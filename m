Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2358712FC5
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 00:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238041AbjEZWO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 18:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbjEZWO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 18:14:56 -0400
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439D683
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 15:14:55 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw21.mail.saunalahti.fi (Halon) with ESMTP
        id bb89b88c-fc12-11ed-abf4-005056bdd08f;
        Sat, 27 May 2023 01:14:50 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Sat, 27 May 2023 01:14:50 +0300
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linus.walleij@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v6 5/5] firmware: qcom_scm: Add multiple download mode
 support
Message-ID: <ZHEvWpCqg_oyWyZW@surfacebook>
References: <1680076012-10785-1-git-send-email-quic_mojha@quicinc.com>
 <1680076012-10785-6-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1680076012-10785-6-git-send-email-quic_mojha@quicinc.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wed, Mar 29, 2023 at 01:16:52PM +0530, Mukesh Ojha kirjoitti:
> Currently, scm driver only supports full dump when download
> mode is selected. Add support to enable minidump as well as
> enable it along with fulldump.

...

>  #define QCOM_DOWNLOAD_MODE_MASK 0x30
>  #define QCOM_DOWNLOAD_FULLDUMP	0x1
> +#define QCOM_DOWNLOAD_MINIDUMP  0x2
> +#define QCOM_DOWNLOAD_BOTHDUMP	(QCOM_DOWNLOAD_FULLDUMP | QCOM_DOWNLOAD_MINIDUMP)

Now order is broken.

>  #define QCOM_DOWNLOAD_NODUMP	0x0

...

> @@ -1420,13 +1422,16 @@ static irqreturn_t qcom_scm_irq_handler(int irq, void *data)
>  	return IRQ_HANDLED;
>  }
>  
> -

Stray change and ping-pong style at the same time.

...

>  	if (download_mode == QCOM_DOWNLOAD_FULLDUMP)
>  		len = sysfs_emit(buffer, "full\n");
> +	else if (download_mode == QCOM_DOWNLOAD_MINIDUMP)
> +		len = sysfs_emit(buffer, "mini\n");
> +	else if (download_mode == QCOM_DOWNLOAD_BOTHDUMP)

> +		len = sysfs_emit(buffer, "full,mini\n");

Why not "both" ?

>  	else if (download_mode == QCOM_DOWNLOAD_NODUMP)
>  		len = sysfs_emit(buffer, "off\n");


With an array (for streq_match_string() call suggested earlier) this become as
simple as

	if (mode >= ARRAY_SIZE(...))
		return sysfs_emit("Oh heh!\n");

	return sysfs_emit("%s\n", array[mode]);

...

> -	if (sysfs_streq(val, "full")) {

Why changing this line?

> +	if (sysfs_streq(val, "full,mini") || sysfs_streq(val, "mini,full")) {
> +		download_mode = QCOM_DOWNLOAD_BOTHDUMP;

It's way too hard, esp. taking into account that once user enters wrong order,
user can't simply validate this by reading value back.

Use "both" and that's it.

> +	} else if (sysfs_streq(val, "full")) {
>  		download_mode = QCOM_DOWNLOAD_FULLDUMP;
> +	} else if (sysfs_streq(val, "mini")) {
> +		download_mode = QCOM_DOWNLOAD_MINIDUMP;

...

>  module_param_cb(download_mode, &download_mode_param_ops, NULL, 0644);
>  MODULE_PARM_DESC(download_mode,
> -		 "Download mode: off/full or 0/1 for existing users");
> +		"download mode: off/full/mini/full,mini or mini,full and 0/1 for existing users");

You really must be consistent with at least a couple of things:
1) capitalization;
2) indentation.

-- 
With Best Regards,
Andy Shevchenko


