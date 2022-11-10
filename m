Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB2D8624E59
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 00:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbiKJXRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 18:17:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiKJXRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 18:17:21 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D4A11451
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 15:17:20 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id 130so2995900pgc.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 15:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a2bzNs4rtiIEWS4hP4fFa/WTzjX0pYcg+YnAfRUDQN0=;
        b=Xw3EpdN3gudzO9w1MQTSqivuHehUg3UFHs7GTJzfjHQuRrFtKgfDnTN5uTaXzTfxoG
         BrsSgabn0RC+9Rjyq1OQJG62qxSd3fOuTEH/MjtLZlI+P++RCJc3yIbi7ZAeaRwzvP6w
         8wyzh4TSPAHmK0q+rmuAB9O7THoPsu1HsTDZcpZVfgIY2SmxqZhk/cc014/nc9M3R5Up
         OuMXLbeH5ZKBofdUsvBIo2tAsxKL3MJ1mqTKCIbDtMQzTtgpP5qUHNR0nDFqI9QbFVKo
         p06DC7abQGdBPjxAZ/lHIVVcFsfnEt5ETNjR56PEHFa2ydVqf2IHnQm6HwHbI53yHuAb
         QgNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a2bzNs4rtiIEWS4hP4fFa/WTzjX0pYcg+YnAfRUDQN0=;
        b=EO6Np3zQq1QZt1uZKPdHnHrTP3J3e6yjd/Qdfq+ei1bCqjGlXEe4CXZ0uD91hwsAIf
         jtW81kKfWxnqH8rDyFzMQAkkCh9ZeoTnWc20Zar55z2sGRMeB32GFnsLohSDMezUidF3
         5uE3Gj5NM8TDkP930S+LV9zul1xvN/d67TPEEWvnfJ/bGLRm9fxQUJNpnR0GAAxtuyfK
         UmyuS+uSc6Re2/eS/muyDafwuRIX5AVEh17U3WSwiCKk05h2CM6A1mkuIeGWXZh1fzw1
         XA2Xpo2J73Ev7ZJySIaCKOLtj8hWhW2udIXj7SyJAl77tucrZmS1CDfHdsxUJ5OT2nx8
         +GJQ==
X-Gm-Message-State: ACrzQf0QA9zETR9O5rqDUf2+jrP/2wgsFesJQ4aUXKuYGnE78+gXbo9D
        yNFf69d2LHOHNvL3aRpaM3aXg3ndr4zTOA==
X-Google-Smtp-Source: AMsMyM7fh4Kur0PAb6g0H7G7SKOATz8yhuh3ZZgW15M4GbiGWv0ZqC7iVD85WQJ+IQZgK22mOcu/hg==
X-Received: by 2002:a63:d513:0:b0:46f:6afe:d94b with SMTP id c19-20020a63d513000000b0046f6afed94bmr3775600pgg.72.1668122240093;
        Thu, 10 Nov 2022 15:17:20 -0800 (PST)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id e29-20020a056a0000dd00b005668b26ade0sm190138pfj.136.2022.11.10.15.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 15:17:19 -0800 (PST)
Date:   Thu, 10 Nov 2022 15:17:19 -0800 (PST)
X-Google-Original-Date: Thu, 10 Nov 2022 15:14:30 PST (-0800)
Subject:     Re: [PATCH] RISC-V: vdso: Do not add missing symbols to version section in linker script
In-Reply-To: <20221108171324.3377226-1-nathan@kernel.org>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        Conor Dooley <conor@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, patches@lists.linux.dev, nathan@kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     nathan@kernel.org
Message-ID: <mhng-430179a1-e929-4bf8-8f7f-d176215f80a7@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 08 Nov 2022 09:13:23 PST (-0800), nathan@kernel.org wrote:
> Recently, ld.lld moved from '--undefined-version' to
> '--no-undefined-version' as the default, which breaks the compat vDSO
> build:
>
>   ld.lld: error: version script assignment of 'LINUX_4.15' to symbol '__vdso_gettimeofday' failed: symbol not defined
>   ld.lld: error: version script assignment of 'LINUX_4.15' to symbol '__vdso_clock_gettime' failed: symbol not defined
>   ld.lld: error: version script assignment of 'LINUX_4.15' to symbol '__vdso_clock_getres' failed: symbol not defined
>
> These symbols are not present in the compat vDSO or the regular vDSO for
> 32-bit but they are unconditionally included in the version section of
> the linker script, which is prohibited with '--no-undefined-version'.
>
> Fix this issue by only including the symbols that are actually exported
> in the version section of the linker script.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/1756
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  arch/riscv/kernel/vdso/Makefile   | 3 +++
>  arch/riscv/kernel/vdso/vdso.lds.S | 2 ++
>  2 files changed, 5 insertions(+)
>
> diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
> index f2e065671e4d..82416ebf4cca 100644
> --- a/arch/riscv/kernel/vdso/Makefile
> +++ b/arch/riscv/kernel/vdso/Makefile
> @@ -28,6 +28,9 @@ obj-vdso := $(addprefix $(obj)/, $(obj-vdso))
>
>  obj-y += vdso.o
>  CPPFLAGS_vdso.lds += -P -C -U$(ARCH)
> +ifneq ($(filter vgettimeofday, $(vdso-syms)),)
> +CPPFLAGS_vdso.lds += -DHAS_VGETTIMEOFDAY
> +endif
>
>  # Disable -pg to prevent insert call site
>  CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) -Os
> diff --git a/arch/riscv/kernel/vdso/vdso.lds.S b/arch/riscv/kernel/vdso/vdso.lds.S
> index 01d94aae5bf5..150b1a572e61 100644
> --- a/arch/riscv/kernel/vdso/vdso.lds.S
> +++ b/arch/riscv/kernel/vdso/vdso.lds.S
> @@ -68,9 +68,11 @@ VERSION
>  	LINUX_4.15 {
>  	global:
>  		__vdso_rt_sigreturn;
> +#ifdef HAS_VGETTIMEOFDAY
>  		__vdso_gettimeofday;
>  		__vdso_clock_gettime;
>  		__vdso_clock_getres;
> +#endif
>  		__vdso_getcpu;
>  		__vdso_flush_icache;
>  	local: *;
>
> base-commit: f0c4d9fc9cc9462659728d168387191387e903cc

Thanks, this is on fixes.  Something is confusing b4, so I've merged it 
using the old flow -- hopefully that still works ;)
