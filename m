Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED67565FA9A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 05:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbjAFEPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 23:15:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjAFEPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 23:15:45 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F66D6AD9F
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 20:15:43 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Np94F0pMmz4xyY;
        Fri,  6 Jan 2023 15:15:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1672978541;
        bh=B6gZjIQTJnL5aU+bxgCKiSJjqk4zws5L2t2pylMPyXw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=D5ZcTtUdUJX7WYoYNrMKSdHdoXFRnG0GwNEwi4gEniVt1rU6TT+N41T2wQ+NGB3ey
         aTNp37iq3KCCbMBsGO+fxYrd8MYaIZvC6yLKzvfpNm7jR8FqBpLKy6hOG/Jsr44fVv
         5U2czSqBnoTutofkZ0YF40cJ6lHVNd/PXeDLeurKMlKsZzhWWL4b71qbPyHMT83Ps6
         bZQjbfRW28go3avQucQPCpxuoTX+fhqpWeGJ0ecVWGkLO0FII6B02zv+Qogrt7ryLk
         ME2Xk5nbGX3Z82FJfs31mhR3/Z1b53TYB7CNMlLePIM6cbTO+n03GuHCFR5hsG4HZn
         wQEELvw9r0UZA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Russell Currey <ruscur@russell.cc>, linuxppc-dev@lists.ozlabs.org
Cc:     gregkh@linuxfoundation.org, gcwilson@linux.ibm.com,
        linux-kernel@vger.kernel.org, nayna@linux.ibm.com,
        ajd@linux.ibm.com, zohar@linux.ibm.com,
        Russell Currey <ruscur@russell.cc>
Subject: Re: [PATCH v2 6/7] powerpc/secvar: Extend sysfs to include config vars
In-Reply-To: <20221230042014.154483-7-ruscur@russell.cc>
References: <20221230042014.154483-1-ruscur@russell.cc>
 <20221230042014.154483-7-ruscur@russell.cc>
Date:   Fri, 06 Jan 2023 15:15:37 +1100
Message-ID: <87358oi9hy.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Russell Currey <ruscur@russell.cc> writes:
> The forthcoming pseries consumer of the secvar API wants to expose a
> number of config variables.  Allowing secvar implementations to provide
> their own sysfs attributes makes it easy for consumers to expose what
> they need to.
>
> This is not being used by the OPAL secvar implementation at present, and
> the config directory will not be created if no attributes are set.

Would it be slightly cleaner if the attributes were just a member of
secvar_operations?

That would avoid the need for some of the separate handling of the ops
and the attributes.

I know "ops" implies it's only methods, but I think that's not a big
problem. The power_pmu struct does something similar, where it combines
ops and attributes.

cheers

> diff --git a/arch/powerpc/include/asm/secvar.h b/arch/powerpc/include/asm/secvar.h
> index 92d2c051918b..250e7066b6da 100644
> --- a/arch/powerpc/include/asm/secvar.h
> +++ b/arch/powerpc/include/asm/secvar.h
> @@ -10,6 +10,7 @@
>  
>  #include <linux/types.h>
>  #include <linux/errno.h>
> +#include <linux/sysfs.h>
>  
>  extern const struct secvar_operations *secvar_ops;
>  
> @@ -27,10 +28,12 @@ struct secvar_operations {
>  #ifdef CONFIG_PPC_SECURE_BOOT
>  
>  extern void set_secvar_ops(const struct secvar_operations *ops);
> +extern void set_secvar_config_attrs(const struct attribute **attrs);
>  
>  #else
>  
>  static inline void set_secvar_ops(const struct secvar_operations *ops) { }
> +static inline void set_secvar_config_attrs(const struct attribute **attrs) { }
>  
>  #endif
>  
> diff --git a/arch/powerpc/kernel/secvar-sysfs.c b/arch/powerpc/kernel/secvar-sysfs.c
> index aa1daec480e1..ad1e1d72d2ae 100644
> --- a/arch/powerpc/kernel/secvar-sysfs.c
> +++ b/arch/powerpc/kernel/secvar-sysfs.c
> @@ -15,9 +15,17 @@
>  
>  #define NAME_MAX_SIZE	   1024
>  
> +const struct attribute **secvar_config_attrs __ro_after_init = NULL;
> +
>  static struct kobject *secvar_kobj;
>  static struct kset *secvar_kset;
>  
> +void set_secvar_config_attrs(const struct attribute **attrs)
> +{
> +	WARN_ON_ONCE(secvar_config_attrs);
> +	secvar_config_attrs = attrs;
> +}
> +
>  static ssize_t format_show(struct kobject *kobj, struct kobj_attribute *attr,
>  			   char *buf)
>  {
> @@ -134,6 +142,16 @@ static int update_kobj_size(void)
>  	return 0;
>  }
>  
> +static int secvar_sysfs_config(struct kobject *kobj)
> +{
> +	struct attribute_group config_group = {
> +		.name = "config",
> +		.attrs = (struct attribute **)secvar_config_attrs,
> +	};
> +
> +	return sysfs_create_group(kobj, &config_group);
> +}
> +
>  static int secvar_sysfs_load(void)
>  {
>  	char *name;
> @@ -196,26 +214,38 @@ static int secvar_sysfs_init(void)
>  
>  	rc = sysfs_create_file(secvar_kobj, &format_attr.attr);
>  	if (rc) {
> -		kobject_put(secvar_kobj);
> -		return -ENOMEM;
> +		pr_err("secvar: Failed to create format object\n");
> +		rc = -ENOMEM;
> +		goto err;
>  	}
>  
>  	secvar_kset = kset_create_and_add("vars", NULL, secvar_kobj);
>  	if (!secvar_kset) {
>  		pr_err("secvar: sysfs kobject registration failed.\n");
> -		kobject_put(secvar_kobj);
> -		return -ENOMEM;
> +		rc = -ENOMEM;
> +		goto err;
>  	}
>  
>  	rc = update_kobj_size();
>  	if (rc) {
>  		pr_err("Cannot read the size of the attribute\n");
> -		return rc;
> +		goto err;
> +	}
> +
> +	if (secvar_config_attrs) {
> +		rc = secvar_sysfs_config(secvar_kobj);
> +		if (rc) {
> +			pr_err("secvar: Failed to create config directory\n");
> +			goto err;
> +		}
>  	}
>  
>  	secvar_sysfs_load();
>  
>  	return 0;
> +err:
> +	kobject_put(secvar_kobj);
> +	return rc;
>  }
>  
>  late_initcall(secvar_sysfs_init);
> -- 
> 2.38.1
