Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68ED8647510
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 18:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbiLHRmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 12:42:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiLHRmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 12:42:09 -0500
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73637E806
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 09:42:07 -0800 (PST)
Received: by mail-vs1-xe36.google.com with SMTP id b189so2125363vsc.10
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 09:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZLBXt2Jtw0kYFWpcJPTwwMQ6BDpS6jKcsiWh2x9aQ68=;
        b=q1rHnTY7Tadre4D+fqST2ld7So3s26m9HTLgoPCGDo1koR1yer4RbVIKn4L+Y2qbuU
         uW177VPnbUlziy1OucBIa1tm/gBCzOldbcB9kxUM1pn89texknSond0wO8diqwQIhcFY
         eKL6S8X2C/FaeIVDdJixZcJvZYjmLrrgBxZ5CBtywJC7ULgeultgKTu1tVT34nc3Z4b3
         PxJiKpJ8IAQZ9CLlkhSOj047IpG9ZjTgUPHarmjfF43MsGEmQrBKgSd+WefifG3W8q69
         zUPZbGp5ATTqyylOG6Mmj0VZBi+kYd7T7zIFLgwfePAbUWZkUndclxJa8QjLP+t/LWaB
         CjDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZLBXt2Jtw0kYFWpcJPTwwMQ6BDpS6jKcsiWh2x9aQ68=;
        b=Be3X9sWR1nkzl2M7UeBLSYIjYBxCQ5idrn/wkBoqQ6+EPPNyCcb/Yg13ytSCWMS65p
         5Oyub24n+Sy2NGZBHQuYOM4LGaT2l6ieHhodF9+BWJ8zWZh7MaAUMbSn90dSycotQW+T
         SIRhJoaoddtk8QDhX7ruxH+500WH2hOLPQn6UqjUnDSxr0HRIEHMPFYti9PY+3gNeOPB
         7OpChqWU8yOza05FgwUGyXVZ9Bvm2L/VBSzUQgoEWy4k/cjKBEYl1m+Sgw36JxwtieJN
         wM1yGqsAY1irHAd95n8ZsQ/pl97Gl98TTylHAY5NEu/byDy/oL6icnlk6GoONWRCr3Hw
         usmA==
X-Gm-Message-State: ANoB5pnyHxQm5CYZx90HyDXmtrxl9Y38RvbI4WQGagMSn/4O2a2Bhkop
        QFPjBMnI0m70O5XcxEwlEfa3lhrZ1lc1CVi1axad4Q==
X-Google-Smtp-Source: AA0mqf5988ezjzMU+pj3GZmQT8TbVYw3+msm3Gje3bceuHYPjEBbPuSHL9bVhPvP+54fI00E0UUCZLYWZcEtwKIds40=
X-Received: by 2002:a05:6102:114b:b0:3b0:5300:a99b with SMTP id
 j11-20020a056102114b00b003b05300a99bmr43661599vsg.23.1670521326913; Thu, 08
 Dec 2022 09:42:06 -0800 (PST)
MIME-Version: 1.0
References: <20221207055908.1385448-1-irogers@google.com> <Y5DQKif+PdRJblk+@kernel.org>
 <0d64e485-5acf-b7ad-e228-9bf85d8ae16d@oracle.com> <Y5DRjecE88KFc4He@kernel.org>
In-Reply-To: <Y5DRjecE88KFc4He@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 8 Dec 2022 09:41:55 -0800
Message-ID: <CAP-5=fWa=zNK_ecpWGoGggHCQx7z-oW0eGMQf19Maywg0QK=4g@mail.gmail.com>
Subject: Re: [PATCH v4] perf jevents: Parse metrics during conversion
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        John Garry <john.g.garry@oracle.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apologies, I found an issue with a double-if. Could you add the 1 line
fix plus test:

diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric=
.py
index cc451a265751..4797ed4fd817 100644
--- a/tools/perf/pmu-events/metric.py
+++ b/tools/perf/pmu-events/metric.py
@@ -462,6 +462,7 @@ class _RewriteIfExpToSelect(ast.NodeTransformer):

  def visit_IfExp(self, node):
    # pylint: disable=3Dinvalid-name
+    self.generic_visit(node)
    call =3D ast.Call(
        func=3Dast.Name(id=3D'Select', ctx=3Dast.Load()),
        args=3D[node.body, node.test, node.orelse],
diff --git a/tools/perf/pmu-events/metric_test.py
b/tools/perf/pmu-events/metric_test.py
index 4741b7b6612d..6980f452df0a 100644
--- a/tools/perf/pmu-events/metric_test.py
+++ b/tools/perf/pmu-events/metric_test.py
@@ -87,6 +87,10 @@ class TestMetricExpressions(unittest.TestCase):
    after =3D r'min((a + b if c > 1 else c + d), e + f)'
    self.assertEqual(ParsePerfJson(before).ToPerfJson(), after)

+    before =3D r'a if b else c if d else e'
+    after =3D r'(a if b else (c if d else e))'
+    self.assertEqual(ParsePerfJson(before).ToPerfJson(), after)
+
  def test_ToPython(self):
    # pylint: disable=3Deval-used
    # Based on an example of a real metric.

Thanks,
Ian

On Wed, Dec 7, 2022 at 9:47 AM Arnaldo Carvalho de Melo <acme@kernel.org> w=
rote:
>
> Em Wed, Dec 07, 2022 at 05:42:52PM +0000, John Garry escreveu:
> > On 07/12/2022 17:40, Arnaldo Carvalho de Melo wrote:
> > > Em Tue, Dec 06, 2022 at 09:59:08PM -0800, Ian Rogers escreveu:
> > > > Currently the 'MetricExpr' json value is passed from the json
> > > > file to the pmu-events.c. This change introduces an expression
> > > > tree that is parsed into. The parsing is done largely by using
> > > > operator overloading and python's 'eval' function. Two advantages
> > > > in doing this are:
> > > John, what tag can I get from you? =F0=9F=98=84
> > >
> > > - Arnaldo
> > Sure,
> > Reviewed-by: John Garry <john.g.garry@oracle.com>
>
> Thanks a lot!
>
> - Arnaldo
