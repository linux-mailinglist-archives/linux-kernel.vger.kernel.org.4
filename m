Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4AF66BA60E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 05:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbjCOEOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 00:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbjCOENl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 00:13:41 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3133C509A6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 21:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678853575; x=1710389575;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9yzCmVnJ2ADFgpoYjZxap/HmlSXife7MeskouNF4fAo=;
  b=ATOU9dCprU+1B8w0+SapeatksDksOyfGISjo3eL4wK5vc1LtutNrbVLa
   YG9zSPWUkXtEPGhQK10HqFANIGtWpeuqccZqi9Wtz4r8SfRbI8vL31NVm
   UJ3K4a9NxDZUmxVKDi4znhqS0GsEbU3CazQxOvS6SNxEDc/3Rt/XwsP/+
   tYldndbogROkjf6i2NsO/35g7/V1yOhFvJMsVS2sDXB1qWdoUWcID4aKb
   B/kZbiLGYF7ZoVcOB/Yn8Q1I8MLllaqm5oM+moktfsGBcuNdX6FmqsUwR
   J1nHAf9rsl+p3ZSlJKBPnzJ31LY2v1ys8uzcruMiW2pFTAfXnQXnJURC0
   w==;
X-IronPort-AV: E=Sophos;i="5.98,261,1673884800"; 
   d="scan'208";a="230609557"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Mar 2023 12:12:54 +0800
IronPort-SDR: Vf/jtZau6xa1R4Xgd51PwB510n9SD8H0Y2/BPQzPxyv+bQVeIi2/ae291Y7veMp0mugorPPoqd
 hU8y6RdCbDsmSDPSPxBS8ZCKElBaeQEgjMnO7H9zjk/ch+qjdoIMTXoLeYBZnEtGpX6osaE5Zo
 H24vExozN00NRSbsrSjZQXrDm6D2pNV3i2fOiFQbEDlMaj9S6T0yMjuoKodU1//jGQvA+aRRc3
 22vC8zuFrvf5d9lRFcGL5W8myiYzFyRiLVup7cB3DyP0AYEkhvSJ8cHrTew82/IlVyEEU9iCZ5
 A18=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Mar 2023 20:23:40 -0700
IronPort-SDR: vZ6YUsdYAsiIDpR1LrFCd2dQZ4h7C6P1iYl6/EY2YOuR0Su8i899+h898w+GIali9DimWvsOp1
 VyLjF03NkvR1j+VJs/PQr+qGyWxQwQiTnKPTV/+Q4h6YQJxf8titSTBaYvt1i9A8flrX+pMVJM
 wHmlFzlEKqBx/NYuhruUW/aRLkgpT+KCrs9eF8qrxvWn5bFPXstXXDFItYp97xfzio29E8cy/2
 9eaHkh2mLbPeQItlv5QY2XwxktcbjAEYJ3LXKJMWHavHSO6Q1ThwKLv0kR6+9PWJl2G/sQG9uY
 9ZA=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Mar 2023 21:12:54 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pbxnf2HpGz1RtVp
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 21:12:54 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1678853573; x=1681445574; bh=9yzCmVnJ2ADFgpoYjZxap/HmlSXife7Mesk
        ouNF4fAo=; b=FBbk/eB6Leir1m8WJTARQJodRW25c5yVCiZrI8NcVcF7O2J1xMt
        C8BfqepJRN9OKXEvrVw3gGRmYljk51KsV+dWSqDLFzKD/jkB20gLQF4XxVtdlWQB
        rsoqP06MOheGOynGW3yA8fqrQmDvWczDM0GISt9QOcyuTWcG0I/cyNzZuhykoH5r
        dTVP1o6PWAqvuM0rJqAlWOa/JpFmZrOLVNpKmkblsZeNX6+phBQ67pEhVeRth/Jm
        WG6+6aR8pkY1MTHCmZ6P1WmpNPmBuxI9EHDg9a74LqMZtjg15+CZl1a7AxihsqzP
        fBgrdlVGQEMkmYhOWkLYiEeabP3QFh21CNw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 004tqWStsnoL for <linux-kernel@vger.kernel.org>;
        Tue, 14 Mar 2023 21:12:53 -0700 (PDT)
Received: from [10.225.163.84] (unknown [10.225.163.84])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pbxnc2Dq3z1RtVm;
        Tue, 14 Mar 2023 21:12:52 -0700 (PDT)
Message-ID: <9521f4da-1451-293e-ce0a-08b9edad2298@opensource.wdc.com>
Date:   Wed, 15 Mar 2023 13:12:50 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 0/2] riscv: support ELF format binaries in nommu mode
Content-Language: en-US
To:     Palmer Dabbelt <palmer@dabbelt.com>, gerg@kernel.org,
        macro@orcam.me.uk
