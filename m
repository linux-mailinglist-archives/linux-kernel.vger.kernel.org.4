Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40B4E73A854
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 20:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbjFVSgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 14:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbjFVSgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 14:36:15 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B782107
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 11:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687458974; x=1718994974;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xsDOxooYomhcTk6AFNyONdDmOWqSgMcW90cQxsZizYQ=;
  b=N61agU2+xjwJM878SBWBapYam4f56rJepd0os87s+kc2EMHjX1TkXfxi
   P+GYwV7KfDzu44d29ZgjlaieueKq0zzjhymKP436S1SG2JJSbAwLeFW08
   /1cFOl7wt1w6JQJ0o3fzZPBJvwpTzHFa4yioChYesmY1cM6XTe5u6gOPN
   TPREPBdTW5ZXFvknbNe8rNitWY6L1EQNXdEIR8q2UCeyZ6B38pV69sjwD
   GCFVAFjteLYWeaMPzaybAQLOtGoUqtZqPd7jUI5LRumCa2dMLABlv1Pay
   oiK7pNkfv8XpQxjERhgZmHy8vnO8MoaAY0NCqXsntS/0YUx8hrbBuYfuP
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="350336485"
X-IronPort-AV: E=Sophos;i="6.01,149,1684825200"; 
   d="scan'208";a="350336485"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 11:36:10 -0700
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="749444244"
X-IronPort-AV: E=Sophos;i="6.01,149,1684825200"; 
   d="scan'208";a="749444244"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 22 Jun 2023 11:36:08 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 724D333B; Thu, 22 Jun 2023 21:36:19 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 3/3] regmap: mmio: Remove unused 64-bit support code
Date:   Thu, 22 Jun 2023 21:36:13 +0300
Message-Id: <20230622183613.58762-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230622183613.58762-1-andriy.shevchenko@linux.intel.com>
References: <20230622183613.58762-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

regmap API does not support 64-bit data size, so
there is no point to have it in regmap MMIO.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/regmap/regmap-mmio.c | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/drivers/base/regmap/regmap-mmio.c b/drivers/base/regmap/regmap-mmio.c
index 8132b5c101c4..99d7fd85ca7d 100644
--- a/drivers/base/regmap/regmap-mmio.c
+++ b/drivers/base/regmap/regmap-mmio.c
@@ -202,15 +202,6 @@ static int regmap_mmio_noinc_write(void *context, unsigned int reg,
 				writel(swab32(valp[i]), ctx->regs + reg);
 			goto out_clk;
 		}
-#ifdef CONFIG_64BIT
-		case 8:
-		{
-			const u64 *valp = (const u64 *)val;
-			for (i = 0; i < val_count; i++)
-				writeq(swab64(valp[i]), ctx->regs + reg);
-			goto out_clk;
-		}
-#endif
 		default:
 			ret = -EINVAL;
 			goto out_clk;
@@ -227,11 +218,6 @@ static int regmap_mmio_noinc_write(void *context, unsigned int reg,
 	case 4:
 		writesl(ctx->regs + reg, (const u32 *)val, val_count);
 		break;
-#ifdef CONFIG_64BIT
-	case 8:
-		writesq(ctx->regs + reg, (const u64 *)val, val_count);
-		break;
-#endif
 	default:
 		ret = -EINVAL;
 		break;
@@ -363,11 +349,6 @@ static int regmap_mmio_noinc_read(void *context, unsigned int reg,
 	case 4:
 		readsl(ctx->regs + reg, (u32 *)val, val_count);
 		break;
-#ifdef CONFIG_64BIT
-	case 8:
-		readsq(ctx->regs + reg, (u64 *)val, val_count);
-		break;
-#endif
 	default:
 		ret = -EINVAL;
 		goto out_clk;
@@ -387,11 +368,6 @@ static int regmap_mmio_noinc_read(void *context, unsigned int reg,
 		case 4:
 			swab32_array(val, val_count);
 			break;
-#ifdef CONFIG_64BIT
-		case 8:
-			swab64_array(val, val_count);
-			break;
-#endif
 		default:
 			ret = -EINVAL;
 			break;
-- 
2.40.0.1.gaa8946217a0b

