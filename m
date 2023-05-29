Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07BFD7148EA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 13:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbjE2Lvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 07:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjE2Lvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 07:51:53 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF42C9;
        Mon, 29 May 2023 04:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685361111; x=1716897111;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=83ZhOT2qisuB6P0cKdHDa0xFaODwdyuLx6l+kkaIoEc=;
  b=ljEwGMSVe1iMBJnBeBIs5QCRufjLl4/dfDhYs7DFv/ebeIZYYhTGgN5i
   WwsxoS0pXriXJe12a3J023088wzx+m2LZ3W7Y16mGDTzwZsFfiQ35nQsk
   htMHIU9q1f4rIqIB593VQdCMiundgyN/zH+eedZKttnKXU/4RCqeV8nn6
   bpY09F6jivlN2fYGto0djJGRV+YEKcbq4Jq/EYMlO8NgGGjSYRQah/FfG
   Uultba5Z51QA1X41VqILJq9/rsJDXxPaCOIMSbdXMHz1TwcO/gsxTp+FJ
   +K3ijWdtjtPZBEWzsx4U3G+shMOo5Sq8wBUWmfobqVimL2DDWYYKerO5a
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10724"; a="354701370"
X-IronPort-AV: E=Sophos;i="6.00,201,1681196400"; 
   d="scan'208";a="354701370"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2023 04:51:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10724"; a="830368044"
X-IronPort-AV: E=Sophos;i="6.00,201,1681196400"; 
   d="scan'208";a="830368044"
Received: from btaubert-mobl1.ger.corp.intel.com ([10.252.55.237])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2023 04:51:48 -0700
Date:   Mon, 29 May 2023 14:51:46 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Mark Pearson <mpearson-lenovo@squebb.ca>
cc:     hdegoede@redhat.com, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/5] platform/x86: think-lmi: Enable opcode support
 on BIOS settings
In-Reply-To: <20230526171658.3886-1-mpearson-lenovo@squebb.ca>
Message-ID: <0e11913-ba27-e3a-fafe-bd5e48db8b6b@linux.intel.com>
References: <mpearson-lenovo@squebb.ca> <20230526171658.3886-1-mpearson-lenovo@squebb.ca>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1924053861-1685361110=:2737"
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1924053861-1685361110=:2737
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Fri, 26 May 2023, Mark Pearson wrote:

> Whilst reviewing some documentation from the FW team on using WMI on
> Lenovo system I noticed that we weren't using Opcode support when
> changing BIOS settings in the thinkLMI driver.
> 
> We should be doing this to ensure we're future proof as the old
> non-opcode mechanism has been deprecated.
> 
> Tested on X1 Carbon G10 and G11.
> 
> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> ---
> Changes in v2: Update comment for clearer explanation of what the driver
> is doing
> Changes in v3: None. Version bump with rest of series
> 
>  drivers/platform/x86/think-lmi.c | 28 +++++++++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
> index 1138f770149d..2745224f62ab 100644
> --- a/drivers/platform/x86/think-lmi.c
> +++ b/drivers/platform/x86/think-lmi.c
> @@ -1001,7 +1001,33 @@ static ssize_t current_value_store(struct kobject *kobj,
>  				tlmi_priv.pwd_admin->save_signature);
>  		if (ret)
>  			goto out;
> -	} else { /* Non certiifcate based authentication */
> +	} else if (tlmi_priv.opcode_support) {
> +		/*
> +		 * If opcode support is present use that interface.
> +		 * Note - this sets the variable and then the password as separate
> +		 * WMI calls. Function tlmi_save_bios_settings will error if the
> +		 * password is incorrect.
> +		 */
> +		set_str = kasprintf(GFP_KERNEL, "%s,%s;", setting->display_name,
> +					new_setting);

Alignment.

> +		if (!set_str) {
> +			ret = -ENOMEM;
> +			goto out;
> +		}
> +
> +		ret = tlmi_simple_call(LENOVO_SET_BIOS_SETTINGS_GUID, set_str);
> +		if (ret)
> +			goto out;
> +
> +		if (tlmi_priv.pwd_admin->valid && tlmi_priv.pwd_admin->password[0]) {
> +			ret = tlmi_opcode_setting("WmiOpcodePasswordAdmin",
> +					tlmi_priv.pwd_admin->password);

Align.

> +			if (ret)
> +				goto out;
> +		}
> +
> +		ret = tlmi_save_bios_settings("");
> +	} else { /* old non opcode based authentication method (deprecated)*/

non missing hyphen.

Missing space at the comment closing.

>  		if (tlmi_priv.pwd_admin->valid && tlmi_priv.pwd_admin->password[0]) {
>  			auth_str = kasprintf(GFP_KERNEL, "%s,%s,%s;",
>  					tlmi_priv.pwd_admin->password,
> 

Except for those style issues, it look okay to me:

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>


-- 
 i.

--8323329-1924053861-1685361110=:2737--
