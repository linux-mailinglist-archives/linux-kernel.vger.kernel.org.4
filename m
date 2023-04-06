Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6939C6D90E3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 09:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235420AbjDFH5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 03:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233584AbjDFH4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 03:56:44 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E137A83
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 00:56:40 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id d11-20020a05600c3acb00b003ef6e6754c5so19616594wms.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 00:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680767798; x=1683359798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TyPpsxVpWOnetTwLjLWBEhY22mWrzGD8UY2J96nDW7k=;
        b=zWiwnSsgiwxOBlt+XTfxNDIWh7S6hBxFbpT53Q6DVP73VgjAQBBiNcWHbTNm1NQ4LC
         6pqQAdRucyOvolfvPCENnsYTh4SmeXtF5xdecqq1htyHcRzHlosL7IyumDA9nNm3FyO/
         8ev3eyNOmBW0DmTdApje/h35er/G4crmmGN7T32j1zls7pRey9B2yrskW78yV8AghwbI
         jZW/QbGawSZXx6t/6fg6ycU17hrdlHEWqpZGKxPxjgszMfSibTgrseFgucOvQYQLPFzf
         88gjWSZI3rgJG+u4wRVyJZ0qLaSAts0fTE1gcWRAS8vB3rtTI6JxEIZw2PB4cCs97rae
         ysbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680767798; x=1683359798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TyPpsxVpWOnetTwLjLWBEhY22mWrzGD8UY2J96nDW7k=;
        b=4HihJwvcR8j6Pp/ueeAkB+3PT/47qMFbTFLVcqutZKeMuyWQoemKbaCFdaEKHnAhH7
         qA8XoSX1NetAzzGpkD4FNiFtK8JlGwj9k12mh3wSXq9ttDZojjBoh+KPEq32MWb6MlXi
         gHlB+tqGN2C3OTAMAZL2lgSUQ1PVp6OYzqvZRRJpXKJ+uz6ORTo5Dg9Jmvi5cnb5mH/c
         bMeaxplS9jv8iLFrQw5STSa++ifhrUHo4UqMyB53rbaX03pw3UaHkeIanJrcAJx7Cqyv
         a3plOWABC7VF/nQXkck3t46u5uNcb8hIchebdyW9PbEo064qx+PFAxWhoQCnHwPPXijv
         wOSg==
X-Gm-Message-State: AAQBX9fMrJECsLuoC0vB25VRoYgVA5uuAJmc4DqU+pITlaDLtiHRVWm3
        O3YoWvkFZ46fQDy5IMn5SSiTPA==
X-Google-Smtp-Source: AKy350aoYZBUIUjFzkBavIzTYVsfyGZA4hS+0MW4Qt/hRxTFphhsgdP0xROXbIs0nJUPg1IGPrFs/A==
X-Received: by 2002:a1c:7c12:0:b0:3ed:29e1:ed21 with SMTP id x18-20020a1c7c12000000b003ed29e1ed21mr6691164wmc.37.1680767798261;
        Thu, 06 Apr 2023 00:56:38 -0700 (PDT)
Received: from baylibre-ThinkPad-T14s-Gen-2i.. (151.31.102.84.rev.sfr.net. [84.102.31.151])
        by smtp.gmail.com with ESMTPSA id r15-20020a05600c458f00b003f03d483966sm4572651wmo.44.2023.04.06.00.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 00:56:38 -0700 (PDT)
From:   Julien Panis <jpanis@baylibre.com>
To:     lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, corbet@lwn.net, arnd@arndb.de,
        gregkh@linuxfoundation.org, derek.kiernan@xilinx.com,
        dragan.cvetic@xilinx.com
Cc:     yi.l.liu@intel.com, jgg@ziepe.ca, razor@blackwall.org,
        stephen@networkplumber.org, prabhakar.csengg@gmail.com,
        contact@emersion.fr, macro@orcam.me.uk, dsahern@kernel.org,
        alex.williamson@redhat.com, akrowiak@linux.ibm.com,
        mark.rutland@arm.com, ye.xingchen@zte.com.cn, ojeda@kernel.org,
        keescook@chromium.org, me@kloenk.de, mhiramat@kernel.org,
        milan@mdaverde.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        sterzik@ti.com, u-kumar1@ti.com, eblanc@baylibre.com,
        jneanne@baylibre.com
Subject: [PATCH v6 5/6] Documentation: Add TI TPS6594 PFSM
Date:   Thu,  6 Apr 2023 09:56:21 +0200
Message-Id: <20230406075622.8990-6-jpanis@baylibre.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230406075622.8990-1-jpanis@baylibre.com>
References: <20230406075622.8990-1-jpanis@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds documentation for the TPS6594 PFSM driver.

