Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C379740C0A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 10:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234292AbjF1I5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 04:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234405AbjF1InQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 04:43:16 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E162B30C2;
        Wed, 28 Jun 2023 01:35:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D4FBA21864;
        Wed, 28 Jun 2023 06:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1687932593; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pb1MWnUMmUFEexxqK5EEY1JTSgmlRyHzP6MrqQFpEXU=;
        b=YaYej1+R30o+dQs1G1sudkf9gCXZ0aUOD8y7MDYkVUrM2fmAol6PYiPYlr8/urWhqNoxuv
        pOz5DwJ0yjft0n+5PVkUBxNfVdphIqR89aw6bvhctKCYmYBx1HWz5ZSFE4h9FWIt2/1yzn
        6TnSC/0XOK77BpGtD0iCczdutNkgAcI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1687932593;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pb1MWnUMmUFEexxqK5EEY1JTSgmlRyHzP6MrqQFpEXU=;
        b=PUzBZ2/mZv5KJOFaiPsbNDAfkGGcOcY5hMmJO3e1mdDxJDKhWegvRSFRNcN6r6/SYK6dvQ
        3EUUToqhETgvzJAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BF98B138E8;
        Wed, 28 Jun 2023 06:09:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id c9RlLrHOm2QcEgAAMHmgww
        (envelope-from <dwagner@suse.de>); Wed, 28 Jun 2023 06:09:53 +0000
Date:   Wed, 28 Jun 2023 08:09:53 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        James Smart <jsmart2021@gmail.com>,
        Martin Belanger <Martin.Belanger@dell.com>
Subject: Re: [PATCH blktests v1 2/3] nvme/rc: Avoid triggering host nvme-cli
 autoconnect
Message-ID: <ygfgqglmntpqiopzq44aqegehnlroarteqjtmih7mulan4oukv@jmtupz2jnafv>
References: <20230620132703.20648-1-dwagner@suse.de>
 <20230620132703.20648-3-dwagner@suse.de>
 <oyhlgbqq6pjwln5ly47rt5iyjtai4jeepkascfaskn2z7nu3ks@te7yrwbcpsmi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <oyhlgbqq6pjwln5ly47rt5iyjtai4jeepkascfaskn2z7nu3ks@te7yrwbcpsmi>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 10:22:53AM +0000, Shinichiro Kawasaki wrote:
> On Jun 20, 2023 / 15:27, Daniel Wagner wrote:
> > When the host has enabled the udev/systemd autoconnect services for the
> > fc transport it interacts with blktests and make tests break.
> > 
> > nvme-cli learned to ignore connects attemps when using the
> > --context command line option paired with a volatile configuration. Thus
> > we can mark all the resources created by blktests and avoid any
> > interaction with the systemd autoconnect scripts.
> 
> This sounds a good idea. Question, is "--context" option of the nvme command
> mandatory to run nvme test with nvme_trtype=fc?

If nvme-cli is called without the '--context' option, the command will be
executed. Though if '--context' is provided as option and there is a
configuration which matches the connect parameters but doesn't match the context
it will ignore the operation.

The blktests tests expects that nothing behind it's back is fiddling on the
setup while it is running. So far udev didn't trigger for rdma/tcp but with fc
it will.

Thus, it's mandatory to use either the '--context' parameter or alternatively
disable the rule with

  ln -s /etc/udev/rules.d/70-nvmf-autoconnect.rules /dev/null

BTW, when the udev rule is active I observed crashes when running blktests. So
there is more to fix, though one thing at the time.

> Or is it nice-to-have feature
> depending on the test system OS? If it is mandatory, it's the better to check
> in _nvme_requires.

Well, I didn't want to make this a hard requirement for all tests. I guess we
could make it for fc only if this is what you had in mind. The question should
it only test for nvme-cli supporting --context or should it be really clever and
test if the udev rule is also active (no idea how but I assume it is possible)?

> >  _cleanup_nvmet() {
> > @@ -337,6 +383,8 @@ _setup_nvmet() {
> >  		def_host_traddr=$(printf "nn-%s:pn-%s" \
> >  					 "${def_local_wwnn}" \
> >  					 "${def_local_wwpn}")
> > +
> > +		_setup_nvme_cli
> 
> Can we move this _setup_nvme_cli call from _setup_nvmet to _setup_fcloop?
> _cleanup_nvme_cli is called in _cleanup_fcloop. I think it is a bit cleaner
> since those setup/cleanup functions are called at at same level.

Sure, no problem.
