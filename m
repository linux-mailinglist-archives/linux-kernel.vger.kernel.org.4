Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6F66B377E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 08:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbjCJHjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 02:39:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbjCJHjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 02:39:33 -0500
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F84F31F1
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 23:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1678433962; x=1709969962;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2rW9oMWvY+NquKDnF5bLOq8e5GEMLalpiu7hkMsEjBo=;
  b=YAUb3NyWooQ+Vd/AvUw1iFoWUUTzk9L2Xu+1OioGmfCOg6pUwsn2V4z/
   3SsNzCVyfZOPlDycwZlhVbiYm0aGbwHvMoKdZRyJpm9EjrrWSoIgLLBCG
   OfvCcv+jEg7XVw8fQT3QXglYx3vp4wZRgAA113JwKIen75aPVx5UIMSFA
   HyxJY0MboXYCEOR1jSysq7QhS3UhcpjPECCvIM4eVYTGeJRcGKBIlSf6P
   T7+ADdyHHMd7Tb0LD4JqgPh/AnHqpwe3Sn2Zbr5kgZ63xP3RK0JoJIL4v
   wjZcm2HTMOodYxxmH4NvPSzi8yleF3F9mKeaI9GpQBLNWlR7SMsM6PGHR
   g==;
X-IronPort-AV: E=Sophos;i="5.98,249,1673910000"; 
   d="scan'208";a="29596581"
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
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2rW9oMWvY+NquKDnF5bLOq8e5GEMLalpiu7hkMsEjBo=;
  b=SIBj3YJi06VcVu0A2UxJudDjWg6BIt+nAcCugGlvS7a3WVzAvmecpR06
   iek8vpUKKQZaE2TpjpXKxYK9zThKulMnwA2sVUy4+47TMFj4poa39hHek
   DrwPg6Isn9N7bOLt3qF0nmUP5r2GK38PJjIRufvwzuUtgMDxGeValG2fS
   BYeThnSXyXrbFkxs54o0DfLjOoaU4NOx0k7mE+HN0ReU9i7wFb3Q5AZMH
   3WXSvNEF47GT/HSTpZoTF3kC3vQ6+CqpCZ8aUviEFibGeHVtBJkyOVsZN
   eZELXPP3H1xm9e2cR5Kx1DV7ycfAWDhSo8tKcVju2Dx3iPKRkpi913Q1C
   w==;
X-IronPort-AV: E=Sophos;i="5.98,249,1673910000"; 
   d="scan'208";a="29596579"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 10 Mar 2023 08:39:17 +0100
Received: from steina-w.tq-net.de (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 33D7D280072;
        Fri, 10 Mar 2023 08:39:17 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] regmap: cache: Fix return value
Date:   Fri, 10 Mar 2023 08:39:11 +0100
Message-Id: <20230310073911.3470892-2-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230310073911.3470892-1-alexander.stein@ew.tq-group.com>
References: <20230310073911.3470892-1-alexander.stein@ew.tq-group.com>
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

checkpatch.pl warned:
WARNING: ENOSYS means 'invalid syscall nr' and nothing else
Align the return value to regcache_drop_region().

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
This warning popped up while initially returning ENOSYS in patch 1.

But I'm wondering if returning 0 for regcache_write is correct or not.
This might be a follow-up patch though.

 drivers/base/regmap/regcache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regcache.c b/drivers/base/regmap/regcache.c
index b61763dbfc68..c13f5f8872ac 100644
--- a/drivers/base/regmap/regcache.c
+++ b/drivers/base/regmap/regcache.c
@@ -242,7 +242,7 @@ int regcache_read(struct regmap *map,
 	int ret;
 
 	if (map->cache_type == REGCACHE_NONE)
-		return -ENOSYS;
+		return -EINVAL;
 
 	BUG_ON(!map->cache_ops);
 
-- 
2.34.1

