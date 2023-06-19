Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACD9A734B19
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 06:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjFSE2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 00:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjFSE2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 00:28:07 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C2B1BB;
        Sun, 18 Jun 2023 21:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1687148863; x=1687753663; i=deller@gmx.de;
 bh=cgufvUEgcntUumfnkvWsXTVY4o9BX5y3Q1d3nNiorMc=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=LSI+CVQnaUd6ZMiX61A8dHxL5FB33EKK2GfA8HS/KbhLK/gAFDgOGYBQTIc7UA0YxZlgc11
 Wm2tEkM7QMjReqt934JW1mqCbztCGIRi1x7tg0Sdth0/z7xNmWMnz8L7ZIPyATtzjKkEoWNCP
 fBFdWPt9qUeokkdcFxNR1orDek2op/PmIQEcYknBJG0v6dTYwpaSLzspj871C8X2NHNlJKe2x
 U/aF8CjiInrPwgYJUJSmH4U4nMaqaXQ3+3foc+pfVzMKCyF6bbJZypa6vGubrPDK3FnEYXwEO
 5evbNYgm7wAX4gyEArY4q6R7yBFLwwoYjIczqnAdEy8naOmr87lQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.148.114]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MGhuU-1qNlvQ3mle-00Dmh3; Mon, 19
 Jun 2023 06:27:42 +0200
Message-ID: <79b816e7-c331-49f9-058c-02828623ad94@gmx.de>
Date:   Mon, 19 Jun 2023 06:27:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v9 01/42] mm: Rename arch pte_mkwrite()'s to
 pte_mkwrite_novma()
Content-Language: en-US
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Cc:     linux-parisc@vger.kernel.org
References: <20230613001108.3040476-1-rick.p.edgecombe@intel.com>
 <20230613001108.3040476-2-rick.p.edgecombe@intel.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20230613001108.3040476-2-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Q4zXblBLpzKCBDT98aM0erTlf7ZwLbfecz+itWO0Q3U5Wlf6TrI
 FcpI/+BbHkZce/5Ses91ny7YSY73bZDZTrjyS9KwKY35E7HWRKEKrJN0ODlKfZ0AoBUCdS9
 QsC43PkiXmy8XiMEkg+kjQ1s6kal0zdoC7RubFk8KJDh4Pd/u0H8lpdhLMhGlVwotqpykq6
 7d6MQoIo11ZFAWVEsS8xw==
UI-OutboundReport: notjunk:1;M01:P0:Q3URMTomAwk=;Iq/ukwVLHjd5s1CHDl+VsOB0F4B
 8TnW0jk7VIRTsMwACfoXCavITJZ+RO71QddeHEkNrpKC5980P45PR7twjf3p3Q7D0Qz2P8tqA
 /XDaGjgEVoXzNKfBuO8Ep/jYEwIDgaDbvK37acFmM+Bolub/PwcmkGYPX1qj9gxPCl7CocyZt
 rZ+FxNcF2IBiksTAnVLU7ewz78SDZYH2khNEuiLo0fPkL7J7NFexfh9E+ygl38bBFTtlGzC4f
 vRueC9MGLD4DleuUfc2ycBs3ApmB7m78bE1Tyvz78eon40gtr9VKeJ9P/EgdKP+4jNwyVOHjT
 J/O8XgRAQ9EVFjUv9RyKqEZwXQcklGCmfAdOe4VHW4eqEkfgmYi93GHlC9wfG52q5X9kwT6jK
 +KQvuHrV8NjYQSvZZLZN5LlzitNvdrl9FQ7qZ2ax4jokWZI6xcSt/9sdRGE9HEx8oCl4HOvXE
 i/04l7PrmCzIrp92dN8ikjGg06yJKu9mglmk6ka98P5DkKfEVCLYxbK95KN0g992kCPJphzUW
 0/CTdsZhl0Nf8p67cQPXv+BGgFk62IS3+EjQ9xPna5LpJhq199uFASfzGyJC94k9j6sKdm2jd
 oAFBlkrQDe61LnRjDP5Uq2mF5Wt72KUPspzinDDKmPLd26C+NWiTy1omRKOoeRBdX2jGHSgzr
 7Qry5BXxIRKm68TuEmmGcpVh9d6L21/y0hzLQsW6qS1FALz9EvhClHv0pqKXsS0JAvilx+bVz
 LyqyZGp2duVkNTPzuwx4Oo9VOBpg0XXS12zBy3y2XSROnqadqmGRAWvjk6Owoxi4Y1ukEvDyg
 i3vakQcp7veDUSIy1BJiflPhJ/EXg8sie0bOkCfzXKFLv5KoVZRGINt6P3myqQ158Z+YenJeJ
 Q+NUuyUeS3Cp3oW8chby1NEsMma7WNMKN5AojipQZu5J2CQlvJVhuWGXO8nXDMjES8PmlKJQd
 Ju/N+L9TBexz2jkHcF3qUwbzK/o=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/13/23 02:10, Rick Edgecombe wrote:
