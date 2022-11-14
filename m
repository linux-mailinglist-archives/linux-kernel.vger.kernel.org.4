Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE0E627762
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 09:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236330AbiKNIVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 03:21:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236323AbiKNIVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 03:21:01 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3602DD8;
        Mon, 14 Nov 2022 00:21:00 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id r61-20020a17090a43c300b00212f4e9cccdso13062223pjg.5;
        Mon, 14 Nov 2022 00:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I0FZVAdRpvpy7ZVNcCCnedRrqNVd3d/8wdB1h9T/kfA=;
        b=aRDRjUJ0AG42neL5MrbmzwWoe6gAIdCyz/bXBZq9i8dttD3TnOKCyPu6XxiqgwR7f2
         wJ3c/ywrXxV5p9/gBE3ELge8l6nJCYMDTwJjYPOVUJQbvHkI9zb8MjdxZlWhH7N5D5HM
         IN2tI5f9cvEyRFd+IsBQvyTpTi8k6c/YhgoHwT5mvB789yL16Fwflhpd+yVy0KiPtK8D
         1Aet/R3nfIRNsMyCqar9XMrmPlW1v0Txq/ov6/cGG1N6sIRE+gvbCD/b0JshwkT8WUxk
         H4Bf7BownJDU26yo9ki6fZ2o+/wUTkNZeGraNiCAXKrPVnB/e99wo0p2MzwXpIA2/pkG
         V4Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I0FZVAdRpvpy7ZVNcCCnedRrqNVd3d/8wdB1h9T/kfA=;
        b=2aSx0uYb3MGSvljCgMZdNoj0SiXz9Mlk+wb3YFLHrLVEgd9Tz7zA6nQA19+h7xgE4a
         yDjZnOsjzxIVXL3TDhsOj72UEmG75yDHF4eOaQxbgFTNVSfQCH1XkACZlYptyVhzaiMl
         vewAQEl7wGVgqrkhPJFsNPGe5Jiegth0VfFN0JkDrdLfH4BOHqstIDqsErJ6Ejfmh5Gn
         8orqSFU+gKDXpepQRj2ZbvWvlw9TwU3wZjTksbg6vRszYQcBW1+XLu7TlXvG8Cg9MO5r
         GJ444QkJtObXoV4c/ttO7xZ5lVHlFuUQggeUis4Nkt9mzxjJsGJuLu4bZkdSdB9hxi6p
         ZUyg==
X-Gm-Message-State: ANoB5pnIr3AWMJ7B7R6lHsYqx5GLCvo6ZPG0ui2LZAr7lM0qE56yfdzR
        F5R4OKEGq/KmWoQ9EMwIg+vO9LkFgZE=
X-Google-Smtp-Source: AA0mqf6LoX/vgZIHrcCyxuW8+uuzUvKUBS3e97QEk+flLyMk8L0KjK1q2GscsvI0Vv63mD+lMT/c/g==
X-Received: by 2002:a17:902:9f8f:b0:186:b889:dd6f with SMTP id g15-20020a1709029f8f00b00186b889dd6fmr12704804plq.97.1668414059738;
        Mon, 14 Nov 2022 00:20:59 -0800 (PST)
Received: from localhost.localdomain ([2402:7500:487:fe99:8803:61a2:a857:2b40])
        by smtp.gmail.com with ESMTPSA id o38-20020a634e66000000b004639c772878sm5419997pgl.48.2022.11.14.00.20.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Nov 2022 00:20:58 -0800 (PST)
From:   cy_huang <u0084500@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sre@kernel.org
Cc:     cy_huang@richtek.com, allen_chiang@richtek.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] Add Richtek RT9759 smart cap divider charger support
Date:   Mon, 14 Nov 2022 16:20:50 +0800
Message-Id: <1668414053-32728-1-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

This patch set is to add Richtek RT9759 smart cap divider charger.

The RT9759 is a high efficiency and high charge current charger.
The efficiency is up to 97.8% when VBAT=4.2V, IBAT=2.5A, and the maximum
charge current is up to 8A. The device integrates smart cap divider topology
with a dual-phase charge pump core and 9 channel high speed ADCs to monitor
the charging process.

Since v3:
- Fix 0002 patch title typo (from 'rt9471' to 'rt9759')
- Remove unused R_VAC_OVP range.
- Refer to ABI document, use 'status' to control battery charging, not 'online'
- Refer to ABI document, use 'online' to indicate bus state

Since v2:
- Add Reviewed-by tag for dt-binding patch
- Change ABI document date from Oct 2022 to Nov 2022 and KernelVersion
  from 6.1 to 6.2

ChiYuan Huang (3):
  dt-bindings: power: supply: Add Richtek RT9759 smart cap divider
    charger
  power: supply: rt9759: Add Richtek RT9759 smart cap divider charger
  Documentation: power: rt9759: Document exported sysfs entries

 Documentation/ABI/testing/sysfs-class-power-rt9759 |  37 ++
 .../bindings/power/supply/richtek,rt9759.yaml      |  61 ++
 drivers/power/supply/Kconfig                       |  15 +
 drivers/power/supply/Makefile                      |   1 +
 drivers/power/supply/rt9759.c                      | 613 +++++++++++++++++++++
 5 files changed, 727 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-power-rt9759
 create mode 100644 Documentation/devicetree/bindings/power/supply/richtek,rt9759.yaml
 create mode 100644 drivers/power/supply/rt9759.c

-- 
2.7.4

