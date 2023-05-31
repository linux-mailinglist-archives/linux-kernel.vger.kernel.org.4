Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49FCB7185CE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 17:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234157AbjEaPMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 11:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234154AbjEaPML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 11:12:11 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33709107
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 08:12:10 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f505aace48so3890291e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 08:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1685545928; x=1688137928;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M1o4Wjc1Cd+qea3/6BxW++NOPFclyS7iyVbzxq2yJnM=;
        b=Xsh7wmb56AfkTGFNGfAoURmK0HS6z+XV2ALRtt5RWYeUEPKtRQN0zWKH1+/tWx2ChO
         GMTXteP2EObzHUyg6W/oBG3Lpr9zCgHEPJpan34MRkH3YHo1Tpg9D0YtIngKFJuBMg5K
         ukB1YMiBtgIxiccgf/cZWGDjHIzwtdp0XCOrimUjIsQyg1wOZzE81jLMMIl7dLRaGctF
         uGb/kLmfRNLYi2shrOabraf5t0YD0HnT7diFftFD3pC4v77XXr/91T1h8KLLjTP+rRYf
         Wc6YWE5/onF4g54mVyMS+rFk+4PkmWayq2iMlKRxZjekGE3HYQBpNA669F7LlnVSJALw
         Rn5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685545928; x=1688137928;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M1o4Wjc1Cd+qea3/6BxW++NOPFclyS7iyVbzxq2yJnM=;
        b=M9lkde5AWc5a42JgdoDpYtRxdxwnBuLq7+svBfRmou0M8u/tDROxlldD440kXz0TV/
         9V1ypENuHKgh23rzN8lzDOOsQp/gEFfOnezP74jqEuld8hh+7CTCbAMLSGxOEIEVsg+l
         P1cNNrIJmAR7qvee5O4Btt5JctU1mkybmle0J0zOVLnegA0G2ZGsygIwKB9eLa8nyY5G
         9/Xo3g2hcxzatuesqm0AKZTH5ACtAkhJ+BKFWUXNT5ysgf7X3wZUXwrox3Tmbcgjm5uH
         F4X0SjFvBzn1/bHv4zYFSQcIG2L1l6HBH8kpqS7TJbjXcjsuLkmwidg7ljaD04Xso47s
         7GyQ==
X-Gm-Message-State: AC+VfDx7GoMYqUXDyCySJTlHRqDO0KQ6KQnrw1+xuInq9gYaYgfNIrVk
        xW1jFDhEhB1n9bifX34UZ/EZsQ==
X-Google-Smtp-Source: ACHHUZ6HFVOQ+2uUMoZbOvBiq8z2lgUqeyqmyxMd2ASVv3Wpmnk8xG5ixCshIzQtQNpCNFCqlxN6uA==
X-Received: by 2002:ac2:518c:0:b0:4f3:baf9:8f8e with SMTP id u12-20020ac2518c000000b004f3baf98f8emr3047811lfi.4.1685545928497;
        Wed, 31 May 2023 08:12:08 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id u5-20020a05600c00c500b003f0ad8d1c69sm24598389wmm.25.2023.05.31.08.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 08:12:08 -0700 (PDT)
Date:   Wed, 31 May 2023 17:12:07 +0200
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
Subject: Re: [PATCH v2 09/10] tools: lib: perf: Implement riscv mmap support
Message-ID: <20230531-5e82a25977cfe463e4db1cd1@orel>
References: <20230512085321.13259-1-alexghiti@rivosinc.com>
 <20230512085321.13259-10-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230512085321.13259-10-alexghiti@rivosinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2023 at 10:53:20AM +0200, Alexandre Ghiti wrote:
> riscv now support mmaping hardware counters so add what's needed to
> take advantage of that in libperf.
> 
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  tools/lib/perf/mmap.c | 65 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 65 insertions(+)
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
