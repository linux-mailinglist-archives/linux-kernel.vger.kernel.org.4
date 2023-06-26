Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8768773EB4D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 21:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjFZTtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 15:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjFZTtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 15:49:07 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E95DC
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 12:49:06 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4fb7dc16ff0so513717e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 12:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1687808944; x=1690400944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4BJ+wat2wj/FnZRmm9Ds0OCDYXwTdmsZ2vAXsvIEv6U=;
        b=n0Q+moQbFISX0SC6k/G5s8/ci5S1Sj+UYHAD6iQKUaLZP1GMO83KbjQ3DjRehRLoUj
         IkV0wvY1xHoraSzsJUskqyZpfHKm1D6Qo8jhywerpW3c577K10ubhqhUZ6qKIZ1lhR0W
         vrigxZts8U3ovG1p4Z0sW40eVpTQJvPANzK/zJ4OPd0iFsyw/vC+wURFobP48ZHxyTd1
         y8A7zE6TGGw9SSTmUsvPoJyjpZRehXWOLEwwK3IZMUP8BPBkTKNRVM4jKNAwJZrPHwzs
         fVHpBdxpGeWsq1iXWOGxqQO+51hTOlYLIZwc4OKDr/QhMSjDvsMvmyH3arnkq8NUc9tk
         Jeow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687808944; x=1690400944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4BJ+wat2wj/FnZRmm9Ds0OCDYXwTdmsZ2vAXsvIEv6U=;
        b=OmBfGUwqBVujBiOvDp+Le93R0duz2CZONrs6TB7C21hoTpOCmbTNqP7xL9JZQplbVE
         9EHgYMiENNcDAlGOhUqiHh4SMg2vKuBHw1qK0BGGBukEbI0tVMMO8HA4ZY/vSP7jp9CD
         j8gK30z27GWnk5cKiWvjfYYT9rs64v+nQRzeISJuvcJaFwLWmgWbfT1IBRqxpbnfCVh8
         Bkjc2p6gfuKkAfpIQUyxbrM7GKECGDNavvhJsbU3PAtTnEH4D81p6+NvmdBfs1Hjryqi
         m8MSqw+dBEVoZrg7AYTl5txhtTabaZXIE7+Is16TtXJjbU+QWfrpWyqbKHXFifv54RlL
         G64g==
X-Gm-Message-State: AC+VfDyBOR2+z/hZnveLhoPC410/hHjEAP7GBGPHg3vu03y9FSUOk5aE
        Utxkk3RNbLAopSbiDDFMm6+rABuN7LxtZ3T3WyieNQ==
X-Google-Smtp-Source: ACHHUZ404+xgRifh929v2n1RFqqXcNondC2qUQ/hTMZBuj3neqo1V3zfBES+zkOVMWcqFo/TKvK3zNi3kLbTTQ04Pbw=
X-Received: by 2002:ac2:4bd0:0:b0:4fb:b11:c9a1 with SMTP id
 o16-20020ac24bd0000000b004fb0b11c9a1mr3143535lfq.40.1687808943797; Mon, 26
 Jun 2023 12:49:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230623222016.3742145-1-evan@rivosinc.com> <20230624-tycoon-pliable-325806e73a11@spud>
In-Reply-To: <20230624-tycoon-pliable-325806e73a11@spud>
From:   Evan Green <evan@rivosinc.com>
Date:   Mon, 26 Jun 2023 12:48:27 -0700
Message-ID: <CALs-Hsv0r0sWFM4_uqz+WQvrOc8bLcDb35suyrJ46sQ6jh7jTw@mail.gmail.com>
Subject: Re: [PATCH 0/2] RISC-V: Probe for misaligned access speed
To:     Conor Dooley <conor@kernel.org>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        Simon Hosie <shosie@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Andy Chiu <andy.chiu@sifive.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Guo Ren <guoren@kernel.org>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Heiko Stuebner <heiko@sntech.de>,
        Jisheng Zhang <jszhang@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Ley Foon Tan <leyfoon.tan@starfivetech.com>,
        Li Zhengyu <lizhengyu3@huawei.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Samuel Holland <samuel@sholland.org>,
        Sia Jee Heng <jeeheng.sia@starfivetech.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Xianting Tian <xianting.tian@linux.alibaba.com>,
        Yangyu Chen <cyy@cyyself.name>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
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

On Sat, Jun 24, 2023 at 3:08=E2=80=AFAM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Fri, Jun 23, 2023 at 03:20:14PM -0700, Evan Green wrote:
> >
> > The current setting for the hwprobe bit indicating misaligned access
> > speed is controlled by a vendor-specific feature probe function. This i=
s
> > essentially a per-SoC table we have to maintain on behalf of each vendo=
r
> > going forward. Let's convert that instead to something we detect at
> > runtime.
> >
> > We have two assembly routines at the heart of our probe: one that
> > does a bunch of word-sized accesses (without aligning its input buffer)=
,
> > and the other that does byte accesses. If we can move a larger number o=
f
> > bytes using misaligned word accesses than we can with the same amount o=
f
> > time doing byte accesses, then we can declare misaligned accesses as
> > "fast".
> >
> > The tradeoff of reducing this maintenance burden is boot time. We spend
> > 4-6 jiffies per core doing this measurement (0-2 on jiffie edge
> > alignment, and 4 on measurement). The timing loop was based on
> > raid6_choose_gen(), which uses (16+1)*N jiffies (where N is the number
> > of algorithms). On my THead C906, I found measurements to be stable
> > across several reboots, and looked like this:
> >
> > [    0.047582] cpu0: Unaligned word copy 1728 MB/s, byte copy 402 MB/s,=
 misaligned accesses are fast
> >
> > I don't have a machine where misaligned accesses are slow, but I'd be
> > interested to see the results of booting this series if someone did.
>
> Can you elaborate on "results" please? Otherwise,
>
> [    0.333110] smp: Bringing up secondary CPUs ...
> [    0.370794] cpu1: Unaligned word copy 2 MB/s, byte copy 231 MB/s, misa=
ligned accesses are slow
> [    0.411368] cpu2: Unaligned word copy 2 MB/s, byte copy 231 MB/s, misa=
ligned accesses are slow
> [    0.451947] cpu3: Unaligned word copy 2 MB/s, byte copy 231 MB/s, misa=
ligned accesses are slow
> [    0.462628] smp: Brought up 1 node, 4 CPUs
>
> [    0.631464] cpu0: Unaligned word copy 2 MB/s, byte copy 229 MB/s, misa=
ligned accesses are slow
>
> btw, why the mixed usage of "unaligned" and misaligned"?

Yes, this is exactly what I was hoping for in terms of results, thank
you. I'll clean up the diction and choose one word. I think my brain
attributed subtle differences between unaligned (as in, without regard
for alignment, the behavior of the copies) and misaligned (ie.
deliberately out of alignment, the type of access we're testing), but
I'm not sure I'm even fully consistent to those, so I'll fix it.

-Evan

>
> Cheers,
> Conor.
