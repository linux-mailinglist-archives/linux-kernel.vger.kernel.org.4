Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35EC17351A6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 12:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbjFSKLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 06:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231740AbjFSKLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 06:11:07 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94BBC10CE;
        Mon, 19 Jun 2023 03:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1687169428; x=1687774228; i=deller@gmx.de;
 bh=qGeiVrX793s0DZYEPdtucWfg8cVq1CsOldhtd9/eL3w=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=N7Px8AjvhL4+znxRqKxz+lSA270421k2rcZysgGpUOdCoRMhGTVOjDqDGLH1s0EkpQD0ZFf
 P8X6a67UPCgBtqINFV+8/+O48QhEDhGdWFL8S2dc7nWGUbJOPu9FHjuAF/MwnelAJRj70ooke
 TF0kgPe8dAPr5xLyNrzU7eQOpE1eD3kp57dGR93RygOq7/7ZzHsan29gdI/D6roYCEefuxco/
 Po6GiDXT+7WReQvdM1U5aRmkRt1Y+JRjARR3yIt3/ipmtXPE3rWn4HHtSismb6F+asv/8Oj/G
 auQPLsmcFpQoUStnyLN72oawOJVSUjfcDxuz1ekj35RKbozKmoNw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.144.204]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N2E1G-1q6PTW2kcI-013i1Z; Mon, 19
 Jun 2023 12:10:28 +0200
Message-ID: <6c7a0ca2-003b-c724-6ef1-4d756d05d2f0@gmx.de>
Date:   Mon, 19 Jun 2023 12:10:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/3] nios2: Fix flush_dcache_page() for usage from irq
 context
Content-Language: en-US
To:     Dinh Nguyen <dinguyen@kernel.org>, linux@armlinux.org.uk,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org
References: <20230524152633.203927-1-deller@gmx.de>
 <20230524152633.203927-3-deller@gmx.de>
 <d5bd569d-b20e-f9c7-d839-93011dde380b@kernel.org>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <d5bd569d-b20e-f9c7-d839-93011dde380b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6Ip6mm7Bsw+/cTJsBB4pvMFdzoEQcOBCpy8pF0iNolDQnV9g6xO
 Kaxf/VhnOD/qaECrj4ihQZK7zgQ12RoTTOe4jXea6vqDj52E3/ZKrkEyrgE9bJE95StLKUk
 QjkBoizdPUV2f9C0Z87Kh61nOR5xeXswAU5iMrMr1RJvzmAdHxRas4oyMhkBjaXaGZw8LHv
 QDCTMPCq1u49IMf8wx2Uw==
UI-OutboundReport: notjunk:1;M01:P0:qmtmZJb+fTI=;ofiShLOTJd+FmbyF/cxgXTjj6/m
 1c50isGBSSmpooU3EBnDLlKYI6pj+dvZ0InRMF/IW/qHNTJZewNtxjQsIMM9OZW7pY0jCvk2L
 iqNZaA0oMrvA3DCEKKI8OOqVOuGnTiyAso9B+TklqkrfVaOBFX05Bft6wHSAF8CwbCYe7YOtl
 bb/3WduWfTG7xrC+uDZCRTMeHxHB9aWJ7/HlBs/ykMO+LlGlqcSMoMMkyNz4PGHCNZ/UyAs1F
 TbDQr7/eqHQvhfGTwyGDSy6uQ4nd//mCctuedjPtJbOSmCe6KtLsaJ9wGczSN8IXj0S6GLUEN
 GkcRqQXSBDSzbaQMf/QGJ2wdsrO+fvyf4QQu8iNiVvBk4RyIWBZGgpopPyxI3zK3QRjHzF981
 svk5BLTXhXPDSeYu6zqVziOGDW5sgjUOcVS/Nbs18/3ASCIdZ9seorxIz4kJfrwO4kXFa1O0B
 ROldqmDjv4esQsHt5EeCuKlHy81gbImu5Ke8NbTId9sZGmRk9fDC6yScSVDEyF4O/gTEvzNxX
 rslfj4/Sbvz/yRWafBLg/JnzZd9aYEft7Jzrynp8KXdGTzS6V/y9sbmScAyhiFlTy54KFd16F
 YXFj4OVNsyQV3cL3IPG2TtHZN3A+7jrBHqPQAZuJNAJ7rnOO/+0f1cK+UWa6v27sn+I8kI6TY
 wv873yemxhmLdNsa9RiPzrSwVTsvDGaI87WQowmJsraROW7xfPrIZGrZMf2GW3D1lyQG7gv6K
 wGa8vtSr+02jhURb9OTv3taZquBs5FKqqleDcCgjgcpwTLcPAPFYUTDBEscZmk3RiKOjgfKzo
 JM4r6Em1G7TxXBlDuvy6139O3KQs6y+yTNCS/9vRXfJoXc5wl68vGrsoolhILfsyz6kbnnlUa
 R4TRS0FnSXSdmxbEhcsiePledct/I9QIDWljgktylsRoYZXEgiHbQwQ2IfCTjC6nUs4ui+JDD
 DLWuOKYQEquTAZo2nHeE+5ZSk0s=
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

