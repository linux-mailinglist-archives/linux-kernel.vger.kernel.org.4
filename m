Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5D8D6C8248
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 17:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbjCXQWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 12:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231671AbjCXQWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 12:22:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAEB0C170
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 09:22:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0845562BCF
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 16:22:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4959C433EF;
        Fri, 24 Mar 2023 16:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679674951;
        bh=jQ6FNRb0R/uXtkn3B/rwLhEiRBFD8xOB7uKz4XfEwWs=;
        h=From:Date:Subject:To:Cc:From;
        b=u87W/hTfLDkdVRxzgR+PL+/ELqRbGYcfuEcs09ghJQYWy4cU7QBc/Xi9d9y3Y3w+D
         CsP6TcJwSz5hnLscKw9jtIGnoHPWmtkrNp1qzFEZw03Vz0FrYjCB3EJ/wjC1PDnoy7
         ETvqAY4/ILbz1Y2pHXnuwqmT0zkEae5/BHjYL7fAvELYo0CYsTXFfAAPFxM+74UzTl
         wNiz93Tg8S+FT8WQmK9gAOPjpzLiectqk87PL/Ko+7UqV4ikud78V8sF/AX8j7pb4j
         v+3BR0+tRZHuqgcP7qm+TDopTddmVras6fZXiVTX9b0NwtcFvSjWxMyM9Zp5UHwTSK
         2ib3nOUItIqhg==
From:   Mark Brown <broonie@kernel.org>
Date:   Fri, 24 Mar 2023 16:22:26 +0000
Subject: [PATCH] regmap: Clarify error for unknown cache types
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230324-regcache-unknown-v1-1-80deecbf196b@kernel.org>
X-B4-Tracking: v=1; b=H4sIAEHOHWQC/x2NwQqDMBAFf0X23IUYrYf+Sukhia9mETZlQ2tB/
 PfGHmdgmJ0qTFDp1u1k+EiVog36S0cpB13AMjcm7/zgBj+yYUkhZfBbVy2b8jzCw00x9NeJWhZ
 DBUcLmvIZbsXWU78MT/n+T/fHcfwAPrfyUXkAAAA=
To:     linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-2eb1a
X-Developer-Signature: v=1; a=openpgp-sha256; l=1148; i=broonie@kernel.org;
 h=from:subject:message-id; bh=jQ6FNRb0R/uXtkn3B/rwLhEiRBFD8xOB7uKz4XfEwWs=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkHc5FLUeMaOk5T+jLfSXe7ou/Ir1WQvpTBC0cjW1s
 6W1p6B2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZB3ORQAKCRAk1otyXVSH0FH5B/
 93Eg3hfzW4TaRT0cvY04PmOKc6ko/BDI6KMFX/Dg0p8vCSOaIBN4iNOFD4ni2gjPlP2hunnOEXUVb0
 y8VszBNKuOlBdkkMuIDjDS3uniRNlfw3DVQnxfSeKXPUACQz31ymlojGS5XN8cljST6LZdPqTMpsxP
 st/AH0MsztZe/fvrb7Huoy5Rh13TxnjHYjRCLkwTy7nIlKrge1TEbG0ajqsyPHgud9S+kBtaaFzpZQ
 jfhqKiILPRCBuYE08MqG6AHK5ck/aCgEHg3889zU8R8By4uh6s59o7GntNI1hkarWx/aAufxe3Q8Ft
 FtjbYSI1iq1sgay4jTdDqUFyEWai96
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

The error message printed when we fail to locate the cache type the map
requested says it can't find a compress type rather than a cache type,
fix that. Since the compressed type is the only one currently compiled
conditionally it's likely to be the missing type but that might not always
be true and is still unclear.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/regcache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regcache.c b/drivers/base/regmap/regcache.c
index 362e043e26d8..4d3884294fe2 100644
--- a/drivers/base/regmap/regcache.c
+++ b/drivers/base/regmap/regcache.c
@@ -148,7 +148,7 @@ int regcache_init(struct regmap *map, const struct regmap_config *config)
 			break;
 
 	if (i == ARRAY_SIZE(cache_types)) {
-		dev_err(map->dev, "Could not match compress type: %d\n",
+		dev_err(map->dev, "Could not match cache type: %d\n",
 			map->cache_type);
 		return -EINVAL;
 	}

---
base-commit: e8d018dd0257f744ca50a729e3d042cf2ec9da65
change-id: 20230324-regcache-unknown-d4e2e06ba156

Best regards,
-- 
Mark Brown <broonie@kernel.org>

