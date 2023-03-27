Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C72306CACE7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 20:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbjC0SUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 14:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjC0SUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 14:20:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 991052110;
        Mon, 27 Mar 2023 11:20:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 354436145F;
        Mon, 27 Mar 2023 18:20:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1887AC433EF;
        Mon, 27 Mar 2023 18:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679941219;
        bh=lYY4zfnVk+dS2Tb1gFUTLPpevowSoSPH3ArNqnSQ6IA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JI8IyHx1Qe1sBAmze9v4RqReo4EDkqQsUAwFFTSpJXrlTu+Vl3BnggfyYuhf4CLwp
         mTfClSdc/RBHJv8+1JYV9R/at+5F/ibT9bHSQ/59XGnhyDJFS49nXElG5apF2qV15f
         GITT+riTVu9VT66sSPgf2vraLfAMfZaQTAbZBCIJl5i9Iei7OCfngLvcNaLGZEW36V
         3uKIRBubNNlV/Ti6Bsig1/c30MkTHf2zpzfsijj9ixhM6ASGp0krjHvhVDp2n8Qe0t
         zuorG4ZViq/8rUVAeRSE+paK07XrfHiVd3pWSms0kIzXi/iJ4NkbUN1HG7qPNVOSH3
         Hfp7VpFJiZ8hw==
Date:   Mon, 27 Mar 2023 11:23:24 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     agross@kernel.org, konrad.dybcio@linaro.org,
        linus.walleij@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v4 4/5] firmware: qcom_scm: Refactor code to support
 multiple download mode
Message-ID: <20230327182324.elrxciz5vqvryp7y@ripper>
References: <1679935281-18445-1-git-send-email-quic_mojha@quicinc.com>
 <1679935281-18445-5-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1679935281-18445-5-git-send-email-quic_mojha@quicinc.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 10:11:20PM +0530, Mukesh Ojha wrote:
[..]
> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
> index 3c6c5e7..0c94429 100644
> --- a/drivers/firmware/qcom_scm.c
> +++ b/drivers/firmware/qcom_scm.c
> @@ -20,11 +20,11 @@
>  #include <linux/clk.h>
>  #include <linux/reset-controller.h>
>  #include <linux/arm-smccc.h>
> +#include <linux/kstrtox.h>
>  
>  #include "qcom_scm.h"
>  
> -static bool download_mode = IS_ENABLED(CONFIG_QCOM_SCM_DOWNLOAD_MODE_DEFAULT);
> -module_param(download_mode, bool, 0);
> +static u32 download_mode;
>  
>  #define SCM_HAS_CORE_CLK	BIT(0)
>  #define SCM_HAS_IFACE_CLK	BIT(1)
> @@ -32,6 +32,7 @@ module_param(download_mode, bool, 0);
>  
>  #define QCOM_DOWNLOAD_MODE_MASK 0x30
>  #define QCOM_DOWNLOAD_FULLDUMP	0x1
> +#define QCOM_DOWNLOAD_NODUMP	0x0
>  
>  struct qcom_scm {
>  	struct device *dev;
> @@ -440,8 +441,9 @@ static int __qcom_scm_set_dload_mode(struct device *dev, bool enable)
>  	return qcom_scm_call_atomic(__scm->dev, &desc, NULL);
>  }
>  
> -static void qcom_scm_set_download_mode(bool enable)
> +static void qcom_scm_set_download_mode(u32 download_mode)
>  {
> +	bool enable = !!download_mode;
>  	bool avail;
>  	int ret = 0;
>  
> @@ -453,7 +455,7 @@ static void qcom_scm_set_download_mode(bool enable)
>  	} else if (__scm->dload_mode_addr) {
>  		ret = qcom_scm_io_update_field(__scm->dload_mode_addr,
>  				QCOM_DOWNLOAD_MODE_MASK,
> -				enable ? QCOM_DOWNLOAD_FULLDUMP : 0);
> +				enable ? download_mode : 0);

Afaict, with QCOM_DOWNLOAD_NODUMP as 0, this says:

  when download_mode is non-zero, write that value, otherwise write 0

That should be the same as "write download_mode", so you should be able
to drop the enable part.

>  	} else {
>  		dev_err(__scm->dev,
>  			"No available mechanism for setting download mode\n");
> @@ -1419,6 +1421,49 @@ static irqreturn_t qcom_scm_irq_handler(int irq, void *data)
>  	return IRQ_HANDLED;
>  }
>  
> +
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
> +}
> +
> +static int set_download_mode(const char *val, const struct kernel_param *kp)
> +{
> +	u32 old = download_mode;
> +
> +	if (!strncmp(val, "full", strlen("full"))) {

strcmp loops over the two string until they differ and/or both are
'\0'.

As such, the only thing you achieve by using strncmp(.., T, strlen(T))
is that the code has to iterate over T twice - and you make the code
harder to read.

> +		download_mode = QCOM_DOWNLOAD_FULLDUMP;
> +	} else if (!strncmp(val, "off", strlen("off"))) {
> +		download_mode = QCOM_DOWNLOAD_NODUMP;
> +	} else if (kstrtouint(val, 0, &download_mode) ||
> +		   !(download_mode == 0 || download_mode == 1)) {
> +		download_mode = old;
> +		pr_err("unknown download mode\n");

This will result in a lone "unknown download mode" line somewhere in the
kernel log, without association to any driver or any indication what the
unknown value was.

  pr_err("qcom_scm: unknown download mode: %s\n", val);

Would give both context and let the reader know right there what value
the code wasn't able to match.

Regards,
Bjorn
