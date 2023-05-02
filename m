Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F80A6F3D21
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 07:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233462AbjEBFtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 01:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233018AbjEBFta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 01:49:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2827C3C03
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 22:49:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B7796114D
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 05:49:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CF34C433D2;
        Tue,  2 May 2023 05:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683006568;
        bh=XZgZAS0IJYvBCvNMmmrNBtsGeLXPqmq39HguoAr5Cpo=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=WxNMR7Xjfz6JTdz5RI+4EngcKkVBosdrQjQyuyYPs/hfvKi6+XHNwlApSNVLqMT7B
         qZNmXVo5ZRyXsCXkkf8azBqo9itm7mPel1GP2J1/BPD6sLqiR62awB5tWPSvz0/8sb
         yVM89oRJRtK0AS5dIwH37gTHl62vHd2eHEX+rO4DS4nFhPTep0YGy/S/gM8Q3QjC2t
         Ka2hR7IVmIau+YNM1lua7OGIIcJIw9PmzJYmhF0wvy2hQyM5kdn7etvlr/IY03h0sV
         YP63JxxnCxXWEK4TMlK7TIgQHTEbBioqWCikRM08jrvTCn9KvmPXgtrjUVaPHGwELB
         4szEjELLv5Bcg==
Date:   Tue, 02 May 2023 06:49:22 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>
CC:     Conor Dooley <conor.dooley@microchip.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        akpm@linux-foundation.org, aneesh.kumar@linux.ibm.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        lukas.bulwahn@gmail.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_RISC-V=3A_fixup_in-flight_collis?= =?US-ASCII?Q?ion_with_ARCH=5FWANT=5FOPTIMIZE=5FVMEMMAP_rename?=
User-Agent: K-9 Mail for Android
In-Reply-To: <mhng-e1596f31-67bc-4e2e-b86e-a32da907eecd@palmer-ri-x1c9a>
References: <mhng-e1596f31-67bc-4e2e-b86e-a32da907eecd@palmer-ri-x1c9a>
Message-ID: <8BF847E5-B06F-49B0-81D8-E75A6A8D0AF7@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
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



On 1 May 2023 23:52:58 IST, Palmer Dabbelt <palmer@dabbelt=2Ecom> wrote:
>On Sat, 29 Apr 2023 02:32:33 PDT (-0700), Conor Dooley wrote:
>> On Sat, Apr 29, 2023 at 10:27:33AM +0100, Conor Dooley wrote:
>>> From: Conor Dooley <conor=2Edooley@microchip=2Ecom>
>>>=20
>>> Lukas warned that ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP had been
>>> renamed in the mm tree & that RISC-V would need a fixup as part of the
>>> merge=2E The warning was missed however, and RISC-V is selecting the
>>> orphaned Kconfig option=2E
>>>=20
>>> Fixes: 89d77f71f493 ("Merge tag 'riscv-for-linus-6=2E4-mw1' of git://g=
it=2Ekernel=2Eorg/pub/scm/linux/kernel/git/riscv/linux")
>>> Reported-by: Lukas Bulwhan <lukas=2Ebulwhan@gmail=2Ecom>
>>=20
>> That should have been Lukas Bulwahn <lukas=2Ebulwahn@gmail=2Ecom>=2E
>
>I think I got that right, but the email bounced=2E  I'm not sure if it's =
just the list issues, though=2E

B4 probably just replied to the address in my original email,
rather than the corrected one?

>
>> This is what I get for hand-typing an email address that I could have
>> copied from lore I suppose=2E
>>=20
>>> Link: https://lore=2Ekernel=2Eorg/linux-riscv/CAKXUXMyVeg2kQK_edKHtMD3=
eADrDK_PKhCSVkMrLDdYgTQQ5rg@mail=2Egmail=2Ecom/
>>> Signed-off-by: Conor Dooley <conor=2Edooley@microchip=2Ecom>
>>> ---
>>> I guess you picking this up for your second PR makes the most sense
>>> Palmer?
>>>=20
>>> CC: Palmer Dabbelt <palmer@dabbelt=2Ecom>
>>> CC: Linus Torvalds <torvalds@linux-foundation=2Eorg>
>>> CC: Andrew Morton <akpm@linux-foundation=2Eorg>
>>> CC: Aneesh Kumar K=2EV <aneesh=2Ekumar@linux=2Eibm=2Ecom>
>>> CC: Lukas Bulwhan <lukas=2Ebulwhan@gmail=2Ecom>
>>> CC: linux-riscv@lists=2Einfradead=2Eorg
>>> CC: linux-kernel@vger=2Ekernel=2Eorg
>>> ---
>>>  arch/riscv/Kconfig | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>=20
>>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>>> index 5c88ac4b52be=2E=2Ee1bdb3fb16cc 100644
>>> --- a/arch/riscv/Kconfig
>>> +++ b/arch/riscv/Kconfig
>>> @@ -46,9 +46,9 @@ config RISCV
>>>  	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU
>>>  	select ARCH_WANT_FRAME_POINTERS
>>>  	select ARCH_WANT_GENERAL_HUGETLB if !RISCV_ISA_SVNAPOT
>>> -	select ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
>>>  	select ARCH_WANT_HUGE_PMD_SHARE if 64BIT
>>>  	select ARCH_WANT_LD_ORPHAN_WARN if !XIP_KERNEL
>>> +	select ARCH_WANT_OPTIMIZE_VMEMMAP
>>>  	select ARCH_WANTS_THP_SWAP if HAVE_ARCH_TRANSPARENT_HUGEPAGE
>>>  	select BINFMT_FLAT_NO_DATA_START_OFFSET if !MMU
>>>  	select BUILDTIME_TABLE_SORT if MMU
>>> --=20
>>> 2=2E39=2E2
>>>=20
