Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBE75741685
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 18:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbjF1Qcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 12:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbjF1QcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 12:32:11 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF8D2D76
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 09:31:28 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b5c231f842so65281111fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 09:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1687969887; x=1690561887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MxUKkkbx+vRaC8aApGfWw+lRG/yJ6GciI8eYWTcSc+k=;
        b=UWTbqKJ2fZNsGlGeU+8ZqLPNDF2dy+79VrxjSQXDm8YcY/1L1wE7WMUH+axRruogbx
         A08uUzgNdoD9PvKZlIafvnJ3JtujnGWoKyJkpMWvVa0ipnPKdJijF266uEO18WoglKYp
         l+ehO5vfpQkxBZggXZNKcZKv+EQKodX2f+Z1dgQJ8iiCO/64mushT8tSZHQySYGC4tIH
         /wSVEHiefbZ1CXQQEbX7i4urF2ooCKxKflvI9W9GmTZkcms+hP3Jh0w3eaeLTg7HZOjM
         i7yZiz8IDiby+B+LAGmNaisWhRX1gXnaXUlH5o8JGY/TE+Z5wjFBsBuWon1C7rxHA0bI
         ZErA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687969887; x=1690561887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MxUKkkbx+vRaC8aApGfWw+lRG/yJ6GciI8eYWTcSc+k=;
        b=SOoJe/OF99r1iqXyCwVdnCQcEdPkDREe2vkeK/xsUBGYvZZSdL1DOGRiXfpBozGmE5
         chwcUiUFQvP6zHZxQFA4XjZCseEVKdq4hKM4JS1sl7jFll40gCP7S6LCvB7WR9XcXp81
         2Yv5yBV3/+9JDnRQijrZxdTOAbBUzxSqeO/e+ZepUAZh2h2kGOm87ooNlOi+viJZYtpr
         Tl9zCZXuDYt0LAy+hdtxRfxILXOPNV9p3ytJQD8/zpt6CJN3HPp+0K0WJxuCm3wZbE7p
         GOZByVChtKbb7u4xhG2ARpMcRPWNU+i95avot59AIh/Bk5wlSS2wyaMUn4YaHrxk2uNx
         0TwQ==
X-Gm-Message-State: AC+VfDx4e0ebWvidb238pKcrwTAEAAmrgZyehM9ttEYWxS5s48yPLAxa
        txJSGA38p7nYdzQxJWTeCv3fBjX4dAcRorhpVG7FKw==
X-Google-Smtp-Source: ACHHUZ4m+7RR8cSMdL8PzsOGNomHg8wcCI+B4awSJPYhsIdDffEKLLZoyQ0wBygn7bgMqn4iZow/NVhPAO6GvWVDdGA=
X-Received: by 2002:a2e:9e07:0:b0:2b4:5fdd:f588 with SMTP id
 e7-20020a2e9e07000000b002b45fddf588mr21115198ljk.43.1687969887180; Wed, 28
 Jun 2023 09:31:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230616063210.19063-1-eric.lin@sifive.com> <20230616063210.19063-4-eric.lin@sifive.com>
 <2437bda9-bbdb-ad80-7201-1e16e1388890@linaro.org> <CAPqJEFoTsmVZ4kvsSB0RkQZaQGyXC96KV6RvdpeC5XxURCOZ0w@mail.gmail.com>
 <8c9ed2d4-83ab-ecc0-a300-e6bc8e2047b6@linaro.org>
In-Reply-To: <8c9ed2d4-83ab-ecc0-a300-e6bc8e2047b6@linaro.org>
From:   Eric Lin <eric.lin@sifive.com>
Date:   Thu, 29 Jun 2023 00:31:15 +0800
Message-ID: <CAPqJEFqhmxksvEgvC61cJcRGR0DrSWDZxJC3J7tdgcG8UY+sFw@mail.gmail.com>
Subject: Re: [PATCH 3/3] dt-bindings: riscv: sifive: Add SiFive Private L2
 cache controller
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     conor@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dslin1010@gmail.com,
        Zong Li <zong.li@sifive.com>, Nick Hu <nick.hu@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Mon, Jun 26, 2023 at 2:19=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 26/06/2023 05:26, Eric Lin wrote:
