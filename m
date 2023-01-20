Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC56A674921
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 03:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjATCFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 21:05:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjATCFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 21:05:01 -0500
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A741EA5780;
        Thu, 19 Jan 2023 18:05:00 -0800 (PST)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-1322d768ba7so4781583fac.5;
        Thu, 19 Jan 2023 18:05:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8k15q3/S51QoDxMMcUo+FnVDcwFKQKTHuY334sTG8sM=;
        b=QN2zFt0lMXVWZA1IHZg7fAsjWO0FRDlTZ21/OD+gTD47RDB9bA6jq3d8bfhYyo/fMY
         cBWz5BoZ/C8iHGZWyCiwXV82XHQXzLYu4lq9vUDMl/MfA8+fY5bFbVVyRxaSOKSB7jI9
         jM97JBo93tNxuy0e4pRvNeddzFAl1WrUePrWorPRbAy0WIpDo35yvxuD7ItpiCsKNaX+
         cTkm8dAJkrrqBGFztRKQ7wC8QRMg8+fBOvs10KTmFtI/UwkzC3LuDcbvYMC22ifkLTqB
         QkogW1pOrK4H8ZAZH30Zmlknp6Ah4kmyMNSYgr0x4ZnWhagor1oBM+rEofb7WvfLqTNX
         /GfQ==
X-Gm-Message-State: AFqh2krFiqytQRZ1mMAvGcGz6Nkc2WAmUhIUJ29OoYymoxjMiPT7a0L+
        FDNOa5ubVmBhAy/31SPl+w==
X-Google-Smtp-Source: AMrXdXtGHdJVQiXKyiVSgVhhdZ22Yn5NONpdwcqmKX8L8BuNS1bgHKbQyfrFnZNVH85hwzmWhrkjrg==
X-Received: by 2002:a05:6870:9a88:b0:15e:db7a:cf6a with SMTP id hp8-20020a0568709a8800b0015edb7acf6amr7647755oab.56.1674180299855;
        Thu, 19 Jan 2023 18:04:59 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t9-20020a056870f20900b0015f193c86d2sm9507623oao.6.2023.01.19.18.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 18:04:59 -0800 (PST)
Received: (nullmailer pid 3226249 invoked by uid 1000);
        Fri, 20 Jan 2023 02:04:58 -0000
From:   Rob Herring <robh@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: mtd: partitions: Fix partition node name pattern
Date:   Thu, 19 Jan 2023 20:04:53 -0600
Message-Id: <20230120020454.3225796-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'partition' node name pattern is missing start and end anchors, so
anything is allowed before or after the regex pattern. There's no in tree
users needing that, so add anchors to the pattern.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/mtd/partitions/partitions.yaml          | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mtd/partitions/partitions.yaml b/Documentation/devicetree/bindings/mtd/partitions/partitions.yaml
index 9aca4e6c6047..2edc65e0e361 100644
--- a/Documentation/devicetree/bindings/mtd/partitions/partitions.yaml
+++ b/Documentation/devicetree/bindings/mtd/partitions/partitions.yaml
@@ -32,7 +32,7 @@ properties:
     enum: [1, 2]
 
 patternProperties:
-  "partition(-.+|@[0-9a-f]+)":
+  "^partition(-.+|@[0-9a-f]+)$":
     $ref: partition.yaml
 
 required:
-- 
2.39.0

