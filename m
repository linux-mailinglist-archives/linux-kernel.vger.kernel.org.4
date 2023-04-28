Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1DF6F1DC8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 20:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346235AbjD1SDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 14:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjD1SDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 14:03:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03A72D69;
        Fri, 28 Apr 2023 11:03:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4970661A66;
        Fri, 28 Apr 2023 18:03:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D471C4339E;
        Fri, 28 Apr 2023 18:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682705012;
        bh=c6L1X4BgIOcktzeLUChU6aJWGbP0/aLPkV7gmZS0UKs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=URULa2d+QR+HOlQeO1K+icIhT3OW5LEZSsME1RudNmHb9UK0uoJS6h/f3xVjhyvM3
         aAJ2jYHP3yuzZpH85y/m2no5D5JdY9zMNYZgkj4gMZg45z3fTMOdhUSB19EZ7SYe7N
         FurFBMHteEMQrW204LGDgx3QPo4WkhB9vEyhBIyxin+2vrI9xPCULorg2gs/haWZVi
         991FJ5e97dOUTGhdBnE0lHeHuW2NT5xJ4w5IY7PSCDjL7nW0sZFS+Cej0iWYDSMGfH
         oZc0bbayrnMwodygH98AyaRT464XbwKwlcee4ekrlrfOD2HacKgmGgqK/StEykfhVt
         YMY+Uf/NJil6A==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-4efe8991b8aso250835e87.0;
        Fri, 28 Apr 2023 11:03:32 -0700 (PDT)
X-Gm-Message-State: AC+VfDzUdXoL8XgppuixvEN6iNTJHTH37xuxsZQ+AWHok0PTuIJkgXL9
        13WPEk5+BpJ7NPcvQLK7p77bK8+IKMpyG5s9mx8=
X-Google-Smtp-Source: ACHHUZ5otoB6oLEGJMnsT3sSOLwsgs9s9w+5qXKcQyWcMi/p8jKZng6ZikMfQofiDQMvYmkR4J+fm6rbxpfxC+dA6Ys=
X-Received: by 2002:a05:6512:403:b0:4ef:ec94:9674 with SMTP id
 u3-20020a056512040300b004efec949674mr1777138lfk.32.1682705010596; Fri, 28 Apr
 2023 11:03:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230426034001.16-1-cuiyunhui@bytedance.com> <CAMj1kXEKh9O-ndk3QFibJMYfMbG7vm-cLN2vVQM5eDsYK84NzQ@mail.gmail.com>
 <CAEEQ3wkJB5CKm33mHXUOPX5makYOHF8By6FYGnNzRkM-Mo72OQ@mail.gmail.com>
 <ZEj33QLZqEeL+/y4@FVFF77S0Q05N> <CAEEQ3wmDBJkfOeKCQfcnuE+1=1K0D2pzu+Sn+zPEWk+RHs0NFQ@mail.gmail.com>
 <CAP6exY+ydbzh1EkWTFejzwaW+PA-ySVO2Qj+CVJ1XbSMce2S9Q@mail.gmail.com>
 <ZEpbTE4gcsf8meXc@FVFF77S0Q05N> <CAMj1kXH5kZJ6ff=PRCRDLCBcw2AkEnRL_L1ABuvu5n71=unvAw@mail.gmail.com>
 <CAEEQ3w=495snOz3UNBO4dpgyfZs3jQoRKo4QRAXXqR5-0j4SWA@mail.gmail.com> <CAP6exYK9ytcgqcy2gFyOGvbxd7DPGQNs=m7nNgnfunnh8et9aQ@mail.gmail.com>
In-Reply-To: <CAP6exYK9ytcgqcy2gFyOGvbxd7DPGQNs=m7nNgnfunnh8et9aQ@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 28 Apr 2023 19:03:19 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGB4yXCdzts2=G_-hadoka9F2BU1gvVxeLEs5ifSbqgog@mail.gmail.com>
Message-ID: <CAMj1kXGB4yXCdzts2=G_-hadoka9F2BU1gvVxeLEs5ifSbqgog@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] firmware: added a firmware information
 passing method FFI