The PFSM controls the operational states of the TPS6594 PMIC.
Depending on the operational mode, some power domain networks
remain energized while others can be off.

Signed-off-by: Julien Panis <jpanis@baylibre.com>
---
 Documentation/misc-devices/index.rst          |  1 +
 Documentation/misc-devices/tps6594-pfsm.rst   | 87 +++++++++++++++++++
 .../userspace-api/ioctl/ioctl-number.rst      |  1 +
 3 files changed, 89 insertions(+)
 create mode 100644 Documentation/misc-devices/tps6594-pfsm.rst

diff --git a/Documentation/misc-devices/index.rst b/Documentation/misc-devices/index.rst
index 756be15a49a4..ecc40fbbcfb8 100644
--- a/Documentation/misc-devices/index.rst
+++ b/Documentation/misc-devices/index.rst
@@ -28,5 +28,6 @@ fit into other categories.
    oxsemi-tornado
    pci-endpoint-test
    spear-pcie-gadget
+   tps6594-pfsm
    uacce
    xilinx_sdfec
diff --git a/Documentation/misc-devices/tps6594-pfsm.rst b/Documentation/misc-devices/tps6594-pfsm.rst
new file mode 100644
index 000000000000..4ada37ccdcba
--- /dev/null
+++ b/Documentation/misc-devices/tps6594-pfsm.rst
@@ -0,0 +1,87 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=====================================
+Texas Instruments TPS6594 PFSM driver
+=====================================
+
+Author: Julien Panis (jpanis@baylibre.com)
+
+Overview
+========
+
+Strictly speaking, PFSM (Pre-configurable Finite State Machine) is not
+hardware. It is a piece of code.
+
+The TPS6594 PMIC (Power Management IC) integrates a state machine which
+manages operational modes. Depending on the current operational mode,
+some voltage domains remain energized while others can be off.
+
+The PFSM driver can be used to trigger transitions between configured
+states. It also provides R/W access to the device registers.
+
+Supported chips
+---------------
+
+- tps6594-q1
+- tps6593-q1
+- lp8764-q1
+
+Driver location
+===============
+
+drivers/misc/tps6594-pfsm.c
+
+Driver type definitions
+=======================
+
+include/uapi/linux/tps6594_pfsm.h
+
+Driver IOCTLs
+=============
+
+:c:macro::`PMIC_GOTO_STANDBY`
+All device resources are powered down. The processor is off, and
+no voltage domains are energized.
+
+:c:macro::`PMIC_GOTO_LP_STANDBY`
+The digital and analog functions of the PMIC, which are not
+required to be always-on, are turned off (low-power).
+
+:c:macro::`PMIC_UPDATE_PGM`
+Triggers a firmware update.
+
+:c:macro::`PMIC_SET_ACTIVE_STATE`
+One of the operational modes.
+The PMICs are fully functional and supply power to all PDN loads.
+All voltage domains are energized in both MCU and Main processor
+sections.
+
+:c:macro::`PMIC_SET_MCU_ONLY_STATE`
+One of the operational modes.
+Only the power resources assigned to the MCU Safety Island are on.
+
+:c:macro::`PMIC_SET_RETENTION_STATE`
+One of the operational modes.
+Depending on the triggers set, some DDR/GPIO voltage domains can
+remain energized, while all other domains are off to minimize
+total system power.
+
+Driver usage
+============
+
+See available PFSMs::
+
+    # ls /dev/pfsm*
+
+Dump the registers of pages 0 and 1::
+
+    # hexdump -C /dev/pfsm-0-0x48
+
+See PFSM events::
+
+    # cat /proc/interrupts
+
+Userspace code example
+----------------------
+
+samples/pfsm/pfsm-wakeup.c
diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index 0a1882e296ae..e48c92be5807 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -180,6 +180,7 @@ Code  Seq#    Include File                                           Comments
 'P'   00-0F  drivers/usb/class/usblp.c                               conflict!
 'P'   01-09  drivers/misc/pci_endpoint_test.c                        conflict!
 'P'   00-0F  xen/privcmd.h                                           conflict!
+'P'   00-05  linux/tps6594_pfsm.h                                    conflict!
 'Q'   all    linux/soundcard.h
 'R'   00-1F  linux/random.h                                          conflict!
 'R'   01     linux/rfkill.h                                          conflict!
-- 
2.37.3

