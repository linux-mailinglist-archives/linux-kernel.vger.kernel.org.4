Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABDA875058F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 13:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbjGLLHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 07:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjGLLHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 07:07:24 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965489B;
        Wed, 12 Jul 2023 04:07:22 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36CB71Jh059296;
        Wed, 12 Jul 2023 06:07:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1689160021;
        bh=yiHVCuGsiZlkPhosVF3FExflDykcFxP77ZaPzD4NRuc=;
        h=From:To:CC:Subject:Date;
        b=EY9mW132s/McC77oCAabadzdYEFL490+Jc0NcpeFLgPBc+NhLnWtPutycy51fUkhd
         0BEzodw/3KqPUQDa5a1nQ67JjrJVmXW+EEw+jCNT5SAIaXRAdsXQeBknYH19fFsCIH
         a8mZ9KN6fhaGsfAbyJ0qtj8QGtG7CBBx0e1h2Tio=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36CB71NJ035772
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 Jul 2023 06:07:01 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 12
 Jul 2023 06:07:01 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 12 Jul 2023 06:07:01 -0500
Received: from uda0492258.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36CB6vDu018727;
        Wed, 12 Jul 2023 06:06:58 -0500
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
To:     <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <rogerq@kernel.org>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH net] net: ethernet: ti: cpsw_ale: Fix cpsw_ale_get_field()/cpsw_ale_set_field()
Date:   Wed, 12 Jul 2023 16:36:57 +0530
Message-ID: <20230712110657.1282499-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tanmay Patil <t-patil@ti.com>

CPSW ALE has 75 bit ALE entries which are stored within three 32 bit words.
The cpsw_ale_get_field() and cpsw_ale_set_field() functions assume that the
field will be strictly contained within one word. However, this is not
guaranteed to be the case and it is possible for ALE field entries to span
across up to two words at the most.

Fix the methods to handle getting/setting fields spanning up to two words.

Fixes: db82173f23c5 ("netdev: driver: ethernet: add cpsw address lookup engine support")
Signed-off-by: Tanmay Patil <t-patil@ti.com>
[s-vadapalli@ti.com: rephrased commit message and added Fixes tag]
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 drivers/net/ethernet/ti/cpsw_ale.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw_ale.c b/drivers/net/ethernet/ti/cpsw_ale.c
index 0c5e783e574c..64bf22cd860c 100644
--- a/drivers/net/ethernet/ti/cpsw_ale.c
+++ b/drivers/net/ethernet/ti/cpsw_ale.c
@@ -106,23 +106,37 @@ struct cpsw_ale_dev_id {
 
 static inline int cpsw_ale_get_field(u32 *ale_entry, u32 start, u32 bits)
 {
-	int idx;
+	int idx, idx2;
+	u32 hi_val = 0;
 
 	idx    = start / 32;
+	idx2 = (start + bits - 1) / 32;
+	/* Check if bits to be fetched exceed a word */
+	if (idx != idx2) {
+		idx2 = 2 - idx2; /* flip */
+		hi_val = ale_entry[idx2] << ((idx2 * 32) - start);
+	}
 	start -= idx * 32;
 	idx    = 2 - idx; /* flip */
-	return (ale_entry[idx] >> start) & BITMASK(bits);
+	return (hi_val + (ale_entry[idx] >> start)) & BITMASK(bits);
 }
 
 static inline void cpsw_ale_set_field(u32 *ale_entry, u32 start, u32 bits,
 				      u32 value)
 {
-	int idx;
+	int idx, idx2;
 
 	value &= BITMASK(bits);
-	idx    = start / 32;
+	idx = start / 32;
+	idx2 = (start + bits - 1) / 32;
+	/* Check if bits to be set exceed a word */
+	if (idx != idx2) {
+		idx2 = 2 - idx2; /* flip */
+		ale_entry[idx2] &= ~(BITMASK(bits + start - (idx2 * 32)));
+		ale_entry[idx2] |= (value >> ((idx2 * 32) - start));
+	}
 	start -= idx * 32;
-	idx    = 2 - idx; /* flip */
+	idx = 2 - idx; /* flip */
 	ale_entry[idx] &= ~(BITMASK(bits) << start);
 	ale_entry[idx] |=  (value << start);
 }
-- 
2.34.1

