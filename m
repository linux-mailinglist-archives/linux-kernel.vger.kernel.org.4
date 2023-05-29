Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7FD27148AF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 13:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbjE2Lhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 07:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbjE2Lhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 07:37:46 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA4C198;
        Mon, 29 May 2023 04:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685360234; x=1716896234;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=NWr/6eJjlJQBWiOn+r8LQO0h+nbcFRQJQ97hoYzdinM=;
  b=GxLlC3IlvxBzeBw629QYfKtdLzgvtDe9HjCpog52GbrYpoRhPS2wo/j1
   DOip0QcodQvoJsd6ChEe2XxN+XLMSU/+p2KoWsrxCBrhs3HXHHdwtG0Fw
   /ZMAuxL6iyeHrsTxmERHqvtGi+W2ILWaQd3LJb35/AsGabd84029hHLbj
   FdAtQh6LJ9EWhndk0k+kI5ZXspnz8r+PcLIn8zOnRXGqAUewlgmVf9FeA
   dwlw+vZQpm+KybCzYdf2oxCaI+his5F0wCE0evs4dL8yY9rYqWgmgwBkO
   /cqvpgqmU/LueqDpM1u1fXDChqYnkh6qY7hQc1irJSK4Oi/wu3Jmk1xGk
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10724"; a="354698994"
X-IronPort-AV: E=Sophos;i="6.00,201,1681196400"; 
   d="scan'208";a="354698994"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2023 04:37:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10724"; a="706035409"
X-IronPort-AV: E=Sophos;i="6.00,201,1681196400"; 
   d="scan'208";a="706035409"
Received: from btaubert-mobl1.ger.corp.intel.com ([10.252.55.237])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2023 04:37:12 -0700
Date:   Mon, 29 May 2023 14:36:59 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Mark Pearson <mpearson-lenovo@squebb.ca>
cc:     hdegoede@redhat.com, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/5] platform/x86: think-lmi: Correct System password
 interface
In-Reply-To: <20230526171658.3886-2-mpearson-lenovo@squebb.ca>
Message-ID: <ff5513d9-ecf-50d3-1bb3-644a1d2c2347@linux.intel.com>
References: <mpearson-lenovo@squebb.ca> <20230526171658.3886-1-mpearson-lenovo@squebb.ca> <20230526171658.3886-2-mpearson-lenovo@squebb.ca>
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

> The system password identification was incorrect. This means that if
> the password was enabled it wouldn't be detected correctly; and setting
> it would not work.
> Also updated code to use TLMI_SMP_PWD instead of TLMI_SYS_PWD to be in
> sync with Lenovo documentation.
> 
> Correct these mistakes.
> 
> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>

Missing Fixes tag?

> ---
> Changes in v2:
>  - Updated define name to be SMP_PWD instead of SYS_PWD
>  - Clarified in comments what each password type is.
> Changes in v3: None. Version bump with rest of series
> 
>  drivers/platform/x86/think-lmi.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
> index 2745224f62ab..c7e98fbe7c3d 100644
> --- a/drivers/platform/x86/think-lmi.c
> +++ b/drivers/platform/x86/think-lmi.c
> @@ -168,11 +168,11 @@ MODULE_PARM_DESC(debug_support, "Enable debug command support");
>   */
>  #define LENOVO_CERT_THUMBPRINT_GUID "C59119ED-1C0D-4806-A8E9-59AA318176C4"
>  
> -#define TLMI_POP_PWD (1 << 0)
> -#define TLMI_PAP_PWD (1 << 1)
> -#define TLMI_HDD_PWD (1 << 2)
> -#define TLMI_SYS_PWD (1 << 3)
> -#define TLMI_CERT    (1 << 7)
> +#define TLMI_POP_PWD (1 << 0) /* Supervisor */
> +#define TLMI_PAP_PWD (1 << 1) /* Power-on */
> +#define TLMI_HDD_PWD (1 << 2) /* HDD/NVME */
> +#define TLMI_SMP_PWD (1 << 6) /* System Management */
> +#define TLMI_CERT    (1 << 7) /* Certificate Based */

Whe you're adding Fixes tag, please make this change minimal by just 
adding TLMI_SMP_PWD.

The rest of these define changes are a good too but it's unrelated to the 
actual fix so they should be in a separate patch. And once you move it 
into own change, convert to BIT() while at it.

-- 
 i.


>  #define to_tlmi_pwd_setting(kobj)  container_of(kobj, struct tlmi_pwd_setting, kobj)
>  #define to_tlmi_attr_setting(kobj)  container_of(kobj, struct tlmi_attr_setting, kobj)
> @@ -1509,11 +1509,11 @@ static int tlmi_analyze(void)
>  		tlmi_priv.pwd_power->valid = true;
>  
>  	if (tlmi_priv.opcode_support) {
> -		tlmi_priv.pwd_system = tlmi_create_auth("sys", "system");
> +		tlmi_priv.pwd_system = tlmi_create_auth("smp", "system");
>  		if (!tlmi_priv.pwd_system)
>  			goto fail_clear_attr;
>  
> -		if (tlmi_priv.pwdcfg.core.password_state & TLMI_SYS_PWD)
> +		if (tlmi_priv.pwdcfg.core.password_state & TLMI_SMP_PWD)
>  			tlmi_priv.pwd_system->valid = true;
>  
>  		tlmi_priv.pwd_hdd = tlmi_create_auth("hdd", "hdd");
> 
