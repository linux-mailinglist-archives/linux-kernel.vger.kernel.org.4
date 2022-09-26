Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49E705EAF3F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 20:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbiIZSJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 14:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiIZSJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 14:09:12 -0400
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A20640A
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 10:55:23 -0700 (PDT)
Received: from [127.0.0.1] ([73.223.250.219])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 28QHqB9Q1421307
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Mon, 26 Sep 2022 10:52:12 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 28QHqB9Q1421307
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2022090501; t=1664214733;
        bh=hLqd7WM4fQuRrX4MuUr1oLpSdIj1sB1gjJzdBDORqVw=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=OCnK7FyMSNY/ERMqPS8CvPcuVF0ngptqhhDU55JW04STpNwV1M0y84wAzdWTwQEgI
         A+ulpl8jEcfS/lNv0GihW/uMDvZl7euVgZ5msHuewKmTAE7+5fFv7xFOq8o+oV9hC6
         z2q4WpX2KRbenBMhFgfThtFHxuvBkKwfroXQOVhMh/ld7KrHLP/fD4DBGwWyiPA2wt
         +8uSgphsnLDeBO7bYRCUaIsYDZwr73LcHjlcZ4+q9NRiefrYulBcITzqVIJm7fVg8g
         Ngc+9rPKe6psSYOabDQBl1fXc4c6/AH219xXijEBvGCaUEbK1mPMrAN0Lqot93NVkc
         EFayDsmUaweLQ==
Date:   Mon, 26 Sep 2022 10:52:08 -0700
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Borislav Petkov <bp@alien8.de>, Li Zetao <lizetao1@huawei.com>
CC:     tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, brijesh.singh@amd.com, michael.roth@amd.com,
        venu.busireddy@oracle.com, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_-next=5D_x86/sev=3A_Remove_unu?= =?US-ASCII?Q?sed_variable_=22err=22_in_enforce=5Fvmpl0=28=29?=
User-Agent: K-9 Mail for Android
In-Reply-To: <YzG72ynMieCUaHVM@zn.tnic>
References: <20220923113209.3046960-1-lizetao1@huawei.com> <Yy2kU7lZuArVMC5p@zn.tnic> <b02f72c5-636d-2d4f-98d7-bf3741e38e5d@huawei.com> <YzG72ynMieCUaHVM@zn.tnic>
Message-ID: <BA9F2C10-DC7F-49F9-B1AE-D58D690A5291@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On September 26, 2022 7:48:59 AM PDT, Borislav Petkov <bp@alien8=2Ede> wrot=
e:
>On Sat, Sep 24, 2022 at 06:18:19PM +0800, Li Zetao wrote:
>> My Compiler version is 11=2E2=2E0=2E I used the default =2Econfig and c=
ompiled with
>> flags "-Wall -Werror", just as follows:
>>=20
>> =C2=A0=C2=A0=C2=A0 make allmodconfig
>>=20
>> =C2=A0=C2=A0=C2=A0 make EXTRA_CFLAGS=3D"-Wall -Werror"
>
>Ah, compressed/Makefile doesn't have -Wall=2E That's the old problem of
>x86 not sharing makefiles=2E I need to dust off my patches which do that=
=2E
>
>Now, if you do:
>
>diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed=
/Makefile
>index 35ce1a64068b=2E=2E10abb7c45d04 100644
>--- a/arch/x86/boot/compressed/Makefile
>+++ b/arch/x86/boot/compressed/Makefile
>@@ -34,7 +34,7 @@ targets :=3D vmlinux vmlinux=2Ebin vmlinux=2Ebin=2Egz v=
mlinux=2Ebin=2Ebz2 vmlinux=2Ebin=2Elzma \
> # be valid=2E
> KBUILD_CFLAGS :=3D -m$(BITS) -O2 $(CLANG_FLAGS)
> KBUILD_CFLAGS +=3D -fno-strict-aliasing -fPIE
>-KBUILD_CFLAGS +=3D -Wundef
>+KBUILD_CFLAGS +=3D -Wundef -Wall
> KBUILD_CFLAGS +=3D -DDISABLE_BRANCH_PROFILING
> cflags-$(CONFIG_X86_32) :=3D -march=3Di386
> cflags-$(CONFIG_X86_64) :=3D -mcmodel=3Dsmall -mno-red-zone
>
>then allmodconfig triggers a bunch:
>
>arch/x86/boot/compressed/efi=2Ec: In function =E2=80=98efi_get_system_tab=
le=E2=80=99:
>arch/x86/boot/compressed/efi=2Ec:62:23: warning: unused variable =E2=80=
=98et=E2=80=99 [-Wunused-variable]
>   62 |         enum efi_type et;
>      |                       ^~
>arch/x86/boot/compressed/efi=2Ec: In function =E2=80=98efi_get_conf_table=
=E2=80=99:
>arch/x86/boot/compressed/efi=2Ec:134:13: warning: unused variable =E2=80=
=98ret=E2=80=99 [-Wunused-variable]
>  134 |         int ret;
>      |             ^~~
>arch/x86/boot/compressed/acpi=2Ec: In function =E2=80=98__efi_get_rsdp_ad=
dr=E2=80=99:
>arch/x86/boot/compressed/acpi=2Ec:27:13: warning: unused variable =E2=80=
=98ret=E2=80=99 [-Wunused-variable]
>   27 |         int ret;
>      |             ^~~
>arch/x86/boot/compressed/acpi=2Ec: In function =E2=80=98efi_get_rsdp_addr=
=E2=80=99:
>arch/x86/boot/compressed/acpi=2Ec:55:22: warning: unused variable =E2=80=
=98nr_tables=E2=80=99 [-Wunused-variable]
>   55 |         unsigned int nr_tables;
>      |                      ^~~~~~~~~
>arch/x86/boot/compressed/sev=2Ec: In function =E2=80=98enforce_vmpl0=E2=
=80=99:
>arch/x86/boot/compressed/sev=2Ec:256:13: warning: unused variable =E2=80=
=98err=E2=80=99 [-Wunused-variable]
>  256 |         int err;
>      |             ^~~
>
>
>Would you like to do the above instead and fix them all in one go?
>
>Thx=2E
>

The boot code really needs to be refactored, especially that the real-mode=
 BIOS code is built in the root of that tree=2E
