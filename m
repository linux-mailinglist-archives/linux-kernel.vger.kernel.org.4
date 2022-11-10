Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2527C624D31
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 22:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbiKJVmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 16:42:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232369AbiKJVmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 16:42:06 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A82556561
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 13:42:05 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id h14so2818232pjv.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 13:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PSztxiJ5t6Iqa7j7QbwzknRhLr5EexaRl2lcq/yDKSw=;
        b=KoYGu5IIzOXGeXG4drNc1+CwdElhVuLMlSIl6h6O12ydrJyf4jnKTAAci0FKmlc3cD
         CFCqcSI0IR7sH97Be4G+724cCVPmUfuq1IklP/Mz0HAAQ/JGHC9E1jsHFAeNk9ap5iPH
         X8l0a8cDym+nzieJUbb0ErbioV8gI6DBsGAFtq9H+cXkpokKRbBw7dcWyCArFgJmuhmA
         pYIgByRnuTiDERvOvF0+ce6QtYY+nqszISkaZMWKuoiD+K36o/uo8MkgoNl+JjQDiOPK
         YHCcVp21lBiA2iqU1ltMC/EL2irkVChKb6Rko/vFgodMMth36AQZKJv+o/0xT9snWr9i
         Dn/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PSztxiJ5t6Iqa7j7QbwzknRhLr5EexaRl2lcq/yDKSw=;
        b=omagrORAZ56nLL82yaPEnzPIq/Y3ObttQVWMDUJX+rxgKa0kTYqA2g3r1MoO7W6ZUN
         23QQJguaTJc0GO6vxsNU96hKBQqZmcXJ8vMHdIQcNfl2ftQGbvPU6WUS57nz5gskZSlR
         Ocg+5amdzo1Mc771NC1i8H+gt1DXJYcOVvOc/B/rvz5tCpftX0s8FO9NwIiCu52+0H2G
         12J09BYUt8WrZLUspsAfpblbqn4Ut8wgN/pMKCfkptwFb15CDN8Q95fvcl2yUhUpWO5r
         L/wf/LjwsB9T3cXuNRZyW0oEU9I7GlVix9zbYSKpKoGTsi8TAJXOP85hXH50dZ9DfnHo
         4HDQ==
X-Gm-Message-State: ACrzQf1gty4HO2rTJZlevuQGzFduUlRIJMLwPFxsDNlWJ5+12Zxg+IKH
        dU1W998sG+SR0+aCD2dqunffXg==
X-Google-Smtp-Source: AMsMyM5Ko/0Xxdd0D4wfqneZtZye8DqKSLgy8+nDpiPvljrSklrs8pt0ztzdCwt6DpTGEU0urkT+5g==
X-Received: by 2002:a17:90b:3102:b0:213:b853:5e45 with SMTP id gc2-20020a17090b310200b00213b8535e45mr2178800pjb.97.1668116524759;
        Thu, 10 Nov 2022 13:42:04 -0800 (PST)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id p10-20020a170902bd0a00b00186c5e8b1d0sm145934pls.149.2022.11.10.13.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 13:42:03 -0800 (PST)
Date:   Thu, 10 Nov 2022 13:42:03 -0800 (PST)
X-Google-Original-Date: Thu, 10 Nov 2022 13:42:00 PST (-0800)
Subject:     Re: [PATCH] RISC-V: Do not issue remote fences until smp is available
In-Reply-To: <CAOnJCUK5Z6i39f5MJaRFhorGjcmBR=p_MapY_TDcR1e274wtpA@mail.gmail.com>
CC:     Conor Dooley <conor@kernel.org>, Atish Patra <atishp@rivosinc.com>,
        linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu,
        anup@brainfault.org, damien.lemoal@wdc.com,
        devicetree@vger.kernel.org, jszhang@kernel.org,
        krzysztof.kozlowski@canonical.com, linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>, robh+dt@kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     atishp@atishpatra.org
Message-ID: <mhng-76ad1ec7-7ad6-4223-9e6f-321ac56d6dee@palmer-ri-x1c9a>
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

On Mon, 31 Oct 2022 12:26:05 PDT (-0700), atishp@atishpatra.org wrote:
> On Mon, Oct 31, 2022 at 12:12 PM Conor Dooley <conor@kernel.org> wrote:
>>
>> On Fri, Oct 28, 2022 at 04:19:29PM -0700, Atish Patra wrote:
>> > It is useless to issue remote fences if there is a single core
>> > available. It becomes a bottleneck for sbi based rfences where
>> > we will be making those ECALLs for no reason. Early code patching
>> > because of static calls end up in this path.
>> >
>> > Signed-off-by: Atish Patra <atishp@rivosinc.com>
>>
>> Hey Atish,
>> This doesn't apply for me to either fixes or for-next. What branch does
>> it apply to?
>> Thanks,
>> Conor.
>>
>> > ---
>> >  arch/riscv/mm/cacheflush.c | 4 ++++
>> >  1 file changed, 4 insertions(+)
>> >
>> > diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
>> > index f10cb47eac3a..7fafc8c26505 100644
>> > --- a/arch/riscv/mm/cacheflush.c
>> > +++ b/arch/riscv/mm/cacheflush.c
>> > @@ -19,6 +19,10 @@ void flush_icache_all(void)
>> >  {
>> >       local_flush_icache_all();
>> >
>> > +     /* No need to issue remote fence if only 1 cpu is online */
>> > +     if (num_online_cpus() == 1)
>> > +             return;
>> > +
>> >       if (IS_ENABLED(CONFIG_RISCV_SBI) && !riscv_use_ipi_for_rfence())
>> >               sbi_remote_fence_i(NULL);
>> >       else
>> > --
>> > 2.34.1
>> >
>
> Sorry I forgot to specify the dependencies for this patch. This patch
> is based on Anup's IPI series [1] as
> I assumed the IPI series would go first. I can rebase on top of the
> master if required.
> However, the issue will manifest only after Jisheng's patch[2] which
> moved the sbi_init to earlier and introduced the
> static key in the paging_init path.
>
> [1] https://patchwork.kernel.org/project/linux-riscv/patch/20220820065446.389788-8-apatel@ventanamicro.com/
> [2] https://lore.kernel.org/lkml/20220716115059.3509-1-jszhang@kernel.org/

IMO we should just stop issuing the SBI remote fences at all, with the 
code to do IPI-based fences we're just adding complexity for the slow 
case.
