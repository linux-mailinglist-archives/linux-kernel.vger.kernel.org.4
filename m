Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D34977185B6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 17:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234060AbjEaPIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 11:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234065AbjEaPII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 11:08:08 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D23D1BC
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 08:07:58 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f3b314b1d7so6539232e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 08:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1685545676; x=1688137676;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JUIbREcbx/7AYCYbP6hJBZ04/CWyd0xTzthWNvvFKW0=;
        b=CpdRFrDGLIRJKki5RjwxylxPBIFamWlGob2MdmpKb4HBlVP/tRQ13doI2Q6aF2nWQt
         CXk6kqO9Egk15pYIpSHmHy+QzOKB1W+xuz4hJf9LD8tmbKFjnyCbESeDgc+kw9Z+1jzj
         JQE3+HWfdLsErL/zbVzmgs8uXKzNLV1fuxZjATvFFXL5M8p5iJKf7Uq5nHp2PxFGj6SH
         lHUbchz2sVhxVTxsM77cueNtzFJshSst2SFewStnxOBaBsiBefJfqH8lrv1Rvdc3pIWA
         aurGDEE+qIriegaiVBQ+1e2w7d3M99inUa0YPEoxy4Fumca0XI7NMJ9lB+tvXz0B8jbb
         Pouw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685545676; x=1688137676;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JUIbREcbx/7AYCYbP6hJBZ04/CWyd0xTzthWNvvFKW0=;
        b=Ko7Y1gkWFK+9YdnMwzVhi25dZGHznnTghTmXi0cPECb4T9hE82AQsGKiXNLXiWTA+n
         QRlSiIO0rjmLLJovOqUPCiCDjf/4XDWDGKTFXpfneFKzM8MI5BJcDJnQ1ylFnI6kD1xg
         CihQj+/yw+C9dphfY1Aw4gHwJfwOT96HHa86IhEwEGxXy/ECr9pof1/EnZmt5hxfuX4V
         l1RKnWPFaSvAS2o5khCpE3sfxZF5M8OXZYI4AzznnjVyfqiPRybs27OnV0YJP1WHSOn1
         OQusnYG+pIgxPLFFOkj+T2kq1GjBYr6dD2XbRmQ9EJODE7vU3Sdah028KdUjlawtS7g0
         Krpw==
X-Gm-Message-State: AC+VfDzT6TahzHYiuY1NcPq+OOekkn4pPIIZZ/sv2znWZp/7p9hpDvsW
        8t4J9GUBAYjtl3iI0LUKzjE0Zw==
X-Google-Smtp-Source: ACHHUZ7E6kbDp2hRRtt+qsXk2F0ex4UkDmy/j1U8lrPnGhR9xK8TtMFExzBERPqMYV57ESb28Lkr0g==
X-Received: by 2002:a05:6512:4ce:b0:4f3:a69e:1d80 with SMTP id w14-20020a05651204ce00b004f3a69e1d80mr3069033lfq.0.1685545676307;
        Wed, 31 May 2023 08:07:56 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id m6-20020a7bce06000000b003f6050d35c9sm20952739wmc.20.2023.05.31.08.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 08:07:55 -0700 (PDT)
Date:   Wed, 31 May 2023 17:07:55 +0200
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
Subject: Re: [PATCH v2 08/10] Documentation: admin-guide: Add riscv
 sysctl_perf_user_access
Message-ID: <20230531-0707dc46df8078cd92711314@orel>
References: <20230512085321.13259-1-alexghiti@rivosinc.com>
 <20230512085321.13259-9-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230512085321.13259-9-alexghiti@rivosinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2023 at 10:53:19AM +0200, Alexandre Ghiti wrote:
> riscv now uses this sysctl so document its usage for this architecture.
> 
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  Documentation/admin-guide/sysctl/kernel.rst | 24 +++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
> index 4b7bfea28cd7..93cd518ca94b 100644
> --- a/Documentation/admin-guide/sysctl/kernel.rst
> +++ b/Documentation/admin-guide/sysctl/kernel.rst
> @@ -941,16 +941,32 @@ enabled, otherwise writing to this file will return ``-EBUSY``.
>  The default value is 8.
>  
>  
> -perf_user_access (arm64 only)
> -=================================
> +perf_user_access (arm64 and riscv only)
> +=======================================
> +
> +Controls user space access for reading perf event counters.
>  
> -Controls user space access for reading perf event counters. When set to 1,
> -user space can read performance monitor counter registers directly.
> +arm64
> +=====
>  
>  The default value is 0 (access disabled).
> +When set to 1, user space can read performance monitor counter registers
> +directly.
>  
>  See Documentation/arm64/perf.rst for more information.
>  
> +riscv
> +=====
> +
> +When set to 0, user access is disabled.
> +
> +When set to 1, user space can read performance monitor counter registers
> +directly only through perf, any direct access without perf intervention will
> +trigger an illegal instruction.
> +
> +The default value is 2, which enables legacy mode (user space has direct
> +access to cycle, time and insret CSRs only). Note that this legacy value
> +is deprecated and will be removed once all userspace applications are fixed.

All modes can access the time CSR so I'm not sure if it should be pointed
out here as if it's an exception. Maybe we shouldn't point it out at all
or we should point it out for all three?

Thanks,
drew
