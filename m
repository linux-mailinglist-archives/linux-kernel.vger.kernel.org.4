Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E386B72AFF1
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 03:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjFKBmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 21:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjFKBmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 21:42:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C51F9;
        Sat, 10 Jun 2023 18:42:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7ACA060C64;
        Sun, 11 Jun 2023 01:42:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F60DC433EF;
        Sun, 11 Jun 2023 01:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686447719;
        bh=yBR0w/7klBnAZNSh3fgyCef+xkrLcYecwAJ698mVcZo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tWJhaU6BqowAugNqJBIlaD92oSLJXs/6tS/3XlGdl7/rqsiWYkwq080nNEsKyqwod
         UkA2Zjq+6kuYZh+xiEULfSM55GnkdTH0c4RnGZsoznFLBHHlDL5RFsi7L2jFq1EP4C
         KMrzNt0hq7H8ZBSgTbuXh1rr0725pTPn19gmyxjZVTbI+ydTRocQST+Nr2M42XXhQj
         0yQTtGNjCtVsK/EJqVTqib7qBUpr25OolxdqaLAPwZVjW65Qg88OxnNwT5X9Ctcjca
         OeayPH2itrzd2g4C2Q35n3bn3QQzhaW6id6W9nqRe5bctJW7Cympwmd7lMZohAqUcc
         SisGaYZAmyG0w==
Date:   Sat, 10 Jun 2023 18:45:27 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] soc: qcom: icc-bwmon: Set default thresholds
 dynamically
Message-ID: <20230611014527.ezkgvtac5akrprdg@ripper>
References: <20230610-topic-bwmon_opp-v1-1-65125d7493fc@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230610-topic-bwmon_opp-v1-1-65125d7493fc@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 10, 2023 at 02:01:53PM +0200, Konrad Dybcio wrote:
> Currently we use predefined threshold values. This works, but does not
> really scale well, as they may differ between SoCs due to LPDDR generation
> and/or DDR controller setup. All of the data we need for that is already
> provided in the device tree, anyway.
> 

Per your own argument, the replaced values are just initial values and
you should fairly quickly get some interrupt to start moving the
threshold up or down. I don't think your argumentation expresses
adequately why this "does not really scale well" and why your new values
happens to work better.

