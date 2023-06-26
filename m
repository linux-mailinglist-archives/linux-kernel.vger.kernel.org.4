Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24DC473EB42
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 21:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjFZTtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 15:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjFZTtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 15:49:22 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81AFA1727
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 12:49:20 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4f954d78bf8so5199890e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 12:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1687808959; x=1690400959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6YM/3jytDSw5aCGEFIsFzQqRvaDLcL3uFF5ne8/Vpng=;
        b=rMvt5DOa+d5Ev5t6uxa2w3H7fN1E2vJqXHCzpIonlVWY9h+igGLjmlZap8F+vkqtfQ
         79RaVl6dSRLrmiu06nwDUzUSon2uM3LeanriiR/CYMO7edw3M6BvR09M46AovO3JXaL7
         OFtOfbEyiNBrVuVv5xg5uo8kii5Nywg04nYGSciIqIf4MW6D9LuAszTbpu1RLonGsO0C
         OF4MgCAqHnfcuC5jhTXDosFecrA8UB2gxJ9dfWHn6KFckVjjTyoOqdegIjAUzb2tc2RT
         YAdVdwIFZQsNtTbOrkrCAP+xl06QBopBxyhgNtPQaqOXhD2EUxKVJAzR4Pwx2/G5Oem5
         E2Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687808959; x=1690400959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6YM/3jytDSw5aCGEFIsFzQqRvaDLcL3uFF5ne8/Vpng=;
        b=X5HwCUKR8exSJl/HiXlKhVtDimFXkpmA7UhXjJ+boYpELLUc9MBPvDtkwm/SFxiiZj
         Ux8uPOYNkB8oqva6RZiOs8ZsqLLt07hDB/if9V1GzV5NqAmvAQtRx0UrBRUUz3rRimxd
         9dkrpD0ozaSYZqIKz3MfWtQ3kVXKJLGDZiCqfnuF50ywgPo7W0lCnSQ1LN+y23XCS28s
         Pa6U6wEDJdy8DAKXLTh5z8bFt4sGXyDRs6kgykZH4KEX5eOwfw0WUsnzVeEQ7fjtkMSs
         hoXpaxricZapxbWvlBRk5ltb0fHZ90uKEc1352YHKYRjBl2jtAI4Vq6w/UrZ8inysdgM
         hlbw==
X-Gm-Message-State: AC+VfDzq50z5iSzXJkKwD2y7CT8nHXgEudFebHBiMntYjYF4BPlY72Sa
        bWAe1KGLcsjWIMxphDNiVWh3NszmoTMPMgebJSUYoQ==
X-Google-Smtp-Source: ACHHUZ6avkdLR+FgKz1qS04UPjaf9BSA07AhepW4v7HvSFw74n2Fsq9w2aB6inJFNBV5gr+Rt0Rv48bZvLGzKw/tTEk=
X-Received: by 2002:a05:6512:3b8e:b0:4fb:744e:17db with SMTP id
 g14-20020a0565123b8e00b004fb744e17dbmr3081195lfv.1.1687808958688; Mon, 26 Jun
 2023 12:49:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230623222016.3742145-1-evan@rivosinc.com> <tencent_817CE182DEDA938E03B848314821098D4408@qq.com>
In-Reply-To: <tencent_817CE182DEDA938E03B848314821098D4408@qq.com>
From:   Evan Green <evan@rivosinc.com>
Date:   Mon, 26 Jun 2023 12:48:42 -0700
Message-ID: <CALs-Hsv+iS055GUJdotYxmn5ST9y9yT7P1PiG4DLPU+rzPO20A@mail.gmail.com>
Subject: Re: [PATCH 0/2] RISC-V: Probe for misaligned access speed
To:     Yangyu Chen <cyy@cyyself.name>
Cc:     ajones@ventanamicro.com, alexghiti@rivosinc.com,
        andy.chiu@sifive.com, aou@eecs.berkeley.edu,
        apatel@ventanamicro.com, conor.dooley@microchip.com,
        corbet@lwn.net, greentime.hu@sifive.com, guoren@kernel.org,
        heiko.stuebner@vrull.eu, heiko@sntech.de,
        jeeheng.sia@starfivetech.com, jszhang@kernel.org,
        leyfoon.tan@starfivetech.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        lizhengyu3@huawei.com, masahiroy@kernel.org, palmer@dabbelt.com,
        palmer@rivosinc.com, paul.walmsley@sifive.com,
        rdunlap@infradead.org, samuel@sholland.org, shosie@rivosinc.com,
        sunilvl@ventanamicro.com, xianting.tian@linux.alibaba.com
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

On Sat, Jun 24, 2023 at 3:22=E2=80=AFAM Yangyu Chen <cyy@cyyself.name> wrot=
e:
>
> Hi,
>
> Thanks for doing this.
>
> On 6/24/23 6:20 AM, Evan Green wrote:
> > I don't have a machine where misaligned accesses are slow, but I'd be
> > interested to see the results of booting this series if someone did.
>
> I have tested your patches on a 100MHz BigCore rocket-chip with opensbi r=
unning on FPGA with 72bit(64bit+ECC) DDR3 1600MHz memory. As the rocket-chi=
p did not support misaligned memory access, every misaligned memory access =
will trap and emulated by SBI.
>
> Here is the result:
>
> ~ # cat /proc/cpuinfo
> processor       : 0
> hart            : 0
> isa             : rv64imafdc
> mmu             : sv39
> uarch           : sifive,rocket0
> mvendorid       : 0x0
> marchid         : 0x1
> mimpid          : 0x20181004
>
> processor       : 1
> hart            : 1
> isa             : rv64imafdc
> mmu             : sv39
> uarch           : sifive,rocket0
> mvendorid       : 0x0
> marchid         : 0x1
> mimpid          : 0x20181004
>
> ~ # dmesg | grep Unaligned
> [    0.210140] cpu1: Unaligned word copy 0 MB/s, byte copy 38 MB/s, misal=
igned accesses are slow
> [    0.410715] cpu0: Unaligned word copy 0 MB/s, byte copy 35 MB/s, misal=
igned accesses are slow

Thank you, Yangyu! Oof, the firmware traps are quite slow!
-Evan
