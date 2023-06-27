Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F16E8740406
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 21:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbjF0TeA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 27 Jun 2023 15:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjF0Td7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 15:33:59 -0400
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BCA31BC3;
        Tue, 27 Jun 2023 12:33:58 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-5700b15c12fso52289837b3.1;
        Tue, 27 Jun 2023 12:33:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687894437; x=1690486437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nEEQwXF6153JBPAVoTjMd1AVh+oNM4vqAmX0ynTyiqE=;
        b=AF2w6bgthwYBxLkX70SaP35HCkk7GtKB+tyiVZFHr/6Yl+waihjqZwD8ScCUXINnKC
         jJnyRoSp07F0JFdKKUBtKU4MD8nS+fS3oTi6/wg/yCntMDaPUJfVUeuZMfTsZu0yuC5B
         ianPpixnGjeCdjuyUZHvGIdkbZtCg4jB8hHYpZBri57BeJt4IybsrXDhf1pjLA1z1D9b
         2PZTI0lxKr2zBkWU9CYfPpHrB5Wnsc9NgL5XyliZHt/WLqQApVGo0SxbdEN10YTdn5Ri
         VdURM0WvqaOK6OTLGZ4HjjQsWH47wHqGh0jvLNpAFeDlwGE6nnZ11jjVbSqCm9eVaswR
         Dv6g==
X-Gm-Message-State: AC+VfDwsntPd73+/XT5VNYOFKAluqsuvuelXc+2HXpPl1zeFVX/0Wm3a
        kSYSf+oIXaqXq+Mzuq8u0/dTCmHRPX5f8AZzqXk=
X-Google-Smtp-Source: ACHHUZ4RDHiTTnTdXB6PlN9mTF5J4NX2BboW/pyuodYfFqe5grFk1xYdA6rWB6mEFqZ4xiZnA9XlV/Qc2ef1FuhnWCk=
X-Received: by 2002:a25:b09f:0:b0:be3:bf87:3ebc with SMTP id
 f31-20020a25b09f000000b00be3bf873ebcmr30298883ybj.56.1687894437518; Tue, 27
 Jun 2023 12:33:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230626053048.257959-1-irogers@google.com> <CAM9d7cgrVEUBrmF4+w02ENQwSG-Ek6H_O7B0cUgPxv_wvsj5MQ@mail.gmail.com>
In-Reply-To: <CAM9d7cgrVEUBrmF4+w02ENQwSG-Ek6H_O7B0cUgPxv_wvsj5MQ@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 27 Jun 2023 12:33:46 -0700
Message-ID: <CAM9d7ci8ywh47tkdQOo-Y4QDvUquwSJhUDCg3ezmErjsitdTjA@mail.gmail.com>
Subject: Re: [PATCH v1] perf pmu: Correct auto_merge_stats test
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 3:15 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Hi Ian,
>
> On Sun, Jun 25, 2023 at 10:31 PM Ian Rogers <irogers@google.com> wrote:
> >
> > The original logic was:
> > https://lore.kernel.org/all/20230527072210.2900565-35-irogers@google.com/
> > return !is_pmu_hybrid(pmu->name)
> >
> > is_pmu_hybrid was removed but with the incorrect condition which was
> > fixed for core PMUs but not uncore. This change fixes both.
> >
> > Fixes: e23421426e13 ("perf pmu: Correct perf_pmu__auto_merge_stats() affecting hybrid")
> > Signed-off-by: Ian Rogers <irogers@google.com>
>
> Tested-by: Namhyung Kim <namhyung@kernel.org>

Applied to perf-tools-next, thanks!
