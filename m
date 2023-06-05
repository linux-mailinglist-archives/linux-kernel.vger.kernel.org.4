Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0295C721DD3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 08:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjFEGFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 02:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjFEGFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 02:05:36 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA318DA
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 23:05:34 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-3980f2df1e7so3756420b6e.1
        for <linux-kernel@vger.kernel.org>; Sun, 04 Jun 2023 23:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20221208.gappssmtp.com; s=20221208; t=1685945134; x=1688537134;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aG+rBQmeae374bYM8rVLVqpGGBZMigs4icT8fjXvYaY=;
        b=HdjeIw6BUhEmLgzYWhC5wcosmH0h2AbfOdEF4uGIKMA8xrxXVNSZXEbNUv8JkqUu/Q
         VSpvTzV5ovZA2dgakY+LuSdKEEbkdaeC4UAoVQ1V8TrUn/VkI+8+9FjdDKfZ600sBSc9
         yz+s3z9A3cF3skEOZRYmiXECf95MIDf6GEQRme2hyIYcrOxQTllG+01WzJBi9pf1FhPi
         aPJjMuSNcr8eaMOE2EXhaBaxCazs/fdfB/mEcZleAZfRoY3PbRWbjr5mSB4EqjvyFHvN
         9E1RwAmBg8HluQjdOj7AI5HEryXkfBnCVHWbVatngKzy53OO55rC/k9OvrS5yegbYR2p
         J1lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685945134; x=1688537134;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aG+rBQmeae374bYM8rVLVqpGGBZMigs4icT8fjXvYaY=;
        b=MS0x9r0K1rnqt61jw1N5mXnMW6GGX3Ug7rGSFJ+LUChniUjfzSYhtRYjrWlUHJbtyB
         t4q2HYDPOs3fBseWi1TkoJyCtb+VLz04SDw388/7kYdl1oS2HCWkLzbp4BJXQlyNYjMP
         5y6YC08ghVaLLs+m3tG9f38GbTqk8nOjlyOyYrsWVYHtlFHyToXBUEuuBRq5PeG9akw4
         Y1z1uWBZZOei/MumkqcSCNXmws+/KVxsPcPSw6LcC7QmIVP9scsdlaROYXqwfTYv253a
         jvrigfR+aNSt/YgrK5b0HlcO9Yasw13yZVoBc7kV6o/Er9LPDmbpZmPZZTAfkyWIo6V0
         RXfA==
X-Gm-Message-State: AC+VfDxLookBB0bLYSsph2EtsCRgF5T7Eak1Zwfg0ge4yVa3e3GpFueD
        6wBUpSEozKbfIun9JGbjZ4gtCg==
X-Google-Smtp-Source: ACHHUZ71AGlS3HJzknedtzCQFzOgeTmCOlb0bmpeR1Pp+yIRXJnUbK0oexUil/w+7w8A5kb6ATSxRQ==
X-Received: by 2002:a54:410f:0:b0:398:36ac:44f1 with SMTP id l15-20020a54410f000000b0039836ac44f1mr7277183oic.7.1685945134298;
        Sun, 04 Jun 2023 23:05:34 -0700 (PDT)
Received: from yc.huaqin.com ([101.78.151.214])
        by smtp.gmail.com with ESMTPSA id 128-20020a630786000000b0053ba104c113sm5031379pgh.72.2023.06.04.23.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jun 2023 23:05:33 -0700 (PDT)
From:   Cong Yang <yangcong5@huaqin.corp-partner.google.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, dmitry.torokhov@gmail.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com, dianders@chromium.org,
        hsinyi@google.com
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Subject: [PATCH v2 0/2] Add ili9882t timing
Date:   Mon,  5 Jun 2023 14:05:22 +0800
Message-Id: <20230605060524.1178164-1-yangcong5@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ili9882t dt-bindings and timing

Changes in v2:
- PATCH 1/2: fix ran make dt_binding_check warnings/errors.
- PATCH 1/2: remove oneOf,just enum.
- Link to v1: https://lore.kernel.org/all/20230602140948.2138668-1-yangcong5@huaqin.corp-partner.google.com/

Cong Yang (2):
  dt-bindings: input: touchscreen: Add ilitek 9882T touchscreen chip
  HID: i2c-hid: elan: Add ili9882t timing

 .../bindings/input/elan,ekth6915.yaml         | 23 ++++++++++++++++---
 drivers/hid/i2c-hid/i2c-hid-of-elan.c         | 20 ++++++++++++----
 2 files changed, 36 insertions(+), 7 deletions(-)

-- 
2.25.1

