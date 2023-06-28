Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69C9740ED8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 12:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbjF1Kcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 06:32:46 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:52492 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbjF1Kai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 06:30:38 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A66FC2185C;
        Wed, 28 Jun 2023 10:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1687948236; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BCksnSvqb2exthjt44ZVB4l+uDUSHQhOWcwxYNPNILY=;
        b=pTbjx/jyqTYF1XnZiTMK5kPMPvzBbEre9iW+GEsBQVUUqHIonNXz8J4gb9LrMTwNqVYE5o
        RRABQZnUmPwsAQ8ui0ra57SCtFDCGi7m4EjyG5eOsqPkVFNtVyzV7IqTDScc5HllsS1P9d
        VLMgePQSmjqZ5JnwNVCbxP/tU6Tmzcc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 877EB138EF;
        Wed, 28 Jun 2023 10:30:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9FbPHswLnGTwGwAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 28 Jun 2023 10:30:36 +0000
Date:   Wed, 28 Jun 2023 12:30:35 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Jean Delvare <jdelvare@suse.de>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] module: print module name on refcount error
Message-ID: <ZJwLy5anSgFzbTUP@dhcp22.suse.cz>
References: <20230626123252.73dbc139@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230626123252.73dbc139@endymion.delvare>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 26-06-23 12:32:52, Jean Delvare wrote:
> If module_put() triggers a refcount error, include the culprit
> module name in the warning message, to easy further investigation of
> the issue.
> 
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Suggested-by: Michal Hocko <mhocko@suse.com>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  kernel/module/main.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> --- linux-6.3.orig/kernel/module/main.c
> +++ linux-6.3/kernel/module/main.c
> @@ -850,7 +850,9 @@ void module_put(struct module *module)
>  	if (module) {
>  		preempt_disable();
>  		ret = atomic_dec_if_positive(&module->refcnt);
> -		WARN_ON(ret < 0);	/* Failed to put refcount */
> +		WARN(ret < 0,
> +		     KERN_WARNING "Failed to put refcount for module %s\n",
> +		     module->name);

Would it make sense to also print the refcnt here? In our internal bug
report it has turned out that this was an overflow (put missing) rather
than an underflow (too many put calls). Seeing the value could give a
clue about that. We had to configure panic_on_warn to capture a dump to
learn more which is rather impractical.

Other than that the module information on its own is an improvement
because one knows where to start looking or to reduce the tracing data
collected.

In any case
Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

>  		trace_module_put(module, _RET_IP_);
>  		preempt_enable();
>  	}
> 
> 
> -- 
> Jean Delvare
> SUSE L3 Support

-- 
Michal Hocko
SUSE Labs
