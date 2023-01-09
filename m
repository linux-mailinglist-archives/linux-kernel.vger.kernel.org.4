Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2966621AF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 10:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233393AbjAIJeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 04:34:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236633AbjAIJdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 04:33:53 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B34F115C;
        Mon,  9 Jan 2023 01:33:52 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id s22so8255020ljp.5;
        Mon, 09 Jan 2023 01:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rNnvNTBMGELu3VN6vH0YTp6DPHz7nzIVYPeYgFskFXE=;
        b=EXmEQcDmM1xcGRcxBdThTmqTfNWF9mMT75GsHDeDqkjbpbsVxxPy0GM4WcIlzlc39L
         xGZ0VkakUPjNDAkdJQYvkhM+llWHwjuNY99zUnu1kJvA+MmfAqRT+TsInnocHZ27FtQc
         JJRvAFn5DG6/Vnf2rkfyJ19yuIB/ClTTjiaugp1Jnia2JCi8XOutXj7+Dw9CUSMUMwWj
         H56GZ8HOfhCuqp52wLJoieLB4BgFrYmfHVuETf9FQfGw1AOqGx72nStPyys1bpxIQHOQ
         idMUJqUamtLKvddulHw66Wpj6wUl/yPWdi/BkrDmH/N2dRPfF5FS9l89TGEnRrtQzcy1
         ujJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rNnvNTBMGELu3VN6vH0YTp6DPHz7nzIVYPeYgFskFXE=;
        b=cn6qEnvxaf/ovoqEzl/UEZl15Z9rltcuY0yxPmWSdvILpop2mt4dIp4i4OMIsLOi0k
         DhZrc9/9QaHXvy2NfSxhtStH1MD1yWGnpsECN0QLQCKWPNcJFdwvrLuRvK3fvf7xeMo4
         G2sDrJFiqTGaFie7jxcSOb6xEMQguV0PCtlEnWuI7FDcZIo0PETmHft1qDwTdiXsfICA
         4/kb5ocqT7bLRxED3ycikMEufnt83AT6yh/qfALh1aJeghF9mpyVO2N7dI/UbhNs1hII
         fZuYqU2K19dQ1jRmOw3QS4loHyriRCkziB0W05TdTDIYqhOOEVQkqGjI1Z+VhUUfRj+1
         7YSA==
X-Gm-Message-State: AFqh2krX+p0tKpIQ4NVOEGvDybwJYZaf9Za8Xz1UiAMoFeic6Q8EjuHT
        +z2e+6RcwM4/PMuwYPsfjTY=
X-Google-Smtp-Source: AMrXdXvQmlqPvgR5EwzIejFMocfh26sIvUQoei5k6VehZoxaV/QM5kIzaBj79R/Y2iTTAZCts1Nivg==
X-Received: by 2002:a05:651c:384:b0:27f:f08d:6060 with SMTP id e4-20020a05651c038400b0027ff08d6060mr6272416ljp.38.1673256830641;
        Mon, 09 Jan 2023 01:33:50 -0800 (PST)
Received: from localhost.localdomain ([46.147.136.10])
        by smtp.gmail.com with ESMTPSA id p19-20020a2e8053000000b0028402d9646dsm457730ljg.37.2023.01.09.01.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 01:33:49 -0800 (PST)
From:   Alexander Pantyukhin <apantykhin@gmail.com>
To:     mark.rutland@arm.com
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexander Pantyukhin <apantykhin@gmail.com>
Subject: [PATCH] tools:perf:scripts:python:mem-phys-addr fix performance
Date:   Mon,  9 Jan 2023 14:33:47 +0500
Message-Id: <20230109093347.6639-1-apantykhin@gmail.com>
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

Avoid double strip() calls for getting memory type.

Signed-off-by: Alexander Pantyukhin <apantykhin@gmail.com>
---
 tools/perf/scripts/python/mem-phys-addr.py | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/perf/scripts/python/mem-phys-addr.py b/tools/perf/scripts/python/mem-phys-addr.py
index 1f332e72b9b0..f267d8382eda 100644
--- a/tools/perf/scripts/python/mem-phys-addr.py
+++ b/tools/perf/scripts/python/mem-phys-addr.py
@@ -8,7 +8,6 @@ from __future__ import print_function
 
 import os
 import sys
-import struct
 import re
 import bisect
 import collections
@@ -30,12 +29,14 @@ event_name = None
 def parse_iomem():
 	global f
 	f = open('/proc/iomem', 'r')
-	for i, j in enumerate(f):
+	for _, j in enumerate(f):
 		m = re.split('-|:',j,2)
-		if m[2].strip() == 'System RAM':
+		memory_type = m[2].strip()
+
+		if memory_type == 'System RAM':
 			system_ram.append(int(m[0], 16))
 			system_ram.append(int(m[1], 16))
-		if m[2].strip() == 'Persistent Memory':
+		elif memory_type == 'Persistent Memory':
 			pmem.append(int(m[0], 16))
 			pmem.append(int(m[1], 16))
 
@@ -75,6 +76,7 @@ def is_persistent_mem(phys_addr):
 def find_memory_type(phys_addr):
 	if phys_addr == 0:
 		return "N/A"
+
 	if is_system_ram(phys_addr):
 		return "System RAM"
 
-- 
2.25.1

