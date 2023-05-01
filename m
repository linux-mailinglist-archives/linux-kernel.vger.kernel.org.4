Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA8E46F32DA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 17:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232590AbjEAP1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 11:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjEAP1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 11:27:01 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC5119AD
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 08:26:57 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2a8ba693f69so26815561fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 08:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1682954816; x=1685546816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UYm1A2Y9JCZwWJY3qxKMfyKzI+6vl440LsSxrmBj2go=;
        b=yEOlzIaV3aJknjdM72WirigOWww4r/fv/w+yhsRsPTr3tk3IR/qB7P5VekNU4eJVXr
         KA7uz4riPYIztbxYiKtrKzIER4ofXty03AvxT2uKXDBqEs/EWMYaz9wcbm7HSauumT2V
         bEJTupRfO0L+lpquWNzXwLW4kyBu4RqGA/H14KE3GVbmtGLL+qiABAjUeXo/fZGFrd9A
         XqKmaOGnaOY9u1oLvDQBQfwgWcYqb3R9iQGEZhZ9laWq52NaKKGcqTXJlCX9bDIl1hL4
         Jt+cyeVNBz1fYyLBFKnLoRg6nr7qdhf1A/FIiqjVlwxGV7hdIdPP7BvBmmt7TWacnYO/
         I8Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682954816; x=1685546816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UYm1A2Y9JCZwWJY3qxKMfyKzI+6vl440LsSxrmBj2go=;
        b=T59Nli7z13VHMRsCZv1cMSuN6KipoMUdZ6kndGRB7Bh/qSwTw6JQsIGcO6phe/Ud7g
         uiRTCYhFKNeTndJ6AxM5LX32zRBfLibr7zPESswOIqdG1JQDhoJQRQeLZOznkjt/gWv9
         XNZta/9mNq7X/rezN/hzdqCdYXEdpeJFjJPZj1huahtuiY9QK6nP3mps0YClLAHYlvM9
         fLxUlIINcLVA6JgEyWKuqAJSoGXcBAdjtmbuSuRziyI1Ap8LGVwZB1aZhnYqWDlsNSBw
         k+oq2HuQ+vaPAldI5IL5WHx0Iy1NygW9TVybGEavckeozmn9vxFKTK9pDBkD8Wy952mZ
         BXlw==
X-Gm-Message-State: AC+VfDy7jn3CJAnlMjbQi2k5zAIaRjHDUgKjgiCcY+yF3coIXDzQLvrI
        1N6IpgNX2q/zi7hsgFj8+38mnSOi8te4KraDoezbiA==
X-Google-Smtp-Source: ACHHUZ5SrpQirrYAcF9qgnVJKaaaAQzxukyNkmKEArX8qm1p+W3TbEIE4ryk2UMkaDjJlid7gyr/resqZTPXwf9lyHc=
X-Received: by 2002:a2e:3e13:0:b0:299:bdc7:8ff2 with SMTP id
 l19-20020a2e3e13000000b00299bdc78ff2mr3727827lja.39.1682954815912; Mon, 01
 May 2023 08:26:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230429155247.12131-1-rdunlap@infradead.org> <CALs-HsuG3EFBs60sgiMcPHoE1dF7mhi3GKt=AWvRPaUHAfA88Q@mail.gmail.com>
 <20230429-outboard-hypocrite-983e977103d2@spud> <CALs-HstrR3Cm3jQKt6dmfYiRRVkAVibAZDtFo0wmXz4LEvRf_A@mail.gmail.com>
 <37e6b325-44e4-8e65-68e3-eab2943018ac@infradead.org> <CALs-Hss3b86zAqohK9NYEkzn+pnLeMB37qaj1EA6f6bRkFWwCg@mail.gmail.com>
 <20230429-dandy-gush-6f5da93055bc@spud>
