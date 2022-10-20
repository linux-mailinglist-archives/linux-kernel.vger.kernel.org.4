Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8F406068DE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 21:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbiJTT3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 15:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbiJTT31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 15:29:27 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFC11008;
        Thu, 20 Oct 2022 12:29:21 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id t10-20020a17090a4e4a00b0020af4bcae10so591760pjl.3;
        Thu, 20 Oct 2022 12:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=3IhfJV/ujEMz2VKCojZus2oWqbEOyKbn3J2D7DFU0U4=;
        b=m/YmPmdSeKWw68CQWY77WtCYKP4sk7RmpdviGct4nk3WTQF9K4Bv0loTBpi/NhPdNZ
         eu24hydAsAkIiu8WtuidUxz5/AT3RawWQvm+NwTwZHHsHKesQkzh4xXk1Zdcz9ZgIcs6
         ZSwxreAKF9vmrJkm770z3i/RNIsdgjsVA2KwoARQdD1f+H0JtgXPi5pHdGBr5ScpzGDN
         bKM3oLmk5NCVVnTk6w7YXpe2bGuWx8/x+T1E7Ywjqhu8R/XUkggf0Dyyfwe0VYkJrEgf
         zUOI53F7wCUwR9tgYB/cIqu5IQwjs8iFztOsIZeXM/iuHlYc+305/rRQ2QwT9Trp+Aw0
         b2Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3IhfJV/ujEMz2VKCojZus2oWqbEOyKbn3J2D7DFU0U4=;
        b=QfpVDRHYgrdLQC+f6uF8CDy4188tjCjqUywJuaEW2gveW+wX6XIOPGZsd62KyHex5/
         1uBI/xpMU3W9xTpcqz+3pgM/0OAiKkSHfcQXH07KDdhCgt50Hn3YOhqDVoeMK4E8V1V4
         w3toshuvM6fjnXV+NFTC1GCQzQn4J9qtPBv6IIGyUZrO3f7kpCIGyZPacfEowAXHeXkj
         Dddq/R8J6TMhNqlSh7nxpFScAHggkyASXfHi7SODC4NmhoBBtaCDVpMe/Du/zzPKXKJd
         wZ9bOFw3qM7DoTw0EVXQtGYvPXxwRu3LE/xKUUr8UJu6pDS9wagUbiu7Bofm3y0q6DTX
         ocpg==
X-Gm-Message-State: ACrzQf3zuD60CcNfktAPJO1LVR5uMBbWU5hCKB4oeZ2gTAXa8vdZZ8kw
        9r++WJYVzJtkrswSpni+muk=
X-Google-Smtp-Source: AMsMyM6BFkt/4Umtx/UkV+izdSEu/8B243G5U5IqDFk1S8zMwE98ymly8FBCMJtX7PyxO1VUZ3s1RA==
X-Received: by 2002:a17:903:230a:b0:17d:707a:360e with SMTP id d10-20020a170903230a00b0017d707a360emr15764571plh.118.1666294160982;
        Thu, 20 Oct 2022 12:29:20 -0700 (PDT)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:637f:7dcc:4bbf:4981])
        by smtp.gmail.com with ESMTPSA id p189-20020a625bc6000000b00562e9f636e0sm14230825pfb.10.2022.10.20.12.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 12:29:20 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Ammy Yi <ammy.yi@intel.com>
Subject: [PATCH] perf test: Do not fail Intel-PT misc test w/o libpython
Date:   Thu, 20 Oct 2022 12:29:17 -0700
Message-Id: <20221020192917.3542757-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The virtuall LBR test uses a python script to check the max size of
branch stack in the Intel-PT generated LBR.  But it didn't check whether
python scripting is available (as it's optional).

Let's skip the test if the python support is not available.

Fixes: f77811a0f625 ("perf test: test_intel_pt.sh: Add 9 tests")
Cc: Ammy Yi <ammy.yi@intel.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/test_intel_pt.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/tests/shell/test_intel_pt.sh b/tools/perf/tests/shell/test_intel_pt.sh
index 4c0aabbe33bd..e66b7d977462 100755
--- a/tools/perf/tests/shell/test_intel_pt.sh
+++ b/tools/perf/tests/shell/test_intel_pt.sh
@@ -526,6 +526,12 @@ test_kernel_trace()
 test_virtual_lbr()
 {
 	echo "--- Test virtual LBR ---"
+	# Check if python script is supported
+	libpython=$(ldd $(which perf) | grep -c python)
+	if [ "${libpython}" != "1" ] ; then
+		echo "SKIP: python scripting is not supported"
+		return 2
+	fi
 
 	# Python script to determine the maximum size of branch stacks
 	cat << "_end_of_file_" > "${maxbrstack}"
-- 
2.38.0.135.g90850a2211-goog

