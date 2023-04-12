Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 100E46E021E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 00:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbjDLWqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 18:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbjDLWqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 18:46:37 -0400
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A5D8693;
        Wed, 12 Apr 2023 15:46:34 -0700 (PDT)
Received: by mail-oi1-f171.google.com with SMTP id bx42so25270665oib.6;
        Wed, 12 Apr 2023 15:46:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681339594; x=1683931594;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n6IQmhNHxPjInxSQpSIu3wq6BYWmrEpb2ujMy7CJmmE=;
        b=A+++A1jG7M9J0QqMWgdmD/agkTMRSxWd5oeejJyeQhkUoyaN+I+FofW5U1v3/Q18cI
         9g3RDHOO2/Z29hwpEKNMBS2WPnddgmiJRo01G0DsgbgBvsjE54GvkZ1Dgzyx18JmfJEq
         zHHNipEZbxSIytZcPa/jWUdxdbncQOKYff/r6DPAO4nvR2jjtQ3y9IghVsJ3vEjoruML
         qsOTVfh8mEfFklx9p1PqGhH+afJ/2YYOs5jrFkrGrWE4ERBpsd+n5Qmikh0fbd623qqG
         YQBatW8dv5CxrfrCvM0QF+RFXyu/+e8OJQ+WGDgHqBJ/VUfxOJDYKGhLiTcfZcdJKvho
         lQIg==
X-Gm-Message-State: AAQBX9dlK6wYhVfOzofISHzWUi0cocv2NDcEF+OMHfNz1CshR9KPtCQN
        SHja98zoVQveU0qJAn55ZVs=
X-Google-Smtp-Source: AKy350b3kRXiEpI85ie3nrvEShAhdBFxd4KwZmrMkY60iSWqORJl20wsZIIc2xYDvXSOb8nHd/bsSg==
X-Received: by 2002:a05:6808:694:b0:38c:9f1:2c88 with SMTP id k20-20020a056808069400b0038c09f12c88mr111818oig.32.1681339593707;
        Wed, 12 Apr 2023 15:46:33 -0700 (PDT)
Received: from archfamilia.lan ([181.219.149.7])
        by smtp.gmail.com with ESMTPSA id cg9-20020a056808328900b0038beb8c1289sm50012oib.15.2023.04.12.15.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 15:46:33 -0700 (PDT)
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
Subject: [PATCH v3 1/1] of: fdt: Scan /memreserve/ last
Date:   Wed, 12 Apr 2023 18:46:20 -0400
Message-Id: <20230412224620.8909-2-tanure@linux.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230412224620.8909-1-tanure@linux.com>
References: <20230412224620.8909-1-tanure@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the order of scanning /memreserve/ and /reserved-memory node.
/reserved-memory node should go first, as it has a more updated
description of the memory regions and it can apply flags, like nomap.
Also, /memreserve/ should avoid reserving regions described in
/reserved-memory node.

Signed-off-by: Lucas Tanure <tanure@linux.com>
---
 drivers/of/fdt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index d1a68b6d03b3..c28aedd7ae1f 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -635,6 +635,9 @@ void __init early_init_fdt_scan_reserved_mem(void)
 	if (!initial_boot_params)
 		return;
 
+	fdt_scan_reserved_mem();
+	fdt_reserve_elfcorehdr();
+
 	/* Process header /memreserve/ fields */
 	for (n = 0; ; n++) {
 		fdt_get_mem_rsv(initial_boot_params, n, &base, &size);
@@ -643,8 +646,6 @@ void __init early_init_fdt_scan_reserved_mem(void)
 		memblock_reserve(base, size);
 	}
 
-	fdt_scan_reserved_mem();
-	fdt_reserve_elfcorehdr();
 	fdt_init_reserved_mem();
 }
 
-- 
2.40.0

