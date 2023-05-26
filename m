Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0A47712FBA
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 00:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235167AbjEZWI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 18:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243584AbjEZWIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 18:08:55 -0400
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0849E10F3
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 15:08:30 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw21.mail.saunalahti.fi (Halon) with ESMTP
        id d68de696-fc11-11ed-abf4-005056bdd08f;
        Sat, 27 May 2023 01:08:26 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Sat, 27 May 2023 01:08:26 +0300
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linus.walleij@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v6 4/5] firmware: qcom_scm: Refactor code to support
 multiple download mode
Message-ID: <ZHEt2mrYpSMKBuIX@surfacebook>
References: <1680076012-10785-1-git-send-email-quic_mojha@quicinc.com>
 <1680076012-10785-5-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1680076012-10785-5-git-send-email-quic_mojha@quicinc.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wed, Mar 29, 2023 at 01:16:51PM +0530, Mukesh Ojha kirjoitti:
> Currently on Qualcomm SoC, download_mode is enabled if
> CONFIG_QCOM_SCM_DOWNLOAD_MODE_DEFAULT is selected.
> 
> Refactor the code such that it supports multiple download
> modes and drop CONFIG_QCOM_SCM_DOWNLOAD_MODE_DEFAULT config
> instead, give interface to set the download mode from
> module parameter.

...

>  #include <linux/clk.h>
>  #include <linux/reset-controller.h>
>  #include <linux/arm-smccc.h>

> +#include <linux/kstrtox.h>

Can this be located after clk.h which makes (some) order in this block?

...

>  #define QCOM_DOWNLOAD_MODE_MASK 0x30
>  #define QCOM_DOWNLOAD_FULLDUMP	0x1
> +#define QCOM_DOWNLOAD_NODUMP	0x0

Okay, so you start backward ordering.
But see comments to the next patch.

...

>  		ret = qcom_scm_io_update_field(__scm->dload_mode_addr,
> -				QCOM_DOWNLOAD_MODE_MASK,
> -				enable ? QCOM_DOWNLOAD_FULLDUMP : 0);
> +				QCOM_DOWNLOAD_MODE_MASK, download_mode);

Can ping-pong style be avoided? I.e. do the right thing in the previous patch,
so you won't change lines that were introduced just before.

...

>  }
>  
> +

Stray change.

> +static int get_download_mode(char *buffer, const struct kernel_param *kp)
> +{
> +	int len = 0;
> +
> +	if (download_mode == QCOM_DOWNLOAD_FULLDUMP)
> +		len = sysfs_emit(buffer, "full\n");
> +	else if (download_mode == QCOM_DOWNLOAD_NODUMP)
> +		len = sysfs_emit(buffer, "off\n");
> +
> +	return len;

You can return directly.

Also, what about download_mode that doesn't fit to the above two?

> +}

...

> +static int set_download_mode(const char *val, const struct kernel_param *kp)
> +{
> +	u32 old = download_mode;
> +
> +	if (sysfs_streq(val, "full")) {
> +		download_mode = QCOM_DOWNLOAD_FULLDUMP;
> +	} else if (sysfs_streq(val, "off")) {
> +		download_mode = QCOM_DOWNLOAD_NODUMP;

NIH sysfs_match_string().

> +	} else if (kstrtouint(val, 0, &download_mode) ||
> +		   !(download_mode == 0 || download_mode == 1)) {
> +		download_mode = old;
> +		pr_err("qcom_scm: unknown download mode: %s\n", val);

> +		return -EINVAL;

Do not shadow the error code from kstrtouint() it can be different to this one.

> +	}
> +
> +	if (__scm)
> +		qcom_scm_set_download_mode(download_mode);
> +
> +	return 0;
> +}

...

Have you updated corresponding documentation about this parameter?
Or there is none?

-- 
With Best Regards,
Andy Shevchenko


