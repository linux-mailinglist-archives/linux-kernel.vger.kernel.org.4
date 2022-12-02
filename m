Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9FE5640A84
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 17:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234050AbiLBQVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 11:21:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233944AbiLBQVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 11:21:31 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D089EECE41
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 08:18:50 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id c66so834411edf.5
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 08:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9sSKXcDsyGwMJeWY4NDSO718BkFmb+d6Aniz+mE21XI=;
        b=DMcjVh5J0PLUm4KCi2yThPTKI61xrD/51r2/Ok5zUYgIBjhEOFJPoR+53vqsJaGXeb
         o4FgU79/sR8k7rABYurayQCm0emRdY+OM4hauUeAM60mGgGe7HGCp+icrlEziWASk2aa
         lZYKIVVT9zINcAIrUgC9muSsvr6Whu52Zt+ZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9sSKXcDsyGwMJeWY4NDSO718BkFmb+d6Aniz+mE21XI=;
        b=ZZ59eOAesUA1E3CPsf3Ptg7UKu8v4BZKDObMscfFoT0Ko7rf3HsatuBpnMMBaJt0hS
         nnFnQa65ntjhr4VswD/5MJeAYLIOAm/xCDa154b5ixgPWvLcqz+6vCYzB+TTgKvyoqa+
         OwRpsKQK0R/DNUsAkB7QFw8lp3p8AHYS/lPG411hM5bPLuZQOqMmaCK0uLvxe1vIQUx+
         7t2TgtlhvlDx3EmwjhvPO5TA2SigTokKaZAr9OsjvBEOFAjCGic8ud1bM8/lj4uYKUSN
         GWkgIcyeK3Sy3TuDJL8TxLOIw2mV8lSNS+FjDIUSy4Hv25biSehz8DSK5XlETH9fuvGQ
         yoLw==
X-Gm-Message-State: ANoB5pnwJs/7EP36kBQRQYn/pZq4lx+EkMQCY0/gNqIub19MPEUGR1iB
        8LVY2GNFjvV7kDkgXWHzk8Z4yYq/H3aXxZLTozw=
X-Google-Smtp-Source: AA0mqf5xa2zYJBaJgQ4P/CcG/bT7AEGZCB7N1djg2sB1pFjqeJvFK5Z8qY4QU9hViOwoKUBYVQNHtg==
X-Received: by 2002:aa7:cb15:0:b0:458:e9c0:3e6f with SMTP id s21-20020aa7cb15000000b00458e9c03e6fmr65877008edt.61.1669997894835;
        Fri, 02 Dec 2022 08:18:14 -0800 (PST)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id v1-20020a50a441000000b0046b4e0fae75sm3124153edb.40.2022.12.02.08.18.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 08:18:13 -0800 (PST)
Received: by mail-wr1-f48.google.com with SMTP id bx10so8601784wrb.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 08:18:13 -0800 (PST)
X-Received: by 2002:a5d:4943:0:b0:242:3ca3:b7bd with SMTP id
 r3-20020a5d4943000000b002423ca3b7bdmr4732468wrs.583.1669997893515; Fri, 02
 Dec 2022 08:18:13 -0800 (PST)
MIME-Version: 1.0
References: <20221202155738.383301-1-krzysztof.kozlowski@linaro.org> <CAD=FV=U86PyVQP4wbhwEkzYprJxz2-S3ooniuYKJBNQOudx2uA@mail.gmail.com>
In-Reply-To: <CAD=FV=U86PyVQP4wbhwEkzYprJxz2-S3ooniuYKJBNQOudx2uA@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 2 Dec 2022 08:18:01 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VjfFx_GBNh9zC=fdV5gUBHww+4BhSSpAq0iq-72i62TQ@mail.gmail.com>
Message-ID: <CAD=FV=VjfFx_GBNh9zC=fdV5gUBHww+4BhSSpAq0iq-72i62TQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] arm64: dts: qcom: sdm845-db845c: fix audio codec
 interrupt pin name
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Fri, Dec 2, 2022 at 8:08 AM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Fri, Dec 2, 2022 at 7:57 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
> >
> > The pin config entry should have a string, not number, for the GPIO used
> > as WCD9340 audio codec interrupt.
> >
> > Reported-by: Doug Anderson <dianders@chromium.org>
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >
> > ---
> >
> > Cc: Doug Anderson <dianders@chromium.org>
> >
> > Changes since v2:
> > 1. New patch.
> > ---
> >  arch/arm64/boot/dts/qcom/sdm845-db845c.dts | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Presumably should have a "Fixes" tag since this is likely a true bug.
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

FWIW, this got copy-pasta-ed to another place, which I just noticed as
I'm looking at your v3. So while your change is correct, it'd be
better to also fix "sdm845-xiaomi-beryllium-common.dtsi"

-Doug
