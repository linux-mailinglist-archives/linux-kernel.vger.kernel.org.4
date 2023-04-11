Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035896DD5B1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 10:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbjDKIeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 04:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbjDKIe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 04:34:26 -0400
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618A210C2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 01:34:22 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-94a34a0baf9so174819566b.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 01:34:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681202061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y/F/1PUJwUX6hCcJ6JDKSJ9tj5PmDrf32kZ6wJpW/Zo=;
        b=cLX5Ci11ngysjh16qUj5iEyNUSKOuzyDt+2Cyax4nBu0gXPbsHNF5Q2TDlTgTWEGfE
         FnARH6bI4n2DvHbQAV5XB4MLOBst8VluQJCBViiRyDQxSqBs8kM24apxfJe06j/G1CIg
         4r59jFT3cQTxx7MCCKhHpCUlhFvvsG2UuAbo2KVxlMW96x2BueQjHJZPY/2p4iy2L4sq
         q4cgxRFBZEiRV3krl78X1O3sGljz+VbHXbzr0W1DiKwohBt1cAmxc/xXvp5PSwCdQ1Jv
         hqKf7K8qQ3vIoZPAsSRmWSeaI8Ua1SXslfMDRIZXA9auCUlRAn0FH88OWVGiFFh4WceY
         BS4g==
X-Gm-Message-State: AAQBX9fsiLdSZIObxqL6DeWESUvm5sU/e6abQ3INatuCF3Jw9WWSkZI5
        9PCEA3xyWLvTDixfRU40GRs=
X-Google-Smtp-Source: AKy350YCqBiHLbtRNZKN4SVJvgOQBXvbh1L7W3uUwxNGnzhOI4iNjG/whS6hXTRfrF/uNHfZXjzfXw==
X-Received: by 2002:a05:6402:10c6:b0:504:b657:4cd8 with SMTP id p6-20020a05640210c600b00504b6574cd8mr3450298edu.31.1681202060806;
        Tue, 11 Apr 2023 01:34:20 -0700 (PDT)
Received: from localhost.localdomain (aftr-82-135-86-174.dynamic.mnet-online.de. [82.135.86.174])
        by smtp.googlemail.com with ESMTPSA id v13-20020a50954d000000b004fc649481basm5683178eda.58.2023.04.11.01.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 01:34:19 -0700 (PDT)
From:   Johannes Thumshirn <jth@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     JoseJavier.Rodriguez@duagon.com, Jorge.SanjuanGarcia@duagon.com,
        linux-kernel@vger.kernel.org,
        Jorge Sanjuan Garcia <jorge.sanjuangarcia@duagon.com>,
        Javier Rodriguez <josejavier.rodriguez@duagon.com>,
        Johannes Thumshirn <jth@kernel.org>
Subject: [PATCH 1/3] mcb: Return actual parsed size when reading chameleon table
Date:   Tue, 11 Apr 2023 10:33:27 +0200
Message-Id: <20230411083329.4506-2-jth@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230411083329.4506-1-jth@kernel.org>
References: <20230411083329.4506-1-jth@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Rodríguez Barbarin, José Javier <JoseJavier.Rodriguez@duagon.com>

The function chameleon_parse_cells() returns the number of cells
parsed which has an undetermined size. This return value is only
used for error checking but the number of cells is never used.

Change return value to be number of bytes parsed to allow for
memory management improvements.

Co-developed-by: Jorge Sanjuan Garcia <jorge.sanjuangarcia@duagon.com>
Signed-off-by: Jorge Sanjuan Garcia <jorge.sanjuangarcia@duagon.com>
Signed-off-by: Javier Rodriguez <josejavier.rodriguez@duagon.com>
Signed-off-by: Johannes Thumshirn <jth@kernel.org>
---
 drivers/mcb/mcb-parse.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/mcb/mcb-parse.c b/drivers/mcb/mcb-parse.c
index aa6938da0db8..2aef990f379f 100644
--- a/drivers/mcb/mcb-parse.c
+++ b/drivers/mcb/mcb-parse.c
@@ -130,7 +130,7 @@ static void chameleon_parse_bar(void __iomem *base,
 	}
 }
 
-static int chameleon_get_bar(char __iomem **base, phys_addr_t mapbase,
+static int chameleon_get_bar(void __iomem **base, phys_addr_t mapbase,
 			     struct chameleon_bar **cb)
 {
 	struct chameleon_bar *c;
@@ -179,12 +179,13 @@ int chameleon_parse_cells(struct mcb_bus *bus, phys_addr_t mapbase,
 {
 	struct chameleon_fpga_header *header;
 	struct chameleon_bar *cb;
-	char __iomem *p = base;
+	void __iomem *p = base;
 	int num_cells = 0;
 	uint32_t dtype;
 	int bar_count;
 	int ret;
 	u32 hsize;
+	u32 table_size;
 
 	hsize = sizeof(struct chameleon_fpga_header);
 
@@ -239,12 +240,16 @@ int chameleon_parse_cells(struct mcb_bus *bus, phys_addr_t mapbase,
 		num_cells++;
 	}
 
-	if (num_cells == 0)
-		num_cells = -EINVAL;
+	if (num_cells == 0) {
+		ret = -EINVAL;
+		goto free_bar;
+	}
 
+	table_size = p - base;
+	pr_debug("%d cell(s) found. Chameleon table size: 0x%04x bytes\n", num_cells, table_size);
 	kfree(cb);
 	kfree(header);
-	return num_cells;
+	return table_size;
 
 free_bar:
 	kfree(cb);
-- 
2.39.2

