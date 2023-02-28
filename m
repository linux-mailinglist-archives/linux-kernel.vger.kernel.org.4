Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C43956A58A7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 12:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbjB1Ly7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 06:54:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjB1Ly3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 06:54:29 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E412FCE3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 03:54:05 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id v11so6586528plz.8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 03:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t1yEtOA/S7kgzfPudB0ZivwtY0/Ec+bbW+dtSNwunWQ=;
        b=EqufZcgTJuLYFCdWec9ozeE+yvyIhPMiuWZG7A6k0XGyy0ERBAWTIzjZhxq9j+V+yP
         gc5sA3f3W834DFB3va31cNbRSXdkcxDha0CQU5S1eZRzCnYiZxlcvZUdd/dXd2+6Ox/5
         8J3tbO/DccOBS9rheXfOoucs3x1nmTzTFIvPluFqJOuEnYh44+jyzaubuPwdyWZmKrkE
         vGeoaOKP/c/+wB6Ou11XBQ6TRtWplZ7o0UO774BrRjzzMon9NFcRhijfarq4npF5IE1g
         36lsOVNKKaFuSQhOXsvAbVB6cKZDz2pT64VVXGuyw1m1Lp1X+cuPyyCCbIMkBtlXPcyz
         BCvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t1yEtOA/S7kgzfPudB0ZivwtY0/Ec+bbW+dtSNwunWQ=;
        b=H53KbUa4mN8beqWQ+fATZdbT/RQUmKVbL4tOsalx8rFVsSWdeyHNZk9RJvPqEILDbG
         J85f2274J9JzPxOfxK6dQ4G9KvxkYYtLj16tU8RmuM9HAl8KgcaBwf78fq64Yx+a8t3m
         lwqLrJatWN2J4YLGW5a+oSu2iSBfiIYDBl5V5BRx1Kjr8ukv/Lb0N4cYmEg0EF+hd6Ch
         IYggJvgvPfC+0imRQSQHNMxpXJlWRf9gEkzYU9bjGGygVY3WAXqt6Uz86m/87BgTkVUg
         G2P85EiwrTUhMDjHLNw7s6jok8tbFiQWZzJAug/NHfzRE3Z/ilKmWV2oEWSjoK54KL1W
         OYTA==
X-Gm-Message-State: AO0yUKXDkb7wmy2t7kdIZPNT2Uhso4bMofv7my6WDRb78uzknCWNiY9D
        Pdsbd1fPphwscHlvBy8uSEUGGA==
X-Google-Smtp-Source: AK7set/3ey40Ufas0DbtaGkjaVGCapd2bs4uVJuNf5++vCCnnGrtEoZlpBjYWG9kNrPFvlVjwMA/jA==
X-Received: by 2002:a17:90b:4a85:b0:234:9715:fe9a with SMTP id lp5-20020a17090b4a8500b002349715fe9amr2785028pjb.43.1677585244013;
        Tue, 28 Feb 2023 03:54:04 -0800 (PST)
Received: from leoy-huanghe.lan (n058152048225.netvigator.com. [58.152.48.225])
        by smtp.gmail.com with ESMTPSA id gk8-20020a17090b118800b002339491ead6sm7922317pjb.5.2023.02.28.03.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 03:54:03 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3 14/14] perf kvm: Update documentation to reflect new changes
Date:   Tue, 28 Feb 2023 19:51:25 +0800
Message-Id: <20230228115125.144172-15-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230228115125.144172-1-leo.yan@linaro.org>
References: <20230228115125.144172-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update documentation for new sorting and option '--stdio'.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: James Clark <james.clark@arm.com>
---
 tools/perf/Documentation/perf-kvm.txt | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-kvm.txt b/tools/perf/Documentation/perf-kvm.txt
index 2ad3f5d9f72b..b66be66fe836 100644
--- a/tools/perf/Documentation/perf-kvm.txt
+++ b/tools/perf/Documentation/perf-kvm.txt
@@ -58,7 +58,7 @@ There are a couple of variants of perf kvm:
   events.
 
   'perf kvm stat report' reports statistical data which includes events
-  handled time, samples, and so on.
+  handled sample, percent_sample, time, percent_time, max_t, min_t, mean_t.
 
   'perf kvm stat live' reports statistical data in a live mode (similar to
   record + report but with statistical data updated live at a given display
@@ -82,6 +82,8 @@ OPTIONS
 :GMEXAMPLESUBCMD: top
 include::guest-files.txt[]
 
+--stdio:: Use the stdio interface.
+
 -v::
 --verbose::
 	Be more verbose (show counter open errors, etc).
@@ -97,7 +99,10 @@ STAT REPORT OPTIONS
 -k::
 --key=<value>::
        Sorting key. Possible values: sample (default, sort by samples
-       number), time (sort by average time).
+       number), percent_sample (sort by sample percentage), time
+       (sort by average time), precent_time (sort by time percentage),
+       max_t (sort by maximum time), min_t (sort by minimum time), mean_t
+       (sort by mean time).
 -p::
 --pid=::
     Analyze events only for given process ID(s) (comma separated list).
-- 
2.34.1

