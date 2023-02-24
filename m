Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 368CB6A2472
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 23:48:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjBXWsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 17:48:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBXWsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 17:48:14 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D083A298D9;
        Fri, 24 Feb 2023 14:48:13 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id h14so989119plf.10;
        Fri, 24 Feb 2023 14:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qeATGpMAUhlPhNlH9gLwCd/TfxdFp8lFPK3Fc+jb8A4=;
        b=Es3b3ycUyHUUzwLVFclE4aaFgl10/UTcec+goyMlkH/IUCyzlYs1lYdHiL7UhEwt3U
         TY692Ar4ptj+Or+3WFK5qEAhRXwp1uih2X/G+j7UiM+q0JiNAZru/VlDZA+KanFvhjJd
         Wn/pdc4L9yW3JWEDn/IZtvFmFxVeeSTQ6pNEunlboQf4p7lMtuSeFAdOLOxeabQwk4oY
         qw8njtIEm4wE5j7GkZYa1hc7099iTIRWn+J6KIQthbu/sS2MQ3R+A8vvpXUoKK4OI3rS
         hzr8O0m5LocQZF0GCwIObsnc9yEsBy6VunYD7vrNOwCe6DAa7qVYGzbfM6fnbmqRvJWE
         AIHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qeATGpMAUhlPhNlH9gLwCd/TfxdFp8lFPK3Fc+jb8A4=;
        b=3eA4GOL/e5lZtCOxCqUSxAjUk8WWvENBnNKdVOMBReKnPF3crO5GiZyc8pxdtnchLN
         KI6Bgg/tOgGrOWj/KsWFvX8qzqSZ7gdemnnxg4pG0fBEYjOs3GDMZ0tXRy7TL9plZJga
         8/h7lkXNPq+2gq+5oijUCZGUEouQwfd5uULOZO1T9sctscl+Vle+WG/iQV4u2ER7IzFk
         UQ9HydBQGGhICLCqWb6iCSH54QVRMTavGPhfiFiftpc9XoDNQ3YhqylAu0Ahhehyehb7
         P2JPK0muVECga7Z2pI2T/XCe58bK81f9Abx4Yuygth51fzYSJ2IOzPxMipxkeHsfQ9Ug
         PyGA==
X-Gm-Message-State: AO0yUKWU/zdtIWqKVov4Ru8IvYdCydxgP4EUmy8uK6SJ07DV9Yf5jl5s
        xsXJtXcZ9938Bk9xRZnkolU=
X-Google-Smtp-Source: AK7set+PhjoHKaKfk5icN0Rs8rA4nm5038euOGQAbYkKXG/+4fURV/b5B0PelIz1YulzEAHf6TFvvg==
X-Received: by 2002:a17:902:6b06:b0:19c:d5d4:843c with SMTP id o6-20020a1709026b0600b0019cd5d4843cmr2723168plk.20.1677278893220;
        Fri, 24 Feb 2023 14:48:13 -0800 (PST)
Received: from google.com ([2601:647:6780:44b0:776c:a206:d0db:818b])
        by smtp.gmail.com with ESMTPSA id m12-20020a170902bb8c00b00194a297cb8esm13674pls.191.2023.02.24.14.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 14:48:12 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
Date:   Fri, 24 Feb 2023 14:48:07 -0800
From:   Namhyung Kim <namhyung@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Sandipan Das <sandipan.das@amd.com>,
        James Clark <james.clark@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.g.garry@oracle.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Florian Fischer <florian.fischer@muhq.space>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Sean Christopherson <seanjc@google.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v1 50/51] perf stat: Use counts rather than saved_value
Message-ID: <Y/k+p8IPY/ftl3KQ@google.com>
References: <20230219092848.639226-1-irogers@google.com>
 <20230219092848.639226-51-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230219092848.639226-51-irogers@google.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 19, 2023 at 01:28:47AM -0800, Ian Rogers wrote:
> Switch the hard coded metrics to use the aggregate value rather than
> from saved_value. When computing a metric like IPC the aggregate count
> comes from instructions then cycles is looked up and if present IPC
> computed. Rather than lookup from the saved_value rbtree, search the
> counter's evlist for the desired counter.
> 
> A new helper evsel__stat_type is used to both quickly find a metric
> function and to identify when a counter is the one being sought. So
> that both total and miss counts can be sought, the stat_type enum is
> expanded. The ratio functions are rewritten to share a common helper
> with the ratios being directly passed rather than computed from an
> enum value.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
[SNIP]
> -static double runtime_stat_avg(enum stat_type type, int aggr_idx,
> -			       struct runtime_stat_data *rsd)
> +static double find_stat(const struct evsel *evsel, int aggr_idx, enum stat_type type)
>  {
> -	struct saved_value *v;
> -
> -	v = saved_value_lookup(NULL, aggr_idx, false, type, rsd->ctx, rsd->cgrp);
> -	if (!v)
> -		return 0.0;
> -
> -	return avg_stats(&v->stats);
> +	const struct evsel *cur;
> +	int evsel_ctx = evsel_context(evsel);
> +
> +	evlist__for_each_entry(evsel->evlist, cur) {
> +		struct perf_stat_aggr *aggr;
> +
> +		/* Ignore the evsel that is being searched from. */
> +		if (evsel == cur)
> +			continue;
> +
> +		/* Ignore evsels that are part of different groups. */
> +		if (evsel->core.leader->nr_members &&
> +		    evsel->core.leader != cur->core.leader)

The evsel->nr_members is somewhat confusing in that it counts itself
as a member.  I'm not sure it resets the nr_members to 0 for standalone
events.  You'd better checking nr_members greater than 1 for group
events.

Thanks,
Namhyung


> +			continue;
> +		/* Ignore evsels with mismatched modifiers. */
> +		if (evsel_ctx != evsel_context(cur))
> +			continue;
> +		/* Ignore if not the cgroup we're looking for. */
> +		if (evsel->cgrp != cur->cgrp)
> +			continue;
> +		/* Ignore if not the stat we're looking for. */
> +		if (type != evsel__stat_type(cur))
> +			continue;
> +
> +		aggr = &cur->stats->aggr[aggr_idx];
> +		if (type == STAT_NSECS)
> +			return aggr->counts.val;
> +		return aggr->counts.val * cur->scale;
> +	}
> +	return 0.0;
>  }
