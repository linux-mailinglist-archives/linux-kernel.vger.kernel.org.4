Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 447745BB34B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 22:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiIPUM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 16:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiIPUMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 16:12:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1EEBA158
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 13:12:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C5BF62D8A
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 20:12:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ED91C433C1;
        Fri, 16 Sep 2022 20:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1663359170;
        bh=L9/u85Ob/hu3MpUlIrHb1tJLfMBDTRMqxcF8INzzKE0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JaYP3IROe/rIGIpR8rGtKnuj9vmuD85fQAlt3pf7sHACVpzNIdg3eljoYzZqLBCYy
         mu2k5ByJFVcpLkndnQbeR06PEGZAiL4LwYLYxy1JBNeWfD0javfA4KcEACNAi6vscW
         paoh+6oFjS1L+dBYXrAj00S6ZmKlIuXywejcN6S8=
Date:   Fri, 16 Sep 2022 13:12:49 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Xin Hao <xhao@linux.alibaba.com>
Cc:     mike.kravetz@oracle.com, songmuchun@bytedance.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] mm/hugetlb: add is_resv_equal_free() func
Message-Id: <20220916131249.68d59133cdb0366e0831592b@linux-foundation.org>
In-Reply-To: <20220916064127.1904-1-xhao@linux.alibaba.com>
References: <20220916064127.1904-1-xhao@linux.alibaba.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Sep 2022 14:41:27 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:

> In hugetlb.c file, there are several places to compare the values of
> 'h->free_huge_pages' and 'h->resv_huge_pages', it looks a bit messy, so
> there add a new is_resv_equal_free() func to do these.
> 
> ...
>
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1191,6 +1191,11 @@ static struct page *dequeue_huge_page_nodemask(struct hstate *h, gfp_t gfp_mask,
>  	return NULL;
>  }
> 
> +static inline bool is_resv_equal_free(struct hstate *h)

I'm not sure that's a well chosen name.  A better name would reflect
the *meaning* of free_huge_pages being equal to resv_huge_pages.  Maybe
something like reserves_exhausted()?

This would all be clearer if we'd bothered to document the fields of
struct hstate :(


> +{
> +	return (h->free_huge_pages - h->resv_huge_pages == 0) ? true : false;

	return h->free_huge_pages == h->resv_huge_pages;

> +}

