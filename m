Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCFA574CFE9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 10:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232933AbjGJI1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 04:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232530AbjGJI1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 04:27:23 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D07124;
        Mon, 10 Jul 2023 01:27:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 24C5021E8D;
        Mon, 10 Jul 2023 08:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1688977638; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UIZvDVy9k/7OMTz4A4x2ug9kFE4VMtfrWhDBOUfK4Mg=;
        b=D1duItWpVprF4m7rIL37r/2RswiHoIOPBjUPTljv7afso5npmgIyJIhZSxI3AZ0eTshORs
        /tebehspJiJRXL2HV5l6iJoOUmp82xp00hPCVB+waC4mSljUy1O9bQKZ04cpEMzHTO8+fc
        xsv7x5IJro01X+CKAIujb3+/2TyKE9c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1688977638;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UIZvDVy9k/7OMTz4A4x2ug9kFE4VMtfrWhDBOUfK4Mg=;
        b=h9IHnAzUbdOUzsHPmGdRZwgsRo3pBNef5WKps6f8Bm7OFmvWtfW2VYZo9J99N4Td0t7/p5
        qCgCRAyov7EpJrBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1402E1361C;
        Mon, 10 Jul 2023 08:27:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Wm0iBObAq2ShDQAAMHmgww
        (envelope-from <dwagner@suse.de>); Mon, 10 Jul 2023 08:27:18 +0000
Date:   Mon, 10 Jul 2023 10:27:17 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Max Gurtovoy <mgurtovoy@nvidia.com>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        James Smart <jsmart2021@gmail.com>,
        Martin Belanger <Martin.Belanger@dell.com>
Subject: Re: [PATCH blktests v1 2/3] nvme/rc: Avoid triggering host nvme-cli
 autoconnect
Message-ID: <bz2s6nyjwl6l7yfrd4wtjdtousv23ypcdleckibps5lyjpwi4x@wqq6qqesevpk>
References: <20230620132703.20648-1-dwagner@suse.de>
 <20230620132703.20648-3-dwagner@suse.de>
 <9c07e4f6-2cf5-b53b-6b48-bd4df8798ee9@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c07e4f6-2cf5-b53b-6b48-bd4df8798ee9@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 06, 2023 at 07:11:58PM +0300, Max Gurtovoy wrote:
> 
> 
> On 20/06/2023 16:27, Daniel Wagner wrote:
> > When the host has enabled the udev/systemd autoconnect services for the
> > fc transport it interacts with blktests and make tests break.
> > 
> > nvme-cli learned to ignore connects attemps when using the
> > --context command line option paired with a volatile configuration. Thus
> > we can mark all the resources created by blktests and avoid any
> > interaction with the systemd autoconnect scripts.
> 
> why would we like to ignore connect attempts during blktests ?

The problem I observed is that there were two connect attempts (one triggered
via udev and one via the test itself) which disturbed the test. The interference
resulted into a complete hang of the test case:

https://lore.kernel.org/linux-nvme/6g53yj5afhhonwf2psf7ft2gkakkwewy7klkix3y3u6uclpa5w@tt2yfzigyxgg/

> We define unique nqn/ids/etc. So we never should disturb other running
> services, unless it uses the same parameters, which shouldn't happen.

Yes, that should do the decoupling between udev and blktests.

> Agree on setting the hard coded values for hostnqn and hostid instead of
> reading the /etc/nvme/* files. This should do the work IMO, isn't it ?

Do you mean that nvme-cli will ignore the udev trigger when a different hostnqn
is invovled? At least for the well-known discover controller the hostqnq
doesn't work. Though not sure if I understood you correctly here.
