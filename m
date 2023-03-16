Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82B846BC3C0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 03:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjCPCYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 22:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjCPCYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 22:24:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C01AA71F;
        Wed, 15 Mar 2023 19:24:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA5B961EE6;
        Thu, 16 Mar 2023 02:24:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10AFFC433D2;
        Thu, 16 Mar 2023 02:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678933460;
        bh=Dru+k7mXY5CpAC6aY6esr/ftvOW/j2SPoAN8MMrwrXk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xx0sLu+EE6NGwrA7T1XLyK3xqdnhfUPax0Xde53H3kBa7xYlk5YqYNM/UR9MpEx8N
         MDHrshUiYQfpdExClIp+Wkobv2rVERnHFdiZ7oZSjfs2Mu+XSorbVuXe9xmmUKoVWI
         b0rraXBwEkRWibwqrdOCILhxp2RmV22nu2SiPY3p3Su5rrOppAkKvbriU8wDaE0jRl
         Q8GCA2tiZQAX1hMv7Cp2R/dsNay95+ucp+Irlo37IE940XMtSvaqsdqU1sCtjWcIg7
         XVnCdqOiaAq36q74y9DqKqB+D33P4ZOtYj7O1eaq0+o79J6GFRSewlUTxW1NOuk/dt
         ZN41t9SAsroYw==
Date:   Wed, 15 Mar 2023 19:27:40 -0700
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
Subject: Re: [PATCH v2 6/7] remoteproc: qcom_q6v5_pas: Add support to attach
 a DSP
Message-ID: <20230316022740.umavd6jviftktag7@ripper>
References: <20230306231202.12223-1-quic_molvera@quicinc.com>
 <20230306231202.12223-7-quic_molvera@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230306231202.12223-7-quic_molvera@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2023 at 03:12:01PM -0800, Melody Olvera wrote:
> Some chipsets will have DSPs which will have begun running prior
> to linux booting, so add support to late attach these DSPs by
> adding support for:
> - run-time checking of an offline or running DSP via rmb register
> - a late attach framework to attach to the running DSP
> - a handshake mechanism to ensure full and proper booting via rmb
> 
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---
>  drivers/remoteproc/qcom_q6v5_pas.c | 103 ++++++++++++++++++++++++++++-
>  1 file changed, 102 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
> index 0871108fb4dc..e22be6a029a8 100644
> --- a/drivers/remoteproc/qcom_q6v5_pas.c
> +++ b/drivers/remoteproc/qcom_q6v5_pas.c
> @@ -242,10 +242,89 @@ static int adsp_load(struct rproc *rproc, const struct firmware *fw)
>  	return ret;
>  }
>  
> +static int adsp_attach(struct rproc *rproc)
> +{
> +	struct qcom_adsp *adsp = (struct qcom_adsp *)rproc->priv;
> +	int i, ret;
> +
> +	ret = qcom_q6v5_prepare(&adsp->q6v5);
> +	if (ret)
> +		return ret;
> +
> +	ret = adsp_pds_enable(adsp, adsp->proxy_pds, adsp->proxy_pd_count);
> +	if (ret < 0)
> +		goto disable_irqs;
> +
> +	ret = clk_prepare_enable(adsp->xo);
> +	if (ret)
> +		goto disable_proxy_pds;
> +
> +	ret = clk_prepare_enable(adsp->aggre2_clk);
> +	if (ret)
> +		goto disable_xo_clk;
> +
> +	if (adsp->cx_supply) {
> +		ret = regulator_enable(adsp->cx_supply);
> +		if (ret)
> +			goto disable_aggre2_clk;
> +	}
> +
> +	if (adsp->px_supply) {
> +		ret = regulator_enable(adsp->px_supply);
> +		if (ret)
> +			goto disable_cx_supply;
> +	}
> +
> +	/* if needed, signal Q6 to continute booting */
> +	if (adsp->q6v5.rmb_base) {
> +		for (i = 0; i < RMB_POLL_MAX_TIMES; i++) {
> +			if (readl_relaxed(adsp->q6v5.rmb_base + RMB_BOOT_WAIT_REG)) {
> +				writel_relaxed(1, adsp->q6v5.rmb_base + RMB_BOOT_CONT_REG);
> +				break;
> +			}
> +			msleep(20);
> +		}
> +
> +		if (!readl_relaxed(adsp->q6v5.rmb_base + RMB_BOOT_WAIT_REG)) {
> +			dev_err(adsp->dev, "Didn't get rmb signal from  %s\n", rproc->name);
> +			goto disable_px_supply;
> +		}
> +	}
> +
> +	ret = qcom_q6v5_wait_for_start(&adsp->q6v5, msecs_to_jiffies(5000));
> +	if (ret == -ETIMEDOUT) {
> +		dev_err(adsp->dev, "start timed out\n");
> +		qcom_scm_pas_shutdown(adsp->pas_id);
> +		goto disable_px_supply;
> +	}
> +
> +	return 0;
> +
> +disable_px_supply:
> +	if (adsp->px_supply)
> +		regulator_disable(adsp->px_supply);
> +disable_cx_supply:
> +	if (adsp->cx_supply)
> +		regulator_disable(adsp->cx_supply);
> +disable_aggre2_clk:
> +	clk_disable_unprepare(adsp->aggre2_clk);
> +disable_xo_clk:
> +	clk_disable_unprepare(adsp->xo);
> +disable_proxy_pds:
> +	adsp_pds_disable(adsp, adsp->proxy_pds, adsp->proxy_pd_count);
> +disable_irqs:
> +	qcom_q6v5_unprepare(&adsp->q6v5);
> +
> +	/* Remove pointer to the loaded firmware, only valid in adsp_load() & adsp_start() */
> +	adsp->firmware = NULL;
> +
> +	return ret;
> +}
> +
>  static int adsp_start(struct rproc *rproc)
>  {
>  	struct qcom_adsp *adsp = (struct qcom_adsp *)rproc->priv;
> -	int ret;
> +	int i, ret;
>  
>  	ret = qcom_q6v5_prepare(&adsp->q6v5);
>  	if (ret)
> @@ -304,6 +383,22 @@ static int adsp_start(struct rproc *rproc)
>  		goto release_pas_metadata;
>  	}
>  
> +	/* if needed, signal Q6 to continute booting */

