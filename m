Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41B60627840
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 09:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236607AbiKNI5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 03:57:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236615AbiKNI45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 03:56:57 -0500
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960291ADBE
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 00:56:56 -0800 (PST)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-12c8312131fso11808363fac.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 00:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9DzXrgXEb9Q6lBK/xYH4J2+9GgGboeSXFoTt7ybDG+Q=;
        b=nRoOU8N7Hcbw2Brfjn2EfoZcp5HttVWcqVX2WOa5NoSRIhd8RChOrhysb6EnjAVRtG
         SAM3+yN6q0jge1Vndkh5JLOvT6l7CII500Il1cnI5N6k3BAdDJYMGBqqI5j40DwbFpPZ
         zgu1NnPU3EQ5jaP5vBpoRLiwmu63GmqiWD8sY+XJ/gUsAROEjkLIAcrl0wlKRdAxJVLZ
         vyYcCtxKkapzy8BgPbfrVSXYZuQ/YJIkzuyuQEdqhqMgoR9EsqpCgTZbTpUKoexnaqce
         ZMqP/YPLzFT8NXZWD4Dy5uH2jGJqt/R6azhKR3tTIKPPMUQ3GHloRRQGYPMpPSgidqxX
         t/Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9DzXrgXEb9Q6lBK/xYH4J2+9GgGboeSXFoTt7ybDG+Q=;
        b=SgcBMyIeT6xBYtXkQ6G/cOll7WL/qXUsUERzzyJuy2dFyGFxTkus+uRL1q4btm8bhs
         Oq938ffdPeCJGNDaUyqdS/FLuLwXhJJuBwaGypxC8tYhCmzYBDgBGOW55PnJuF3JB5OP
         r2iLUk6Hg0lb0D6L6m0vKjSY4x7VQ0QBNS5BIAWH9v0frOhSfuoxMLMN/TKp0VUbpuZZ
         FdzusEcdwoHPH60IfWqJW3Y7KT4aemPEMjRdXOWanCA9GGQ1AxH6CFsC58GiqT9xZWZo
         JgIPZkXMJAuY6K8tHQS+gaJK5m8CarBxmHZ9WlwpmplufxNGkjWktztjj1toMmeR3OAB
         RfDA==
X-Gm-Message-State: ANoB5pn1l8e7vs7Hl7IRoXW7pdcM0VBjkA77FDnnYeQ4gC57p/aN6fQ2
        6MSfiAxzhcouBcoaSL4/ETTWL5H2WuiK08g/JUJkNT9XsKu5dQ==
X-Google-Smtp-Source: AA0mqf7d3HkDvDfpTBEJOXnIzbMky1ezkJ33YX3pnh2HvIw3FS7ilUZVh5hyuqFk96D7of7TC1QJz6HHUUSAMp3BFBo=
X-Received: by 2002:a05:6870:56a6:b0:132:a767:a2ba with SMTP id
 p38-20020a05687056a600b00132a767a2bamr6249198oao.271.1668416215094; Mon, 14
 Nov 2022 00:56:55 -0800 (PST)
MIME-Version: 1.0
References: <20220903161309.32848-4-apatel@ventanamicro.com> <20220904080601.2405-1-hdanton@sina.com>
In-Reply-To: <20220904080601.2405-1-hdanton@sina.com>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Mon, 14 Nov 2022 14:26:44 +0530
Message-ID: <CAK9=C2XJdEP=h4dQFKOSBcZMMH-OZRGyWy_B333UYbFMDGMoGQ@mail.gmail.com>
Subject: Re: [PATCH v9 3/7] genirq: Add mechanism to multiplex a single HW IPI
To:     Hillf Danton <hdanton@sina.com>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 4, 2022 at 1:36 PM Hillf Danton <hdanton@sina.com> wrote:
>
> On 3 Sep 2022 21:43:05 +0530 Anup Patel <apatel@ventanamicro.com> wrote:
> >
> > +static void ipi_mux_send_mask(struct irq_data *d, const struct cpumask *mask)
> > +{
> > +     u32 ipi_bit = BIT(irqd_to_hwirq(d));
> > +     struct cpumask pmask = { 0 };
> > +     unsigned long pending;
> > +     int cpu;
> > +
> > +     for_each_cpu(cpu, mask) {
> > +             pending = atomic_fetch_or_release(ipi_bit,
> > +                                     per_cpu_ptr(&ipi_mux_bits, cpu));
> > +
> > +             /*
> > +              * The atomic_fetch_or_release() above must complete before
> > +              * the atomic_read() below to avoid racing ipi_mux_unmask().
> > +              */
> > +             smp_mb__after_atomic();
> > +
> > +             if (!(pending & ipi_bit) &&
> > +                 (atomic_read(per_cpu_ptr(&ipi_mux_enable, cpu)) & ipi_bit))
> > +                     cpumask_set_cpu(cpu, &pmask);
> > +     }
> > +
> > +     /* Trigger the parent IPI */
> > +     ipi_mux_ops->ipi_mux_send(ipi_mux_parent_virq, ipi_mux_data, &pmask);
> > +}
>
> Can you shed some light on the reasons why a pending TLB ipi for flushing
> page3 on CPU2 prevents TLB ipi from being sent to CPU2 for flushing page9.

The "!(pending & ipi_bit)" check in the above "if ()" statement seems to be
causing this. I am seeing CPU soft-lockup due to the  "!(pending & ipi_bit)"
check on a QEMU RISC-V virt machine with large CPUs.

I will quickly send v11 with the check removed.

Thanks,
Anup
