Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5CB628EBD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 01:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237456AbiKOAyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 19:54:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237448AbiKOAys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 19:54:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27A11C419
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 16:54:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 65B59B8163C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 00:54:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5AFCC433D6;
        Tue, 15 Nov 2022 00:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1668473685;
        bh=YuNm5aVH1KCch4Kn/nxOuMib3rfYJErbQ8eXFx1Dr+k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pqdhGMePYNC1UM0DUE1MAes0ZKL7YihtfdIzKjt+Vcuy0IGPG8khY9rLlTDZ4muv2
         bTcfhHx9Unw3QGtlD5DhnyZFe5gt4ydcPLQskKEiutn7+FQr6cta9YbiFFg9hw+3l4
         403F9/PZwX9squyObVXkcicDDk/uG6R2Pp9aoKd8=
Date:   Mon, 14 Nov 2022 16:54:43 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Zhang Qiang1 <qiang1.zhang@intel.com>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: Re: [PATCH] mm/vmalloc: allow mem_dump_obj() to be called in
 interrupt context
Message-Id: <20221114165443.98042d9244ee8899901df164@linux-foundation.org>
In-Reply-To: <20221112121537.1634-1-thunder.leizhen@huawei.com>
References: <20221112121537.1634-1-thunder.leizhen@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Nov 2022 20:15:37 +0800 Zhen Lei <thunder.leizhen@huawei.com> wrote:

> The function mem_dump_obj() can sometimes provide valuable debugging
> information, but it cannot be called in an interrupt context because
> spinlock vmap_area_lock has not been protected against IRQs. If the
> current task has held the lock before hard/soft interrupt handler calls
> mem_dump_obj(), simply abandoning the dump operation can avoid deadlock.
> That is, no deadlock occurs in extreme cases, and dump succeeds in most
> cases.
> 
> ...
>
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -4034,6 +4034,9 @@ bool vmalloc_dump_obj(void *object)
>  	struct vm_struct *vm;
>  	void *objp = (void *)PAGE_ALIGN((unsigned long)object);
>  
> +	if (unlikely(spin_is_locked(&vmap_area_lock)))
> +		return false;
> +
>  	vm = find_vm_area(objp);
>  	if (!vm)
>  		return false;

Yes, but this will worsen the current uses of this function.  Consider
the case where task A wants to call vmalloc_dump_obj() but task B holds
vmap_area_lock.  No problem, task A will simply spin until task B is
done.

But after this patch, task A's call to vmalloc_dump_obj() will return
without having done anything.

