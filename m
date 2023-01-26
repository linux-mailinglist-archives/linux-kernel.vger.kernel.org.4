Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D25E67D9BF
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 00:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233512AbjAZXjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 18:39:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233511AbjAZXjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 18:39:21 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B09011661
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 15:38:48 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id d21-20020a25add5000000b007ff8112e8b8so3610718ybe.17
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 15:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xTYdmI9og0perxBFMnwOyD8JALYBo9fFqhvIGnAB7iw=;
        b=pN++yaxhHw5hsqtHgPMZeHJr1T+f83UqE4aoFtt5+LAeg4UHQo6kEIwVfN/W5KzpWd
         NAKHo1zdw7heZJbx1WfqGp1S+SxrOx8iQQEmdAlVDg2VTtwzUZXBX9I4nN6s/ySTc+jr
         3ZaRTEU2LdtjdBqC28mfYKA3RWWRWiipp0ubURRbSnB2td+dOXW6A6Z1YmXTTTs7lrMt
         kSSpO1HdzzSc0Io1imdV8ICez2HaQFT3vzJjPfo5xcK7Rc2m+quLXQ9DiPdQKhFDh9i9
         7D6enP4ZWLDUdi03ANNOdVpbRaEKQA7hGat0dQrO/F54JVVNV8CR5DwopbFxCgwL+Ylt
         8iEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xTYdmI9og0perxBFMnwOyD8JALYBo9fFqhvIGnAB7iw=;
        b=LF9iNDE3uju5cV6L8jhAxrzhU4QnfF6kYHff5HkorPunrOdajjHPHXkxAM3NJggqgP
         SX8yQFbJErVmVBetdq22OOueO3w3DcZLeyoURX18BmiGa3zfTUw+0XfXKrCMJz7T0bTR
         S2o8pIetfQpRhHTxI2QbXF2RCE5cVgrZfm31Ywq/l83h3XPFcrHq6pjooqOpSKlsVH2f
         O3BywE2T3aCcKfUx4i5IVzHcDEAgUB3dSqcmq2cEMNk86KlGHjSiJh1XYvVxyTTY59tW
         A1YoN9S/GKNZjo0wQkuAOqrMOn3PUMRiEv0xJVK8DTB9YANMXC8ShNbWacKl+UaC8xGA
         IGGA==
X-Gm-Message-State: AO0yUKWE4W0QAfhgWxrKi7OchygGi61YE3/iWK6Dflv8bmSCdlebqx4E
        l/+j60G81dkawKpUTdzmXh3OYrNRptRd
X-Google-Smtp-Source: AK7set8ogChtzu8dxXsUiUpTxkmy4XJKX0fEnPVUFfp8yLVVlaZbFvMbbtXJs9Lil32EN+jbOQsVkSj+abRi
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:b9b8:6de0:39b3:4cf7])
 (user=irogers job=sendgmr) by 2002:a25:ce90:0:b0:80b:6168:a831 with SMTP id
 x138-20020a25ce90000000b0080b6168a831mr1670207ybe.408.1674776313147; Thu, 26
 Jan 2023 15:38:33 -0800 (PST)
Date:   Thu, 26 Jan 2023 15:36:43 -0800
In-Reply-To: <20230126233645.200509-1-irogers@google.com>
Message-Id: <20230126233645.200509-14-irogers@google.com>
Mime-Version: 1.0
References: <20230126233645.200509-1-irogers@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Subject: [PATCH v5 13/15] perf jevents: Correct bad character encoding
From:   Ian Rogers <irogers@google.com>
To:     John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        Kang Minchul <tegongkang@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sandipan Das <sandipan.das@amd.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        linuxppc-dev@lists.ozlabs.org, Kajol Jain <kjain@linux.ibm.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A character encoding issue added a "3D" character that breaks the
metrics test.

Fixes: 40769665b63d ("perf jevents: Parse metrics during conversion")
---
 tools/perf/pmu-events/metric_test.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/metric_test.py b/tools/perf/pmu-events/metric_test.py
index ced5998bd827..e4c792428277 100644
--- a/tools/perf/pmu-events/metric_test.py
+++ b/tools/perf/pmu-events/metric_test.py
@@ -89,8 +89,8 @@ class TestMetricExpressions(unittest.TestCase):
     after = r'min((a + b if c > 1 else c + d), e + f)'
     self.assertEqual(ParsePerfJson(before).ToPerfJson(), after)
 
-    before =3D r'a if b else c if d else e'
-    after =3D r'(a if b else (c if d else e))'
+    before = r'a if b else c if d else e'
+    after = r'(a if b else (c if d else e))'
     self.assertEqual(ParsePerfJson(before).ToPerfJson(), after)
 
   def test_ToPython(self):
-- 
2.39.1.456.gfc5497dd1b-goog

