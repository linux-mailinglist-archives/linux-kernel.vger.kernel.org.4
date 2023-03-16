Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 946ED6BD973
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 20:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbjCPTm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 15:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjCPTmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 15:42:23 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD2CE5008;
        Thu, 16 Mar 2023 12:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678995739; x=1710531739;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Uj6dg8HajoHWiLlcjfZ1cC5m+o7lfOdaDPvUfS+JTUc=;
  b=V0az4KmSNpQhRsXgK7F4AjZ1dyvrBdTMCIsXSUnFhoxpvn1w6T4RjfcO
   piGmFQ1WfDFSJiMFjyvg+GwFAi2sIhh37IgZVoBluYEpfy5SO/O8DRFdc
   s14Vaa+y062VyBLZJTz+M2u8r+AyzEaiUMHVXeUwF37OyHrlqEXn5JLBK
   1pK/K+gpojAtjtr8ywu3K3+9X7xY5+4SfWs/tmUhJgIpTpoLBBCT/se4P
   ZhTk1MuJ/XuaeMShPIuAHRYaGa/23ubdmOz03PkPvCEazMdTlu3C0JDl0
   TOYoexKdJNmg9Jy0We2Sjy6cRQw5+TLU8Oo1WGpmB3o8EHcKy/IjBW+Rx
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="326465427"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="326465427"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 12:42:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="823392406"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="823392406"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.251.221.172])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 12:42:16 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 3/3] perf tools: Avoid warning in do_realloc_array_as_needed()
Date:   Thu, 16 Mar 2023 21:41:56 +0200
Message-Id: <20230316194156.8320-4-adrian.hunter@intel.com>
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

do_realloc_array_as_needed() used memcpy() of zero size with a NULL
pointer. Check the size first to avoid sanitize warning.

Discovered using EXTRA_CFLAGS="-fsanitize=undefined -fsanitize=address".

Reported-by: kernel test robot <yujie.liu@intel.com>
Link: https://lore.kernel.org/oe-lkp/202303061424.6ad43294-yujie.liu@intel.com
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/util.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index b356c9f7f0c3..089208b51e68 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -524,7 +524,8 @@ int do_realloc_array_as_needed(void **arr, size_t *arr_sz, size_t x, size_t msz,
 	new_arr = calloc(new_sz, msz);
 	if (!new_arr)
 		return -ENOMEM;
-	memcpy(new_arr, *arr, *arr_sz * msz);
+	if (*arr_sz)
+		memcpy(new_arr, *arr, *arr_sz * msz);
 	if (init_val) {
 		for (i = *arr_sz; i < new_sz; i++)
 			memcpy(new_arr + (i * msz), init_val, msz);
-- 
2.34.1

