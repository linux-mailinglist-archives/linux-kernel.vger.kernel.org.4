Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3D16522FF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 15:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234092AbiLTOrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 09:47:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiLTOrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 09:47:03 -0500
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1825F66;
        Tue, 20 Dec 2022 06:46:58 -0800 (PST)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1322d768ba7so15620407fac.5;
        Tue, 20 Dec 2022 06:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O6fcP+au1pJCc5owaj1Sd0fF89EDU2Pk93B1pd+WtcM=;
        b=ZB4Klg04jg4pG2p2Z75tAziefJom6noEMN8YisNd8555YhNy38DpACpuWVV0fm9qlK
         EvGbUj1zMNXN98eiVnUX71WQs4LCT7pWiBQOvSz+5k4bGVCY8dYORDsxAzQUmXyggKFI
         vLnlvf5SHokPES6WCysBodYizSd6mvAYwYOqsDfHfW9nne59f0dDCImuFHbM7mbnTsdI
         VEkhQzhGi1re1MQscanRUfrtz2H7Yr+iG/QGLDBt62ttc+vKn3dm8c0uoN24Fqpap0QZ
         s7FS8/sZP1h1wgedTO6p1dwpKfeF6qBXtcUXcmcIZ4A6RNHXLBuGYOv4q0ZWRcw6+LPm
         WMjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O6fcP+au1pJCc5owaj1Sd0fF89EDU2Pk93B1pd+WtcM=;
        b=2tYPTn25X4GQC05DqtMhO8K+CU/+HkOeTu7HAIu+6b3CYdjCA604dojmqiCdJ67gzo
         o/5+8iFCtb5aNUSJJRsNwjXr3NIVPIw50JUKMk6Akkx5mgiZpLxcQ6O/G95eRyiA3s7C
         JnG+LdfhSJVcL/GFkxC87GgCo/YpjhQv66xiKA8zJ3zyieHQ7lubvoIkGWfdCCGXaEHq
         pu5/aX2RPTGb69jzeD6/5Zp7cqOZk4tFsw/ffTaKZl+Cb9teOSLNTgol/215YWnAOqoR
         go0QAM86WH97vHlCjnOsiox7B+leFkHGGWS1BVWFfhHg1dZ1mAegvpTLTl/+YTB0NGoY
         +oNw==
X-Gm-Message-State: ANoB5pmsojAT1qC2c8EwN1/8xacFgFY74BSoM+051i78NnYtFxZv65RI
        j7PnKIwMPyJ8XCE3eQy8mdD6rmKaRkk=
X-Google-Smtp-Source: AA0mqf6vizzqChyEIpNF1gofYdMyL/N/e5BVP5bauwz0RXLr97NMg2d89TxEkZT1RLXbbJK6JZFzQg==
X-Received: by 2002:a05:6870:4510:b0:144:d4f9:4c9f with SMTP id e16-20020a056870451000b00144d4f94c9fmr20979012oao.50.1671547617975;
        Tue, 20 Dec 2022 06:46:57 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s6-20020a056870ea8600b00136f3e4bc29sm6074491oap.9.2022.12.20.06.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 06:46:57 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 20 Dec 2022 06:46:56 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jon Cormier <jcormier@criticallink.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bob Duke <bduke@criticallink.com>,
        John Pruitt <jpruitt@criticallink.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: hwmon: adi,ltc2945: Add binding
Message-ID: <20221220144656.GA3748047@roeck-us.net>
References: <20221214220727.1350784-1-jcormier@criticallink.com>
 <20221220000457.1163446-1-jcormier@criticallink.com>
 <20221220000457.1163446-2-jcormier@criticallink.com>
 <e0f620b4-5780-fbea-4446-fd68f281281a@linaro.org>
 <CADL8D3YUzgk+H70wEG1Qfq-kcn_csUdJyRg2rWfraVb3JsEa_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADL8D3YUzgk+H70wEG1Qfq-kcn_csUdJyRg2rWfraVb3JsEa_g@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 09:35:38AM -0500, Jon Cormier wrote:
> On Tue, Dec 20, 2022 at 5:15 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
> >
> > On 20/12/2022 01:04, Cormier, Jonathan wrote:
> > > Create initial binding for the LTC2945 I2C power monitor.
> > > Also adds shunt-resistor-micro-ohms parameter
> >
> > The last sentence does not make sense. I propose to skip it.
> Ok
> >
> > >
> > > Signed-off-by: "Cormier, Jonathan" <jcormier@criticallink.com>
> > > ---
> > >  .../bindings/hwmon/adi,ltc2945.yaml           | 50 +++++++++++++++++++
> > >  1 file changed, 50 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/hwmon/adi,ltc2945.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/hwmon/adi,ltc2945.yaml b/Documentation/devicetree/bindings/hwmon/adi,ltc2945.yaml
> > > new file mode 100644
> > > index 000000000000..f90d40919ee6
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/hwmon/adi,ltc2945.yaml
> > > @@ -0,0 +1,50 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/hwmon/adi,ltc2945.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Analog Devices LTC2945 wide range i2c power monitor
> > > +
> > > +maintainers:
> > > +  - Guenter Roeck <linux@roeck-us.net>
> >
> > Maintainer of binding is person interested in the device, e.g. having
> > the hardware or datasheet. Not the subsystem maintainer. Unless by
> > coincidence this is the same person here?
> What do you do with a basic kernel driver which hasn't been touched
> since it was introduced except for various refactors? He seems to be
> the one who introduced it and most consistently made changes to it.

FWIW, if I was not ok with being listed as maintainer I would have objected.

Having said that, it is just as fine with me to list someone else.

Guenter

> >
> >
> > > +
> > > +description: |
> > > +  Analog Devices LTC2945 wide range i2c power monitor over I2C.
> > > +
> > > +  https://www.analog.com/media/en/technical-documentation/data-sheets/LTC2945.pdf
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - adi,ltc2945
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  shunt-resistor-micro-ohms:
> > > +    description:
> > > +      Shunt resistor value in micro-Ohms
> > > +    default: 1000
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +
> > > +
> > This is a friendly reminder during the review process.
> >
> > It seems my previous comments were not fully addressed. Maybe my
> > feedback got lost between the quotes, maybe you just forgot to apply it.
> > Please go back to the previous discussion and either implement all
> > requested changes or keep discussing them.
> My bad,
> >
> > Thank you.
> >
> > > +additionalProperties: false
> > > +
> >
> > Best regards,
> > Krzysztof
> >
> 
> 
> -- 
> Jonathan Cormier
> Software Engineer
> 
> Voice:  315.425.4045 x222
> 
> 
> 
> http://www.CriticalLink.com
> 6712 Brooklawn Parkway, Syracuse, NY 13211
