Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF46B718414
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 16:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236392AbjEaOB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 10:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237289AbjEaOB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 10:01:26 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B09D198B
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 06:55:35 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-30ad752f433so4075321f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 06:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1685541249; x=1688133249;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zbb0XlzY1V6un7ssRQbevCYzvMDnOinL05UrfKmM4xc=;
        b=C6P+PAcESg9pjJuC1kShZkAMK9uNCuZZC59NjruVdLAT+QbK5Fb7OyTaHMvt9uPzWB
         XC6YjFkU+s1LzKNcLemCA5UvlagHiacGzTfiM/R2e6hfVvlyHtQgvcdf+G/89fBAyaFn
         al95wHlokLtDX33yAGCyGXGWNp+6upvH+JRfhP/MfAomjpj7ykZGP6APMEFunMG6Um4A
         Q0GkFyAbz3+Gec81W0jn0DXHKIAfGHWPlMPSF60xf9udnMyIdlRQDSu26bSGscPRElke
         Ee9HUot213bm0c1us5iqLgmtj9PemzfMxCRv29nNkaPrcub3t3g85duWFbefmqdgiqmB
         Q95Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685541249; x=1688133249;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zbb0XlzY1V6un7ssRQbevCYzvMDnOinL05UrfKmM4xc=;
        b=iqfGu1x3QeC9QI/q7NnqV5/7aAuRRjeWkhagUUfb3N1k7V76bXXgj8fngpj+ZWYcf7
         gy1eTdxR/jncjXLgoCHAL+XcTB7AkdUHYbobP1BkYX4VMQPutmV4mKGcaeLBIGesZQyX
         +SDsAodP/09cb/NOt8K/m/Pk7htsBrwjxKIK0S6uPgzR57/Y0pDVETCVJW29jaHhiNox
         BhPD3gNoMNUPStbxkPmDPlPD2Mp4ZZrBLWs2YZjjW05ZVaAymCjT6Iu8gOjKp92lkIiN
         youXaEMcFmpg2f3Ex6w2ZoWiE0ufTkarcLRtJdtFR8R9+/I57EldAcZS9d9MitZK8VNq
         y8kA==
X-Gm-Message-State: AC+VfDwC6Ey1EGp4tFX4w6rJGhaQlO7uOk4YMs42RDPFbBeQfuJyXzoy
        +LVTsrmP8Kxnws8LrXOchhn2JA==
X-Google-Smtp-Source: ACHHUZ65HnfYl06bZQf8YF6kP/w87wKf4hufmXMk6i3aLTcwxJQjR5kyaJJ5JQgRjhi7bOY5IOdgjg==
X-Received: by 2002:adf:e848:0:b0:2f0:2d92:9c81 with SMTP id d8-20020adfe848000000b002f02d929c81mr4030977wrn.19.1685541248998;
        Wed, 31 May 2023 06:54:08 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id i16-20020a05600011d000b0030aefa3a957sm7021247wrx.28.2023.05.31.06.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 06:54:08 -0700 (PDT)
Date:   Wed, 31 May 2023 15:54:07 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 01/10] perf: Fix wrong comment about default event_idx
Message-ID: <20230531-5678beb107af4b9805cbb611@orel>
References: <20230512085321.13259-1-alexghiti@rivosinc.com>
 <20230512085321.13259-2-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230512085321.13259-2-alexghiti@rivosinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2023 at 10:53:12AM +0200, Alexandre Ghiti wrote:
> event_idx default implementation returns 0, not idx + 1.

The comment was correct until commit c719f56092ad ("perf: Fix and clean
up initialization of pmu::event_idx"). I'm not sure that warrants a fixes
tag, but maybe a reference in the commit message.

> 
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  include/linux/perf_event.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index d5628a7b5eaa..56fe43b20966 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -442,7 +442,8 @@ struct pmu {
>  
>  	/*
>  	 * Will return the value for perf_event_mmap_page::index for this event,
> -	 * if no implementation is provided it will default to: event->hw.idx + 1.
> +	 * if no implementation is provided it will default to 0 (see
> +	 * perf_event_idx_default).
>  	 */
>  	int (*event_idx)		(struct perf_event *event); /*optional */
>  
> -- 
> 2.37.2
>

Otherwise,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
