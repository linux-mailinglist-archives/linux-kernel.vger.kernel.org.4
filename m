Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6B5772F64F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 09:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233802AbjFNH3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 03:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234114AbjFNH3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 03:29:01 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2CBE4D
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 00:29:00 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id ada2fe7eead31-43dda815756so786823137.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 00:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1686727739; x=1689319739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5CRRGmdvDVbIEVTAFye64zUK3XOXIsv8ssMpfcABwlc=;
        b=Nf0/wLoZ38LsOopYbyo0ezI8LUQxgJTAFLkmLtgB++4Cqtqg95I3NTpGl9TXnYDDkY
         wQhNpaGtN+5iKwyxA/Sc3yKL4QWEEoRYv1tUv0/rZ1jPqpc9h2liqXzIFsH7Mk0PzJ2D
         8Dt9l/8xaaR/qGP/pxdKD42jgFfMPgpFD59+6wt7ykOg3xU4OOQOIVjAB7xnsarGe2xV
         S1QJ6zDt5NlO/4rFM4tBxEctZeiRwHUUbqReFG2sT+6YQbOdFDmCmmmOhAPgpwdAefLP
         SOVujR+y+Jx1AZxSFRB5PTZR3D5aXGCdsLrtMDajNAzKERlzusmNmNlP39Tdtw7fIp0C
         Jqdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686727739; x=1689319739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5CRRGmdvDVbIEVTAFye64zUK3XOXIsv8ssMpfcABwlc=;
        b=Va4PYF+/vGQ8X0fVqnBSLb+1IrGvnhP0YI4biosyELublvqL69sJ/HAYG/1XJlDYeK
         re9d5jKnVUC2xqh1czxOznsUCK1FgwLBuuBDCrD4C1XOI6aBddIKM/qbmpvmvC628EI5
         1SbT9wwDkC4jPdUZBECNNrBGfHtdtTCXzAARo6yr0CvhDfV4WKq0Hc0OmmEUKM5Mp2ez
         VCQwXLiOtkWBUWaC9y/1/MeIvm0Ts02wHeQe0TSzxRaHBgHFi9P1tuD10iSjza4XbMGY
         colMiyI3wrik5Yo1n2xiI6ngxkGkIzo0wRJm4/QJRISnSUf7+IUgIJLLKIdFKuPyEqWm
         aRZg==
X-Gm-Message-State: AC+VfDxBF0cz/pctexYrB5pBe5tofYGgvAeqfpGLzeSXTcyIJ063jnOe
        S+R43c7+ELD8f8KhhBmt7NjtgcP9pZsoHZXWNRhwog==
X-Google-Smtp-Source: ACHHUZ5IOUv06tiZXv2OeC2IVs2JPsy0d5AliyorYz0hKnjFQVcPktvrX5L1vFgxFRciusLts8S8bofr4NgaMAhMxQo=
X-Received: by 2002:a05:6102:ca:b0:43d:54e9:35fb with SMTP id
 u10-20020a05610200ca00b0043d54e935fbmr7796848vsp.14.1686727739229; Wed, 14
 Jun 2023 00:28:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230612092355.87937-1-brgl@bgdev.pl> <20230612092355.87937-21-brgl@bgdev.pl>
 <712b2650-f0c1-088a-612c-ef6d6bcc1eb0@linaro.org>
In-Reply-To: <712b2650-f0c1-088a-612c-ef6d6bcc1eb0@linaro.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 14 Jun 2023 09:28:48 +0200
Message-ID: <CAMRc=McvVwk_HGU_cRzJ_qsCriHKfq61qL7bbe10evr-Sp6YSA@mail.gmail.com>
Subject: Re: [PATCH 20/26] dt-bindings: net: qcom,ethqos: add description for sa8775p
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 9:25=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 12/06/2023 11:23, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Add the compatible for the MAC controller on sa8775p platforms. This MA=
C
> > works with a single interrupt so add minItems to the interrupts propert=
y.
> > The fourth clock's name is different here so change it. Enable relevant
> > PHY properties.
> >
>
> I think the patch should be squashed with previous. Adding compatible to
> common snps,dwmac binding does not make sense on its own. It makes sense
> with adding compatible here.
>
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > ---
> >  .../devicetree/bindings/net/qcom,ethqos.yaml       | 14 +++++++++++++-
> >  1 file changed, 13 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/net/qcom,ethqos.yaml b/D=
ocumentation/devicetree/bindings/net/qcom,ethqos.yaml
> > index 60a38044fb19..b20847c275ce 100644
> > --- a/Documentation/devicetree/bindings/net/qcom,ethqos.yaml
> > +++ b/Documentation/devicetree/bindings/net/qcom,ethqos.yaml
> > @@ -20,6 +20,7 @@ properties:
> >    compatible:
> >      enum:
> >        - qcom,qcs404-ethqos
> > +      - qcom,sa8775p-ethqos
> >        - qcom,sc8280xp-ethqos
> >        - qcom,sm8150-ethqos
> >
> > @@ -32,11 +33,13 @@ properties:
> >        - const: rgmii
> >
> >    interrupts:
> > +    minItems: 1
> >      items:
> >        - description: Combined signal for various interrupt events
> >        - description: The interrupt that occurs when Rx exits the LPI s=
tate
> >
> >    interrupt-names:
> > +    minItems: 1
> >      items:
> >        - const: macirq
> >        - const: eth_lpi
> > @@ -49,11 +52,20 @@ properties:
> >        - const: stmmaceth
> >        - const: pclk
> >        - const: ptp_ref
> > -      - const: rgmii
> > +      - enum:
> > +          - rgmii
> > +          - phyaux
> >
> >    iommus:
> >      maxItems: 1
> >
> > +  phys: true
> > +
> > +  phy-supply: true
>
> Isn't this property of the phy?
>

It is, and as discussed elsewhere with Andrew, I will move it to the
SerDes PHY driver.

Bart

> > +
> > +  phy-names:
> > +    const: serdes
>
> Keep the phy-names after phys.
>
>
> Best regards,
> Krzysztof
>
