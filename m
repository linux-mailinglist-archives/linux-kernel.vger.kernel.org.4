Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FCD95F1629
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 00:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbiI3Wbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 18:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiI3Wbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 18:31:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8363415D110
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 15:31:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 43128B82A76
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 22:31:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87849C433C1;
        Fri, 30 Sep 2022 22:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1664577096;
        bh=EkVrlHyTVHUTLwQT4CnvETp8bpncjOLRpYeapD2l0s4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pM0+nGgFgs0WV9gN28yx7k0+vLSSZRaTVneZS6x7pS0lpBtyXHt5fcsZbzYtljigx
         bEUBk+8XB2f6HgCfzVUsnxUQOaHV9LFgjoaOdp0bDfa5SA6RwF0PUvqqV/Kl8soxAP
         A7suUUihYOJHwJl41hkMVasX7RMKdpQ/lJVJ2Pd8=
Date:   Fri, 30 Sep 2022 15:31:35 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Qi Zheng <zhengqi.arch@bytedance.com>, maobibo@loongson.cn,
        chenhuacai@loongson.cn, songmuchun@bytedance.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        loongarch@lists.linux.dev, chris@zankel.net, jcmvbkbc@gmail.com
Subject: Re: [PATCH v3 1/2] mm: use update_mmu_tlb() on the second thread
Message-Id: <20220930153135.164240eadc71ddf94d8200fb@linux-foundation.org>
In-Reply-To: <673e494c-eb91-470a-026b-59e414d0916e@redhat.com>
References: <20220929112318.32393-1-zhengqi.arch@bytedance.com>
        <20220929112318.32393-2-zhengqi.arch@bytedance.com>
        <0fecbcdc-7324-2d76-8452-b60b4638d074@redhat.com>
        <32a53a8f-f6f8-6efc-a5f6-a004ffab8c99@bytedance.com>
        <673e494c-eb91-470a-026b-59e414d0916e@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Sep 2022 10:44:21 +0200 David Hildenbrand <david@redhat.com> wrote:

> > Oh, this is better. Hi Andrew, do I need to resend the v4?
> > 
> 
> I assume he can squash it, most probably no need to resend. :)


From: Qi Zheng <zhengqi.arch@bytedance.com>
Subject: mm: use update_mmu_tlb() on the second thread
Date: Thu, 29 Sep 2022 19:23:17 +0800

As message in commit 7df676974359 ("mm/memory.c: Update local TLB if PTE
entry exists") said, we should update local TLB only on the second thread.
So in the do_anonymous_page() here, we should use update_mmu_tlb()
instead of update_mmu_cache() on the second thread.

As David pointed out, this is a performance improvement, not a
correctness fix.

Link: https://lkml.kernel.org/r/20220929112318.32393-2-zhengqi.arch@bytedance.com
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: David Hildenbrand <david@redhat.com>
Cc: Bibo Mao <maobibo@loongson.cn>
Cc: Chris Zankel <chris@zankel.net>
Cc: Huacai Chen <chenhuacai@loongson.cn>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/memory.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/mm/memory.c~mm-use-update_mmu_tlb-on-the-second-thread
+++ a/mm/memory.c
@@ -4136,7 +4136,7 @@ static vm_fault_t do_anonymous_page(stru
 	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->address,
 			&vmf->ptl);
 	if (!pte_none(*vmf->pte)) {
-		update_mmu_cache(vma, vmf->address, vmf->pte);
+		update_mmu_tlb(vma, vmf->address, vmf->pte);
 		goto release;
 	}
 
_

