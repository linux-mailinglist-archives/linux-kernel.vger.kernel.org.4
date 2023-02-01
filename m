Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E13FA683695
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 20:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbjAaTad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 14:30:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjAaTab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 14:30:31 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7149A5246
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 11:30:30 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id 144so10965308pfv.11
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 11:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zandUZ3Tm0aytQS9nqqC5N+P1l58rEETrB4mxTtLnOg=;
        b=cVZMyZYdkHzjMPyz+29zB2zEmrJM84cjJoeaeCqB+JgSq+zKDMdK8QqkJd2cUryUJM
         X16U/bhqKBGBSJsWDXti/gzHOXpJzPSPcmeaD+DypVg0W5TdyI9ExImsvfGSzC869s9w
         OtCoZbSiMjTxS6dMuNs2RKw6BfxfQR2H9Z66M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zandUZ3Tm0aytQS9nqqC5N+P1l58rEETrB4mxTtLnOg=;
        b=hxVse+2XCn0fDzEuixPGdHhaVae5ZPPYZ8pIWzncONjatHC6gqoHkoIRTyvrWinSwZ
         OCDV1UgKYOR5viWWZ2mYAWqFv83Ld83RPVbaIym7BC7E0ExnhQN0GcNREyKlM9FajBqq
         ZaSACjpSbkO1/h+idZzJllfB/h/9klYihsrCHFfUuN17MGR6nwcA0rEgw4zWx6/aTgYZ
         Nx0eTIFLX2NuUPIm8F+tIAaM8gys85SU7fOy7RvnpdaZnbWeYjXkX7ki3QKl+HaFkEB1
         3jk2MscrARrnVAEifQfiUjzJsDlOlIeMKGPCqoHRId90jRq/rQAIJISAkNMcC7a2C0aM
         5zZw==
X-Gm-Message-State: AO0yUKUmIDoqbolpWM/Nvjb+7aEE/mn6H64r/wi0ZpgAH+3lAK+vjCU5
        dAIeVIhIL1k9zWFIMR0o3VMrTUOZBDI0Wov7/EmW
X-Google-Smtp-Source: AK7set83+A1QVYBNJ0oFxqG/QiC6KVG/mhilmiaXhkowEyp3VLWnnexRuwKDtvunnjkAKS6W2LFaiJMWMkh5dpQIfhI=
X-Received: by 2002:aa7:99dd:0:b0:593:1253:2ff5 with SMTP id
 v29-20020aa799dd000000b0059312532ff5mr2536050pfi.14.1675193429885; Tue, 31
 Jan 2023 11:30:29 -0800 (PST)
MIME-Version: 1.0
References: <20230127182558.2416400-1-atishp@rivosinc.com> <20230127182558.2416400-4-atishp@rivosinc.com>
 <Y9RV0cOMld20EFBI@spud>
In-Reply-To: <Y9RV0cOMld20EFBI@spud>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Tue, 31 Jan 2023 11:30:18 -0800
Message-ID: <CAOnJCU+16EEe0OrNY3ZW_FS591+KmG5ap1OTjOL+gtqGtr7nLw@mail.gmail.com>
Subject: Re: [PATCH v3 03/14] RISC-V: Improve SBI PMU extension related definitions
To:     Conor Dooley <conor@kernel.org>
Cc:     Atish Patra <atishp@rivosinc.com>, linux-kernel@vger.kernel.org,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <anup@brainfault.org>, Guo Ren <guoren@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sergey Matyukevich <sergey.matyukevich@syntacore.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 2:53 PM Conor Dooley <conor@kernel.org> wrote:
>
> Yo Atish,
>
> On Fri, Jan 27, 2023 at 10:25:47AM -0800, Atish Patra wrote:
> > This patch fixes/improve few minor things in SBI PMU extension
> > definition.
> >
> > 1. Align all the firmware event names.
>
> > @@ -171,7 +171,7 @@ enum sbi_pmu_fw_generic_events_t {
> >       SBI_PMU_FW_IPI_RECVD            = 7,
> > -     SBI_PMU_FW_FENCE_I_RECVD        = 9,
> > +     SBI_PMU_FW_FENCE_I_RCVD         = 9,
> >       SBI_PMU_FW_SFENCE_VMA_RCVD      = 11,
>
> Alignment looks incomplete to me! Looks like you went from 2 RECVD and
> 1 RCVD to 2 RCVD and 1 RECVD! FWIW, the spec uses RECEIVED for all of

Ahh I missed the other one. I have changed everything to RCVD just to
keep it short.
"RECEIVED" is too long :)


> these:
> https://github.com/riscv-non-isa/riscv-sbi-doc/blob/master/riscv-sbi.adoc#114-event-firmware-events-type-15
>
> Thanks,
> Conor.
>


-- 
Regards,
Atish
