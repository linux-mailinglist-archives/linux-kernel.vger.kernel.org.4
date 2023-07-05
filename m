Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4158748666
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 16:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbjGEOdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 10:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231565AbjGEOdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 10:33:15 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C091700
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 07:33:13 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-bc379e4c1cbso7966541276.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 07:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688567593; x=1691159593;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=H1YvkBrXVZd9H3EDnRbIG+arHenMO/HjA5HNZAprwPE=;
        b=mIgVt5+DY7exRn6lX7iN3G4zO6iPsPB5yaWdfqj1NeOGVYs+Gcfw+REdJB75JXNrMn
         nc7Rhl17v4JF2EtwUA6lJxbuo20ZO+yRRNxpc28dNRk/d4h9+LBhkukfJMG9NiGMxwmp
         xOYaRwZbva2lk+B+8rSJIuokVX7e/YdF+ml7d9TbaEP2WI7kxEZ8YGJgBoMyH38T9ASf
         rp2DQxHXcJlY2qQVsTYl02wbiEjghg0tdsPpmYN852UhRm5pSeRXveWamVwJaX41Qu+C
         fnHPZU5ylRhSvcYOwlwgiJFM56BxG0xwr3c4xSoWkb6xHIAqhzBB5bSiLpkOIWf2LMP/
         Ineg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688567593; x=1691159593;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H1YvkBrXVZd9H3EDnRbIG+arHenMO/HjA5HNZAprwPE=;
        b=A8+RCGsbwdFGU6876DtUallcdfL2aZD885ZlXwOL/Log/mmdVmnXner+mpyY961KHR
         2O9fGJcf5Y7ZMBuDx87/3PX2wRV6Fd6IbqJo2Zgm6Q5YrM5lxHfceu7+2UxPcwuQSDnU
         b4pHqkioML82wkLQBvKLDqq1OxuG7j9nIgwTaZTwtyAgoHc/5cG0Va4ncjo5aKM8mP57
         gbKMm1lecfQ/HSEb5PnRSy2bV0CaeqKvaBgrR5VjvutBKQaA0AOTF+f0doiacOMOeNQR
         4QZgfWomz7Ysdr7yh9Vxxn8i+HUSMOJfahfuQUzoFHSLgK+VT6e38mhrUEBa6QEgsOJA
         J0Ew==
X-Gm-Message-State: ABy/qLb4ajI7Qw76oB+A4hsvbEZDAGAP267iBWQNnxeFKY6Oc86K3BY5
        LpjvJllc801+XCDjFpwTACDDwDv+B6ycomEfAMeUUA==
X-Google-Smtp-Source: APBJJlFDlIZZV+QglFbYRJU4YxDQMm2AvbHxpKLqE9KcyMP+MwmMrDpwetSq8pc2PYLjYlZzbY+GVW8HoKuOcSQHw9o=
X-Received: by 2002:a25:5341:0:b0:bad:fb1:a9f9 with SMTP id
 h62-20020a255341000000b00bad0fb1a9f9mr15150879ybb.62.1688567592856; Wed, 05
 Jul 2023 07:33:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230705110620.7687-1-quic_kbajaj@quicinc.com>
 <20230705110620.7687-2-quic_kbajaj@quicinc.com> <8bd8ffbe-f50d-6e4a-2fdf-3983a76fb5ad@linaro.org>
In-Reply-To: <8bd8ffbe-f50d-6e4a-2fdf-3983a76fb5ad@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 5 Jul 2023 17:33:01 +0300
Message-ID: <CAA8EJpqaqM1GL4_t=F0YP2wr-_2GetkD+gM54Ay=xUWRC9RQbg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] arm64: dts: qcom: qdu1000-idp: Update reserved
 memory region
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Komal Bajaj <quic_kbajaj@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jul 2023 at 17:24, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 05/07/2023 13:06, Komal Bajaj wrote:
> > Add missing reserved regions as described in QDU1000 memory map.
> >
> > Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
> > ---
> >  arch/arm64/boot/dts/qcom/qdu1000-idp.dts | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/qdu1000-idp.dts b/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
> > index 1d22f87fd238..47e5e31dde23 100644
> > --- a/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
> > +++ b/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
> > @@ -448,6 +448,28 @@ &qupv3_id_0 {
> >       status = "okay";
> >  };
> >
> > +&reserved_memory{
> > +     ecc_meta_data_mem: memory@e0000000{
>
> Missing spaces before '{'. I was correcting this already:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=66b14154e278807811d67de9fb0d5cc76638d07b
> so it seems I need to keep doing the same.
>
> Anyway, the names should follow purpose, not "memory". See link from Konrad.

Yes, mea culpa. Please excuse me for the suggestion, I was looking at
the older device tree files.

>
>
> Best regards,
> Krzysztof
>


-- 
With best wishes
Dmitry
