Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 286016FC27E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 11:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233784AbjEIJQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 05:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbjEIJQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 05:16:37 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A2CDC58
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 02:16:36 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9619095f479so886132866b.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 02:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1683623795; x=1686215795;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ESRtU13Q20lhgeVgaqet/6dyVYxVu+bxM8k/smriowo=;
        b=Uk9yV9EyvHzhIP9kQ+L+aLwpbcYJw1tTqOttKI4POpX+hA4O4NDfUG3ka3/m2DtpdE
         Eemk7BJUMb9ZkBLuGazl6xBfCKUKmdzhHSuoxt4zDCLasBmsLizqoiHoneiIKLJJRyrW
         Y5tG6BAXpb7Vfr+1MhNPNxZECG1gZRQfOeUmmC9a5E8JM9rIKrQc7VLHMZxyWhnHeIFh
         2a8NTd4q3bNYASOU2Cac/W2zI0IbbvttC2d7h90vrBh8399jtsYp17ggv7ACRxEojd8U
         2sWeyh78aLiWJ+GjfzeajzPsZg1KKQgX4kRyeb3nojUihhVA1xRnLT9bWe3wfo5XEOL9
         yUDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683623795; x=1686215795;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ESRtU13Q20lhgeVgaqet/6dyVYxVu+bxM8k/smriowo=;
        b=XUS12E7Jdmc4l6bejtiWXYQeAAUPxQuYl3J6gXlCDUyoe91Zb/ALfF97tFpO0/VlF1
         DgIEGiQJuNMbOj3zFdeiyFj00W/6reGMJA2qkow0nuk55hBMA/fYXkK/YXUFWfk0/eEH
         eeGvlqgfbBy8e/f+rm7lMtELHQidyZkYdz2P/kKBCrAPz8x4VZeDcfgqsKL/yYt/jUGA
         6p1KDncRTwyidtEEFIHDjuJEcJCHqbkZNtnJjxir59S84p5Tbs5OUmUl1TvaQInnLUkb
         5UE8uKddJNxcWzePjP50G9XW+ow5OTmTEVjU5lXh7pubtbWyo/81HMzCYMTLGpM0Z3Z4
         WDkQ==
X-Gm-Message-State: AC+VfDyahg3WxdUkoYNag8CE80pTURWbd70TYctIHOyL0WCNSTJY2uTL
        j1piT5bu++GerFuzk1D4Rv4x7ndxBW5r2rpvRbA=
X-Google-Smtp-Source: ACHHUZ7kR7bw/QdypkzfhJj3HmFGbVzTl2TetUM9WWyvfIlLdthtP8NbOw4V8SxZPoR7McpL7hnx9g==
X-Received: by 2002:a17:906:d554:b0:94f:e98:4e94 with SMTP id cr20-20020a170906d55400b0094f0e984e94mr11440790ejc.47.1683623795051;
        Tue, 09 May 2023 02:16:35 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id r23-20020aa7da17000000b00506987c5c71sm533721eds.70.2023.05.09.02.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 02:16:34 -0700 (PDT)
Date:   Tue, 9 May 2023 11:16:33 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     zhangfei <zhang_fei_0403@163.com>
Cc:     aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, zhangfei@nj.iscas.ac.cn
Subject: Re: [PATCH] riscv: Optimize memset
Message-ID: <20230509-b0dc346928ddc8d2b5690f67@orel>
References: <20230505-9ec599a36801972451e8b17f@orel>
 <20230509022207.3700-1-zhang_fei_0403@163.com>
 <20230509022207.3700-3-zhang_fei_0403@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230509022207.3700-3-zhang_fei_0403@163.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2023 at 10:22:07AM +0800, zhangfei wrote:
> From: zhangfei <zhangfei@nj.iscas.ac.cn>
> 
> > >  5:
> > > -	sb a1, 0(t0)
> > > -	addi t0, t0, 1
> > > -	bltu t0, a3, 5b
> > > +        sb a1, 0(t0)
> > > +        sb a1, -1(a3)
> > > +        li a4, 2
> > > +        bgeu a4, a2, 6f
> > > +
> > > +        sb a1, 1(t0)
> > > +        sb a1, 2(t0)
> > > +        sb a1, -2(a3)
> > > +        sb a1, -3(a3)
> > > +        li a4, 6
> > > +        bgeu a4, a2, 6f
> > > +
> > > +        sb a1, 3(t0)
> > > +        sb a1, -4(a3)
> > > +        li a4, 8
> > > +        bgeu a4, a2, 6f
> > 
> > Why is this check here?
> 
> Hi,
> 
> I filled head and tail with minimal branching. Each conditional ensures that 
> all the subsequently used offsets are well-defined and in the dest region.

I know. You trimmed my comment, so I'll quote myself, here

"""
After the check of a2 against 6 above we know that offsets 6(t0)
and -7(a3) are safe. Are we trying to avoid too may redundant
stores with these additional checks?
"""

So, again. Why the additional check against 8 above and, the one you
trimmed, checking 10?

> 
> Although this approach may result in redundant storage, compared to byte by 
> byte storage, it allows storage instructions to be executed in parallel and 
> reduces the number of jumps.

I understood that when I read the code, but text like this should go in
the commit message to avoid people having to think their way through
stuff.

> 
> I used the code linked below for performance testing and commented on the memset 
> that calls the arm architecture in the code to ensure it runs properly on the 
> risc-v platform.
> 
> [1] https://github.com/ARM-software/optimized-routines/blob/master/string/bench/memset.c#L53
> 
> The testing platform selected RISC-V SiFive U74.The test data is as follows:
> 
> Before optimization
> ---------------------
> Random memset (bytes/ns):
>            memset_call 32K:0.45 64K:0.35 128K:0.30 256K:0.28 512K:0.27 1024K:0.25 avg 0.30
> 
> Medium memset (bytes/ns):
>            memset_call 8B:0.18 16B:0.48 32B:0.91 64B:1.63 128B:2.71 256B:4.40 512B:5.67
> Large memset (bytes/ns):
>            memset_call 1K:6.62 2K:7.02 4K:7.46 8K:7.70 16K:7.82 32K:7.63 64K:1.40
> 
> After optimization
> ---------------------
> Random memset bytes/ns):
>            memset_call 32K:0.46 64K:0.35 128K:0.30 256K:0.28 512K:0.27 1024K:0.25 avg 0.31
> Medium memset (bytes/ns )
>            memset_call 8B:0.27 16B:0.48 32B:0.91 64B:1.64 128B:2.71 256B:4.40 512B:5.67
> Large memset (bytes/ns):
>            memset_call 1K:6.62 2K:7.02 4K:7.47 8K:7.71 16K:7.83 32K:7.63 64K:1.40
> 
> From the results, it can be seen that memset has significantly improved its performance with 
> a data volume of around 8B, from 0.18 bytes/ns to 0.27 bytes/ns.

And these benchmark results belong in the cover letter, which this series
is missing.

Thanks,
drew