> Change that to:
> * 0 for low (as we've been doing up until now)
> * BW_MIN/4 for mid
> * BW_MIN for high
> 
> The mid value is chosen for a "low enough" bw to nudge bwmon into
> slowing down if the bw starts too high from the bootloader.
> 

As soon as we get the first interrupt, these values would be adjusted to
the bandwidth of the surrounding opp pair. So why is the /4 needed in
this initial state?

> The high value corresponds to the upper barrier which - when crossed -
> raises an interrupt in the third zone, signaling a need for upping
> the bw.
> 
> This only changes the values programmed at probe time, as high and med
> thresholds are updated at interrupt, based on the OPP table from DT.
> 

Your underlying reasoning, to remove the hard coded initial values,
sounds very reasonable to me.

Regards,
Bjorn

> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/soc/qcom/icc-bwmon.c | 28 +++++++---------------------
>  1 file changed, 7 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/soc/qcom/icc-bwmon.c b/drivers/soc/qcom/icc-bwmon.c
> index 40068a285913..99cbdb3cf531 100644
> --- a/drivers/soc/qcom/icc-bwmon.c
> +++ b/drivers/soc/qcom/icc-bwmon.c
> @@ -165,9 +165,6 @@ enum bwmon_fields {
>  struct icc_bwmon_data {
>  	unsigned int sample_ms;
>  	unsigned int count_unit_kb; /* kbytes */
> -	unsigned int default_highbw_kbps;
> -	unsigned int default_medbw_kbps;
> -	unsigned int default_lowbw_kbps;
>  	u8 zone1_thres_count;
>  	u8 zone3_thres_count;
>  	unsigned int quirks;
> @@ -564,20 +561,21 @@ static void bwmon_set_threshold(struct icc_bwmon *bwmon,
>  static void bwmon_start(struct icc_bwmon *bwmon)
>  {
>  	const struct icc_bwmon_data *data = bwmon->data;
> +	u32 bw_low = 0;
>  	int window;
>  
> +	/* No need to check for errors, as this must have succeeded before. */
> +	dev_pm_opp_find_bw_ceil(bwmon->dev, &bw_low, 0);
> +
>  	bwmon_clear_counters(bwmon, true);
>  
>  	window = mult_frac(bwmon->data->sample_ms, HW_TIMER_HZ, MSEC_PER_SEC);
>  	/* Maximum sampling window: 0xffffff for v4 and 0xfffff for v5 */
>  	regmap_field_write(bwmon->regs[F_SAMPLE_WINDOW], window);
>  
> -	bwmon_set_threshold(bwmon, bwmon->regs[F_THRESHOLD_HIGH],
> -			    data->default_highbw_kbps);
> -	bwmon_set_threshold(bwmon, bwmon->regs[F_THRESHOLD_MED],
> -			    data->default_medbw_kbps);
> -	bwmon_set_threshold(bwmon, bwmon->regs[F_THRESHOLD_LOW],
> -			    data->default_lowbw_kbps);
> +	bwmon_set_threshold(bwmon, bwmon->regs[F_THRESHOLD_HIGH], bw_low);
> +	bwmon_set_threshold(bwmon, bwmon->regs[F_THRESHOLD_MED], div_u64(bw_low, 4));
> +	bwmon_set_threshold(bwmon, bwmon->regs[F_THRESHOLD_LOW], 0);
>  
>  	regmap_field_write(bwmon->regs[F_THRESHOLD_COUNT_ZONE0],
>  			   BWMON_THRESHOLD_COUNT_ZONE0_DEFAULT);
> @@ -807,9 +805,6 @@ static int bwmon_remove(struct platform_device *pdev)
>  static const struct icc_bwmon_data msm8998_bwmon_data = {
>  	.sample_ms = 4,
>  	.count_unit_kb = 1024,
> -	.default_highbw_kbps = 4800 * 1024, /* 4.8 GBps */
> -	.default_medbw_kbps = 512 * 1024, /* 512 MBps */
> -	.default_lowbw_kbps = 0,
>  	.zone1_thres_count = 16,
>  	.zone3_thres_count = 1,
>  	.quirks = BWMON_HAS_GLOBAL_IRQ,
> @@ -822,9 +817,6 @@ static const struct icc_bwmon_data msm8998_bwmon_data = {
>  static const struct icc_bwmon_data sdm845_cpu_bwmon_data = {
>  	.sample_ms = 4,
>  	.count_unit_kb = 64,
> -	.default_highbw_kbps = 4800 * 1024, /* 4.8 GBps */
> -	.default_medbw_kbps = 512 * 1024, /* 512 MBps */
> -	.default_lowbw_kbps = 0,
>  	.zone1_thres_count = 16,
>  	.zone3_thres_count = 1,
>  	.quirks = BWMON_HAS_GLOBAL_IRQ,
> @@ -835,9 +827,6 @@ static const struct icc_bwmon_data sdm845_cpu_bwmon_data = {
>  static const struct icc_bwmon_data sdm845_llcc_bwmon_data = {
>  	.sample_ms = 4,
>  	.count_unit_kb = 1024,
> -	.default_highbw_kbps = 800 * 1024, /* 800 MBps */
> -	.default_medbw_kbps = 256 * 1024, /* 256 MBps */
> -	.default_lowbw_kbps = 0,
>  	.zone1_thres_count = 16,
>  	.zone3_thres_count = 1,
>  	.regmap_fields = sdm845_llcc_bwmon_reg_fields,
> @@ -847,9 +836,6 @@ static const struct icc_bwmon_data sdm845_llcc_bwmon_data = {
>  static const struct icc_bwmon_data sc7280_llcc_bwmon_data = {
>  	.sample_ms = 4,
>  	.count_unit_kb = 64,
> -	.default_highbw_kbps = 800 * 1024, /* 800 MBps */
> -	.default_medbw_kbps = 256 * 1024, /* 256 MBps */
> -	.default_lowbw_kbps = 0,
>  	.zone1_thres_count = 16,
>  	.zone3_thres_count = 1,
>  	.quirks = BWMON_NEEDS_FORCE_CLEAR,
> 
> ---
> base-commit: 49dd846128d56199db2e3bcfca42d87fbc82b212
> change-id: 20230610-topic-bwmon_opp-f995bbdd18bd
> 
> Best regards,
> -- 
> Konrad Dybcio <konrad.dybcio@linaro.org>
> 
