Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD8355B54DB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 08:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbiILG5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 02:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiILG5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 02:57:11 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C861B40;
        Sun, 11 Sep 2022 23:57:11 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id m10-20020a17090a730a00b001fa986fd8eeso11451301pjk.0;
        Sun, 11 Sep 2022 23:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=SHFI7KtF/4EdUvL9JCtWG9NI+uEC+BREujAzYelFCr0=;
        b=ZoenZs8T1eI3VH2GG/2qKeGeteC0MyYGAMkIbJ4/2r8W8giEg4xR/b/AInjR1uOmwy
         f01wDHxN3PVHJzNc3ywcSBP4X8EIIkduOkUruBDMNEKOJZi+VRUyUBuqCY66PHmqwGBx
         k2xFnbPnhQmoHkzUJY+6vDIxo9vubhUPxzsjx+t+QuS8ZkdAjw2hl7Giv4up99JNjbKM
         hARowkIfLBbRkEQnU4njyHfGspLA+l7PXDTqX8kpZkbtcOfPC1XyHsHSls83STykEAFQ
         zs9vg3owIevPQzYqRGWwqxRuq7gZXojmZ7qwDNwyL5IS5VqnUBRa65iwGoYj1z9Oa+t3
         kFjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=SHFI7KtF/4EdUvL9JCtWG9NI+uEC+BREujAzYelFCr0=;
        b=M2Ds3r4Nse+5pcw/r6S+gnwX3/Sa0cVdGEH8VoF3LUd+DPCs35kK/gPS5P47bS20xe
         bvq6Q4blkDCEJTK4RDvMVmNvkBhLn9lNMWA5oDVwGmCnh268gtq0A8AlC3EedyfstqUR
         OVbImPq6NOKbzuPRfDXoZ2MooOVYs0SyrYejkHeK4HNoI6l1rnf+pzCPqW6FNGI8VS5+
         qEkQ6FvRCzh9Ebs+3L6eLfpH9pHRD81cs9RcRdUpduHNlZteM3PUQVYYTxjBE4hAQ8rI
         gZLZMUfkFpm/Y1e9T/BbrHaiIl7oVUq1Ry4JhnF8eljipyyj9Au/R7RQm7kEN0sdNgh7
         S39A==
X-Gm-Message-State: ACgBeo3VuXEsaSX5qDFLz6xRNT5WocvvS775h1Y6dFdLI0cQCiZo3Vzr
        tWkeZCIdy0MRLiGwfpMES0U=
X-Google-Smtp-Source: AA6agR7tdBNTkceKDRTuPsTep4p7iygVwqRPupyWp31GfSB6cMHQaLqbYFBlg3IzjT9JeBqruWcXTA==
X-Received: by 2002:a17:902:d4c1:b0:176:b795:c639 with SMTP id o1-20020a170902d4c100b00176b795c639mr24939860plg.154.1662965830533;
        Sun, 11 Sep 2022 23:57:10 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:569:7171:597e:5b7:9ff9:1cd5])
        by smtp.gmail.com with ESMTPSA id l12-20020a170903244c00b001743be790b4sm5044611pls.215.2022.09.11.23.57.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Sep 2022 23:57:09 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sre@kernel.org
Cc:     mazziesaccount@gmail.com, alina_yu@richtek.com,
        cy_huang@richtek.com, alinayu829@gmail.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v4 0/3] Add Richtek RT9471 3A battery charger support
Date:   Mon, 12 Sep 2022 14:57:00 +0800
Message-Id: <1662965823-17760-1-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

This patch set is to add Richtek RT9471 charger support.

The RT9471/D is a highly-integrated 3A switch mode battery charge management
and system power path management device for single cell Li-Ion and Li-polymer
battery. The low impedance power path optimizes switch-mode operation
efficiency, reduces battery charging time and extends battery life during
discharging phase.

Since v4:
- Remove the line for the owner field in driver.
- Add the documentation for sysfs entries.

Since v3:
- Move unevaluatedProperties line after $ref for binding patch.
- Add Reviewed-by tag for binding patch.

Since v2:
- Remove the properties for interrupt controller things in the binding documentation.
- Fix dtc error for typo, it's 'regulator-name', not 'regulator-compatible'.
- Add regulator min/max microamp to allow otg vbus current adjustable in example.
- Specify the active-level for charge-enable-gpios in binding example.
- Fix checkpatch error about 'foo * bar' to 'foo *bar' in psy_device_to_chip function.
- Specify the member name directly for the use of linear range.

ChiYuan Huang (3):
  dt-bindings: power: supply: Add Richtek RT9471 battery charger
  power: supply: rt9471: Add Richtek RT9471 charger driver
  Documentation: power: rt9471: Document exported sysfs entries

 Documentation/ABI/testing/sysfs-class-power        |  44 +
 .../bindings/power/supply/richtek,rt9471.yaml      |  73 ++
 drivers/power/supply/Kconfig                       |  16 +
 drivers/power/supply/Makefile                      |   1 +
 drivers/power/supply/rt9471.c                      | 952 +++++++++++++++++++++
 drivers/power/supply/rt9471.h                      |  76 ++
 6 files changed, 1162 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/richtek,rt9471.yaml
 create mode 100644 drivers/power/supply/rt9471.c
 create mode 100644 drivers/power/supply/rt9471.h

-- 
2.7.4

