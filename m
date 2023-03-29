Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3C96CF158
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 19:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjC2RqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 13:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjC2RqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 13:46:14 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1396F59ED
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 10:46:12 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id ix20so15687473plb.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 10:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680111971;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/ya68Y7BreYgp2xmW7R1eW3EwXPKdktm2mDTZy/1T50=;
        b=dMJU+o+oi5o+BlxycSkAJ0Nk546Id6eOpKoQNZB4kNWrxcy8P5Z0Hpe1OpZa2jlPrs
         86jfgpEltiydLSAwjAG0XTgcr9hNJY1nqiTUR8f8np+AteK+/jJmXPlZByoJTpNQewGB
         4TPsQgzXU3IGOsIMY5xxs0JX00o+drI1epvCGJpQLLIlOyiGjtxDlVZb/gOlxptYYtrS
         VZIg1/885K+tiiuxmBebY8YUEmLuREKhOizD0K2sr4jVyIHuCojsXp/OqJm+Mw7J1+lm
         WZRMBk946CXWNCUoZf/c11Ma9Jq7EFi11/CRC9zFsPbPmMcmhC5GCWemYXxBhyJH7HoG
         NxuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680111971;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ya68Y7BreYgp2xmW7R1eW3EwXPKdktm2mDTZy/1T50=;
        b=ZqkM5b22QGiUQqo7p6XdHmfelcDJM86l/ES0EfvSOP4CZ2ZU/R0r07q+vNaFRZw4Uu
         2Jl+FEpxXDfwpEkZ5hKV5KF1LDQlC2JwWwv5PjVsbsE6rQsWIPgJEG+eg3IGznbyendL
         fZiwMgMAxxWwm/v6UOi2f9SBv0x7aFnwIH4hvJ21IllZntzQaKIC1MKl6N2FwtA6b3T8
         tI/8FQOFSjFfmfSHhMd5oMNZbtGS1LbiGf8k0RJuZA3xsG4/hf4Z+Qod6vgrwKyHQsF3
         O5Dc/UbsRKR0c6PKFi8s571TkgIGuWTf0tkZRBwsYZcubkPfad3SScgnJSIET0luqwXz
         0Phg==
X-Gm-Message-State: AAQBX9dd6FLJQOd0PVS5QySlC6J4uDUoN0AulqFVbNbqv8eoXlqmzaUe
        Hu9VWuV9yD1KHfV6IjbsftY7TQ==
X-Google-Smtp-Source: AKy350Y7TSUjpvy5YPG38ymSokgkfiQGqTlx//VBy8VXDlp6/7VnzWJyCDUsV2h7z1S6+WJBJJyJ4w==
X-Received: by 2002:a17:903:138e:b0:1a2:3ddc:6286 with SMTP id jx14-20020a170903138e00b001a23ddc6286mr12485764plb.49.1680111971487;
        Wed, 29 Mar 2023 10:46:11 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:6b79:83ab:5e33:50a5])
        by smtp.gmail.com with ESMTPSA id v15-20020a1709028d8f00b001a055028d1asm23327162plo.1.2023.03.29.10.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 10:46:11 -0700 (PDT)
Date:   Wed, 29 Mar 2023 11:46:08 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Yu Zhe <yuzhe@nfschina.com>
Cc:     andersson@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, agross@kernel.org,
        konrad.dybcio@linaro.org, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        kernel-janitors@vger.kernel.org, liqiong@nfschina.com
Subject: Re: [PATCH v4] remoteproc: remove unnecessary (void*) conversions
Message-ID: <20230329174608.GB3374270@p14s>
References: <20230328015749.1608-1-yuzhe@nfschina.com>
 <20230328024907.29791-1-yuzhe@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328024907.29791-1-yuzhe@nfschina.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 10:49:07AM +0800, Yu Zhe wrote:
