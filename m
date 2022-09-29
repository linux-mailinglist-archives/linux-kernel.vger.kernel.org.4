Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B56EE5EF312
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 12:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235299AbiI2KJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 06:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234515AbiI2KJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 06:09:43 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA64663B4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 03:09:34 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-352ffac3941so9445487b3.6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 03:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=L4CXyRkfDdqPzt4BDFbLVWgyf8dxhN++1/fR935b4BQ=;
        b=wsISCwsZ0H8bKDjajGftebLWZNGGdoT9cLT63qtRubzwDoqQUAtgoYSNb1CNeAc4bW
         IM5SjCraUo6yCElCeuqfKdy6UZmhq7aAZeIPu2b6UEpaMW5UdG5gtHU9nBaCY+nLRuzU
         bWFhs43Q3lKzkRqa9mIm8xZiz6Aq/WL2w+uiue24kCbrZXyA+CIrbwVBMo5CAdBg6OkX
         11IgAsinAl7IUR0l/p1B8xpMZMkOa4rE+w5laUij9hdRFEEfUVl/dxBLsg7jBc97rt9M
         x++H04UOxn5rw65+XTGFrVohnQrEM5vme6wrGOZg7TjPZd3t9S1f6TOflh1o/e7aMPkw
         VfMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=L4CXyRkfDdqPzt4BDFbLVWgyf8dxhN++1/fR935b4BQ=;
        b=OMMbvM5Ue8+tJla4wdfYXVJPUqCUKMIDa5N3IoDrEnfA9hrFDXPPOKt1a0M/buiHYk
         W6/Kteoyoo7nBoDpj2R5OHyl2n6k1a4cf+0ONQop+rZR7tgEHfGhxRaKOHYhoRuJ9naU
         Pl+nv/IBM0F+ZuoJ3WfhZPVYBqIXdZmTv8j3Ac3J3FG4MDnl2mC85DKjwwiDmQ4pmG3t
         NIj/haM3npmcmMuiolSe1gM9k9Mpsht7fAn1hkBtR7r/C5RP586Htk5MTmRQFglrXx1R
         1caaNswQMo7RIkaL/7fWGGuqog1KLQyEVU2zagzyy1uRWSg1v01xpkIRAqGGW30tf6qz
         l0mQ==
X-Gm-Message-State: ACrzQf3d8Ea/r7zNUa32i5zi/X9cjpQATVfZ3iVzslX9nZbrZwbITLWB
        FrTbUAG3mx+T8lgwYDQj8OKBIoXuLtVkHU6Mnen5JmaQaBgaoA==
X-Google-Smtp-Source: AMsMyM5Vk0BM+zVXvmz4Nb+GXJ9MIX2/6TtCfL1z6+EU/Ex+OQgPrqVXc/ab/Afwe0pHg5NyVpdqnXqSD1Kuzt2pAmA=
X-Received: by 2002:a81:b40f:0:b0:352:477a:659e with SMTP id
 h15-20020a81b40f000000b00352477a659emr2358745ywi.127.1664446173543; Thu, 29
 Sep 2022 03:09:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220929092916.23068-1-johan+linaro@kernel.org> <20220929092916.23068-10-johan+linaro@kernel.org>
In-Reply-To: <20220929092916.23068-10-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 29 Sep 2022 13:09:22 +0300
Message-ID: <CAA8EJppu162mrfdEv7zb0hC3n-2dWKafGe7iEt5NhXLrV_9FZQ@mail.gmail.com>
Subject: Re: [PATCH v2 09/11] phy: qcom-qmp-usb: clean up power-down handling
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Sept 2022 at 12:29, Johan Hovold <johan+linaro@kernel.org> wrote:
>
> Always define the POWER_DOWN_CONTROL register instead of falling back to
> the v2 (and v3) offset during power on and power off.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

-- 
With best wishes
Dmitry
