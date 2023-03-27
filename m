Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 983ED6CACFB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 20:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbjC0SY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 14:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjC0SYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 14:24:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 492AE2D67;
        Mon, 27 Mar 2023 11:24:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA76061473;
        Mon, 27 Mar 2023 18:24:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 834C8C433D2;
        Mon, 27 Mar 2023 18:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679941458;
        bh=/42gpiL3XmCJs1PgWn+kvWNZaEuLTPFWkG/Gn+lttLQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=spWkBGxWUAlGWRb/9TAOnDLSiGpeQb4X7S+v4NwpLYmyGdv9uUTujIjyijxI6zx4F
         r9/yqmS9hjFTa+TNy/tHlU2FICl7idHU6SP3SkZ9bC7sCmf6xTcrqmcXgH9CNlyxL+
         dnGoNILLBbW5zIEX6bFJXQpmsX0X5uKs/aDGO+g0XlGx3G+RvsbGljaT1ufF2I1gLT
         IQWEOTSH6ATToXP7namlofvXfclGuBWUzlIkZgC5S/LQGhuZwa6xfdWVj0hQWxeck2
         xX9XoXrs/oHlr/lj9KKy0ken+SzNreyrfqPw1ZTbpgPjFFlihVi3uaXwP+Qd8XWrkP
         CgAR+3zBldDvQ==
Date:   Mon, 27 Mar 2023 11:27:23 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     agross@kernel.org, konrad.dybcio@linaro.org,
        linus.walleij@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v4 5/5] firmware: qcom_scm: Add multiple download mode
 support
Message-ID: <20230327182723.bopz73a5as4ft74g@ripper>
References: <1679935281-18445-1-git-send-email-quic_mojha@quicinc.com>
 <1679935281-18445-6-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1679935281-18445-6-git-send-email-quic_mojha@quicinc.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 10:11:21PM +0530, Mukesh Ojha wrote:
> Currently, scm driver only supports full dump when download
> mode is selected. Add support to enable minidump as well both
> dump(full dump + minidump).
> 
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> ---
>  drivers/firmware/qcom_scm.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
> index 0c94429..19315d0 100644
> --- a/drivers/firmware/qcom_scm.c
> +++ b/drivers/firmware/qcom_scm.c
> @@ -32,6 +32,8 @@ static u32 download_mode;
>  
>  #define QCOM_DOWNLOAD_MODE_MASK 0x30
>  #define QCOM_DOWNLOAD_FULLDUMP	0x1
> +#define QCOM_DOWNLOAD_MINIDUMP  0x2
> +#define QCOM_DOWNLOAD_BOTHDUMP	(QCOM_DOWNLOAD_FULLDUMP | QCOM_DOWNLOAD_MINIDUMP)
>  #define QCOM_DOWNLOAD_NODUMP	0x0
>  
>  struct qcom_scm {
> @@ -1421,13 +1423,16 @@ static irqreturn_t qcom_scm_irq_handler(int irq, void *data)
>  	return IRQ_HANDLED;
>  }
>  
> -
>  static int get_download_mode(char *buffer, const struct kernel_param *kp)
>  {
>  	int len = 0;
>  
>  	if (download_mode == QCOM_DOWNLOAD_FULLDUMP)
>  		len = sysfs_emit(buffer, "full\n");
> +	else if (download_mode == QCOM_DOWNLOAD_MINIDUMP)
> +		len = sysfs_emit(buffer, "mini\n");
> +	else if (download_mode == QCOM_DOWNLOAD_BOTHDUMP)
> +		len = sysfs_emit(buffer, "both\n");
>  	else if (download_mode == QCOM_DOWNLOAD_NODUMP)
>  		len = sysfs_emit(buffer, "off\n");
>  
> @@ -1440,6 +1445,10 @@ static int set_download_mode(const char *val, const struct kernel_param *kp)
>  
>  	if (!strncmp(val, "full", strlen("full"))) {
>  		download_mode = QCOM_DOWNLOAD_FULLDUMP;
> +	} else if (!strncmp(val, "mini", strlen("mini"))) {
> +		download_mode = QCOM_DOWNLOAD_MINIDUMP;
> +	} else if (!strncmp(val, "both", strlen("both"))) {

"both" isn't very future proof...

How about allowing mini,full? You don't need to do string tokenizing
etc, just strcmp mini,full (and full,mini if you want to be fancy)...

Regards,
Bjorn

> +		download_mode = QCOM_DOWNLOAD_BOTHDUMP;
>  	} else if (!strncmp(val, "off", strlen("off"))) {
>  		download_mode = QCOM_DOWNLOAD_NODUMP;
>  	} else if (kstrtouint(val, 0, &download_mode) ||
> @@ -1462,7 +1471,7 @@ static const struct kernel_param_ops download_mode_param_ops = {
>  
>  module_param_cb(download_mode, &download_mode_param_ops, NULL, 0644);
>  MODULE_PARM_DESC(download_mode,
> -		 "Download mode: off/full or 0/1 for existing users");
> +		 "download mode: off/full/mini/both(full+mini) or 0/1 for existing users");
>  
>  static int qcom_scm_probe(struct platform_device *pdev)
>  {
> -- 
> 2.7.4
> 
