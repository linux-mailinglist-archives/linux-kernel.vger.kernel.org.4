Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ADBD6F4A30
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 21:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjEBTP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 15:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjEBTP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 15:15:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7664D1BD4
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 12:15:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 122C962071
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 19:15:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F551C4339B;
        Tue,  2 May 2023 19:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1683054926;
        bh=r8WWjkIMJIaq0ut5/ios1bJTm+k1wBFfceoqsar6VsM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qg6+vslt/PZ2KiRJz8sltxAlarRY+0m4mwAxTUhOyxfJCF8bpSFxmxyYqETIAktFb
         aNnUkECRskkjEWWSWkjFdGtMxAJ6pVGIDqCP/oQ4YLLqsOLdzBam6uEZAUTYDaufve
         9ANJ2AMqCAFygybwaTV9MAomqhHeSE/IvEgJGM+w=
Date:   Tue, 2 May 2023 12:15:25 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm/mmap/vma_merge: always check invariants
Message-Id: <20230502121525.258f089cbed7e44c113f2d83@linux-foundation.org>
In-Reply-To: <df548a6ae3fa135eec3b446eb3dae8eb4227da97.1682885809.git.lstoakes@gmail.com>
References: <df548a6ae3fa135eec3b446eb3dae8eb4227da97.1682885809.git.lstoakes@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Apr 2023 21:19:17 +0100 Lorenzo Stoakes <lstoakes@gmail.com> wrote:

> We may still have inconsistent input parameters even if we choose not to
> merge and the vma_merge() invariant checks are useful for checking this
> with no production runtime cost (these are only relevant when
> CONFIG_DEBUG_VM is specified).
> 
> Therefore, perform these checks regardless of whether we merge.
> 
> This is relevant, as a recent issue (addressed in commit "mm/mempolicy:
> Correctly update prev when policy is equal on mbind") in the mbind logic
> was only picked up in the 6.2.y stable branch where these assertions are
> performed prior to determining mergeability.
> 
> Had this remained the same in mainline this issue may have been picked up
> faster, so moving forward let's always check them.
> 

I'll scoot this into 6.4-rc, given the recent problems in this area.

> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -960,17 +960,17 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>  		merge_next = true;
>  	}
>  
> +	/* Verify some invariant that must be enforced by the caller. */
> +	VM_WARN_ON(prev && addr <= prev->vm_start);
> +	VM_WARN_ON(curr && (addr != curr->vm_start || end > curr->vm_end));
> +	VM_WARN_ON(addr >= end);

Maybe converting to VM_WARN_ON_ONCE() would be kinder.


