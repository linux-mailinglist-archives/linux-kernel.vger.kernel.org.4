Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B14DF7131CD
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 03:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbjE0Bz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 21:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjE0Bzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 21:55:55 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E711114
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 18:55:54 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b0201d9a9eso4974315ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 18:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685152554; x=1687744554;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=50rkrbLJVVboYecgPYKgeMphE+OaVJjRPZM9miVDUhs=;
        b=beCPuV/V7OuI1suBCjYxRtMGlT8BPdjHbEpyfLnUqawZaYHZufceQol3xzTW7DIa7C
         4ON+4K3zgdZghca/FQpzCbilB2zdHd3r67P46lUIK+xbsmLyB4Vdp0lUtcu1U8BsuNSt
         s1uFfCd0ZvhVhpPAmfRt8BR4MIZuNg8PXPSOq9cHDKIIPOhvm50GuFnB4dppetq4XS7P
         ePc9Wuor+9IPHVhgxTBnWUAOAlYC6q4AG6TKBhfwAl2RVmUAhB2wp0+uDFSV2q7vLzHP
         FU05kJXzYcR3WVTBrk/K9dZV8QHWcz2CIUXzAm7TMO+7MO02eBY6tE99QqEpZO287g6t
         8glg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685152554; x=1687744554;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=50rkrbLJVVboYecgPYKgeMphE+OaVJjRPZM9miVDUhs=;
        b=i5flE3JuZo6z9GWh3+TV8B3s6dWIb4d8E1DSyoD5BGVzi0cnXaJV5xxCRO+MkrIuDC
         uGJ06+69ajff1rPvCMcbLUpvlmdFO8koETvUlIUDkrRv6UXFzWbu9tVHp/CyHNu5pI4r
         mnS27npIHNC2l3cNbQgMTsTdAigbexdt4ujVjNFy2k9mKwiSHjMv6nx1yOGfTMhI1PnJ
         rUh8xJ7s8zrGoViQ9Xguh7QrhcfGbMC094Nhe0mZNIbNRgorcEZ57hJdu8eKqIa7WeeY
         RzT54ksqKL7uXAdQNFu/bPL0syxresrUK50PM2m77kzEfLjw36/853punCNim1d00UOu
         5Cyw==
X-Gm-Message-State: AC+VfDzVwQw7nfChZv6JD/ID1yj4KyZMbmP9utEUwRjR1y5SD7Uog/3e
        K41OxceyqgMWx3+dWUG0hqoy9g==
X-Google-Smtp-Source: ACHHUZ5cJy6CAykc9hMzO8zTqghMwRVEw6pl5aSVIDGDnBXSeoSTj2Ojvo+hf5XAxS+c2G4Hk0XjPA==
X-Received: by 2002:a17:903:41c3:b0:1af:f253:24b1 with SMTP id u3-20020a17090341c300b001aff25324b1mr1095383ple.9.1685152553710;
        Fri, 26 May 2023 18:55:53 -0700 (PDT)
Received: from leoy-huanghe ([107.151.177.130])
        by smtp.gmail.com with ESMTPSA id f12-20020a170902ce8c00b0019aaab3f9d7sm3838026plg.113.2023.05.26.18.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 18:55:53 -0700 (PDT)
Date:   Sat, 27 May 2023 09:55:20 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Hans-Peter Nilsson <hp@axis.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH 2/2] perf LoongArch: Simplify mksyscalltbl
Message-ID: <20230527015520.GB188137@leoy-huanghe>
References: <1684837327-18203-1-git-send-email-yangtiezhu@loongson.cn>
 <1684837327-18203-3-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1684837327-18203-3-git-send-email-yangtiezhu@loongson.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 06:22:07PM +0800, Tiezhu Yang wrote:
> In order to print the numerical entries of the syscall table,
> there is no need to call the host compiler to build and then
> run a program, this can be done directly by the shell script.
> 
> This is similar with commit 9854e7ad35fe ("perf arm64: Simplify
> mksyscalltbl").
> 
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  .../arch/loongarch/entry/syscalls/mksyscalltbl     | 32 ++++++----------------
>  1 file changed, 8 insertions(+), 24 deletions(-)
> 
> diff --git a/tools/perf/arch/loongarch/entry/syscalls/mksyscalltbl b/tools/perf/arch/loongarch/entry/syscalls/mksyscalltbl
> index c52156f..d7d97d5 100755
> --- a/tools/perf/arch/loongarch/entry/syscalls/mksyscalltbl
> +++ b/tools/perf/arch/loongarch/entry/syscalls/mksyscalltbl
> @@ -22,40 +22,24 @@ create_table_from_c()

Nitpick: since this patch tries to remove the temporary C program and
simply use shell to generate syscall table, to avoid confusion, it's
good to update the function name from create_table_from_c() to
create_sc_table().

I know Arm64's mksyscalltbl has the same issue, we can use a separate
patch to address it.

Otherwise, this patch LGTM:

Reviewed-by: Leo Yan <leo.yan@linaro.org>