Cc:     linux-riscv@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <mhng-a62a57b8-4268-4c51-b79e-f5f6bd0c13a2@palmer-ri-x1c9a>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <mhng-a62a57b8-4268-4c51-b79e-f5f6bd0c13a2@palmer-ri-x1c9a>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_PASS,T_SPF_HELO_TEMPERROR,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/15/23 12:58, Palmer Dabbelt wrote:
> On Tue, 28 Feb 2023 16:20:35 PST (-0800), gerg@kernel.org wrote:
>> Hi Palmer,
>>
>> On 1/3/23 07:52, Palmer Dabbelt wrote:
>>> On Tue, 28 Feb 2023 05:51:24 PST (-0800), gerg@kernel.org wrote:
>>>> The following changes add the ability to run ELF format binaries whe=
n
>>>> running RISC-V in nommu mode. That support is actually part of the
>>>> ELF-FDPIC loader, so these changes are all about making that work on
>>>> RISC-V.
>>>>
>>>> The first issue to deal with is making the ELF-FDPIC loader capable =
of
>>>> handling 64-bit ELF files. As coded right now it only supports 32-bi=
t
>>>> ELF files.
>>>>
>>>> Secondly some changes are required to enable and compile the ELF-FDP=
IC
>>>> loader on RISC-V and to pass the ELF-FDPIC mapping addresses through=
 to
>>>> user space when execing the new program.
>>>>
>>>> These changes have not been used to run actual ELF-FDPIC binaries.
>>>> It is used to load and run normal ELF - compiled -pie format. Though=
 the
>>>> underlying changes are expected to work with full ELF-FDPIC binaries=
 if
>>>> or when that is supported on RISC-V in gcc.
>>>>
>>>> To avoid needing changes to the C-library (tested with uClibc-ng
>>>> currently) there is a simple runtime dynamic loader (interpreter)
>>>> available to do the final relocations, https://github.com/gregungere=
r/uldso.
>>>> The nice thing about doing it this way is that the same program
>>>> binary can also be loaded with the usual ELF loader in MMU linux.
>>>>
>>>> The motivation here is to provide an easy to use alternative to the
>>>> flat format binaries normally used for RISC-V nommu based systems.
>>>>
>>>> Signed-off-by: Greg Ungerer <gerg@kernel.org>
>>>> ---
>>>>
>>>> =C2=A0arch/riscv/include/asm/elf.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0=C2=A0 11 +++++++++-
>>>> =C2=A0arch/riscv/include/asm/mmu.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 4 +++
>>>> =C2=A0arch/riscv/include/uapi/asm/ptrace.h |=C2=A0=C2=A0=C2=A0 5 +++=
+
>>>> =C2=A0fs/Kconfig.binfmt=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0=C2=A0 2 -
>>>> =C2=A0fs/binfmt_elf_fdpic.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 38 +++++++=
++++++++++------------------
>>>> =C2=A0include/linux/elf-fdpic.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 14 +++++++++++-
>>>> =C2=A0include/uapi/linux/elf-fdpic.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0 15 +++++++++++++
>>>> =C2=A07 files changed, 67 insertions(+), 22 deletions(-)
>>>
>>> Adding Damien, as IIRC he's had some hacked up userspace bits for the=
 K210.=C2=A0 I'm yet to get anything running, but it'd be great if we get=
 this to a point where I can actually boot test this on QEMU (I'm just do=
ing builds now).
>>
>> This is a simple script I user to generate a working QEMU example:
>>
>>    https://raw.githubusercontent.com/gregungerer/simple-linux/master/b=
uild-riscvnommu-linux-uclibc-elf.sh
>>
>> It does reference some configs here https://github.com/gregungerer/sim=
ple-linux/tree/master/configs
>> and this posted patchset as https://github.com/gregungerer/simple-linu=
x/tree/master/patches (this is
>> just these 2 patches combined as a single patch).
>>
>>
>>> Given that it's the second week of the merge window and this is a bun=
ch of new uABI it seems best to hold off until the next cycle.=C2=A0 I po=
ked around and don't see anything wrong, but I'll try and take a more det=
ailed look after the merge window.
>>
>> Oh, yeah, no hurry.
>=20
> Maciej and Damien: I'm fine taking this, but not in any rush.  I'd=20
> rather get the uABI right if things are still in flight, but if we're=20
> all just waiting for something to get merged first then I'm fine with=20
> that being Linux.

I did not try Gerg script with the k210. No time right now.
But if it works with QEMU, should be fine.

>=20
>>
>> Regards
>> Greg

--=20
Damien Le Moal
Western Digital Research

