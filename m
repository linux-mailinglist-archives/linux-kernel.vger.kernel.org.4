Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9DEF6D9BEB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 17:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239694AbjDFPPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 11:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239727AbjDFPOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 11:14:49 -0400
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4E81980;
        Thu,  6 Apr 2023 08:14:48 -0700 (PDT)
Received: by mail-wm1-f46.google.com with SMTP id d11-20020a05600c3acb00b003ef6e6754c5so20277344wms.5;
        Thu, 06 Apr 2023 08:14:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680794086; x=1683386086;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VKATmeJF+Xd6RfEgdIKd/kdycc50pAq48rMDI6zu3z4=;
        b=dt+SmTvy2gx2thRpX0PbgTQkGnR50qRgsPB8Eh9n0afq9RSCNEQn4GbNyOvTfjqUJm
         W7zZ2I2n230HU6Q/ozN+wVs4VClgTivAw1HfR1Df9ELv0UBLnN9+NVrQueFfOAcgxAl3
         uYh2WZR9loalROn20tVp655TpDJAHKnc4EKUoFBvWJnv0Q1EiC9lR7KjDJGggFYiwIvn
         C9eo0+KrPfLgBu5A40eOmGznzSkgmwHZstIdZ96MSQYh014T2GZNXab/fhTWtPKjnRTF
         Cq70AtNfaMM24LLI6x2Iy488+X3O0lqsoAgA/wjmsBnP7FIqEl6FZ3Fhb65I8fxV/Xqv
         WhWw==
X-Gm-Message-State: AAQBX9cc2txjeWIOQcER1H7lZT8S6AYWZhAieFKIJ0a5IDWpZpOoWc8U
        w68K6QUz2zyaGeYM9PRSP+k=
X-Google-Smtp-Source: AKy350YOU24o0+DjVUVccG/oqlcWRmAeru9w+HwMxOWGCplLCkcR3X6veQF5xP1/2B5vxx8vQzUciA==
X-Received: by 2002:a7b:c850:0:b0:3ef:6ea4:a675 with SMTP id c16-20020a7bc850000000b003ef6ea4a675mr7787556wml.36.1680794086552;
        Thu, 06 Apr 2023 08:14:46 -0700 (PDT)
Received: from ryzen.lan (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net. [82.11.51.62])
        by smtp.gmail.com with ESMTPSA id fj12-20020a05600c0c8c00b003ef67848a21sm5560213wmb.13.2023.04.06.08.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 08:14:46 -0700 (PDT)
From:   Lucas Tanure <tanure@linux.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, jbrunet@baylibre.com,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        martin.blumenstingl@googlemail.com, narmstrong@baylibre.com,
        stefan@agner.ch, Lucas Tanure <tanure@linux.com>
Subject: [PATCH 2/2] of: fdt: Allow the kernel to mark nomap regions received from fdt
Date:   Thu,  6 Apr 2023 16:14:29 +0100
Message-Id: <20230406151429.524591-3-tanure@linux.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230406151429.524591-1-tanure@linux.com>
References: <20230406151429.524591-1-tanure@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reserved regions can be described in FDT and device trees, but FDT doesn't
provide the related flags, like nomap.
So allow the kernel to mark regions where the base and size received from
the device tree are the same as the base and region on FDT.
Here we trust that the device tree has a more updated description of the
region than the one received from FDT.

Signed-off-by: Lucas Tanure <tanure@linux.com>
---
 drivers/of/fdt.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index d1a68b6d03b3..754a7ea4f45c 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -482,11 +482,13 @@ static int __init early_init_dt_reserve_memory(phys_addr_t base,
 	if (nomap) {
 		/*
 		 * If the memory is already reserved (by another region), we
-		 * should not allow it to be marked nomap, but don't worry
-		 * if the region isn't memory as it won't be mapped.
+		 * should not allow it to be marked nomap, unless is the exact same region
+		 * (same base and size), which the kernel knows better and should be allowed to mark
+		 *  it as nomap.
+		 * But don't worry if the region isn't memory as it won't be mapped.
 		 */
-		if (memblock_overlaps_region(&memblock.memory, base, size) &&
-		    memblock_is_region_reserved(base, size))
+		if (memblock_overlaps_region(&memblock.memory, base, size) == MEMBLOCK_OVERLAPS &&
+		    memblock_is_region_reserved(base, size) == MEMBLOCK_OVERLAPS)
 			return -EBUSY;
 
 		return memblock_mark_nomap(base, size);
-- 
2.40.0

