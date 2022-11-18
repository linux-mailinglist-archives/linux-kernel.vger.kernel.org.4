Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 951EC62FE9F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 21:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbiKRUQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 15:16:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiKRUQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 15:16:37 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C332EF27
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 12:16:36 -0800 (PST)
Received: from [192.168.10.28] (unknown [39.46.5.142])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 847C56602A03;
        Fri, 18 Nov 2022 20:16:31 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1668802594;
        bh=TSwxHSQBbkuzfXNvA6Zh6Vo8JX+fo2F06/ARbcL6rXs=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=k1J5LHCdWvwMWsDdLUDxxETULJBgP8mYDOZRVancMsCHtccJl4JqMtgOX1rw6slqa
         fvCCqYbxU2YfcdkE/bFAJ4R8kICQi5dRkS24i/m1pltx5BPT4STyJaj6CP3D/4URbx
         ggo+T7nON06FiwkspEtHXjnG/CInjMdsTmR/UXf1qNpauLRvu7scWEhyQiCnkPtkcH
         fcO1Y6QCZP1F3TejpypgmN0N61vo19xWFzX5V7X5+dwUnAvO+ieu5LJsCwkI6Cxnyi
         s1pSg6PIBb/5AFXyukQsYVLijxqY/R+SPS2EwBtnI8PXpdjUDDu5xI8QfIJGM+1Fg8
         lRfYQpnNk+vMQ==
Message-ID: <b75653b8-5264-ca03-bf5c-671e07e7fdd8@collabora.com>
Date:   Sat, 19 Nov 2022 01:16:26 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 1/3] mm/mprotect: Fix soft-dirty check in
 can_change_pte_writable()
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>
References: <20220725142048.30450-1-peterx@redhat.com>
 <20220725142048.30450-2-peterx@redhat.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20220725142048.30450-2-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter and David,

On 7/25/22 7:20 PM, Peter Xu wrote:
> The check wanted to make sure when soft-dirty tracking is enabled we won't
> grant write bit by accident, as a page fault is needed for dirty tracking.
> The intention is correct but we didn't check it right because VM_SOFTDIRTY
> set actually means soft-dirty tracking disabled.  Fix it.
[...]
> +static inline bool vma_soft_dirty_enabled(struct vm_area_struct *vma)
> +{
> +	/*
> +	 * NOTE: we must check this before VM_SOFTDIRTY on soft-dirty
> +	 * enablements, because when without soft-dirty being compiled in,
> +	 * VM_SOFTDIRTY is defined as 0x0, then !(vm_flags & VM_SOFTDIRTY)
> +	 * will be constantly true.
> +	 */
> +	if (!IS_ENABLED(CONFIG_MEM_SOFT_DIRTY))
> +		return false;
> +
> +	/*
> +	 * Soft-dirty is kind of special: its tracking is enabled when the
> +	 * vma flags not set.
> +	 */
> +	return !(vma->vm_flags & VM_SOFTDIRTY);
> +}
I'm sorry. I'm unable to understand the inversion here.
> its tracking is enabled when the vma flags not set.
VM_SOFTDIRTY is set on the VMA when new VMA is allocated to mark is
soft-dirty. When we write to clear_refs to clear soft-dirty bit,
VM_SOFTDIRTY is cleared from the VMA as well. Then why do you say tracking
is enabled when the vma flags not set? I'm missing some obvious thing.
Maybe the meaning of tracking is to see if VM_SOFTDIRTY needs to be set. If
VM_SOFTDIRTY is already set, tracking isn't needed. Can you give an example
here?

-- 
BR,
Muhammad Usama Anjum
