Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06EB37390C8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 22:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjFUU1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 16:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjFUU1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 16:27:51 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E43619A6;
        Wed, 21 Jun 2023 13:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=LRODS49SUbgdzUbhy9d8FMcSqVwfsnLQJj1+bJUkvy4=;
        t=1687379266; x=1688588866; b=yBwzH+ZachXiLAIc0/nshaYESDcgQRlMl/LW0/tim5hwvWK
        cHNaxImpA1m+mDxT9Nk6R6F3fvfD33u1hXJ7BC9Vvb3hVfLKwc3ZkogxBrCu8keCzfFmgojgBUKyH
        EPtg6P0RUMDcOrTxwY6NGwxG2mhBAnBhVTVIUZtWw2MtOLA4yTMBnJdcIVpj8UdSLe0TJ7lJw5dJ/
        JeFjBo6UujwX+Dn87Ih2Z+W9MFS6T6uwlaxWOFAkMkIS/5CewN/P4R9lxPPNbVoliCjLNHyv/VHcA
        zGyjN15jTRTCzREpZyJ/3fRf7sS4acRDdtFbe8nX/baf57TXyIb2CDoERWcDrEgw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qC4QT-00DrCh-2m;
        Wed, 21 Jun 2023 22:27:38 +0200
Message-ID: <cfe53cb984dfd42f8b835d5e05b0393ba0352a7c.camel@sipsolutions.net>
Subject: Re: [syzbot] [net?] possible deadlock in netlink_set_err
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Jakub Kicinski <kuba@kernel.org>,
        syzbot <syzbot+a7d200a347f912723e5c@syzkaller.appspotmail.com>
Cc:     bpf@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Date:   Wed, 21 Jun 2023 22:27:36 +0200
In-Reply-To: <20230621124246.07f9833c@kernel.org>
References: <000000000000e38d1605fea5747e@google.com>
         <20230621124246.07f9833c@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-06-21 at 12:42 -0700, Jakub Kicinski wrote:
> Hi Johannes,
>=20
> Doesn't seem like netlink_set_err() wants to be called from just any
> context. Should we convert nl_table_lock to alwasy be _bh ?

So as I was writing this Eric responded too :) It does seem _bh wouldn't
be sufficient then, the lockdep report below also mentions IRQ
disabling.


I'm not entirely sure this is needed, and I'm also not sure we really
need to fix it immediately, it's a very old bug and one that's going to
be very difficult to actually hit a deadlock on in practice. The "CPU1"
part of the report is basically almost never happening.

This is why syzbot couldn't reproduce it, this code will always execute:

        spin_lock_irqsave(&local->queue_stop_reason_lock, flags);
        for (i =3D 0; i < IEEE80211_MAX_QUEUES; i++) {
                skb_queue_walk_safe(&local->pending[i], skb, tmp) {
                        struct ieee80211_tx_info *info =3D IEEE80211_SKB_CB=
(skb);
                        if (info->control.vif =3D=3D &sdata->vif) {
                                __skb_unlink(skb, &local->pending[i]);
                                ieee80211_free_txskb(&local->hw, skb);
                        }
                }
        }
        spin_unlock_irqrestore(&local->queue_stop_reason_lock, flags);


However, pretty much *all* of the time there will be no SKBs on this
pending list that have a report to send out to userspace in
ieee80211_free_txskb -> ieee80211_report_used_skb:

...
        } else if (info->ack_frame_id) {
                ieee80211_report_ack_skb(local, skb, acked, dropped,
                                         ack_hwtstamp);


and really, ack_frame_id is rarely set, and in addition it's pretty
unlikely that a frame would still be on the queue when the interface is
set down. That's also not a very common operation (it's not like you try
to do that many times per second), so ...


Another approach might be to just disentangle that loop I pasted above
out from the queue_stop_reason_lock, we can move the SKBs to a separate
list before freeing them.


That said, it does stand to reason that if nlmsg_multicast() or
netlink_broadcast() can be called with a gfp_t argument then it should
be possible to call it with IRQs disabled or under a lock such as this
example, so perhaps Eric's patch really is the right thing to do here,
to avoid this potential pitfall in the future.

johannes
