Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D15DB674274
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 20:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjASTMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 14:12:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbjASTLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 14:11:42 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B157C9B105
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 11:11:01 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id bk15so8218757ejb.9
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 11:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5DgmdxISYxAGF0PfZ9BcThxW09Vbi+MCyPhr6BazLtw=;
        b=dF8f7+PhLfU04sVIxxubHrCV5k3rKFiQPk/NlLGGZjXyAhv59R5ETnUwaQSVV6o5oq
         LLCqFaMNdZ4DUMCLO81WV675QdK6ZpZYVTRtAdaHe/3bIItQGayb3kW3vnY4MmSBq9CB
         hXbQ/cZrxPcXxwM5i/SjMTGaY3kRebVG086IZp7fjtiXc+FBAjOQN8Y0K7nngY1hr8dP
         bCltMfxrQ5U2GcnTVKss5uS7PrfUaeBttESr6oHzodTXO6Q9sdlpbp9aUzIP893zxEsi
         NClVFM/dzDrrxhhOiFRuEpqhM+E8592P0yWU6NGiLy8CECmyOGrfakA4ev+LuV6mMYM1
         1/2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5DgmdxISYxAGF0PfZ9BcThxW09Vbi+MCyPhr6BazLtw=;
        b=h3HSk+zZbL417qGyFmVZKPnahKKN7+j4gHW1Yshcn3FEATBWTwWPy0Sxbyi2NV24Td
         +VkJjtS5aimpFw1WyEwiaZulw/EgiMBzvKSEFdPYn1RKjDLotWJ93gbq9QYJki7bx6f5
         JXZWY2h9NQawvVifo7RNKB2xlqqJi7fAY0/NsoOHMdT2mKOt6ner+1gJTCOwCOawoQ8t
         OO6pw8sFAcFoVlCIjg9mqrDonyoHZngPoqWcOz9urxSTPzM4mb2tpB4giUzml0g7mTVz
         XMXmhzCequE9Stlqw8qpojSP0aAwFrh7Jy0JZbqM7wAPf4xwi9QLvoON0U6fGIbNaIii
         HPrw==
X-Gm-Message-State: AFqh2krhU7niVpH9jvwh4Af55U1IWI2YHDMSriY+ewMkRrq8ZhZweKJ/
        wXvpigW/gi0scsCDPz/uQiqqzQ==
X-Google-Smtp-Source: AMrXdXv9JqeohpG7e780c+S2XWGSDjRglnr6mSNdrJpNsLuGu/s9a2hyjayxnK0PpkQB3Nq/m/u6dA==
X-Received: by 2002:a17:907:c019:b0:867:ef3f:dd85 with SMTP id ss25-20020a170907c01900b00867ef3fdd85mr9077419ejc.56.1674155407507;
        Thu, 19 Jan 2023 11:10:07 -0800 (PST)
Received: from [192.168.1.101] (abyk37.neoplus.adsl.tpnet.pl. [83.9.30.37])
        by smtp.gmail.com with ESMTPSA id d14-20020a170906304e00b0077077c62cadsm16677521ejd.31.2023.01.19.11.10.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 11:10:06 -0800 (PST)
Message-ID: <fc97247a-300f-dc46-aaa4-932259702136@linaro.org>
Date:   Thu, 19 Jan 2023 20:10:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 1/2] clk: qcom: smd: Add XO RPM clocks for
 MSM8226/MSM8974
Content-Language: en-US
To:     Rayyan Ansari <rayyan@ansari.sh>, linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230119190534.317041-1-rayyan@ansari.sh>
 <20230119190534.317041-2-rayyan@ansari.sh>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230119190534.317041-2-rayyan@ansari.sh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19.01.2023 20:05, Rayyan Ansari wrote:
> Add the XO and XO_A clocks to the MSM8974 clock list, which is also
> used on MSM8226.
> 
> Signed-off-by: Rayyan Ansari <rayyan@ansari.sh>
> ---
>  drivers/clk/qcom/clk-smd-rpm.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/clk/qcom/clk-smd-rpm.c b/drivers/clk/qcom/clk-smd-rpm.c
> index fea505876855..42ea3bb37f63 100644
> --- a/drivers/clk/qcom/clk-smd-rpm.c
> +++ b/drivers/clk/qcom/clk-smd-rpm.c
> @@ -549,6 +549,8 @@ DEFINE_CLK_SMD_RPM_XO_BUFFER_PINCTRL(msm8974, cxo_a1_pin, cxo_a1_a_pin, 5, 19200
>  DEFINE_CLK_SMD_RPM_XO_BUFFER_PINCTRL(msm8974, cxo_a2_pin, cxo_a2_a_pin, 6, 19200000);
>  
>  static struct clk_smd_rpm *msm8974_clks[] = {
> +	[RPM_SMD_XO_CLK_SRC] 		= &sdm660_bi_tcxo,
> +	[RPM_SMD_XO_A_CLK_SRC] 		= &sdm660_bi_tcxo_a,
I think that's gonna conflict with Dmitry's recent cleanup..

Konrad
>  	[RPM_SMD_PNOC_CLK]		= &msm8916_pcnoc_clk,
>  	[RPM_SMD_PNOC_A_CLK]		= &msm8916_pcnoc_a_clk,
>  	[RPM_SMD_SNOC_CLK]		= &msm8916_snoc_clk,
