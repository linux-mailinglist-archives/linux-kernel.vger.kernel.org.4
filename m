Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3D16C910C
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 22:50:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbjCYVuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 17:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbjCYVuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 17:50:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A22DB76E
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 14:49:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9E77AB80977
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 21:49:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79474C433D2;
        Sat, 25 Mar 2023 21:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679780997;
        bh=c5w2xQu/8wCXjsZH3FlKUmoCjisCwE0EABExkI+kokM=;
        h=From:Date:Subject:To:Cc:From;
        b=MJ1w+yGO1sCfU+u2xZvHX7WUy47Q+dPaiWK4tiEcNc5XVrlTmjmgYnaFKYwyWKT++
         k/cYBeWWdA05I28e+F+A22qg5YBHAe6IGPCt8iRnPbWD48+D3trnVD5IYE9mC7zedo
         cEvlMqJJ/2FHML3rEkr/rmFHwPcQtF4CkXKjBW9MHhvMRGzv9AkQQ4MNYI4XLbWd6e
         UMk0XgmUKZtF8wjvclfMIUgoI+7UmedrJ/77qJbPbnEmbve/ktIt9/HB3QHKKwhFSk
         mQyfGOY660Ku67zMc+2WptAGHZl++GfwW6dkRmneicIv4/vGLfQmUlVMxbG9C/JLOH
         USdISGwSNBB8A==
From:   Mark Brown <broonie@kernel.org>
Date:   Sat, 25 Mar 2023 21:49:49 +0000
Subject: [PATCH] regmap: Handle sparse caches in the default sync
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230325-regcache-sparse-sync-v1-1-2a890239d061@kernel.org>
X-B4-Tracking: v=1; b=H4sIAHxsH2QC/x2NwQrCQAxEf6Xk7ELdtcj6K+Ihm8ZuELYlAauU/
 rupp+HN8JgNjFXY4NZtoPwWk7k5nE8dUMU2cZDRGWIfU5/iEJQnQqocbEE1j2+jMIwXyinjNZc
 Erhb0pSg2qoe8zvo66kX5KZ//2/2x7z/4IW6ifQAAAA==
To:     linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-2eb1a
X-Developer-Signature: v=1; a=openpgp-sha256; l=881; i=broonie@kernel.org;
 h=from:subject:message-id; bh=c5w2xQu/8wCXjsZH3FlKUmoCjisCwE0EABExkI+kokM=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkH2yDfxQcy9uCTPcyJLgaGKfZgQU+LxLlQHpNKs2O
 G+LrMg2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZB9sgwAKCRAk1otyXVSH0GiVB/
 9msvwvaMBn0eEGWoLxFXegmTSPd1TfyG7NnW/FfXb8pnBH5EJI1jyVApJwOpjeD5VEniY0hrisPSwW
 AbdqSfdEWHM3bHTW6aUP5G69OhXh6omPirBHanPVF/g9kHr4u+f6tkKcGTYc8vKdRM/EHW/hsb5WNE
 dUJCL/hvxlusO/vRivHWQk79ZBuyuAzOdDqvDy4lGgKPLsDw88PDYHmNbhMSLaKfeOa4gGTAktRLr0
 T7e1CxOrXMLIJMxaYDbbwvd7IScwvaXkU6coif7bNzMPjNWwiTLBHZs7CuqvCLcJlta60lamxY7KXN
 J5NIUI3wn8OuFvnzwp0OLOMuPu5y6f
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If there is no cache entry available we will get -ENOENT from the cache
implementation, handle this gracefully and skip rather than treating it as
an error.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/regcache.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/base/regmap/regcache.c b/drivers/base/regmap/regcache.c
index 362e043e26d8..c1b020c5a6a9 100644
--- a/drivers/base/regmap/regcache.c
+++ b/drivers/base/regmap/regcache.c
@@ -311,6 +311,8 @@ static int regcache_default_sync(struct regmap *map, unsigned int min,
 			continue;
 
 		ret = regcache_read(map, reg, &val);
+		if (ret == -ENOENT)
+			continue;
 		if (ret)
 			return ret;
 

---
base-commit: e8d018dd0257f744ca50a729e3d042cf2ec9da65
change-id: 20230325-regcache-sparse-sync-5d4c939a79b3

Best regards,
-- 
Mark Brown <broonie@kernel.org>

