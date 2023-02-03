Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65A01689833
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 13:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232640AbjBCMBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 07:01:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232562AbjBCMBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 07:01:14 -0500
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED85953FD
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 04:01:13 -0800 (PST)
Received: by mail-vk1-xa2c.google.com with SMTP id t190so2426532vkb.13
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 04:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bVBPlUOA2Saz8Z2ELzkGmW92oTRqygdhDOd3NoQ2OvM=;
        b=C0uuf321Wlpg5+wIml2URGup0sUV3eCPnVIs2mDubn8aIXCDxAhcQSy9bMxjMoDglN
         WcXKKTa6sG7igE+h+BLd8BeJdcl8aT3AGLNm/QAUA8CLyEZ3tLodnzc9O6xFxOH9H2rm
         RG7c3hxqIFNYoSIwwLgsm/pxZCwRhRha88p+JP4D/8dVsQxT5KKKcCaFXDWjhWbf4VwI
         DKHc1USEDM+uqwVFaEleFuPeRlzU2HoNi+DorLJNKMj9937DweWd35ye2+U8oXmJA2Jn
         suSVFvjiD+nJ1WVEq4UEg8W3YIvny6e1yTg4NCLHFkgbu2oeqlA3w0vuckXv9FQDGlIL
         /Ong==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bVBPlUOA2Saz8Z2ELzkGmW92oTRqygdhDOd3NoQ2OvM=;
        b=NJGWPi31joCVfXyoMrXuLAAg7YPokVDtbTI2GD88zzyfW5n42JApp4heu1xabyyYwp
         A6QbmSjPbYVOlchEHgIyu+N24J/2aPOx66zvfDE2yTix58oURq7JEIxl5GPJCC0JfY6C
         05Vrcgwu75e4tbAIBm5pc8xMWe1QREQKr1Uakyl3JhijXuW/16n0JgCQio7Vxmeq87rb
         RSYHdLvMNogdchyr2F6Z28PmDRVl7hx96cVOVq41f5qRypEKnwbJmajPDvok9RRoX4ar
         flVVpAYLu6ofMcMqlHOG9jIuYBfRiq3EIGKOWGNC7jwso5dvB2ajc3mXpQW8mIJHLuKB
         zRXg==
X-Gm-Message-State: AO0yUKWsQB0nFyTd6dNYr1vLTVMofB/Sq8qm1BgWGtsch8CVgHSBNrOe
        8+7Mja/1SkdD2CO6SX3UVFAa41Zo2J/Cqgf7c2LzWg==
X-Google-Smtp-Source: AK7set8Q/OFTvZSYsRPT84VinKFWhLoPFlGow5ONcJ4RtLja8SFxkXGoz+YFgryocUWfojsT3S3jNMO/0HXz/NNCAyc=
X-Received: by 2002:a1f:6e0c:0:b0:3e1:95e8:fe1e with SMTP id
 j12-20020a1f6e0c000000b003e195e8fe1emr1584545vkc.1.1675425672447; Fri, 03 Feb
 2023 04:01:12 -0800 (PST)
MIME-Version: 1.0
References: <20230128072737.2995881-3-apatel@ventanamicro.com> <mhng-0f9bdf58-5289-4db4-8fd7-38898824c44f@palmer-ri-x1c9>
In-Reply-To: <mhng-0f9bdf58-5289-4db4-8fd7-38898824c44f@palmer-ri-x1c9>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Fri, 3 Feb 2023 17:31:01 +0530
Message-ID: <CAK9=C2X8C4yswGhDwe1OzQXTELXQxp8=ayiFxh1aVMk4TxeDjw@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] RISC-V: Detect AIA CSRs from ISA string
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     pbonzini@redhat.com, atishp@atishpatra.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        ajones@ventanamicro.com, anup@brainfault.org, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 3, 2023 at 5:54 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> On Fri, 27 Jan 2023 23:27:32 PST (-0800), apatel@ventanamicro.com wrote:
> > We have two extension names for AIA ISA support: Smaia (M-mode AIA CSRs)
> > and Ssaia (S-mode AIA CSRs).
>
> This has pretty much the same problem that we had with the other
> AIA-related ISA string patches, where there's that ambiguity with the
> non-ratified chapters.  IIRC when this came up in GCC the rough idea was
> to try and document that we're going to interpret the standard ISA
> strings that way, but now that we're doing custom ISA extensions it
> seems saner to just define on here that removes the ambiguity.
>
> I just sent
> <https://lore.kernel.org/r/20230203001201.14770-1-palmer@rivosinc.com/>
> which documents that.

