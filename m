Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8070B65A6D7
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 21:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235860AbiLaUVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 15:21:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiLaUVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 15:21:35 -0500
Received: from m-r1.th.seeweb.it (m-r1.th.seeweb.it [5.144.164.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B4F60E8
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 12:21:34 -0800 (PST)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id E35671F71E;
        Sat, 31 Dec 2022 21:14:29 +0100 (CET)
Date:   Sat, 31 Dec 2022 21:14:27 +0100
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Adam Skladowski <a39.skl@gmail.com>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pinctrl: qcom: pinctrl-msm8976: Correct function names
 for wcss pins
Message-ID: <20221231201427.4zvubd4cqkaphayd@SoMainline.org>
Mail-Followup-To: Marijn Suijten <marijn.suijten@somainline.org>,
        Adam Skladowski <a39.skl@gmail.com> phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221231164250.74550-1-a39.skl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221231164250.74550-1-a39.skl@gmail.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-12-31 17:42:50, Adam Skladowski wrote:
> Adjust names of function for wcss pins, also fix third gpio in bt group.

Agreed, the wcss_wlan[210]_groups arrays and functions are unused prior
to this patch nor are pins 40/41/42 part of wcss_wlan_groups (which only
contains 43 and 44).  Same for the BT fix, the pingroup for pin 48 is
clearly wcss_bt and there's none for pin 88.

You could have made that more clear in the commit message though (and
I'm not even sure if pinctrl allows the pins to be used when the groups
are misaligned like this, at least there's a fixes: tag), but for the
change itself:

Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>

> Fixes: bcd11493f0ab ("pinctrl: qcom: Add a pinctrl driver for MSM8976 and 8956")
> Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
> ---
>  drivers/pinctrl/qcom/pinctrl-msm8976.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-msm8976.c b/drivers/pinctrl/qcom/pinctrl-msm8976.c
> index ec43edf9b660..e11d84584719 100644
> --- a/drivers/pinctrl/qcom/pinctrl-msm8976.c
> +++ b/drivers/pinctrl/qcom/pinctrl-msm8976.c
> @@ -733,7 +733,7 @@ static const char * const codec_int2_groups[] = {
>  	"gpio74",
>  };
>  static const char * const wcss_bt_groups[] = {
> -	"gpio39", "gpio47", "gpio88",
> +	"gpio39", "gpio47", "gpio48",
>  };
>  static const char * const sdc3_groups[] = {
>  	"gpio39", "gpio40", "gpio41",
> @@ -958,9 +958,9 @@ static const struct msm_pingroup msm8976_groups[] = {
>  	PINGROUP(37, NA, NA, NA, qdss_tracedata_b, NA, NA, NA, NA, NA),
>  	PINGROUP(38, NA, NA, NA, NA, NA, NA, NA, qdss_tracedata_b, NA),
>  	PINGROUP(39, wcss_bt, sdc3, NA, qdss_tracedata_a, NA, NA, NA, NA, NA),
> -	PINGROUP(40, wcss_wlan, sdc3, NA, qdss_tracedata_a, NA, NA, NA, NA, NA),
> -	PINGROUP(41, wcss_wlan, sdc3, NA, qdss_tracedata_a, NA, NA, NA, NA, NA),
> -	PINGROUP(42, wcss_wlan, sdc3, NA, qdss_tracedata_a, NA, NA, NA, NA, NA),
> +	PINGROUP(40, wcss_wlan2, sdc3, NA, qdss_tracedata_a, NA, NA, NA, NA, NA),
> +	PINGROUP(41, wcss_wlan1, sdc3, NA, qdss_tracedata_a, NA, NA, NA, NA, NA),
> +	PINGROUP(42, wcss_wlan0, sdc3, NA, qdss_tracedata_a, NA, NA, NA, NA, NA),
>  	PINGROUP(43, wcss_wlan, sdc3, NA, NA, qdss_tracedata_a, NA, NA, NA, NA),
>  	PINGROUP(44, wcss_wlan, sdc3, NA, NA, NA, NA, NA, NA, NA),
>  	PINGROUP(45, wcss_fm, NA, qdss_tracectl_a, NA, NA, NA, NA, NA, NA),
> -- 
> 2.25.1
> 
