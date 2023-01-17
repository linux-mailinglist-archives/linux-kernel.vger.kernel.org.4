Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA6A66E728
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 20:40:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjAQTkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 14:40:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235422AbjAQTfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 14:35:08 -0500
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38EAB38011
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 10:40:53 -0800 (PST)
Received: by mail-vs1-xe2b.google.com with SMTP id l125so13839536vsc.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 10:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HzP1xFoLjj5jhJ3xNiat0BSRJmicxmV9UzOSz4HXrGI=;
        b=lk2Ol42uH592eFDM/2k/N+xqYAdoODD5g/N7UJ7JKoDCDd9fEllMgDaV5J/zMwowGJ
         sylAwhCm918hE3r70qdAMJnL6ktDsrxkF9TElCPUsfufClV394XIYhJBBgqfTl8ftiJ7
         tbR78n4ln2EH8StsOtl5QJTYqIkA2qIC7hzkI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HzP1xFoLjj5jhJ3xNiat0BSRJmicxmV9UzOSz4HXrGI=;
        b=LYLBLrZZiipmXh9iaV44vhRk0APpVVa+zCzPD8LKDscqN8wjSd05wd/pWFUOBoUA2l
         S7O19gwlOH2PL6wXHE5YNgqLVc+k0Di2fSCqZX4p47HrdxcS3Bl0ttUkYqpWEOPbi1a9
         PE7imW772M9BPSsNZY+85wEW/aGXj7evOcgUVLNjHuGWS1vq1KVDXCd2okQgkUEd42L/
         +W6VGaPPuaqUNGvKAqOiYM/iC2y2hYf0akVRlmEpwpOgMAGazNz9ZtimM2A6iYNo3np8
         5iE7jBke8p2a/LbfKEwl11D+Lnpi3biz9t1tM0gSeDfeBuQcM03ns9kSWrbBRbX6Jn43
         +20Q==
X-Gm-Message-State: AFqh2kqJcSv29m/pjcrKg1UZS4kIlGLXJDcs0tUoxOiRGsP74Ygx9qFm
        /DdSLn0TcakZWgK6nYvHaeMVRlxHYhhf7r+J
X-Google-Smtp-Source: AMrXdXuCkFNtk3b4zF85HMByvyito1T7PWWIv7b0CX7WwhEuOYORR4pJqioo1BOJdDFn4zA6hvs/uA==
X-Received: by 2002:a05:6102:1482:b0:3d0:c56e:bc1d with SMTP id d2-20020a056102148200b003d0c56ebc1dmr2064705vsv.30.1673980852148;
        Tue, 17 Jan 2023 10:40:52 -0800 (PST)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id b7-20020a0561023a0700b003d3fc32d3eesm142012vsu.30.2023.01.17.10.40.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 10:40:50 -0800 (PST)
Received: by mail-vs1-f41.google.com with SMTP id k6so24273758vsk.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 10:40:50 -0800 (PST)
X-Received: by 2002:a67:bb14:0:b0:3ce:acca:5b77 with SMTP id
 m20-20020a67bb14000000b003ceacca5b77mr466044vsn.70.1673980850013; Tue, 17 Jan
 2023 10:40:50 -0800 (PST)
MIME-Version: 1.0
References: <20230117085212.1.If242b1cd61b2e87e312dd9cf81e20301bae2a5a4@changeid>
In-Reply-To: <20230117085212.1.If242b1cd61b2e87e312dd9cf81e20301bae2a5a4@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 17 Jan 2023 10:40:38 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XNazmGuFkdUEcNoitkced4uuy5C1CJBK4vgpbdZU5AWg@mail.gmail.com>
Message-ID: <CAD=FV=XNazmGuFkdUEcNoitkced4uuy5C1CJBK4vgpbdZU5AWg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sc7180: set ath10k output power
 calibration string
To:     Yunlong Jia <ecs.beijing2022@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bob Moragues <moragues@chromium.org>,
        Henry Sun <henrysun@google.com>,
        Abhishek Kumar <kuabhs@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jan 17, 2023 at 12:57 AM Yunlong Jia <ecs.beijing2022@gmail.com> wrote:
>
> Add the string to load RF output power table for pazquel360 project.
>
> Signed-off-by: Yunlong Jia <ecs.beijing2022@gmail.com>
>
> ---
>
>  arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel360.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
