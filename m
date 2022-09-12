Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4A55B564D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 10:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbiILIet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 04:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbiILIec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 04:34:32 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B50DB2A;
        Mon, 12 Sep 2022 01:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662971671; x=1694507671;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NJc/hTioHCdfuSYNEzedGGrqLQLSzj9kvnpmuTm90lA=;
  b=kOynKcwDRBJDoD6tlICTLnbAySnvizvx9Htd+3aBVTAhi2hyNdw7vWx5
   2XsA0iOLlS7QVXYEzZ/l8XWTkgM2d4x3wkuRuRJVcycaNSG1sa6pUgzVG
   WFfg2beHv9TbWKXAiaVSjOF7S7WzKRRec0JZ0srTC7nG7/re1aTisD+7B
   fbcrEYqYVZHj7hCvqNpwqe45w8clAWKLOrfudejLgqGyISWtqvB4qKEfN
   +7fzh1H6I2m1ZJgSmjkLK1p2q++S5itZK524UWAuxcFg9cxu873abVrcR
   sWkSaL70FyVcgg4Ic54J1vNFoIUzQZXrimHm9ZTnTMt0X58MFzM3dtTkm
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10467"; a="299153614"
X-IronPort-AV: E=Sophos;i="5.93,308,1654585200"; 
   d="scan'208";a="299153614"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 01:34:30 -0700
X-IronPort-AV: E=Sophos;i="5.93,308,1654585200"; 
   d="scan'208";a="611688251"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.46.215])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 01:34:28 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 02/11] perf test: test_intel_pt.sh: Use a temp directory
Date:   Mon, 12 Sep 2022 11:34:03 +0300
Message-Id: <20220912083412.7058-3-adrian.hunter@intel.com>
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

Create a directory for temporary files so that mktemp needs to be used
only once. It also enables more temp files to be added without having to
add them also to the cleanup.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/tests/shell/test_intel_pt.sh | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tools/perf/tests/shell/test_intel_pt.sh b/tools/perf/tests/shell/test_intel_pt.sh
index 17338e6a6f99..872ee0d89d38 100755
--- a/tools/perf/tests/shell/test_intel_pt.sh
+++ b/tools/perf/tests/shell/test_intel_pt.sh
@@ -11,14 +11,20 @@ skip_cnt=0
 ok_cnt=0
 err_cnt=0
 
-tmpfile=`mktemp`
-perfdatafile=`mktemp`
+temp_dir=$(mktemp -d /tmp/perf-test-intel-pt-sh.XXXXXXXXXX)
+
+tmpfile="${temp_dir}/tmp-perf.data"
+perfdatafile="${temp_dir}/test-perf.data"
 
 cleanup()
 {
 	trap - EXIT TERM INT
-	rm -f ${tmpfile}
-	rm -f ${perfdatafile}
+	sane=$(echo "${temp_dir}" | cut -b 1-26)
+	if [ "${sane}" = "/tmp/perf-test-intel-pt-sh" ] ; then
+		echo "--- Cleaning up ---"
+		rm -f "${temp_dir}/"*
+		rmdir "${temp_dir}"
+	fi
 }
 
 trap_cleanup()
-- 
2.25.1

