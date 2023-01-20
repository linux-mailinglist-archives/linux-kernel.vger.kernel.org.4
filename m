Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7A367549F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 13:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjATMfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 07:35:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbjATMfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 07:35:34 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D26BCE06;
        Fri, 20 Jan 2023 04:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674218126; x=1705754126;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UxtJ1rP66dQ3RmSMBjvuUkGyB8tVAPu0JZkPBT1WvxI=;
  b=QnRWmb//iRSmbXKXl/YpxMmnxA9055P/PIqAqLlpGx2CIvaYpMth528M
   aodCoRwBm0zLgfA7/0VLCIKZ+pHWdrCrZveC6whsSS9d2bQclf0sV31kZ
   Ze42hZabzfUKsNDvSwDWM2SUGflevPo5OVYgTsZF9BK8w1NeKT5n3/3st
   nz+RpoEgvyi8nyHm+QS4sG0tkt2tjb3MlI64NOgyWMWP+XHWZ9bgUgneL
   NoF3Dwjvlc8j54BlSKAdccK0MUni+HTXUMp8c8IomCOV8WIUd3RDY6sF8
   VxRd0+XXrmsi07IBSvBaCg/Ixyfk0jK1plM6RngIOw5ZDGVsOdWy43fIh
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="387935223"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="387935223"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 04:35:26 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="692847438"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="692847438"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.251.223.163])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 04:35:24 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 05/10] perf symbols: Slightly simplify 'err' usage in dso__synthesize_plt_symbols()
Date:   Fri, 20 Jan 2023 14:34:51 +0200
Message-Id: <20230120123456.12449-6-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230120123456.12449-1-adrian.hunter@intel.com>
References: <20230120123456.12449-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return zero directly instead of needless 'goto out_elf_end' that does
the same thing. That allows 'err' to be initialized to -1 instead of
having to change its value later.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/symbol-elf.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index c6a4e6c73990..990a2c6037bb 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -384,7 +384,7 @@ int dso__synthesize_plt_symbols(struct dso *dso, struct symsrc *ss)
 	GElf_Ehdr ehdr;
 	char sympltname[1024];
 	Elf *elf;
-	int nr = 0, symidx, err = 0;
+	int nr = 0, symidx, err = -1;
 
 	if (!ss->dynsym)
 		return 0;
@@ -397,7 +397,7 @@ int dso__synthesize_plt_symbols(struct dso *dso, struct symsrc *ss)
 	dynsym_idx = ss->dynsym_idx;
 
 	if (scn_dynsym == NULL)
-		goto out_elf_end;
+		return 0;
 
 	scn_plt_rel = elf_section_by_name(elf, &ehdr, &shdr_rel_plt,
 					  ".rela.plt", NULL);
@@ -405,11 +405,9 @@ int dso__synthesize_plt_symbols(struct dso *dso, struct symsrc *ss)
 		scn_plt_rel = elf_section_by_name(elf, &ehdr, &shdr_rel_plt,
 						  ".rel.plt", NULL);
 		if (scn_plt_rel == NULL)
-			goto out_elf_end;
+			return 0;
 	}
 
-	err = -1;
-
 	if (shdr_rel_plt.sh_link != dynsym_idx)
 		goto out_elf_end;
 
-- 
2.34.1

