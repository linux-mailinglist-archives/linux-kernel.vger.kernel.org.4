Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA4575FC853
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 17:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbiJLPWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 11:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbiJLPVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 11:21:54 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F05E0713
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 08:21:49 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-131dda37dddso19876907fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 08:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kwJqhNTRTFOg6KTTCmq+FiqxOKuhAXdi9Q4wCoPOfNA=;
        b=LfBzqTPrASeASfAn0654FEvZUhQFsvG64bV9qcmnJd4LbEm+rkZNvoKFu0ffJ+FNtQ
         4E6H/Gv2Q2RUfFZNewBefThDeYwq9SdFEk69iIOyc4abjB5Et0TliU2LrZpckIum6Pdz
         ut9fbok3nZ9I9AtM6ckHbIFeZvb96geiPR6f/YrmSDPz9NkoH3imxf3Bm1Q/faP/lvqi
         NjWfQnt7GfmQMkyXQB5IEfTaACIO89fSsdQT9uJKpNEORekRZz9GaeOmOB7YNA4V92f6
         2klOhMMHe1zGx/15xksX3AII8yjZ8zm+/6ZTM5rG1LhkdfocruGU+1uaC7h4N90epx+K
         lxEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kwJqhNTRTFOg6KTTCmq+FiqxOKuhAXdi9Q4wCoPOfNA=;
        b=PMVL5dlpe+CaSsX1n/dah/1kzDPDOlBmuo033mT04BFvtl4507GNcfxEeETgH3kt+n
         v6EKJ+EY0j5jpTSUsLLHIV4Ero/eB9Dh+AjDgwzZ8bkTUEqLme4CzdF0o7Dn8EJBg82T
         ePBbTfE2hqsgGPr1nPUoxJ4T0ETwDJZ2T5sd2PllVQWJy43ETkFd0gFqfqcwb6t97hel
         phFpgWH/t2WzBqRTnA+m7rHv4sIXy5QOrZmWpQSyF3+USCtEP+t5En64N5KhwvkMAmXe
         cXNsiPhegSm8PPGZYA43cqECEihqXE2ZAmkDimGRhko70IJigHgbp7PgURUAmYhYFHgt
         UU0w==
X-Gm-Message-State: ACrzQf15wU/OsPxgydatyPYHgI1KG/BsF/1VJm+2KzWfOj24aKmCNGiv
        L1CZg4//1OB7mdx2fo5nbZ3cUDaPZsvd1A==
X-Google-Smtp-Source: AMsMyM6kEsuXW3HmeI0aeXF32Wl0YnPoY7Nc/gpj1Mziw/JRUJ4FdkB+Pc2sCFKPhLu+UaFZgU1aPA==
X-Received: by 2002:a05:6870:f5a9:b0:136:3e51:eff7 with SMTP id eh41-20020a056870f5a900b001363e51eff7mr2828401oab.241.1665588109024;
        Wed, 12 Oct 2022 08:21:49 -0700 (PDT)
Received: from fedora.. ([186.122.181.28])
        by smtp.gmail.com with ESMTPSA id h21-20020aca1815000000b00342ded07a75sm6808541oih.18.2022.10.12.08.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 08:21:48 -0700 (PDT)
From:   Mauro Lima <mauro.lima@eclypsium.com>
To:     broonie@kernel.org
Cc:     mika.westerberg@linux.intel.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mauro Lima <mauro.lima@eclypsium.com>
Subject: [PATCH] spi: intel: Fix the offset to get the 64K erase opcode
Date:   Wed, 12 Oct 2022 12:21:35 -0300
Message-Id: <20221012152135.28353-1-mauro.lima@eclypsium.com>
X-Mailer: git-send-email 2.34.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to documentation, the 64K erase opcode is located in VSCC
range [16:23] instead of [8:15].
Use the proper value to shift the mask over the correct range.

Signed-off-by: Mauro Lima <mauro.lima@eclypsium.com>
---
 drivers/spi/spi-intel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-intel.c b/drivers/spi/spi-intel.c
index 55f4ee2db002..605acb1bf4b0 100644
--- a/drivers/spi/spi-intel.c
+++ b/drivers/spi/spi-intel.c
@@ -114,7 +114,7 @@
 #define ERASE_OPCODE_SHIFT		8
 #define ERASE_OPCODE_MASK		(0xff << ERASE_OPCODE_SHIFT)
 #define ERASE_64K_OPCODE_SHIFT		16
-#define ERASE_64K_OPCODE_MASK		(0xff << ERASE_OPCODE_SHIFT)
+#define ERASE_64K_OPCODE_MASK		(0xff << ERASE_64K_OPCODE_SHIFT)
 
 /* Flash descriptor fields */
 #define FLVALSIG_MAGIC			0x0ff0a55a
-- 
2.34.3