Hi Dinh,

On 6/14/23 00:39, Dinh Nguyen wrote:
> Thanks for the patch. Does it need a Fixes tag?

I did not add a fixes tag for the parisc or arm version.

The code was originally correct, but later patches then suddenly started
using cache flushes from irq context (e.g. 21b40200cfe96 ("aio: use
flush_dcache_page()")) which then triggers the bug.
So, it's hard to say that it fixes one specific commit.

I suggest you backport it as far as possible.

Helge

> Dinh
>
> On 5/24/23 10:26, Helge Deller wrote:
>> Since at least kernel 6.1, flush_dcache_page() is called with IRQs
>> disabled, e.g. from aio_complete().
>>
>> But the current implementation for flush_dcache_page() on NIOS2
>> unintentionally re-enables IRQs, which may lead to deadlocks.
>>
>> Fix it by using xa_lock_irqsave() and xa_unlock_irqrestore()
>> for the flush_dcache_mmap_*lock() macros instead.
>>
>> Cc: Dinh Nguyen <dinguyen@kernel.org>
>> Signed-off-by: Helge Deller <deller@gmx.de>
>> ---
>> =C2=A0 arch/nios2/include/asm/cacheflush.h | 4 ++++
>> =C2=A0 arch/nios2/mm/cacheflush.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 5 +++--
>> =C2=A0 2 files changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/nios2/include/asm/cacheflush.h b/arch/nios2/include/a=
sm/cacheflush.h
>> index d0b71dd71287..a37242662809 100644
>> --- a/arch/nios2/include/asm/cacheflush.h
>> +++ b/arch/nios2/include/asm/cacheflush.h
>> @@ -48,5 +48,9 @@ extern void invalidate_dcache_range(unsigned long sta=
rt, unsigned long end);
>>
>> =C2=A0 #define flush_dcache_mmap_lock(mapping)=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 xa_lock_irq(&mapping->i_pages)
>> =C2=A0 #define flush_dcache_mmap_unlock(mapping)=C2=A0=C2=A0=C2=A0 xa_u=
nlock_irq(&mapping->i_pages)
>> +#define flush_dcache_mmap_lock_irqsave(mapping, flags)=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xa_lock_irqsave(&mapping->i=
_pages, flags)
>> +#define flush_dcache_mmap_unlock_irqrestore(mapping, flags)=C2=A0=C2=
=A0=C2=A0 \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xa_unlock_irqrestore(&mappi=
ng->i_pages, flags)
>>
>> =C2=A0 #endif /* _ASM_NIOS2_CACHEFLUSH_H */
>> diff --git a/arch/nios2/mm/cacheflush.c b/arch/nios2/mm/cacheflush.c
>> index 6aa9257c3ede..35f3b599187f 100644
>> --- a/arch/nios2/mm/cacheflush.c
>> +++ b/arch/nios2/mm/cacheflush.c
>> @@ -75,11 +75,12 @@ static void flush_aliases(struct address_space *map=
ping, struct page *page)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct mm_struct *mm =3D current->active=
_mm;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct vm_area_struct *mpnt;
>> +=C2=A0=C2=A0=C2=A0 unsigned long flags;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pgoff_t pgoff;
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pgoff =3D page->index;
>>
>> -=C2=A0=C2=A0=C2=A0 flush_dcache_mmap_lock(mapping);
>> +=C2=A0=C2=A0=C2=A0 flush_dcache_mmap_lock_irqsave(mapping, flags);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vma_interval_tree_foreach(mpnt, &mapping=
->i_mmap, pgoff, pgoff) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long of=
fset;
>>
>> @@ -92,7 +93,7 @@ static void flush_aliases(struct address_space *mappi=
ng, struct page *page)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 flush_cache_page=
(mpnt, mpnt->vm_start + offset,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 page_to_pfn(page));
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> -=C2=A0=C2=A0=C2=A0 flush_dcache_mmap_unlock(mapping);
>> +=C2=A0=C2=A0=C2=A0 flush_dcache_mmap_unlock_irqrestore(mapping, flags)=
;
>> =C2=A0 }
>>
>> =C2=A0 void flush_cache_all(void)
>> --
>> 2.38.1
>>

