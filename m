Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12BFB73EB45
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 21:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjFZTtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 15:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjFZTtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 15:49:52 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9364D1727
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 12:49:48 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f004cc54f4so4905003e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 12:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1687808987; x=1690400987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q/lpdCNdLKPRzw0ijMjHRl02NQSZei/pxPOLUCjqo3k=;
        b=QWtcTiIiPKl9H826wqtI3mIN4HxJs5POVfqyPr8eOWBkYaECIMhruW4xZpQ2kul+He
         n/gCx6cO+uMID5tG0EtDJCHMB/kLRMNKw6jBXFWVMQQi++j8jIdbkbVaObPVE7Xhc2uK
         7a171PPpGfLRIdDucT2W2U/UrhC5+eoqzPwsO1ePOOtk0KbuCLu62qviXnKdvsJbhB+i
         rd99P9xRNYKiAttFIY/WdEL728VonCU7YVOVsBf/I6iZ3OUEZxwlZ64vN8rND0zh+2g6
         QkINBVVlEgwd4ucW66DnvKq+jQQhjzIkJg7rUKGMsnxIztQ20VyRlnBON+yWuvaa5GEQ
         U9bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687808987; x=1690400987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q/lpdCNdLKPRzw0ijMjHRl02NQSZei/pxPOLUCjqo3k=;
        b=cFCHtuEERcp594plpNLnCrPxuc/AnId3pKuWQRIxDmMvc/W5ScKPQyBeWnRfbQqkLW
         qkYCn6zwulDFc+7f2ePaAUkQ/xhyBxTQuTuSQ6dPYAi7zfdxEbVbdg8YgL6codZDS3VB
         0LCwTgljtkldPsoe9sOISIll7eu+xRLbnHMDI2ZBPiUuQz2Qqe+YWtQzAYl+tUe9ku3V
         /RktR9GdbJ+f0AOeDdy+3ycKUGCEV/pOJ2ar0sWalmh40Kk+fUr9fILjNF53SFiRUjYr
         nJbFav8VlIk+SjAVgOeSPTWvvBVI8vhkCzSbVOz6nvHUm6uQzpf9mdrO5idVFY2LHhZU
         OchA==
X-Gm-Message-State: AC+VfDyehm2fosFoObRPWEqecEauVtRht36epxug1rENNhn7IvzGtHsb
        sIieA4hO4eLmsdW5z9VoH/qaNNW69PA40tGGCt2FSw==
X-Google-Smtp-Source: ACHHUZ5vtNENlMXy3eoIP2B/IYY0UdAclSBCeu4efpGL+RVbDwQeQxviyfF4cQHVw1pp1j8K6+p+YOGDD+E/mwTCOFk=
X-Received: by 2002:a19:5018:0:b0:4f8:b349:7737 with SMTP id
 e24-20020a195018000000b004f8b3497737mr13173121lfb.36.1687808986946; Mon, 26
 Jun 2023 12:49:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230623222016.3742145-1-evan@rivosinc.com> <tencent_817CE182DEDA938E03B848314821098D4408@qq.com>
 <253bad9e83cd4890b29dd89a3d5a1937@AcuMS.aculab.com>
In-Reply-To: <253bad9e83cd4890b29dd89a3d5a1937@AcuMS.aculab.com>
From:   Evan Green <evan@rivosinc.com>
Date:   Mon, 26 Jun 2023 12:49:10 -0700
Message-ID: <CALs-Hsu681qusmGn+aWarnTXQ=e20C52jSZU-q-hWihP+7ud7Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] RISC-V: Probe for misaligned access speed
To:     David Laight <David.Laight@aculab.com>
Cc:     Yangyu Chen <cyy@cyyself.name>,
        "ajones@ventanamicro.com" <ajones@ventanamicro.com>,
        "alexghiti@rivosinc.com" <alexghiti@rivosinc.com>,
        "andy.chiu@sifive.com" <andy.chiu@sifive.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "apatel@ventanamicro.com" <apatel@ventanamicro.com>,
        "conor.dooley@microchip.com" <conor.dooley@microchip.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "greentime.hu@sifive.com" <greentime.hu@sifive.com>,
        "guoren@kernel.org" <guoren@kernel.org>,
        "heiko.stuebner@vrull.eu" <heiko.stuebner@vrull.eu>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "jeeheng.sia@starfivetech.com" <jeeheng.sia@starfivetech.com>,
        "jszhang@kernel.org" <jszhang@kernel.org>,
        "leyfoon.tan@starfivetech.com" <leyfoon.tan@starfivetech.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "lizhengyu3@huawei.com" <lizhengyu3@huawei.com>,
        "masahiroy@kernel.org" <masahiroy@kernel.org>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "palmer@rivosinc.com" <palmer@rivosinc.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "samuel@sholland.org" <samuel@sholland.org>,
        "shosie@rivosinc.com" <shosie@rivosinc.com>,
        "sunilvl@ventanamicro.com" <sunilvl@ventanamicro.com>,
        "xianting.tian@linux.alibaba.com" <xianting.tian@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 2:24=E2=80=AFAM David Laight <David.Laight@aculab.c=
om> wrote:
>
> From: Yangyu Chen
> > Sent: 24 June 2023 11:22
> >
> > Hi,
> >
> > Thanks for doing this.
> >
> > On 6/24/23 6:20 AM, Evan Green wrote:
> > > I don't have a machine where misaligned accesses are slow, but I'd be
> > > interested to see the results of booting this series if someone did.
> >
> > I have tested your patches on a 100MHz BigCore rocket-chip with opensbi=
 running on FPGA with
> > 72bit(64bit+ECC) DDR3 1600MHz memory. As the rocket-chip did not suppor=
t misaligned memory access,
> > every misaligned memory access will trap and emulated by SBI.
> >
> > Here is the result:
> ...
> > ~ # dmesg | grep Unaligned
> > [    0.210140] cpu1: Unaligned word copy 0 MB/s, byte copy 38 MB/s, mis=
aligned accesses are slow
> > [    0.410715] cpu0: Unaligned word copy 0 MB/s, byte copy 35 MB/s, mis=
aligned accesses are slow
>
> How many misaligned cycles are in the test loop?
> If emulated ones are that slow you pretty much only need to test one.

The code does as many cycles as it can in a fixed number of jiffies.

>
> Also it is pretty clear that you really don't want to be emulating them.
> If the emulation is hidden from the kernel that really doesn't help at al=
l.

From what I understand there's work being done to give the kernel some
awareness and even control over the misaligned access
trapping/emulation. It won't help today's systems though, and either
way you're right emulating is very very slow.
-Evan
