Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F3074CDE5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 09:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbjGJHFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 03:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231714AbjGJHFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 03:05:09 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA3B130
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 00:05:06 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-314417861b9so4116039f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 00:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1688972705; x=1691564705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mFvL3tlkpDhpLI9w7XrEtJqw/lbmRTQDmsFPeVlaTJE=;
        b=B+OAWea8safjLliid5fb8P1XEOByAWmJtrdPeO8vVt0BsfB3sAQ/HEWF0pq51BZPP/
         9u6eXAkqEVbhocmUjbg2FiO7/4ydZdcFxw2s8OQrvJmOxT7ymv/XvTaj8BCcYMrkJSpe
         QPDT9DIoeFUUY6bTwyxFsdUzKFFiTcEOCfa+mrSxkonkUTXuBPf6Xn1fiZm8FyQTZPi6
         l8VqvMGpytp9+RGRmBHRwUHr1wjESiWVsJvoWcG8fr0+Gt/ezkG3pD+6ZPE0GcnGRTFj
         5f78Id5wtOSSXzbr8qM/drdbmelMDLqumNxOArrLO+/XVHuNqxzyEXY3sEfNRj3OMOrm
         XMYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688972705; x=1691564705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mFvL3tlkpDhpLI9w7XrEtJqw/lbmRTQDmsFPeVlaTJE=;
        b=JzLIuDa1o6d6WBNG8PYzinYDzReBVzVYBjl+0Oh0yxNCgH/OMyOroJJ8+dc2/aQ3ud
         kzbY2WTslUjNRZCC9m0Lfm9wneV/so9nKKsXQCcE2tS15/VzlMHUoxdXOaLtgw442pR8
         kRE7bbWUd7itHRzPlCUlwAxeGDTfbu3J7IDagVDJgJfxKkhVh7DvWvZLxtiKJQCDN9Qn
         0MMPsls2NI5zIIo2nzHiv7E1xx6bZoyTMyTnmGO4xf7JXCYp361fvDL1SjUbdR5XmTdZ
         P+1Fr4od8K/nJbokPzXty0MVImD3irHq7raci6pk25BXgRzQxateSmnvqj1XohDhD6F2
         sXpQ==
X-Gm-Message-State: ABy/qLbpiTr3VmpZZgzISTlfWf3bH3v7nUnSARyNrJPPPCq3ub1AybMh
        vicqEckutPPW6MFzH703tQ/I6pAoywHP2U8k8hqCBA==
X-Google-Smtp-Source: APBJJlE3NFpHmzslV9vKFkDNQrbvhe42+Doh1LqIf2mh+PVW47q644xaDCXNbv5LQWJCaCVpTz2Lne60UkJ44T2N8sA=
X-Received: by 2002:adf:fe01:0:b0:314:23b:dc56 with SMTP id
 n1-20020adffe01000000b00314023bdc56mr8033189wrr.71.1688972704715; Mon, 10 Jul
 2023 00:05:04 -0700 (PDT)
MIME-Version: 1.0
References: <202307100638.uoomUZol-lkp@intel.com>
In-Reply-To: <202307100638.uoomUZol-lkp@intel.com>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Mon, 10 Jul 2023 09:04:52 +0200
Message-ID: <CAHVXubg2BUeM72rG5xLZFRQQ+eGfS3An0zeY7ueiH4nwFOeGcA@mail.gmail.com>
Subject: Re: ld.lld: error: section .bss load address range overlaps with .init.pi.text
To:     kernel test robot <lkp@intel.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 12:23=E2=80=AFAM kernel test robot <lkp@intel.com> =
wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t master
> head:   06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
> commit: 3b90b09af5be42491a8a74a549318cfa265b3029 riscv: Fix orphan sectio=
n warnings caused by kernel/pi
> date:   9 weeks ago
> config: riscv-randconfig-r022-20230710 (https://download.01.org/0day-ci/a=
rchive/20230710/202307100638.uoomUZol-lkp@intel.com/config)
> compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git =
4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
> reproduce: (https://download.01.org/0day-ci/archive/20230710/202307100638=
.uoomUZol-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202307100638.uoomUZol-lkp=
@intel.com/
>
> All errors (new ones prefixed by >>):
>
> >> ld.lld: error: section .bss load address range overlaps with .init.pi.=
text
>    >>> .bss range is [0xDD5000, 0x1EC438F]
>    >>> .init.pi.text range is [0x1DBC350, 0x1DBF39B]
> --
> >> ld.lld: error: section .rodata load address range overlaps with .init.=
pi.bss
>    >>> .rodata range is [0x1DBF400, 0x2888177]
>    >>> .init.pi.bss range is [0x1EC4390, 0x1EC478F]
>

XIP_KERNEL=3Dy so nothing to do here.

Thanks,

Alex

> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
