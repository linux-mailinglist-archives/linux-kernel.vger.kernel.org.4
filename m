Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71335664E67
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 23:00:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233953AbjAJV7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 16:59:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232908AbjAJV7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 16:59:44 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2501C633A1;
        Tue, 10 Jan 2023 13:59:43 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id g13so20617420lfv.7;
        Tue, 10 Jan 2023 13:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oqUVGWZ+P64IzHMaMbFTP3YtveA0quZvXbNj1geobqc=;
        b=NGDzhEW4M0tKj1NoeA6Hd6vWts/TspUQn6sDIv8a5vLCCktMeA3GF4NBhWF+sTvYvY
         k5iGqdfp3Khp6jhgPiBcjJ0l/rIr2qit3Zbjx3KjdTOi10Klgd953idMcXMhbBgbMYmk
         1PYHRgSJfnY1RB7zQkulgHkf1gu7eXllHcGMRUXLrSmxw3jXVxyGMsSaUY2CJmBOm8pL
         7YFD1pHAFzOYAPcjpNzWPp4/yRFS2r5Eeg14m5FAjN6zLt/zp+K3B4OVxVwXE4UIw/Qf
         xsr1J+YiFji2T/PL3kDQZMwlCZaBJ1CHFxvPjQpgxn1k+Jo+LBW2aGq9S4b8MkTHFCSG
         /NRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oqUVGWZ+P64IzHMaMbFTP3YtveA0quZvXbNj1geobqc=;
        b=ts4xCpUdQ8hSfOwuAf6Z7PnX1qBIL11Hfe7RhKmV8m495CTFfSuRWsEnapeXT/ZdU4
         G2dudwI9OP3eE2FF4NF0zrgwMmmYFwkPXanUKggwNkoYMZGltoJaRH6AY3oq4GAX2whj
         V97NP/rQEkTUj7xxMFzD6YS7ngF+1kzEbWVHNu55xfwuNss8IqC0Lcwdels9G6L1w7yd
         z2yFrvZ6388feshhnTr0WABSEgWliU5c5ldJD2tw/KePpwJTEw/70JfIKjDoRjqcAHWN
         JOwt4XU9lBIP372B8hFEpv3MgvUjhShsd2KtliAKT7I3FPT36YhPyHcGcI3JLpwVWsU/
         oyGA==
X-Gm-Message-State: AFqh2ko7sqpYL0lUUv2UHeANcORCRS355p4ARQ9OyOmdCQYhrx0+lR1h
        58ThaHef8FA93ffbJ3+RnUk=
X-Google-Smtp-Source: AMrXdXv8jyJj3Qj+E77izK5gNhB2ntWeXdV+Wt5avomU6UxOwe2zEsXP9UzV4haMnOgo/fmj6qI+/Q==
X-Received: by 2002:a05:6512:3089:b0:4cc:586b:183d with SMTP id z9-20020a056512308900b004cc586b183dmr7311757lfd.55.1673387981381;
        Tue, 10 Jan 2023 13:59:41 -0800 (PST)
Received: from localhost.localdomain ([46.147.136.10])
        by smtp.gmail.com with ESMTPSA id v4-20020ac258e4000000b004b59b43ec61sm2373015lfo.179.2023.01.10.13.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 13:59:40 -0800 (PST)
From:   Alexander Pantyukhin <apantykhin@gmail.com>
To:     jolsa@kernel.org
Cc:     akpm@linux-foundation.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexander Pantyukhin <apantykhin@gmail.com>
Subject: [PATCH] tools:perf:scripts:python:mem-phys-addr fix behavior
Date:   Wed, 11 Jan 2023 02:59:36 +0500
Message-Id: <20230110215936.4716-1-apantykhin@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the case when phys_addr belongs to the end of the range.

Example:
system_ram = [10, 20]
is_system_ram(20) - returns False
Expected: True

Signed-off-by: Alexander Pantyukhin <apantykhin@gmail.com>
---
 tools/perf/scripts/python/mem-phys-addr.py | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/tools/perf/scripts/python/mem-phys-addr.py b/tools/perf/scripts/python/mem-phys-addr.py
index 1f332e72b9b0..b1daa22bd405 100644
--- a/tools/perf/scripts/python/mem-phys-addr.py
+++ b/tools/perf/scripts/python/mem-phys-addr.py
@@ -59,18 +59,23 @@ def trace_end():
 	print_memory_type()
 	f.close()
 
+def is_value_inside_one_of_range(memory_ranges, value):
+    position = bisect.bisect(memory_ranges, value)
+
+    if position == 0:
+        return False
+
+    if position % 2 == 0:
+        return value == memory_ranges[position - 1]
+
+    return True
+
 def is_system_ram(phys_addr):
 	#/proc/iomem is sorted
-	position = bisect.bisect(system_ram, phys_addr)
-	if position % 2 == 0:
-		return False
-	return True
+	return is_value_inside_one_of_range(system_ram, phys_addr)
 
 def is_persistent_mem(phys_addr):
-	position = bisect.bisect(pmem, phys_addr)
-	if position % 2 == 0:
-		return False
-	return True
+	return is_value_inside_one_of_range(pmem, phys_addr)
 
 def find_memory_type(phys_addr):
 	if phys_addr == 0:
-- 
2.25.1

