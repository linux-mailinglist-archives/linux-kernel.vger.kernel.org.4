Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 719A45B40FB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 22:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbiIIUp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 16:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231756AbiIIUpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 16:45:30 -0400
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C43DE5827;
        Fri,  9 Sep 2022 13:45:26 -0700 (PDT)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-1279948d93dso6957477fac.10;
        Fri, 09 Sep 2022 13:45:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=wJHPlwUtvZUMl13qkXUAr67z5VRLYGwRp7OVgCggcQ8=;
        b=SWtryOq2AxWUM1vWmaOoeQ9AmOJgGD6iaG3IneNHL31AJzBrc168A/aOLCqAOp6WWq
         jxJmNJp3PZSa7WdVYPfzqKE9ge4yRa27lV1UxPlPGJezaMaCc+oiuBTHAuCPzBUfEyMz
         I0W/bduiSIyvYiF/9r/HGCFHQFhoT9Y0yuf+sKKw2x+GB+F8VAYpnWocgVG2gw+2CYU3
         ByRaxq7mM9kO+Jh1vpbjI+wn5GzR8vrQoZe8lAu2AVuxvat0HJqpljWQaZbSscjV1srk
         u89YyLCaNCBns5vrJrB0x0OP0lh5j7dIWRhPMnc8rkD0jE7QwIAdBcYXFQ82qhcfMfQm
         P12g==
X-Gm-Message-State: ACgBeo2C38ua8nRMHA52U/XH3A7LYRUiofSsnlTVrHlbRiaIRvNhk+yT
        376QWJDaG63lPpL1v848fQ==
X-Google-Smtp-Source: AA6agR72dTUvUYth3SpEr5goOZl3+nCyxA8MljUI5f9EQmBiFXK73tYkzF5DmGOuvPjZj42APSiY5A==
X-Received: by 2002:a05:6871:a4:b0:127:2ef5:f66e with SMTP id u36-20020a05687100a400b001272ef5f66emr5879727oaa.213.1662756325737;
        Fri, 09 Sep 2022 13:45:25 -0700 (PDT)
Received: from xps15.. (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.googlemail.com with ESMTPSA id a4-20020a9d5c84000000b006370b948974sm213742oti.32.2022.09.09.13.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 13:45:25 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] perf: Skip and warn on unknown format 'configN' attrs
Date:   Fri,  9 Sep 2022 15:45:09 -0500
Message-Id: <20220909204509.2169512-1-robh@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the kernel exposes a new perf_event_attr field in a format attr, perf
will return an error stating the specified PMU can't be found. For
example, a format attr with 'config3:0-63' causes an error as config3 is
unknown to perf. This causes a compatibility issue between a newer
kernel with older perf tool.

Before this change with a kernel adding 'config3' I get:

$ perf record -e arm_spe// -- true
event syntax error: 'arm_spe//'
                     \___ Cannot find PMU `arm_spe'. Missing kernel support?
Run 'perf list' for a list of valid events

 Usage: perf record [<options>] [<command>]
    or: perf record [<options>] -- <command> [<options>]

    -e, --event <event>   event selector. use 'perf list' to list
available events

After this change, I get:

$ perf record -e arm_spe// -- true
WARNING: format 'inv_event_filter' requires 'config3' which is not supported by this version of perf!
[ perf record: Woken up 2 times to write data ]
[ perf record: Captured and wrote 0.091 MB perf.data ]

To support unknown configN formats, rework the YACC implementation to
pass any config[0-9]+ format to perf_pmu__new_format() to handle with a
warning.

Note that the user will get the warning if *any* PMU has an unsupported
format attr even if that PMU isn't used. This is because perf tool scans
all the PMUs.

Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
 - Rework YACC code to handle configN formats in C code
 - Add a warning when an unknown configN attr is found

v1: https://lore.kernel.org/all/20220901184709.2179309-1-robh@kernel.org/
---
 tools/perf/util/pmu.c |  6 ++++++
 tools/perf/util/pmu.l |  2 --
 tools/perf/util/pmu.y | 15 ++++-----------
 3 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 89655d53117a..6757db7d559c 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1475,6 +1475,12 @@ int perf_pmu__new_format(struct list_head *list, char *name,
 {
 	struct perf_pmu_format *format;
 
+	if (config > PERF_PMU_FORMAT_VALUE_CONFIG2) {
+		pr_warning("WARNING: format '%s' requires 'config%d' which is not supported by this version of perf!\n",
+			   name, config);
+		return 0;
+	}
+
 	format = zalloc(sizeof(*format));
 	if (!format)
 		return -ENOMEM;
diff --git a/tools/perf/util/pmu.l b/tools/perf/util/pmu.l
index a15d9fbd7c0e..58b4926cfaca 100644
--- a/tools/perf/util/pmu.l
+++ b/tools/perf/util/pmu.l
@@ -27,8 +27,6 @@ num_dec         [0-9]+
 
 {num_dec}	{ return value(10); }
 config		{ return PP_CONFIG; }
-config1		{ return PP_CONFIG1; }
-config2		{ return PP_CONFIG2; }
 -		{ return '-'; }
 :		{ return ':'; }
 ,		{ return ','; }
diff --git a/tools/perf/util/pmu.y b/tools/perf/util/pmu.y
index bfd7e8509869..283efe059819 100644
--- a/tools/perf/util/pmu.y
+++ b/tools/perf/util/pmu.y
@@ -20,7 +20,7 @@ do { \
 
 %}
 
-%token PP_CONFIG PP_CONFIG1 PP_CONFIG2
+%token PP_CONFIG
 %token PP_VALUE PP_ERROR
 %type <num> PP_VALUE
 %type <bits> bit_term
@@ -47,18 +47,11 @@ PP_CONFIG ':' bits
 				      $3));
 }
 |
-PP_CONFIG1 ':' bits
+PP_CONFIG PP_VALUE ':' bits
 {
 	ABORT_ON(perf_pmu__new_format(format, name,
-				      PERF_PMU_FORMAT_VALUE_CONFIG1,
-				      $3));
-}
-|
-PP_CONFIG2 ':' bits
-{
-	ABORT_ON(perf_pmu__new_format(format, name,
-				      PERF_PMU_FORMAT_VALUE_CONFIG2,
-				      $3));
+				      $2,
+				      $4));
 }
 
 bits:
-- 
2.34.1

