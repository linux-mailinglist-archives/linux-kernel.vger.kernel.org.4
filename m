Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C364E61FD2A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 19:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233048AbiKGSRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 13:17:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232897AbiKGSQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 13:16:46 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A2A25E98
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 10:15:36 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id sc25so32308610ejc.12
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 10:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7pmt2HngsIty5fjoD5/n01C+C3m5PcZ1nRjgP9AEiKY=;
        b=H6Pt1iEIO9Je8Lj5yki7ij1JghQLmX72gIhqHI+1jUaHVV13J3SINQWIVw3YubeLVp
         C+nZadw2za/hQ+csoF5oGR5WOqHGIUMFOx+YyEPuKWNjq0C9+DVkJEnyOUGereMCx0nO
         F/S8mlzyMxtnsWh3TP8OuxFgLAOtKuNRf5lHc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7pmt2HngsIty5fjoD5/n01C+C3m5PcZ1nRjgP9AEiKY=;
        b=ptRr3smKOJ9rI5Q68bZhMTOqHFp68vBesWjuhC1IxukY0OXZ6tYS1QOPS6HvhmMr14
         s2qRHRhHfbKQqs7yzkiIBBx1LoqKS+IbyZrk3M3F1NuX3y+0xf6wdlU/KA+wFtWgW93A
         6kBmD/evZ5QG0DVXcXYsCe/+iyF9ZB4O9htnM2mpF94kxDe88V59yj7mewdY1lBI3DvK
         eAgtzBG1Sq7gzEt0NC9Tc1oJHi0fFAqC9PCAqcOH3/49RLm7J4OpkWxQaqggd3daRPm+
         L0562A+SWB+FBQ2XejzZ6Bqsid9bUWyBwoWaabseG3B2gh8KvSOSTCshBJtSGbi3R51z
         ldew==
X-Gm-Message-State: ACrzQf2ubOQJLqpseSFu3fr+2v5T8EcL0To53TWC4iUXFHdrXOsOk37H
        7ozMd930sgPq06vs+iyRPamxRTZlMsT2AyrC
X-Google-Smtp-Source: AMsMyM5tG3AcWkSnZN9EnPTEX3qKX2qdYexIfJj/MkdgeSjVn0D4jDp9MO6xKEiJTp3t/EcH+skrPg==
X-Received: by 2002:a17:906:4c4b:b0:7ad:a197:b58e with SMTP id d11-20020a1709064c4b00b007ada197b58emr50104591ejw.203.1667844934314;
        Mon, 07 Nov 2022 10:15:34 -0800 (PST)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id m19-20020a056402051300b00459cd13fd34sm4451868edv.85.2022.11.07.10.15.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 10:15:33 -0800 (PST)
Received: by mail-wm1-f52.google.com with SMTP id t4so7384798wmj.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 10:15:33 -0800 (PST)
X-Received: by 2002:a05:600c:4486:b0:3cf:6e1d:f4a5 with SMTP id
 e6-20020a05600c448600b003cf6e1df4a5mr31342979wmo.85.1667844932555; Mon, 07
 Nov 2022 10:15:32 -0800 (PST)
MIME-Version: 1.0
References: <20221107094345.2838931-1-sheng-liang.pan@quanta.corp-partner.google.com>
 <20221107173954.v11.4.I9718ac3622fa550e432209ae5c95c87b873a0f87@changeid>
In-Reply-To: <20221107173954.v11.4.I9718ac3622fa550e432209ae5c95c87b873a0f87@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 7 Nov 2022 10:15:21 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Uc78wH9A1bev4L=-kje00RNu-AQu87zLK6Sx4AdxDe8A@mail.gmail.com>
Message-ID: <CAD=FV=Uc78wH9A1bev4L=-kje00RNu-AQu87zLK6Sx4AdxDe8A@mail.gmail.com>
Subject: Re: [PATCH v11 4/5] arm64: dts: qcom: sc7280: add sc7280-herobrine-audio-rt5682-3mic3.dtsi
 for evoker
To:     Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Nov 7, 2022 at 1:45 AM Sheng-Liang Pan
<sheng-liang.pan@quanta.corp-partner.google.com> wrote:
>
> +&lpass_va_macro {
> +       vdd-micb-supply = <&pp1800_l2c>;
> +       pinctrl-0 = <&lpass_dmic01_clk>, <&lpass_dmic01_data>, <&lpass_dmic23_clk>,
> +                       <&lpass_dmic23_data>;
> +
> +       status = "okay";
> +};
> +
> +/* PINCTRL - ADDITIONS TO NODES IN PARENT DEVICE TREE FILES */
> +
> +&lpass_dmic01_clk {
> +       drive-strength = <8>;
> +       bias-disable;
> +};
> +
> +&lpass_dmic01_clk_sleep {
> +       drive-strength = <2>;
> +};

All of these "sleep" pinctrl states don't actually do anything useful
because (currently) nobody refers to them. Off-list I've asked
Srinivasa (now CCed here) to address this and I think it's fine for
you to have them here for now and then we can use or remove them all
at once.

In any case, this patch looks good to me now, thanks!

Reviewed-by: Douglas Anderson <dianders@chromium.org>
