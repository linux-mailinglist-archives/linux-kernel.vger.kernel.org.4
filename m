Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74038730F05
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 08:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243549AbjFOGEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 02:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243393AbjFOGEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 02:04:00 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9915C2D67
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 23:03:34 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-3f9d619103dso106161cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 23:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686809014; x=1689401014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=632BrejRI47KfzW94FMEls4zOiM4nWP+5ukW0DARlOU=;
        b=m+oTFWNZgqs6EIO5/VqwGETqW4eELQmzYq1Jg6iGi9hMtFDsvo0UsRvpJgy6LUCUvK
         Gel4HeZxnnvQFlt6kwSz6xhGsEVf/VK9eCbUnh/e5VSB9Ie/sP/UnjrVDXGrkDQe90gm
         kJeFbT3d5LC3TBt4FfHv7eav9rFcG4CYXzpl1t6JIJHdzxeYOh/khPEfLehhBbvQhXAb
         YNqnm4fB6H0tkphT1DJN0GCrPKUCgWuvn1jhT27KCqdzFOtajEC7bfDVjpzHzJcAtuEr
         HjaO5R1ckggpuMKC3hVyHT6SHiiNFSMNIRBfhafZHgNSwvT2p2SYiGtHQoIr7utm8xDB
         uwfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686809014; x=1689401014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=632BrejRI47KfzW94FMEls4zOiM4nWP+5ukW0DARlOU=;
        b=bAau96TBPwizXGrPgI7x9kZMIop/bi3srclPJRtTOTL2keG7LhXwYsr6AyOIUWnBNW
         g58r1Tuoh+USoKjvdZ2OU4yBpFzD+wj0/gJARoxFAD9no9MAE8x+D/v3kzmNeJHVk6pQ
         gWAP7uGNSIo3WchIiLc48b0BPGl0wNeBhj7awqNDTl9HTrAzIUV4DBHwz4arW92J0l9C
         5/cbtT9XjL6y7i9pVenOvC4lcE92h/3wc+mLMgXJ+xQGOcPTcwC9ruDV75nYMdzUIFg+
         WEa+3wHzj53uSKWt8sZ2ofc4eTY/2eMUuzLux/gGR3TtlbYX6m98ZdMXjNkxAO88owS/
         835w==
X-Gm-Message-State: AC+VfDz7/Sn9koniWQcLiO7O9mm6DdOAQOSt5rSX7kRAFdcvy6cNfSjj
        hv0B6i9BQVNQVLWQL3ks/9ECMN8OU6VeCn48FD5rAw==
X-Google-Smtp-Source: ACHHUZ7+kJky3iNdrr5l2cYfbued1qOJZc7QntwFY/5I5w5adacEl72kq7hel4wFdjGuBTFESYfj9s8zZgLsP5JuZYI=
X-Received: by 2002:ac8:5b01:0:b0:3ef:2f55:2204 with SMTP id
 m1-20020ac85b01000000b003ef2f552204mr177771qtw.6.1686809013689; Wed, 14 Jun
 2023 23:03:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230615051700.1833-1-ravi.bangoria@amd.com>
In-Reply-To: <20230615051700.1833-1-ravi.bangoria@amd.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 14 Jun 2023 23:03:22 -0700
Message-ID: <CAP-5=fUZ+erp_cNoy4sSqPpZN8BmiPLui42o8+GtPzYj0gXmfw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] perf mem amd: Fix few logic bugs
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     acme@kernel.org, jolsa@kernel.org, namhyung@kernel.org,
        peterz@infradead.org, james.clark@arm.com, alisaidi@amazon.com,
        leo.yan@linaro.org, adrian.hunter@intel.com,
        kan.liang@linux.intel.com, mark.rutland@arm.com,
        maddy@linux.ibm.com, tmricht@linux.ibm.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ananth.narayan@amd.com,
        santosh.shukla@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 10:17=E2=80=AFPM Ravi Bangoria <ravi.bangoria@amd.c=
om> wrote:
>
> Recent PMU refactoring changes[1] introduced a notion of core vs other
> PMUs and made perf mem/c2c code depend only on core PMUs, which is
> logically wrong for AMD as perf mem/c2c on AMD depends on IBS OP PMU,
> not the core PMU. Although user visible perf mem/c2c functionality is
> still working fine, internal code logic is wrong. Fix those.
>
> [1] https://lore.kernel.org/r/20230527072210.2900565-1-irogers@google.com
>
> v1: https://lore.kernel.org/r/20230613095506.547-1-ravi.bangoria@amd.com
> v1->v2:
>  - Patch #2 of last version is already picked up by Arnaldo. So skip it.
>  - Scan all PMUs unconditionally in perf mem code instead of making it
>    conditional on arch.
>
> Ravi Bangoria (3):
>   perf pmus: Describe semantics of 'core_pmus' and 'other_pmus'
>   perf mem amd: Fix perf_pmus__num_mem_pmus()
>   perf mem: Scan all PMUs instead of just core ones

For the series:
Reviewed-by: Ian Rogers <irogers@google.com>
just a nit in a comment on the 2nd patch.

Thanks,
Ian

>
>  tools/perf/arch/x86/util/pmu.c | 12 ++++++++++++
>  tools/perf/util/mem-events.c   | 13 +++++++++----
>  tools/perf/util/pmus.c         | 17 ++++++++++++++++-
>  3 files changed, 37 insertions(+), 5 deletions(-)
>
> --
> 2.40.1
>
