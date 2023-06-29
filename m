Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 294CF7430E2
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 01:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbjF2XK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 19:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjF2XK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 19:10:26 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC2E30C4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 16:10:24 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f766777605so2001625e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 16:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1688080223; x=1690672223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s1fWEnH0sdbyAOEH6UFoh83BPgBAF+lwm2DoFeYlQSk=;
        b=5bGVU2MaUkUfhQDs6c1WAjUyAqUmx30DMW/hAm9jx0x8uDUV1zUNCKaqUSH4hzt1p0
         rN9gCnNRsDgItfj7rs7/aHQvp7m4nT3p7bIJ3YvHwpGpGDJgBpbxcGjYtu1jFbRICPHc
         DV2R0fEicsDIJfQrBL57qdl+3uJ9u7DjebiqGSIl5PZLhEr3LujO6QE63N+pQh9NqVXo
         SnZNLpyLIa423MT1NbXgQ9jR/v4dttdQJKnh53vAaJKGR7Id07yFaS7pM8hmZzvkB9Mx
         zeV3mQxGziBYMqETfztiSTfF8Cyr3dDasRAtzR4atBINHRLBuTh50y6dIVT7pXOH9SSM
         yg/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688080223; x=1690672223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s1fWEnH0sdbyAOEH6UFoh83BPgBAF+lwm2DoFeYlQSk=;
        b=SAfYMrdb6X4MyONoyDs3xyZGi+FopMRVvnyJ+UlYT0QHx0SIjla4LoM+t8WjimL75v
         ilO7ugs5Aa9XpEKpXQigO9ESOTjj3+3w7wFkGKHgbHVePtiFFp0VrALUjXBTTQE5ru4Q
         xfjO7z+PWeyGlI9C2U6xbdU2GneHAUZxwmr9jo0OsIF1PtVqKtMjy70ej81mdUG0bxTE
         fPHF1NOaoBvHZcZGppbp1BhapMqin9gE/Oibr9mMhaQH6y8+y7EZ3MnPwstTCFx+WTLy
         H7+LmLtHG5DjGiOdeU1eAOPhqudaAscpZrspZI5dcxPBWp+EOTK3zU1yqnjmiL7lamQl
         L7bw==
X-Gm-Message-State: ABy/qLYXOIrw6MaL/m8M95LBkYiIx6eUVJEejl0lsEQLxy4lSVdY4m7e
        I7Y0hwT4BLRsp0tzAS8a9yPQq1swFpadLIeHGG1fbA==
X-Google-Smtp-Source: APBJJlGPLoLbN3j/MYaWDb+BS3m3rP3at/zt6fvbleRSvozMEhN8Jx0lax5nME4zrea3unZFbnd7KR+3GW/NDralX8c=
X-Received: by 2002:a05:6512:314b:b0:4fb:92a9:cbe8 with SMTP id
 s11-20020a056512314b00b004fb92a9cbe8mr845289lfi.18.1688080222801; Thu, 29 Jun
 2023 16:10:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230623222016.3742145-1-evan@rivosinc.com> <20230623222016.3742145-2-evan@rivosinc.com>
 <64F2D853-61E5-49CF-BAB5-AAFB8697683E@jrtc27.com> <CALs-HssZG8daTJaRK8JPT0VRk=23CtO6B_5kq4Xa_DdLELjaZw@mail.gmail.com>
 <53dc6959cc8849d6b66676ad48c1376a@AcuMS.aculab.com>
In-Reply-To: <53dc6959cc8849d6b66676ad48c1376a@AcuMS.aculab.com>
From:   Evan Green <evan@rivosinc.com>
Date:   Thu, 29 Jun 2023 16:09:46 -0700
Message-ID: <CALs-HstgcnK=prSHm9D7bqWc05q52ObA5kozmxzr-euR=CFfKw@mail.gmail.com>
Subject: Re: [PATCH 1/2] RISC-V: Probe for unaligned access speed
To:     David Laight <David.Laight@aculab.com>
Cc:     Jessica Clarke <jrtc27@jrtc27.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Yangyu Chen <cyy@cyyself.name>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Xianting Tian <xianting.tian@linux.alibaba.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Simon Hosie <shosie@rivosinc.com>,
        Li Zhengyu <lizhengyu3@huawei.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Ley Foon Tan <leyfoon.tan@starfivetech.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Anup Patel <apatel@ventanamicro.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sia Jee Heng <jeeheng.sia@starfivetech.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Andy Chiu <andy.chiu@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2023 at 5:05=E2=80=AFAM David Laight <David.Laight@aculab.c=
om> wrote:
>
> From: Evan Green
> > Sent: 27 June 2023 20:12
> >
> > On Mon, Jun 26, 2023 at 2:42=E2=80=AFPM Jessica Clarke <jrtc27@jrtc27.c=
om> wrote:
> > >
> > > On 23 Jun 2023, at 23:20, Evan Green <evan@rivosinc.com> wrote:
> > > >
> > > > Rather than deferring misaligned access speed determinations to a v=
endor
> > > > function, let's probe them and find out how fast they are. If we
> > > > determine that a misaligned word access is faster than N byte acces=
ses,
> > > > mark the hardware's misaligned access as "fast".
> > >
> > > How sure are you that your measurements can be extrapolated and aren=
=E2=80=99t
> > > an artefact of the testing process? For example, off the top of my he=
ad:
> > >
> > > * The first run will potentially be penalised by data cache misses,
> > >   untrained prefetchers, TLB misses, branch predictors, etc. compared
> > >   with later runs. You have one warmup, but who knows how many
> > >   iterations it will take to converge?
> >
> > I'd expect the cache penalties to be reasonably covered by a single
> > warmup. You're right about branch prediction, which is why I tried to
> > use a large-ish buffer size, minimize the ratio of conditionals to
> > loads/stores, and do the test for a decent number of iterations (on my
> > THead, about 1800 and 400 for words and bytes).
> >
> > When I ran the test a handful of times, I did see variation on the
> > order of ~5%. But the comparison of the two numbers doesn't seem to be
> > anywhere near that margin (THead C906 was ~4x faster doing misaligned
> > word accesses, others with slow misaligned accesses also reporting
> > numbers not anywhere close to each other).
>
> Isn't the EMULATED case so much slower than anything else that
> it is even pretty obvious from a single access?
> (Possibly the 2nd access to avoid 'cold cache'.)
>
> One of the things that can perturb measurements is hardware
> interrupts. That can be mitigated by counting clocks for a few
> (10 is plenty) iterations of a short request and taking the
> fastest value.
> For short hot-cache code sequences you can actually compare the
> actual clock counts with theoretical minimum values.

Yeah, one thing I could do is disable interrupts, measure the cycle
count of doing an individual iteration, do this N times, and take the
minimum value as the time to compare. In the end I'll then have two
numbers to compare, like I do in this patch. In theory the variance on
that should be really tight. N will have to depend on the overall
amount of time I'm taking so as not to shut interrupts off for very
long. Let me experiment with this and see how the results look.
-Evan
