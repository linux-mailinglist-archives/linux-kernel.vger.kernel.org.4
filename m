Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7036597B7
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 12:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbiL3LdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 06:33:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiL3LdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 06:33:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F9A01AD91
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 03:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672399940;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=+/oAGKz8UHTa57iRKW4s5lGYuywGUey4a7vrsAc6ygU=;
        b=EcvyVIlMhm4wLGraSAChKMIfXVQV5dwqobw0jvr/89MghzLMlN8w3G+iIMbGDC6FajFJfr
        jH/BE7Iud/jg0ezO892XqOR6uWE9DyYjDu05RMO1Q2btSCqUfihnq3I4W3Oe2A/+lkxk4S
        a1B9Y0hdrHZsIW1ylRcSOoAkAfDM8r0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-363-p8n0QfeFObiJlCLcokmL4Q-1; Fri, 30 Dec 2022 06:32:19 -0500
X-MC-Unique: p8n0QfeFObiJlCLcokmL4Q-1
Received: by mail-wr1-f72.google.com with SMTP id d14-20020adfa40e000000b0028e67b296c0so177777wra.23
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 03:32:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+/oAGKz8UHTa57iRKW4s5lGYuywGUey4a7vrsAc6ygU=;
        b=uyHVUlUM2QG2w2StxhCFTcJi/aqzoSc8q66+7hkCxAOoTtn+JuI94eM+Taa/TddcD0
         f5bfENey/pViTFXXp5F3ZdRLMoGXhTFf6vzeOeU1j1ZZ5KERQp9V4ZFU4RdgxInNBHFc
         fStNuiWnjsG8qw4uJYUkBufnWtZxDP8q9aQlB9N85bffM+kMIlGDGh5VvB2WCLi0JR81
         dJa9w38YPPBIjYUY2SyVZR6ndU7RSaPNsB5jXi2TzapZH7ICM73MjplfKtx14zlxH+7e
         YozvD6FlgPjt2QEWoa2utLxUEfYYvf/MUTIj1u+M1xcRDQ39lkywL6YbAQEZSIZ/8k8V
         Kczw==
X-Gm-Message-State: AFqh2krJq5OhD0p3dJZ9Xo/KIeaaw73jPk1Sy7g3/s1sZqPGy5rPmD7+
        M9D7r7QlKdxhoYwoBZkuc3kPm15hYEz1/0P1iWzCMVWn0Ow78FDeQy9IgNhpw1g6DGwZpRQ6LOO
        elTlYNvQxYKpdPyA5TfLgET8nSCnLIXSfmoVdRnm+45b9+p8/92/mjQkZVX+4Sr9024j7nLLGGf
        c=
X-Received: by 2002:a05:600c:1da3:b0:3d3:4dbc:75ef with SMTP id p35-20020a05600c1da300b003d34dbc75efmr22353800wms.17.1672399937654;
        Fri, 30 Dec 2022 03:32:17 -0800 (PST)
X-Google-Smtp-Source: AMrXdXujD8ZzgS7Pb826oREyFiC1KNraLQbuNX7XL2S+SNLv8iwIINUvUgMCaq86xR2bPIYl4qfNTA==
X-Received: by 2002:a05:600c:1da3:b0:3d3:4dbc:75ef with SMTP id p35-20020a05600c1da300b003d34dbc75efmr22353756wms.17.1672399937268;
        Fri, 30 Dec 2022 03:32:17 -0800 (PST)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id y22-20020a1c4b16000000b003d01b84e9b2sm27638432wma.27.2022.12.30.03.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Dec 2022 03:32:16 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Kamil=20Trzci=C5=84ski?= <ayufan@ayufan.eu>,
        Martijn Braam <martijn@brixit.nl>,
        Sam Ravnborg <sam@ravnborg.org>,
        Robert Mader <robert.mader@posteo.de>,
        Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
        Peter Robinson <pbrobinson@gmail.com>,
        Onuralp Sezer <thunderbirdtr@fedoraproject.org>,
        dri-devel@lists.freedesktop.org, Ondrej Jirman <megi@xff.cz>,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        Neal Gompa <ngompa13@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Caleb Connolly <kc@postmarketos.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: [PATCH v4 0/4] Add PinePhone Pro display support
Date:   Fri, 30 Dec 2022 12:31:50 +0100
Message-Id: <20221230113155.3430142-1-javierm@redhat.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series add support for the display present in the PinePhone Pro.

Patch #1 adds a driver for panels using the Himax HX8394 panel controller,
such as the HSD060BHW4 720x1440 TFT LCD panel present in the PinePhone Pro.

Patch #2 adds a devicetree binding schema for this driver and patch #3 adds
an entry for the driver in the MAINTAINERS file.

Finally patch #4 adds the needed devicetree nodes in the PinePhone Pro DTS,
to enable both the display and the touchscreen. This makes the upstream DTS
much more usable and will allow for example to enable support for the phone
in the Fedora distribution.

I only added myself as the maintainer for the driver because I don't know
if Kamil and Ondrej that worked in the driver would be interested. Please
let me know folks if you are, and I can add you too in the next revision.

This is a v4 of the patch-set that addresses issues pointed out in v3:

https://lists.freedesktop.org/archives/dri-devel/2022-December/384560.html

The patches were tested on a PinePhone Pro Explorer Edition using a Fedora
37 Workstation image.

Best regards,
Javier

Changes in v4:
- Add fallback "himax,hx8394" compatible for the panel controller (Jagan Teki).
- Add Tom Fitzhenry's Tested-by tag.
- Add Sam Ravnborg's Acked-by tag.
- Add Tom Fitzhenry's Tested-by tag.
- Keep the DTS nodes sorted alphabetically (Tom Fitzhenry).

Changes in v3:
- Fix example snippet for `make dt_binding_check` to pass (Krzysztof Kozlowski).
- Add Sam Ravnborg's reviwed-by tag.
- Move driver patch after one introducing the DT binding (Sam Ravnborg).

Changes in v2:
- Drop redundant "bindings" in subject (Krzysztof Kozlowski).
- Drop "device tree bindings" in title (Krzysztof Kozlowski).
- Put port next to other "true" properties (Krzysztof Kozlowski).
- Add Krzysztof Kozlowski's Reviewed-by tag.
- Add year to driver's copyright notice (Sam Ravnborg)
- Remove unused <video/display_timing.h> header include (Sam Ravnborg).
- Use mipi_dsi_dcs_write_seq() helper and drop custom macro (Sam Ravnborg).
- Drop unnecessary info messages and move useful one to debug (Sam Ravnborg).
- Fix regulator node names (Maya Matuszczyk).
- Drop non-existent "poweroff-in-suspend" property (Maya Matuszczyk).
- Remove unnecessary comments in panel node (Maya Matuszczyk).

Javier Martinez Canillas (2):
  dt-bindings: display: Add Himax HX8394 panel controller
  MAINTAINERS: Add entry for Himax HX8394 panel controller driver

Kamil Trzciński (1):
  drm: panel: Add Himax HX8394 panel controller driver

Ondrej Jirman (1):
  arm64: dts: rk3399-pinephone-pro: Add internal display support

 .../bindings/display/panel/himax,hx8394.yaml  |  75 +++
 MAINTAINERS                                   |   7 +
 .../dts/rockchip/rk3399-pinephone-pro.dts     | 123 +++++
 drivers/gpu/drm/panel/Kconfig                 |  12 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 drivers/gpu/drm/panel/panel-himax-hx8394.c    | 446 ++++++++++++++++++
 6 files changed, 664 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/himax,hx8394.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-himax-hx8394.c

-- 
2.38.1

