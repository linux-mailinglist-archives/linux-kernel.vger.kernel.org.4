Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 096B37184D4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 16:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbjEaOYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 10:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232598AbjEaOY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 10:24:27 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED52193
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 07:24:18 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f606912ebaso61079045e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 07:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1685543057; x=1688135057;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UX4uQnFBny46FGtELxF82bEZ7MtHQbRmUfHqzbpy2lU=;
        b=IfZ/Ty5r3Rvqpyw7mbNjCMOnUMNLWEjwe+gPBeXaNQKgtzbrn43qBaFsQ01WG62yjv
         XME9SbyP0N5U1D9NoQRBkV9Zhqo1YGZZ53aXrSteaeilPxLX2+XbnbvtmK8KVitIuNum
         BTw0oVjDbhu+LZvVe9vwdVAdbPm6FM6OrfIGRXCfRJwEyWbKyAxPmC0AxCpZ/t4lXnVG
         ZEbjJhaOYnNF5I7VXOD2aSrPOgT/5V5ayPDbsai1cu/XzZW/x1EOnDPlftPM1zLUo5hK
         LpNd3f3eYdQgduYWjrWRqJHgEFVdyS9CpXr7n4tqRw18zRe8skA+G5OYnlILCzE7fCiE
         4hHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685543057; x=1688135057;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UX4uQnFBny46FGtELxF82bEZ7MtHQbRmUfHqzbpy2lU=;
        b=VqLKtuG5dsui9RTve7bGiTayIpzw9Xaku2i7J/Rs0OxR+qOs8mLQmQTVjt0+z30xnd
         GW1XzJngHGKmmD3oF5d3S+tKvtKAEL/GFeMfy9aJyz8ZR6Hm4cW7AULOCcFDnjeqeFJR
         XAnxiAbqjtSJwo0iMdeMZiZgEByZfdsXXpz+O10jLmxsZiLv+yVIwkDZ/daSt0/XJdg9
         BtyBbxJ0S6ufYZlWqVC9w+emgEzqGzCVZl4oxf0CCOAiwvjVCJ5B8L5a1jkhnuDIDKok
         XJXjygoAz7E+vn6XUPSMRQ9LdMGWiPBPyQpLPPxp9OJdHL2xgt9b+yqPmzc2LOlL45XZ
         v+RQ==
X-Gm-Message-State: AC+VfDzro3N8inFCDWFPiPn1awA7E3KRDDkyP4JHy31BD6GIvD52lIax
        gd712NVY1Xz+qbpUzwtNHPgy8g==
X-Google-Smtp-Source: ACHHUZ5dPMhB9kse11TIMIIwrwKdudQXmklhlG9pDb6dSrstXMUpAu5VAPxTeBjZUNfqusU9DTLd+A==
X-Received: by 2002:a1c:f30e:0:b0:3f6:e42:8f85 with SMTP id q14-20020a1cf30e000000b003f60e428f85mr4390658wmq.37.1685543057440;
        Wed, 31 May 2023 07:24:17 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id u20-20020a05600c211400b003f4ebeaa970sm21044711wml.25.2023.05.31.07.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 07:24:17 -0700 (PDT)
Date:   Wed, 31 May 2023 16:24:16 +0200
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
Subject: Re: [PATCH v2 05/10] riscv: Prepare for user-space perf event mmap
 support
Message-ID: <20230531-107c91fd5c1926f7c8a2a25d@orel>
References: <20230512085321.13259-1-alexghiti@rivosinc.com>
 <20230512085321.13259-6-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230512085321.13259-6-alexghiti@rivosinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2023 at 10:53:16AM +0200, Alexandre Ghiti wrote:
> Provide all the necessary bits in the generic riscv pmu driver to be
> able to mmap perf events in userspace: the heavy lifting lies in the
> driver backend, namely the legacy and sbi implementations.
> 
> Note that arch_perf_update_userpage is almost a copy of arm64 code.
> 
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  arch/riscv/kernel/Makefile     |  2 +-
>  arch/riscv/kernel/perf_event.c | 58 ++++++++++++++++++++++++++++++++++
>  drivers/perf/riscv_pmu.c       | 41 ++++++++++++++++++++++++
>  include/linux/perf/riscv_pmu.h |  4 +++
>  4 files changed, 104 insertions(+), 1 deletion(-)
>  create mode 100644 arch/riscv/kernel/perf_event.c
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
