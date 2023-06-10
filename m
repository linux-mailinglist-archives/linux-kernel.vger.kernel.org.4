Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72C0672ABF8
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 15:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235067AbjFJN7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 09:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234892AbjFJN7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 09:59:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3003A94;
        Sat, 10 Jun 2023 06:59:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B86C4617AA;
        Sat, 10 Jun 2023 13:59:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AA09C433D2;
        Sat, 10 Jun 2023 13:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686405562;
        bh=CpgASGMcxOiXtSqIWIJ12fQxYBImkxzjEkeKHiVV3l0=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=pPitQzMhii2/jF2k/f2DQ7qFpVls7xe94YQ+dS6CrvxB6OtLhb99O5eevRZ1PDEMu
         Fq/nn16UU28U3jdJBzGsfyly1dj1CqlzHqvNE1CGRjYVpv7lRBGkqQsT4eF81ch7EJ
         0GxFeOJgjr1YWdOYRYyHd25flQHr0/yUoOwLc0jWyKp5YfUZS8zxXc5jOyg/ZOimF3
         CWII10bp3ouXwywZEL24G4+OD4tLmwlkuhlooT0WH8JrPswjnX//A6uj1GT+4ZTWyB
         a9yM0j75Pc4Sd/Za34vne5IceqRuF5buvLJnfHdz/dY+LHVLZLbQT12KRKE+PZD3jE
         KdUdx1EL63rFw==
From:   Mark Brown <broonie@kernel.org>
Date:   Sat, 10 Jun 2023 14:59:10 +0100
Subject: [PATCH 4/5] hwmon: (tmp108) Use maple tree register cache
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230609-hwmon-maple-v1-4-8edacce86b28@kernel.org>
References: <20230609-hwmon-maple-v1-0-8edacce86b28@kernel.org>
In-Reply-To: <20230609-hwmon-maple-v1-0-8edacce86b28@kernel.org>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-bfdf5
X-Developer-Signature: v=1; a=openpgp-sha256; l=914; i=broonie@kernel.org;
 h=from:subject:message-id; bh=CpgASGMcxOiXtSqIWIJ12fQxYBImkxzjEkeKHiVV3l0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkhIGxv3mooAdtCHR/2+fVAi3jETBozXNiUKusU3UF
 9sWvBI+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZISBsQAKCRAk1otyXVSH0MgBB/
 4jRWTLGhbWRfPDMAFfRT5xo5kFIB07oByOlxQofYhkYOelOKgPWitmGOTyRw1aLbnycoGvEffWYHxj
 bJQPal1CJd3iP0V61D+8OT8fE1cWmAo1jK5WSJZm+fGozaRga736zD2HPMjcdKU8CMZlrEHLVDLjtX
 1Uls0/lMktDPa8IsF4AHkMHg0q8Vn1sxXAQtX0dn3CjEMsmcyI8U+yWI93xsQ6eSEi7KN2s2S5uTmY
 7cQOjwpKI/eLKOIfSAjVc1IUoRUrapO+BCKXL9PkfXHwsAuRA44PfQgkCE7EgFmLGAp/pjBlhDISV5
 e6hd3TqQnHta/v3DMi5wS/3gPAXPbK
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

The tmp108 is only capable of performing single register read and write
operations which means it gains no advantage from using a rbtree register
cache, convert it to using the more modern maple tree register cache
instead. This should be more efficient.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/hwmon/tmp108.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/tmp108.c b/drivers/hwmon/tmp108.c
index 43784c289a9e..f5a80d133048 100644
--- a/drivers/hwmon/tmp108.c
+++ b/drivers/hwmon/tmp108.c
@@ -318,7 +318,7 @@ static const struct regmap_config tmp108_regmap_config = {
 	.writeable_reg = tmp108_is_writeable_reg,
 	.volatile_reg = tmp108_is_volatile_reg,
 	.val_format_endian = REGMAP_ENDIAN_BIG,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 	.use_single_read = true,
 	.use_single_write = true,
 };

-- 
2.30.2

