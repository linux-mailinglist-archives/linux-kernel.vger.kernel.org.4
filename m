Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A87065FCC49
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 22:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbiJLUol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 16:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiJLUoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 16:44:25 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B2B7FFF98
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 13:44:22 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id g1so27437000lfu.12
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 13:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C+C0Mxv2tX523uCK05eKZPxUZ5oE4e3IyCVHLYGN5SI=;
        b=uvNDbWbG5eSo8weiIPDDLGWl8An4BMkTYO8SF7yC+yGjExdt81T37ieOfK+IDhI76d
         FqreDaEtg524sTKjC5lkpsWNNx0IlE+xv9xOZ0RkZx1FKjpP+4I15YgSZXadvR+/ryQk
         wCL3N1EI28kqJ6qJS+diwz1RwBORJrMX/EuWvdSnn/5kRs/BrxOgwN8l6h+486bpZTNz
         u0a2eZNigxL+OtWtlWMvQR6oIGMZuGwCuW4tZciVSsYskj1CQ8ywvoT2mA+EF8yaN8lm
         UIze/0FoQ+jh5NuSBrsDXDC4EOUcc3PiCtgH2Ycd5qy574j4mVE+UBMqJkYowJglYOhY
         d8xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C+C0Mxv2tX523uCK05eKZPxUZ5oE4e3IyCVHLYGN5SI=;
        b=xixxg6LXWVYfWQ9EDQsoOAevp10dgbk9vUzul/SryNeV9iB7TuQqWuCjMVcAkXeUKC
         xO6Gxlwyis+WmHIl5Z5uxD1oM+niHsyhiGVfQ4YRb75BF7vJlo5mrzjdp5G+dEMPXKxm
         1qpR3SV+1t9NB51z3vL1KJLYTqu5iFU6x3CUhxJdMlwO1AAo+6b43VI0ql2QwDtwiW28
         R0qwHzNk2Fjy99HP8qsm4ohll8BjGS8oA9aUk9vr3F+igyjH/VKpLSoN6Xnl1gz+WwZb
         dT76nnhem9VAlmAXvFeOrlv+u4W6zanqQL9JVbTxfxrH4lNCUVwPER8LKDNVQvzhDm2H
         w96A==
X-Gm-Message-State: ACrzQf1EU7Bkck0yEDDBKqiz6KmY1To9200HggINiqkE42J4TO+4B3ju
        eOg+8EOFTJoyGqg6eo0X2G3Axw==
X-Google-Smtp-Source: AMsMyM6hBJPbIlXaMhcnTghNSdmHcOfNis3jxOSvhveulPVBL8W/p5rpNKObX5xbxRTdurBq5KrwmQ==
X-Received: by 2002:a05:6512:2392:b0:4a2:550a:e21d with SMTP id c18-20020a056512239200b004a2550ae21dmr11490183lfv.550.1665607460721;
        Wed, 12 Oct 2022 13:44:20 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id d23-20020a056512369700b0049fbf5facf4sm103561lfs.75.2022.10.12.13.44.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Oct 2022 13:44:20 -0700 (PDT)
Message-ID: <996cf5ca-fb54-a69b-f107-13571b6530e7@linaro.org>
Date:   Wed, 12 Oct 2022 23:44:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 01/20] phy: qcom-qmp-pcie: fix sc8180x initialisation
Content-Language: en-GB
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20221012084846.24003-1-johan+linaro@kernel.org>
 <20221012085002.24099-1-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221012085002.24099-1-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/2022 11:49, Johan Hovold wrote:
> The phy_status mask was never set for SC8180X which meant that the
> driver would not wait for the PHY to be initialised during power-on and
> would never detect PHY initialisation timeouts.
> 
> Fixes: f839f14e24f2 ("phy: qcom-qmp: Add sc8180x PCIe support")
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

