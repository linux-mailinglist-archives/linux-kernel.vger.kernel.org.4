Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 331FA64A460
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 16:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbiLLPqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 10:46:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232055AbiLLPqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 10:46:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553946320;
        Mon, 12 Dec 2022 07:46:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 01EF4B80D53;
        Mon, 12 Dec 2022 15:46:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91B09C433D2;
        Mon, 12 Dec 2022 15:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670859968;
        bh=2QkewT9Gyg7L5KqfYz9gcGz6oq9e3/Kl7bvOLkxlt0w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RgJwfbl8DaOqGZG+xOe96k9AqpqCKAkliJB3Ds5pxYcflQrmn3G7EcBqx3cfRaHB6
         YtQ5i6j+ljGp+ds4Gsqh2u73Mn0ctE2TSd+YZoK16jOdoLvqFN+Ybl97p01BYdmnM2
         9EpUfoEu1RsURfxUXHDtXKD49SGv8QZWwvuRGUhb3pzGlmeVxgSd2ekAn4sT0OfhOM
         qmiMdcm8RI5l5+o/zZJjjqVzk58ApyPzgxVLjGTJiEgSeQBekBnbdXOY6eBSnabyXC
         K1v5ma0txc5x5eOKxj5Oz3q50qKghGkqnhTVr3+AMg9iZnE8Yn9CcmxNepxk884y7s
         dz9jm9SA3xfgw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 50A8540483; Mon, 12 Dec 2022 12:46:06 -0300 (-03)
Date:   Mon, 12 Dec 2022 12:46:06 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     John Garry <john.g.garry@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v4] perf jevents: Parse metrics during conversion
Message-ID: <Y5dMvhMd7kbkAUyY@kernel.org>
References: <20221207055908.1385448-1-irogers@google.com>
 <Y5DQKif+PdRJblk+@kernel.org>
 <0d64e485-5acf-b7ad-e228-9bf85d8ae16d@oracle.com>
 <Y5DRjecE88KFc4He@kernel.org>
 <CAP-5=fWa=zNK_ecpWGoGggHCQx7z-oW0eGMQf19Maywg0QK=4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWa=zNK_ecpWGoGggHCQx7z-oW0eGMQf19Maywg0QK=4g@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Dec 08, 2022 at 09:41:55AM -0800, Ian Rogers escreveu:
> Apologies, I found an issue with a double-if. Could you add the 1 line
> fix plus test:

Had to apply manually, the patch was munged, end result should be the
same:


diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
index cc451a26575185f4..4797ed4fd817b1a0 100644
--- a/tools/perf/pmu-events/metric.py
+++ b/tools/perf/pmu-events/metric.py
@@ -462,6 +462,7 @@ class _RewriteIfExpToSelect(ast.NodeTransformer):
 
   def visit_IfExp(self, node):
     # pylint: disable=invalid-name
+    self.generic_visit(node)
     call = ast.Call(
         func=ast.Name(id='Select', ctx=ast.Load()),
         args=[node.body, node.test, node.orelse],
diff --git a/tools/perf/pmu-events/metric_test.py b/tools/perf/pmu-events/metric_test.py
index 4741b7b6612dc268..15315d0f716caf4e 100644
--- a/tools/perf/pmu-events/metric_test.py
+++ b/tools/perf/pmu-events/metric_test.py
@@ -87,6 +87,10 @@ class TestMetricExpressions(unittest.TestCase):
     after = r'min((a + b if c > 1 else c + d), e + f)'
     self.assertEqual(ParsePerfJson(before).ToPerfJson(), after)
 
+    before =3D r'a if b else c if d else e'
+    after =3D r'(a if b else (c if d else e))'
+    self.assertEqual(ParsePerfJson(before).ToPerfJson(), after)
+
   def test_ToPython(self):
     # pylint: disable=eval-used
     # Based on an example of a real metric.
 
> diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
> index cc451a265751..4797ed4fd817 100644
> --- a/tools/perf/pmu-events/metric.py
> +++ b/tools/perf/pmu-events/metric.py
> @@ -462,6 +462,7 @@ class _RewriteIfExpToSelect(ast.NodeTransformer):
> 
>   def visit_IfExp(self, node):
>     # pylint: disable=invalid-name
> +    self.generic_visit(node)
>     call = ast.Call(
>         func=ast.Name(id='Select', ctx=ast.Load()),
>         args=[node.body, node.test, node.orelse],
> diff --git a/tools/perf/pmu-events/metric_test.py
> b/tools/perf/pmu-events/metric_test.py
> index 4741b7b6612d..6980f452df0a 100644
> --- a/tools/perf/pmu-events/metric_test.py
> +++ b/tools/perf/pmu-events/metric_test.py
> @@ -87,6 +87,10 @@ class TestMetricExpressions(unittest.TestCase):
>     after = r'min((a + b if c > 1 else c + d), e + f)'
>     self.assertEqual(ParsePerfJson(before).ToPerfJson(), after)
> 
> +    before = r'a if b else c if d else e'
> +    after = r'(a if b else (c if d else e))'
> +    self.assertEqual(ParsePerfJson(before).ToPerfJson(), after)
> +
>   def test_ToPython(self):
>     # pylint: disable=eval-used
>     # Based on an example of a real metric.
> 
> Thanks,
> Ian
> 
> On Wed, Dec 7, 2022 at 9:47 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >
> > Em Wed, Dec 07, 2022 at 05:42:52PM +0000, John Garry escreveu:
> > > On 07/12/2022 17:40, Arnaldo Carvalho de Melo wrote:
> > > > Em Tue, Dec 06, 2022 at 09:59:08PM -0800, Ian Rogers escreveu:
> > > > > Currently the 'MetricExpr' json value is passed from the json
> > > > > file to the pmu-events.c. This change introduces an expression
> > > > > tree that is parsed into. The parsing is done largely by using
> > > > > operator overloading and python's 'eval' function. Two advantages
> > > > > in doing this are:
> > > > John, what tag can I get from you? 😄
> > > >
> > > > - Arnaldo
> > > Sure,
> > > Reviewed-by: John Garry <john.g.garry@oracle.com>
> >
> > Thanks a lot!
> >
> > - Arnaldo

-- 

- Arnaldo
