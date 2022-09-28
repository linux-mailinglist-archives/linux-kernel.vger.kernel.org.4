Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0D6A5EE7E4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 23:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234466AbiI1VJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 17:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234847AbiI1VJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 17:09:25 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B34F686A
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 14:04:25 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id c30so17710626edn.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 14:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=q/GKAyyF0vF1eWzJ1k0yLeMrfcWHaRkvaCbw2GvKS5w=;
        b=H7SFjs+BVe498MJEl3L9bI5G5W+1u1h2GbtuS7vrhh7P+e05VpYrDNFWp68HOubH9d
         Q/oyVXSpZqMudYWJKw1hR0rNw0iU/7q9vtltmHL+XYsDz8mpYWkSmySMRSMtpwvbxnGd
         PfNzo+l5nF8WRGdAqhEKnszfJW55MkO8O4cw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=q/GKAyyF0vF1eWzJ1k0yLeMrfcWHaRkvaCbw2GvKS5w=;
        b=Uuzzj7fgovNKg5QgDK1oc3mmG66fxleTmfiK1q59MPe/cjdvAPd/uUs34wJvB5Trh3
         /U/AmmpPGmVHr7To/ELnSQdtciiFubNXJ0DNkGusIbQYkYVrkakO+mBraaHRbRmN7Y2V
         kiz8adMGqQAfQsna+0xgH3A4keeaO9BAJj/grqywpvZiSgEFma47RudVDwIOR9OCiN1j
         PZ7676drGFo3LFf1lwPxnXE7HUlCUihbQZbMIXheyVSTPnYUaLQ2NGtlyu9W5sRmrkkI
         Xc77YrQ6Ah8mmAif8B03brDsD9pHRrB363qtv2mudGjB5rEXpKXGrTeTU2F0Ko1chG4m
         YqFQ==
X-Gm-Message-State: ACrzQf2QB2nNlyaQw4Tiy/AL61S20ifcgmagX9nIw4XvVttFJsEf4JAs
        PhUxy5PJGDPFpDUC3TunWeejKhBcVP7RPo2/
X-Google-Smtp-Source: AMsMyM6H+65IMSV6OBRd/2kvqKjt5CskWXVP5fckYPp2i3EpxFsq2C8sot9m6DLq184AMwS7hu4mwg==
X-Received: by 2002:a05:6402:4402:b0:453:6a9:ef8a with SMTP id y2-20020a056402440200b0045306a9ef8amr34007987eda.85.1664399044770;
        Wed, 28 Sep 2022 14:04:04 -0700 (PDT)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id s3-20020a056402520300b00453d8dee355sm4093272edd.60.2022.09.28.14.04.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 14:04:04 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id x18so21613650wrm.7
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 14:04:04 -0700 (PDT)
X-Received: by 2002:a5d:522f:0:b0:228:dc7f:b9a8 with SMTP id
 i15-20020a5d522f000000b00228dc7fb9a8mr22712807wra.617.1664399043934; Wed, 28
 Sep 2022 14:04:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220927112343.2700216-1-sheng-liang.pan@quanta.corp-partner.google.com>
 <20220927192234.v4.1.Ide53082044aac56877c4ff5725777769e377476a@changeid>
In-Reply-To: <20220927192234.v4.1.Ide53082044aac56877c4ff5725777769e377476a@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 28 Sep 2022 14:03:52 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Uk8i+JMVEPthpuQj-rNJVzCXaYRrTW4td4hE1JfCDYbg@mail.gmail.com>
Message-ID: <CAD=FV=Uk8i+JMVEPthpuQj-rNJVzCXaYRrTW4td4hE1JfCDYbg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: arm: qcom: Separate LTE/WIFI SKU for sc7280-evoker
To:     Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Sep 27, 2022 at 4:25 AM Sheng-Liang Pan
<sheng-liang.pan@quanta.corp-partner.google.com> wrote:
>
> evoker will have WIFI/LTE SKU, separate it for each different setting.
>
> Signed-off-by: Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>
> ---
>
> Changes in v4:
> - fix typo in tittle and commit
>
>  Documentation/devicetree/bindings/arm/qcom.yaml | 5 +++++
>  1 file changed, 5 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
