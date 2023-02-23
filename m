Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0FB96A0BD5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 15:25:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234617AbjBWOY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 09:24:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234771AbjBWOYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 09:24:50 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3256E51F87
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 06:24:47 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id a65so1130600qkg.13
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 06:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lS02SECNsTsSICkh2N4Q1yNXKnOepHfYrYQXorOwyTc=;
        b=l47r7gKZWo17ELTFBKSDnl4UL1aPpwX48egkQ5iv9fd7gU1+KYTV/qLbq1HpRXJ1LA
         4+24lFDlBwsHuQHEJQ/xOHjyvmGnq1K48HmsnGkwGReXKXQfDc8HuaDRMin/xz49Oz74
         UrfdYbXpRunGetKy8QcBgmNfoiSXSi4+iPIHFosVLliohTHZLaooZw8yRpKOCI6n1sNS
         al0D4N2shcbn7qJYckk5TV3EvNBXl1HquFcXUC8Yf5TpLPipk5xXF3gUo9xlSOwpy1tb
         6EbyW+3+LhJRobC9aKhf6/QSOF3X2oxX2SkEv051yZJsKuxSiZOtbIpbrrsKjYDJ4Crl
         vxfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lS02SECNsTsSICkh2N4Q1yNXKnOepHfYrYQXorOwyTc=;
        b=O7N3gdJjVkMGcxgNOihLPpD5Lmv7oaEjJqTA1qdLzDUW8FatPY1UaJc8Ox1H+fes47
         mx4fo5YCpkPydJlyG1/ITALubsLa4VGu/MYtaHFMQZ3Omipr/lkvyL33RG7Mf0+w4VBY
         cfVs3xvqBRS0xIYJNhhlQe6TukEouM1drayb5Xi3h6U5Sv5p02vCkIqQK3DScksJMC/i
         knQp8mzq2hSQTb8Y/oLcmUJ0bO6XBehUWsXc98kZv2sY+IGkkZ19f58HR8ZaWatO3RKK
         ClUVPZurKsrYpVtxJnrLOwvidCCR8KfvgGWp84rkCfLI9/kF1KQoNlJ9WMlZJL5fnUNQ
         33Xw==
X-Gm-Message-State: AO0yUKXKGDzglx+1GnVp9woftEdOM9djimbsCkxxQ+SslNbhm9x15JSw
        nTxS3Y2rEA//9thQu/JZsk8B1BU3g2qoqtgwXA==
X-Google-Smtp-Source: AK7set9UOZ6B88hyD9biWoBHnQUGbtIgWqp/hXoIK+QG4jRV5lY7E9wDL+//EyYIwze+YUcOcARfoovIpNGHsLsq7IM=
X-Received: by 2002:a05:620a:831a:b0:742:3e52:f855 with SMTP id
 pa26-20020a05620a831a00b007423e52f855mr873076qkn.2.1677162286321; Thu, 23 Feb
 2023 06:24:46 -0800 (PST)
MIME-Version: 1.0
References: <20230222221301.245890-1-brgerst@gmail.com> <5bc62f30a439345eaf58231bafe621b28c62d85e.camel@infradead.org>
In-Reply-To: <5bc62f30a439345eaf58231bafe621b28c62d85e.camel@infradead.org>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Thu, 23 Feb 2023 09:24:33 -0500
Message-ID: <CAMzpN2j7-GV4ONG7P-R6fZ3P+ZYu9CRzZYFbO+OswX+XZwV4nA@mail.gmail.com>
Subject: Re: [PATCH 0/6] x86-64: Remove global variables from boot
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Usama Arif <usama.arif@bytedance.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023 at 8:44 AM David Woodhouse <dwmw2@infradead.org> wrote:
>
> On Wed, 2023-02-22 at 17:12 -0500, Brian Gerst wrote:
> > This is on top of the parallel boot v10 series.
> >
> > Remove the global variables initial_gs, initial_stack, and
> > early_gdt_descr from the 64-bit boot code.  The stack, GDT, and GSBASE
> > can be determined from the CPU number.
> >
> > Brian Gerst (6):
> >   x86/smpboot: Use CPU number instead of APIC ID for single CPU startup
> >   x86/smpboot: Use current_task to get idle thread
>
>
> I think those first two should be folded into the 'x86/smpboot: Support
> parallel startup of secondary CPUs' patch rather than follow-on
> patches?

Yes, that makes sense.

> >   x86/smpboot: Remove initial_stack on 64-bit
> >   x86/smpbppt: Remove early_gdt_descr on 64-bit
> >   x86/smpboot: Remove initial_gs
> >   x86/smpboot: Simplify boot CPU setup
>
> Those four probably make sense to come separately. For each of them,
>
> Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
>
> I've pulled in the v10 series from Usama, squashed the first two as I
> suggested, added the last four on top to do some testing:
> https://git.infradead.org/users/dwmw2/linux.git/shortlog/refs/heads/parallel-6.2-rc8-part1

Looks good.  I noticed a typo in the commit log of the last patch
(dynammically -> dynamically).  Can you fix that or should I resend?

Thanks

--
Brian Gerst
