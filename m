Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A13245B564F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 10:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbiILIe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 04:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbiILIeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 04:34:36 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF8B2DCE;
        Mon, 12 Sep 2022 01:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662971675; x=1694507675;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c7TgFGL2ToMu95xImGg5FhbMxBsKP7FJqIbGsSEeMTo=;
  b=aQUyBIPbK3SGTt2Uu3zOTBgDIspZgKYOph9Bke82in9fQC2OLBABwP+l
   NiVMoZgcvSOuMbqW3hiTib+EaftrIEaPh2joPLHXRoh7lMUEqWeDMSp5C
   63wmvXKJAiefzbrN/5Q5Cd4UIRuEyoWknWnwE/ilrvOBH93D9LFLaHP/u
   PFXZQsolrSbBxuPzui8A4Vxy+aDTvwa8HiQQBPO5cSLUng1MSjfq5xsv+
   YpCJuoW6th/D1RgKzu5EEkfE49yFSTSWwk6sHS5VXwGJohHmjhWTLArVh
   KcwEk8PoZR3JqCHkRsjcZmwOwexbnt01cqFHgUJY8x9N2+jEfCZ9qnSXC
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10467"; a="299153628"
X-IronPort-AV: E=Sophos;i="5.93,308,1654585200"; 
   d="scan'208";a="299153628"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 01:34:35 -0700
X-IronPort-AV: E=Sophos;i="5.93,308,1654585200"; 
   d="scan'208";a="611688269"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.46.215])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 01:34:32 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 04/11] perf test: test_intel_pt.sh: Stop using expr
Date:   Mon, 12 Sep 2022 11:34:05 +0300
Message-Id: <20220912083412.7058-5-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220912083412.7058-1-adrian.hunter@intel.com>
References: <20220912083412.7058-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As suggested by shellcheck, stop using expr.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/tests/shell/test_intel_pt.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/shell/test_intel_pt.sh b/tools/perf/tests/shell/test_intel_pt.sh
index 6e40ee7261da..2be8cb03a620 100755
--- a/tools/perf/tests/shell/test_intel_pt.sh
+++ b/tools/perf/tests/shell/test_intel_pt.sh
@@ -64,14 +64,14 @@ test_system_wide_side_band()
 count_result()
 {
 	if [ $1 -eq 2 ] ; then
-		skip_cnt=`expr ${skip_cnt} \+ 1`
+		skip_cnt=$((skip_cnt + 1))
 		return
 	fi
 	if [ $1 -eq 0 ] ; then
-		ok_cnt=`expr ${ok_cnt} \+ 1`
+		ok_cnt=$((ok_cnt + 1))
 		return
 	fi
-	err_cnt=`expr ${err_cnt} \+ 1`
+	err_cnt=$((err_cnt + 1))
 }
 
 test_system_wide_side_band
-- 
2.25.1

