Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECA226FA389
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 11:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233795AbjEHJl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 05:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233677AbjEHJlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 05:41:50 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB481BD9;
        Mon,  8 May 2023 02:41:37 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f41dceb9c9so10987185e9.3;
        Mon, 08 May 2023 02:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683538896; x=1686130896;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DulnJXXhFI32By6CBfowIMFI6FZKGl0CYE23bj9tFQw=;
        b=SCm31vwAjISEgJAnQeQHHezQ3te1iTHr1/0Z/kSc9WyB7Pc+g14/0BoeQNmdBcLlo8
         Fi73QyAgM+IG43qpPGX7fkKs6XitAXTWkHZD+YSjI+k3UAlGQ7XeaVYwbXR8dZLPg1Ep
         G8FckVF3GqhnRHFXIadENTrL2cWDIFE4PQQdAHnxMUwj/lpsDgqCqPBj6pGin/FBDkOr
         BQTJpqhsu4iSpX5+tYY3niZ508DDCnx8s+1stQwZIhAgfXby+2EQLgqeAmcBRpLZOjm7
         L5WkDxmlrfpi4vWZpPV0IUFIs/DDPE7nYpRwve3BRcVZ4qjjHMN8Vq2ElWRsBYEBfDak
         wEaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683538896; x=1686130896;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DulnJXXhFI32By6CBfowIMFI6FZKGl0CYE23bj9tFQw=;
        b=UyXoi6jSWqyRxxvLbQNssN4WR9DPDUHfZ6lImZLQES4qnxjtmRvn/7rsdaJwSAYJav
         RpP0r7lVNiuL5keqFp+lLwPPpICIP8uFicQ0aWq1DcQaILEVu8lIOmf3N3ciFaH7A2e9
         LPxQEqZPTeBlzHZ+YNd0fi8y6Dk4/P6NOPAA0nijTL+Vj4rX/v2t9y5Y+0+1SS5pB8it
         jZ7otKajHpvvUuEjuWiHpOrp+j1aC82h0A0++81e0E3btEYV9SUb5Et1/+GUFoCZ6yQc
         DJixyBPcaYXcZY7H1cPlXQTmhzDXYvIjKn0+AQDkkiLX/Zfb9pBRdYO/q8rMOnpmJiWw
         IlFw==
X-Gm-Message-State: AC+VfDwoWfVnbIgxqTVB232RJPentfySxOdDDdP3lYt8k/ftT2dm0iMk
        hHQ1CccSZ7RMrz7oo/Bz4G15/X4T/ADhAg==
X-Google-Smtp-Source: ACHHUZ5ptAhbyT3XU8XBM0xD+cJXbJg04sowKEfhhybItNS2RmQwYUslxU/NS0icEyd0LeySqGho+g==
X-Received: by 2002:a1c:4b12:0:b0:3f4:21f8:90a8 with SMTP id y18-20020a1c4b12000000b003f421f890a8mr2954474wma.17.1683538895891;
        Mon, 08 May 2023 02:41:35 -0700 (PDT)
Received: from standask-GA-A55M-S2HP ([188.123.113.247])
        by smtp.gmail.com with ESMTPSA id 10-20020a05600c024a00b003f423dfc686sm3635736wmj.45.2023.05.08.02.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 02:41:35 -0700 (PDT)
Date:   Mon, 8 May 2023 11:41:33 +0200
From:   Stanislav Jakubek <stano.jakubek@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: firmware: brcm,kona-smc: convert to YAML
Message-ID: <20230508094133.GA10980@standask-GA-A55M-S2HP>
References: <20230508081053.GA4675@standask-GA-A55M-S2HP>
 <0ce9003a-5dd2-8dd0-2fa8-96ceaf954d50@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ce9003a-5dd2-8dd0-2fa8-96ceaf954d50@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 08, 2023 at 11:23:52AM +0200, Krzysztof Kozlowski wrote:
> On 08/05/2023 10:10, Stanislav Jakubek wrote:
> > Convert Broadcom Kona family Secure Monitor bounce buffer bindings
> > to DT schema.
> > 
> > Changes during conversion:
> >   - move from misc to firmware subdirectory
> >   - add used, but previously undocumented SoC-specific compatibles
> >   - drop deprecated compatibles (they've been deprecated for ~10 years)
> > 
> > Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
> > ---
> > 
> > Changes in V2:
> >   - move to firmware subdirectory (Krzysztof)
> >   - drop deprecated compatibles (Krzysztof)
> >   - adjusted commit message to reflect the above changes
> >   
> >  .../bindings/firmware/brcm,kona-smc.yaml      | 40 +++++++++++++++++++
> >  .../bindings/misc/brcm,kona-smc.txt           | 15 -------
> >  2 files changed, 40 insertions(+), 15 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/firmware/brcm,kona-smc.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/misc/brcm,kona-smc.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/firmware/brcm,kona-smc.yaml b/Documentation/devicetree/bindings/firmware/brcm,kona-smc.yaml
> > new file mode 100644
> > index 000000000000..16c7928a0daa
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/firmware/brcm,kona-smc.yaml
> > @@ -0,0 +1,40 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/firmware/brcm,kona-smc.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Broadcom Kona family Secure Monitor bounce buffer
> > +
> > +description:
> > +  A bounce buffer used for non-secure to secure communications.
> > +
> > +maintainers:
> > +  - Florian Fainelli <f.fainelli@gmail.com>
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> 
> You do not need oneOf.

Nice catch! Seems I forgot to remove it when removing the deprecated
compatibles. Will fix in V3.

Stanislav

> 
> 
> Best regards,
> Krzysztof
> 
