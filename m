Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 230D3712E04
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 22:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbjEZUOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 16:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjEZUOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 16:14:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC913E7;
        Fri, 26 May 2023 13:14:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7905565321;
        Fri, 26 May 2023 20:14:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41783C433D2;
        Fri, 26 May 2023 20:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685132048;
        bh=+LH8uYOOMZ4oYEueEi03d6yn1VdMgPEVBQS7nznYJzA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FftT9q4m/nYrgDG4C/4vRIRMPuyG0OXKj/b3YdkqCsYW497NFdjClPgoqx/Ln3U3s
         rs4m7DZaID6sDM+9Mg+QtuaDWgV2T4J9KjQIATOOppqT7LGc0aTtb39B5tX0hzGWOB
         0Tub+A3SPzx2+BBvDVGB8a9COtcfLswA3R5gFazGh62R6uN9+hDO0wz18/pBkJmxz1
         rDMh15cfNzosvRrER1dq1cWCvk9ZeDGPxFfvLI/TXbD7empLvHHTMYu8gwdBV5bHu4
         tsaAXQvjPQPAKYeapcJTCEwbsTu2kXQZcLQeVzkex/PKViRsUdExDer49N9HD+aQ/o
         1ui+1VDj6RZsg==
Date:   Fri, 26 May 2023 13:17:57 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     agross@kernel.org, konrad.dybcio@linaro.org,
        linus.walleij@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Poovendhan Selvaraj <quic_poovendh@quicinc.com>
Subject: Re: [PATCH v6 3/5] firmware: scm: Modify only the download bits in
 TCSR register
Message-ID: <20230526201757.a37hcjbif5atbvmx@ripper>
References: <1680076012-10785-1-git-send-email-quic_mojha@quicinc.com>
 <1680076012-10785-4-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1680076012-10785-4-git-send-email-quic_mojha@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 01:16:50PM +0530, Mukesh Ojha wrote:
> CrashDump collection is based on the DLOAD bit of TCSR register.
> To retain other bits, we read the register and modify only the
> DLOAD bit as the other bits have their own significance.
> 
> Signed-off-by: Poovendhan Selvaraj <quic_poovendh@quicinc.com>

With Poovendhan being the first one to sign off the patch, was he the
author? Or should this be Co-developed-by: Poovendhan ?

Regards,
Bjorn

> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> ---
>  drivers/firmware/qcom_scm.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
> index cb0bc32..8e39b97 100644
> --- a/drivers/firmware/qcom_scm.c
> +++ b/drivers/firmware/qcom_scm.c
> @@ -30,6 +30,9 @@ module_param(download_mode, bool, 0);
>  #define SCM_HAS_IFACE_CLK	BIT(1)
>  #define SCM_HAS_BUS_CLK		BIT(2)
>  
> +#define QCOM_DOWNLOAD_MODE_MASK 0x30
> +#define QCOM_DOWNLOAD_FULLDUMP	0x1
> +
>  struct qcom_scm {
>  	struct device *dev;
>  	struct clk *core_clk;
> @@ -448,8 +451,9 @@ static void qcom_scm_set_download_mode(bool enable)
>  	if (avail) {
>  		ret = __qcom_scm_set_dload_mode(__scm->dev, enable);
>  	} else if (__scm->dload_mode_addr) {
> -		ret = qcom_scm_io_writel(__scm->dload_mode_addr,
> -				enable ? QCOM_SCM_BOOT_SET_DLOAD_MODE : 0);
> +		ret = qcom_scm_io_update_field(__scm->dload_mode_addr,
> +				QCOM_DOWNLOAD_MODE_MASK,
> +				enable ? QCOM_DOWNLOAD_FULLDUMP : 0);
>  	} else {
>  		dev_err(__scm->dev,
>  			"No available mechanism for setting download mode\n");
> -- 
> 2.7.4
> 
