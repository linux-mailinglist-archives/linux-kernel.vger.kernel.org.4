Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55EBB732302
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 01:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235249AbjFOXFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 19:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232199AbjFOXEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 19:04:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54141270E
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 16:04:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D79EB61D3D
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 23:04:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B209C433C0;
        Thu, 15 Jun 2023 23:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686870291;
        bh=8+cqmpEluGFJUjsLLUOCmEf447swesb08oyLW1en1sw=;
        h=From:Date:Subject:To:Cc:From;
        b=Fz/zbDmJxir+nK9UpEh2aBfB27t/vPAuEq35Odr8BAVk5v3dvNe8EVjYCk8L4fhyt
         ZDCf8S5VFbYMP4Z5uFL/B/jfBiMzw3lT/jCMd9k/DKMR4RTWtIAT+4FKTcjhTjJ5bg
         4aHtBEyiN97mXKok/YBFSGAvc3uEfteoMG0hb13+vZcGafzbMJb+EEVMnxz+Mvrw8w
         kclAbtUfJQV5cQs2lbSEH0qnxB000Db20Cr1BXyLUUOFq6viB7hV6UACvT7oefpy4x
         +IrZZyFBcKXzk9Bg8UeM/bbfnZUDySqc3dwPGdK8buZDOgp6GPeJf+ZEmrodSfHZa1
         /s9tUM07qtsGg==
From:   Mark Brown <broonie@kernel.org>
Date:   Fri, 16 Jun 2023 00:04:40 +0100
Subject: [PATCH] regmap: Drop early readability check
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230615-regmap-drop-early-readability-v1-1-8135094362de@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAeZi2QC/x2NQQ6CMBAAv0L27Ca0tWr8iuGwpStsxNJsjUoIf
 7d4nDnMrFBYhQtcmxWU31JkThXMoYF+pDQwSqwMtrWuPRmPysOTMkadMzLptFRDkYJM8lrQXZw
 NZ++JzRFqI1BhDEqpH/fKZ9bHrrPyXb7/7a3bth8TS8ZGhgAAAA==
To:     linux-kernel@vger.kernel.org,
        Konrad Dybcio <konradybcio@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-c6835
X-Developer-Signature: v=1; a=openpgp-sha256; l=1489; i=broonie@kernel.org;
 h=from:subject:message-id; bh=8+cqmpEluGFJUjsLLUOCmEf447swesb08oyLW1en1sw=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBki5kRpW8FX6gkrdmtBpRiHJCxgxBYszWPZJkze4iS
 MQtpGgGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZIuZEQAKCRAk1otyXVSH0BN1B/
 4mv2FA2lK9jsOxosXcMBqP7xAdOVRP27AUrJqgsfDtjfKRRYI5U7EMlLNbn7CtKp8IMOJj0vy4EO61
 BiTMsqECJkpsnygtkOo6v4ZcnHbH4jjXlW5NNGHu8UpOioeg52rcAs8OHD1+MhLFSu+MMGxPCl/Ao1
 i6/tYhPGv7NAzHZ5LeeKkli9uA975I9uvDd2LL9GVgqF2l1mUqGngynF9rnrupCKExnoyhwg5biA3Y
 VTUhAmo5unKZGQftr4XYX/BbpS8UU88VKyQtHUZ1ty1KYKeUkwjtKEEyo8KmrJ1Z9V38HCNY3kAmsU
 Xq+XChIMwVh3vAn8qioHWG0b4ijNWg
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

We have some drivers that have a use case for cached write only
registers, doing read/modify/writes on read only registers in order to
work more easily with bitfields.  Go back to trying the cache before we
check if we can read from the device.

Fixes: eab5abdeb79f0 ("regmap: Check for register readability before checking cache during read")
Reported-by: Konrad Dybcio <konradybcio@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/regmap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index fad66b309ef9..89a7f1c459c1 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -2897,9 +2897,6 @@ static int _regmap_read(struct regmap *map, unsigned int reg,
 	int ret;
 	void *context = _regmap_map_get_context(map);
 
-	if (!regmap_readable(map, reg))
-		return -EIO;
-
 	if (!map->cache_bypass) {
 		ret = regcache_read(map, reg, val);
 		if (ret == 0)
@@ -2909,6 +2906,9 @@ static int _regmap_read(struct regmap *map, unsigned int reg,
 	if (map->cache_only)
 		return -EBUSY;
 
+	if (!regmap_readable(map, reg))
+		return -EIO;
+
 	ret = map->reg_read(context, reg, val);
 	if (ret == 0) {
 		if (regmap_should_log(map))

---
base-commit: 505cb70cd27abde24bd48b2c9a539cca485d722f
change-id: 20230615-regmap-drop-early-readability-3832b755ae14

Best regards,
-- 
Mark Brown <broonie@kernel.org>

