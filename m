Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 306DC748699
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 16:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232621AbjGEOmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 10:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232475AbjGEOmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 10:42:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B961B6;
        Wed,  5 Jul 2023 07:42:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2DA4D61578;
        Wed,  5 Jul 2023 14:42:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E85DC433C7;
        Wed,  5 Jul 2023 14:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688568156;
        bh=89PZ/QaDV/f5qPoJLlgOoWPxoC4vw+BEViZ9AyZWsfg=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=DfJpQcZ5wYbIRdrAxfvkOEeQ58K5JIHMs2FykL5zAQ2Pv1iLJaDus12bGeMN5OIni
         /D0lLEsHoJ68qb2bWiEIORQV+3sph/xv9ZxP/oakwPnlxKQYcPeIwNsHH+5uX1f6+j
         1zQdvnww3UBWVPg1Z2nJ0ILX7uqBx7lb05o0Fe4CQB1S5X9MWiyLXhx4xN3lsIqAWx
         nzrHbS1MJgvtMYBmpB+zMkSzM8iUMIDrneRNkvqK1ETFJ6vV5glD8ABGTKfKJz56pj
         oN3ZVXO1IctgMPpWmdDJuGm/+YEdlAeXX2T4iQFNVsFE50XMkGYWqre3TxkZUjXPpt
         x+hYbs5HsGqQw==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     =?utf-8?B?6L+Q6L6J5bSU?= <cuiyunhui@bytedance.com>,
        Jessica Clarke <jrtc27@jrtc27.com>,
        Emil Renner Berthing <emil.renner.berthing@gmail.com>
Cc:     Andrew Jones <ajones@ventanamicro.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        rminnich@gmail.com, Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, jdelvare@suse.com,
        yc.hung@mediatek.com, angelogioacchino.delregno@collabora.com,
        allen-kh.cheng@mediatek.com, pierre-louis.bossart@linux.intel.com,
        tinghan.shen@mediatek.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-acpi@vger.kernel.org, geshijian@bytedance.com,
        weidong.wd@bytedance.com
Subject: Re: [External] [PATCH v2 1/3] riscv: obtain ACPI RSDP from FFI.
In-Reply-To: <50F3BD62-78F1-456E-A44A-0C7D9A2D4113@jrtc27.com>
References: <20230702095735.860-1-cuiyunhui@bytedance.com>
 <20230703-71f67eb66a037f5c0fb825c6@orel>
 <CAEEQ3w=7tBHyG=CvuktPN5cvfpY6ayamnbry6eOYxMDrPN+oZg@mail.gmail.com>
 <CANBLGcwcvK55dZ1__wvWCtcw=XoKt=qki8g6C_QYo+TBqqJ=TA@mail.gmail.com>
 <50F3BD62-78F1-456E-A44A-0C7D9A2D4113@jrtc27.com>
Date:   Wed, 05 Jul 2023 16:42:33 +0200
Message-ID: <87bkgql8rq.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jessica Clarke <jrtc27@jrtc27.com> writes:

> On 3 Jul 2023, at 19:58, Emil Renner Berthing <emil.renner.berthing@gmail=
.com> wrote:
>>=20
>> On Mon, 3 Jul 2023 at 15:33, =E8=BF=90=E8=BE=89=E5=B4=94 <cuiyunhui@byte=
dance.com> wrote:
>>>=20
>>> Hi drew,
>>>=20
>>> On Mon, Jul 3, 2023 at 9:01=E2=80=AFPM Andrew Jones <ajones@ventanamicr=
o.com> wrote:
>>>>=20
>>>>=20
>>>> (This is a reply to a non-existent cover letter.)
>>>=20
>>> This has been discussed many times with Ard, Please refer to :
>>> https://patches.linaro.org/project/linux-acpi/patch/20230426034001.16-1=
-cuiyunhui@bytedance.com/
>>=20
>> Hi Yunhui,
>>=20
>> From that discussion it was mentioned that that arm supports 3 methods
>> of booting:
>>  direct + devicetree
>>  EFI + devicetree
>>  EFI + ACPI
>> ..but not
>>  direct + ACPI
>>=20
>> To me it isn't obvious from that or this thread, and since arm seems
>> to be doing fine without the 4th option I'm curious why that's
>> necessary on riscv?
>
> If anything we should be removing option 1, because that=E2=80=99s not a
> cross-OS standard (though RISC-V=E2=80=99s SBI direct booting is at least=
 not
> tied to the OS). Any application-class platform spec is going to
> mandate EFI, because, whatever your thoughts of EFI are, that is *the*
> standard. And if you=E2=80=99re willing to pick up all the complexity of =
ACPI,
> what=E2=80=99s a bit of EFI (especially if you only go for a minimal one =
a la
> U-Boot)?

Well said!

Yunhui, why not simply add a minimal UEFI stub to Coreboot (like Jess
points out above)?

IMO what U-boot (or
https://github.com/cloud-hypervisor/rust-hypervisor-firmware if you're
into Rust ;-)) is doing, and just having a small UEFI shim is the way to
go.
