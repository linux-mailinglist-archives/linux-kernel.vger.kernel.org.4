Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 848CA73938E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 02:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbjFVAJL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 21 Jun 2023 20:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjFVAJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 20:09:09 -0400
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0712A3;
        Wed, 21 Jun 2023 17:09:08 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-bc43a73ab22so156416276.0;
        Wed, 21 Jun 2023 17:09:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687392548; x=1689984548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9JwY1z34HajMBEgQFRBHMRG7XdiQHDpLz+pOguTwHBg=;
        b=XccwjGChuYsp9P1EdYh8lix3pWLrz4+yUsQv1a1yXRRcUedXR3O4FHEsa396TM/geR
         Ds4MJPYwtjRBMx7FMBVMynWeO/J1Cku3vRrT1RbRMcP34PoMRlWm/xXkrRjT4fwSwmXv
         Pgvi/+JtFBkHMVHK43RveO9kGCmlFNrFL+1IIe21VHg8oIh3cNJ+I7vHmjgkciujPAFp
         1QxXGz2Rk/GCJ3bZXS+6oU4taQLFdgudiViWJuSlNVjdL29CCqOU54ulZYcPGouuyP6T
         AyFY8Zdr66QdqEUVXhJoOguGjtyPzeWRZZtgo0QvEke1+BG5UPI9Nepidj6OmJYgvXXS
         kb0Q==
X-Gm-Message-State: AC+VfDxawuZIq+JQGb2ipfsNo/MHfXOrNFIp6I3QLwbJK+uvBQhCYbLt
        yBSfWPPKWTkFkNOlJGZSPyx3zw7XNiOyZ4pO6vg=
X-Google-Smtp-Source: ACHHUZ714CDLV6yfRZXyThDivy47Gt/f0HjzChbg9nlc8R9IE/46OU2Rnt5RAzPo4DKpW9xpz0G1fVcI0481rbwVdbI=
X-Received: by 2002:a25:2c5:0:b0:bd4:58f0:2014 with SMTP id
 188-20020a2502c5000000b00bd458f02014mr16481989ybc.6.1687392547748; Wed, 21
 Jun 2023 17:09:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230620170027.1861012-1-weilin.wang@intel.com>
In-Reply-To: <20230620170027.1861012-1-weilin.wang@intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 21 Jun 2023 17:08:56 -0700
Message-ID: <CAM9d7cichi8QpVFjCDUf8e5aJEuZg1JPHtMBEs_FSNtsm8VoeA@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] Add metric value validation test
To:     Weilin Wang <weilin.wang@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>, ravi.bangoria@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Jun 20, 2023 at 10:00 AM Weilin Wang <weilin.wang@intel.com> wrote:
>
> This is the fifth version of metric value validation tests.
>
> We made the following changes from v4 to v5:
>  - Update "()" to "{}" to avoid creating sub shell and successfully skip test on non-Intel
>  platform. [Ravi]
>
> v4: https://lore.kernel.org/lkml/20230618172820.751560-1-weilin.wang@intel.com/
>
> Weilin Wang (3):
>   perf test: Add metric value validation test
>   perf test: Add skip list for metrics known would fail
>   perf test: Rerun failed metrics with longer workload

Tested-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


$ ./perf test -v validation

107: perf metrics value validation                                   :
--- start ---
test child forked, pid 1900992
Launch python validation script ./tests/shell/lib/perf_metric_validation.py
Output will be stored in: /tmp/__perf_test.program.Mm9Rw
Starting perf collection
...
Workload:  perf bench futex hash -r 2 -s
Total metrics collected:  200
Non-negative metric count:  200
Total Test Count:  100
Passed Test Count:  100
Test validation finished. Final report:
[
    {
        "Workload": "perf bench futex hash -r 2 -s",
        "Report": {
            "Metric Validation Statistics": {
                "Total Rule Count": 100,
                "Passed Rule Count": 100
            },
            "Tests in Category": {
                "PositiveValueTest": {
                    "Total Tests": 200,
                    "Passed Tests": 200,
                    "Failed Tests": []
                },
                "RelationshipTest": {
                    "Total Tests": 5,
                    "Passed Tests": 5,
                    "Failed Tests": []
                },
                "SingleMetricTest": {
                    "Total Tests": 95,
                    "Passed Tests": 95,
                    "Failed Tests": []
                }
            },
            "Errors": []
        }
    }
]
test child finished with 0
---- end ----
perf metrics value validation: Ok
