Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BBBE6BC3A6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 03:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbjCPCOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 22:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjCPCOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 22:14:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF16E113E8;
        Wed, 15 Mar 2023 19:14:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 60FD561EE7;
        Thu, 16 Mar 2023 02:14:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B31ACC433EF;
        Thu, 16 Mar 2023 02:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678932855;
        bh=Wo69fq00Qh9FEc+bDW6Zi5el1L42m3tYk6njxLOZzZo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Av/BYTdx9CmTg8Ne72QlOQ0mjqu4v84hEautrlHNDaRe4Nr5ObHCnDRjeDf7f3Lzp
         qlATCoAmy+SULrwT29m+KlE1xRG5nAnt7yXZinH5yO6KSQuUgCo6/WTsAVrF4H1FJk
         MD/mzUaGlktyTzJfOKR6ZV+A5yTV6WVIR9f6f09fvN3Kv/HcZj2DO5/6pMdwWBtuI0
         bfuuMlDMMpIix6bOaAbt49kkZqPBGeVnM1v46xzC3IY2IjLvC1rZ2jeO20Z8M2jnHE
         TSURNwiJP1WLd3K9/fqgbbL6J6wS/YcgSlqX0ht23IuKxj1ShV6XSkCCrQw/3E59QC
         bddZf7FcWfFAQ==
Date:   Wed, 15 Mar 2023 19:17:36 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Melody Olvera <quic_molvera@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH v2 5/7] remoteproc: qcom: q6v5: Add support for q6 rmb
 registers
Message-ID: <20230316021736.d53quam5eew5fr6m@ripper>
References: <20230306231202.12223-1-quic_molvera@quicinc.com>
 <20230306231202.12223-6-quic_molvera@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230306231202.12223-6-quic_molvera@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2023 at 03:12:00PM -0800, Melody Olvera wrote:
> When attaching a running Q6, the remoteproc driver needs a way
> to communicate with the Q6 using rmb registers, so allow the
> rmb register to be gotten from the device tree if present.
> 
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---
>  drivers/remoteproc/qcom_q6v5.c | 9 +++++++++
>  drivers/remoteproc/qcom_q6v5.h | 8 ++++++++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5.c b/drivers/remoteproc/qcom_q6v5.c
> index 192c7aa0e39e..e8c6be70ebfd 100644
> --- a/drivers/remoteproc/qcom_q6v5.c
> +++ b/drivers/remoteproc/qcom_q6v5.c
> @@ -254,6 +254,7 @@ int qcom_q6v5_init(struct qcom_q6v5 *q6v5, struct platform_device *pdev,
>  		   void (*handover)(struct qcom_q6v5 *q6v5))
>  {
>  	int ret;
> +	struct resource *res;
>  
>  	q6v5->rproc = rproc;
>  	q6v5->dev = &pdev->dev;
> @@ -263,6 +264,14 @@ int qcom_q6v5_init(struct qcom_q6v5 *q6v5, struct platform_device *pdev,
>  	init_completion(&q6v5->start_done);
>  	init_completion(&q6v5->stop_done);
>  
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);

In addition to the PAS driver, __func__ is being invoked by the non-PAS
ADSP and MPSS drivers as well, which both uses reg[1] for other
purposes. So this won't work.

Perhaps I'm missing some possibility of reuse, but it seems reasonable
for this to move to the pas-driver.

Thanks,
Bjorn

> +	if (res) {
> +		q6v5->rmb_base = devm_ioremap_resource(&pdev->dev, res);
> +		if (IS_ERR(q6v5->rmb_base))
> +			q6v5->rmb_base = NULL;
> +	} else
> +		q6v5->rmb_base = NULL;
> +
>  	q6v5->wdog_irq = platform_get_irq_byname(pdev, "wdog");
>  	if (q6v5->wdog_irq < 0)
>  		return q6v5->wdog_irq;
> diff --git a/drivers/remoteproc/qcom_q6v5.h b/drivers/remoteproc/qcom_q6v5.h
> index 5a859c41896e..95824d5b64ce 100644
> --- a/drivers/remoteproc/qcom_q6v5.h
> +++ b/drivers/remoteproc/qcom_q6v5.h
> @@ -7,6 +7,12 @@
>  #include <linux/completion.h>
>  #include <linux/soc/qcom/qcom_aoss.h>
>  
> +#define RMB_BOOT_WAIT_REG 0x8
> +#define RMB_BOOT_CONT_REG 0xC
> +#define RMB_Q6_BOOT_STATUS_REG 0x10
> +
> +#define RMB_POLL_MAX_TIMES 250
> +
>  struct icc_path;
>  struct rproc;
>  struct qcom_smem_state;
> @@ -16,6 +22,8 @@ struct qcom_q6v5 {
>  	struct device *dev;
>  	struct rproc *rproc;
>  
> +	void __iomem *rmb_base;
> +
>  	struct qcom_smem_state *state;
>  	struct qmp *qmp;
>  
> -- 
> 2.25.1
> 
