Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B339872FF7D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 15:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244474AbjFNNIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 09:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235231AbjFNNIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 09:08:00 -0400
X-Greylist: delayed 902 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 14 Jun 2023 06:07:55 PDT
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8004C184
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 06:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1686747170; x=1689339170;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=W4aY2dtVSQrTCXa8xdenfZv/tWJRpvPvBQU636eWqd0=;
        b=CRYYAGcLHk2xIk6mNrj1F7eWN9cavT0dVv+vKrWIb7bd/s6S3Y6xMSa8TnsNK6NO
        MjhmXjtiFo2UNKcRAbBmBN8lkbJhpBgKgQibQaYhwVePtSQSKzeIZ7oepmf9Jt5U
        PccXiQkUOamd3I+ceQpU6NB1eRYmIUFfAxf/c0GMl3Q=;
X-AuditID: ac14000a-917fe70000007ecb-5c-6489b822b1fe
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 27.84.32459.228B9846; Wed, 14 Jun 2023 14:52:50 +0200 (CEST)
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 14 Jun
 2023 14:52:50 +0200
From:   Teresa Remmet <t.remmet@phytec.de>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Robin Gong <yibin.gong@nxp.com>
CC:     <linux-kernel@vger.kernel.org>, <upstream@lists.phytec.de>
Subject: [PATCH] regulator: pca9450: Fix LDO3OUT and LDO4OUT MASK
Date:   Wed, 14 Jun 2023 14:52:40 +0200
Message-ID: <20230614125240.3946519-1-t.remmet@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJLMWRmVeSWpSXmKPExsWyRpKBR1dpR2eKwaE+K4upD5+wWfQuPcdq
        8e1KB5PF5V1z2Cy636lbdG84y+jA5rFz1l12j02rOtk8jlxdzOrR393C6rHx3Q4mj8+b5ALY
        orhsUlJzMstSi/TtErgyrn3fxVzQyl5xpXUXWwPjC9YuRk4OCQETiQXNT9m6GLk4hASWMEns
        X/GOEcJ5wiix4eE6FpAqNgENiacrTjOBJEQE5jJK3Hq/HqydWcBOYuLKq0A2B4ewgKPE8ldV
        ICaLgKrE+uPyIBW8ApYSX2Y9ZINYJi8x89J3doi4oMTJmU9YIKbISzRvnc0MYUtIHHzxAswW
        AorvunSSEaZ32rnXzBB2qMTWL9uZJjAKzEIyahaSUbOQjFrAyLyKUSg3Mzk7tSgzW68go7Ik
        NVkvJXUTIyi4RRi4djD2zfE4xMjEwXiIUYKDWUmE96lGe4oQb0piZVVqUX58UWlOavEhRmkO
        FiVx3vs9TIlCAumJJanZqakFqUUwWSYOTqkGxoWqXqnKG97dPrX9xeR+FbP5IjtWh/yv/xsa
        tlwvYzr3632HPJo+fCnSlLp4fvmh2KeXPX54nf38Y01URkN04UHZudrf1IsMu9J2OxzqfnSV
        OVP/xKKAb7K8mset1x5IKjyalRZkKVoZlFgYPWfFQbuqNXEl+zLLeXYXX3z+8iWz1fOlV2Zt
        UVFiKc5INNRiLipOBACL9VPIXAIAAA==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

L3_OUT and L4_OUT Bit fields range from Bit 0:4 and thus the
mask should be 0x1F instead of 0x0F.

Fixes: 0935ff5f1f0a ("regulator: pca9450: add pca9450 pmic driver")
Signed-off-by: Teresa Remmet <t.remmet@phytec.de>
---
 include/linux/regulator/pca9450.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/regulator/pca9450.h b/include/linux/regulator/pca9450.h
index 3c01c2bf84f5..505c908dbb81 100644
--- a/include/linux/regulator/pca9450.h
+++ b/include/linux/regulator/pca9450.h
@@ -196,11 +196,11 @@ enum {
 
 /* PCA9450_REG_LDO3_VOLT bits */
 #define LDO3_EN_MASK			0xC0
-#define LDO3OUT_MASK			0x0F
+#define LDO3OUT_MASK			0x1F
 
 /* PCA9450_REG_LDO4_VOLT bits */
 #define LDO4_EN_MASK			0xC0
-#define LDO4OUT_MASK			0x0F
+#define LDO4OUT_MASK			0x1F
 
 /* PCA9450_REG_LDO5_VOLT bits */
 #define LDO5L_EN_MASK			0xC0
-- 
2.25.1

