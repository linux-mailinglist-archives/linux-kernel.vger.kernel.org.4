Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD4EB72ABFF
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 16:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235057AbjFJOAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 10:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235011AbjFJOAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 10:00:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C6B3AA3
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 07:00:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CDD32617AA
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 14:00:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B63EC4339B;
        Sat, 10 Jun 2023 14:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686405603;
        bh=tqfDet0oyCIS8KVG5eALLTQbNkqBuqxcXgXUiMoKUs4=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=ECk9vk96n5XRT5GAw2CXS16Nh07lMfk/pZ0smHV41X+x+KcHE/q2eLq0eTksK1xXO
         JPajewjJK4Q8/+Q0YpwiAsMzwiZmQZM8jfAhNv0PW0T3iH1kMKih+tOFuMLois+vne
         fmsseia7aIxlPpgRntdpvrPY38XaSxqTtthICCgS6zj9a6VWSUBTNwXFFptBbkJFiz
         hjvJlZJilSer4F0llH09WtCXWN8qOm4K6+CQN8FfOk8bujZ7feddIQN2zUvO8bFFY1
         2HBAPVaYGhNRt1MEFnEjCbBoD3NQognRa2VEGqFTSANz6yb5L2b7wbhHJC/4AH2Z0t
         7gYYsNiPOCF7Q==
From:   Mark Brown <broonie@kernel.org>
Date:   Sat, 10 Jun 2023 14:59:53 +0100
Subject: [PATCH 1/2] regulator: ltc3589: Use maple tree register cache
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230609-regulator-ltc-maple-v1-1-08c15181f8b2@kernel.org>
References: <20230609-regulator-ltc-maple-v1-0-08c15181f8b2@kernel.org>
In-Reply-To: <20230609-regulator-ltc-maple-v1-0-08c15181f8b2@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-bfdf5
X-Developer-Signature: v=1; a=openpgp-sha256; l=943; i=broonie@kernel.org;
 h=from:subject:message-id; bh=tqfDet0oyCIS8KVG5eALLTQbNkqBuqxcXgXUiMoKUs4=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkhIHf6ALjrfw2NggwKpVQ5MPpRZOS9fZ3uDmwx4b3
 3Ivh8q2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZISB3wAKCRAk1otyXVSH0NPeB/
 9IheVHPcl1/YQhPvDv1f5hKDnwr6v3EDhSCTIoaWNO+fDDv9tRo9yaVRMKRfplWpImf5Y8Acr0m2YC
 pNxmMami5hkNWEVGq/G9YBa2/xom7Q+IVmRVTBrPO92H6W5rDXUFwYAmm9eKAUiuzHZntuzOj4N66E
 nKHdLqNZg8kKfCGFDt8xGIL0nPhE4GPIBeGiQrgBrAW/TDQVmKjN5tjNPRACMvuMRdGw0BwgEf/zlk
 wKVccykyZmHVnxMPemkJOdvs/H+5cF7sqP0zhRSXafgo5xonVSVrJC9H8xh3TeS/fcbuWuaapsWMur
 uBQQR6ZPwiV1wirDtLrY4fJNq/Pdyf
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ltc3589 can only support single register read and write operations
so does not benefit from block writes. This means it gets no benefit from
using the rbtree register cache over the maple tree register cache so
convert it to use maple trees instead, it is more modern.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/ltc3589.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/ltc3589.c b/drivers/regulator/ltc3589.c
index 359b534d8c70..06cfc165ab5f 100644
--- a/drivers/regulator/ltc3589.c
+++ b/drivers/regulator/ltc3589.c
@@ -348,7 +348,7 @@ static const struct regmap_config ltc3589_regmap_config = {
 	.num_reg_defaults = ARRAY_SIZE(ltc3589_reg_defaults),
 	.use_single_read = true,
 	.use_single_write = true,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 };
 
 static irqreturn_t ltc3589_isr(int irq, void *dev_id)

-- 
2.30.2

