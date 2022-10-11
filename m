Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B69F05FBAF3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 21:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiJKTDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 15:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbiJKTDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 15:03:10 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A7B8A7CC
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 12:02:40 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id k6so13175481vsp.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 12:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NXGJe3FJJ+2iFrQ2DFiSfPDKQZ5eJqWY1ug7Ohd2phA=;
        b=GgvfskVxoI+00fUghW4UvWwn7+YnMWog4YlGHhuxv7ZSX1BRJ2ChLpWlR+iXD0Rakx
         N8M/qdubWVsmhTBewwpWGFTE2H1fM5m14+/TgIoIUeCw15LtEyLICbp8VkySQqUzlIob
         pyocpXbMFvSAoj8QGLPw/tEFHl/gnqa5oDe3CrRsybJB256Cw/VVpI5vZcq2AX8D84zg
         g0SkFQ3SLscdpumiWx+66pDwAC7PrA52mq4kHfdqxqz9Vq4LjyYWSJo3qM49+ojt5T9W
         1okZ/bH55FCU0VR82F1qmJBLUkI5OCxSFt9rh9mfrMfW9iTs+AXnj7CI3kREKlIlXpZa
         LBgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NXGJe3FJJ+2iFrQ2DFiSfPDKQZ5eJqWY1ug7Ohd2phA=;
        b=YbZcD1j800dmOfdWA9ohgNKEgzPb1sW+9KYysYX0OhjQCW2t7Rx/E2dKaun8BIrT1a
         lWBjf80Zqc8xiihHU88fTLKnE+SDeCykW/sZicqLcKtpG//ey1jK0qqcxrsmBEdVeNzM
         i/Xb0cbl5gVTGzoGxETzCYaMNRfeglfYrFgFzb2bIcxAcPHX9H0Ub9m5aZTsxIlj59Rp
         P2gckJakUCF/J4Zgy1apfADSRTZwxzmEZl5Qb9ZLBicG6UvO1exz5nS1Dcyw8YyC4LFf
         6lOa3sRy7dWslfZoDE7R+50uwIzQmfxSeOwAuiuQAX7ChVk3k9NhFcALv3QxNrN4P0qk
         C28g==
X-Gm-Message-State: ACrzQf1e23N0fg+erBwD8/WCaPOvHp1uiBMZ4iRKD9FzIVYwrZBjv0rA
        VMAslVXOpwh7Fne1IUU6nO+L4Pa0KpEHkLtgJtI=
X-Google-Smtp-Source: AMsMyM4+8r1kKYkA8gJ2qE+wnsZVTdDxRgijxT2rla8ok/Y+mo12+zuZAU3+0WqpnHAvir0RYZs2aqzDM5uyoMwBprg=
X-Received: by 2002:a67:e118:0:b0:3a7:6074:dd7e with SMTP id
 d24-20020a67e118000000b003a76074dd7emr8798297vsl.57.1665514958373; Tue, 11
 Oct 2022 12:02:38 -0700 (PDT)
MIME-Version: 1.0
References: <20221011175031.1782748-1-ajones@ventanamicro.com>
 <Y0WvX9Mp0kuohNdq@zn.tnic> <20221011181715.dpayrpjueha7kxoj@kamzik>
In-Reply-To: <20221011181715.dpayrpjueha7kxoj@kamzik>
From:   Yury Norov <yury.norov@gmail.com>
Date:   Tue, 11 Oct 2022 12:02:26 -0700
Message-ID: <CAAH8bW8Gz66aT4bBbxsrM4iYmpx-DDv8j_M48R+WOuSTravSgQ@mail.gmail.com>
Subject: Re: [PATCH] x86: Fix /proc/cpuinfo cpumask warning
To:     Andrew Jones <ajones@ventanamicro.com>
Cc:     Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
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

On Tue, Oct 11, 2022 at 11:17 AM Andrew Jones <ajones@ventanamicro.com> wrote:
>
> On Tue, Oct 11, 2022 at 08:01:03PM +0200, Borislav Petkov wrote:
> > On Tue, Oct 11, 2022 at 07:50:31PM +0200, Andrew Jones wrote:
> > > Upcoming cpumask changes will start issuing warnings[*] when cpu
> >
> > What upcoming changes?
> >
> > This needs a concrete pointer to a commit or so.
>
> Hi Boris,
>
> Sorry, I should have pointed this out. The upcoming change is
>
> linux-next/master commit a314123c8bdb ("cpumask: fix checking valid cpu
> range")
>
> And also an ongoing discussion here
> https://lore.kernel.org/lkml/20221011170949.upxk3tcfcwnkytwm@kamzik/
>
> I'm hoping that Yury will pick these patches up and integrate
> them at the front of his series when introducing the warnings.
> I wasn't sure how to call that out other than with the generic
> "upcoming change".
>
> >
> > > indices equal to nr_cpu_ids are passed to cpumask_next* functions.
> >
> > How do those indices get passed here? I think you need to explain how
> > exactly this happens.

The cpumask_check() fix is already in master. Because of some mess in
cpumask, cpumask_check() was broken for quite a long time, and didn't
bark when passed with an out-of-range CPU.

I fixed some false-positives and sent those fixes together with a314123c8bdb.
Now, I expect that people will see warnings generated by correct
cpumask_check().
This is actually the first sign.

Andrew, can you please answer Borislav's question:

> > How do those indices get passed here? I think you need to explain how
> > exactly this happens.

It might be either an expected behaviour, and then there should be a great
explanation on how and why things work in the subsystem.

Or it might be an error in the caller. In that case, the caller must be fixed.

Thanks,
Yury
