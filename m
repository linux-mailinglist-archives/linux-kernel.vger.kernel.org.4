Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5CF0696E1C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 20:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232638AbjBNTs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 14:48:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbjBNTsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 14:48:54 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911B028D01;
        Tue, 14 Feb 2023 11:48:53 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id 7so11009827pga.1;
        Tue, 14 Feb 2023 11:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3KPvoJ4GnlMgsohhv5ZFTkjPNgvE0397TI0CYAnCxqM=;
        b=Gr6T/uMmQW0P2TPA5kU2B0SezfYIPng0GmMu1nbsnL7n4Qhw9RF68MIXO9T2lIb4Vd
         9XqzWMo3zWupmo7DDnQIRZvSJhGTc3cJrOSj6qnw7ZLFMuv1jhehz7SDmTyxss5IvAuF
         ITBMuNHAK1NOe9nMNVZ11QjpI/ucBxZuVeSuDtnc42j7aN5Y3/LFY0jJey9dm6rJdUJ4
         LHKBtyEUPuxrQMMdOfkgTlii7etUm1Jsa4u0tgyMoqTav4keZsI205xjLS15k/6dNP48
         pxdBRqWKGSlZs5JtldCGgNcu4SmZfcR6VtsRIgsyLA6/xT3/Y75dtU4bMody4IfGBQxC
         Gv8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3KPvoJ4GnlMgsohhv5ZFTkjPNgvE0397TI0CYAnCxqM=;
        b=S59/0XiQ9Q7a2qfz76/WosSowlQasTqAPPAVPx4gusSdFHCncEY3tl+sISYljLHNr8
         HUF0wvNq/kqfiQECsdQKVW8YFYb1imknpKwg0DymGZ1huod0i2fIdanGm0W6lsBFC4cz
         uMK2icWt1a1ttu7cJxHdN0cUSnJyhVzaryr0PLeaLAg8WlIErURQegWy1F1GhGndQi56
         UfMtc8kMl7RfWHdBAg05pkbdjB1GLhfBqEK/1+CpMPovSls/0xY1iDPaekcs4uVnlf64
         7d5ceNtU625XDrJWqIG5XV4zP8zIf4z8nj+fE3v4K4kfkXED0JxbxsbBUYtpyPYcCPuD
         6Q5w==
X-Gm-Message-State: AO0yUKX/oF//gQsOMA9yoq4flR9Rc8RPfP7Tj4qBfAY8kD9lfR+PwLTw
        cAZJd/FR1+bshshHtX8bgZw4q4gyAWSCVUKifS0=
X-Google-Smtp-Source: AK7set/RjysGRw6Tb1OUrwUKy/GM2o6xSEOZ9Hy3VBjfC8/RJ69CUMocJn0vWTmElSm33m/BGVWvbyqYG1s66BcSQYs=
X-Received: by 2002:aa7:9591:0:b0:5a8:65e5:b1ba with SMTP id
 z17-20020aa79591000000b005a865e5b1bamr740284pfj.29.1676404133096; Tue, 14 Feb
 2023 11:48:53 -0800 (PST)
MIME-Version: 1.0
References: <cover.1676358308.git.jpoimboe@kernel.org> <cca346b5c87693499e630291d78fb0bf12c24290.1676358308.git.jpoimboe@kernel.org>
 <1b4afd82-83cb-0060-7cab-8e16d2e69ff9@linaro.org> <20230214182322.r5tyeowxzloiuh72@treble>
In-Reply-To: <20230214182322.r5tyeowxzloiuh72@treble>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Tue, 14 Feb 2023 11:48:41 -0800
Message-ID: <CAMo8BfLzV0Oe_i-QrMzE-BE028s6GNvOd827N5+tteELidjpvA@mail.gmail.com>
Subject: Re: [PATCH v2 19/24] xtensa/cpu: Make sure cpu_die() doesn't return
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>,
        linux-kernel@vger.kernel.org, jgross@suse.com,
        richard.henderson@linaro.org, ink@jurassic.park.msu.ru,
        mattst88@gmail.com, linux-alpha@vger.kernel.org,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, will@kernel.org, guoren@kernel.org,
        linux-csky@vger.kernel.org, linux-ia64@vger.kernel.org,
        chenhuacai@kernel.org, kernel@xen0n.name,
        loongarch@lists.linux.dev, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, tsbogend@alpha.franken.de,
        linux-mips@vger.kernel.org, jiaxun.yang@flygoat.com,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        linuxppc-dev@lists.ozlabs.org, ysato@users.sourceforge.jp,
        dalias@libc.org, linux-sh@vger.kernel.org, davem@davemloft.net,
        sparclinux@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, chris@zankel.net, linux-xtensa@linux-xtensa.org,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, paulmck@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 10:23 AM Josh Poimboeuf <jpoimboe@kernel.org> wrote=
:
> On Tue, Feb 14, 2023 at 08:55:32AM +0100, Philippe Mathieu-Daud=C3=A9 wro=
te:
> > Can you update the documentation along? Currently we have:
> >
> >   /*
> >    * Called from the idle thread for the CPU which has been shutdown.
> >    *
> >    * Note that we disable IRQs here, but do not re-enable them
> >    * before returning to the caller. This is also the behaviour
> >    * of the other hotplug-cpu capable cores, so presumably coming
> >    * out of idle fixes this.
> >    */
>
> void __ref cpu_die(void)
> {
>         idle_task_exit();
>         local_irq_disable();
>         __asm__ __volatile__(
>                         "       movi    a2, cpu_restart\n"
>                         "       jx      a2\n");
>
>         BUG();
> }
>
> Hm, not only is the comment wrong, but it seems to be branching to
> cpu_restart?  That doesn't seem right at all.

Perhaps the name is a bit misleading. The CPU that enters 'cpu_restart'
loops there until a call to 'boot_secondary' releases it, after which it go=
es
to '_startup'. So it is a restart, but not immediate.

--=20
Thanks.
-- Max
