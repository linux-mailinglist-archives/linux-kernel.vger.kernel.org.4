Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0AEC5B564B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 10:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbiILIen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 04:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiILIeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 04:34:31 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77360385;
        Mon, 12 Sep 2022 01:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662971668; x=1694507668;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gwqpOrlpoM7QQaHMT4fCz5cXWh0yb5xUU36OguseAi4=;
  b=e3FcTrSQyyz3PpJMvGBsUlT5o+d6lGgWYSu6UsPfzvsAVZ2tMhUjc5MF
   pFhGOQJuHkFfArJow44kyGZiiuCGbpQj56+fVaayW/kJO2NKjwjYigZwx
   oX8nfY7Arrz5i8x5S3daOP13phBsXCFmVo9n7897Uhd13voPn+sj9xsAR
   eH+Ij4SzumYxEJ5thVi+NCGiJfXkcJj4r5hPBenFstFikEw1FtWLF/6q2
   Ben/jxPz8TL/VO88kdc6aJx+dp9q2elQSxM45mjgxfkk8K0gwxeyLJw+e
   CX3rXvoGZvPulhIDZbexp+W8Eyl6oy5IYZV8EfeuHLfs02U+wUnUaEfxI
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10467"; a="299153607"
X-IronPort-AV: E=Sophos;i="5.93,308,1654585200"; 
   d="scan'208";a="299153607"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 01:34:28 -0700
X-IronPort-AV: E=Sophos;i="5.93,308,1654585200"; 
   d="scan'208";a="611688245"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.46.215])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 01:34:26 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 01/11] perf test: test_intel_pt.sh: Add cleanup function
Date:   Mon, 12 Sep 2022 11:34:02 +0300
Message-Id: <20220912083412.7058-2-adrian.hunter@intel.com>
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

Add a cleanup function that will still clean up if the script is
terminated prematurely.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/tests/shell/test_intel_pt.sh | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/shell/test_intel_pt.sh b/tools/perf/tests/shell/test_intel_pt.sh
index a3298643884d..17338e6a6f99 100755
--- a/tools/perf/tests/shell/test_intel_pt.sh
+++ b/tools/perf/tests/shell/test_intel_pt.sh
@@ -14,6 +14,21 @@ err_cnt=0
 tmpfile=`mktemp`
 perfdatafile=`mktemp`
 
+cleanup()
+{
+	trap - EXIT TERM INT
+	rm -f ${tmpfile}
+	rm -f ${perfdatafile}
+}
+
+trap_cleanup()
+{
+	cleanup
+	exit 1
+}
+
+trap trap_cleanup EXIT TERM INT
+
 can_cpu_wide()
 {
 	perf record -o ${tmpfile} -B -N --no-bpf-event -e dummy:u -C $1 true 2>&1 >/dev/null || return 2
@@ -57,8 +72,7 @@ test_system_wide_side_band
 
 count_result $?
 
-rm -f ${tmpfile}
-rm -f ${perfdatafile}
+cleanup
 
 if [ ${err_cnt} -gt 0 ] ; then
 	exit 1
-- 
2.25.1

