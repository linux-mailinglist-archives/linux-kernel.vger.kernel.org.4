Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2BD76DC67B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 14:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjDJMAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 08:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjDJMA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 08:00:29 -0400
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F208A5591;
        Mon, 10 Apr 2023 05:00:28 -0700 (PDT)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-184518754bfso2013030fac.5;
        Mon, 10 Apr 2023 05:00:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681128028; x=1683720028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hdg6OnGdhnbQDxiR6CHlfN0w6V2p30dC7To9wkPjF7U=;
        b=x/+d+Pa5raAbMOCjUJ418G45tcEHXQtCCUhIFIU/+iz9nQHdNHTKWmhGNbZ9m+Lays
         9aWtQh+57LPzNpgSsX3H7p83lKNYmEl6ZWVoa7N53fV8vYYtmEgt6MbcpMKgrcUU7z4z
         Y4nxQbXtHhsO7i3kr34SSeEhLgzHw1o00J45wMlFF6EVqBMnGNf6apFVCEH0mTn54/bi
         f6IFoLPJQtqBTHLp2s+neFPvWjXPxJ0yDe0m+4vlqgRqJgwK/YEI4nRR01hNu/VeVZC/
         Ts+ygdQEq6VwIwChnEW/3EvfJ0B0j3FkAYUFAHyE10jiGebwRFmUkNuu1FAJBx0yfEoV
         3yng==
X-Gm-Message-State: AAQBX9cPLSr8JclXo6JX7lM1bRutgP4OFGSAEdmdzHZgpCvt/7DuJqIr
        Gp7l9/tbcCFHYW8fkKxUb8c=
X-Google-Smtp-Source: AKy350bAQmqx25l+3rBkic3FytZFkAQr9CoLxY8EvZgErZmEKWzqTuGKjdy/sRVA4KxfgfAtkx8g4g==
X-Received: by 2002:a05:6870:c155:b0:180:2a5e:7f8f with SMTP id g21-20020a056870c15500b001802a5e7f8fmr6126629oad.22.1681128028235;
        Mon, 10 Apr 2023 05:00:28 -0700 (PDT)
Received: from archfamilia.lan ([181.219.149.7])
        by smtp.gmail.com with ESMTPSA id j4-20020a9d7384000000b0069f9203967bsm4141884otk.76.2023.04.10.05.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 05:00:27 -0700 (PDT)
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
Subject: [PATCH v2 1/1] of: fdt: Scan /memreserve/ last
Date:   Mon, 10 Apr 2023 08:00:17 -0400
Message-Id: <20230410120017.41664-2-tanure@linux.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230410120017.41664-1-tanure@linux.com>
References: <20230410120017.41664-1-tanure@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
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
 drivers/of/fdt.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index d1a68b6d03b3..26e608d8025d 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -635,16 +635,21 @@ void __init early_init_fdt_scan_reserved_mem(void)
 	if (!initial_boot_params)
 		return;
 
+	fdt_scan_reserved_mem();
+	fdt_reserve_elfcorehdr();
+
 	/* Process header /memreserve/ fields */
 	for (n = 0; ; n++) {
 		fdt_get_mem_rsv(initial_boot_params, n, &base, &size);
 		if (!size)
 			break;
+		if (memblock_overlaps_region(&memblock.memory, base, size) &&
+		    memblock_is_region_reserved(base, size))
+			break;
+
 		memblock_reserve(base, size);
 	}
 
-	fdt_scan_reserved_mem();
-	fdt_reserve_elfcorehdr();
 	fdt_init_reserved_mem();
 }
 
-- 
2.40.0