In-Reply-To: <20230429-dandy-gush-6f5da93055bc@spud>
From:   Evan Green <evan@rivosinc.com>
Date:   Mon, 1 May 2023 08:26:19 -0700
Message-ID: <CALs-HsuP1moOdZQG_Ur3J3cQ1J+j9Zr-tiSgAkvmCsOXaca9ag@mail.gmail.com>
Subject: Re: [PATCH v2] RISC-V: fix sifive and thead section mismatches in errata
To:     Conor Dooley <conor@kernel.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
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

On Sat, Apr 29, 2023 at 12:11=E2=80=AFPM Conor Dooley <conor@kernel.org> wr=
ote:
>
> On Sat, Apr 29, 2023 at 12:06:19PM -0700, Evan Green wrote:
> > On Sat, Apr 29, 2023 at 10:58=E2=80=AFAM Randy Dunlap <rdunlap@infradea=
d.org> wrote:
> > >
> > >
> > >
> > > On 4/29/23 10:48, Evan Green wrote:
> > > > On Sat, Apr 29, 2023 at 10:24=E2=80=AFAM Conor Dooley <conor@kernel=
.org> wrote:
> > > >>
> > > >> On Sat, Apr 29, 2023 at 10:21:39AM -0700, Evan Green wrote:
> > > >>> On Sat, Apr 29, 2023 at 8:52=E2=80=AFAM Randy Dunlap <rdunlap@inf=
radead.org> wrote:
> > > >>>>
> > > >>>> When CONFIG_MODULES is set, __init_or_module becomes <empty>, bu=
t when
> > > >>>> CONFIG_MODULES is not set, __init_or_module becomes __init.
> > > >>>> In the latter case, it causes section mismatch warnings:
> > > >>>>
> > > >>>> WARNING: modpost: vmlinux.o: section mismatch in reference: risc=
v_fill_cpu_mfr_info (section: .text) -> sifive_errata_patch_func (section: =
.init.text)
> > > >>>> WARNING: modpost: vmlinux.o: section mismatch in reference: risc=
v_fill_cpu_mfr_info (section: .text) -> thead_errata_patch_func (section: .=
init.text)
> > > >>>>
> > > >>>> Fixes: bb3f89487fd9 ("RISC-V: hwprobe: Remove __init on probe_ve=
ndor_features()")
> > > >>>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> > > >>>> Cc: Heiko Stuebner <heiko@sntech.de>
> > > >>>> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> > > >>>> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> > > >>>> Cc: Albert Ou <aou@eecs.berkeley.edu>
> > > >>>> Cc: linux-riscv@lists.infradead.org
> > > >>>> Cc: Conor Dooley <conor@kernel.org>
> > > >>>> Cc: Evan Green <evan@rivosinc.com>
> > > >>>> ---
> > > >>>
> > > >>> Thanks, Randy. I'm confused at how I didn't see that when I made =
the
> > > >>> original fix. I feel like repro of these section mismatch errors
> > > >>> depend on some other factor I'm not understanding. In any case:
> > > >>
> > > >> Perhaps you had a cut-down config that did not enable either of th=
e
> > > >> relevant ARCH_ options to get those errata compiled?
> > > >
> > > > It was weird, my original "fix" (the one listed in this Fixes tag) =
was
> > > > needed because while the hwprobe series was clean on Palmer's branc=
h,
> > > > it generated a "section mismatch" on linux-next. As noted here, it =
was
> > > > only with !CONFIG_MODULES, so I explicitly remember generating that
> > > > config and checking it on linux-next to generate this "fix", and it
> > > > came out clean. It's like the robots are getting smarter.
> > > > -Evan
> > >
> > > I observed the problem in 8 out of 20 randconfig builds,
> > > using linux-next 20230427.
> >
> > Oh interesting, so not the stock k210_nommu defconfig. That makes me
> > feel a little better at least.
>
> Ohh man, that's a pretty bad config to try use (if that's your default)
> for build testing stuff. The k210_mmu defconfig doesn't enable anything
> other than SOC_CANAAN.
> I could reproduce Randy's issue on defconfig w/ CONFIG_MODULES disabled.

That's the one that caught me before, so I remembered it as being
"different". I'll try what you describe above next time I'm hunting
for section mismatches.
-Evan