> > Hi Krzysztof,
> >
> > On Fri, Jun 16, 2023 at 6:45=E2=80=AFPM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 16/06/2023 08:32, Eric Lin wrote:
> >>> This add YAML DT binding documentation for SiFive Private L2
> >>> cache controller
> >>>
> >>> Signed-off-by: Eric Lin <eric.lin@sifive.com>
> >>> Reviewed-by: Zong Li <zong.li@sifive.com>
> >>> Reviewed-by: Nick Hu <nick.hu@sifive.com>
> >>> ---
> >>>  .../bindings/riscv/sifive,pL2Cache0.yaml      | 81 +++++++++++++++++=
++
> >>>  1 file changed, 81 insertions(+)
> >>>  create mode 100644 Documentation/devicetree/bindings/riscv/sifive,pL=
2Cache0.yaml
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/riscv/sifive,pL2Cache0=
.yaml b/Documentation/devicetree/bindings/riscv/sifive,pL2Cache0.yaml
> >>> new file mode 100644
> >>> index 000000000000..b5d8d4a39dde
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/riscv/sifive,pL2Cache0.yaml
> >>> @@ -0,0 +1,81 @@
> >>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> >>> +# Copyright (C) 2023 SiFive, Inc.
> >>> +%YAML 1.2
> >>> +---
> >>> +$id: http://devicetree.org/schemas/riscv/sifive,pL2Cache0.yaml#
> >>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>> +
> >>> +title: SiFive Private L2 Cache Controller
> >>> +
> >>> +maintainers:
> >>> +  - Greentime Hu  <greentime.hu@sifive.com>
> >>> +  - Eric Lin      <eric.lin@sifive.com>
> >>> +
> >>> +description:
> >>> +  The SiFive Private L2 Cache Controller is per hart and communicate=
s with both the upstream
> >>> +  L1 caches and downstream L3 cache or memory, enabling a high-perfo=
rmance cache subsystem.
> >>> +  All the properties in ePAPR/DeviceTree specification applies for t=
his platform.
> >>
> >> Drop the last sentence. Why specification would not apply?
> >>
> > OK, I'll drop it in v2.
> >
> >>> +
> >>> +allOf:
> >>> +  - $ref: /schemas/cache-controller.yaml#
> >>> +
> >>> +select:
> >>> +  properties:
> >>> +    compatible:
> >>> +      contains:
> >>> +        enum:
> >>> +          - sifive,pL2Cache0
> >>> +          - sifive,pL2Cache
> >>> +
> >>> +  required:
> >>> +    - compatible
> >>> +
> >>> +properties:
> >>> +  compatible:
> >>> +    items:
> >>
> >>
> >> You have only one item, so no need for items... unless you just missed
> >> proper fallback.
> >
> > OK, I'll fix it in v2.
> >
> >>
> >>> +      - enum:
> >>> +          - sifive,pL2Cache0
> >>> +          - sifive,pL2Cache1
> >>
> >> What is "0" and "1" here? What do these compatibles represent? Why the=
y
> >> do not have any SoC related part?
> >
> > The pL2Cache1 has minor changes in hardware, but it can use the same
> > pl2 cache driver.
>
> Then why aren't they compatible?
>

The pL2Cache1 has removed some unused bits in the register compared to
pl2Cache0.
From the hardware perspective, they are not compatible but they can
share the same pl2 cache driver in software.
Thus, we would like to keep both. It would be great if you can provide
some suggestions. Thanks.

Best Regards,
Eric Lin.

> > May I ask, what do you mean about the SoC-related part? Thanks.
>
> This is part of a SoC, right? We expect SoC blocks to have compatible
> based on the SoC.
>
>
>
> Best regards,
> Krzysztof
>
