Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60BED6ED029
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 16:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbjDXOSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 10:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjDXOSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 10:18:10 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2CE81AD;
        Mon, 24 Apr 2023 07:18:08 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1a677dffb37so39330155ad.2;
        Mon, 24 Apr 2023 07:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682345888; x=1684937888;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wgz6pGktHqeuQ4Y4H5L+AJiXl1aqMQ4y3UGquhQlAig=;
        b=Ty53eIAt1IHobjrfSfk6qmCuv/xmbaA+p/YqcxwpbTAc7dCv2X4Jt3DcrocevC/79O
         p/Uy1z2cnOjwlNOmVpJyXpj+lEOTuNSpICa3SObATJN5VybRkUCoZr+udJa1VDeqGsMB
         l7TPKHTFsoxKA8MzCei8cL0X+4N86NrxGZ0pB52HVghOZfhYS0t0VWHzQsl9A1LPXVVw
         AEhPYQ5Zf2f4QVYzfa/xd9dRMyc3FbRKvfUAQfo0w+6jwjKEmNsKFzeAc5Ug+N+WO1uz
         B8JygVYjN7UOZdHajiZIJu03dcuGqrGm89nkgwwEwbUVaxQxufQzAEZvsQ5xMYxuXgFW
         z6Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682345888; x=1684937888;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wgz6pGktHqeuQ4Y4H5L+AJiXl1aqMQ4y3UGquhQlAig=;
        b=Nb2HmW0MSYfWt1Us7ucHPyP1nrV/UNg7EIg+TEg6FK/k69Je0tbz1TZzEx9WPmy9Cm
         2lvN5vM/YRR6E1Vy4AIPbqXd4u03s56qNRg2zl2EBN805hpjKwwDIdsFgaF4Lxu3Qoa/
         CdRZCrjxx4qNB2jnKBkXvvyzUm4HZ0yaGC0Ez8nZqIj41TZQ7NMf9jkBlJ0bwlCDq5wE
         c+YWHv+rjSAymL++l/DtI5oykrtgJYRrlOd00g6TawKegpD2f13BfwzGdynQH5WuSTeU
         QUaw18OHQ69bS863/weYT6ebxUjItgebt4pzMJmI2k2qDW3VGNVOTtaUnlmUxmsQecnf
         cytw==
X-Gm-Message-State: AAQBX9cLnYhFmc2wLqXD2QxkaZHMg3COTO6McO+li0yszk//tTO1lhob
        7/Vhaah25+eCy33sHCjuRWM=
X-Google-Smtp-Source: AKy350YRFnPX7pHvHtaSTxI87RqGj1EAdgRzXvQnqI87j56IDGmzabDHr8vRW+W4Fub/VfgBsg5+8g==
X-Received: by 2002:a17:903:4093:b0:1a4:f295:32fa with SMTP id z19-20020a170903409300b001a4f29532famr11784339plc.15.1682345888127;
        Mon, 24 Apr 2023 07:18:08 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k11-20020a170902694b00b0019309be03e7sm6663563plt.66.2023.04.24.07.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 07:18:07 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 24 Apr 2023 07:18:06 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/43] dt-bindings: watchdog: add DT bindings for Cirrus
 EP93x
Message-ID: <7353ae3d-baf1-4f7f-9d87-ae322aa37338@roeck-us.net>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
 <20230424123522.18302-10-nikita.shubin@maquefel.me>
 <b39724a8-5e29-411e-9deb-29dd37609372@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b39724a8-5e29-411e-9deb-29dd37609372@roeck-us.net>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2023 at 07:16:16AM -0700, Guenter Roeck wrote:
> On Mon, Apr 24, 2023 at 03:34:25PM +0300, Nikita Shubin wrote:
> > This adds device tree bindings for the Cirrus Logic EP93xx
> > watchdog block used in these SoCs.
> > 
> > Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> > ---
> >  .../bindings/watchdog/cirrus,ep93xx-wdt.yaml  | 38 +++++++++++++++++++
> >  1 file changed, 38 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/watchdog/cirrus,ep93xx-wdt.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/watchdog/cirrus,ep93xx-wdt.yaml b/Documentation/devicetree/bindings/watchdog/cirrus,ep93xx-wdt.yaml
> > new file mode 100644
> > index 000000000000..f39d6b14062d
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/watchdog/cirrus,ep93xx-wdt.yaml
> > @@ -0,0 +1,38 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/watchdog/cirrus,ep93xx-wdt.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Cirrus Logic EP93xx Watchdog Timer
> > +
> > +maintainers:
> > +  - Wim Van Sebroeck <wim@linux-watchdog.org>
> > +
> > +description:
> > +  Watchdog driver for Cirrus Logic EP93xx family of devices.
> > +
> > +allOf:
> > +  - $ref: "watchdog.yaml#"
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - cirrus,ep9301-wdt
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +additionalProperties: false
> 
> The driver does support reading the timeout from devicetree.
> It might make sense to mention that here.
> 
Never mind - I guess that is includeds in watchdog.yaml.
Sorry for the noise.

> > +
> > +examples:
> > +  - |
> > +    wdt0: watchdog@80940000 {
> > +        compatible = "cirrus,ep9301-wdt";
> > +        reg = <0x80940000 0x08>;
> > +    };
> > +
> > -- 
> > 2.39.2
> > 