To:     ron minnich <rminnich@gmail.com>
Cc:     =?UTF-8?B?6L+Q6L6J5bSU?= <cuiyunhui@bytedance.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>, rafael@kernel.org,
        lenb@kernel.org, jdelvare@suse.com, yc.hung@mediatek.com,
        angelogioacchino.delregno@collabora.com,
        allen-kh.cheng@mediatek.com, pierre-louis.bossart@linux.intel.com,
        tinghan.shen@mediatek.com, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Fri, 28 Apr 2023 at 17:09, ron minnich <rminnich@gmail.com> wrote:
>
> There is lots of text in the preceding notes :-), which is nice because w=
e're clearly looking at something that matters!
>
> But, note, ARM Chromebooks run Linux, and I checked with the firmware tea=
m just now:
> "Right. We're not using UEFI or ACPI or SMBIOS or DMI or any of that on A=
rm. Just the Device Tree."
>
> So I do not agree that we need UEFI tables due to some presumed semantics=
 that they implement, because: several tens of millions of ARM chromebooks =
running Linux show otherwise.
>
> We've got a chance here to move to self describing data, and I think we n=
eed to take it. It will be a long time before we get this chance again.
>

I'm not sure what you mean by self-describing: device tree is
definitely not self-describing, and we maintain a huge collection of
DT bindings (which are documented in separate YAML files) in the
kernel tree that specify in detail how a device tree must be
constructed in order to comply with the device tree based boot
protocol.

However, introducing such a binding for SMBIOS is perfectly
reasonable, although I would suggest that we don't copy the
SMBIOS/SMBIOS3 entry point address into the device tree (as this patch
does), but properly describe the memory region that contains the
actual SMBIOS structured data directly, along with its version. This
might be reused by other DT based platforms as well.

Doing the same for ACPI is where we'll get into trouble, given that
we'd end up with two conflicting hardware descriptions and unfulfilled
dependencies on EFI specific data structures, and it is not the
kernel's job to reason about which h/w description should take
precedence, or to make guesses about memory types. So I fully agree
with Ron that moving to device tree is a much better choice here -
that way, you can avoid ACPI and UEFI altogether




> On Thu, Apr 27, 2023 at 8:18=E2=80=AFPM =E8=BF=90=E8=BE=89=E5=B4=94 <cuiy=
unhui@bytedance.com> wrote:
>>
>> Hi Ard, Mark,
>>
>> On Thu, Apr 27, 2023 at 8:52=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org>=
 wrote:
>>
>> > and the only combination we do not support is ACPI without EFI, as
>> > ACPI on arm64 depends on the EFI memory map.
>> >
>> > What this patch seems to be proposing is a combination of all of
>> > these, i.e., doing a pseudo-EFI direct kernel boot where the EFI
>> > dependencies of ACPI are being fulfilled by ad-hoc descriptions passed
>> > in via DT.
>> >
>> > I am concerned that this will result in a maintenance burden for Linux
>> > with very little gain, so I feel we should not go down this road.
>>
>> Judging from the current kernel, getting acpi smbios, memmap tables is
>> not just a way to have EFI, right?
>> smbios:SMBIOS_ENTRY_POINT_SCAN_START
>> acpi:CONFIG_ACPI_LEGACY_TABLES_LOOKUP
>> memmap: e820
>>
>> Our current situation is that coreboot does not support EFI, but support=
s fdt,
>> but we need to support ACPI,  and riscv does not have a reserved
>> address segment
>> like x86 that can be used, so our current solution is to pass acpi and
>> other tables through fdt.
>>
>> Based on this, do you have a better suggestion ?
>>
>> Thanks=EF=BC=8C
>> Yunhui
