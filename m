Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37F796044C6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 14:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbiJSMOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 08:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233121AbiJSMOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 08:14:17 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81B0183D8A;
        Wed, 19 Oct 2022 04:50:43 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id bp11so28694499wrb.9;
        Wed, 19 Oct 2022 04:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/SgthmTOzp3GGabfMw1BGo5g3o2HNTfweNMsL53GOTc=;
        b=XznED3sZp9svoyHkLA1j5DhdbO8l+nPvuyUqWZcMwP52T0KIuuQWMrZIz7p9JrYekv
         sUzIoYPZXBgeqkGX7wYNW9wgLVaWBTZMMYETm/qxREwkGqRI+pg2cmwkNFAvyPUa4PjM
         xpX/x3WKxWVoKPUEV1KEJdoOszoC69e8Afbn7Aum9e0FJYhz9MemAWhhWWqOF/VgTZPc
         qSljtj7HUICXFDKR3YXI7ogC7F3bOK7tCOJ8hq1PgYVSkj/nwVVZAZ4Lja3RcToN9U2I
         eVk/3TWf1bfoMCH67WoNWUvOUyDNPjg0YWCWBwJtm/jGVl7GVSRdg5qrHZRwLblO+iy8
         FeXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/SgthmTOzp3GGabfMw1BGo5g3o2HNTfweNMsL53GOTc=;
        b=6SojIR0Txdogg/jNT0iX8FsNtnoWf6Xd6N+u3hiHfPPCjJfEU7oLUHs5QdT4WsS/Xf
         cVIuNeGAfKtVPKOk9d4zpV2pz62spE8SuCb9JQUGcBBFkhv3N+ylvDcKBO/tgrNuuSHY
         NdP+RAHWhtBOQTiRkSU8MeiflPjKBwIY97UNkQPXdZz4TAvgVTIc4BjZ9gOn4D9ZFK/J
         6tViWhKgz96CPtqHnvkviT6nvVjEsKsQl8hQq5fXeaEpVlKrZ+NuZWo5BONOa+1zRErV
         L9+gRUZBzxJwMgdHqtMPcGl9b5wcyr4MnfMDNtazP9RFXPQ54A7Xc4Lw48fDG3o6P8FA
         MxQw==
X-Gm-Message-State: ACrzQf1tyQphHATxI1ImyrjZAQa7qSx1NfHkaWqpLhT5z0m5ppNzclBu
        oAMXEN52HeSzB7OPT+6EJloHqJ/m5Rg=
X-Google-Smtp-Source: AMsMyM6nCzwdW4mWOBQs58yKiCa3tBpUd6ICc0SZWaZEyY4NDKU/gpSMnAyAhFSQBcd3Hi0b3BAl5g==
X-Received: by 2002:a17:906:eec9:b0:73d:c369:690f with SMTP id wu9-20020a170906eec900b0073dc369690fmr6449809ejb.767.1666180173514;
        Wed, 19 Oct 2022 04:49:33 -0700 (PDT)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id fg4-20020a056402548400b0045bef7cf489sm10186308edb.89.2022.10.19.04.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 04:49:32 -0700 (PDT)
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
Subject: [PATCH 1/2] dt-bindings: mtd: partitions: support marking root device partition
Date:   Wed, 19 Oct 2022 13:48:54 +0200
Message-Id: <20221019114855.31639-1-zajec5@gmail.com>
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
table). For such cases allow "linux,root-device" property to mark
correct flash partition.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 .../devicetree/bindings/mtd/partitions/fixed-partitions.yaml  | 1 +
 .../devicetree/bindings/mtd/partitions/partition.yaml         | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml b/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml
index ad3ccd250802..e627085df4fc 100644
--- a/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml
+++ b/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml
@@ -84,6 +84,7 @@ examples:
         partition@0 {
             label = "filesystem";
             reg = <0x00000000 0x1 0x00000000>;
+            linux,root-device;
         };
     };
 
diff --git a/Documentation/devicetree/bindings/mtd/partitions/partition.yaml b/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
index f1a02d840b12..671906acf1bd 100644
--- a/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
+++ b/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
@@ -52,6 +52,10 @@ properties:
       immune to paired-pages corruptions
     type: boolean
 
+  linux,root-device:
+    description: Marks partition that is a root device with filesystem to mount
+      and boot user space from
+
 if:
   not:
     required: [ reg ]
-- 
2.34.1

