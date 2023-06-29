Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A9B742665
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 14:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbjF2M1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 08:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232326AbjF2M06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 08:26:58 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 516C035A9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 05:26:45 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6b711c3ad1fso541219a34.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 05:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688041604; x=1690633604;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NIk8wJfpH3/FAkecZSGRLuKhBChqs6CWPQ8UTS6BFyg=;
        b=eR/kPUuAd3/af7k4Nbz4TVTCdX1xjvfgAzUSaztt8l1P+l5BEnIae3/gvu6h42hE9G
         /Rs6xuuqPGj78oHLv5cIKvQARlFXqgJwJM5S5bOcoJQfSaUkWsfoHJIYZveMMkzDzWnm
         VJgk/NyNwVcs5RHGSeI7AjySTjefoggCBomRpr3ldjA8sVbPV5XkELdSZwL/SyNY6c5w
         6ipHpivvrUEDvJIUhAPNOGe+ZvWVf6sYKZGCAhGT5uFL+BQTGKt4OZlV0U5rrbcAlDTM
         nv8YkIs7PJpCXyqGsH2qJsGh7itojyBM88kqCe4nyFOShcmW/UhHIJQhh48mqPpMHOEN
         UpUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688041604; x=1690633604;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NIk8wJfpH3/FAkecZSGRLuKhBChqs6CWPQ8UTS6BFyg=;
        b=elNNeGZ9ylU3KCAWhBbo3LUJrhgQJ71AsnmEOZ7Q1DKpUf3sIHHJPHCsAYK3kAJ/gn
         9uVy1sV7z2x2+PwKCvukTbFAjI+1hISBuElzGqXCCNF4B24iZ7Z87aU5YskwO6RVIIoL
         hCwoSvsirWW+jNOVt+kYQyy24XXukHVtcbLr9+cy9rzSDdUbg+r7Ru2oUz9rvnoL+BbY
         352VjF0FCby7gEF7vqOpq+vx5Hau1FrrF+jNq67c0CagyeqFKH/6ATTXbVAF6mCpYnLS
         nqOaTSc4QQ3LM4/MIfwYIszms7TFnnd8XGTCSIQcVmp4o42cnSPf69DoA32e/2jLs7Vi
         OY1Q==
X-Gm-Message-State: AC+VfDxoGEf80svYi0MxMOBX2FJG6gfmXyv5buog53ZALxLbeg5zdukd
        clRtZXwguFySMyn9zUmJkegp/Y1BV9oq9/UR4cNBqw==
X-Google-Smtp-Source: ACHHUZ7elJFZUK/QSAojN3eXj6aPyhL1NPR9xEeFzIAo7HV9CqflV2dOYJOUp8Wkhr8zxc0HCzV1+n6otclDt9K3gI0=
X-Received: by 2002:a05:6359:601:b0:134:d0d0:c5f1 with SMTP id
 eh1-20020a056359060100b00134d0d0c5f1mr6107800rwb.19.1688041604413; Thu, 29
 Jun 2023 05:26:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230627-sm6125-dpu-v2-0-03e430a2078c@somainline.org>
 <20230627-sm6125-dpu-v2-12-03e430a2078c@somainline.org> <84eb1d40-436b-a5b4-a4e3-75a511ad5a90@linaro.org>
 <st3nrb54zxa5xp7qqkdyygf7t6ucgzl3xc5w6d426xy6udj4fx@puakunoaoj2l>
In-Reply-To: <st3nrb54zxa5xp7qqkdyygf7t6ucgzl3xc5w6d426xy6udj4fx@puakunoaoj2l>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 29 Jun 2023 15:26:33 +0300
Message-ID: <CAA8EJpqHh4ZWZxuRMLN2z8BZYFqzoWxZV=oW1ANzEJy4i-PWNw@mail.gmail.com>
Subject: Re: [PATCH v2 12/15] arm64: dts: qcom: sm6125: Switch fixed xo_board
 clock to RPM XO clock
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, Lux Aliaga <they@mint.lgbt>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jun 2023 at 15:09, Marijn Suijten
<marijn.suijten@somainline.org> wrote:
>
> On 2023-06-29 13:55:28, Dmitry Baryshkov wrote:
> > On 27/06/2023 23:14, Marijn Suijten wrote:
> > > We have a working RPM XO clock; no other driver except rpmcc should be
> > > parenting directly to the fixed-factor xo_board clock nor should it be
> > > reachable by that global name.  Remove the name to that effect, so that
> > > every clock relation is explicitly defined in DTS.
> > >
> > > Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> > > Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> > > ---
> > >   arch/arm64/boot/dts/qcom/sm6125.dtsi | 7 ++++---
> > >   1 file changed, 4 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/arch/arm64/boot/dts/qcom/sm6125.dtsi b/arch/arm64/boot/dts/qcom/sm6125.dtsi
> > > index 722dde560bec..edb03508dba3 100644
> > > --- a/arch/arm64/boot/dts/qcom/sm6125.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/sm6125.dtsi
> > > @@ -22,7 +22,6 @@ xo_board: xo-board {
> > >                     compatible = "fixed-clock";
> > >                     #clock-cells = <0>;
> > >                     clock-frequency = <19200000>;
> > > -                   clock-output-names = "xo_board";
> >
> > Why? I'd say, leave it.
>
> The exact reason is explained in the commit message.

Usually we do no not kill the xo_board name for the sake of anybody
still looking for the old name. Weak argument, I know.

>
> >
> > With that fixed:
>
> Hence I don't think it makes sense to "fix" this.
>
> - Marijn
>
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>



-- 
With best wishes
Dmitry
