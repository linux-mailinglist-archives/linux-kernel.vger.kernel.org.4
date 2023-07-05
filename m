Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3102748E3A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 21:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233588AbjGETsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 15:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234363AbjGETsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:48:11 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BFEFE3;
        Wed,  5 Jul 2023 12:48:10 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-5577900c06bso5445893a12.2;
        Wed, 05 Jul 2023 12:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688586490; x=1691178490;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H8c7Bp6w5fylw1SD1uv/K3VcW7YeFvhEhx9WsbO4Uk4=;
        b=VwC/7T6rXHKCboVLiOSQ60+XsauCs5vu855Ri1MRU6fgeob30zBSq7qObxfjfC7lFz
         7xElentszw6z26+apN7wG7/++uA0gsZwmsW4my3yX0on8r11AN9+QBueOFs9ITdMDBgJ
         N1TW2wLWmERtm5jU7WitNh6oOpXahSV+lOVD9aOICiufqowq4b3AnX/XTTNjYf9gi1iA
         UbERjSi0N3+L+edZJeR3y63Gp5l/RdoDnKG/5HiEtBVLZW8WiNxHxDda+gJlPhOoi5Xn
         SKD7dDxoApFBrRb4ahPajtnqcgBwfkgJOod9gWGoo8iYONTgdklDnMi239wrS4DBuX1H
         Xj3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688586490; x=1691178490;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H8c7Bp6w5fylw1SD1uv/K3VcW7YeFvhEhx9WsbO4Uk4=;
        b=OXq1VRio4jh3Lj+s5fhwvudPQP94Ym8a2WKfebPWIMCP4nQ5E0n4srpwHsYmmZJkqX
         lZ4AScNtUd5Om0M3oFWRG+6oXVkiRhxljW8dEpgcOr4V/AYis49Dlbx52cJTqfNrmbUv
         /3VAb/JrBgyiQE96el4oZ0wkv7QAMfAxKM1en2Dl4e0fMTWLRYV5Fx0mI6biB7vj+xIh
         yvZx4SCkzDfyW3Ndq6i8JUwpuILLbZugmm3xljGz5Hiu3oEst91f5dyeYvUZZBjbI3Qk
         8dB2r2RwHiTtioluH64eHVBJeKv6PHh+iYbFMKOBw4LxtYRD3stKD3cqNs28/DWse80T
         Q0Tw==
X-Gm-Message-State: ABy/qLaBzpnvo+5FPSouDSvDuSG8zbaqe9DmBw5wdjEpMUKTuLhPIuM7
        2xc2rOMN9semxb7ebEQAs4A=
X-Google-Smtp-Source: APBJJlFask0sSoE46kwZpLV7qEUJqwpTqvU/AeUJNg80TLOzxT6fteX2wngGxbhMVEs4HOxwwGFUpA==
X-Received: by 2002:a05:6a20:2588:b0:12f:cd72:ab6f with SMTP id k8-20020a056a20258800b0012fcd72ab6fmr2169640pzd.51.1688586489984;
        Wed, 05 Jul 2023 12:48:09 -0700 (PDT)
Received: from yoga ([2400:1f00:13:c628:31be:68ae:86f5:48b9])
        by smtp.gmail.com with ESMTPSA id d12-20020aa7814c000000b00682a61fa525sm3322801pfn.91.2023.07.05.12.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 12:48:09 -0700 (PDT)
Date:   Thu, 6 Jul 2023 01:18:02 +0530
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
Subject: [PATCH v2 4/7] scripts: python: implement get or create stack
 function
Message-ID: <d432405a93438f1780a767567b69bcdab32e1683.1688585597.git.anupnewsmail@gmail.com>
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

The get_or_create_stack function is responsible for retrieving
or creating a stack based on the provided frame and prefix.
It first generates a key using the frame and prefix values.
If the stack corresponding to the key is found in the stackMap,
it is returned. Otherwise, a new stack is created by appending
the prefix and frame to the stackTable's 'data' array. The key
and the index of the newly created stack are added to the
stackMap for future reference.

Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
---
 tools/perf/scripts/python/firefox-gecko-converter.py | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/perf/scripts/python/firefox-gecko-converter.py b/tools/perf/scripts/python/firefox-gecko-converter.py
index e56864e78dc1..6f69c083d3ff 100644
--- a/tools/perf/scripts/python/firefox-gecko-converter.py
+++ b/tools/perf/scripts/python/firefox-gecko-converter.py
@@ -65,6 +65,17 @@ def process_event(param_dict):
 			},
 			'data': [],
 		}
+		stringTable = []
+
+		stackMap = dict()
+		def get_or_create_stack(frame, prefix):
+			key = f"{frame}" if prefix is None else f"{frame},{prefix}"
+			stack = stackMap.get(key)
+			if stack is None:
+				stack = len(stackTable['data'])
+				stackTable['data'].append([prefix, frame])
+				stackMap[key] = stack
+			return stack
 
 	def _addThreadSample(pid, tid, threadName, time_stamp, stack):
 		thread = thread_map.get(tid)
-- 
2.34.1

