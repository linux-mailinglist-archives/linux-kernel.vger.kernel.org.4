Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7F8744232
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 20:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232631AbjF3S1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 14:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232141AbjF3S1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 14:27:04 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3D8125
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 11:27:01 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-66c729f5618so1851054b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 11:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688149621; x=1690741621;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+MGEKuy4Nf7dornYLukxVhbDcETcom+zcGjM3plM8Nc=;
        b=cVGunLYeWmUQGAQf3lovWRGWSR0TcbBHb4Y8apc2gLvK2jKN3WraWLIx+i1wC7syM1
         xNp3c2Dw0mxqK0Q9d7EstGXylZE3FY9I+IdulRH17Mk2q2T6pbCLQOIh/RNvpHiRWcbP
         164iVzp+JOTtRaP2xNJchQVZEjpiZaPGl+qRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688149621; x=1690741621;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+MGEKuy4Nf7dornYLukxVhbDcETcom+zcGjM3plM8Nc=;
        b=EM+7YvNX6C12ZE88yypkj9NSsu/f6DnR+/PYXslnzp9sZT5gIt5QVUt+jyu2t8bpak
         U0P3cGzpV4ET95THISuUArGTgbc7Wjkjsm228S/cbV7HtMXde95tFlRnYo5DKKEsslI0
         1n/0PtSXIros4ccpdQDQu4rpPlM2MsnzyCwn7ZU3JbjVieOdY58xG/qmF1Bwqrajnkju
         Vda7iuQlrTqqeGNkFzuuALy99WZowLYjeYtnYZZKK8B0pQbsEgh8Py9QE76+XYsjoSDa
         Q0uCjJYkw8hreCIZSb13cUnB4D0P+yC1sZdq8zmyb6R59BEs2R9/+9EG6TjdnowfhuIi
         /Gfg==
X-Gm-Message-State: ABy/qLY66YgbJS3UMDEAlvKuGRUZiFhArHxartj3vZ08edJAzUeRuxFL
        xbFSskD74rJwo3716rM49Ji3lQ==
X-Google-Smtp-Source: APBJJlEUOk6Acl3a1g9AJCQfsFvKOayNdfseye6ROPl1IEsyWrEGF0ii1Iv4vcSYKV0m9f3h3pWsgA==
X-Received: by 2002:a05:6a00:2d12:b0:682:4ef7:9b0b with SMTP id fa18-20020a056a002d1200b006824ef79b0bmr4322828pfb.0.1688149620695;
        Fri, 30 Jun 2023 11:27:00 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id v15-20020a62a50f000000b006528d9080f6sm5450990pfm.9.2023.06.30.11.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 11:27:00 -0700 (PDT)
Date:   Fri, 30 Jun 2023 11:26:59 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-riscv@lists.infradead.org, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] riscv: Add CFI error handling
Message-ID: <202306301126.D7EC815A22@keescook>
References: <20230629234244.1752366-8-samitolvanen@google.com>
 <20230629234244.1752366-12-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230629234244.1752366-12-samitolvanen@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2023 at 11:42:49PM +0000, Sami Tolvanen wrote:
> With CONFIG_CFI_CLANG, the compiler injects a type preamble immediately
> before each function and a check to validate the target function type
> before indirect calls:
> 
>   ; type preamble
>     .word <id>
>   function:
>     ...
>   ; indirect call check
>     lw      t1, -4(a0)
>     lui     t2, <hi20>
>     addiw   t2, t2, <lo12>
>     beq     t1, t2, .Ltmp0
>     ebreak
>   .Ltmp0:
>     jarl    a0
> 
> Implement error handling code for the ebreak traps emitted for the
> checks. This produces the following oops on a CFI failure (generated
> using lkdtm):
> 
> [   21.177245] CFI failure at lkdtm_indirect_call+0x22/0x32 [lkdtm]
> (target: lkdtm_increment_int+0x0/0x18 [lkdtm]; expected type: 0x3ad55aca)
> [   21.178483] Kernel BUG [#1]
> [   21.178671] Modules linked in: lkdtm
> [   21.179037] CPU: 1 PID: 104 Comm: sh Not tainted
> 6.3.0-rc6-00037-g37d5ec6297ab #1
> [   21.179511] Hardware name: riscv-virtio,qemu (DT)
> [   21.179818] epc : lkdtm_indirect_call+0x22/0x32 [lkdtm]
> [   21.180106]  ra : lkdtm_CFI_FORWARD_PROTO+0x48/0x7c [lkdtm]
> [   21.180426] epc : ffffffff01387092 ra : ffffffff01386f14 sp : ff20000000453cf0
> [   21.180792]  gp : ffffffff81308c38 tp : ff6000000243f080 t0 : ff20000000453b78
> [   21.181157]  t1 : 000000003ad55aca t2 : 000000007e0c52a5 s0 : ff20000000453d00
> [   21.181506]  s1 : 0000000000000001 a0 : ffffffff0138d170 a1 : ffffffff013870bc
> [   21.181819]  a2 : b5fea48dd89aa700 a3 : 0000000000000001 a4 : 0000000000000fff
> [   21.182169]  a5 : 0000000000000004 a6 : 00000000000000b7 a7 : 0000000000000000
> [   21.182591]  s2 : ff20000000453e78 s3 : ffffffffffffffea s4 : 0000000000000012
> [   21.183001]  s5 : ff600000023c7000 s6 : 0000000000000006 s7 : ffffffff013882a0
> [   21.183653]  s8 : 0000000000000008 s9 : 0000000000000002 s10: ffffffff0138d878
> [   21.184245]  s11: ffffffff0138d878 t3 : 0000000000000003 t4 : 0000000000000000
> [   21.184591]  t5 : ffffffff8133df08 t6 : ffffffff8133df07
> [   21.184858] status: 0000000000000120 badaddr: 0000000000000000
> cause: 0000000000000003
> [   21.185415] [<ffffffff01387092>] lkdtm_indirect_call+0x22/0x32 [lkdtm]
> [   21.185772] [<ffffffff01386f14>] lkdtm_CFI_FORWARD_PROTO+0x48/0x7c [lkdtm]
> [   21.186093] [<ffffffff01383552>] lkdtm_do_action+0x22/0x34 [lkdtm]
> [   21.186445] [<ffffffff0138350c>] direct_entry+0x128/0x13a [lkdtm]
> [   21.186817] [<ffffffff8033ed8c>] full_proxy_write+0x58/0xb2
> [   21.187352] [<ffffffff801d4fe8>] vfs_write+0x14c/0x33a
> [   21.187644] [<ffffffff801d5328>] ksys_write+0x64/0xd4
> [   21.187832] [<ffffffff801d53a6>] sys_write+0xe/0x1a
> [   21.188171] [<ffffffff80003996>] ret_from_syscall+0x0/0x2
> [   21.188595] Code: 0513 0f65 a303 ffc5 53b7 7e0c 839b 2a53 0363 0073 (9002) 9582
> [   21.189178] ---[ end trace 0000000000000000 ]---
> [   21.189590] Kernel panic - not syncing: Fatal exception
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Looks good -- should the noaddr failure paths include any warnings of
their own? (i.e. isn't that unexpected?)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
