Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81F6E66BFF7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 14:39:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbjAPNjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 08:39:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbjAPNjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 08:39:11 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85BB572AC;
        Mon, 16 Jan 2023 05:39:07 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id s22so29995597ljp.5;
        Mon, 16 Jan 2023 05:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DkN/Q+WE6dIkvD0+yQccgtM27O8+Zp01R8sAtPJH6pc=;
        b=JRF+zY364R4598fq1+knN3KVWirFsYO2f10SaByTH+7vxJw7Sg1SwhpkGNv23ZF0hZ
         /c9y6uarVBG+GLvTC03lrLdafGgns3+XFUzeDi+KM5QgVItwCMVT1fEvzQAY1seupPpI
         rUOkxdqEhrxNg3y6dD+E2xM/liQ4dH0oFag+0wgdZazEz1pyqMu9gC2VJU//7sRBW6sF
         Q3rHhYIO5gn9yuq31ALmhD6YtXHBCqQNKp4HSAM8PfUlRtL99aPyEuH8TOmo4wIaPlaZ
         QrQeTdgs0fmzO3FVIMBJiLHl+RYXMOam1SMQ43w7XebQrElugWRJQ6SjqSyVXHYq2aW8
         G5Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DkN/Q+WE6dIkvD0+yQccgtM27O8+Zp01R8sAtPJH6pc=;
        b=uTUW3BaueJqq98sSksMZPpZ/2qBNx2IhGVppy4N77nWZnXKQTqMSlZHlAs4i6zikj3
         kUwUdPn5V11s1EJg1MMP5kldDJ5cHb9tHc8fZxZx3sxllZglfqnB1hnp0gCmx6TeSxR6
         teK07YB07+ormNGtPD3wD4kE5ru11MEP0+ZOByDCdP08xIOU3FBsXfRX1Xif8vZIzBbC
         HrDqKWOyAVHSXD+pCRjixtzyrWO1+CGFuJ9oUOFpP1kj0NS+bpDLxvDYjVU1HDaHe2+a
         A/du9Cm1qSW+pcTfqwoTRRIpi9+oWT/eN6wGb1O0M+T4mDBDKfU/WBX51DmRXq66NHZ6
         kLKw==
X-Gm-Message-State: AFqh2koNcVSTkyFIuAWdM2EfuqEbMFOToTppJh5g/JKB7dLQmVp6g+V5
        lDw0/DZgXAKUjQt8VXmr+dM/29kELbYRDw==
X-Google-Smtp-Source: AMrXdXtg3uqqUWLpxccU8Re3KuNH+Npw2b0vFtJXjNAdnDYxu0RyV3HtsxP7VMGGOAB0II54C5xAFA==
X-Received: by 2002:a2e:8796:0:b0:28b:6f54:729a with SMTP id n22-20020a2e8796000000b0028b6f54729amr2823112lji.21.1673876345780;
        Mon, 16 Jan 2023 05:39:05 -0800 (PST)
Received: from localhost.localdomain ([46.147.136.0])
        by smtp.gmail.com with ESMTPSA id d4-20020a2e9284000000b0028b92cd1fd8sm132748ljh.109.2023.01.16.05.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 05:39:05 -0800 (PST)
From:   Alexander Pantyukhin <apantykhin@gmail.com>
To:     akpm@linux-foundation.org
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexander Pantyukhin <apantykhin@gmail.com>
Subject: [PATCH] /tools/../Core.py: move tasks states outside the method
Date:   Mon, 16 Jan 2023 18:39:02 +0500
Message-Id: <20230116133902.4143-1-apantykhin@gmail.com>
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

The states variable is invariant for the taskState method. It could be
brought out of the taskState.

Signed-off-by: Alexander Pantyukhin <apantykhin@gmail.com>
---
 .../Perf-Trace-Util/lib/Perf/Trace/Core.py    | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/Core.py b/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/Core.py
index 54ace2f6bc36..ecb5087e5583 100644
--- a/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/Core.py
+++ b/tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/Core.py
@@ -85,18 +85,15 @@ def trace_flag_str(value):
     return string
 
 
-def taskState(state):
-	states = {
-		0 : "R",
-		1 : "S",
-		2 : "D",
-		64: "DEAD"
-	}
-
-	if state not in states:
-		return "Unknown"
+tasks_states = {
+    0 : "R",
+    1 : "S",
+    2 : "D",
+    64: "DEAD"
+}
 
-	return states[state]
+def taskState(state):
+    return tasks_states.get(state, "Unknown")
 
 
 class EventHeaders:
-- 
2.25.1

