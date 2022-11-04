Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15186199D9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 15:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbiKDO2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 10:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbiKDO2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 10:28:17 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D880305
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 07:26:13 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id sc25so13620954ejc.12
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 07:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ezu4+x+FxmyX9LnUOtXYBWAL6xwSTPUJFe4qn695+K8=;
        b=CT1hZWbquyHWvrgB8QGBW5W6X6O9ZmDfiWMIdy36NP115npz/vftPW3Y/KXWY9GwVG
         eHJqRqakklZm2mrqCohYKxxqfmGsVd18ife5cR5uc2d9icoK1bP8AnHKDTb0lM1rWW3X
         7RcvCe2reUBgTMvL6PTalopiQulEArdShKqDM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ezu4+x+FxmyX9LnUOtXYBWAL6xwSTPUJFe4qn695+K8=;
        b=wKfDVKbG/SPRMzmjwrxeRanhNt0ItRPgV1EfblJePMixfrNZGTWhkN7/HyJjI/FBgS
         PjYSX0y8fVl8LhA2sU4/BN4mJzX5XpXpChaUOeUA+P1OBx0obN2SlTTaYLp1LCH6D0Se
         1/0U3hX4U8CH021zv3B9qUiGO3F0Ugp9PwIkx2p2G8RbXct2oJr1qsCjK2exuMQu2FaE
         zAZz8TdLYo6DffM8hk89zU89w07nFwwXfhQH6rclw9eb5cF1fc2Vpa+k06BIzcYeZSuk
         7SxjLiIgfosOir8xTq74hJbHeSHthbCAuUrS2U+HtnXKZu2qkntEnxi2lgtrcu9x/uCD
         PJqw==
X-Gm-Message-State: ACrzQf0Ekf5ZXDEDNE5VlSuY3QZ4KnBMVhODciuw6tSIoCQxcY5a7Sng
        CadxILVh6ySVDkbA8Pze2HiE6i+4KNJ/oWn4
X-Google-Smtp-Source: AMsMyM4BXm6Wkpb8pM6TgGpPkBHADB23pCSPCUFYNr/qLV2FCvK58KmjBN1XeNeFRZQRY9x0XzmugQ==
X-Received: by 2002:a17:907:6288:b0:78d:ab30:c374 with SMTP id nd8-20020a170907628800b0078dab30c374mr34815071ejc.266.1667571971719;
        Fri, 04 Nov 2022 07:26:11 -0700 (PDT)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id 9-20020a170906218900b007a9c3831409sm1853376eju.137.2022.11.04.07.26.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Nov 2022 07:26:09 -0700 (PDT)
Received: by mail-wm1-f47.google.com with SMTP id h125-20020a1c2183000000b003cf9c3f3b80so573264wmh.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 07:26:08 -0700 (PDT)
X-Received: by 2002:a05:600c:4486:b0:3cf:6e1d:f4a5 with SMTP id
 e6-20020a05600c448600b003cf6e1df4a5mr20925598wmo.85.1667571968557; Fri, 04
 Nov 2022 07:26:08 -0700 (PDT)
MIME-Version: 1.0
References: <20221104061941.2739938-1-sheng-liang.pan@quanta.corp-partner.google.com>
 <20221104141515.v10.3.I3ac715e729f6f9b5a3e3001b155df4f9d14e6186@changeid> <139c06eb-14b8-10b5-80b7-ba8ec8579846@somainline.org>
In-Reply-To: <139c06eb-14b8-10b5-80b7-ba8ec8579846@somainline.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 4 Nov 2022 07:25:55 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VwP_s5y0MVNLs+WGD_=nJtJe7h=n+Xu4Ky5RvgdkAw9Q@mail.gmail.com>
Message-ID: <CAD=FV=VwP_s5y0MVNLs+WGD_=nJtJe7h=n+Xu4Ky5RvgdkAw9Q@mail.gmail.com>
Subject: Re: [PATCH v10 3/4] arm64: dts: qcom: sc7280: Add touchscreen and
 touchpad support for evoker
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Nov 4, 2022 at 2:35 AM Konrad Dybcio
<konrad.dybcio@somainline.org> wrote:
>
>
> On 04/11/2022 07:19, Sheng-Liang Pan wrote:
> > Change touchpad and touchscreen node for evoker
> > Touchpad: SA461D-1011
> > Touchscreen: GT7986U
>
> What's the reasoning? Were they changed post r0? Is r0 support
> effectively dropped?
>
> The changes look ok, but I feel like this needs more of a comment in the
> commit msg.

As I understand it r0's toucscreen/touchpad were not right to start
with. We are moving towards getting things upstream sooner and that
means that hardware hasn't always been fully tested out.

I certainly wouldn't object to a better commit message here, but in
this case there are no real world users (yet) and thus nobody is
really affected by this churn. ...so IMO if the series needs to be
spun for some other reason then the commit message could be updated,
but I wouldn't object to it landing as-is either.

-Doug
