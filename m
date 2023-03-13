Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C27B26B6FFF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 08:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbjCMHS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 03:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjCMHSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 03:18:22 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4811517B
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 00:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1678691899; x=1710227899;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uxphrJO53fgWyH9ueJOT+zSEyjnRIfnzD2Q0hhVeNvc=;
  b=iMdVv/a0aPgLbZKy6xmZ4Y+6laZTliaGnafPkbb0fLGAOvu5a4yLaM77
   NN1ZEzLn0q1sFPWjjR7rU6WFQS8djudbF98uoL6F5b/5YZHkfj5oZS6fU
   NVaaMcMNFsnLyKz5BVNcEiM9tqP97IT1Zg8CBCfc8DLcroQ0CBApDPxb3
   xUl9dxCT8Xj8WU5HzEnPD0PtK4sA4h3ebdivhCLO9T2La5UtNMUmR/Qsc
   nWd7e+AhZB6gNkwMaEiKMHS4onIfKIUd8ObSoVewAuME3KAdZu59hFV12
   SOD/17rsz5AxlskvX6tHnCwcrBQ2hUjmDLxkO4k1rXtD4tmJP1QKadcVz
   w==;
X-IronPort-AV: E=Sophos;i="5.98,256,1673910000"; 
   d="scan'208";a="29633085"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 13 Mar 2023 08:18:16 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Mon, 13 Mar 2023 08:18:16 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Mon, 13 Mar 2023 08:18:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1678691896; x=1710227896;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uxphrJO53fgWyH9ueJOT+zSEyjnRIfnzD2Q0hhVeNvc=;
  b=HMro8iQ49nANm+L+bGGLmG3UFd9JhjbRNpfFacT6opGwAgqJy44GJ0R+
   SVXWyqI1QBgAvgIOpBdjARatJYcqGr1Eq1i0L56Aqt9P17pO7VwZNKoox
   7hld7X4ltrF6zm34OLG6rVIGFls9B1Yu9iFAYFlqh99p+X0yAmUDNY6v1
   AubtB9sB08LKIXO8CZeQ0ypE5QFoDmoSJfdc6Tf/hJR5Se9fJw8+WhCnm
   CB6wIAmjQ79QEj/VAMtuMW7n4A+46pZYotuW/ta3uudDbSjPwVnV8yfhz
   9RpaozDUhz5Bkt1h2n4TuMwzFIoeUArnAQTVNxJhn5vxqRmgkrFS+mHcS
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,256,1673910000"; 
   d="scan'208";a="29633083"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 13 Mar 2023 08:18:16 +0100
Received: from steina-w.tq-net.de (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 9BDC2280056;
        Mon, 13 Mar 2023 08:18:16 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] regmap: cache: Return error in cache sync operations for REGCACHE_NONE
Date:   Mon, 13 Mar 2023 08:18:11 +0100
Message-Id: <20230313071812.13577-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no sense in doing a cache sync on REGCACHE_NONE regmaps.
Instead of panicking the kernel due to missing cache_ops, return an error
to client driver.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
Changes in v2:
* Reworded the reasoning in the commit message
* Use WARN_ON to indicate there is an implementation error
* Return -EINVAL instead

 drivers/base/regmap/regcache.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/base/regmap/regcache.c b/drivers/base/regmap/regcache.c
index 362e043e26d86..8031007b4887d 100644
--- a/drivers/base/regmap/regcache.c
+++ b/drivers/base/regmap/regcache.c
@@ -349,6 +349,9 @@ int regcache_sync(struct regmap *map)
 	const char *name;
 	bool bypass;
 
+	if (WARN_ON(map->cache_type == REGCACHE_NONE))
+		return -EINVAL;
+
 	BUG_ON(!map->cache_ops);
 
 	map->lock(map->lock_arg);
@@ -418,6 +421,9 @@ int regcache_sync_region(struct regmap *map, unsigned int min,
 	const char *name;
 	bool bypass;
 
+	if (WARN_ON(map->cache_type == REGCACHE_NONE))
+		return -EINVAL;
+
 	BUG_ON(!map->cache_ops);
 
 	map->lock(map->lock_arg);
-- 
2.34.1

