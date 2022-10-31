Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFEA46131B0
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 09:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiJaI2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 04:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiJaI2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 04:28:13 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0596644A
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 01:28:02 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id f205so12890956yba.2
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 01:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V8hiaX3qzM77jDPn/tc4Lj/66Z56ccEa25AnRYdm1OM=;
        b=VZMm+e0TNUmZrn1v7yt1bdkyybRRhs5NJoX8ziQRiHQHdBev3jNpXEfCqQzAH7wJqh
         zW+h9clIz4rjx8AUGkYFb+b8ieEbLidYLXriPQkUkEWycE/lJaNqdz/w+pSIM0jcqCIe
         yf/dhlrLcjihdgcUpYgmifpbKdOZVjbJ6KRdO5HDThOeGNAbSPC2EBAVbF0byeL/IMct
         GRqDsSQnPT/nJaq95Q1BoinUPAMKh0G9BAGM6kqpl7Gjzqf85tf58N6VDi+cXHyULmuE
         7ZFVBb7SV4rXwciUGikNK34i0dkvA+EqafjvbJTErbnH5obk0T/L+145oCAj5agqREgS
         SY+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V8hiaX3qzM77jDPn/tc4Lj/66Z56ccEa25AnRYdm1OM=;
        b=bbafCQhp51Uu7enSmo1blFQQvD/jM/HqL75CiaaEqd2ATgp2uOZL9+cyu58heuUOQ+
         q9lkMbr7ibFO+mjwWfXGet5rmE2FNl53NkAY+1da7JVv6YVMF6W1Zkz/rUPHmq9MTELd
         KLZIseWeIXxKZ1h5T2eERDWHzROBTKh9PwfF/mt2f969TtQKWbyeFklOfBvby1J5kEQn
         Uyfrwns8OxszXQwH0BwuIDKA4HqAiPyV9p4tK6Ji8QfHoHZqWEqYEjoN0GBkcF0ZVCvk
         eLV67W/0JaBU+nGK2VOW9cFTvLuys7CRwS+DhPh1nmhXv5lqEv6hs0AeFy/XJYD7FlOm
         Qh0A==
X-Gm-Message-State: ACrzQf3DuRYxcGsyN0aIgzq0X0Qdqh7yGp5DAvdV3PeGIkhG3nj6d08r
        4BJsIIeHRd1AshlGUDc5hEcQi6HC5fVrXMNCgCSAV4r6AR4=
X-Google-Smtp-Source: AMsMyM6oRp4zLCXIi2/Z1Kc03cjZlwKVHggj8xzvByxGrQtOhr6VbY6cMZ/UI3klJbqt39SyldBiIhCLoAIi6i+sA+c=
X-Received: by 2002:a25:a088:0:b0:6ca:33ff:5b30 with SMTP id
 y8-20020a25a088000000b006ca33ff5b30mr11810505ybh.242.1667204881935; Mon, 31
 Oct 2022 01:28:01 -0700 (PDT)
MIME-Version: 1.0
References: <202210310123.aklkcZzK-lkp@intel.com>
In-Reply-To: <202210310123.aklkcZzK-lkp@intel.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 31 Oct 2022 09:27:25 +0100
Message-ID: <CAG_fn=VqT+ORnMwR=YCsp6SxOMESqL9-O_t8G-5BdsNNBe13Mg@mail.gmail.com>
Subject: Re: arch/powerpc/kexec/crash.c:311:22: error: variable 'i' might be
 clobbered by 'longjmp' or 'vfork'
To:     kernel test robot <lkp@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks unrelated to this 2-year old commit?

On Sun, Oct 30, 2022 at 6:12 PM kernel test robot <lkp@intel.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t master
> head:   882ad2a2a8ffa1defecdf907052f04da2737dc46
> commit: f0fe00d4972a8cd4b98cc2c29758615e4d51cdfe security: allow using Cl=
ang's zero initialization for stack variables
> date:   2 years, 4 months ago
> config: powerpc-wii_defconfig
> compiler: powerpc-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=3D1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbi=
n/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.=
git/commit/?id=3Df0fe00d4972a8cd4b98cc2c29758615e4d51cdfe
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/=
git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout f0fe00d4972a8cd4b98cc2c29758615e4d51cdfe
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-12.1.0 make.cro=
ss W=3D1 O=3Dbuild_dir ARCH=3Dpowerpc SHELL=3D/bin/bash arch/powerpc/
>
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    arch/powerpc/kexec/crash.c: In function 'default_machine_crash_shutdow=
n':
> >> arch/powerpc/kexec/crash.c:311:22: error: variable 'i' might be clobbe=
red by 'longjmp' or 'vfork' [-Werror=3Dclobbered]
>      311 |         unsigned int i;
>          |                      ^
>    cc1: all warnings being treated as errors
>
>
> vim +311 arch/powerpc/kexec/crash.c
>
> 496b010e1e70a9 arch/powerpc/kernel/crash.c Michael Neuling  2008-01-18  3=
08
> cc53291521701f arch/powerpc/kernel/crash.c Michael Ellerman 2005-12-04  3=
09  void default_machine_crash_shutdown(struct pt_regs *regs)
> cc53291521701f arch/powerpc/kernel/crash.c Michael Ellerman 2005-12-04  3=
10  {
> 496b010e1e70a9 arch/powerpc/kernel/crash.c Michael Neuling  2008-01-18 @3=
11     unsigned int i;
>
> :::::: The code at line 311 was first introduced by commit
> :::::: 496b010e1e70a9b4286fa34f19523f24a194f119 [POWERPC] kdump shutdown =
hook support
>
> :::::: TO: Michael Neuling <mikey@neuling.org>
> :::::: CC: Paul Mackerras <paulus@samba.org>
>
> --
> 0-DAY CI Kernel Test Service
> https://01.org/lkp



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
