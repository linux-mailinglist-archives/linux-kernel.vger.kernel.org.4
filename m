Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43DB06A8F04
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 02:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjCCB5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 20:57:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjCCB5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 20:57:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD662734
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 17:57:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A94C7616EF
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 01:57:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C18C2C433D2;
        Fri,  3 Mar 2023 01:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1677808655;
        bh=8nCh8U5O/ZXKVmZDEcs6WxwzpGVNHClVBgr7qeBYLZo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AbMZvzyFq3YIQxOLWlCrcVKKv2q9ooVq+0R/X8C13HjYid7pOqd9s8B7t9MCgSMEn
         2cfntWoQB1s4un4Dep+dzyBa0rfVFTIIAVYRMA76AavkmjoCSnXr55dxbOZvT8nlSF
         +kMpR90gnarYX+OKvSW/5j8V2T5BonVUh7g57JTQ=
Date:   Thu, 2 Mar 2023 17:57:34 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Jerome Glisse <jglisse@redhat.com>, Shaohua Li <shli@fb.com>
Subject: Re: [PATCH v1] mm/userfaultfd: propagate uffd-wp bit when
 PTE-mapping the huge zeropage
Message-Id: <20230302175734.7be9da18e4724720a12a4b40@linux-foundation.org>
In-Reply-To: <20230302175423.589164-1-david@redhat.com>
References: <20230302175423.589164-1-david@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  2 Mar 2023 18:54:23 +0100 David Hildenbrand <david@redhat.com> wrote:

> Currently, we'd lose the userfaultfd-wp marker when PTE-mapping a huge
> zeropage, resulting in the next write faults in the PMD range
> not triggering uffd-wp events.
> 
> Various actions (partial MADV_DONTNEED, partial mremap, partial munmap,
> partial mprotect) could trigger this. However, most importantly,
> un-protecting a single sub-page from the userfaultfd-wp handler when
> processing a uffd-wp event will PTE-map the shared huge zeropage and
> lose the uffd-wp bit for the remainder of the PMD.
> 
> Let's properly propagate the uffd-wp bit to the PMDs.
> 
> ...
>
> Fixes: e06f1e1dd499 ("userfaultfd: wp: enabled write protection in userfaultfd API")
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Jerome Glisse <jglisse@redhat.com>
> Cc: Shaohua Li <shli@fb.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Do you agree that a -stable backport is appropriate?
