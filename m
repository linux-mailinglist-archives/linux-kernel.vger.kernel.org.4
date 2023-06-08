Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 233B072817A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 15:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235420AbjFHNh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 09:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234893AbjFHNhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 09:37:24 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174331BEA
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 06:37:23 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-77493b3d18cso23437239f.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 06:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686231441; x=1688823441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6BDWspg0bM2Mt6zZ21elLYpHVPdFq4+1NTztyTSOtN8=;
        b=VzDsL0HX+Cj9Bnk20uwriJtQSV0plRjGRh/urvRBb+TdmhgLhBKYS8oQ2QrzHCGW+x
         OUy3IjF9JRe0JVnvJpw6100Ga08rKTY2CDDymiecf6ca9mB6vXuSl0+lo3L539OaGpJY
         U/BphmYtxSgWA51aHzjcRxVwFbI5Nq9W3F+jc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686231441; x=1688823441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6BDWspg0bM2Mt6zZ21elLYpHVPdFq4+1NTztyTSOtN8=;
        b=G8/cIVir+pS1puqjrTCHVqGxdUMWr3q3Su6sSAXgJ4OUwmlekk/BTeE+iJ5Wh7EipX
         WCYqP337dHP3+9RDaRIBgfaGguo7JZxsnZs+uUOJmu3eYVblOANAdCvxxdEXsn3pnI4P
         uq5JEJptqm/is3bdnWWuBgtvlL9XUamycJm5eV9LJos1cNy8gywuyuUiMZfc/TUcXQYd
         cKJkshcnaiCdSGB8BcurUM2YLgdcq+xZxzlqpHTv7U+rza6b4DifdR7AkdW7W8e1WfTe
         4CWkFst4HpcBe9P3JU9p0Dspktb1yrwDpZZh0SHId1tOVWexasJsr+Jiw9K271xubpaK
         YcNg==
X-Gm-Message-State: AC+VfDyJRLB5NWmd9JAv3ck8bMbPndKoyhGZCaonZCD9kIMDfZZqIiCL
        9PwV+gJab+H5qeIjTtxs+borU7uanj6NJ6KVHeM=
X-Google-Smtp-Source: ACHHUZ73/3ZKaZo9JXxPMNs0LttflOs45aTbsdubrTxifkDRXu5CmhlcbssgWJzwEXR76Plkui/T8w==
X-Received: by 2002:a92:4b08:0:b0:331:b2a1:841c with SMTP id m8-20020a924b08000000b00331b2a1841cmr11139702ilg.13.1686231441758;
        Thu, 08 Jun 2023 06:37:21 -0700 (PDT)
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com. [209.85.166.176])
        by smtp.gmail.com with ESMTPSA id s16-20020a92cc10000000b0032e1f94be7bsm412373ilp.33.2023.06.08.06.37.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jun 2023 06:37:19 -0700 (PDT)
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-33b7f217dd0so136455ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 06:37:19 -0700 (PDT)
X-Received: by 2002:a05:6e02:1d90:b0:335:6626:9f38 with SMTP id
 h16-20020a056e021d9000b0033566269f38mr239729ila.0.1686231439005; Thu, 08 Jun
 2023 06:37:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230608130147.2835818-1-yangcong5@huaqin.corp-partner.google.com>
 <20230608130147.2835818-2-yangcong5@huaqin.corp-partner.google.com>
In-Reply-To: <20230608130147.2835818-2-yangcong5@huaqin.corp-partner.google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 8 Jun 2023 06:37:06 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VTvZZA=AenE5vFMtrUVqLAp+RZMoZFU5t7R6tNpvnvjQ@mail.gmail.com>
Message-ID: <CAD=FV=VTvZZA=AenE5vFMtrUVqLAp+RZMoZFU5t7R6tNpvnvjQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: HID: i2c-hid: ilitek: Introduce
 bindings for Ilitek ili9882t
To:     Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, dmitry.torokhov@gmail.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com, hsinyi@google.com,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jun 8, 2023 at 6:02=E2=80=AFAM Cong Yang
<yangcong5@huaqin.corp-partner.google.com> wrote:
>
> @@ -0,0 +1,66 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/input/ilitek,ili9882t.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Ilitek ili9882t touchscreen controller
> +
> +maintainers:
> +  - Dmitry Torokhov <dmitry.torokhov@gmail.com>

Has Dmitry agreed to be the maintainer here? Traditionally when adding
a new file one lists themselves.


> +description:
> +  Supports the Ilitek ili9882t touchscreen controller.
> +  This touchscreen controller uses the i2c-hid protocol with a reset GPI=
O.
> +
> +allOf:
> +  - $ref: /schemas/input/touchscreen/touchscreen.yaml#
> +
> +properties:
> +  compatible:
> +    const: ilitek,ili9882t
> +
> +  reg:
> +    const: 0x41
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  panel: true
> +
> +  reset-gpios:
> +    maxItems: 1
> +    description: Reset GPIO.
> +
> +
> +  vccio-supply:
> +    description: The 1.8V supply to the touchscreen.

Why two blank lines between reset-gpios and vccio-supply?


> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - vccio-supply

I think you want "panel" as a required property too, right?


> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    i2c {
> +      #address-cells =3D <1>;
> +      #size-cells =3D <0>;
> +
> +      touchscreen: touchscreen@41 {
> +        compatible =3D "ilitek,ili9882t";
> +        reg =3D <0x41>;
> +
> +        interrupt-parent =3D <&pio>;
> +        interrupts =3D <12 IRQ_TYPE_LEVEL_LOW>;
> +
> +        reset-gpios =3D <&pio 60 GPIO_ACTIVE_LOW>;
> +        vccio-supply =3D <&mt6366_vio18_reg>;

...and "panel" would also need to go in the above example.
