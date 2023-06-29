Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99D8374301E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 00:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbjF2WEL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 29 Jun 2023 18:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjF2WEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 18:04:08 -0400
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A518630D1;
        Thu, 29 Jun 2023 15:04:07 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-bad0c4f6f50so1790533276.1;
        Thu, 29 Jun 2023 15:04:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688076247; x=1690668247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u7291qckVfYWCuKWv0VcLn223mZh7f/lbFxCabc9sbE=;
        b=jmzqg7iXkUIjrg4+0VioG2aemaX6sAg6PzM4d/nF4OD0lwq8ONkDTFzZI6EXvQ+V4D
         gAe3LY1YN/KshlH67Rx2kFkzA+aFRgyEq4ryjqsRgkUHVPw47YwFNFTDRmzmPQM6DUcP
         v6Hx1/397lDfuNBuk1UOLIGzF7zMW/ajHQzPRIws+neSHNEzi0nPQMUyPOjoO6J80RnE
         xLH5Hx/K57N3FLDTRd8GUyuIIxVD/bFzDeT13M8L0ITx4P0BuVrwKUPdfY7e/Cvdadx3
         gBIxxtwicvEWQRpQ1s3Gw2Im5MAU9PRU/mTRxLBc2c+I5zSI9mYdffj4ZY2cIfq48jvo
         Hfog==
X-Gm-Message-State: ABy/qLZ8lCG8hyWPK3nMAKQchnCyK6DvTF8WCrVrxdr+cyfWWBUdvBkk
        2f0MJC05KYz8r83afqUDxuYSMxUGJ1fsMKPJftM=
X-Google-Smtp-Source: APBJJlHRvuFCduHH5tQ2+DYic01wPkU/kvXGJwnlInLOsKGdvKug0WZYtaRoBE45TmehG+RPz7wMlc1hz9PXv2etPBc=
X-Received: by 2002:a25:ad94:0:b0:c12:29ac:1d35 with SMTP id
 z20-20020a25ad94000000b00c1229ac1d35mr1447153ybi.13.1688076246741; Thu, 29
 Jun 2023 15:04:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230628105303.4053478-1-james.clark@arm.com>
In-Reply-To: <20230628105303.4053478-1-james.clark@arm.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 29 Jun 2023 15:03:55 -0700
Message-ID: <CAM9d7cgo97jJTTTV7F2kJ=sF9MBoRwegN4r0dWotbUD=Nr1_cQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/1] perf tools: Add a place to put kernel config
 fragments for test runs
To:     James Clark <james.clark@arm.com>
Cc:     linux-perf-users@vger.kernel.org, acme@kernel.org,
        masahiroy@kernel.org, leo.yan@linaro.org, broonie@kernel.org,
        Aishwarya.TCV@arm.com, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org
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

Hi James,

On Wed, Jun 28, 2023 at 3:53 AM James Clark <james.clark@arm.com> wrote:
>
> Changes since RFC:
>
>  * Changed arch filename convention to use the ARCH= build time values
>    instead of uname
>
> It seems like there were no objections on the RFC, apart from maybe
> changing the perf tests to run as a kself test. But that's probably not
> going to happen for a while, if ever, and these fragments can always
> be moved in that case.

I missed the RFC, sorry.  Could you please add a link for that?

Thanks,
Namhyung


>
> James Clark (1):
>   perf tools: Add a place to put kernel config fragments for test runs
>
>  tools/perf/tests/config-fragments/README |  7 +++++++
>  tools/perf/tests/config-fragments/arm64  |  1 +
>  tools/perf/tests/config-fragments/config | 11 +++++++++++
>  3 files changed, 19 insertions(+)
>  create mode 100644 tools/perf/tests/config-fragments/README
>  create mode 100644 tools/perf/tests/config-fragments/arm64
>  create mode 100644 tools/perf/tests/config-fragments/config
>
>
> base-commit: ad5f604e186ac08d12c401e34ea96c09c38ddbc5
> --
> 2.34.1
>
