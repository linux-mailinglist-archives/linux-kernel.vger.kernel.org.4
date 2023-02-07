Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B49268D4CB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 11:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbjBGKtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 05:49:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbjBGKtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 05:49:42 -0500
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F66518170
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 02:49:41 -0800 (PST)
Received: by mail-vs1-xe34.google.com with SMTP id v26so8039909vsk.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 02:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r5ZtbwgDHN1H9THEYqzxxATE7adMzoUBL4nhQ1nnvTU=;
        b=vTID03xPsUXAb2/q8wDaCP1wystpGeU2tMzBY2hEFhQxDHuBoEoJ8tbk9MMPWpu3/Q
         l9nLUBmihndRr67XADwza9jGrCzS+iDP5J3rXloedGBSxYoWXtmkhDyg+h0kPThuxYr6
         IbRjRv9dBW8N47EoFLGZr5FU3KWOpiv1AhaKt2vZMloLyvwslubZ/jxMFxHglP5sK3XE
         pafrKVXeX94sHTG4N55rZR/q1nN/5w8CjdqBAUlXymzv3Aa2hD6UD7OTacuM34/jjG/6
         vK+dECDL4/cSZIvHCQjf5fAInLszTj5ZBFJ1QnaL4cauBKxP3drHngU71rNG5D3MGlBl
         gJGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r5ZtbwgDHN1H9THEYqzxxATE7adMzoUBL4nhQ1nnvTU=;
        b=L0N4x3GNU7i/o6y0ZjsUluZ71tIXJWjpJwjmuETUgIaIVldZ9kvCR9jTuZGfaqsxu0
         EE3DWCMuVtWvaQ2rq2P8Vy9hNoQh3r3AG+WtmL3Hk/YR3TP+W+7NItSs7GX2uwHec1cg
         HXOWK7HYwFWGjPsvfXBw6yHWR3n5PNHmLcGiEiEPPIZd3n2gri4T/amcNKw/aEaxbzbo
         vdCCyL2Xz1MEKpp6BYLJHV8Cow7TlEFtkGtA+O9uqt48qdYg4d2XjrtPYazw/COSSanC
         M2IZTdvjaKM3y1ogXcoXDiT0oHMqO508XV9rMAtt6LAfEC8Ka1MrvjDpFyt4SSgc3ZMs
         hK3w==
X-Gm-Message-State: AO0yUKVWDR0gj0qFdKaL6lH7bRBDHxj8ZkrxsRcX6sAbDLWMAVFFVqBO
        llZgJQ8rf2iAw3GqHrYHeOxJUea/fzpNipDeDBlCNQ==
X-Google-Smtp-Source: AK7set9pDY0mqzeJ8jF4fVB2/wJHwUl1SEMb1HEqt/Uk8ZySQQAd4Ko2KfQTPfxBnDKEN/xYC3+mbSfAEzj2Stqqt1Y=
X-Received: by 2002:a05:6102:3c94:b0:3fe:b46c:7889 with SMTP id
 c20-20020a0561023c9400b003feb46c7889mr667496vsv.78.1675766980397; Tue, 07 Feb
 2023 02:49:40 -0800 (PST)
MIME-Version: 1.0
References: <20230207100730.218725-1-brgl@bgdev.pl> <20230207100730.218725-4-brgl@bgdev.pl>
 <828c6ab8-6f5d-510a-05ef-7e0503323c75@linaro.org>
In-Reply-To: <828c6ab8-6f5d-510a-05ef-7e0503323c75@linaro.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 7 Feb 2023 11:49:29 +0100
Message-ID: <CAMRc=Mex6jgEhGQefk8KQLdb90hqptwhdBSqs-_f_PazEmgHTQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] soc: qcom: socinfo: add support for SA8775P
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 7, 2023 at 11:46 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 07/02/2023 11:07, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Add SocInfo support for SA8775P.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > ---
> >  drivers/soc/qcom/socinfo.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
> > index 3b970a80f3aa..c5208aa99125 100644
> > --- a/drivers/soc/qcom/socinfo.c
> > +++ b/drivers/soc/qcom/socinfo.c
> > @@ -419,6 +419,7 @@ static const struct soc_id soc_id[] = {
> >       { qcom_board_id(SM8350) },
> >       { qcom_board_id(SM6115) },
> >       { qcom_board_id(SC8280XP) },
> > +     { qcom_board_id(SA8775P) },
>
> This does not look like correctly ordered.
>

Ugh, I missed the fact that these are ordered by the chip ID that's
defined elsewhere. Thanks, will fix that in v2.

Bart
