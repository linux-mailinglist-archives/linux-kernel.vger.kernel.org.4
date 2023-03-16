Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA09F6BD971
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 20:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbjCPTmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 15:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjCPTmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 15:42:15 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8296E442CB;
        Thu, 16 Mar 2023 12:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678995734; x=1710531734;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eIZyYOcJoDlch2zoEcNQZVhXa/4V+wzyFtHKXdVX4jU=;
  b=ZVai50OVrZ/OOMm+iJC3qqv6EpZsNG//b23JljgSC7dhH3Ge8M0Q1lfH
   6sILO94ZEox0Z4R+ya5mU4IcA8snIdt+CoA70+FBG2vgd1IFFZPwM2GCP
   Wg/bGCdWDaW1GGeLGBtuxZzgSyBULOlq8iTIIsg3PWBw3HbSBSYcvslPj
   9VngzW52hDt0dEpOz8yGBNqGTmd0h5GxH9wz+EuS9iEFLg8ffkMVtrGNs
   uuiQ/KjNqSv1rCiMZNO3JYDbSdMqirPdxcvZYUqB6PUQFFIRUprOe8O1U
   gqWeMOhCwieiGGWXRH+WOGEEqhR0WeKWIH4b6sPF8jKEC3n3PmeOtpHhl
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="326465402"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="326465402"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 12:42:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="823392391"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="823392391"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.251.221.172])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 12:42:12 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 1/3] perf symbols: Fix use-after-free in get_plt_got_name()
Date:   Thu, 16 Mar 2023 21:41:54 +0200
Message-Id: <20230316194156.8320-2-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230316194156.8320-1-adrian.hunter@intel.com>
References: <20230316194156.8320-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix use-after-free in get_plt_got_name().

Discovered using EXTRA_CFLAGS="-fsanitize=undefined -fsanitize=address".

Reported-by: kernel test robot <yujie.liu@intel.com>
Link: https://lore.kernel.org/oe-lkp/202303061424.6ad43294-yujie.liu@intel.com
Fixes: ce4c8e7966f3 ("perf symbols: Get symbols for .plt.got for x86-64")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/symbol-elf.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index c0a2de42c51b..7ef5f6d7d415 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -557,6 +557,7 @@ static bool get_plt_got_name(GElf_Shdr *shdr, size_t i,
 	const char *sym_name;
 	char *demangled;
 	GElf_Sym sym;
+	bool result;
 	u32 disp;
 
 	if (!di->sorted)
@@ -583,9 +584,11 @@ static bool get_plt_got_name(GElf_Shdr *shdr, size_t i,
 
 	snprintf(buf, buf_sz, "%s@plt", sym_name);
 
+	result = *sym_name;
+
 	free(demangled);
 
-	return *sym_name;
+	return result;
 }
 
 static int dso__synthesize_plt_got_symbols(struct dso *dso, Elf *elf,
-- 
2.34.1

