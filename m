Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F07C5F07DC
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 11:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbiI3JpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 05:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbiI3Joy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 05:44:54 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC212CE2E;
        Fri, 30 Sep 2022 02:44:49 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id v10-20020a17090a634a00b00205e48cf845so8517748pjs.4;
        Fri, 30 Sep 2022 02:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=M+Epxubk/iFdRfYWv+mlOr9Mlw7F3zdxgQKr6Zw2CgI=;
        b=c0qYuvNDSgKrq8KbFNxXn5HHPpAaZJhDH+1NpdhYmjYIufbADvhFv9ukuu3AgOcANg
         IVKmPE2b9EMjvNyeOrQmtjiQtLBbxjhGhCVoyQROuGQ4uBkxqdHlC2ktu3cpHTsIvui8
         3MKL57V7K0szOVF/Gyu0f+aZp7SUbYS8i6PsIy7yRQ7kGT0wlel2qniHHkge+uYHuv2U
         eVO9RtXbufIDnLN1eAVczf0PCYKcL6hp113XbvmCoME9keavCzjnOkF/Cb5uHmH3/Ewi
         +A0/La56b56s3+eSb+N80sLJAxql9JBPDKOBFBCOhN9N3uOm0kx2dAJQ9uCBXhGukLBF
         4Riw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=M+Epxubk/iFdRfYWv+mlOr9Mlw7F3zdxgQKr6Zw2CgI=;
        b=L4tw0ltik3StA37KnvVbNFhvFg74VOAR9LIgCDexRfNbecr4wTLSM7+gGXEMkY/QsD
         mGGNIteYpwu2T81x7DZleX+JPWccnyid6W8gjPCyY+6YhoRvIYF4lpY+1j8NK1/lHa7K
         kU+drdrI+nNUBKQyDMAx7NrZpJulyJzjghX4axEro/12hwXtEpFbqy2IyteLFzE3dEG1
         X59tfIth0594Q8F+pj16vqpD+mGPs54nKDIs8yTc70qnXnhc8HVlPGW4C2dq4DX2M3VX
         NhliIK2vQ051P9bItGdL4QZGO/sziXVq2YK6GBl3nO1VWCXqiuP86hGSYLlUxQDlivCU
         LALQ==
X-Gm-Message-State: ACrzQf35JHq2jwoecHOu+sKbfNBHqFjXqYVb57zrRv+J4+UL4sxTWip5
        U/6HpXrnuYY0uq7IoSaYG18=
X-Google-Smtp-Source: AMsMyM4V/pVRkSv83xEi89qHO/BXFCYo7xtEsm4hrVAGvtTLXoCeVR2/w9kxC1YhLFgfsU0M+ur0nw==
X-Received: by 2002:a17:902:d50f:b0:17c:1b89:20ee with SMTP id b15-20020a170902d50f00b0017c1b8920eemr3661069plg.60.1664531087767;
        Fri, 30 Sep 2022 02:44:47 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:579:1b3a:4d22:d83a:1d4a:43f1])
        by smtp.gmail.com with ESMTPSA id b7-20020a170902650700b0016dc78d0153sm1398051plk.296.2022.09.30.02.44.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Sep 2022 02:44:47 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sre@kernel.org
Cc:     mazziesaccount@gmail.com, alina_yu@richtek.com,
        cy_huang@richtek.com, alinayu829@gmail.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/3] Add Richtek RT9471 3A battery charger support
Date:   Fri, 30 Sep 2022 17:44:36 +0800
Message-Id: <1664531079-15915-1-git-send-email-u0084500@gmail.com>
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

This patch set is to add Richtek RT9471 charger support.

The RT9471/D is a highly-integrated 3A switch mode battery charge management
and system power path management device for single cell Li-Ion and Li-polymer
battery. The low impedance power path optimizes switch-mode operation
efficiency, reduces battery charging time and extends battery life during
discharging phase.

Since v7:
- Add irq wakeup capable.
- Add missing header 'module.h' for MODULE_DEVICE_TABLE.

Since v6:
- Use 'ATTRIBUTE_GROUPS' macro to simplify the attribute coding.
- Explain more details for sysoff_enable attribute.

Since v5:
- Remove one line wrapper.
- Merge header content into source file, remove header file.
- Remove 'charge_term_enable' sysfs entry and merge it into
  'charge_term_current' property control.
- Change MODULE_LICENSE from 'GPL v2' to 'GPL'.
  Following by the below discussion
  https://lore.kernel.org/all/YxAVAt2eWB3NFlrk@google.com/
- Recover all the change in sysfs-class-power.
- New a sysfs-class-power-rt9471 file.
- Remove 'charge_term_enable' sysfs entry, directly integrate it in
  'charge_term_current' power supply property control.

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

 Documentation/ABI/testing/sysfs-class-power-rt9471 |  32 +
 .../bindings/power/supply/richtek,rt9471.yaml      |  73 ++
 drivers/power/supply/Kconfig                       |  16 +
 drivers/power/supply/Makefile                      |   1 +
 drivers/power/supply/rt9471.c                      | 934 +++++++++++++++++++++
 5 files changed, 1056 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-power-rt9471
 create mode 100644 Documentation/devicetree/bindings/power/supply/richtek,rt9471.yaml
 create mode 100644 drivers/power/supply/rt9471.c

-- 
2.7.4

