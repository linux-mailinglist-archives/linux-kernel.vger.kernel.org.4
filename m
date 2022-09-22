Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 204F85E687E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 18:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbiIVQd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 12:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbiIVQdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 12:33:24 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719CD4454E
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 09:33:22 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id q21so14381703edc.9
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 09:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=hHrtnzL79eYFEPjEF2yi096AMyC1QbuWRhmXoAyygq8=;
        b=E62MrqC3zOFBmFTKp4oTrZM/z66KQ4CtKhMc2j6L40FWedjqY5X2kE0XK83hQj29ua
         E0ImPDNsXVMBpE45yGGoqoYfZBi5TXdevSXameDBsxFPmEN/dxbtcS0uKjMwnI2sjHNs
         nODz6eNmWN6bpNR1mbiggJufeDZtbZba0MrfI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=hHrtnzL79eYFEPjEF2yi096AMyC1QbuWRhmXoAyygq8=;
        b=4CebgLr7AyOLeCPye/FhNuoGSG5dQA9+PkyNWsA20OfjdM08CcHt/1mwyf7nbnIQM/
         0kim55ydLv31sRDwZrwROhlkaXowbucmOHoUE1haaRL6qq4bq92UjJuDGnB6kkH0Vx7Y
         D+gFiGJB9vqtPyGWtmN5artMpkKKTX9X9x4vSDRzPcYx8DZLs7yvfO5410C7/TRlNnSJ
         M4ha08LBL42vQSdcXizj/XQ2CXHO0JaKbc338ZpuuzzhGf1xLL+GEMDuAGlvcdoJbBJ7
         FakHVwMvewJ7WIAxOA3hvb4KfYlwZTc8cl8fS70sta7jSD37SZC53/I3T1YtTkyQu+P+
         9mMg==
X-Gm-Message-State: ACrzQf1fhVo/dE3IC+0GzhEHclcEbnpH8e8d5DGyJfY1ykDYL18mox3f
        Lcb4Mf3RwdMVBTzBsuwqY07ZUd0G0zcBKnJN
X-Google-Smtp-Source: AMsMyM4u8N/JGGd8wIWm8QiO9kfbC4Mp20AdWY4aDD0sUkna/fkaUiQKyHVx1Wtonf/Fo3Rkr2NO4g==
X-Received: by 2002:a05:6402:e01:b0:442:dd7e:f49d with SMTP id h1-20020a0564020e0100b00442dd7ef49dmr4220388edh.355.1663864400725;
        Thu, 22 Sep 2022 09:33:20 -0700 (PDT)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com. [209.85.128.49])
        by smtp.gmail.com with ESMTPSA id v15-20020a50d58f000000b0044eb5b922bdsm3987251edi.24.2022.09.22.09.33.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 09:33:18 -0700 (PDT)
Received: by mail-wm1-f49.google.com with SMTP id r133-20020a1c448b000000b003b494ffc00bso1724804wma.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 09:33:18 -0700 (PDT)
X-Received: by 2002:a05:600c:5488:b0:3b5:634:731 with SMTP id
 iv8-20020a05600c548800b003b506340731mr1759364wmb.188.1663864397810; Thu, 22
 Sep 2022 09:33:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220922101813.v4.1.I3aa360986c0e7377ea5e96c116f014ff1ab8c968@changeid>
In-Reply-To: <20220922101813.v4.1.I3aa360986c0e7377ea5e96c116f014ff1ab8c968@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 22 Sep 2022 09:33:05 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XWhf2nfs-+5JhTjWxwUUmvfPkO8VwBi=d9SM8Zr+Pq=A@mail.gmail.com>
Message-ID: <CAD=FV=XWhf2nfs-+5JhTjWxwUUmvfPkO8VwBi=d9SM8Zr+Pq=A@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] dt-bindings: arm: qcom: Document additional skus
 for sc7180 pazquel360
To:     Yunlong Jia <ecs.beijing2022@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Yunlong Jia <yunlong.jia@ecs.com.tw>,
        Henry Sun <henrysun@google.com>,
        Bob Moragues <moragues@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
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

On Thu, Sep 22, 2022 at 3:21 AM Yunlong Jia <ecs.beijing2022@gmail.com> wrote:
>
> pazquel360 is an extension project based on pazquel.
> We create 3 sku on pazquel360:
>    sku 20 for LTE with physical SIM _and_ eSIM and WiFi
>    sku 21 for WiFi only
>    sku 22 for LTE with only a physical SIM
>  Both sku20 and sku22 are LTE SKUs.
>  One has the eSIM stuffed and one doesn't.
>  There is a single shared device tree for the two.
>
> Signed-off-by: Yunlong Jia <ecs.beijing2022@gmail.com>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>
> ---
>
> Changes in v4:
>  1. Adjust the 'Signed-off-by'.
>
> Changes in v3:
>  1. Adjust the format of the changelog.
>
>  Documentation/devicetree/bindings/arm/qcom.yaml | 11 +++++++++++
>  1 file changed, 11 insertions(+)

You should have carried the Ack that you had on v3 [1]. Please send a
v5 with that fixed. AKA:

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[1] https://lore.kernel.org/r/20220901024827.v3.1.I3aa360986c0e7377ea5e96c116f014ff1ab8c968@changeid/
