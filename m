Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3458746ACD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 09:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbjGDHiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 03:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjGDHh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 03:37:57 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8793EAD
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 00:37:56 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1qGabR-0005k3-4E; Tue, 04 Jul 2023 09:37:37 +0200
Received: from ore by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1qGabP-0002j5-5n; Tue, 04 Jul 2023 09:37:35 +0200
Date:   Tue, 4 Jul 2023 09:37:35 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     syzbot <syzbot+1591462f226d9cbf0564@syzkaller.appspotmail.com>
Cc:     astrajoan@yahoo.com, davem@davemloft.net, edumazet@google.com,
        ivan.orlov0322@gmail.com, kernel@pengutronix.de, kuba@kernel.org,
        linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@rempel-privat.de, mkl@pengutronix.de, netdev@vger.kernel.org,
        pabeni@redhat.com, robin@protonic.nl, skhan@linuxfoundation.org,
        socketcan@hartkopp.net, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] can: j1939: prevent deadlock by changing
 j1939_socks_lock to rwlock
Message-ID: <20230704073735.GC15522@pengutronix.de>
References: <20230704064710.3189-1-astrajoan@yahoo.com>
 <00000000000002937705ffa3a80b@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <00000000000002937705ffa3a80b@google.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2023 at 11:47:26PM -0700, syzbot wrote:
> > The following 3 locks would race against each other, causing the
> > deadlock situation in the Syzbot bug report:
> >
> > - j1939_socks_lock
> > - active_session_list_lock
> > - sk_session_queue_lock
> >
> > A reasonable fix is to change j1939_socks_lock to an rwlock, since in
> > the rare situations where a write lock is required for the linked list
> > that j1939_socks_lock is protecting, the code does not attempt to
> > acquire any more locks. This would break the circular lock dependency,
> > where, for example, the current thread already locks j1939_socks_lock
> > and attempts to acquire sk_session_queue_lock, and at the same time,
> > another thread attempts to acquire j1939_socks_lock while holding
> > sk_session_queue_lock.
> >
> > NOTE: This patch along does not fix the unregister_netdevice bug
> > reported by Syzbot; instead, it solves a deadlock situation to prepare
> > for one or more further patches to actually fix the Syzbot bug, which
> > appears to be a reference counting problem within the j1939 codebase.
> >
> > #syz test:
> 
> This crash does not have a reproducer. I cannot test it.
> 

To stress this code path, the socket should be configured with err queue
enabled. For example like this:

        value = 1;
        setsockopt(priv->sock, SOL_CAN_J1939, SO_J1939_ERRQUEUE, &value,
                         sizeof(value));

        sock_opt = SOF_TIMESTAMPING_SOFTWARE |
                   SOF_TIMESTAMPING_OPT_CMSG |
                   SOF_TIMESTAMPING_TX_ACK |
                   SOF_TIMESTAMPING_TX_SCHED |
                   SOF_TIMESTAMPING_OPT_STATS | SOF_TIMESTAMPING_OPT_TSONLY |
                   SOF_TIMESTAMPING_OPT_ID | SOF_TIMESTAMPING_RX_SOFTWARE;

        setsockopt(priv->sock, SOL_SOCKET, SO_TIMESTAMPING,
                       (char *) &sock_opt, sizeof(sock_opt));


I hope it will help to create the reproducer

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
