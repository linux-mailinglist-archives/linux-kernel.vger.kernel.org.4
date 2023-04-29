Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA7366F24B8
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 14:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjD2Mej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 08:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjD2Mei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 08:34:38 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1BA61BD4
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 05:34:36 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-2fa47de5b04so746715f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 05:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1682771675; x=1685363675;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oyTww+8/zlSGEpH0cgrTBvyiwJFDady3FmCvoDDMgT0=;
        b=A/z5TyUTqwCud45/kIkuGOx165IgVQyxljkiX3LKmU54aJnPA50bxIdVR7ORVbXPJG
         xLzfHVYD1z1C+uol3WpTyDpqwZGSqr1wH51zuS+TNV47qeoqch5NqgvTx9xAeqZY44IU
         XWA4SIStAPzkbCckFU/tbkQYR+hhIYkxqc9rsjeN13oSpTfat4mby2+qQH2b7+vr8MsO
         kVr7vr0bqsw5soMq/oHkc1kaIvmSxzIMNlotFeYuA3/n2lgPhzq76mR9b0G+QsX2p550
         4qYsIkYVYROlXo4IosM1ZtD6Cpm8cJ2fEQNX4jIWRknEVYDHna0vHNyJ5nBrjAXZGr0a
         oGlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682771675; x=1685363675;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oyTww+8/zlSGEpH0cgrTBvyiwJFDady3FmCvoDDMgT0=;
        b=JDgkR0fOWjntSx9nqIXQxnHAeZ41uy5V0rMZkoVOHa/WetcEzwQydsEimJk7c1H64j
         gJL+JgAlPuzKYkq/ZHxUk3Vz1v7RLONFt3z3r+SH7eOshPNghbmZM8tXfeiU89bMEWl8
         SEdVNTqX6Knrw91MzYoDuM5iiN5H7i+mhitR09fh8yafjHDrwr+WC/oYJjV0IGOQcm+l
         qA7eOBNUmzH74ys4xwvIDvkXUHKhAUi/eYR32nk4hj+uJHcDzTIOhG+O0bVVeo7FuSi1
         H5MI5HURvAB0LLMQcu9KKcIR7ELCf2j9uhceiPLEdQTnEtOJO0DCLsVf6eUHqxYlRK+O
         h8ig==
X-Gm-Message-State: AC+VfDw+Fj4XvtD5k0sHIgyyT3jpBUJRY9WNpjL6m4dpHll6qrckbepT
        7v6fJhl4v0dg7vX2cEPyaHMX8Q==
X-Google-Smtp-Source: ACHHUZ6+RfewAuyborC2LIhchXAkHF6ymuqX2qX76Qc+Bj0Gznua6O2fZa1Zh1/JuvhHM0dXQ6rcYg==
X-Received: by 2002:a05:6000:509:b0:2e8:b9bb:f969 with SMTP id a9-20020a056000050900b002e8b9bbf969mr6248178wrf.0.1682771675082;
        Sat, 29 Apr 2023 05:34:35 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id f11-20020adffccb000000b002f90a75b843sm23496085wrs.117.2023.04.29.05.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Apr 2023 05:34:34 -0700 (PDT)
Date:   Sat, 29 Apr 2023 14:34:33 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Evan Green <evan@rivosinc.com>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Bresticker <abrestic@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Celeste Liu <coelacanthus@outlook.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Dao Lu <daolu@rivosinc.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Jisheng Zhang <jszhang@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH 0/3] RISC-V: Export Zba, Zbb to usermode via hwprobe
Message-ID: <20230429-104e430d8f02e587aeff2652@orel>
References: <20230428190609.3239486-1-evan@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230428190609.3239486-1-evan@rivosinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 28, 2023 at 12:06:05PM -0700, Evan Green wrote:
> 
> This change detects the presence of Zba and Zbb extensions and exports
> them per-hart to userspace via the hwprobe mechanism. Glibc can then use
> these in setting up hwcaps-based library search paths.
> 
> There's a little bit of extra housekeeping here: the first change adds
> Zba to the set of extensions the kernel recognizes, and the second
> change starts tracking ISA features per-hart (in addition to the ANDed
> mask of features across all harts which the kernel uses to make
> decisions). Now that we track the ISA information per-hart, we could
> even fix up /proc/cpuinfo to accurately report extension per-hart,
> though I've left that out of this series for now.
> 
> 
> Evan Green (3):
>   RISC-V: Add Zba extension probing
>   RISC-V: Track ISA extensions per hart
>   RISC-V: hwprobe: Expose Zba and Zbb
> 
>  Documentation/riscv/hwprobe.rst       |  7 +++++
>  arch/riscv/include/asm/cpufeature.h   | 10 +++++++
>  arch/riscv/include/asm/hwcap.h        |  1 +
>  arch/riscv/include/uapi/asm/hwprobe.h |  2 ++
>  arch/riscv/kernel/cpu.c               |  1 +
>  arch/riscv/kernel/cpufeature.c        | 19 ++++++++----
>  arch/riscv/kernel/sys_riscv.c         | 43 ++++++++++++++++++++++-----
>  7 files changed, 70 insertions(+), 13 deletions(-)
> 
> -- 
> 2.25.1
>

For the series

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
