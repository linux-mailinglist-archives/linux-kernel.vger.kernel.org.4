Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D21BF693F46
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 09:03:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjBMIC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 03:02:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjBMIC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 03:02:57 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535209768
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 00:02:56 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id bg2so1839023pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 00:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1eCtcZtCR47U1MIhZ6xkb7WXfv9xH7fMalTcERPvTEc=;
        b=ez4JR4xqehpNflGapljH3KzW4VF5Xp4U0kyztUgaAaPQdul/PNoJXygpS9k07Fso0h
         SPVDPXoj9Nhs/oT4h1s3lWlur3ESALzQ/3ErCHIlgFhw1ZcA+YhpMSb5FYp1Y3pHDbcD
         Iw7f7nAW3/IfH9YG5GCZylvibb/joiNYCE7c17J8q+jPxSZRFqvMOQ38dWEDfv2xCAJl
         PqzR9Wr9ButwzzGWq5oHDqaplFqgVJsv2Y5lnEa5yn8TI5iF/CmICbtJSmwsVqflV3vN
         FJ6u00/RiAYFQCvRdB5m+9m4J48nfcOtYchJYT2VI5j2mrdePU1/TH24bqefuWLVUxlG
         +hKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1eCtcZtCR47U1MIhZ6xkb7WXfv9xH7fMalTcERPvTEc=;
        b=HtAzee9hy+idhJHRrl0Ph8OcTQZsLfY0FapIseNVjucNM/sG7xf7SBqNNIy4jo2EnG
         8qyPfJt/9wbkyS/LXB23jmDAVHay1KGU1yutMJR6QjIhJl0UTxZ6B+LE6386jMnggacN
         2OnwB98UrdYCjig6ZC9qNfo26aDVOXvx5ifNi9WK0B2KQOryrrF7L2AoCEkC8mXIlZ2J
         FS9arnOvAh8Mcr7fSgMQ5hfzSIHQevsGVE4+R0QJJuiQ9UqQ5B7cseqgRjFVtKLJuTXi
         Rn/VDKNAtwPSOT2FkSnlx1hPDsEj554C7zXt3wNMLRsPSnCkJl6SytCytSPqZxEESC9p
         SIog==
X-Gm-Message-State: AO0yUKUU+gJ4Qr7/8VYVuoMM+3YBLFIJKir/uuHYUfzNKJvfgcLpb7ro
        pgi59YhcBXVUovB94xALojliaw==
X-Google-Smtp-Source: AK7set9Co+HQgBjj06+W9UgioXLdyhFieGkYg4dEPCyHrN3c2X42VQ+qghVNMOHy+M9BwVXDnEc9sQ==
X-Received: by 2002:a17:902:d509:b0:196:22d5:6583 with SMTP id b9-20020a170902d50900b0019622d56583mr23433159plg.32.1676275375693;
        Mon, 13 Feb 2023 00:02:55 -0800 (PST)
Received: from leoy-yangtze.lan (211-75-219-203.hinet-ip.hinet.net. [211.75.219.203])
        by smtp.gmail.com with ESMTPSA id d10-20020a170902728a00b001949c680b52sm7537779pll.193.2023.02.13.00.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 00:02:55 -0800 (PST)
Date:   Mon, 13 Feb 2023 16:02:49 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Joe Mario <jmario@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>
Subject: Re: [PATCH] perf c2c: Add report option to show false sharing in
 adjacent cachelines
Message-ID: <Y+nuqcDBu9sC6F6A@leoy-yangtze.lan>
References: <20230213031733.236485-1-feng.tang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230213031733.236485-1-feng.tang@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 11:17:33AM +0800, Feng Tang wrote:
> Many platforms have feature of adjacent cachelines prefetch, when it
> is enabled, for data in RAM of 2 cachelines (2N and 2N+1) granularity,
> if one is fetched to cache, the other one could likely be fetched too,
> which sort of extends the cacheline size to double, thus the false
> sharing could happens in adjacent cachelines.
> 
> 0Day has captured performance changed related with this [1], and some
> commercial software explicitly makes its hot global variables 128 bytes
> aligned (2 cache lines) to avoid this kind of extended false sharing.
> 
> So add an option "-a" or "--double-cl" for c2c report to show false
> sharing in double cache line granularity, which acts just like the
> cacheline size is doubled. There is no change to c2c record. The
> hardware HITM events are still per cacheline. The option just changes
> the granularity of how events are grouped and displayed.
> 
> In the c2c report below (will-it-scale's pagefault2 case on old kernel):
> 
>   ----------------------------------------------------------------------
>      26       31        2        0        0        0  0xffff888103ec6000
>   ----------------------------------------------------------------------
>    35.48%   50.00%    0.00%    0.00%    0.00%   0x10     0       1  0xffffffff8133148b      1153        66       971     3748        74  [k] get_mem_cgroup_from_mm
>     6.45%    0.00%    0.00%    0.00%    0.00%   0x10     0       1  0xffffffff813396e4       570         0      1531      879        75  [k] mem_cgroup_charge
>    25.81%   50.00%    0.00%    0.00%    0.00%   0x54     0       1  0xffffffff81331472       949        70       593     3359        74  [k] get_mem_cgroup_from_mm
>    19.35%    0.00%    0.00%    0.00%    0.00%   0x54     0       1  0xffffffff81339686      1352         0      1073     1022        74  [k] mem_cgroup_charge
>     9.68%    0.00%    0.00%    0.00%    0.00%   0x54     0       1  0xffffffff813396d6      1401         0       863      768        74  [k] mem_cgroup_charge
>     3.23%    0.00%    0.00%    0.00%    0.00%   0x54     0       1  0xffffffff81333106       618         0       804       11         9  [k] uncharge_batch
> 
> The offset 0x10 and 0x54 used to displayed in 2 groups, and now they
> are listed together to give users a hint.
> 
> [1]. https://lore.kernel.org/lkml/20201102091543.GM31092@shao2-debian/
> 
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>

LGTM and I verified it on my Arm64 platform with peer flag:

Reviewed-by: Leo Yan <leo.yan@linaro.org>
Tested-by: Leo Yan <leo.yan@linaro.org>
