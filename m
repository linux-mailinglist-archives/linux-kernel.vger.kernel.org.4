Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4C4C65B813
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 00:08:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233689AbjABXIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 18:08:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233178AbjABXI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 18:08:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC545FF4
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 15:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672700860;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ZVNbH247RvvExgic0vKdLMnFmxWziqLn857HdRy/XtQ=;
        b=LoaSmRYqxi4gJq0nrDoE+vXb0jN1Z/Uu3l9vBx+cLPXHn5LLhcNpTh4vB49LcQLkeTsRCG
        DqOBanZAZcm5ILjx5a4POZDfgln0xm0YKUq2kBtH5xiI1b3A+85ev/9UxVZEFPrhScshQQ
        wgq8I8/ZnpFW10zbR9IAM349JrSSJp4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-648-5rYYmkW3NrGLL9KSOTqE2A-1; Mon, 02 Jan 2023 18:07:39 -0500
X-MC-Unique: 5rYYmkW3NrGLL9KSOTqE2A-1
Received: by mail-wm1-f69.google.com with SMTP id fl12-20020a05600c0b8c00b003d96f0a7f36so14199635wmb.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 15:07:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZVNbH247RvvExgic0vKdLMnFmxWziqLn857HdRy/XtQ=;
        b=L4cqOVEhLeuDvLsHZ33dwzdf8x8vqCGxEtUrM3R0ScwbqNm5/Yd2DNJnB1LjrmrYBv
         fpLRqfHoaB0+t7mvWi3h7/Abndm4v5zJGoUgqyqmBJQpijW/EJZNqoeKNqkVSrfkVUj7
         +UUXaJ+/4jihjiP/ruTMlc35KxnI4doLFomh9cXE6qoClwZcefX79hRa28Yfqnbw+Uf5
         J+E22Ug0u5RstY8N3VhAt2jaXMbkQ6tvsjKwwDJOPegG2B4A04kIk6F5BWafHSohqnQE
         cfkYa5UL5bi5MCCyZD64EI8NCpitAxRKThiXv5YGa72k1oY1yTpwugdb37uYgpI9HYa/
         mWxg==
X-Gm-Message-State: AFqh2kpHFJyjw3CY7+J2d7QcVX0fYDNk3H9bBLpPuebQeW/t6ItAsxj8
        abGSwqZqrH4kgflNrBOL0VR6mM4AESj0d3AI1/AR0yj1c3t6YHa5fv9CKHJVWBI9ZSul6wtCymg
        H4WseQTqmnFmEHkyiLc4Dq4TYnKC4S1JFQ+ETJ3oW4KxD0FqCUcV0ZUOxmvncqfvymGTiiWcgYE
        M=
X-Received: by 2002:adf:e449:0:b0:27c:fdb:cfef with SMTP id t9-20020adfe449000000b0027c0fdbcfefmr16738923wrm.49.1672700858289;
        Mon, 02 Jan 2023 15:07:38 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsm0o/HUzx1u6umoaT6TwoYLUR4Q/i3IuCfEcVC4DAM8E64C5wYahQAOQW+JH1jWC0VtHoPRA==
X-Received: by 2002:adf:e449:0:b0:27c:fdb:cfef with SMTP id t9-20020adfe449000000b0027c0fdbcfefmr16738895wrm.49.1672700857913;
        Mon, 02 Jan 2023 15:07:37 -0800 (PST)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id h10-20020a5d4fca000000b00281eab50380sm22746906wrw.117.2023.01.02.15.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 15:07:37 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Robert Mader <robert.mader@posteo.de>,
        Onuralp Sezer <thunderbirdtr@fedoraproject.org>,
        Martijn Braam <martijn@brixit.nl>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Kamil=20Trzci=C5=84ski?= <ayufan@ayufan.eu>,
        dri-devel@lists.freedesktop.org,
        Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
        Ondrej Jirman <megi@xff.cz>, Neal Gompa <ngompa13@gmail.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        devicetree@vger.kernel.org
Subject: [PATCH v5 0/3] Add PinePhone Pro display support
Date:   Tue,  3 Jan 2023 00:07:30 +0100
Message-Id: <20230102230733.3506624-1-javierm@redhat.com>
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

This series adds support for the display present in the PinePhone Pro.

Patch #1 adds a devicetree binding schema for panels based on the Himax
HX8394 controller, such as the HSD060BHW4 720x1440 TFT LCD panel present
in the PinePhone Pro. Patch #2 adds the panel driver for this controller
and finally patch #3 adds an entry for the driver in MAINTAINERS file.

This version doesn't include the DTS changes, since Ondrej mentioned that
there are still things to sort out before enabling it. The DTS bits will
be proposed as a follow-up patch series.

This allows for example the Fedora distro to support the PinePhone Pro with
a DTB provided by the firmware.

This is a v5 of the patch-set that addresses issues pointed out in v4:

https://lists.freedesktop.org/archives/dri-devel/2022-December/384810.html

The patches were tested on a PinePhone Pro Explorer Edition using a Fedora
37 Workstation image.

Best regards,
Javier

Changes in v5:
- List Ondrej Jirman as a maintainer in the DT binding schema document.
- Add Peter Robinson's Tested-by tag.
- List Ondrej Jirman as a maintainer in the driver's MAINTAINERS entry.

Changes in v4:
- Add fallback "himax,hx8394" compatible for the panel controller (Jagan Teki).
- Add Tom Fitzhenry's Tested-by tag.
- Add Sam Ravnborg's Acked-by tag.

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

Javier Martinez Canillas (2):
  dt-bindings: display: Add Himax HX8394 panel controller
  MAINTAINERS: Add entry for Himax HX8394 panel controller driver

Kamil Trzciński (1):
  drm: panel: Add Himax HX8394 panel controller driver

 .../bindings/display/panel/himax,hx8394.yaml  |  76 +++
 MAINTAINERS                                   |   8 +
 drivers/gpu/drm/panel/Kconfig                 |  12 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 drivers/gpu/drm/panel/panel-himax-hx8394.c    | 451 ++++++++++++++++++
 5 files changed, 548 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/himax,hx8394.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-himax-hx8394.c

-- 
2.38.1

