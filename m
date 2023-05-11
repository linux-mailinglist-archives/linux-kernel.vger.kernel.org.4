Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF9006FFA9C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 21:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239451AbjEKTlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 15:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239444AbjEKTkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 15:40:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80006D078;
        Thu, 11 May 2023 12:40:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9418E6513A;
        Thu, 11 May 2023 19:40:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0FB2C4339C;
        Thu, 11 May 2023 19:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683834003;
        bh=eusArGtpQsQ/mI/dj7NQjj77kk6DhjwgGYGdfDlh95U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ti0o7oHUEbbJXtT8nd+BcAB8KFY0j9LLrie6b4Tn/MOzjE4VHfM6Lo0iGnZvaZeMH
         1pXOh7utZqSPGuarz/u/m5I3Ox5Ix4S/wPNlH1dSNUwaVHMNvwwPij+0Qp5DfnQxHS
         7QGuxLYi+BG8+gL24VY0PCxTuofdF8GKjw9PLOC6h4L5hpH2mwtlmKfsjaGVlPjj1j
         /iDsTggeUQifD4kb7869SXjH73iTiUzuew6lSUfqkUB3rWziRjzsXqoE4Qcz4nk6BX
         pFyNtTJuo7C5+uyM38MdYe8LsKgQOSHROCdgC8H8VIaAInHYS6pPf6cBgEzobRkKec
         NeMltzvFDWJCA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Lucas Tanure <tanure@linux.com>, Rob Herring <robh@kernel.org>,
        Sasha Levin <sashal@kernel.org>, robh+dt@kernel.org,
        frowand.list@gmail.com, devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 5/9] of: fdt: Scan /memreserve/ last
Date:   Thu, 11 May 2023 15:39:38 -0400
Message-Id: <20230511193945.623476-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230511193945.623476-1-sashal@kernel.org>
References: <20230511193945.623476-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Tanure <tanure@linux.com>

[ Upstream commit b413281876292de44ae84e9a9ce9d62e47f266e9 ]

Change the scanning /memreserve/ and /reserved-memory node order to fix
Kernel panic on Khadas Vim3 Board.

If /memreserve/ goes first, the memory is reserved, but nomap can't be
applied to the region. So the memory won't be used by Linux, but it is
still present in the linear map as normal memory, which allows
speculation. Legitimate access to adjacent pages will cause the CPU
to end up prefetching into them leading to Kernel panic.

So /reserved-memory node should go first, as it has a more updated
description of the memory regions and can apply flags, like nomap.

Link: https://lore.kernel.org/all/CAJX_Q+1Tjc+-TjZ6JW9X0NxEdFe=82a9626yL63j7uVD4LpxEA@mail.gmail.com/
Signed-off-by: Lucas Tanure <tanure@linux.com>
Link: https://lore.kernel.org/r/20230424113846.46382-1-tanure@linux.com
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/of/fdt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index d1a68b6d03b3f..c28aedd7ae1f7 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -635,6 +635,9 @@ void __init early_init_fdt_scan_reserved_mem(void)
 	if (!initial_boot_params)
 		return;
 
+	fdt_scan_reserved_mem();
+	fdt_reserve_elfcorehdr();
+
 	/* Process header /memreserve/ fields */
 	for (n = 0; ; n++) {
 		fdt_get_mem_rsv(initial_boot_params, n, &base, &size);
@@ -643,8 +646,6 @@ void __init early_init_fdt_scan_reserved_mem(void)
 		memblock_reserve(base, size);
 	}
 
-	fdt_scan_reserved_mem();
-	fdt_reserve_elfcorehdr();
 	fdt_init_reserved_mem();
 }
 
-- 
2.39.2

