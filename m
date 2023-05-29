Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23ABC714970
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 14:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbjE2MYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 08:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbjE2MYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 08:24:02 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75393C2;
        Mon, 29 May 2023 05:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685363027; x=1716899027;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=zsfRnRMXIV5r/X5furPt6ghu8XOqWi203n2Q9dk2B28=;
  b=GUY4uDRsumjymEK1BNnByh9fG6eFMx9vHkN698/wu4vJmeiGSNuax5r1
   55XanUm7NAXdLkx4K9tT1cGNkIuitTKVJzK+LmVpa8FdoSVO8tOJodSE8
   QuH+iqtS2zKIZge4+CeexTL7VA00Tq3nG/QVv/v5ZLT6EsvIz+gzbYurC
   p/JYfuNKEaA1KWw/BURLUfgl1N2bojRM1yiawcE+xk2ITq0N3e7umjx8U
   SctYrMusy5ptMbqooPl5Irfb0swveOuIIl+T7lKa7XBdeVuHf6DAy/TQt
   fuNN7amAtOFZDWEGQACaLmo4hu8zqLlL74UA/v6pMLQq6eob06iyhrPyr
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="441049767"
X-IronPort-AV: E=Sophos;i="6.00,201,1681196400"; 
   d="scan'208";a="441049767"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2023 05:23:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="818417659"
X-IronPort-AV: E=Sophos;i="6.00,201,1681196400"; 
   d="scan'208";a="818417659"
Received: from btaubert-mobl1.ger.corp.intel.com ([10.252.55.237])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2023 05:23:45 -0700
Date:   Mon, 29 May 2023 15:23:42 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Mark Pearson <mpearson-lenovo@squebb.ca>
cc:     hdegoede@redhat.com, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 5/5] platform/x86: think-lmi: mutex protection around
 multiple WMI calls
In-Reply-To: <20230526171658.3886-5-mpearson-lenovo@squebb.ca>
Message-ID: <27c7824e-ec90-c68f-3e76-92525ed7e393@linux.intel.com>
References: <mpearson-lenovo@squebb.ca> <20230526171658.3886-1-mpearson-lenovo@squebb.ca> <20230526171658.3886-5-mpearson-lenovo@squebb.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 May 2023, Mark Pearson wrote:

> Add mutex protection around cases where an operation needs multiple
> WMI calls - e.g. setting password.

So you need this feature already for Patch 1/5? If that's the case, you 
should reorder the patches and put it before 1/5.

That "e.g. setting password" sounds vague enough that I'm left to wonder 
if there are other cases in the driver which need locking too. It would be 
useful to be precise with wording here. It will help immensely when 
somebody looks this changelog 5 years from now if you explain all cases 
that need locking up front.

So, is this needed also for some existing code, then Fixes tag might be in 
order? (I'm looking e.g. that cert auth block in current_value_store() 
which also does more than one call).

-- 
 i.

> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> ---
> Changes in v2: New commit added after review of other patches in series.
> Changes in v3: Simplified mutex handling as recommended.
> 
>  drivers/platform/x86/think-lmi.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
> index 64cd453d6e7d..86185358dba2 100644
> --- a/drivers/platform/x86/think-lmi.c
> +++ b/drivers/platform/x86/think-lmi.c
> @@ -14,6 +14,7 @@
>  #include <linux/acpi.h>
>  #include <linux/errno.h>
>  #include <linux/fs.h>
> +#include <linux/mutex.h>
>  #include <linux/string.h>
>  #include <linux/types.h>
>  #include <linux/dmi.h>
> @@ -195,6 +196,7 @@ static const char * const level_options[] = {
>  };
>  static struct think_lmi tlmi_priv;
>  static struct class *fw_attr_class;
> +static DEFINE_MUTEX(tlmi_mutex);
>  
>  /* ------ Utility functions ------------*/
>  /* Strip out CR if one is present */
> @@ -437,6 +439,9 @@ static ssize_t new_password_store(struct kobject *kobj,
>  	/* Strip out CR if one is present, setting password won't work if it is present */
>  	strip_cr(new_pwd);
>  
> +	/* Use lock in case multiple WMI operations needed */
> +	mutex_lock(&tlmi_mutex);
> +
>  	pwdlen = strlen(new_pwd);
>  	/* pwdlen == 0 is allowed to clear the password */
>  	if (pwdlen && ((pwdlen < setting->minlen) || (pwdlen > setting->maxlen))) {
> @@ -493,6 +498,7 @@ static ssize_t new_password_store(struct kobject *kobj,
>  		kfree(auth_str);
>  	}
>  out:
> +	mutex_unlock(&tlmi_mutex);
>  	kfree(new_pwd);
>  	return ret ?: count;
>  }
> @@ -987,6 +993,9 @@ static ssize_t current_value_store(struct kobject *kobj,
>  	/* Strip out CR if one is present */
>  	strip_cr(new_setting);
>  
> +	/* Use lock in case multiple WMI operations needed */
> +	mutex_lock(&tlmi_mutex);
> +
>  	/* Check if certificate authentication is enabled and active */
>  	if (tlmi_priv.certificate_support && tlmi_priv.pwd_admin->cert_installed) {
>  		if (!tlmi_priv.pwd_admin->signature || !tlmi_priv.pwd_admin->save_signature) {
> @@ -1031,7 +1040,6 @@ static ssize_t current_value_store(struct kobject *kobj,
>  			if (ret)
>  				goto out;
>  		}
> -
>  		ret = tlmi_save_bios_settings("");
>  	} else { /* old non opcode based authentication method (deprecated)*/
>  		if (tlmi_priv.pwd_admin->valid && tlmi_priv.pwd_admin->password[0]) {
> @@ -1071,6 +1079,7 @@ static ssize_t current_value_store(struct kobject *kobj,
>  		kobject_uevent(&tlmi_priv.class_dev->kobj, KOBJ_CHANGE);
>  	}
>  out:
> +	mutex_unlock(&tlmi_mutex);
>  	kfree(auth_str);
>  	kfree(set_str);
>  	kfree(new_setting);
> 
