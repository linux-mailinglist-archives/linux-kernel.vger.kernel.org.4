Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC4F6EC0FC
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 18:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjDWQPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 12:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjDWQO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 12:14:59 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7CD2E71;
        Sun, 23 Apr 2023 09:14:57 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f195b164c4so12224735e9.1;
        Sun, 23 Apr 2023 09:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682266496; x=1684858496;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N2WWfegOvU9upeAYp5N/FtKW0M+GO0T69Pg9FL709S0=;
        b=TD9d+0KQJAarLZpQwxytUyPLHXa2EsOUK3r/D6NbT/DxXnjd2FOkaxu8Mk8vdRAnFn
         DsrPnLq6gn/k+PKrO1L5N49Qm6geWjzDMA348U4qPWplSIcm3qRC8WnAuXeQO8evDyFL
         v1MAtrchYLwO1SnAsRqsiKq0I5WpQpR+cL5CEX+uJY+05khydhAOD8VfvDT0dIY9JAdH
         VZ7GjpxE4qiLtOjOw5h+clJXEMV/eCeLUeMGc5cZnQqQYxEfOQTdZJNpnZuCgW4MAQZj
         cww9HA/gEzFgxDq14nNQSQ8kDmVyYKIHTt5MSV9a2I+SXU9ndu0zm+amomyB9KBvjK0H
         g24A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682266496; x=1684858496;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N2WWfegOvU9upeAYp5N/FtKW0M+GO0T69Pg9FL709S0=;
        b=mIJtANuTJ3Fdt/ncOPEVJJKR0pb7LjD8/hQ52Bf/N8naT1+sGH1NCtzOs3rGE4bR9e
         CS/5zkD+KcRlL32vmtOP4KiHdnhe/y0zyRfjApONeynON6ge4VKhgC8NhBfoGAjLEd9K
         do+WEfy4m0DkWJySAOh/Iy1CN8UlptIKwnFVob6SA6FLVy2WWfSPzO+4Raj+/sh3CEMe
         yggXOOx0aGfY6pWqBa9fPqFqF9bsGe3fEeDu1X8Nli5iXAw8AxEZJbceEGBqkoeDMQgz
         pu+Zch8KeXWoZ6syMVGF3qDY7Crkf34bV1VKuTHRJh5SwRN5MwhLHW/UaQ2E2aG9oFkt
         yRZQ==
X-Gm-Message-State: AAQBX9dFEv08Ef5fabGGc6tCS1S+S8gva/1B3MP3Rc754XoQdKsJGo/2
        NLaO93lMIDmzMJ91ONh1ZkjR9/9Kyvpa5Q==
X-Google-Smtp-Source: AKy350aHIVkamCMPlOPpFZw2ZbUuMbgbHBDImVPNzIaacdaeezzqVOSR2Wz9LAlWItGA0V/4te5p/w==
X-Received: by 2002:a1c:7404:0:b0:3f1:7123:5f82 with SMTP id p4-20020a1c7404000000b003f171235f82mr6314095wmc.12.1682266496075;
        Sun, 23 Apr 2023 09:14:56 -0700 (PDT)
Received: from standask-GA-A55M-S2HP ([188.123.113.247])
        by smtp.gmail.com with ESMTPSA id l14-20020a7bc44e000000b003f195d2f1a9sm5562665wmi.15.2023.04.23.09.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Apr 2023 09:14:55 -0700 (PDT)
Date:   Sun, 23 Apr 2023 18:14:53 +0200
From:   Stanislav Jakubek <stano.jakubek@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH,RESEND] dt-bindings: watchdog: brcm,kona-wdt: convert to
 YAML
Message-ID: <20230423161453.GA13078@standask-GA-A55M-S2HP>
References: <20230423143951.GA10743@standask-GA-A55M-S2HP>
 <4641afaf-9797-3a29-7eb1-8dadbf3b713d@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4641afaf-9797-3a29-7eb1-8dadbf3b713d@roeck-us.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 23, 2023 at 08:28:23AM -0700, Guenter Roeck wrote:
> On 4/23/23 07:39, Stanislav Jakubek wrote:
> > Convert Broadcom Kona family watchdog timer bindings to DT schema.
> > 
> > Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
> > ---
> > RESEND because I originally sent this to the wrong maintainers and
> > mailing lists by accident. Sorry for the noise.
> > 
> 
> Is this patch supposed to replace / compete with the other patch
> doing the same ?
> https://patchwork.kernel.org/project/linux-watchdog/patch/20230418170341.28805-1-n2h9z4@gmail.com/

I simply did not see that patch, thank you for pointing it out.

> 
> What is the difference, and what is the purpose ?

I believe both patches serve the same purpose - get DT validation for the
Broadcom Kona watchdog.

Looking at the two patches, there's very little difference:
 - capitalization of title (*F*amily *W*atchdog *T*imer)
 - maintainers
 - the brcm,bcm11351-wdt compatible listed as const vs. as enum with
   a single entry (I think the enum is better for future additions,
   but no strong opinion on that)
 - the other patch has a description (which IMO is unnecessary)

Since that patch came before mine, you can drop this one if you want.

Stanislav

> 
> Guenter
> 
> >   .../bindings/watchdog/brcm,kona-wdt.txt       | 15 --------
> >   .../bindings/watchdog/brcm,kona-wdt.yaml      | 37 +++++++++++++++++++
> >   2 files changed, 37 insertions(+), 15 deletions(-)
> >   delete mode 100644 Documentation/devicetree/bindings/watchdog/brcm,kona-wdt.txt
> >   create mode 100644 Documentation/devicetree/bindings/watchdog/brcm,kona-wdt.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/watchdog/brcm,kona-wdt.txt b/Documentation/devicetree/bindings/watchdog/brcm,kona-wdt.txt
> > deleted file mode 100644
> > index 2b86a00e351d..000000000000
> > --- a/Documentation/devicetree/bindings/watchdog/brcm,kona-wdt.txt
> > +++ /dev/null
> > @@ -1,15 +0,0 @@
> > -Broadcom Kona Family Watchdog Timer
> > ------------------------------------
> > -
> > -This watchdog timer is used in the following Broadcom SoCs:
> > -  BCM11130, BCM11140, BCM11351, BCM28145, BCM28155
> > -
> > -Required properties:
> > -  - compatible = "brcm,bcm11351-wdt", "brcm,kona-wdt";
> > -  - reg: memory address & range
> > -
> > -Example:
> > -	watchdog@35002f40 {
> > -		compatible = "brcm,bcm11351-wdt", "brcm,kona-wdt";
> > -		reg = <0x35002f40 0x6c>;
> > -	};
> > diff --git a/Documentation/devicetree/bindings/watchdog/brcm,kona-wdt.yaml b/Documentation/devicetree/bindings/watchdog/brcm,kona-wdt.yaml
> > new file mode 100644
> > index 000000000000..5de1b022847b
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/watchdog/brcm,kona-wdt.yaml
> > @@ -0,0 +1,37 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/watchdog/brcm,kona-wdt.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Broadcom Kona family watchdog timer
> > +
> > +maintainers:
> > +  - Florian Fainelli <f.fainelli@gmail.com>
> > +
> > +allOf:
> > +  - $ref: watchdog.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - enum:
> > +          - brcm,bcm11351-wdt
> > +      - const: brcm,kona-wdt
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    watchdog@35002f40 {
> > +        compatible = "brcm,bcm11351-wdt", "brcm,kona-wdt";
> > +        reg = <0x35002f40 0x6c>;
> > +    };
> > +...
> 
