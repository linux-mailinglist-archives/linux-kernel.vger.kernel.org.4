Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 644C55B3C00
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 17:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbiIIPdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 11:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232003AbiIIPcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 11:32:36 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3280043E70;
        Fri,  9 Sep 2022 08:32:22 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3FC85169E;
        Fri,  9 Sep 2022 08:28:44 -0700 (PDT)
Received: from e126387.arm.com (unknown [10.57.17.154])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 89A413F73D;
        Fri,  9 Sep 2022 08:28:36 -0700 (PDT)
From:   carsten.haitzler@foss.arm.com
To:     linux-kernel@vger.kernel.org
Cc:     coresight@lists.linaro.org, suzuki.poulose@arm.com,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        leo.yan@linaro.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Subject: [PATCH v9 07/13] perf test: Add memcpy thread test shell script
Date:   Fri,  9 Sep 2022 16:27:57 +0100
Message-Id: <20220909152803.2317006-8-carsten.haitzler@foss.arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220909152803.2317006-1-carsten.haitzler@foss.arm.com>
References: <20220909152803.2317006-1-carsten.haitzler@foss.arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Carsten Haitzler <carsten.haitzler@arm.com>

Add a script to drive the threaded memcpy test that gathers data so
it passes a minimum bar for amount and quality of content that we
extract from the kernel's perf support.

Signed-off-by: Carsten Haitzler <carsten.haitzler@arm.com>
---
 .../shell/coresight/memcpy_thread_16k_10.sh    | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100755 tools/perf/tests/shell/coresight/memcpy_thread_16k_10.sh

diff --git a/tools/perf/tests/shell/coresight/memcpy_thread_16k_10.sh b/tools/perf/tests/shell/coresight/memcpy_thread_16k_10.sh
new file mode 100755
index 000000000000..d21ba8545938
--- /dev/null
+++ b/tools/perf/tests/shell/coresight/memcpy_thread_16k_10.sh
@@ -0,0 +1,18 @@
+#!/bin/sh -e
+# CoreSight / Memcpy 16k 10 Threads
+
+# SPDX-License-Identifier: GPL-2.0
+# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
+
+TEST="memcpy_thread"
+. $(dirname $0)/../lib/coresight.sh
+ARGS="16 10 1"
+DATV="16k_10"
+DATA="$DATD/perf-$TEST-$DATV.data"
+
+perf record $PERFRECOPT -o "$DATA" "$BIN" $ARGS
+
+perf_dump_aux_verify "$DATA" 10 10 10
+
+err=$?
+exit $err
-- 
2.32.0

