Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95C366569BB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 12:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbiL0LFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 06:05:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbiL0LEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 06:04:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D83D99583
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 03:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672139023;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=nkS0uo5evck1whC4UlRL7zEzShwAWRdnhJUD05ERnDk=;
        b=ADzZAe0mGs7989NOxpbCVKoPiFz6/6EYcJbTAH283JUElvfvwhocrRsAxviTW8pMpF/fWo
        0S2nRHMnWtJh8dNx8zsveKyL973CX67euV3HMSKx+FHUFPvrQXBko23mjsQ62i0HBlEx88
        vzN5+h0lXVlVEsLGPEglFJKZi88txSs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-131-zeLNBAYNPFKycHIyEqph6A-1; Tue, 27 Dec 2022 06:03:41 -0500
X-MC-Unique: zeLNBAYNPFKycHIyEqph6A-1
Received: by mail-wm1-f69.google.com with SMTP id c23-20020a7bc857000000b003d97c8d4935so2513790wml.8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 03:03:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nkS0uo5evck1whC4UlRL7zEzShwAWRdnhJUD05ERnDk=;
        b=zABzwg5FkmvEwrBJvEUTK8Uz5ys2riZ1qrGW9QpKwR++Fqp6a1vpMh7JFj8SrkMW0F
         Tx30zlnIMOoky/groS7xFJalKVLqUu5wrZKufniWxGkRfYw1mIpSl1EAIzuB7VJLO9S+
         oUVKTSvSLpzUz5YaDtv7affGeQqjuIvBPPGJrt9p50FKHNx7nWjuLWL9WkUdGjIDOw4P
         HR75ILn0X6K/p+80N2b15l43INLN+ZZm6n5gHM8DOoZFKwQekKT+VUjqo9wHkBewBlah
         CfIbNKI8cnN+WTbPPfx85A+k8GmMPeqGYclTMQ7kOGII0amcm0fshs2ELbd0mEek2QsD
         8bIw==
X-Gm-Message-State: AFqh2ko0wzeblwTP14FQhhIfl6E/p35j9+QQbbaxCOi3DrihVfJHmphm
        G2Z51q2tnjrniaYmGiznlEbJ+7kB0sb+cIFMvYNAtU+5yHlCZ7ZnrsT9Lpm7Y04yumKB2BYFs46
        tpyeiq2kgh0mpTQumoCMOPI7A3HUMXpWlLMkr56PZo0n61Jr2rv4jBx4XRujjnppIqAIwrnPQvw
        s=
X-Received: by 2002:adf:9b93:0:b0:26e:d96b:da7a with SMTP id d19-20020adf9b93000000b0026ed96bda7amr12298847wrc.61.1672139020535;
        Tue, 27 Dec 2022 03:03:40 -0800 (PST)
X-Google-Smtp-Source: AMrXdXv5y/kkiAuwA5Llqp+Wayp+ny7mbOOuXGVQjt+WhczDlzljG99CbF/SmOlAkyohJ5FLjxT8qg==
X-Received: by 2002:adf:9b93:0:b0:26e:d96b:da7a with SMTP id d19-20020adf9b93000000b0026ed96bda7amr12298807wrc.61.1672139020100;
        Tue, 27 Dec 2022 03:03:40 -0800 (PST)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id p18-20020a056000019200b00279d23574c4sm7374557wrx.13.2022.12.27.03.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 03:03:39 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Robinson <pbrobinson@gmail.com>,
        Martijn Braam <martijn@brixit.nl>,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Neal Gompa <ngompa13@gmail.com>,
        =?UTF-8?q?Kamil=20Trzci=C5=84ski?= <ayufan@ayufan.eu>,
        Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Robert Mader <robert.mader@posteo.de>,
        Onuralp Sezer <thunderbirdtr@fedoraproject.org>,
        Ondrej Jirman <megi@xff.cz>, dri-devel@lists.freedesktop.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH v3 0/4] Add PinePhone Pro display support
Date:   Tue, 27 Dec 2022 12:03:31 +0100
Message-Id: <20221227110335.2923359-1-javierm@redhat.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
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

This is a v3 of the patch-set that addresses issues pointed out in v2:

https://lists.freedesktop.org/archives/dri-devel/2022-December/384513.html

The patches were tested on a PinePhone Pro Explorer Edition using a Fedora
37 Workstation image.

Best regards,
Javier

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

 .../bindings/display/panel/himax,hx8394.yaml  |  74 +++
 MAINTAINERS                                   |   7 +
 .../dts/rockchip/rk3399-pinephone-pro.dts     | 123 +++++
 drivers/gpu/drm/panel/Kconfig                 |  12 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 drivers/gpu/drm/panel/panel-himax-hx8394.c    | 446 ++++++++++++++++++
 6 files changed, 663 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/himax,hx8394.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-himax-hx8394.c

-- 
2.38.1

