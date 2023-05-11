Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D130D6FEF55
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 11:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237824AbjEKJwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 05:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237791AbjEKJwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 05:52:10 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A532AD18
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 02:51:36 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f4c6c4b425so10420225e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 02:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1683798695; x=1686390695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0OHd/V9Ix4o33YMmir4Y9clMG7lYBUHKDvAJeO5aW44=;
        b=B6QERsOmhTB/wzEMH4e7XD+W3iD3EdMaDAw30pwoi0gK8fs2UOO19yomXKtZcXF1eR
         auoqQZmATFHFuoTdIvBsFQeXIfrr4td0MgkKOGlaEOVI4/mL8inA0EnkUbKg7AKLCj9c
         XYC4IfMofM9NMMkyKLGwUElAiUs5ClFvpcLSzhoNCz1jNS/6gGVO3CiAc3JCZXRVrDe1
         YxHV02mxevTnL8eHYuDu1rJlFhLIXT6TbUkadj5PvM9jQKeVUaAtW3fAQQp+rrriIRIJ
         ANBshwpI3tapk7D98jxHVL0Kt8ZVFcX6bk9VkWrkGQBKNv6X/N6U8rOEJx6MWQq0YhtX
         Amlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683798695; x=1686390695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0OHd/V9Ix4o33YMmir4Y9clMG7lYBUHKDvAJeO5aW44=;
        b=kLwiSBKjHbVfyzEl9bW/bTwGjNhM5Erdg6oP7hLXfrHEE1MRZs/3d+Ej6SKa6xDdZe
         +PtxZAy3+u5BCutqRbFNz09FUnlNGRHZCYFFJvgjQqUcYmRWkeFulCoNFtn/rB90XOfl
         UIft7dE7d8XIQ98vePz2Xf2sz1bBOS6Yo039awhLKdjxU/P9iluCMk+SNm7JVTD6peI9
         7Ym1DxIOrk/cjGZPvIoyDspJUErfJruiHjqEsXOzDjuRRv5LW+SaVt9rYoPgyrWRiROw
         +uoLz0tot9jRt/xvYe9IRvgYFCOMzks49v167mzepyjFO4GZEEvtLa1tMJepATt6e97O
         jEnw==
X-Gm-Message-State: AC+VfDwnnbxz64KjCqGG/uZS9Gd6ohlQy6jlpOhUV6A0e2lZwcUhOocO
        4ngkpqmLQ6V5Y0R26kIHmfNgzw==
X-Google-Smtp-Source: ACHHUZ7b+A9M13qv/yT2hJDG79tnQl/QEB7u0rYsAjJ7HKLv20UVPzWKTFn1gusLVVxmozjX2cbLzw==
X-Received: by 2002:a7b:cb07:0:b0:3f1:7129:6b25 with SMTP id u7-20020a7bcb07000000b003f171296b25mr14539363wmj.18.1683798694748;
        Thu, 11 May 2023 02:51:34 -0700 (PDT)
Received: from baylibre-ThinkPad-T14s-Gen-2i.. (120.205.87.79.rev.sfr.net. [79.87.205.120])
        by smtp.gmail.com with ESMTPSA id z9-20020a05600c114900b003f4069417absm22389956wmz.24.2023.05.11.02.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 02:51:34 -0700 (PDT)
From:   Julien Panis <jpanis@baylibre.com>
To:     lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        corbet@lwn.net, arnd@arndb.de, gregkh@linuxfoundation.org,
        derek.kiernan@xilinx.com, dragan.cvetic@xilinx.com
Cc:     macro@orcam.me.uk, baolu.lu@linux.intel.com, yi.l.liu@intel.com,
        jirislaby@kernel.org, rostedt@goodmis.org, revest@chromium.org,
        gehao@kylinos.cn, akpm@linux-foundation.org, jgg@ziepe.ca,
        razor@blackwall.org, stephen@networkplumber.org,
        prabhakar.csengg@gmail.com, contact@emersion.fr,
        alex.williamson@redhat.com, akrowiak@linux.ibm.com,
        mark.rutland@arm.com, ye.xingchen@zte.com.cn, ojeda@kernel.org,
        me@kloenk.de, milan@mdaverde.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        sterzik@ti.com, u-kumar1@ti.com, eblanc@baylibre.com,
        jneanne@baylibre.com, aseketeli@baylibre.com
Subject: [PATCH v7 5/6] Documentation: Add TI TPS6594 PFSM
Date:   Thu, 11 May 2023 11:51:25 +0200
Message-Id: <20230511095126.105104-6-jpanis@baylibre.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230511095126.105104-1-jpanis@baylibre.com>
References: <20230511095126.105104-1-jpanis@baylibre.com>
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
index 176e8fc3f31b..7167fe38a8f1 100644
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