Why does this come before the wait_for_start()? Is the DSP actually up
and running when you hit attach, or is it just loaded?

> +	if (adsp->q6v5.rmb_base) {

Afaict this is copy-paste from attach, please move it to a helper
function.

> +		for (i = 0; i < RMB_POLL_MAX_TIMES; i++) {
> +			if (readl_relaxed(adsp->q6v5.rmb_base + RMB_BOOT_WAIT_REG)) {
> +				writel_relaxed(1, adsp->q6v5.rmb_base + RMB_BOOT_CONT_REG);
> +				break;
> +			}
> +			msleep(20);
> +		}
> +
> +		if (!readl_relaxed(adsp->q6v5.rmb_base + RMB_BOOT_WAIT_REG)) {

If you hit the break above, there should be no reason to read this
register again.

Seems cleaner to write this as:

	ret = readl_poll_timeout();
	if (ret < 0)
		goto release;

	writel(1, ...);

Regards,
Bjorn

> +			dev_err(adsp->dev, "Didn't get rmb signal from  %s\n", rproc->name);
> +			goto release_pas_metadata;
> +		}
> +	}
> +
>  	ret = qcom_q6v5_wait_for_start(&adsp->q6v5, msecs_to_jiffies(5000));
>  	if (ret == -ETIMEDOUT) {
>  		dev_err(adsp->dev, "start timed out\n");
> @@ -413,6 +508,7 @@ static unsigned long adsp_panic(struct rproc *rproc)
>  static const struct rproc_ops adsp_ops = {
>  	.unprepare = adsp_unprepare,
>  	.start = adsp_start,
> +	.attach = adsp_attach,
>  	.stop = adsp_stop,
>  	.da_to_va = adsp_da_to_va,
>  	.parse_fw = qcom_register_dump_segments,
> @@ -423,6 +519,7 @@ static const struct rproc_ops adsp_ops = {
>  static const struct rproc_ops adsp_minidump_ops = {
>  	.unprepare = adsp_unprepare,
>  	.start = adsp_start,
> +	.attach = adsp_attach,
>  	.stop = adsp_stop,
>  	.da_to_va = adsp_da_to_va,
>  	.load = adsp_load,
> @@ -728,6 +825,10 @@ static int adsp_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto detach_proxy_pds;
>  
> +	if (adsp->q6v5.rmb_base &&
> +			readl_relaxed(adsp->q6v5.rmb_base + RMB_Q6_BOOT_STATUS_REG))
> +		rproc->state = RPROC_DETACHED;
> +
>  	qcom_add_glink_subdev(rproc, &adsp->glink_subdev, desc->ssr_name);
>  	qcom_add_smd_subdev(rproc, &adsp->smd_subdev);
>  	adsp->sysmon = qcom_add_sysmon_subdev(rproc,
> -- 
> 2.25.1
> 
