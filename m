Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDF175EFEF8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 23:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbiI2VAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 17:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiI2VAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 17:00:44 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C440B656E;
        Thu, 29 Sep 2022 14:00:42 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id r14so1679256qvn.3;
        Thu, 29 Sep 2022 14:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=uiZ0nDSBuPQeGax2QW8uIowyQEtsCVx+PfyYzMy0ISY=;
        b=EreWa1r6XpdL6bowUpMjkw6DfsOUGP6iltR2y+/PKBCjCHkk2zneenpwIHJO5wWlHP
         uIJ+Db7wpEZvV3Dy943JAQDdeVNfuYMb807k//3SpBCSAez6kNsLeS4HndXqLv4f0qYc
         Bz08pZZHlnsaQ95ebaWGlq0uY2k3lw0PONyqp53vDJ09j7CNIUL5VKJFCliGyX5eatNH
         ROWOmZAznpWqOeDyHARVuZA0REPyG/FaSwZtsqcATrM4vWlk0KMcttLESowu1PWFC1Xc
         oNQnbJOKQhsUe+FoS+g0TR6ghfyuwjc6DA3QNX6fonaHPKbwAAmU/qIhzv9KMYSTBNnO
         lWlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=uiZ0nDSBuPQeGax2QW8uIowyQEtsCVx+PfyYzMy0ISY=;
        b=4IQzequyis6Hzp/nMObH+joNknJf2Ry2qgUxLOjyCgQfx6oglVaEdoU78g5FDixBul
         xg2+R9iIQTHCqCVlWjNYrJmnr0CGycXSYgwmWw0iPPLYcuooAymi//Xu5QzrtECoHl0z
         YYWcrspmuY+y92K+3nv8PIhQwj8HJvGfGZhnMQ4TQMRasEBqo3vRyELM6Cguulu2KABE
         riQTrz9lSFIWMuiW+3nbj3ERBFNWCU3Tshsqkw2Pj3ezcGSCmW4DaeidllS1G/62c7Fw
         6qIfo3ADi7Ds/HFes7ea3o2kpMOvd1HlVL+d5isebtKdKK3WeYnjeefDKsWrKUvJZTDV
         NIMQ==
X-Gm-Message-State: ACrzQf0v1YbtXq8GRgXsio7cWZMlQYpHdkkDVP3DUwu+SWnkEL0pvCOq
        hp0J3oSat4y6pG7eFXmRrr0=
X-Google-Smtp-Source: AMsMyM6nyxQDEZJp6exJKamOA5+s7k1arGd1CWwyd9PKVu935KcCRfSpU+aKIRmeM5eO4JskphEKhw==
X-Received: by 2002:ad4:4eac:0:b0:4af:8718:3b55 with SMTP id ed12-20020ad44eac000000b004af87183b55mr4168794qvb.72.1664485241585;
        Thu, 29 Sep 2022 14:00:41 -0700 (PDT)
Received: from localhost.localdomain ([177.222.37.214])
        by smtp.googlemail.com with ESMTPSA id z2-20020ac875c2000000b0035cf2995ad8sm190362qtq.51.2022.09.29.14.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 14:00:41 -0700 (PDT)
From:   Henry Castro <hcvcastro@gmail.com>
To:     namhyung@kernel.org
Cc:     Henry Castro <hcvcastro@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] perf: fix the probe finder location (.dwo files)
Date:   Thu, 29 Sep 2022 16:59:57 -0400
Message-Id: <20220929205958.22225-1-hcvcastro@gmail.com>
X-Mailer: git-send-email 2.20.1
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

If the file object is compiled using -gsplit-dwarf,
the probe finder location will fail.

Signed-off-by: Henry Castro <hcvcastro@gmail.com>
---
 tools/perf/util/probe-finder.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index 50d861a80f57..6d7c5461251d 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -1161,7 +1161,8 @@ static int debuginfo__find_probe_location(struct debuginfo *dbg,
 	struct perf_probe_point *pp = &pf->pev->point;
 	Dwarf_Off off, noff;
 	size_t cuhl;
-	Dwarf_Die *diep;
+	Dwarf_Die *diep, cudie, subdie;
+	uint8_t unit_type;
 	int ret = 0;
 
 	off = 0;
@@ -1200,6 +1201,14 @@ static int debuginfo__find_probe_location(struct debuginfo *dbg,
 			continue;
 		}
 
+		/* Check separate debug information file. */
+		if (dwarf_cu_info(pf->cu_die.cu, NULL, &unit_type, &cudie,
+				  &subdie, NULL, NULL, NULL))
+			continue;
+
+		if (unit_type == DW_UT_skeleton)
+			pf->cu_die = subdie;
+
 		/* Check if target file is included. */
 		if (pp->file)
 			pf->fname = cu_find_realpath(&pf->cu_die, pp->file);
-- 
2.20.1

