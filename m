Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1F166308AD
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 02:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233403AbiKSBqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 20:46:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233350AbiKSBqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 20:46:03 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE452729
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 17:11:49 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id m7-20020a05600c090700b003cf8a105d9eso5267511wmp.5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 17:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=poUEgSpW8aRR+UYT6TnHI6nLDP+vN2nQH/+BboE+CwA=;
        b=QJxTQsbhne1J0+HkYSqeeTJ8bAIxnkFEQPLDFXkPJOTL9+l4a2uz9W3tDZP/KE/OhI
         Uov3slDhLE8qws9664ELtwF5kXtbZz+9eqzqnj5B41WgPT9YXFxc6MnYIVIw8wmHdVxu
         cVtAW2Aiz5aLxZCJtkFz4y5svwqU0qfoexV+RiefHu+riHDabwWG4iux1ihYYAGcKMQU
         8OVS2r7SqG9dgCYqiwNYd+PkXiiIuzfohSYXXpiAM9e8MTjnJaeuHK4xlnrs+uzNjatW
         blQFethYpzfYBfhvU6HywPEwEpYwB0vfqhWkZ7iNzwniHirwV4FRf6mhxjdgIi3Oj5Oo
         1Vjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=poUEgSpW8aRR+UYT6TnHI6nLDP+vN2nQH/+BboE+CwA=;
        b=xnaSwTekIT8xuO3snlcO13OhF2ZU7eSqPwape/2e9C2XcBQL427RuHeosgMsFeaRdG
         /38ktVSMsb6wfw0ptT47S5xJTIVNfJa4EbLv241QowRxOaWDi8+dj2bUzenzBjGl0p6M
         FG7pWv4ALbl+WFYxe6KhUhIUCb2TQXhaFhD2H7Q+Rrk2TmKUkvl8s4oP+TKzZzv12wrn
         /v13m+qSZxhVOZ8+m7xurS2BbSe+aKt9sf59DHlHc1pyEQbjTZiT3wNxidhV1L7h2SEz
         mXnXxKD5OkCx5YwXp2Or2ASUnEPyAl1Ik5sfzdGrNqyFZLVZozv/5C0hugmL7ZODT0yc
         Bw1Q==
X-Gm-Message-State: ANoB5pk8LTYjDQL7mtUep0XxxnrhtgglUHgkHV+SJ2gMxcpAIHBxv9+M
        W8IDPtgLceyQtdhKhK6n2KeqXr2Sh1NiKlloQ1j0IQ==
X-Google-Smtp-Source: AA0mqf7V9eiJHCaM/vFfpvEdbjfi2x3hRxzmxWRSYnv0W7idsEOSf0y1t2VFaXjebmElzcfCavuMUUICqyvZPyC9wH8=
X-Received: by 2002:a7b:cb4d:0:b0:3cf:b2a6:267d with SMTP id
 v13-20020a7bcb4d000000b003cfb2a6267dmr6443367wmj.67.1668820307595; Fri, 18
 Nov 2022 17:11:47 -0800 (PST)
MIME-Version: 1.0
References: <20221118075702.40689-1-zhengjun.xing@linux.intel.com>
In-Reply-To: <20221118075702.40689-1-zhengjun.xing@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 18 Nov 2022 17:11:35 -0800
Message-ID: <CAP-5=fUGfJVLFzcUq8U-YH3S2EaPqJm3C2_uK4bF7m-NYpqNzQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] perf vendor events: Add the cpuid for Alderlake-N
To:     zhengjun.xing@linux.intel.com
Cc:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@intel.com, jolsa@kernel.org,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, ak@linux.intel.com,
        kan.liang@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 11:56 PM <zhengjun.xing@linux.intel.com> wrote:
>
> From: Zhengjun Xing <zhengjun.xing@linux.intel.com>
>
> Alderlake-N only has E-core, it has been moved to non-hybrid code path on
> the kernel side, add the cpuid for Alderlake-N separately. Both events for
> Alderlake and Alderlake-N are based on JSON file v1.16.

The update to 1.16 is true at the end of the patch series rather than
the beginning. It makes more sense to bump the version in the same
change that updates the json otherwise reverting the json changes
leaves the version number in place.

Thanks,
Ian


> Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  tools/perf/pmu-events/arch/x86/mapfile.csv | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
> index 5e609b876790..df47462a125f 100644
> --- a/tools/perf/pmu-events/arch/x86/mapfile.csv
> +++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
> @@ -1,5 +1,6 @@
>  Family-model,Version,Filename,EventType
> -GenuineIntel-6-(97|9A|B7|BA|BE|BF),v1.15,alderlake,core
> +GenuineIntel-6-(97|9A|B7|BA|BF),v1.16,alderlake,core
> +GenuineIntel-6-BE,v1.16,alderlaken,core
>  GenuineIntel-6-(1C|26|27|35|36),v4,bonnell,core
>  GenuineIntel-6-(3D|47),v26,broadwell,core
>  GenuineIntel-6-56,v23,broadwellde,core
> --
> 2.25.1
>
