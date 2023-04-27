Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2988D6F0C12
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 20:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244588AbjD0SmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 14:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243639AbjD0SmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 14:42:14 -0400
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C02C10C6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 11:42:13 -0700 (PDT)
Received: from [127.0.0.1] ([73.231.166.163])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 33RIe6OM375051
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Thu, 27 Apr 2023 11:40:07 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 33RIe6OM375051
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2023040901; t=1682620809;
        bh=rYnD7pkCIgEpxgiuVJ8/9sz/T5OnJ8VmHi4qScJQMRM=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=hLU1Quyo2y9woh85OWcLX8Y/ZVhLXw4dueIS4kqyVT30n8nzyx1IKtBn7jwXm5r3I
         XUWRP6aYpXFqfvGQMRKTEAbBhA5Qi1/7mCCDb2szn7zgtptYBAnfRQXhL1DKcPTLHR
         7zHOgSLAlgb2O98UAbW4nlormZuVB7635Fas/Z2syNr9o3PjZF/78Jxx8D+BgjNEMw
         dslA/BA+otZkgWTX2jOcxIzqCqL2/bRPVPdallrO793WSbEIUjJOaXTTpOQTfYFco+
         BDtaQHdsXG/ITIJQRuU2eLtNYfxOhHfSTcQzBl2Gukm0hG53cpUNAQYyeLqJ9bphGC
         bZLkYMH75b7fg==
Date:   Thu, 27 Apr 2023 11:40:02 -0700
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Anthony Yznaga <anthony.yznaga@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
CC:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        rppt@kernel.org, akpm@linux-foundation.org, ebiederm@xmission.com,
        keescook@chromium.org, graf@amazon.com, jason.zeng@intel.com,
        lei.l.li@intel.com, steven.sistare@oracle.com,
        fam.zheng@bytedance.com, mgalaxy@akamai.com,
        kexec@lists.infradead.org
Subject: Re: [RFC v3 21/21] x86/boot/compressed/64: use 1GB pages for mappings
User-Agent: K-9 Mail for Android
In-Reply-To: <1682554137-13938-22-git-send-email-anthony.yznaga@oracle.com>
References: <1682554137-13938-1-git-send-email-anthony.yznaga@oracle.com> <1682554137-13938-22-git-send-email-anthony.yznaga@oracle.com>
Message-ID: <70EB1774-A782-47FB-A8EA-534E66A551F6@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On April 26, 2023 5:08:57 PM PDT, Anthony Yznaga <anthony=2Eyznaga@oracle=
=2Ecom> wrote:
>pkram kaslr code can incur multiple page faults when it walks its
>preserved ranges list called via mem_avoid_overlap()=2E  The multiple
>faults can easily end up using up the small number of pages available
>to be allocated for page table pages=2E
>
>This patch hacks things so that mappings are 1GB which results in the nee=
d
>for far fewer page table pages=2E  As is this breaks AMD SEV-ES which exp=
ects
>the mappings to be 2M=2E  This could possibly be fixed by updating split
>code to split 1GB page if the aren't any other issues with using 1GB
>mappings=2E
>
>Signed-off-by: Anthony Yznaga <anthony=2Eyznaga@oracle=2Ecom>
>---
> arch/x86/boot/compressed/ident_map_64=2Ec | 9 +++++----
> 1 file changed, 5 insertions(+), 4 deletions(-)
>
>diff --git a/arch/x86/boot/compressed/ident_map_64=2Ec b/arch/x86/boot/co=
mpressed/ident_map_64=2Ec
>index 321a5011042d=2E=2E1e02cf6dda3c 100644
>--- a/arch/x86/boot/compressed/ident_map_64=2Ec
>+++ b/arch/x86/boot/compressed/ident_map_64=2Ec
>@@ -95,8 +95,8 @@ void kernel_add_identity_map(unsigned long start, unsig=
ned long end)
> 	int ret;
>=20
> 	/* Align boundary to 2M=2E */
>-	start =3D round_down(start, PMD_SIZE);
>-	end =3D round_up(end, PMD_SIZE);
>+	start =3D round_down(start, PUD_SIZE);
>+	end =3D round_up(end, PUD_SIZE);
> 	if (start >=3D end)
> 		return;
>=20
>@@ -120,6 +120,7 @@ void initialize_identity_maps(void *rmode)
> 	mapping_info=2Econtext =3D &pgt_data;
> 	mapping_info=2Epage_flag =3D __PAGE_KERNEL_LARGE_EXEC | sme_me_mask;
> 	mapping_info=2Ekernpg_flag =3D _KERNPG_TABLE;
>+	mapping_info=2Edirect_gbpages =3D true;
>=20
> 	/*
> 	 * It should be impossible for this not to already be true,
>@@ -365,8 +366,8 @@ void do_boot_page_fault(struct pt_regs *regs, unsigne=
d long error_code)
>=20
> 	ghcb_fault =3D sev_es_check_ghcb_fault(address);
>=20
>-	address   &=3D PMD_MASK;
>-	end        =3D address + PMD_SIZE;
>+	address   &=3D PUD_MASK;
>+	end        =3D address + PUD_SIZE;
>=20
> 	/*
> 	 * Check for unexpected error codes=2E Unexpected are:

Strong NAK: 1G pages are not supported by all 64-bit CPUs, *and* by your o=
wn admission breaks things =2E=2E=2E
