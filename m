Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C190747238
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 15:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbjGDNFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 09:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbjGDNFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 09:05:37 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B5210CC;
        Tue,  4 Jul 2023 06:05:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 105C921F15;
        Tue,  4 Jul 2023 13:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1688475934; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=saIpUUzZfxmUTD6ouTf6NtYrzw3N9oRggkJM/w4fNLQ=;
        b=JmKYsMd6RAJDE4ODiA6p87NmwY2HbAjAsH/q4abp4x/b93SWgjSL4IdH4I7s4i2SvtAzr4
        7VnzJMLYECTlDDP+el8OclnQqWlXAq1g5tjKqrFjgkU81vSOqKmuOQDH5qI1HBD4bBQMt5
        +4GnPnmQnQtK+9A1qq6y4aH0GEfzPUQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E5B721346D;
        Tue,  4 Jul 2023 13:05:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Fd8vNR0ZpGSxSAAAMHmgww
        (envelope-from <mhocko@suse.com>); Tue, 04 Jul 2023 13:05:33 +0000
Date:   Tue, 4 Jul 2023 15:05:33 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Jean Delvare <jdelvare@suse.de>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] module: print module name on refcount error
Message-ID: <ZKQZHZt8YV0GosrZ@dhcp22.suse.cz>
References: <20230626123252.73dbc139@endymion.delvare>
 <ZJwLy5anSgFzbTUP@dhcp22.suse.cz>
 <20230704144312.032b4ddd@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704144312.032b4ddd@endymion.delvare>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 04-07-23 14:43:12, Jean Delvare wrote:
> Hi Michal,
> 
> On Wed, 28 Jun 2023 12:30:35 +0200, Michal Hocko wrote:
> > On Mon 26-06-23 12:32:52, Jean Delvare wrote:
> > > If module_put() triggers a refcount error, include the culprit
> > > module name in the warning message, to easy further investigation of
> > > the issue.
> > > 
> > > Signed-off-by: Jean Delvare <jdelvare@suse.de>
> > > Suggested-by: Michal Hocko <mhocko@suse.com>
> > > Cc: Luis Chamberlain <mcgrof@kernel.org>
> > > ---
> > >  kernel/module/main.c |    4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > 
> > > --- linux-6.3.orig/kernel/module/main.c
> > > +++ linux-6.3/kernel/module/main.c
> > > @@ -850,7 +850,9 @@ void module_put(struct module *module)
> > >  	if (module) {
> > >  		preempt_disable();
> > >  		ret = atomic_dec_if_positive(&module->refcnt);
> > > -		WARN_ON(ret < 0);	/* Failed to put refcount */
> > > +		WARN(ret < 0,
> > > +		     KERN_WARNING "Failed to put refcount for module %s\n",
> > > +		     module->name);  
> > 
> > Would it make sense to also print the refcnt here? In our internal bug
> > report it has turned out that this was an overflow (put missing) rather
> > than an underflow (too many put calls). Seeing the value could give a
> > clue about that. We had to configure panic_on_warn to capture a dump to
> > learn more which is rather impractical.
> 
> Well, other calls to module_put() or try_module_get() could happen in
> parallel, so at the time we print refcnt, its value could be different
> from the one which triggered the WARN.

Racess with module_put should be impossible because all of them should
fail, right? Races with put are possible but we do not need an exact
value to tell the difference between over and underflow, no?
-- 
Michal Hocko
SUSE Labs
