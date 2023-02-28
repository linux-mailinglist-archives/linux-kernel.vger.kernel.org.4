Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAFA26A5867
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 12:36:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbjB1LgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 06:36:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbjB1LgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 06:36:05 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0569EF971
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 03:36:04 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id 6-20020a17090a190600b00237c5b6ecd7so8844286pjg.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 03:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=o//K/tErGPaPJ52r46l6Rxq+plE4dBlL3n3ahROgLsA=;
        b=D6k8bxREcPgb0FmW6ZpVz/wG9B5iQfpxlbGjk+Hi12FAw/wxJlITtDRe/EGC9pzTjA
         moa0q6yPJxYUmyEWj492+kaFVyYvdKMyniovt1TUgduSOk6tnxx6/rA8iJFsaCsu/K2Z
         PoSFMaWSHBXBtRNIs56fiJ62jIYeuDh3z+NkAjmB2Wg3uo6jON0rRjS08tBLfGR9bFmo
         jK1+rWeOkk0m2B/G9z64/cTj9agn4Eyu7nxYfO4TPSW/pt5bC1HAl5D6rZehsLMYQBDy
         VTIuzykyGeMRvJHtyUsIM9bzWdN+fi/SZLCSNUpiap6cBdHm4KYcukofgrk77pSWmzHW
         4OHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o//K/tErGPaPJ52r46l6Rxq+plE4dBlL3n3ahROgLsA=;
        b=7vr4ifiLOySFSAJ6uCicuypDuJ+kGyj/moLVSNhL63q0VRjCczq7ZgklAD+I8N8dBR
         AJI4d3FlueMJ4oJt4TuS7BOVocFjcXFPqzhUoE3WzFAZgiw2y52o9iDDzvur+/xYfyeH
         VZd/xnwdCHovhimrhRMyrkhfCVs3hprTJ+oYWGuyakClU62yEW6msQmB9woScLmOWUem
         OkYmzDM+fpV9dROSmc2Pujb5Rm+HTZ06gNFvaKnCD6I+LEfcVZshhfuwcpUneLkW7ngQ
         +/sUHzd+s1LqVFLNMUmEDxvPs2jtchexz2HjODI73OTTZvOEmbQPmdkf5GHU8murbpXA
         ZiHQ==
X-Gm-Message-State: AO0yUKUjHfo3Yfcj4ujYN1/lUy9AFc5Bmhzb+K6E29E9kwS7VP0iKmBi
        98pZeH34wmHZmEee3UGLClvxeA==
X-Google-Smtp-Source: AK7set9d8OSjLjeV3pqXHAmC+UhG8CPdsw8c53sE0CrU+XDHEF6X+GrnWDDTo0c2Cwo30jzN3xNOzA==
X-Received: by 2002:a17:90b:4acd:b0:233:f354:e7df with SMTP id mh13-20020a17090b4acd00b00233f354e7dfmr2988992pjb.18.1677584163380;
        Tue, 28 Feb 2023 03:36:03 -0800 (PST)
Received: from leoy-yangtze.lan (n058152048225.netvigator.com. [58.152.48.225])
        by smtp.gmail.com with ESMTPSA id p2-20020a17090a348200b00233567a978csm7784204pjb.42.2023.02.28.03.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 03:36:02 -0800 (PST)
Date:   Tue, 28 Feb 2023 19:35:57 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 13/14] perf kvm: Add TUI mode for stat report
Message-ID: <Y/3nHZdMQEoadoLG@leoy-yangtze.lan>
References: <20230228084147.106167-1-leo.yan@linaro.org>
 <20230228084147.106167-14-leo.yan@linaro.org>
 <678c5939-f512-d4f8-e290-9c0f2bf05023@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <678c5939-f512-d4f8-e290-9c0f2bf05023@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On Tue, Feb 28, 2023 at 11:12:17AM +0000, James Clark wrote:

[...]

> > +static void print_result(struct perf_kvm_stat *kvm);
> > +
> > +#ifdef HAVE_SLANG_SUPPORT
> 
> Hi Leo,
> 
> I get an error because of this addition when building on x86. I think
> it's because I don't have HAVE_SLANG_SUPPORT. It might be the same error
> that you mentioned on v1?
> 
>    builtin-kvm.c:535:13: error: ‘print_result’ used but never defined
> [-Werror]
>    535 | static void print_result(struct perf_kvm_stat *kvm);

It's a bit weird for reporting this issue, since you could see I have
moved the function definition for print_result() ahead the macro
condition '#ifdef HAVE_SLANG_SUPPORT'.

But I found building failure with below command:

  $ make VF=1 DEBUG=1 NO_SLANG=1

Let me repin this patch for the building failures; sorry I have been
negligent.

> Other than that, for the whole set:
> 
> Reviewed-by: James Clark <james.clark@arm.com>

Thanks a lot for reviewing!  I will apply your tag in next spin
except patch 13.

Leo
