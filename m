Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6EBE695142
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 21:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjBMUBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 15:01:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjBMUBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 15:01:13 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8757017176
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 12:01:12 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id z1so14688542plg.6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 12:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w/ylDHJlU1BFl20coGEiz1808doT/68HrQMyJm0KLIY=;
        b=pXRJHdDi1FBiTWcyaGAee5cATMQnJvUp3NbKoj+XlSja5seq3XzvjkeO0qeYppE1ui
         eZqKh0rOjjZEQSLvUv8oKMnsHLkM0WawTpLFFV8ZjaYqLpcb7HfIyJEexzh3hbeXl0Dn
         LuyZZUw6nIzFtxuSfFJVUUARRsFc12DuBqH6rNcEGnD4IoX+o9EfThkdZ2JebFH3gYmP
         CRW+PqwqyV+XkvO5FV4DXIhtX9Aq3cAqJdHEU3UXPX7BgDeRTH4Lv7UZm4sDVHm63ZSq
         xiYbHdEu1+BAZbxQrB8ADcvkUUhOEbtmP542VDbIDL5c+PWelWzPOKXIdP7iUQMfVTdI
         GDBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w/ylDHJlU1BFl20coGEiz1808doT/68HrQMyJm0KLIY=;
        b=J9M6SAIt5K46+l0xuFYnooaowRi65XTWpUeQSaJMU0uaVaJIGa6nd4OFWH4ta/MFjh
         hvc322gZTD+vVaHLgO5AJ/FmnkhSR7YyDnpJxYtXyfF0ZcLlgI1j83QjwiYxYqpcuOSG
         AQw+7WpVBZK+4VUeWnbdxC0zVul7IjBlbjMwR7T+XmBfC/Usjr0jnDnM1y+ALFIMSWmV
         kYKZIx3fBVeOtWKhp2ho2yqBY8DdUUMio/GXJDKNm7BzZ9ZDQvJFgn/6RgHbtp7WYxuF
         rd+pj7hl7C+E5No7eCZs0KmyjeRCIJLUKPefMT5uKhbcwUsYTnUpIj4U+WTPbnUoxjmw
         Doew==
X-Gm-Message-State: AO0yUKV1GceaGfpeWl1UpwbybZP+lQRX/g7TH4eayaf3h8AuhgnR5xpd
        B9wbitn+nWXRYY05EG4NSTOPug==
X-Google-Smtp-Source: AK7set+IUYie8T4ysBZbfM8RDgBJuy1q7vvaVvTl80/SQVMK6LuRzrIIVld8uHAf7Br81bxAQGwapw==
X-Received: by 2002:a17:902:f304:b0:19a:85a7:dcb9 with SMTP id c4-20020a170902f30400b0019a85a7dcb9mr114129ple.2.1676318471954;
        Mon, 13 Feb 2023 12:01:11 -0800 (PST)
Received: from debug.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id t23-20020a170902b21700b00196047fc25dsm8630945plr.42.2023.02.13.12.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 12:01:11 -0800 (PST)
Date:   Mon, 13 Feb 2023 12:01:09 -0800
From:   Deepak Gupta <debug@rivosinc.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Subject: Re: [PATCH v1 RFC Zisslpcfi 11/20] mmu: maybe_mkwrite updated to
 manufacture shadow stack PTEs
Message-ID: <20230213200109.GA4016181@debug.ba.rivosinc.com>
References: <20230213045351.3945824-1-debug@rivosinc.com>
 <20230213045351.3945824-12-debug@rivosinc.com>
 <2d6eefb8-c7c5-7d32-9a75-ae716f828cd9@redhat.com>
 <20230213143754.GC3943238@debug.ba.rivosinc.com>
 <7693247c-a55d-a375-3621-1b07115a9d99@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <7693247c-a55d-a375-3621-1b07115a9d99@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 03:56:22PM +0100, David Hildenbrand wrote:
