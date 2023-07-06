Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C79D7497B7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 10:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbjGFIwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 04:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbjGFIwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 04:52:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2EEF1BC2;
        Thu,  6 Jul 2023 01:52:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5FB8F61866;
        Thu,  6 Jul 2023 08:52:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F287C433C7;
        Thu,  6 Jul 2023 08:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688633536;
        bh=ggVTIl5Ohn7qil0HaYjyKOkRlN5j1S5LhF5oA/HxgDs=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=nAAQ8I4u0oL9hHLlo/IXbbKw8j0UTDg3vzzcYaZRFuADEI3gURbH0O9DKjt8D1aKN
         kDmwv0Qr/cVFXAmFfR2dLyGi7A3EAi9ho2+uYSOLchmnNI+VfPy8UoyBkwrhMknQzM
         ZIdPoltZ082Zr/hs44C3Z3fGsQsv56AAbwypk7mR3iwPnR36pb5NhtacSgPio1lrB0
         2yckYj+tMSfftDmbv8vlu3lPqihTDgTLHqJuPJ/KmvPVg3PjFpU+tHvdyTNqU+yLZL
         zbZ/Up0WYMimXJlNVEnnTSHAn9qv/eXnMpfjE6145ztLWg+JxbLtMpwOv4iboeVApW
         OB7BTLbhow/Qg==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     =?utf-8?B?6L+Q6L6J5bSU?= <cuiyunhui@bytedance.com>
Cc:     Jessica Clarke <jrtc27@jrtc27.com>,
        Emil Renner Berthing <emil.renner.berthing@gmail.com>,
        Andrew Jones <ajones@ventanamicro.com>,
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
        weidong.wd@bytedance.com, graf@amazon.de
Subject: Re: [External] [PATCH v2 1/3] riscv: obtain ACPI RSDP from FFI.
In-Reply-To: <CAEEQ3wnaaMvJ3=7udvAjiP3q36nvqAwb8sh34f+nO8Ua_83yFw@mail.gmail.com>
References: <20230702095735.860-1-cuiyunhui@bytedance.com>
 <20230703-71f67eb66a037f5c0fb825c6@orel>
 <CAEEQ3w=7tBHyG=CvuktPN5cvfpY6ayamnbry6eOYxMDrPN+oZg@mail.gmail.com>
 <CANBLGcwcvK55dZ1__wvWCtcw=XoKt=qki8g6C_QYo+TBqqJ=TA@mail.gmail.com>
 <50F3BD62-78F1-456E-A44A-0C7D9A2D4113@jrtc27.com>
 <87bkgql8rq.fsf@all.your.base.are.belong.to.us>
 <CAEEQ3wnaaMvJ3=7udvAjiP3q36nvqAwb8sh34f+nO8Ua_83yFw@mail.gmail.com>
Date:   Thu, 06 Jul 2023 10:52:14 +0200
Message-ID: <87sfa1toap.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E8=BF=90=E8=BE=89=E5=B4=94 <cuiyunhui@bytedance.com> writes:

> Hi Bj=C3=B6rn,
>
> On Wed, Jul 5, 2023 at 10:43=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kern=
el.org> wrote:
>>
>> Jessica Clarke <jrtc27@jrtc27.com> writes:
>>
>> > On 3 Jul 2023, at 19:58, Emil Renner Berthing <emil.renner.berthing@gm=
ail.com> wrote:
>> >>
>> >> On Mon, 3 Jul 2023 at 15:33, =E8=BF=90=E8=BE=89=E5=B4=94 <cuiyunhui@b=
ytedance.com> wrote:
>> >>>
>> >>> Hi drew,
>> >>>
>> >>> On Mon, Jul 3, 2023 at 9:01=E2=80=AFPM Andrew Jones <ajones@ventanam=
icro.com> wrote:
>> >>>>
>> >>>>
>> >>>> (This is a reply to a non-existent cover letter.)
>> >>>
>> >>> This has been discussed many times with Ard, Please refer to :
>> >>> https://patches.linaro.org/project/linux-acpi/patch/20230426034001.1=
6-1-cuiyunhui@bytedance.com/
>> >>
>> >> Hi Yunhui,
>> >>
>> >> From that discussion it was mentioned that that arm supports 3 methods
>> >> of booting:
>> >>  direct + devicetree
>> >>  EFI + devicetree
>> >>  EFI + ACPI
>> >> ..but not
>> >>  direct + ACPI
>> >>
>> >> To me it isn't obvious from that or this thread, and since arm seems
>> >> to be doing fine without the 4th option I'm curious why that's
>> >> necessary on riscv?
>> >
>> > If anything we should be removing option 1, because that=E2=80=99s not=
 a
>> > cross-OS standard (though RISC-V=E2=80=99s SBI direct booting is at le=
ast not
>> > tied to the OS). Any application-class platform spec is going to
>> > mandate EFI, because, whatever your thoughts of EFI are, that is *the*
>> > standard. And if you=E2=80=99re willing to pick up all the complexity =
of ACPI,
>> > what=E2=80=99s a bit of EFI (especially if you only go for a minimal o=
ne a la
>> > U-Boot)?
>>
>> Well said!
>>
>> Yunhui, why not simply add a minimal UEFI stub to Coreboot (like Jess
>> points out above)?
>
> In fact, in the v1 email, Coreboot's maintainer Ron has made it clear
> that Coreboot does not support EFI, and it is necessary to transmit
> firmware information through DTS on RISC-V.

It clear that Coreboot doesn't support UEFI today. We're "arguing" that
it's less work/verification adding the neccesary minimal UEFI plumbing
for Coreboot, than jumping through hoops in the kernel to work around
it.

I'm getting some UEFI FUD vibes here. I also think that parts of UEFI is
kind of ugly, but it's, as Jess says, *the* spec and honestly, a bit
what's expected (Hi CXL).

UEFI is a specification, and implementing the minimal requirements for
UEFI is not that of a big deal. Look at Alex Graf's (et al) work on
u-boot UEFI. U-boot is small/lean/open *and* manage to support enough
UEFI for ACPI.

The whole "Oh, UEFI is so bad, bloated, and closed" hand-wavery is a bit
tiring. :-(

...these last four sections is more of a beer discussion. I'll take my
"my FW is better than yours" rants elsewhere. ;-)


Bj=C3=B6rn