> The x86 Shadow stack feature includes a new type of memory called shadow
> stack. This shadow stack memory has some unusual properties, which requi=
res
> some core mm changes to function properly.
>
> One of these unusual properties is that shadow stack memory is writable,
> but only in limited ways. These limits are applied via a specific PTE
> bit combination. Nevertheless, the memory is writable, and core mm code
> will need to apply the writable permissions in the typical paths that
> call pte_mkwrite(). Future patches will make pte_mkwrite() take a VMA, s=
o
> that the x86 implementation of it can know whether to create regular
> writable memory or shadow stack memory.
>
> But there are a couple of challenges to this. Modifying the signatures o=
f
> each arch pte_mkwrite() implementation would be error prone because some
> are generated with macros and would need to be re-implemented. Also, som=
e
> pte_mkwrite() callers operate on kernel memory without a VMA.
>
> So this can be done in a three step process. First pte_mkwrite() can be
> renamed to pte_mkwrite_novma() in each arch, with a generic pte_mkwrite(=
)
> added that just calls pte_mkwrite_novma(). Next callers without a VMA ca=
n
> be moved to pte_mkwrite_novma(). And lastly, pte_mkwrite() and all calle=
rs
> can be changed to take/pass a VMA.
>
> Start the process by renaming pte_mkwrite() to pte_mkwrite_novma() and
> adding the pte_mkwrite() wrapper in linux/pgtable.h. Apply the same
> pattern for pmd_mkwrite(). Since not all archs have a pmd_mkwrite_novma(=
),
> create a new arch config HAS_HUGE_PAGE that can be used to tell if
> pmd_mkwrite() should be defined. Otherwise in the !HAS_HUGE_PAGE cases t=
he
> compiler would not be able to find pmd_mkwrite_novma().
>
> No functional change.
>
> Cc: linux-doc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-alpha@vger.kernel.org
> Cc: linux-snps-arc@lists.infradead.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-csky@vger.kernel.org
> Cc: linux-hexagon@vger.kernel.org
> Cc: linux-ia64@vger.kernel.org
> Cc: loongarch@lists.linux.dev
> Cc: linux-m68k@lists.linux-m68k.org
> Cc: Michal Simek <monstr@monstr.eu>
> Cc: Dinh Nguyen <dinguyen@kernel.org>
> Cc: linux-mips@vger.kernel.org
> Cc: openrisc@lists.librecores.org
> Cc: linux-parisc@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-riscv@lists.infradead.org
> Cc: linux-s390@vger.kernel.org
> Cc: linux-sh@vger.kernel.org
> Cc: sparclinux@vger.kernel.org
> Cc: linux-um@lists.infradead.org
> Cc: linux-arch@vger.kernel.org
> Cc: linux-mm@kvack.org
> Suggested-by: Linus Torvalds <torvalds@linuxfoundation.org>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Link: https://lore.kernel.org/lkml/CAHk-=3DwiZjSu7c9sFYZb3q04108stgHff2w=
fbokGCCgW7riz+8Q@mail.gmail.com/
> ---
> Hi Non-x86 Arch=E2=80=99s,
>
> x86 has a feature that allows for the creation of a special type of
> writable memory (shadow stack) that is only writable in limited specific
> ways. Previously, changes were proposed to core MM code to teach it to
> decide when to create normally writable memory or the special shadow sta=
ck
> writable memory, but David Hildenbrand suggested[0] to change
> pXX_mkwrite() to take a VMA, so awareness of shadow stack memory can be
> moved into x86 code. Later Linus suggested a less error-prone way[1] to =
go
> about this after the first attempt had a bug.
>
> Since pXX_mkwrite() is defined in every arch, it requires some tree-wide
> changes. So that is why you are seeing some patches out of a big x86
> series pop up in your arch mailing list. There is no functional change.
> After this refactor, the shadow stack series goes on to use the arch
> helpers to push arch memory details inside arch/x86 and other arch's
> with upcoming shadow stack features.
>
> Testing was just 0-day build testing.
>
> Hopefully that is enough context. Thanks!
>
> [0] https://lore.kernel.org/lkml/0e29a2d0-08d8-bcd6-ff26-4bea0e4037b0@re=
dhat.com/
> [1] https://lore.kernel.org/lkml/CAHk-=3DwiZjSu7c9sFYZb3q04108stgHff2wfb=
okGCCgW7riz+8Q@mail.gmail.com/
> ---
>   arch/parisc/include/asm/pgtable.h            |  2 +-

Acked-by: Helge Deller <deller@gmx.de> # parisc

Helge
