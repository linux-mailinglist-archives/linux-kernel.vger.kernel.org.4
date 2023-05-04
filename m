Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13B1D6F64BE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 08:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjEDGKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 02:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbjEDGKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 02:10:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A222D4E
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 23:09:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E37F4612AB
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 06:09:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01CE7C433EF;
        Thu,  4 May 2023 06:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683180580;
        bh=UoN0G7xRgK8l3KWmK6d34C2kwfr+QWMw0vjw1R1S+g8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=WkNmkNHyBdD/lfnYPpRlf/EnuH4fJCQwyJfMktPPjjpKgV58Kq8Dny63w4j1be69C
         Y0/56/ojSQARUHNAK+YeZmq5QtzTuY6nUj0dbjslzaP3bBcHP9Oqm3lFpqjAwz21oj
         ZcJ7ji3L7GFPasea44QUUDWyrz8qGkdGAIRkjWxhFXAwr/vJz5NLnRbjs6h0U8bNpr
         w3uS83M6kpoupg24tFt9sAowm3rIsiT4nznB7QKLjx+I2AmpiYZglpPGRbaT3PI41O
         ZjiRE6u6BotmdwSE4c3YV0tp909MCnd6rSNEnfCiwMZ6Yn26U7sU9f62DmXnPTMVMg
         2mBmisAStMmuw==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     ruanjinjie <ruanjinjie@huawei.com>, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     ruanjinjie@huawei.com
Subject: Re: [PATCH v2] riscv: fix kprobe __user string arg print fault issue
In-Reply-To: <20230423091235.968980-1-ruanjinjie@huawei.com>
References: <20230423091235.968980-1-ruanjinjie@huawei.com>
Date:   Thu, 04 May 2023 08:09:37 +0200
Message-ID: <87cz3g39we.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ruanjinjie <ruanjinjie@huawei.com> writes:

> On riscv qemu platform, when add kprobe event on do_sys_open() to show
> filename string arg, it just print fault as follow:
>
> echo 'p:myprobe do_sys_open dfd=3D$arg1 filename=3D+0($arg2):string flags=
=3D$arg3
> mode=3D$arg4' > kprobe_events
>
> bash-166     [000] ...1.   360.195367: myprobe: (do_sys_open+0x0/0x84)
> dfd=3D0xffffffffffffff9c filename=3D(fault) flags=3D0x8241 mode=3D0x1b6
>
> bash-166     [000] ...1.   360.219369: myprobe: (do_sys_open+0x0/0x84)
> dfd=3D0xffffffffffffff9c filename=3D(fault) flags=3D0x8241 mode=3D0x1b6
>
> bash-191     [000] ...1.   360.378827: myprobe: (do_sys_open+0x0/0x84)
> dfd=3D0xffffffffffffff9c filename=3D(fault) flags=3D0x98800 mode=3D0x0
>
> As riscv do not select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE,
> the +0($arg2) addr is processed as a kernel address though it is a
> userspace address, cause the above filename=3D(fault) print. So select
> ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE to avoid the issue, after that the
> kprobe trace is ok as below:
>
> bash-166     [000] ...1.    96.767641: myprobe: (do_sys_open+0x0/0x84)
> dfd=3D0xffffffffffffff9c filename=3D"/dev/null" flags=3D0x8241 mode=3D0x1=
b6
>
> bash-166     [000] ...1.    96.793751: myprobe: (do_sys_open+0x0/0x84)
> dfd=3D0xffffffffffffff9c filename=3D"/dev/null" flags=3D0x8241 mode=3D0x1=
b6
>
> bash-177     [000] ...1.    96.962354: myprobe: (do_sys_open+0x0/0x84)
> dfd=3D0xffffffffffffff9c filename=3D"/sys/kernel/debug/tracing/events/kpr=
obes/"
> flags=3D0x98800 mode=3D0x0
>
> Signed-off-by: ruanjinjie <ruanjinjie@huawei.com>

Please use your full name.

> ---
> v2:
> - add the config in alphabetical order
> ---
>  arch/riscv/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index eb7f29a412f8..b462ed7d41fe 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -25,6 +25,7 @@ config RISCV
>  	select ARCH_HAS_GIGANTIC_PAGE
>  	select ARCH_HAS_KCOV
>  	select ARCH_HAS_MMIOWB
> +	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE

After adding proper name in SoB, feel free to add:

Acked-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>

>  	select ARCH_HAS_PMEM_API
>  	select ARCH_HAS_PTE_SPECIAL
>  	select ARCH_HAS_SET_DIRECT_MAP if MMU
> --=20
> 2.25.1
