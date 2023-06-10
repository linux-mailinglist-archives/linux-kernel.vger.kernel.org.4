Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 252E272AC00
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 16:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235200AbjFJOAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 10:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234971AbjFJOAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 10:00:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1FB3AB7
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 07:00:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 13CE86179A
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 14:00:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6B19C4339C;
        Sat, 10 Jun 2023 14:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686405604;
        bh=6Z4FFifmunnOEQkNUCdC3SgPc3F6aUQqgVA+b/ca1Qw=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=pJS5xL51RP1Jh/8ickyKGv6R2yw2FqNtJI/R5NikkDVmwyD2/18d7WjsE8/zy0CYJ
         A6K277Y/QuGRCQN/MYYdrkL7j+A7oaNxpjsE4MkNZwnArbx5Nw3i4q3YukX5kTCl6o
         Gm+UbwfV0PAc0S56awdfgYTOa25ZPFEHnRcS74aFq8xnTzjesJdfYHQXtUUYYCDPak
         78tBOD8Vbt8kYVjfV66zm6c+jZkJ/c9H7OXv9eKvR5BSm1Nc/0Sh+4u1Lk89iB1nds
         bZSv+xJcCQpQkCqLAuVINZwsIhRtWwsrqOaFrS1NaFLgMjQmvK+76/83N22bDiSQUf
         Au3C6h2TRQnuA==
From:   Mark Brown <broonie@kernel.org>
Date:   Sat, 10 Jun 2023 14:59:54 +0100
Subject: [PATCH 2/2] regulator: ltc3676: Use maple tree register cache
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230609-regulator-ltc-maple-v1-2-08c15181f8b2@kernel.org>
References: <20230609-regulator-ltc-maple-v1-0-08c15181f8b2@kernel.org>
In-Reply-To: <20230609-regulator-ltc-maple-v1-0-08c15181f8b2@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-bfdf5
X-Developer-Signature: v=1; a=openpgp-sha256; l=920; i=broonie@kernel.org;
 h=from:subject:message-id; bh=6Z4FFifmunnOEQkNUCdC3SgPc3F6aUQqgVA+b/ca1Qw=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkhIHgZh13wu23afngkhjwP1kFmYfqvVNYuQF9G1Gv
 cL3/116JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZISB4AAKCRAk1otyXVSH0IONB/
 4jdRw3u8RbVe9NwdQdZjXm9dJLge2k07dQWe1HsXLZdeTROkmhtactHRNQ5ryNeeumbm9KNRA765IK
 rqMasw0UlsXiMQczCTKXycqeBvM1n2oNWQpofKFSesQPwPR/NZTX8kDnJw+kFfcRat3b9+cKIU/Ou3
 dZipBoeTe2sNiCyPxbVDqIfOA8I7QumNqM+S9F03sa/gqSMnvN6n7eslqpHeZKN/mlyzHdvILN/HqA
 OoDocZGSVzrJykIIX4SsSBc/lTCKBDj+BCJ4BlRdLw41LwTu9cU3p4rJU++xIg9/bxc6QBVslLkg89
 pjdhVLh2BHs1wG7CY5mpfW4WN6uQ68
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ltc3676 can only support single register read and write operations
so does not benefit from block writes. This means it gets no benefit from
using the rbtree register cache over the maple tree register cache so
convert it to use maple trees instead, it is more modern.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/ltc3676.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/ltc3676.c b/drivers/regulator/ltc3676.c
index a28e6c3460f1..fa3da8134e55 100644
--- a/drivers/regulator/ltc3676.c
+++ b/drivers/regulator/ltc3676.c
@@ -261,7 +261,7 @@ static const struct regmap_config ltc3676_regmap_config = {
 	.max_register = LTC3676_CLIRQ,
 	.use_single_read = true,
 	.use_single_write = true,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 };
 
 static irqreturn_t ltc3676_isr(int irq, void *dev_id)

-- 
2.30.2

