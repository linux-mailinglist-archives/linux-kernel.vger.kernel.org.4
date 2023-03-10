Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CBFC6B377D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 08:39:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjCJHja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 02:39:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbjCJHjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 02:39:22 -0500
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC61F2C2A
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 23:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1678433959; x=1709969959;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RVir8PNcQqVGvCKOviPPrwuzapNZGlD3K49gWLW3WRM=;
  b=YKYxce8pmuvV3NLlVTWNvNQz0Izu8XMzHPq/jUiTDeykPd88eIvMmA7p
   eg8C4lbLRcUyN4eXvE8JKb3VHNiGNtVlFk/fofx0DqG9skQKhEfF8quPm
   3rf+mSSmmRLywQEHvdwDERK97175UX3qAoJFMwy/s4kbT0TfzktES6KJQ
   pnmQOnEBvPpCI80dc7XH9JihwTNaSA1YL6zLVbQtTdBww+oQZOTFG18Yw
   nimxMMWr5SPrmeFCZVOOIj0p90yO+XKYMoOC/UnR3yxYy5p43DiGVVfc7
   DakfiPwnmAfxEiBEqIAHx8D13+VS7WWYU1CS+E1HOHKx0V6PbwHK2KZWb
   A==;
X-IronPort-AV: E=Sophos;i="5.98,249,1673910000"; 
   d="scan'208";a="29596580"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 10 Mar 2023 08:39:17 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Fri, 10 Mar 2023 08:39:17 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Fri, 10 Mar 2023 08:39:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1678433957; x=1709969957;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RVir8PNcQqVGvCKOviPPrwuzapNZGlD3K49gWLW3WRM=;
  b=k5Lm6vTrEVwK6Pr6smcQcDMz1ugMIjfmp36LKcwZI4gwSx2z+UjZp6/1
   7lSsmcrQNutaVB50ftsuLrW9ago+5rXL4vUktb5IaeiS874j6x0/m8M7C
   EtdMF9nToxxcLAQ/evEdut3UuSQ4GiTSRtcAm/txOywdZ8DhSIWziq9+o
   JQHYI4cCMWhEAQNZpHQWxloS9Sgm7IemTNqXXF5skcAI4HbLbvCBEA+Wn
   6vSnaSietokZfxhab+r5g4zmhdkvi5RurDJwrlvQEWhuLLEI4Nqmj9hLY
   B/9X6hkeyoBMn4O4j6+N1bV4UwqT7xXDP5VUTqdCmxLClKzUSV/XCng0o
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,249,1673910000"; 
   d="scan'208";a="29596578"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 10 Mar 2023 08:39:17 +0100
Received: from steina-w.tq-net.de (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 16E92280056;
        Fri, 10 Mar 2023 08:39:17 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] regmap: cache: Do not panic for REGCACHE_NONE regmap
Date:   Fri, 10 Mar 2023 08:39:10 +0100
Message-Id: <20230310073911.3470892-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most regcache operations do check for REGCACHE_NONE, before ensuring
doing BUG_ON(!map->cache_ops). The missing regcache_sync* functions
panic on REGCACHE_NONE regmaps instead. Add an early return for non-cached
ones.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 drivers/base/regmap/regcache.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/base/regmap/regcache.c b/drivers/base/regmap/regcache.c
index 362e043e26d8..b61763dbfc68 100644
--- a/drivers/base/regmap/regcache.c
+++ b/drivers/base/regmap/regcache.c
@@ -349,6 +349,9 @@ int regcache_sync(struct regmap *map)
 	const char *name;
 	bool bypass;
 
+	if (map->cache_type == REGCACHE_NONE)
+		return 0;
+
 	BUG_ON(!map->cache_ops);
 
 	map->lock(map->lock_arg);
@@ -418,6 +421,9 @@ int regcache_sync_region(struct regmap *map, unsigned int min,
 	const char *name;
 	bool bypass;
 
+	if (map->cache_type == REGCACHE_NONE)
+		return 0;
+
 	BUG_ON(!map->cache_ops);
 
 	map->lock(map->lock_arg);
-- 
2.34.1

