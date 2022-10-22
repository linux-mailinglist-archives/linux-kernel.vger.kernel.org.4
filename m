Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98809608FAF
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 23:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbiJVVNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 17:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiJVVN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 17:13:28 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57FBC7FF9A;
        Sat, 22 Oct 2022 14:13:25 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id u21so18125343edi.9;
        Sat, 22 Oct 2022 14:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C5hHs2S/RQl/JXIwHudGm/5mav5RsuOJ5skKbHJaT7M=;
        b=NmBEE6eFFqAk065UYolm1o7PT0D3spxPjIpTB1GN4doSOzS/VyF0MqEGtviFaTzcZc
         kkyskhusTgRHUEXA+SUJWNZZZMtBpySOqUoLqvRB5ZBLRjhEc9KjhLe9c5jK8ry4uTV2
         Nk789OK4t4+qNfxNc4QY99Syb9ofJ5Ow89nccso5G+zA4tp0VGicKZTAp9x+JY0nIJAz
         F+e7O3kIGx94sm6tXjxLuCdaD+lqhx63E8T/5sM8hYbr3w3szKdM8Thn11CAbYOPpln1
         t8lbqWF+RU+6NYlfHw/1fmuOYBoXOLkZUGM3TezeU14AoBjoAJHSGDkc9AdSC9EA9b48
         y46Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C5hHs2S/RQl/JXIwHudGm/5mav5RsuOJ5skKbHJaT7M=;
        b=mCVrS0wvWRyrbI4uwJMat0y8A+hV0Qo4FncYjVra9n6IZRI08gR2dhjsgPeD4mW0RN
         IGu9putT6zFaJGgkWwM72sBxrWh1k5tyQOe/1vwXjqtZlfPzR1StnC3W96pMWKx8ueMZ
         AtUZii6TxNR7Yerg1Ec/zXwrOsH5Ns7/isTLvnRmULg6cVx7r+1rOlmJr3p0s9bFeE65
         cI0pbGBl3N4o2QxKtvo8l++XRd9A8aBqWpwSJjvULDZhOhauc+XLmv1AGdDtfSPnACxJ
         EzNL1h4UHF74/v0Pb0CxusB0ReJ8r4+5wE5+Uu549mKJAb8Plfn+QOmUn5qDWQubY3tQ
         XPag==
X-Gm-Message-State: ACrzQf2u5hf2EAQYk02M//TkbooW2wThRO+dsYGUP5o4JYi9WdOTQ+rN
        IYIyBSEYhAVsnkIzrHEzKVc=
X-Google-Smtp-Source: AMsMyM4qRAuTX9xAg5+SVeocMaPvY8/QocSpU2ifwAaPqw2Fu6Q4Lo5wOHKB6Sq6ABNXP+Eq+DcSMg==
X-Received: by 2002:a17:907:3f23:b0:78e:260a:fc33 with SMTP id hq35-20020a1709073f2300b0078e260afc33mr21579377ejc.152.1666473203739;
        Sat, 22 Oct 2022 14:13:23 -0700 (PDT)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id la5-20020a170907780500b0077f20a722dfsm13382584ejc.165.2022.10.22.14.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Oct 2022 14:13:23 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Mikhail Zhilkin <csharper2005@gmail.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH V3 1/2] dt-bindings: mtd: partitions: support marking rootfs partition
Date:   Sat, 22 Oct 2022 23:13:17 +0200
Message-Id: <20221022211318.32009-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

Linux needs to know what to use as root device. On embedded devices with
flash the only common way to specify that is cmdline & root= parameter.

That solution works with U-Boot which is Linux & cmdline aware but isn't
available with all market bootloaders. Also that method is fragile:
1. Requires specific probing order on multi-flash devices
2. Uses hardcoded partitions indexes

A lot of devices use different partitioning methods. It may be
"fixed-partitions" or some dynamic partitioning (e.g. based on parts
table). For such cases allow "linux,rootfs" property to mark correct
flash partition.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
V2: Use "linux,rootfs" as more accurate. Thanks Rob.
---
 .../devicetree/bindings/mtd/partitions/fixed-partitions.yaml  | 1 +
 .../devicetree/bindings/mtd/partitions/partition.yaml         | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml b/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml
index ad3ccd250802..d66a6e3bcb56 100644
--- a/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml
+++ b/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml
@@ -84,6 +84,7 @@ examples:
         partition@0 {
             label = "filesystem";
             reg = <0x00000000 0x1 0x00000000>;
+            linux,rootfs;
         };
     };
 
diff --git a/Documentation/devicetree/bindings/mtd/partitions/partition.yaml b/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
index f1a02d840b12..a25cd23a34c0 100644
--- a/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
+++ b/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
@@ -52,6 +52,10 @@ properties:
       immune to paired-pages corruptions
     type: boolean
 
+  linux,rootfs:
+    description: Marks partition that contains root filesystem to mount and boot
+      user space from
+
 if:
   not:
     required: [ reg ]
-- 
2.34.1

