Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E794D6CB83E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 09:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbjC1Hes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 03:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbjC1HeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 03:34:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C8CB3C21
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 00:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679988797;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=RbISS+/27S6jW4bDHr8lk+wvnbdcYB3f6YGIVizM/3Y=;
        b=QK5KgZ2RQBTIvi4Ne2IbED5n+plXV4qIv+V+CUu7K6B6fzsVoZSsBciWPVUfsskseu4oxn
        VQEM63EI3eRB3QD7pI8LGjg/WQzLteduv3bHNCapMQLB4o36suBeVgdk1q1R5LZunrGIT9
        H36/nUqeh8nFHe+uG5TbWCDliX9bXOQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-xR9ckmbUNTKdIEm1kTKSQA-1; Tue, 28 Mar 2023 03:33:16 -0400
X-MC-Unique: xR9ckmbUNTKdIEm1kTKSQA-1
Received: by mail-wm1-f71.google.com with SMTP id l16-20020a05600c4f1000b003ef6ed5f645so2570565wmq.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 00:33:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679988795;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RbISS+/27S6jW4bDHr8lk+wvnbdcYB3f6YGIVizM/3Y=;
        b=K6VscoZWoKeVydVuq5h5U5zpJhqoe50COUGCUao/WQGFc8hSuB20m5xeK+BrCCeze4
         rYXf8KmEx+Km4OYd1seX8BOWIyQ+I3MB/2XNh2WCDLiaAgqxX/KBYxmHi7RAxrQlra6q
         Edq/6j7sIcYGMaboY1EvtKBKoP+3GVilF6CcwONib/1TvAEDG/xPgMssSQhJnXKJATb3
         JfcZrAmw9JsS0sDK1bwLqB503OHzBaefbN/dsWmkJSN0vq9WwKY09dqsRUbccvZSLxuh
         XrEtF4aFd8NOcm/nEj11IZEmE5p9Jfv941JG1xk3Hom2/pzuAZheUE4Lb1lTLZEEwS71
         o9tQ==
X-Gm-Message-State: AO0yUKVSAryazqWzRRhquHG38EGBpO+Wl6b9T3rm9raGeCn4xi8AxO5Y
        8C9ryBemq+OQ6aVyCSkDQUQ341mLEzlD7Oy3VsDgsxy4fVYhaXKlfFYim5mqli8JWKzZzbJs8uf
        vC8EQN49eB4VJot4+h57W30WZ1hWVzjpMnX9E+P7nrP80/Vz8kr6lgMMcJ5ZHJ9C4wtwyfXz9F3
        ukIzGvtSs=
X-Received: by 2002:a7b:c5c8:0:b0:3eb:2de8:b739 with SMTP id n8-20020a7bc5c8000000b003eb2de8b739mr11276058wmk.37.1679988795203;
        Tue, 28 Mar 2023 00:33:15 -0700 (PDT)
X-Google-Smtp-Source: AK7set8lfOmpR2nW3HTghmY7jK4kUsb4kpoMtbF8MSqpuG8HfIm5O5jbiNwx/SnjQsKsrFOF8ZJmmQ==
X-Received: by 2002:a7b:c5c8:0:b0:3eb:2de8:b739 with SMTP id n8-20020a7bc5c8000000b003eb2de8b739mr11276026wmk.37.1679988794856;
        Tue, 28 Mar 2023 00:33:14 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id j6-20020a05600c190600b003ef6bc71cccsm7527075wmq.27.2023.03.28.00.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 00:33:14 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Robinson <pbrobinson@gmail.com>,
        Tom <tom@tom-fitzhenry.me.uk>,
        Robert Mader <robert.mader@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Martijn Braam <martijn@brixit.nl>, Ondrej Jirman <megi@xff.cz>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        =?UTF-8?q?Kamil=20Trzci=C5=84ski?= <ayufan@ayufan.eu>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Caleb Connolly <kc@postmarketos.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jarrah Gosbell <kernel@undef.tools>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH v3 0/2] arm64: dts: rk3399-pinephone-pro: Add display and touchscreen support
Date:   Tue, 28 Mar 2023 09:33:07 +0200
Message-Id: <20230328073309.1743112-1-javierm@redhat.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series adds support for the display and touchscreen found in the
PinePhone Pro. It's a third version that addresses issues pointed out
by Ondrej Jirman in v2:

http://lists.infradead.org/pipermail/linux-rockchip/2023-March/037889.html

Best regards,
Javier

Changes in v3:
- Fix some ./scripts/checkpatch.pl --strict warnings.
- Add Ondrej Jirman Tested-by tag.
- Change PWM period to 50000 since 20 kHz is recommended (Ondrej Jirman).
- Remove useless comments for the panel regulators (Ondrej Jirman).
- Drop unneeded pinctrl pull down conf for pins that either already have
  a pull-down resistor or are already driven by the SoC (Ondrej Jirman).
- Remove "pwm-delay-us" property not supported in mainline (Ondrej Jirman).
- Use the correct "goodix,gt1158" compatible string (Ondrej Jirman).
- Remove "poweroff-in-suspend" not supported in mainline (Ondrej Jirman).

Changes in v2:
- Drop touchscreen node because used the wrong compatible (Ondrej Jirman).
- Fix assigned-clock-parents in vopb node (Ondrej Jirman).
- Add vopl and vopl nodes.

Martijn Braam (2):
  arm64: dts: rk3399-pinephone-pro: Add internal display support
  arm64: dts: rk3399-pinephone-pro: Add touchscreen support

 .../dts/rockchip/rk3399-pinephone-pro.dts     | 114 ++++++++++++++++++
 1 file changed, 114 insertions(+)


base-commit: 3a93e40326c8f470e71d20b4c42d36767450f38f
-- 
2.40.0

