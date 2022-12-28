Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD36657796
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 15:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232747AbiL1OOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 09:14:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiL1OOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 09:14:21 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF3B9FFC
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 06:14:20 -0800 (PST)
Received: from [192.168.10.12] (unknown [39.45.24.179])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id EF0A96601F12;
        Wed, 28 Dec 2022 14:14:14 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1672236857;
        bh=mz8NzyzkbjYu2yLpQyz2BB2V5QZ0YMUvPPqxgxNxV5c=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=JMCNsn5TxeR9brY7LnaGMEeaKPLn6bspPpFQ4aSuZvnwTnecTxtl7FsZcPDq4YXON
         pfLDTvuxKhbrNH9FW3JUZJ9hIc5/unWs9t7ud8OSIfRgCVjIPpYEJXHP8iAS70CbNt
         yLMpLTMUCnbC3V9r/zDPExw8IypwmAyNGRR0pdqkwi3d9ox0lvvRx3p7xBfZX+oxog
         C1ffEubsut80Jcqq8qmFuIcmtpGIMH/qDrK89Zb6aMTdLABjfefHpwIVB1/YZKu3JC
         LrEI0KQ5tZqUn6rT0JevnUbElyhOfhO7BLJpt7KVouG0fEVHAl807hM/Lmd0jngpiX
         Ke71rZ4j7jajA==
Message-ID: <40cc5f89-fa10-e107-671e-84bdcf7a4430@collabora.com>
Date:   Wed, 28 Dec 2022 19:14:09 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel@collabora.com, Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Paul Gofman <pgofman@codeweavers.com>
Subject: Re: [PATCH v4 1/3] mm/mprotect: Fix soft-dirty check in
 can_change_pte_writable()
To:     Cyrill Gorcunov <gorcunov@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220725142048.30450-1-peterx@redhat.com>
 <20220725142048.30450-2-peterx@redhat.com>
 <b75653b8-5264-ca03-bf5c-671e07e7fdd8@collabora.com> <Y3gRy8pUiYWFGqcI@x1n>
 <a9984aa6-41bc-17c3-b564-87b997c0f2d0@collabora.com> <Y3vq18eTOE0e7I1+@x1n>
 <e3c26b56-5458-eb25-c753-fc4c058ba1b1@collabora.com>
Content-Language: en-US
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <e3c26b56-5458-eb25-c753-fc4c058ba1b1@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/19/22 5:19 PM, Muhammad Usama Anjum wrote:
> Addition of vma_soft_dirty_enabled() has tinkered with the soft-dirty PTE
> bit status setting. The internal behavior has changed. The test case was
> shared by David
> (https://lore.kernel.org/all/bfcae708-db21-04b4-0bbe-712badd03071@redhat.com/).
> The explanation is as following:
> 
> _Before_ addition of this patch(76aefad628aae),
> m = mmap(2 pages)
> clear_softdirty()
> mremap(m + pag_size)
> mprotect(READ)
> mprotect(READ | WRITE);
> memset(m)
> After memset(),
> 			PAGE-1		PAGE-2
> VM_SOFTDIRTY		set		set
> PTE softdirty flag	set		set
> /proc//pagemap view	set		set
> 
> 
> _After_ addition of this patch(76aefad628aae)
> m = mmap(2 pages)
> clear_softdirty()
> mremap(m + page_size)
> mprotect(READ)
> mprotect(READ | WRITE);
> memset(m)
> After memset(),
> 			PAGE-1		PAGE-2
> VM_SOFTDIRTY		set		set
> PTE softdirty flag	*not set*	set
> /proc//pagemap view	set		set
> 
> The user's point of view hasn't changed. But internally after this patch,
> the soft-dirty tracking in PTEs gets turn off if VM_SOFTDIRTY is set. The
> soft-dirty tracking in the PTEs shouldn't be just turned off when mprotect
> is used. Why? Because soft-dirty tracking in the PTEs is always enabled
> regardless of VM_SOFTDIRTY is set or not. Example:
> 
> m = mem(2 pages)
> At this point:
> 			PAGE-1		PAGE-2
> VM_SOFTDIRTY		set		set
> PTE softdirty flag	not set		not set
> /proc//pagemap view	set		set
> memset(m)
> At this point:
> 			PAGE-1		PAGE-2
> VM_SOFTDIRTY		set		set
> PTE softdirty flag	set		set
> /proc//pagemap view	set		set
> 
> This example proves that soft-dirty flag on the PTE is set regardless of
> the VM_SOFTDIRTY.

Hi Andrew and Cyrill,

Peter doesn't agree with me here that this change in behavior should be
reverted etc. Please comment.


-- 
BR,
Muhammad Usama Anjum