>On 13.02.23 15:37, Deepak Gupta wrote:
>>On Mon, Feb 13, 2023 at 01:05:16PM +0100, David Hildenbrand wrote:
>>>On 13.02.23 05:53, Deepak Gupta wrote:
>>>>maybe_mkwrite creates PTEs with WRITE encodings for underlying arch if
>>>>VM_WRITE is turned on in vma->vm_flags. Shadow stack memory is a write-
>>>>able memory except it can only be written by certain specific
>>>>instructions. This patch allows maybe_mkwrite to create shadow stack PTEs
>>>>if vma is shadow stack VMA. Each arch can define which combination of VMA
>>>>flags means a shadow stack.
>>>>
>>>>Additionally pte_mkshdwstk must be provided by arch specific PTE
>>>>construction headers to create shadow stack PTEs. (in arch specific
>>>>pgtable.h).
>>>>
>>>>This patch provides dummy/stub pte_mkshdwstk if CONFIG_USER_SHADOW_STACK
>>>>is not selected.
>>>>
>>>>Signed-off-by: Deepak Gupta <debug@rivosinc.com>
>>>>---
>>>>  include/linux/mm.h      | 23 +++++++++++++++++++++--
>>>>  include/linux/pgtable.h |  4 ++++
>>>>  2 files changed, 25 insertions(+), 2 deletions(-)
>>>>
>>>>diff --git a/include/linux/mm.h b/include/linux/mm.h
>>>>index 8f857163ac89..a7705bc49bfe 100644
>>>>--- a/include/linux/mm.h
>>>>+++ b/include/linux/mm.h
>>>>@@ -1093,6 +1093,21 @@ static inline unsigned long thp_size(struct page *page)
>>>>  void free_compound_page(struct page *page);
>>>>  #ifdef CONFIG_MMU
>>>>+
>>>>+#ifdef CONFIG_USER_SHADOW_STACK
>>>>+bool arch_is_shadow_stack_vma(struct vm_area_struct *vma);
>>>>+#endif
>>>>+
>>>>+static inline bool
>>>>+is_shadow_stack_vma(struct vm_area_struct *vma)
>>>>+{
>>>>+#ifdef CONFIG_USER_SHADOW_STACK
>>>>+	return arch_is_shadow_stack_vma(vma);
>>>>+#else
>>>>+	return false;
>>>>+#endif
>>>>+}
>>>>+
>>>>  /*
>>>>   * Do pte_mkwrite, but only if the vma says VM_WRITE.  We do this when
>>>>   * servicing faults for write access.  In the normal case, do always want
>>>>@@ -1101,8 +1116,12 @@ void free_compound_page(struct page *page);
>>>>   */
>>>>  static inline pte_t maybe_mkwrite(pte_t pte, struct vm_area_struct *vma)
>>>>  {
>>>>-	if (likely(vma->vm_flags & VM_WRITE))
>>>>-		pte = pte_mkwrite(pte);
>>>>+	if (likely(vma->vm_flags & VM_WRITE)) {
>>>>+		if (unlikely(is_shadow_stack_vma(vma)))
>>>>+			pte = pte_mkshdwstk(pte);
>>>>+		else
>>>>+			pte = pte_mkwrite(pte);
>>>>+	}
>>>>  	return pte;
>>>
>>>Exactly what we are trying to avoid in the x86 approach right now.
>>>Please see the x86 series on details, we shouldn't try reinventing the
>>>wheel but finding a core-mm approach that fits multiple architectures.
>>>
>>>https://lkml.kernel.org/r/20230119212317.8324-1-rick.p.edgecombe@intel.com
>>
>>Thanks David for comment here. I looked at x86 approach. This patch
>>actually written in a way which is not re-inventing wheel and is following
>>a core-mm approach that fits multiple architectures.
>>
>>Change above checks `is_shadow_stack_vma` and if it returns true then only
>>it manufactures shadow stack pte else it'll make a regular writeable mapping.
>>
>>Now if we look at `is_shadow_stack_vma` implementation, it returns false if
>>`CONFIG_USER_SHADOW_STACK` is not defined. If `CONFIG_USER_SHADOW_STACK is
>>defined then it calls `arch_is_shadow_stack_vma` which should be implemented
>>by arch specific code. This allows each architecture to define their own vma
>>flag encodings for shadow stack (riscv chooses presence of only `VM_WRITE`
>>which is analogous to choosen PTE encodings on riscv W=1,R=0,X=0)
>>
>>Additionally pte_mkshdwstk will be nop if not implemented by architecture.
>>
>>Let me know if this make sense. If I am missing something here, let me know.
>
>See the discussion in that thread. The idea is to pass a VMA to 
>pte_mkwrite() and let it handle how to actually set it writable.
>

Thanks. I see. Instances where `pte_mkwrite` is directly invoked by checking
VM_WRITE and thus instead of fixing all those instance, make pte_mkwrite itself
take vma flag or vma.

I'll revise.
>-- 
>Thanks,
>
>David / dhildenb
>
