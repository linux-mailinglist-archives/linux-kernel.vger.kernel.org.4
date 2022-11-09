Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2070F62227C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 04:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbiKIDO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 22:14:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiKIDOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 22:14:54 -0500
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3FF22B3B
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 19:14:53 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1667963691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DNSrYyuXAb9KkJUh6mgu5D2kNc+zrdhtGOh9S2mb3dc=;
        b=h1Osu+8NiKcZcp0eGLs+ttEcyg0B9JyICcvybRpwWwsNJhGYbmyXr4ca+Jbm6z8SSuowjs
        VvRRPPhrFbr1Mou9kTl4zyNQ1GMuHkK8bx1Ax9qkUwN3G1U/lBbb9ik1Ro0DFAIzsU6coB
        qXgrYpVJGSCwEvlTjmlvrsiEcqA18QI=
MIME-Version: 1.0
Subject: Re: [PATCH v1] arch/x86/mm/hugetlbpage.c: pud_huge() returns 0 when
 using 2-level paging
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20221107021010.2449306-1-naoya.horiguchi@linux.dev>
Date:   Wed, 9 Nov 2022 11:14:33 +0800
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        =?utf-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <6C1AF1FE-40EC-4B0F-A899-5BAE4BB0EA4A@linux.dev>
References: <20221107021010.2449306-1-naoya.horiguchi@linux.dev>
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 7, 2022, at 10:10, Naoya Horiguchi <naoya.horiguchi@linux.dev> =
wrote:
>=20
> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
>=20
> The following bug is reported to be triggered when starting X on =
x86-32
> system with i915:
>=20
>  [  225.777375] kernel BUG at mm/memory.c:2664!
>  [  225.777391] invalid opcode: 0000 [#1] PREEMPT SMP
>  [  225.777405] CPU: 0 PID: 2402 Comm: Xorg Not tainted 6.1.0-rc3-bdg+ =
#86
>  [  225.777415] Hardware name:  /8I865G775-G, BIOS F1 08/29/2006
>  [  225.777421] EIP: __apply_to_page_range+0x24d/0x31c
>  [  225.777437] Code: ff ff 8b 55 e8 8b 45 cc e8 0a 11 ec ff 89 d8 83 =
c4 28 5b 5e 5f 5d c3 81 7d e0 a0 ef 96 c1 74 ad 8b 45 d0 e8 2d 83 49 00 =
eb a3 <0f> 0b 25 00 f0 ff ff 81 eb 00 00 00 40 01 c3 8b 45 ec 8b 00 e8 =
76
>  [  225.777446] EAX: 00000001 EBX: c53a3b58 ECX: b5c00000 EDX: =
c258aa00
>  [  225.777454] ESI: b5c00000 EDI: b5900000 EBP: c4b0fdb4 ESP: =
c4b0fd80
>  [  225.777462] DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: =
00010202
>  [  225.777470] CR0: 80050033 CR2: b5900000 CR3: 053a3000 CR4: =
000006d0
>  [  225.777479] Call Trace:
>  [  225.777486]  ? i915_memcpy_init_early+0x63/0x63 [i915]
>  [  225.777684]  apply_to_page_range+0x21/0x27
>  [  225.777694]  ? i915_memcpy_init_early+0x63/0x63 [i915]
>  [  225.777870]  remap_io_mapping+0x49/0x75 [i915]
>  [  225.778046]  ? i915_memcpy_init_early+0x63/0x63 [i915]
>  [  225.778220]  ? mutex_unlock+0xb/0xd
>  [  225.778231]  ? i915_vma_pin_fence+0x6d/0xf7 [i915]
>  [  225.778420]  vm_fault_gtt+0x2a9/0x8f1 [i915]
>  [  225.778644]  ? lock_is_held_type+0x56/0xe7
>  [  225.778655]  ? lock_is_held_type+0x7a/0xe7
>  [  225.778663]  ? 0xc1000000
>  [  225.778670]  __do_fault+0x21/0x6a
>  [  225.778679]  handle_mm_fault+0x708/0xb21
>  [  225.778686]  ? mt_find+0x21e/0x5ae
>  [  225.778696]  exc_page_fault+0x185/0x705
>  [  225.778704]  ? doublefault_shim+0x127/0x127
>  [  225.778715]  handle_exception+0x130/0x130
>  [  225.778723] EIP: 0xb700468a
>=20
> Recently pud_huge() got aware of non-present entry by commit =
3a194f3f8ad0
> ("mm/hugetlb: make pud_huge() and follow_huge_pud() aware of =
non-present
> pud entry") to handle some special states of gigantic page.  However, =
it's
> overlooked that pud_none() always returns false when running with =
2-level
> paging, and as a result pmd_huge() can return true pointlessly.
>=20
> Introduce "#if CONFIG_PGTABLE_LEVELS > 2" to pud_huge() to deal with =
this.
>=20
> Fixes: 3a194f3f8ad0 ("mm/hugetlb: make pud_huge() and =
follow_huge_pud() aware of non-present pud entry")
> Reported-by: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> Cc: <stable@vger.kernel.org>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.