I am not sure why you say that these are custom extensions.

Multiple folks have clarified that both Smaia and Ssaia are frozen
ISA extensions as-per RVI process. The individual chapters which
are in the draft state have nothing to do with Smaia and Ssaia CSRs.

Please refer:
https://github.com/riscv/riscv-aia/pull/36
https://lists.riscv.org/g/tech-aia/message/336
https://lists.riscv.org/g/tech-aia/message/337

>
> > We extend the ISA string parsing to detect Smaia and Ssaia extensions.
> >
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> > ---
> >  arch/riscv/include/asm/hwcap.h | 2 ++
> >  arch/riscv/kernel/cpu.c        | 2 ++
> >  arch/riscv/kernel/cpufeature.c | 2 ++
> >  3 files changed, 6 insertions(+)
> >
> > diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
> > index 86328e3acb02..341ef30a3718 100644
> > --- a/arch/riscv/include/asm/hwcap.h
> > +++ b/arch/riscv/include/asm/hwcap.h
> > @@ -59,6 +59,8 @@ enum riscv_isa_ext_id {
> >       RISCV_ISA_EXT_ZIHINTPAUSE,
> >       RISCV_ISA_EXT_SSTC,
> >       RISCV_ISA_EXT_SVINVAL,
> > +     RISCV_ISA_EXT_SMAIA,
> > +     RISCV_ISA_EXT_SSAIA,
> >       RISCV_ISA_EXT_ID_MAX
> >  };
> >  static_assert(RISCV_ISA_EXT_ID_MAX <= RISCV_ISA_EXT_MAX);
> > diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> > index 1b9a5a66e55a..a215ec929160 100644
> > --- a/arch/riscv/kernel/cpu.c
> > +++ b/arch/riscv/kernel/cpu.c
> > @@ -162,6 +162,8 @@ arch_initcall(riscv_cpuinfo_init);
> >   *    extensions by an underscore.
> >   */
> >  static struct riscv_isa_ext_data isa_ext_arr[] = {
> > +     __RISCV_ISA_EXT_DATA(smaia, RISCV_ISA_EXT_SMAIA),
> > +     __RISCV_ISA_EXT_DATA(ssaia, RISCV_ISA_EXT_SSAIA),
>
> This will conflict with that ISA string refactoring I just merged.  It
> should be a pretty mechanical merge conflict, but if you want we can do
> a shared tag with the first few patches and I can handle the merge
> conflict locally.

I am planning to send this series as a second PR for Linux-6.3 after your
PR (which includes ISA string refactoring) is merged. Is that okay with you?

With that said, it would request you to ACK this patch as well.

>
> >       __RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
> >       __RISCV_ISA_EXT_DATA(sstc, RISCV_ISA_EXT_SSTC),
> >       __RISCV_ISA_EXT_DATA(svinval, RISCV_ISA_EXT_SVINVAL),
> > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> > index 93e45560af30..3c5b51f519d5 100644
> > --- a/arch/riscv/kernel/cpufeature.c
> > +++ b/arch/riscv/kernel/cpufeature.c
> > @@ -228,6 +228,8 @@ void __init riscv_fill_hwcap(void)
> >                               SET_ISA_EXT_MAP("zihintpause", RISCV_ISA_EXT_ZIHINTPAUSE);
> >                               SET_ISA_EXT_MAP("sstc", RISCV_ISA_EXT_SSTC);
> >                               SET_ISA_EXT_MAP("svinval", RISCV_ISA_EXT_SVINVAL);
> > +                             SET_ISA_EXT_MAP("smaia", RISCV_ISA_EXT_SMAIA);
> > +                             SET_ISA_EXT_MAP("ssaia", RISCV_ISA_EXT_SSAIA);
> >                       }
> >  #undef SET_ISA_EXT_MAP
> >               }

Thanks,
Anup
