Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3B774E220
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 01:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbjGJXOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 19:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbjGJXOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 19:14:31 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B127195;
        Mon, 10 Jul 2023 16:14:30 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-51452556acdso3453696a12.2;
        Mon, 10 Jul 2023 16:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689030869; x=1691622869;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EIaFszOKIjmn1GPr4vHWBEQHE0KiRcRwYwejxWSEw6Q=;
        b=ekQZS/WIxWgWBCCc3eYQbd+gCWkoM9tJ6gYrkHQ0yrjLOaMwGNhJlLy8FSrAH/hYKE
         22F6BErvLuoFVQOKreCpTGmH2CtgSXiXk9PiTeR2Hr74BXpeSdLF4sPY6x5gaH1kKMIP
         nBi193IpxPuhGZyO5P8GUgPfYzmlf7wsRjQYtsVBmjVNWY6W8ubw92VjRdgzsIPeffky
         qfkOQNDg1qfQZ0hUhzpmKWi5xCCO7tDHThABGdvf4jEtOlofC19ukFNlj9C4F1XLqPQl
         +RkYtwdjNQPIsiiyTiVgerMp/8tXSrK9txrxZ7xJLpHBHPpR7wn1hh8kDq6Z6J5q1Zr4
         z4Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689030870; x=1691622870;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EIaFszOKIjmn1GPr4vHWBEQHE0KiRcRwYwejxWSEw6Q=;
        b=eW+5qvGh2+rmder9Ma1TeUc5nPZaDQTcLigjkrjaeJ0sarose0/AVGtGqmX313Tj4B
         8znFNA6CTKOwefyFNxVCxzWzJAuUoRJtqnFQjVaYDy6nruedP3cEbE8s27HYkZPf8le2
         scuy1X/Wju8vBKGq/GYcmEibQohXup76qggdNUSIrkhHpgquSsaJmtOttmcqGVyk8en8
         xJmGRyqk4gU82ySe+jK1tCHP7vrJsC2J4qFAN8IR9udh4S0vPQCedTmBFYKCma1Ef2ZZ
         /uB0w+XrB1A8iWKYioTK894cEMZd4EX+lkCgJ4gpOLOzMd6+az9Y5pUeF+KugAa3HV7B
         Tenw==
X-Gm-Message-State: ABy/qLZcztsaVJpS0SS2Wg6WaRoYclsh3feyDrkOi9RKynalrniB20+d
        zhRmgOUoI0ssvtfENgvMP/g=
X-Google-Smtp-Source: APBJJlGgAvP70h63K/YLCRubROWtnNOywvJJQNDmqcqFLiAhFTt2GlaLDGCF9NIFITC9+YVmX2ZYIw==
X-Received: by 2002:a17:902:daca:b0:1b8:9195:1dd8 with SMTP id q10-20020a170902daca00b001b891951dd8mr13057988plx.51.1689030869579;
        Mon, 10 Jul 2023 16:14:29 -0700 (PDT)
Received: from yoga ([2400:1f00:13:76f2:868d:bc7d:562b:a5bb])
        by smtp.gmail.com with ESMTPSA id t4-20020a170902bc4400b001b9c960ffeasm428846plz.47.2023.07.10.16.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 16:14:29 -0700 (PDT)
Date:   Tue, 11 Jul 2023 04:44:22 +0530
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
Subject: [PATCH v3 5/6] scripts: python: Implement add sample function and
 return finish
Message-ID: <8b80f803ffbed4c84c0c63b3e1dae155a66ac1f2.1689024635.git.anupnewsmail@gmail.com>
References: <cover.1689024635.git.anupnewsmail@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1689024635.git.anupnewsmail@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The addSample function appends a new entry to the 'samples' data structure.

The finish function generates a dictionary containing various profile
information such as 'tid', 'pid', 'name', 'markers', 'samples',
'frameTable', 'stackTable', 'stringTable', 'registerTime',
'unregisterTime', and 'processType'.

Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
---
 .../scripts/python/firefox-gecko-converter.py | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tools/perf/scripts/python/firefox-gecko-converter.py b/tools/perf/scripts/python/firefox-gecko-converter.py
index 39818a603265..6c934de1f608 100644
--- a/tools/perf/scripts/python/firefox-gecko-converter.py
+++ b/tools/perf/scripts/python/firefox-gecko-converter.py
@@ -106,11 +106,36 @@ def process_event(param_dict):
 		}
 		stringTable = []
 
+		def addSample(threadName, stackArray, time):
+			responsiveness = 0
+			samples['data'].append([stack, time, responsiveness])
+
+		def finish():
+			return {
+				"tid": tid,
+				"pid": pid,
+				"name": name,
+				"markers": markers,
+				"samples": samples,
+				"frameTable": frameTable,
+				"stackTable": stackTable,
+				"stringTable": stringTable,
+				"registerTime": 0,
+				"unregisterTime": None,
+				"processType": 'default'
+			}
+
+		return {
+			"addSample": addSample,
+			"finish": finish
+		}
+
 	def _addThreadSample(pid, tid, threadName, time_stamp, stack):
 		thread = thread_map.get(tid)
 		if not thread:
 			thread = _createThread(threadName, pid, tid)
 			thread_map[tid] = thread
+		thread['addSample'](threadName, stack, time_stamp)
 
 	# Extract relevant information from the event parameters. The event parameters
 	# are in a dictionary:
-- 
2.34.1

