Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6EF6A1500
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 03:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjBXCii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 21:38:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjBXCih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 21:38:37 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA2631E2E
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 18:38:33 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id d7so7165524pfu.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 18:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JRecAKZcY6IbQwyurCrABIbVaiA2PzBDQV3Z+P3MRuI=;
        b=CNs/JVqajIYC7MgPC9Va/OivfBI1AxWe1NN6i0WgWVrP3aM2ojjh1GNTlvPQaE4sUC
         rbFzdkj1hFdKLdtFkngfOFnh22XWCC6dPlb3l7/bVYcnWsoPsAYHR367jep2wHUi5Q0m
         FXzYJTsE1HdASYCoYJEr398Ubr9lnkPyAEpjs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JRecAKZcY6IbQwyurCrABIbVaiA2PzBDQV3Z+P3MRuI=;
        b=GSHf+5scCLfcKaWmnL+rVvfHl9YzKOtjF7A35CSP6jwXK3J0sp+5anyDDG003DYTK2
         NVKyGJiKfyY3TxHsTD8ojlCE9ioAVpG058cCoGKXQXlr8+SMrgkcVdWcgldGSC2g+Li+
         PFuAWVtmVRSulnacxSHAe4oJK/bFSLm0VL36VaOSr0q3SAEna0+Kl0qUvfQGyVD/HY3i
         IT6fbCWpnxAh/aFUrGn8dwwA6Z1xvwZIX7qlAPBqB/PaULsMTW0mlaWL99szY1fHLtE+
         TbiEmSQywpQzBzCbd+jU/LIYp/oOAEqio64qwDxK0DNFs2YUUqKQTR84JUYUrV33NOJT
         QLdg==
X-Gm-Message-State: AO0yUKVA27On7J/TOOQ2tZ5nm9fa+Llf6I8l/cBgHyzeNJzSpBcwZmmr
        hnYapWVYjGQlaimQAAEhPzGjRg7NcOYuOBHGU4iZ
X-Google-Smtp-Source: AK7set/Pl4bgDi8YBHtTidAXSP+H3vDftz5DSWh0Vofi7bk5M4UMW7IhUght0gW5AAjqkid9OtVoW7Q3yNNWVKSGijI=
X-Received: by 2002:a62:8704:0:b0:5a8:9872:2b9b with SMTP id
 i4-20020a628704000000b005a898722b9bmr2481602pfe.1.1677206312565; Thu, 23 Feb
 2023 18:38:32 -0800 (PST)
MIME-Version: 1.0
References: <CAOnJCUKHq_8msJtU-H1JvWJ8nY94J0tcarQMBsPNpBZO8sP6HQ@mail.gmail.com>
 <CAK9=C2Uy_0B6D2TGq35sfrGkp9s1Td=cEsidzDPTDhG7Nq5EWw@mail.gmail.com>
In-Reply-To: <CAK9=C2Uy_0B6D2TGq35sfrGkp9s1Td=cEsidzDPTDhG7Nq5EWw@mail.gmail.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Thu, 23 Feb 2023 18:38:21 -0800
Message-ID: <CAOnJCU+EdF3sCpcNoOiPOCNwwX7bguJghqZccY=cUmku+Ak0=A@mail.gmail.com>
Subject: Re: Perf event to counter mapping question
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     linux-perf-users@vger.kernel.org,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Beeman Strong <beeman@rivosinc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2023 at 6:55 PM Anup Patel <apatel@ventanamicro.com> wrote:
>
> On Thu, Feb 23, 2023 at 5:58 AM Atish Patra <atishp@atishpatra.org> wrote:
> >
> > Hi All,
> > We are trying to figure out what is the best approach to define the
> > perf event to programmable counter mappings in RISC-V.
> > Until recently, all the programmable counter/event selector registers
> > were writable in M-mode (highest privilege mode) only. The firmware
> > residing in M-mode
> > would discover the mapping from device tree[1] and the perf driver
> > relies on SBI PMU[2] interface to discover the mapping between event &
> > counters.
> >
> > There are new ISA extensions being proposed to make counters /event
> > selector register in supervisor mode as well. Thus, a pmu driver
> > can directly program the event selectors without relying on firmware.
> > However, the kernel needs to be aware of counter mapping to do that.
> >
> > AFAIK, ARM64 allows all-to-all mapping in pmuv3[1]. That makes life
> > much easier. It just needs to pick the next available counter.
> > On the other hand, x86 allows selective counter mapping which is
> > discovered from the json file and maintained in per event
> > constraints[4].
> > There may be some legacy reasons why it was done in x86 this way[5].
> > Please correct me if I am wrong in my understanding/assumption.
> >
> > Here are a few approaches that can be used to solve it in RISC-V.
> >
> > 1. Continue to use device tree bindings
> > Cons: We have to define similar entries for ACPI. It makes
> > virtualization difficult as the VMM has to discover and update the
> > device tree/ACPI as well.
> >
> > 2. Mandate all-to-all mapping similar to ARM64.
> > Note: This is only for programmable counters. If the platform supports
> > any fixed counters (i.e. can monitor
> > only a specific event), that needs to be provisioned via some other
> > method. IIRC the fixed counters(apart from cycle) in ARM64 are part of
> > AMU not PMU.
> >
> > 3. All platforms need to define which subset of events can be
> > monitored using a subset of counters. The platform specific perf json
> > file can specify that.
> > This approach provides more flexibility but makes the code path a bit
> > more complex as the counter mask constraint needs to be maintained per
> > event basis.
> >
> > 4. Any other approach ?
>
> I suggest a 4th approach where by default the kernel assumes all-to-all
> mappings and optionally perf json file can be used to override mappings
> for certain counters. This approach is more like a hybrid approach between

Do you mean override counter mapping for certain events ? I don't
think we should split counter space as platforms may want
to choose random encounters between hpmcounter3-hpmcounte31.

We can always do this. If the counter mask is not set in the event
attributes, assume that the event
can be monitored by all the counters. x86 does something similar as well.

> approach #2 and #3. It work fine with KVM RISC-V as well because Guest/VM
> will assume all-to-all mapping for logical HW counters whereas Host can have
> specific counter mappings.
>
> >
> > Any thoughts on what would be the best approach for RISC-V. It would
> > be great to repeat any past mistakes in RISC-V by learning from
> > experience from the community.
> >
> > [1] https://lore.kernel.org/lkml/Y6tS959TaY2EBAdn@spud/T/
> > [2] https://github.com/riscv-non-isa/riscv-sbi-doc/blob/master/riscv-sbi.adoc#function-find-and-configure-a-matching-counter-fid-2
> > [3] https://elixir.bootlin.com/linux/v6.2/source/arch/arm64/kernel/perf_event.c#L899
> > [4] https://elixir.bootlin.com/linux/latest/source/arch/x86/events/core.c#L876
> > [5] https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1978937.html
> > --
> > Regards,
> > Atish
>
> Regards,
> Anup



-- 
Regards,
Atish