> Pointer variables of void * type do not require type cast.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/oe-kbuild-all/202303272213.jOYrwBZu-lkp@intel.com/
> Signed-off-by: Yu Zhe <yuzhe@nfschina.com>
> ---
> 
> v3->v4:
>  Drop wrong modifies
> ---
>  drivers/remoteproc/da8xx_remoteproc.c   | 12 ++++++------
>  drivers/remoteproc/mtk_scp.c            | 12 ++++++------
>  drivers/remoteproc/qcom_q6v5_adsp.c     | 10 +++++-----
>  drivers/remoteproc/qcom_q6v5_mss.c      |  8 ++++----
>  drivers/remoteproc/qcom_q6v5_pas.c      | 14 +++++++-------
>  drivers/remoteproc/qcom_wcnss.c         | 10 +++++-----
>  drivers/remoteproc/xlnx_r5_remoteproc.c | 16 ++++++++--------
>  7 files changed, 41 insertions(+), 41 deletions(-)

This looks good to me but since I am pretty sure you have not compiled for all
these platforms, I will wait a week to give time for the bots to find potential
compilation warnings.

Thanks,
Mathieu

> 
> diff --git a/drivers/remoteproc/da8xx_remoteproc.c b/drivers/remoteproc/da8xx_remoteproc.c
> index 98e0be9476a4..768217f0f5cd 100644
> --- a/drivers/remoteproc/da8xx_remoteproc.c
> +++ b/drivers/remoteproc/da8xx_remoteproc.c
> @@ -84,7 +84,7 @@ struct da8xx_rproc {
>   */
>  static irqreturn_t handle_event(int irq, void *p)
>  {
> -	struct rproc *rproc = (struct rproc *)p;
> +	struct rproc *rproc = p;
>  
>  	/* Process incoming buffers on all our vrings */
>  	rproc_vq_interrupt(rproc, 0);
> @@ -104,8 +104,8 @@ static irqreturn_t handle_event(int irq, void *p)
>   */
>  static irqreturn_t da8xx_rproc_callback(int irq, void *p)
>  {
> -	struct rproc *rproc = (struct rproc *)p;
> -	struct da8xx_rproc *drproc = (struct da8xx_rproc *)rproc->priv;
> +	struct rproc *rproc = p;
> +	struct da8xx_rproc *drproc = rproc->priv;
>  	u32 chipsig;
>  
>  	chipsig = readl(drproc->chipsig);
> @@ -133,7 +133,7 @@ static irqreturn_t da8xx_rproc_callback(int irq, void *p)
>  static int da8xx_rproc_start(struct rproc *rproc)
>  {
>  	struct device *dev = rproc->dev.parent;
> -	struct da8xx_rproc *drproc = (struct da8xx_rproc *)rproc->priv;
> +	struct da8xx_rproc *drproc = rproc->priv;
>  	struct clk *dsp_clk = drproc->dsp_clk;
>  	struct reset_control *dsp_reset = drproc->dsp_reset;
>  	int ret;
> @@ -183,7 +183,7 @@ static int da8xx_rproc_stop(struct rproc *rproc)
>  /* kick a virtqueue */
>  static void da8xx_rproc_kick(struct rproc *rproc, int vqid)
>  {
> -	struct da8xx_rproc *drproc = (struct da8xx_rproc *)rproc->priv;
> +	struct da8xx_rproc *drproc = rproc->priv;
>  
>  	/* Interrupt remote proc */
>  	writel(SYSCFG_CHIPSIG2, drproc->chipsig);
> @@ -360,7 +360,7 @@ static int da8xx_rproc_probe(struct platform_device *pdev)
>  static int da8xx_rproc_remove(struct platform_device *pdev)
>  {
>  	struct rproc *rproc = platform_get_drvdata(pdev);
> -	struct da8xx_rproc *drproc = (struct da8xx_rproc *)rproc->priv;
> +	struct da8xx_rproc *drproc = rproc->priv;
>  	struct device *dev = &pdev->dev;
>  
>  	/*
> diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
> index 0861b76f185f..e1d93e63d7df 100644
> --- a/drivers/remoteproc/mtk_scp.c
> +++ b/drivers/remoteproc/mtk_scp.c
> @@ -74,8 +74,8 @@ static void scp_wdt_handler(struct mtk_scp *scp, u32 scp_to_host)
>  
>  static void scp_init_ipi_handler(void *data, unsigned int len, void *priv)
>  {
> -	struct mtk_scp *scp = (struct mtk_scp *)priv;
> -	struct scp_run *run = (struct scp_run *)data;
> +	struct mtk_scp *scp = priv;
> +	struct scp_run *run = data;
>  
>  	scp->run.signaled = run->signaled;
>  	strscpy(scp->run.fw_ver, run->fw_ver, SCP_FW_VER_LEN);
> @@ -498,7 +498,7 @@ static int scp_parse_fw(struct rproc *rproc, const struct firmware *fw)
>  
>  static int scp_start(struct rproc *rproc)
>  {
> -	struct mtk_scp *scp = (struct mtk_scp *)rproc->priv;
> +	struct mtk_scp *scp = rproc->priv;
>  	struct device *dev = scp->dev;
>  	struct scp_run *run = &scp->run;
>  	int ret;
> @@ -587,7 +587,7 @@ static void *mt8192_scp_da_to_va(struct mtk_scp *scp, u64 da, size_t len)
>  
>  static void *scp_da_to_va(struct rproc *rproc, u64 da, size_t len, bool *is_iomem)
>  {
> -	struct mtk_scp *scp = (struct mtk_scp *)rproc->priv;
> +	struct mtk_scp *scp = rproc->priv;
>  
>  	return scp->data->scp_da_to_va(scp, da, len);
>  }
> @@ -627,7 +627,7 @@ static void mt8195_scp_stop(struct mtk_scp *scp)
>  
>  static int scp_stop(struct rproc *rproc)
>  {
> -	struct mtk_scp *scp = (struct mtk_scp *)rproc->priv;
> +	struct mtk_scp *scp = rproc->priv;
>  	int ret;
>  
>  	ret = clk_prepare_enable(scp->clk);
> @@ -829,7 +829,7 @@ static int scp_probe(struct platform_device *pdev)
>  	if (!rproc)
>  		return dev_err_probe(dev, -ENOMEM, "unable to allocate remoteproc\n");
>  
> -	scp = (struct mtk_scp *)rproc->priv;
> +	scp = rproc->priv;
>  	scp->rproc = rproc;
>  	scp->dev = dev;
>  	scp->data = of_device_get_match_data(dev);
> diff --git a/drivers/remoteproc/qcom_q6v5_adsp.c b/drivers/remoteproc/qcom_q6v5_adsp.c
> index 08d8dad22ca7..d546ab9dc141 100644
> --- a/drivers/remoteproc/qcom_q6v5_adsp.c
> +++ b/drivers/remoteproc/qcom_q6v5_adsp.c
> @@ -321,7 +321,7 @@ static int qcom_adsp_shutdown(struct qcom_adsp *adsp)
>  
>  static int adsp_load(struct rproc *rproc, const struct firmware *fw)
>  {
> -	struct qcom_adsp *adsp = (struct qcom_adsp *)rproc->priv;
> +	struct qcom_adsp *adsp = rproc->priv;
>  	int ret;
>  
>  	ret = qcom_mdt_load_no_init(adsp->dev, fw, rproc->firmware, 0,
> @@ -379,7 +379,7 @@ static int adsp_map_carveout(struct rproc *rproc)
>  
>  static int adsp_start(struct rproc *rproc)
>  {
> -	struct qcom_adsp *adsp = (struct qcom_adsp *)rproc->priv;
> +	struct qcom_adsp *adsp = rproc->priv;
>  	int ret;
>  	unsigned int val;
>  
> @@ -469,7 +469,7 @@ static void qcom_adsp_pil_handover(struct qcom_q6v5 *q6v5)
>  
>  static int adsp_stop(struct rproc *rproc)
>  {
> -	struct qcom_adsp *adsp = (struct qcom_adsp *)rproc->priv;
> +	struct qcom_adsp *adsp = rproc->priv;
>  	int handover;
>  	int ret;
>  
> @@ -492,7 +492,7 @@ static int adsp_stop(struct rproc *rproc)
>  
>  static void *adsp_da_to_va(struct rproc *rproc, u64 da, size_t len, bool *is_iomem)
>  {
> -	struct qcom_adsp *adsp = (struct qcom_adsp *)rproc->priv;
> +	struct qcom_adsp *adsp = rproc->priv;
>  	int offset;
>  
>  	offset = da - adsp->mem_reloc;
> @@ -696,7 +696,7 @@ static int adsp_probe(struct platform_device *pdev)
>  	rproc->has_iommu = desc->has_iommu;
>  	rproc_coredump_set_elf_info(rproc, ELFCLASS32, EM_NONE);
>  
> -	adsp = (struct qcom_adsp *)rproc->priv;
> +	adsp = rproc->priv;
>  	adsp->dev = &pdev->dev;
>  	adsp->rproc = rproc;
>  	adsp->info_name = desc->sysmon_name;
> diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
> index ab053084f7a2..e7a67c8c16a0 100644
> --- a/drivers/remoteproc/qcom_q6v5_mss.c
> +++ b/drivers/remoteproc/qcom_q6v5_mss.c
> @@ -1562,7 +1562,7 @@ static void qcom_q6v5_dump_segment(struct rproc *rproc,
>  
>  static int q6v5_start(struct rproc *rproc)
>  {
> -	struct q6v5 *qproc = (struct q6v5 *)rproc->priv;
> +	struct q6v5 *qproc = rproc->priv;
>  	int xfermemop_ret;
>  	int ret;
>  
> @@ -1604,7 +1604,7 @@ static int q6v5_start(struct rproc *rproc)
>  
>  static int q6v5_stop(struct rproc *rproc)
>  {
> -	struct q6v5 *qproc = (struct q6v5 *)rproc->priv;
> +	struct q6v5 *qproc = rproc->priv;
>  	int ret;
>  
>  	ret = qcom_q6v5_request_stop(&qproc->q6v5, qproc->sysmon);
> @@ -1662,7 +1662,7 @@ static int qcom_q6v5_register_dump_segments(struct rproc *rproc,
>  
>  static unsigned long q6v5_panic(struct rproc *rproc)
>  {
> -	struct q6v5 *qproc = (struct q6v5 *)rproc->priv;
> +	struct q6v5 *qproc = rproc->priv;
>  
>  	return qcom_q6v5_panic(&qproc->q6v5);
>  }
> @@ -1977,7 +1977,7 @@ static int q6v5_probe(struct platform_device *pdev)
>  	rproc->auto_boot = false;
>  	rproc_coredump_set_elf_info(rproc, ELFCLASS32, EM_NONE);
>  
> -	qproc = (struct q6v5 *)rproc->priv;
> +	qproc = rproc->priv;
>  	qproc->dev = &pdev->dev;
>  	qproc->rproc = rproc;
>  	qproc->hexagon_mdt_image = "modem.mdt";
> diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
> index 0871108fb4dc..8eec88119fdd 100644
> --- a/drivers/remoteproc/qcom_q6v5_pas.c
> +++ b/drivers/remoteproc/qcom_q6v5_pas.c
> @@ -186,7 +186,7 @@ static int adsp_shutdown_poll_decrypt(struct qcom_adsp *adsp)
>  
>  static int adsp_unprepare(struct rproc *rproc)
>  {
> -	struct qcom_adsp *adsp = (struct qcom_adsp *)rproc->priv;
> +	struct qcom_adsp *adsp = rproc->priv;
>  
>  	/*
>  	 * adsp_load() did pass pas_metadata to the SCM driver for storing
> @@ -203,7 +203,7 @@ static int adsp_unprepare(struct rproc *rproc)
>  
>  static int adsp_load(struct rproc *rproc, const struct firmware *fw)
>  {
> -	struct qcom_adsp *adsp = (struct qcom_adsp *)rproc->priv;
> +	struct qcom_adsp *adsp = rproc->priv;
>  	int ret;
>  
>  	/* Store firmware handle to be used in adsp_start() */
> @@ -244,7 +244,7 @@ static int adsp_load(struct rproc *rproc, const struct firmware *fw)
>  
>  static int adsp_start(struct rproc *rproc)
>  {
> -	struct qcom_adsp *adsp = (struct qcom_adsp *)rproc->priv;
> +	struct qcom_adsp *adsp = rproc->priv;
>  	int ret;
>  
>  	ret = qcom_q6v5_prepare(&adsp->q6v5);
> @@ -360,7 +360,7 @@ static void qcom_pas_handover(struct qcom_q6v5 *q6v5)
>  
>  static int adsp_stop(struct rproc *rproc)
>  {
> -	struct qcom_adsp *adsp = (struct qcom_adsp *)rproc->priv;
> +	struct qcom_adsp *adsp = rproc->priv;
>  	int handover;
>  	int ret;
>  
> @@ -390,7 +390,7 @@ static int adsp_stop(struct rproc *rproc)
>  
>  static void *adsp_da_to_va(struct rproc *rproc, u64 da, size_t len, bool *is_iomem)
>  {
> -	struct qcom_adsp *adsp = (struct qcom_adsp *)rproc->priv;
> +	struct qcom_adsp *adsp = rproc->priv;
>  	int offset;
>  
>  	offset = da - adsp->mem_reloc;
> @@ -405,7 +405,7 @@ static void *adsp_da_to_va(struct rproc *rproc, u64 da, size_t len, bool *is_iom
>  
>  static unsigned long adsp_panic(struct rproc *rproc)
>  {
> -	struct qcom_adsp *adsp = (struct qcom_adsp *)rproc->priv;
> +	struct qcom_adsp *adsp = rproc->priv;
>  
>  	return qcom_q6v5_panic(&adsp->q6v5);
>  }
> @@ -683,7 +683,7 @@ static int adsp_probe(struct platform_device *pdev)
>  	rproc->auto_boot = desc->auto_boot;
>  	rproc_coredump_set_elf_info(rproc, ELFCLASS32, EM_NONE);
>  
> -	adsp = (struct qcom_adsp *)rproc->priv;
> +	adsp = rproc->priv;
>  	adsp->dev = &pdev->dev;
>  	adsp->rproc = rproc;
>  	adsp->minidump_id = desc->minidump_id;
> diff --git a/drivers/remoteproc/qcom_wcnss.c b/drivers/remoteproc/qcom_wcnss.c
> index 9d4d04fff8c6..0fc317265064 100644
> --- a/drivers/remoteproc/qcom_wcnss.c
> +++ b/drivers/remoteproc/qcom_wcnss.c
> @@ -154,7 +154,7 @@ static const struct wcnss_data pronto_v3_data = {
>  
>  static int wcnss_load(struct rproc *rproc, const struct firmware *fw)
>  {
> -	struct qcom_wcnss *wcnss = (struct qcom_wcnss *)rproc->priv;
> +	struct qcom_wcnss *wcnss = rproc->priv;
>  	int ret;
>  
>  	ret = qcom_mdt_load(wcnss->dev, fw, rproc->firmware, WCNSS_PAS_ID,
> @@ -227,7 +227,7 @@ static void wcnss_configure_iris(struct qcom_wcnss *wcnss)
>  
>  static int wcnss_start(struct rproc *rproc)
>  {
> -	struct qcom_wcnss *wcnss = (struct qcom_wcnss *)rproc->priv;
> +	struct qcom_wcnss *wcnss = rproc->priv;
>  	int ret, i;
>  
>  	mutex_lock(&wcnss->iris_lock);
> @@ -293,7 +293,7 @@ static int wcnss_start(struct rproc *rproc)
>  
>  static int wcnss_stop(struct rproc *rproc)
>  {
> -	struct qcom_wcnss *wcnss = (struct qcom_wcnss *)rproc->priv;
> +	struct qcom_wcnss *wcnss = rproc->priv;
>  	int ret;
>  
>  	if (wcnss->state) {
> @@ -320,7 +320,7 @@ static int wcnss_stop(struct rproc *rproc)
>  
>  static void *wcnss_da_to_va(struct rproc *rproc, u64 da, size_t len, bool *is_iomem)
>  {
> -	struct qcom_wcnss *wcnss = (struct qcom_wcnss *)rproc->priv;
> +	struct qcom_wcnss *wcnss = rproc->priv;
>  	int offset;
>  
>  	offset = da - wcnss->mem_reloc;
> @@ -566,7 +566,7 @@ static int wcnss_probe(struct platform_device *pdev)
>  	}
>  	rproc_coredump_set_elf_info(rproc, ELFCLASS32, EM_NONE);
>  
> -	wcnss = (struct qcom_wcnss *)rproc->priv;
> +	wcnss = rproc->priv;
>  	wcnss->dev = &pdev->dev;
>  	wcnss->rproc = rproc;
>  	platform_set_drvdata(pdev, wcnss);
> diff --git a/drivers/remoteproc/xlnx_r5_remoteproc.c b/drivers/remoteproc/xlnx_r5_remoteproc.c
> index 2db57d394155..5dbc12bdc29e 100644
> --- a/drivers/remoteproc/xlnx_r5_remoteproc.c
> +++ b/drivers/remoteproc/xlnx_r5_remoteproc.c
> @@ -242,7 +242,7 @@ static int add_mem_regions_carveout(struct rproc *rproc)
>  	struct reserved_mem *rmem;
>  	int i, num_mem_regions;
>  
> -	r5_core = (struct zynqmp_r5_core *)rproc->priv;
> +	r5_core = rproc->priv;
>  	num_mem_regions = r5_core->rmem_count;
>  
>  	for (i = 0; i < num_mem_regions; i++) {
> @@ -363,7 +363,7 @@ static int add_tcm_carveout_split_mode(struct rproc *rproc)
>  	size_t bank_size;
>  	char *bank_name;
>  
> -	r5_core = (struct zynqmp_r5_core *)rproc->priv;
> +	r5_core = rproc->priv;
>  	dev = r5_core->dev;
>  	num_banks = r5_core->tcm_bank_count;
>  
> @@ -432,7 +432,7 @@ static int add_tcm_carveout_lockstep_mode(struct rproc *rproc)
>  	u32 pm_domain_id;
>  	char *bank_name;
>  
> -	r5_core = (struct zynqmp_r5_core *)rproc->priv;
> +	r5_core = rproc->priv;
>  	dev = r5_core->dev;
>  
>  	/* Go through zynqmp banks for r5 node */
> @@ -502,7 +502,7 @@ static int add_tcm_banks(struct rproc *rproc)
>  	struct zynqmp_r5_core *r5_core;
>  	struct device *dev;
>  
> -	r5_core = (struct zynqmp_r5_core *)rproc->priv;
> +	r5_core = rproc->priv;
>  	if (!r5_core)
>  		return -EINVAL;
>  
> @@ -595,7 +595,7 @@ static int zynqmp_r5_rproc_unprepare(struct rproc *rproc)
>  	u32 pm_domain_id;
>  	int i;
>  
> -	r5_core = (struct zynqmp_r5_core *)rproc->priv;
> +	r5_core = rproc->priv;
>  
>  	for (i = 0; i < r5_core->tcm_bank_count; i++) {
>  		pm_domain_id = r5_core->tcm_banks[i]->pm_domain_id;
> @@ -649,7 +649,7 @@ static struct zynqmp_r5_core *zynqmp_r5_add_rproc_core(struct device *cdev)
>  	}
>  
>  	r5_rproc->auto_boot = false;
> -	r5_core = (struct zynqmp_r5_core *)r5_rproc->priv;
> +	r5_core = r5_rproc->priv;
>  	r5_core->dev = cdev;
>  	r5_core->np = dev_of_node(cdev);
>  	if (!r5_core->np) {
> @@ -978,12 +978,12 @@ static int zynqmp_r5_cluster_init(struct zynqmp_r5_cluster *cluster)
>  
>  static void zynqmp_r5_cluster_exit(void *data)
>  {
> -	struct platform_device *pdev = (struct platform_device *)data;
> +	struct platform_device *pdev = data;
>  	struct zynqmp_r5_cluster *cluster;
>  	struct zynqmp_r5_core *r5_core;
>  	int i;
>  
> -	cluster = (struct zynqmp_r5_cluster *)platform_get_drvdata(pdev);
> +	cluster = platform_get_drvdata(pdev);
>  	if (!cluster)
>  		return;
>  
> -- 
> 2.11.0
> 
