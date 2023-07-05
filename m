Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E743748E38
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 21:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233544AbjGETri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 15:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbjGETrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:47:35 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EAFCE3;
        Wed,  5 Jul 2023 12:47:35 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1b88e5b3834so18917555ad.3;
        Wed, 05 Jul 2023 12:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688586454; x=1691178454;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eVgKMbQsMcOPsIdlP9IfALADbyS9NwmXrwLOYeG98C0=;
        b=Sso1w05kGo2fnbRz0gtCa4jHE7pHCkIUtUW3QZecc/R7sW9Q+LroXJYYhMo9PHeH+K
         4mcsTVbjvwAQchMmJNoXOBj4RAqZOGjMcpXPbrte5OXx74pSPMQ/H7XY9ugof3GHShU/
         szztPTrgvLDWqTYtjIeQB6UEsNqcmvxVsPRoz8t4+2zJL09qeASUPy3oHqjYeEIVNWLr
         XVMgTL54+KEabZHMnK46O73kLgdLNfyK+C9K9GrzRqjNNTxRZeFWJ6+WhQ35Tp4+8tLv
         +gGMyMr2KDlP0+Nw2OAkaT9OEOtCV3uEaFxJuleDZSOZyDCrbMjETslCFVv2hI53oiSy
         nwvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688586454; x=1691178454;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eVgKMbQsMcOPsIdlP9IfALADbyS9NwmXrwLOYeG98C0=;
        b=dnOadaks0evvhsTngRYumcdqdbT30JtGOy6enA8dluPjCn42N/KNZvPidzWa+X28ms
         3pk9MzZtmNg2nHdI6N7OutFoTGdS6T7SC2HbcQVX3HWn9twhf+fY7VrQPFdvrXvXMeBk
         ohZtvQHY4BU51whco7px0n9sIQSHJ1k2T8DY1QMGvHOvkdZJi7E2Ojel3u4zKAOK/hq8
         WVuuGDKBGhCcaGk5E251Vn11RacsW7NpDesCqY0WrBNBVIP9cnk9zPX0S/b3CW0Lkz5A
         xxyGekBT25JrJ65lTPwVFRrBeqCfp8Evo2iuXTD67q5AX6umkEOTqztNqEqCRQmcdknZ
         5NDg==
X-Gm-Message-State: ABy/qLaAuC8HBgac37ORN5XOkofn+M2ws+y4pSUJcq7bOUGC2X+F8rad
        Qeyv6kKQ58Slahob/dXAH6s=
X-Google-Smtp-Source: APBJJlEuCki5uVW4uNG+AFHC9qSP+9RkSDwavc1CKmEIOcK6Yyxj9pXyy8G56H7ANCpBS1RvoAlBtQ==
X-Received: by 2002:a17:903:41c7:b0:1b8:b433:7fa with SMTP id u7-20020a17090341c700b001b8b43307famr7220ple.13.1688586454487;
        Wed, 05 Jul 2023 12:47:34 -0700 (PDT)
Received: from yoga ([2400:1f00:13:c628:31be:68ae:86f5:48b9])
        by smtp.gmail.com with ESMTPSA id s12-20020a170902988c00b00198d7b52eefsm19333252plp.257.2023.07.05.12.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 12:47:34 -0700 (PDT)
Date:   Thu, 6 Jul 2023 01:17:26 +0530
From:   Anup Sharma <anupnewsmail@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Anup Sharma <anupnewsmail@gmail.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/7] scripts: python: create threads with schemas
Message-ID: <d56fd5874314728e79c084e9d6ce805a24d61707.1688585597.git.anupnewsmail@gmail.com>
References: <cover.1688585597.git.anupnewsmail@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1688585597.git.anupnewsmail@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The markers structure defines the schema and data for
thread markers, including fields such as 'name',
'startTime', 'endTime', 'phase', 'category', and 'data'.

The samples structure defines the schema and data for thread
samples, including fields such as 'stack', 'time', and
'responsiveness'.

The frameTable structure defines the schema and data for frame
information, including fields such as 'location', 'relevantForJS',
'innerWindowID', 'implementation', 'optimizations', 'line',
'column', 'category', and 'subcategory'.

The purpose of this function is to create a new thread structure
These structures provide a framework for storing and organizing
information related to thread markers, samples, frame details,
and stack information.

Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
---
 .../scripts/python/firefox-gecko-converter.py | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/tools/perf/scripts/python/firefox-gecko-converter.py b/tools/perf/scripts/python/firefox-gecko-converter.py
index 95b061a97cbc..e56864e78dc1 100644
--- a/tools/perf/scripts/python/firefox-gecko-converter.py
+++ b/tools/perf/scripts/python/firefox-gecko-converter.py
@@ -24,6 +24,47 @@ start_time = None
 def process_event(param_dict):
 	global start_time
 	global thread_map
+	def _createtread(name, pid, tid):
+		markers = {
+			'schema': {
+				'name': 0,
+				'startTime': 1,
+				'endTime': 2,
+				'phase': 3,
+				'category': 4,
+				'data': 5,
+			},
+			'data': [],
+		}
+		samples = {
+			'schema': {
+				'stack': 0,
+				'time': 1,
+				'responsiveness': 2,
+				},
+			'data': [],
+		}
+		frameTable = {
+			'schema': {
+				'location': 0,
+				'relevantForJS': 1,
+				'innerWindowID': 2,
+				'implementation': 3,
+				'optimizations': 4,
+				'line': 5,
+				'column': 6,
+				'category': 7,
+				'subcategory': 8,
+			},
+			'data': [],
+		}
+		stackTable = {
+			'schema': {
+				'prefix': 0,
+				'frame': 1,
+			},
+			'data': [],
+		}
 
 	def _addThreadSample(pid, tid, threadName, time_stamp, stack):
 		thread = thread_map.get(tid)
-- 
2.34.1

