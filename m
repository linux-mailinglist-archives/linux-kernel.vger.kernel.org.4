Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34371710918
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 11:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240718AbjEYJjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 05:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240780AbjEYJjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 05:39:10 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B43FE49
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 02:38:02 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id a1e0cc1a2514c-783e5c64d29so521065241.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 02:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1685007481; x=1687599481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oEJFrZVH1rjo4B3+YvFZtJFJ+STMe28dWj3W1cbfjMs=;
        b=iM2dxEBGMSs2nJR2qB95J2e/i2Np/iJRynzb0xvTDnfd99o52WnVpmlrE+ekNrdP21
         lmFU512dtt04r3jw/y9ly4KvHRST8MXGu3XVTnkxtP2RE8qSEVcn/9w+WecabUewP9Qe
         7p6w13DuBGgg24cRZDnYPAuAxqwd1pV2GkP+S4nF1+W6faHxDtCV++fg2FCzaO02oR7W
         kFuXYFtxORG0kp7v+Zl4VA1/yWISCnBOirroGOPOYjymNrIS/3EV5QG1CoBjwVbpjhBk
         XaAt9wRu05Uk1DFMHcz0qrvKmDo2lyFbQaSjmscE8ujrledQgK8tDBHsodiZuP0YgJkw
         I8kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685007481; x=1687599481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oEJFrZVH1rjo4B3+YvFZtJFJ+STMe28dWj3W1cbfjMs=;
        b=YPXXVv1XlqW1qLIomKT4FqRrBNKdsyUw05TWp00zXuMY36CpQNbun1Mvp2jrjsVnYa
         MSJMgSNIBVn/Opc3rsxFHRVtHUCZSzKQBUP7Br6CWw4AwwlwKFxg7gaK2zxsXhh8wDPA
         QPB+2yRdiOBqMM+ROAajijsw1Z+WLIBPQrzlw5gVbW13/w6X5tqQeFFSMGrvkDKH/nmn
         HnB8XdvjI9PXetH13qzUT6+VuJx8kwi6NiZadf/Uz0HJAp8A/FlNgpU5urnwQwoNwU6E
         jXtvlq/myqWyhAUIyXA4JW4Vz37L4SeMf6QHvdgvPLp2DQmd/lJKyfaxsjjHFs6OfjYZ
         keVw==
X-Gm-Message-State: AC+VfDy1qYqxI4S56yUauN9TvOaiMyqAxdJ5wMN43hTJ6NnEEhsaXtm7
        WPt+S4EFAZyCSsmMZ3Ggcbx61svoHMoz+s4oYpmYJg==
X-Google-Smtp-Source: ACHHUZ7WpOy3wCLD5AtzEtx27Y4bEWHrtU9zN+2rZF5BNaH1IbmVOHvB1XOktMAjYDfHAtlHwjS6fZtVO9liQY+ETCk=
X-Received: by 2002:a67:dc8c:0:b0:439:6c06:606e with SMTP id
 g12-20020a67dc8c000000b004396c06606emr795944vsk.0.1685007481350; Thu, 25 May
 2023 02:38:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230411130446.401440-1-brgl@bgdev.pl> <20230411130446.401440-2-brgl@bgdev.pl>
 <CAMRc=MdDct0UzJPpOTuKHmm23Jc529NwkBWJJmXfeevpkQaSxQ@mail.gmail.com>
In-Reply-To: <CAMRc=MdDct0UzJPpOTuKHmm23Jc529NwkBWJJmXfeevpkQaSxQ@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 25 May 2023 11:37:50 +0200
Message-ID: <CAMRc=Me4EQ_7ArCeJASzKTimuSH=yNkrwm9DgE93s7kjdS5Nrw@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] dt-bindings: ufs: qcom: add compatible for sa8775p
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 12:06=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:
>
> On Tue, Apr 11, 2023 at 3:04=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.p=
l> wrote:
> >
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Add the compatible string for the UFS on sa8775p platforms.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/ufs/qcom,ufs.yaml | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml b/Docu=
mentation/devicetree/bindings/ufs/qcom,ufs.yaml
> > index c5a06c048389..b1c00424c2b0 100644
> > --- a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
> > +++ b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
> > @@ -26,6 +26,7 @@ properties:
> >            - qcom,msm8994-ufshc
> >            - qcom,msm8996-ufshc
> >            - qcom,msm8998-ufshc
> > +          - qcom,sa8775p-ufshc
> >            - qcom,sc8280xp-ufshc
> >            - qcom,sdm845-ufshc
> >            - qcom,sm6350-ufshc
> > @@ -105,6 +106,7 @@ allOf:
> >            contains:
> >              enum:
> >                - qcom,msm8998-ufshc
> > +              - qcom,sa8775p-ufshc
> >                - qcom,sc8280xp-ufshc
> >                - qcom,sm8250-ufshc
> >                - qcom,sm8350-ufshc
> > --
> > 2.37.2
> >
>
> Bjorn,
>
> Are you picking this one up as well or should it go through Rob's tree?
>
> Bart

Gentle ping.

Bart
