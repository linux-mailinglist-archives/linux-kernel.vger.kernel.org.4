Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7F057416A0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 18:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbjF1QnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 12:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbjF1QnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 12:43:04 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7902682;
        Wed, 28 Jun 2023 09:43:03 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-55e1bb2ab1aso64804eaf.2;
        Wed, 28 Jun 2023 09:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687970583; x=1690562583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=svcTGMlkkZcq7zVljUNn74ilabu4qDPiMWYU2czYc9g=;
        b=Ax2nGNU/u7ZczSf7EY85b64hxkuv34fFWecOTPbBLthfVVc6zkY0rNCHfzpu+9hFEf
         9sJOcaphAgq6dN5NniynuTlHJYjuNA8e9IX2sulm+MQshAEuR4fkthEGxFroLftjGTeb
         vuovl0WUAzyKVERd5OF/FBuO4T1VQzZuK4QyyisDzwgDJMmogC4fv/3NKxtcHlCEAv72
         lFqzycMucwlFpdROAe94BFK3xqVtY4n7ReUd/41GGhcwd9oxNM80XTrA4cBP2REuZvHq
         QK0RU5eIIArmuGnbB2/uWPe6oCZOqNgyORKzAwdLv98ndB8naxdwkA+ZrdCQSZalzf9I
         hTRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687970583; x=1690562583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=svcTGMlkkZcq7zVljUNn74ilabu4qDPiMWYU2czYc9g=;
        b=Pfrh4YAsOVfVYr2nro/m1bV08OXQOs3yvHcLDIXQC4xla99vc2KjqcmSG4KDA/0+i8
         XDtijGvQGO8qZQBErSUt1Pz6uNON+EQlzeTMSTcG/z+FlAi9fbMiLTTtXDrcmrlWZygo
         +SU6MFqlNyrDvM7JKS+5zYSFBDTewDvI4WRrnK907aex6u6DVcml524TaDdCgNcEAXWo
         s3rM1u+DeNrdJN7ZEhK/ttSJVsdsG4Ozzfc6yy2byxkWrx5X23aEsLb3SoRYYdZnvEuJ
         pd/NDkI47hXcQQJNxb0jstuKKP3I0wRuFg7x3SyMihPAMI/vpbPQ6sM8FO/l9kkCRcWm
         FCNA==
X-Gm-Message-State: AC+VfDwCI+IYI/JgUosMc2x98odCsuZEZohKR0ZC1Skc6eGFnjTeDOzM
        qJrsP4drD5A3Y8GeaBpJm7dtk6tBDMir41WMmeDF37EP
X-Google-Smtp-Source: ACHHUZ4KJCgFXswJdX2NSttiyqsSF0rEXTwgInVTPpDHJuM3iH+sf9VdoukianZDFOq9fzSV/ZhZqk8KmUh7fGf3js4=
X-Received: by 2002:a4a:bb08:0:b0:563:53fa:324f with SMTP id
 f8-20020a4abb08000000b0056353fa324fmr7383813oop.6.1687970582917; Wed, 28 Jun
 2023 09:43:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230628082716.2075736-1-sergio.paracuellos@gmail.com> <20230628154022.GA520881-robh@kernel.org>
In-Reply-To: <20230628154022.GA520881-robh@kernel.org>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Wed, 28 Jun 2023 18:42:51 +0200
Message-ID: <CAMhs-H_WD7tkawv1cg3GympqyzzPwK4Es_GxoFD5gPR=Y0H7kw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: timer: add Ralink SoCs system tick counter
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, tglx@linutronix.de,
        daniel.lezcano@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Wed, Jun 28, 2023 at 5:40=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:
>
> On Wed, Jun 28, 2023 at 10:27:16AM +0200, Sergio Paracuellos wrote:
> > Add YAML doc for the system tick counter which is present on Ralink SoC=
s.
> >
> > Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> > ---
> >  .../bindings/timer/ralink,cevt-systick.yaml   | 38 +++++++++++++++++++
> >  1 file changed, 38 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/timer/ralink,cevt=
-systick.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/timer/ralink,cevt-systic=
k.yaml b/Documentation/devicetree/bindings/timer/ralink,cevt-systick.yaml
> > new file mode 100644
> > index 000000000000..59d97feddf4e
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/timer/ralink,cevt-systick.yaml
> > @@ -0,0 +1,38 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/timer/ralink,cevt-systick.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: System tick counter present in Ralink family SoCs
> > +
> > +maintainers:
> > +  - Sergio Paracuellos <sergio.paracuellos@gmail.com>
> > +
> > +properties:
> > +  compatible:
> > +    const: ralink,cevt-systick
>
> What is "cevt"? Would be nice to define. Really this should have been
> SoC specific, but it looks like it has been upstream "forever", so fine.

Not sure what cevt really means, I guess maybe "clock event"? Inside
the documentation this is just listed as "System Tick Counter". It is
upstreamed since Ralink SoCs are on tree. I am just documenting
already mainlined stuff since there are lots of missing  binding docs
for old Ralink SoCs.

>
> Otherwise,
>
> Reviewed-by: Rob Herring <robh@kernel.org>

Thanks!

Best regards,
    Sergio Paracuellos
>
> (the error report can be ignored)
