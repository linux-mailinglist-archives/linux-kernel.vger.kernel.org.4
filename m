Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4F9696641
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 15:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233294AbjBNOOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 09:14:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232718AbjBNOO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 09:14:28 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A606A6F;
        Tue, 14 Feb 2023 06:13:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D4CC3CE2065;
        Tue, 14 Feb 2023 14:07:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D563C4339B;
        Tue, 14 Feb 2023 14:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676383670;
        bh=OaKxI8asQTEjsEh6yfL74O5y0APlN8V2pOfAUwHuYPE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s9uEH0FY0E59Lne0jrBhkQf1M8apaJ4Q5qecHu2ul3FABQgIuCLiaX67MlXCfJKIP
         REV6oT63TsGh2uzEnR6pEqfoZS/Mv7zRh0jY/1seyA7HVtaFiEkwLPSSIQymvZhD5j
         vC2hiiI/90K3ubqTQezm+4Z8s6GsfriFu3fYHCGHgITD9g9h8cIqdv5DgxHYPrg1hg
         7FkupLjpl02YxWT7EReno9nxekdM9ZnEy7IPxyjT7xBJ0MY/nWbprKqXaRz3c9bqGI
         J5CcAY5uJxb5lb/c/PCC4VM2plmW+gV10L7/SI1cUyuoL+hPjrQuQO771g7J/kD01N
         b4DjHYylyTrCw==
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mm@kvack.org, linux-sh@vger.kernel.org
Subject: [PATCH 2/2] sh: initialize max_mapnr
Date:   Tue, 14 Feb 2023 16:07:29 +0200
Message-Id: <20230214140729.1649961-3-rppt@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230214140729.1649961-1-rppt@kernel.org>
References: <20230214140729.1649961-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Mike Rapoport (IBM)" <rppt@kernel.org>

sh never initializes max_mapnr which is used by the generic
implementation of pfn_valid().

Initialize max_mapnr with set_max_mapnr() in sh::paging_init().

Reported-by: Guenter Roeck <linux@roeck-us.net>
Fixes: e5080a967785 ("mm, arch: add generic implementation of pfn_valid() for FLATMEM")
Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 arch/sh/mm/init.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
index 506784702430..bf1b54055316 100644
--- a/arch/sh/mm/init.c
+++ b/arch/sh/mm/init.c
@@ -301,6 +301,7 @@ void __init paging_init(void)
 	 */
 	max_low_pfn = max_pfn = memblock_end_of_DRAM() >> PAGE_SHIFT;
 	min_low_pfn = __MEMORY_START >> PAGE_SHIFT;
+	set_max_mapnr(max_low_pfn - min_low_pfn);
 
 	nodes_clear(node_online_map);
 
-- 
2.35.1

