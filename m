Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32222747189
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 14:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbjGDMnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 08:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjGDMnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 08:43:16 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01F9FB;
        Tue,  4 Jul 2023 05:43:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 70A8C228AF;
        Tue,  4 Jul 2023 12:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1688474594; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kyeDVjvHSYtTDluOfRyuRMUOaldUOiI9fDr6cfh4oxA=;
        b=1V2Hu6Zzpq7keu28Xq6HSHZUlf3pJxJTZNcMG1H9l4pgXrGfOEy37dp3yfcnZxx95duHKk
        WuSGXFxF28KbgD3OJsmu5ZS0FgbsGfkZeq+lqNMcdgIpRG5LBrC9imL/pjoWDruLt3abjI
        jGmoxAK04b7LiiSO2CCKtuEso8+o/ro=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1688474594;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kyeDVjvHSYtTDluOfRyuRMUOaldUOiI9fDr6cfh4oxA=;
        b=M48thlqgS+JjQCHXafM3BN0IIDaNEs91CKvO2wLd5f7s0EKdHc1CeU1W7NKMpNKxGX7op2
        gIpgDbxtd28uc1CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 405071346D;
        Tue,  4 Jul 2023 12:43:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UPX1DeITpGQeOwAAMHmgww
        (envelope-from <jdelvare@suse.de>); Tue, 04 Jul 2023 12:43:14 +0000
Date:   Tue, 4 Jul 2023 14:43:12 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] module: print module name on refcount error
Message-ID: <20230704144312.032b4ddd@endymion.delvare>
In-Reply-To: <ZJwLy5anSgFzbTUP@dhcp22.suse.cz>
References: <20230626123252.73dbc139@endymion.delvare>
 <ZJwLy5anSgFzbTUP@dhcp22.suse.cz>
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

Hi Michal,

On Wed, 28 Jun 2023 12:30:35 +0200, Michal Hocko wrote:
> On Mon 26-06-23 12:32:52, Jean Delvare wrote:
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
> 
> Would it make sense to also print the refcnt here? In our internal bug
> report it has turned out that this was an overflow (put missing) rather
> than an underflow (too many put calls). Seeing the value could give a
> clue about that. We had to configure panic_on_warn to capture a dump to
> learn more which is rather impractical.

Well, other calls to module_put() or try_module_get() could happen in
parallel, so at the time we print refcnt, its value could be different
from the one which triggered the WARN.

Additionally, catching an overflow in module_put() is counterintuitive,
it only works by accident because the counter gets to negative values.
If we really want to reliably report overflows as such then we should
add a dedicated WARN to try_module_get(). Doesn't look trivial though.

With my proposed implementation, I don't think it's necessary to turn
on panic_on_warn to debug further. Once you know which module is
culprit, enabling tracing for this specific module should give you all
the details you need to figure out what's going on.

-- 
Jean Delvare
SUSE L3 Support
