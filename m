Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60014697036
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 22:57:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjBNV54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 16:57:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBNV5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 16:57:54 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7956446A7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 13:57:51 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id f34so25292892lfv.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 13:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IzW7EdWt+H2V3Kpy1BOzuIn0tS7BIsZLy45FNNVskpE=;
        b=m6cZUxfcZuoQo87I9BrwOtVNeBPdIrbWsZoY40av2UhL/nx1lWG+Mi9IYEme+H5sqL
         UpRuyH0anVyktuduXrWORwY9Uc4DZQBgbRJyebRz9M7U1xujvpSEX+hbZixx6b6cPTfM
         XUslox8Gm7hScgluBdfNiwl/HRPtDw1cOvrM61kwzE4E1HKK2h0KXCTiyXLQw5ErCeGu
         PAp13Jj49WXXeujXpumhodutTWO7CJh8TPtS9omtoVSvDzYEWwaXQXAtFd6snoLimJwk
         Qntbhu5FuiUN8ZnFdLjErGbZJqJxDauZ8t0HKyV76d18XO1be8q1n3CJGc5Xfwkwqlhq
         Atqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IzW7EdWt+H2V3Kpy1BOzuIn0tS7BIsZLy45FNNVskpE=;
        b=iKFCfun5Bf4vIZw8QamZmaSv5A8cAUFoS94iWQWs2ZVXiC3uGOrKUetWscbhy3VqjH
         DmuJWq9V8/cxOoPLjg8KL55MfJ6HBV46bjQ9X9fFA2ynytTVvtXESR6f9WcLvmgyTdo7
         dTVXfp4JRtSqc8taQqscRqz8ixzcWTO210ozhAsdBsKHY1X+q011DGDhOOfbp68YXG6t
         ZYMWi7l6ShlWpvLcRUGOJetVgYpV0G4lb8fZJnmu1rI30NJAyWldUGQZD9zh2cny341+
         TbHT8XaQWBpgX8djmsZ4Oz6P1ltfTKJVGm/jhaDR48jRk0tarcftmZfvV16cmwAue3YH
         FtjQ==
X-Gm-Message-State: AO0yUKVtiPrZrKHUtQ/Fdz+fd9we2PbDteCU9+gUTEGTEzNFvfnSY9Na
        0xiiI81jsX2hBgn7brnyqkaFora22yu3f6tdbzsNyzgrqr1a36+e
X-Google-Smtp-Source: AK7set8J6iKIR76FeerAHsSRTfApXB6vWeYie51yHarQ8akNmOtIbVvyDDDQIVgP2xsJFPM1ouMHew77RV4hIpUDfas=
X-Received: by 2002:a05:6512:ba2:b0:4d9:869e:5c54 with SMTP id
 b34-20020a0565120ba200b004d9869e5c54mr709041lfv.9.1676411869729; Tue, 14 Feb
 2023 13:57:49 -0800 (PST)
MIME-Version: 1.0
References: <20230206201455.1790329-1-evan@rivosinc.com> <20230206201455.1790329-2-evan@rivosinc.com>
 <Y+v/Yu/ELfzx954s@spud>
In-Reply-To: <Y+v/Yu/ELfzx954s@spud>
From:   Evan Green <evan@rivosinc.com>
Date:   Tue, 14 Feb 2023 13:57:13 -0800
Message-ID: <CALs-Hss083BHj=bXv_nOqHXB8FNJEc4SSLW8ETqAh2+AmL0ocg@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] RISC-V: Move struct riscv_cpuinfo to new header
To:     Conor Dooley <conor@kernel.org>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>, vineetg@rivosinc.com,
        heiko@sntech.de, slewis@rivosinc.com,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Qinglin Pan <panqinglin2020@iscas.ac.cn>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sunil V L <sunilvl@ventanamicro.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 1:38 PM Conor Dooley <conor@kernel.org> wrote:
>
> On Mon, Feb 06, 2023 at 12:14:50PM -0800, Evan Green wrote:
> > In preparation for tracking and exposing microarchitectural details to
> > userspace (like whether or not unaligned accesses are fast), move the
> > riscv_cpuinfo struct out to its own new cpufeatures.h header. It will
> > need to be used by more than just cpu.c.
> >
> > Signed-off-by: Evan Green <evan@rivosinc.com>
> > ---
> >
> > (no changes since v1)
>
> Really? I don't recall seeing this patch in v1? ;)

My bad, that's an artifact of the tool I'm using (patman) to help me
with patch formatting.

>
> >
> >  arch/riscv/include/asm/cpufeature.h | 21 +++++++++++++++++++++
> >  arch/riscv/kernel/cpu.c             |  8 ++------
> >  2 files changed, 23 insertions(+), 6 deletions(-)
> >  create mode 100644 arch/riscv/include/asm/cpufeature.h
> >
> > diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
> > new file mode 100644
> > index 000000000000..66c251d98290
> > --- /dev/null
> > +++ b/arch/riscv/include/asm/cpufeature.h
> > @@ -0,0 +1,21 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/*
> > + * Copyright 2022 Rivos, Inc
> > + */
> > +
> > +#ifndef _ASM_CPUFEATURE_H
> > +#define _ASM_CPUFEATURE_H
> > +
> > +/*
> > + * These are probed via a device_initcall(), via either the SBI or directly
> > + * from the cooresponding CSRs.
>
> May as well fix the typo here while we are moving the code & a respin is
> required anyway.

Will do.

>
> I'm sure we'll need this patch regardless of approach, so:
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thank you!
