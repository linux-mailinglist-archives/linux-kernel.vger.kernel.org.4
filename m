Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84567730202
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 16:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245436AbjFNObc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 10:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245618AbjFNOb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 10:31:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F99E2702;
        Wed, 14 Jun 2023 07:30:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F407963DC9;
        Wed, 14 Jun 2023 14:30:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCA72C433C0;
        Wed, 14 Jun 2023 14:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686753048;
        bh=VtJq4UGcfl5mcVRLdauP9VIH6vKJDyyGyjdEx2UHTQw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XRvFwTX7GQ8NsNbAkO7iS4yREoL7M1X0b/YYiTIuRofnkm4q2Zu01DX5F7PPHqcB8
         h9R+T1beRarpJUe51ikfbnvqEoRNR+7vlopp3gXfQ1TkFc1cSlktYpTufNwJanFwkI
         bavI7yD2RfsLWyn35wucqnnlIzbhIyhz4V2tuifcGo1blh3/Nu9MVJHUq/ly0U/mGI
         mahpvggisUWHDkL7eaTnAr8GfeTGoSAYZKlgrIzYVSVa7/fIGIZ7fkhyYozHwb7tSg
         AjMrB2+3dgPhB5unmT8vbyXSR9VtHT3QubYHXrsxTRr/lLIDQ/qx+WTLoLxALBlj3w
         83PQfxT/9NaOw==
Date:   Wed, 14 Jun 2023 07:34:10 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v2] soc: qcom: icc-bwmon: Set default thresholds
 dynamically
Message-ID: <20230614143410.fogdqnpygu7ng5jc@ripper>
References: <20230610-topic-bwmon_opp-v2-1-0d25c1ce7dca@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230610-topic-bwmon_opp-v2-1-0d25c1ce7dca@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 03:39:59PM +0200, Konrad Dybcio wrote:
> Currently we use predefined initial threshold values. This works, but
> does not really scale well with more and more SoCs gaining bwmon support,
> as the necessary kickoff values may differ between platforms due to memory
> type and/or controller setup.
> All of the data we need for that is already provided in the device tree,
> anyway.
> 
> Change the thresholds to:
> * low = 0 (as we've been doing up until now)
> * med = high = BW_MIN
> 
> Throughput going below the med threshold nudges bwmon into signaling
> that we should slow down (e.g. if we inherited too high bandwidth
> from the bootloader).
> 
> Throughput going above the high threshold nudges bwmon into signaling
> that we should speed up so as not to choke the bus traffic due to
> insufficient transfer rates.
> 
> F_MIN is a perfect initial value for both of these cases - if we go
> above it (and there's a 99.99% chance it'll happen at boot time), we
> should definitely make the memory go faster, whereas if we go below it,
> we should slow down, no matter what performance state we were at before
> (it's only possible for them to be >= FMIN).
> 
> This only changes the values programmed at probe time, as high and med
> thresholds are updated at interrupt, also based on the OPP table from DT.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn

> ---
> Changes in v2:
> - Drop now-merged dependency
> - Drop div4 for the med value
> - Better explain the reasoning in the commit message
> - Link to v1: https://lore.kernel.org/r/20230610-topic-bwmon_opp-v1-1-65125d7493fc@linaro.org
> ---
>  drivers/soc/qcom/icc-bwmon.c | 28 +++++++---------------------
>  1 file changed, 7 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/soc/qcom/icc-bwmon.c b/drivers/soc/qcom/icc-bwmon.c
> index 40068a285913..8daf0eb03279 100644
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
> +	bwmon_set_threshold(bwmon, bwmon->regs[F_THRESHOLD_MED], bw_low);
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
> base-commit: b16049b21162bb649cdd8519642a35972b7910fe
> change-id: 20230610-topic-bwmon_opp-f995bbdd18bd
> 
> Best regards,
> -- 
> Konrad Dybcio <konrad.dybcio@linaro.org>
> 
