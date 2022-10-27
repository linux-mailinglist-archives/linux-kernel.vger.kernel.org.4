Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D86761036B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 22:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237203AbiJ0Uwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 16:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236658AbiJ0Uvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 16:51:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C5B261137
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 13:45:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 90F0F624E0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 20:44:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0051BC4FF0A;
        Thu, 27 Oct 2022 20:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1666903475;
        bh=eSie5cxyhFgYqzyXxlt/yaovtCT91qgoQ7QxhgbrCRA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cwgeAse8AScdR/vozj93GckLyLgrV217HBziNU9X3Uavagf8OmVJvdNpRYjIR979v
         fnLJGoonLANrwPU4fEb5qkH+t/YUNePk9kk0Z+X/FEgOhzr4fbbu1L+fqXjQeaSdjX
         ZbcDFIrWNEbpTq+AJVXaMoT+xObDtj+dad+lE5BI=
Date:   Thu, 27 Oct 2022 13:44:33 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     andrey.konovalov@linux.dev
Cc:     Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Florian Mayer <fmayer@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH] kasan: allow sampling page_alloc allocations for
 HW_TAGS
Message-Id: <20221027134433.61c0d75246cc68455ea6dfd2@linux-foundation.org>
In-Reply-To: <c124467c401e9d44dd35a36fdae1c48e4e505e9e.1666901317.git.andreyknvl@google.com>
References: <c124467c401e9d44dd35a36fdae1c48e4e505e9e.1666901317.git.andreyknvl@google.com>
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

On Thu, 27 Oct 2022 22:10:09 +0200 andrey.konovalov@linux.dev wrote:

> From: Andrey Konovalov <andreyknvl@google.com>
> 
> Add a new boot parameter called kasan.page_alloc.sample, which makes
> Hardware Tag-Based KASAN tag only every Nth page_alloc allocation.
> 
> As Hardware Tag-Based KASAN is intended to be used in production, its
> performance impact is crucial. As page_alloc allocations tend to be big,
> tagging and checking all such allocations introduces a significant
> slowdown in some testing scenarios. The new flag allows to alleviate
> that slowdown.
> 
> Enabling page_alloc sampling has a downside: KASAN will miss bad accesses
> to a page_alloc allocation that has not been tagged.
> 

The Documentation:

> --- a/Documentation/dev-tools/kasan.rst
> +++ b/Documentation/dev-tools/kasan.rst
> @@ -140,6 +140,10 @@ disabling KASAN altogether or controlling its features:
>  - ``kasan.vmalloc=off`` or ``=on`` disables or enables tagging of vmalloc
>    allocations (default: ``on``).
>  
> +- ``kasan.page_alloc.sample=<sampling frequency>`` makes KASAN tag only
> +  every Nth page_alloc allocation, where N is the value of the parameter
> +  (default: ``1``).
> +

explains what this does but not why it does it.

Let's tell people that this is here to mitigate the performance overhead.

And how is this performance impact observed?  The kernel just gets
overall slower?

If someone gets a KASAN report using this mitigation, should their next
step be to set kasan.page_alloc.sample back to 1 and rerun, in order to
get a more accurate report before reporting it upstream?  I'm thinking
"no"?

Finally, it would be helpful if the changelog were to give us some
sense of the magnitude of the impact with kasan.page_alloc.sample=1. 
Does the kernel get 3x slower?  50x?
