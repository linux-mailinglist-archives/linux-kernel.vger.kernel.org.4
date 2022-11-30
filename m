Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA5E963DDE2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 19:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbiK3Sba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 13:31:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbiK3Sb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 13:31:26 -0500
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6CD8DBF2;
        Wed, 30 Nov 2022 10:31:24 -0800 (PST)
Received: by mail-wm1-f44.google.com with SMTP id ay27-20020a05600c1e1b00b003d070f4060bso2079182wmb.2;
        Wed, 30 Nov 2022 10:31:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mt9j106G+FOPWfXDN0MyStsR9ZfI3uJQSCfy8yQyoZ4=;
        b=1g+EroUdJ9UYfQY3wkG3RVhmx6jOrGVnVnxM88KUMNwHRT/AzH3I0LTK+M5AaK7PtX
         NwDjRA77uLTrJIfrglrKfphTsnfD3v912ETcLo/915EdvZvSd1OEIYk4H8neRxHEM79H
         Jx1vM+yHjdyBNMwerTYoq/x/ojjLyAh9TxRRISq4kv6OO2W+XiVVrdX5+OC/pi14IeQG
         37eIRLOkEIPjKd7wa8ruYZuqJicMiCV21/0nqM03abK08lAmfCjM23v/h8cc75RZwxZl
         c9d/GsL8roo5WpxyyMI7qkcIKafx63Lq6odIjUqfvlkZNZRYq/b82/N4eGHyZZafxpfw
         K5wA==
X-Gm-Message-State: ANoB5pn9lisfmGQCQECPiMF1J4XT7Hv31vellvXSy969iisouNMuMOjn
        mulpke28+VhMye4kg2aDNNK9oZFM3sXHzbZTCLw=
X-Google-Smtp-Source: AA0mqf6+b7JvI62nbUACAKLNq6Cq7ywMpa9NMITBZo/2JgTBrTEpAWzNu1mek9owvTn8B4TLaY9LAIiZsfVBFDljxEk=
X-Received: by 2002:a05:600c:6885:b0:3cf:a80d:59cd with SMTP id
 fn5-20020a05600c688500b003cfa80d59cdmr39435699wmb.5.1669833082922; Wed, 30
 Nov 2022 10:31:22 -0800 (PST)
MIME-Version: 1.0
References: <20221130111521.334152-1-james.clark@arm.com> <CAP-5=fXAhs-xgOo9GPH-w5f1QxNBCt5pdzpC5Cr7K+ovPzdgzw@mail.gmail.com>
In-Reply-To: <CAP-5=fXAhs-xgOo9GPH-w5f1QxNBCt5pdzpC5Cr7K+ovPzdgzw@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 30 Nov 2022 10:31:10 -0800
Message-ID: <CAM9d7cgBvD69=Dy82m7ucXQ85=GaY0P-awkjidA32EDuWAp1RA@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf tests: Fix "perf stat JSON output linter" test
 for new output
To:     Ian Rogers <irogers@google.com>
Cc:     James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, acme@kernel.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Nov 30, 2022 at 10:19 AM Ian Rogers <irogers@google.com> wrote:
>
> On Wed, Nov 30, 2022 at 3:15 AM James Clark <james.clark@arm.com> wrote:
> >
> > Commit c4b41b83c250 ("perf stat: Rename "aggregate-number" to
> > "cpu-count" in JSON") renamed a field, so update the tests to reflect
> > this.
> >
> > This fixes the following failure:
> >
> >   $ sudo ./perf test "json output" -vvv
> >    96: perf stat JSON output linter                                    :
> >   --- start ---
> >   test child forked, pid 327720
> >   Checking json output: no args [Success]
> >   Checking json output: system wide [Success]
> >   Checking json output: interval [Success]
> >   Checking json output: event [Success]
> >   Checking json output: per thread [Success]
> >   Checking json output: per node Test failed for input:
> >   ...
> >   Traceback (most recent call last):
> >     File "./tools/perf/tests/shell/lib/perf_json_output_lint.py", line 93, in <module>
> >       check_json_output(expected_items)
> >     File "./tools/perf/tests/shell/lib/perf_json_output_lint.py", line 78, in check_json_output
> >       raise RuntimeError(f'Unexpected key: key={key} value={value}')
> >   RuntimeError: Unexpected key: key=cpu-count value=16
> >   test child finished with -1
> >   ---- end ----
> >   perf stat JSON output linter: FAILED!
> >
> > Fixes: c4b41b83c250 ("perf stat: Rename "aggregate-number" to "cpu-count" in JSON")
> > Signed-off-by: James Clark <james.clark@arm.com>
>
> Namhyung mentioned reverting change c4b41b83c250, in which case
> merging this would break the test again. I think the revert is better.

Yep, I will send the revert soon.

Thanks,
Namhyung
