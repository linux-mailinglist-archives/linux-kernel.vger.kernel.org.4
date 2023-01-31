Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6154A682D94
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 14:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbjAaNRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 08:17:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbjAaNQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 08:16:56 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF3E367DF;
        Tue, 31 Jan 2023 05:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675171013; x=1706707013;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xv79CpMJX0N54gB4CsU1GJfMgJBj74HpxOAnf609a00=;
  b=IhcUoNCcvxeTkKYkaetKU6zRIrEZ2kdUNru73cPRsr76mFGWraU7pHVW
   Sp4/mID7U3oMUcjCId2k8/nBNYoRLtikf9HZA3MNsSRf5HnZc3Ahl2Wsi
   sCnzmh/f9rjKrUQZNiw9nJyfzjZPwd2/qV0MQZ3Xd/l8/vODLmnulNehn
   chpLda/0YFBjT/T7hEy+Ai8mZTFh+bMEr3Xj3R4lmIel1PZeyWKZq4lKL
   Y2bdQsgN0Lg29VvwB0urDYZPOEvQ3x2WNlub0MKE+L7wOELw0Hz0zvuji
   WKWS9awXRJAHz9jqF5U4jpveeaLIutanZPXXzN7Yj3A3DtkMbaz48rghj
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="325534189"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="325534189"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 05:16:52 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="657864838"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="657864838"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.47.218])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 05:16:50 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH V2 6/9] perf symbols: Allow for .plt without header
Date:   Tue, 31 Jan 2023 15:16:22 +0200
Message-Id: <20230131131625.6964-7-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230131131625.6964-1-adrian.hunter@intel.com>
References: <20230131131625.6964-1-adrian.hunter@intel.com>
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

