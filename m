Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69B99642C20
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 16:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbiLEPm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 10:42:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232082AbiLEPm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 10:42:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129AC324;
        Mon,  5 Dec 2022 07:42:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9990FB8111A;
        Mon,  5 Dec 2022 15:42:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A0D5C433C1;
        Mon,  5 Dec 2022 15:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1670254942;
        bh=thdvIuqkHEyKbS/JWTCnvmyNhW8nCqY9ZAj9HmhLcRU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bmCKOBUn7w+x0qf7dg84Jm7pOjsEYvUi7Af1oAkuQ4tGYQ8hoV8BSvVv0uq45iayZ
         OVrRz8G2vrhalIgV6JCmHKipu+yrujU8nrnjO85fFY/ANIbClr5xKaHTvObqSuaCye
         oWdcgSocbqP/sx7j908NY3aUkIPaLGNTYhp5XDO8=
Date:   Mon, 5 Dec 2022 16:42:19 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Allen Webb <allenwebb@google.com>
Cc:     "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v6 1/5] module: Add empty modalias sysfs attribute
Message-ID: <Y44RW8Fd/WnW/4Ub@kroah.com>
References: <20221202224540.1446952-1-allenwebb@google.com>
 <20221202224744.1447448-1-allenwebb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221202224744.1447448-1-allenwebb@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2022 at 04:47:40PM -0600, Allen Webb wrote:
> This adds the modalias sysfs attribute in preparation for its
> implementation.

What implementation?

This changelog doesn't make too much sense on it's own, and that's not
good.  Please explain what this attribute is for and what it is going to
do, AND include the documentation for the attribute please.


> 
> Signed-off-by: Allen Webb <allenwebb@google.com>
> ---
>  include/linux/module.h   |  1 +
>  kernel/module/internal.h |  2 ++
>  kernel/module/sysfs.c    | 33 +++++++++++++++++++++++++++++++++
>  kernel/params.c          |  7 +++++++
>  4 files changed, 43 insertions(+)
> 
> diff --git a/include/linux/module.h b/include/linux/module.h
> index ec61fb53979a9..0bfa859a21566 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -47,6 +47,7 @@ struct module_kobject {
>  	struct kobject *drivers_dir;
>  	struct module_param_attrs *mp;
>  	struct completion *kobj_completion;
> +	struct bin_attribute modalias_attr;
>  } __randomize_layout;
>  
>  struct module_attribute {
> diff --git a/kernel/module/internal.h b/kernel/module/internal.h
> index 2e2bf236f5582..8d7ae37584868 100644
> --- a/kernel/module/internal.h
> +++ b/kernel/module/internal.h
> @@ -259,11 +259,13 @@ static inline void add_kallsyms(struct module *mod, const struct load_info *info
>  #endif /* CONFIG_KALLSYMS */
>  
>  #ifdef CONFIG_SYSFS
> +void add_modalias_attr(struct module_kobject *mk);

This can not fail?

> +static ssize_t module_modalias_read(struct file *filp, struct kobject *kobj,
> +				    struct bin_attribute *bin_attr,
> +				    char *buf, loff_t pos, size_t count)
> +{
> +	return 0;
> +}
> +
> +/* Used in kernel/params.c for builtin modules.
> + *
> + * `struct module_kobject` is used instead of `struct module` because for
> + * builtin modules, the `struct module` is not available when this is called.
> + */
> +void add_modalias_attr(struct module_kobject *mk)
> +{
> +	sysfs_bin_attr_init(&mk->modalias_attr);
> +	mk->modalias_attr.attr.name = "modalias";
> +	mk->modalias_attr.attr.mode = 0444;
> +	mk->modalias_attr.read = module_modalias_read;
> +	if (sysfs_create_bin_file(&mk->kobj, &mk->modalias_attr)) {
> +		/* We shouldn't ignore the return type, but there is nothing to
> +		 * do.
> +		 */

Odd commenting style.

And yes, if this fails, that is NOT good, please fix that up.

But why is this a static attribute like this as part of the
module_kobject structure and not just a "normal" attribute that is
shared by all kobjects?


> +		return;
> +	}
> +}
> +
> +static void remove_modalias_attr(struct module_kobject *mk)
> +{
> +	sysfs_remove_bin_file(&mk->kobj, &mk->modalias_attr);

Why?  Isn't this automatically cleaned up by the kobject core?


> +}
> +
>  static void del_usage_links(struct module *mod)
>  {
>  #ifdef CONFIG_MODULE_UNLOAD
> @@ -398,6 +429,7 @@ int mod_sysfs_setup(struct module *mod,
>  
>  	add_sect_attrs(mod, info);
>  	add_notes_attrs(mod, info);
> +	add_modalias_attr(&mod->mkobj);

Again, error checking :(

>  
>  	return 0;
>  
> @@ -415,6 +447,7 @@ int mod_sysfs_setup(struct module *mod,
>  
>  static void mod_sysfs_fini(struct module *mod)
>  {
> +	remove_modalias_attr(&mod->mkobj);
>  	remove_notes_attrs(mod);
>  	remove_sect_attrs(mod);
>  	mod_kobject_put(mod);
> diff --git a/kernel/params.c b/kernel/params.c
> index 5b92310425c50..b7fd5313a3118 100644
> --- a/kernel/params.c
> +++ b/kernel/params.c
> @@ -14,6 +14,12 @@
>  #include <linux/ctype.h>
>  #include <linux/security.h>
>  
> +#ifdef CONFIG_MODULES
> +#include "module/internal.h"
> +#else
> +static inline void add_modalias_attr(struct module_kobject *mk) {}
> +#endif /* !CONFIG_MODULES */

#ifdef does not belong in .c files, and mucking around in kernel/params
to go into module/internal.h feels like a layering problem.

> +
>  #ifdef CONFIG_SYSFS
>  /* Protects all built-in parameters, modules use their own param_lock */
>  static DEFINE_MUTEX(param_lock);
> @@ -815,6 +821,7 @@ static void __init kernel_add_sysfs_param(const char *name,
>  	BUG_ON(err);
>  	kobject_uevent(&mk->kobj, KOBJ_ADD);
>  	kobject_put(&mk->kobj);
> +	add_modalias_attr(mk);

You drop the reference on a kobject and then add a sysfs file to it?

Why is this being called here at all?

thanks,

greg k-h
