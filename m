Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0231D67EBEC
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 18:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234826AbjA0RD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 12:03:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234105AbjA0RDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 12:03:46 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 383ED7EFF8;
        Fri, 27 Jan 2023 09:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674838996; x=1706374996;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xv79CpMJX0N54gB4CsU1GJfMgJBj74HpxOAnf609a00=;
  b=ljfcj4/WheW/9Osj5aXcLUhjczUD6TgbY7uVs+/AMEP3R2c/EWRRnh5K
   U0jR7LzK1jK3qCkBcNGUNan15BqWs5TS4D5BYQOV9Do4SQS8e3M64OOzw
   FGv+iAMKpUpgYoVzaeIUyjbCMLzg2CC6NfushB1+/OzlWq1fOTjm+YdPD
   HwvZEnOTp4l7Vr7jWWsxUh+RuuvU2vo+KiAjjj5xPVvMq4vIS5uFuA+VJ
   G2izRcsmB9/rp1A2K3rqg8SuEeAIIrqxkBxlCXbRocO3ZXOjWZmWeHIcg
   OaxpZI2ZR2MTEYdP+c+U8D7zhBYEvgRX0rAcUCdoiKhCI9NfhZsCWv2Az
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="310754181"
X-IronPort-AV: E=Sophos;i="5.97,251,1669104000"; 
   d="scan'208";a="310754181"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 09:02:47 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="726739242"
X-IronPort-AV: E=Sophos;i="5.97,251,1669104000"; 
   d="scan'208";a="726739242"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.57.171])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 09:02:45 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 6/9] perf symbols: Allow for .plt without header
Date:   Fri, 27 Jan 2023 19:02:19 +0200
Message-Id: <20230127170222.9895-7-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230127170222.9895-1-adrian.hunter@intel.com>
References: <20230127170222.9895-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A static executable can have a .plt due to the presence of IFUNCs.
In that case the .plt does not have a header. Check for whether
there is a header by comparing the number of entries to the
number of relocation entries.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/symbol-elf.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index a002fc0bea03..8f7802097c72 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -489,6 +489,7 @@ int dso__synthesize_plt_symbols(struct dso *dso, struct symsrc *ss)
 	Elf *elf;
 	int nr = 0, err = -1;
 	struct rel_info ri = { .is_rela = false };
+	bool lazy_plt;
 
 	elf = ss->elf;
 	ehdr = ss->ehdr;
@@ -523,8 +524,10 @@ int dso__synthesize_plt_symbols(struct dso *dso, struct symsrc *ss)
 		plt_sym->end = plt_sym->start + shdr_plt.sh_size;
 		/* Use .plt.sec offset */
 		plt_offset = plt_sec_shdr.sh_offset;
+		lazy_plt = false;
 	} else {
-		plt_offset = shdr_plt.sh_offset + plt_header_size;
+		plt_offset = shdr_plt.sh_offset;
+		lazy_plt = true;
 	}
 
 	scn_dynsym = ss->dynsym;
@@ -577,6 +580,17 @@ int dso__synthesize_plt_symbols(struct dso *dso, struct symsrc *ss)
 
 	ri.is_rela = shdr_rel_plt.sh_type == SHT_RELA;
 
+	if (lazy_plt) {
+		/*
+		 * Assume a .plt with the same number of entries as the number
+		 * of relocation entries is not lazy and does not have a header.
+		 */
+		if (ri.nr_entries * plt_entry_size == shdr_plt.sh_size)
+			dso__delete_symbol(dso, plt_sym);
+		else
+			plt_offset += plt_header_size;
+	}
+
 	/*
 	 * x86 doesn't insert IFUNC relocations in .plt order, so sort to get
 	 * back in order.
-- 
2.34.1

