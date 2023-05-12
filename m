Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82F327005C7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 12:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240762AbjELKlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 06:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240605AbjELKk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 06:40:58 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B1011FD6;
        Fri, 12 May 2023 03:40:56 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34CAekj4037117;
        Fri, 12 May 2023 05:40:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1683888046;
        bh=8SxkRosU+5sptrW+a2kD7cwTFrcO+YdyW+ZrnrbVrDI=;
        h=From:To:CC:Subject:Date;
        b=A+Vu2BrTl8l2vnucAi5N560zj9QTiMDqJbfIDyorzpwb/7FslxbkQYL1UIj3DTU3s
         sM0YSVASdrA/F7ER6T5SV0olR6d4PUp6MFKFq9VuE/RX8s/kDOl5ERojLqbeEkzkqY
         BkhIzdDjRAQYfSbAFzUPsKCvjBwiseXtsoa3yE+w=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34CAekT8014448
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 12 May 2023 05:40:46 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 12
 May 2023 05:40:46 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 12 May 2023 05:40:45 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34CAejHN011203;
        Fri, 12 May 2023 05:40:45 -0500
From:   Jayesh Choudhary <j-choudhary@ti.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <kristo@kernel.org>, <kamlesh@ti.com>, <u-kumar1@ti.com>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <j-choudhary@ti.com>
Subject: [PATCH] crypto: sa2ul: change unsafe data size limit to 255 bytes
Date:   Fri, 12 May 2023 16:10:44 +0530
Message-ID: <20230512104044.163279-1-j-choudhary@ti.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tero Kristo <t-kristo@ti.com>

256 bytes is quite often used in performance benchmarks and this size
appears to be also working just fine, so mark it as safe so that we do
not fallback to software implementation for this packet size. Otherwise
there is a strange bump up in crypto performance at 256 byte packet size.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
---
 drivers/crypto/sa2ul.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/sa2ul.h b/drivers/crypto/sa2ul.h
index 92bf97232a29..12c17a68d350 100644
--- a/drivers/crypto/sa2ul.h
+++ b/drivers/crypto/sa2ul.h
@@ -170,7 +170,7 @@ struct sa_tfm_ctx;
  * the following range, so avoid using it.
  */
 #define SA_UNSAFE_DATA_SZ_MIN	240
-#define SA_UNSAFE_DATA_SZ_MAX	256
+#define SA_UNSAFE_DATA_SZ_MAX	255
 
 struct sa_match_data;
 
-- 
2.25.1

