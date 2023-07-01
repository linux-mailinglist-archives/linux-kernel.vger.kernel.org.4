Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90035744A64
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 17:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbjGAP5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 11:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjGAP5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 11:57:32 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925512686;
        Sat,  1 Jul 2023 08:57:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9AC7C1F895;
        Sat,  1 Jul 2023 15:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1688227049; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sM/EFLWYvQ93nKE8s+D8ae06QzqP3Jmc92aenxfsX28=;
        b=uzA05cbv5fyb6u8LK87SwUNbz6MQ9eLevhA48Xl2lJ2ga9fqgg9noa6/QKw8Wvg+xiTQjj
        YyMq8WedsviiP2uiAuLwoj4PwrlbHMA3GCgTUNi5u8IS3Wxy9XNWpk2CW9OPbsGKTggCDG
        Bism0cLSFM0/Lz38T3Q9qOlCiNQszeM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1688227049;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sM/EFLWYvQ93nKE8s+D8ae06QzqP3Jmc92aenxfsX28=;
        b=wGo55/vG29gNObHlGVsFdvcvo1PwTUFj52LmPn0sJoqzHOmpP0NgL0lHjV2XZu7RHGwoht
        nYagrIvvEACAhBBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7193A13638;
        Sat,  1 Jul 2023 15:57:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HZwDGulMoGTMIwAAMHmgww
        (envelope-from <jdelvare@suse.de>); Sat, 01 Jul 2023 15:57:29 +0000
Date:   Sat, 1 Jul 2023 17:57:27 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Michal Hocko <mhocko@suse.com>, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] module: print module name on refcount error
Message-ID: <20230701175727.292b84f6@endymion.delvare>
In-Reply-To: <ZJ9fvQZ4k+zFfXbN@bombadil.infradead.org>
References: <20230626123252.73dbc139@endymion.delvare>
        <ZJ9fvQZ4k+zFfXbN@bombadil.infradead.org>
Organization: SUSE Linux
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.34; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luis,

On Fri, 30 Jun 2023 16:05:33 -0700, Luis Chamberlain wrote:
> On Mon, Jun 26, 2023 at 12:32:52PM +0200, Jean Delvare wrote:
> > If module_put() triggers a refcount error, include the culprit
> > module name in the warning message, to easy further investigation of
> > the issue.
> > 
> > Signed-off-by: Jean Delvare <jdelvare@suse.de>
> > Suggested-by: Michal Hocko <mhocko@suse.com>
> > Cc: Luis Chamberlain <mcgrof@kernel.org>
> > ---
> >  kernel/module/main.c |    4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > --- linux-6.3.orig/kernel/module/main.c
> > +++ linux-6.3/kernel/module/main.c
> > @@ -850,7 +850,9 @@ void module_put(struct module *module)
> >  	if (module) {
> >  		preempt_disable();
> >  		ret = atomic_dec_if_positive(&module->refcnt);
> > -		WARN_ON(ret < 0);	/* Failed to put refcount */
> > +		WARN(ret < 0,
> > +		     KERN_WARNING "Failed to put refcount for module %s\n",
> > +		     module->name);
> >  		trace_module_put(module, _RET_IP_);
> >  		preempt_enable();
> >  	}
> >   
> 
> The mod struct ends up actually being allocated, we first read the ELF
> passed by userspace and we end up allocating space for struct module
> when reading the ELF section ".gnu.linkonce.this_module". We cache
> the ELF section index in info->index.mod, we finally copy the module
> into the allocated space with move_module().
> 
> In linux-next code this is much more clear now. 
> 
> What prevents us from racing to free the module and thus invalidating
> the name?
> 
> For instance the system call to delete_module() could hammer and
> so have tons of threads racing try_stop_module(), eventually one of
> them could win and free_module() would kick in gear.
> 
> What prevents code from racing the free with a random module_put()
> called by some other piece of code?
> 
> I realize this may implicate even the existing code seems racy.

You are the maintainer so I'll trust your expertise, but this is how I
understand it: if we hit this WARN, this means reference counting is
screwed. If this is an underflow, we still have a reference to the
module while refcnt is zero, meaning the module could be removed at any
time. This is inherent to the issue we are reporting, and not related
to the proposed change. The name is just one field of struct module,
refcnt is in the very same situation already.

So the whole piece of code is best effort reporting and assumes (both
before and after my proposed change) that nobody attempted to unload
the module yet.

-- 
Jean Delvare
SUSE L3 Support
