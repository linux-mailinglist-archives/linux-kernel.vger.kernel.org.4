Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 028FD71707D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 00:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233657AbjE3WNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 18:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233631AbjE3WNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 18:13:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9284EE5
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 15:13:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2DBD162C1D
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 22:13:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72B27C433D2;
        Tue, 30 May 2023 22:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1685484787;
        bh=y0tk1LhfJUoWojH29xQgBQAHyyiXOdXW+PIeggjfJ4M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GMqZ3gNKQSHgrxIW3VQKnJ3POD/m4f3LfkDLMUO9uTzwJ4TFhEJJnDfXfootzO017
         PmgfE18SeCrd+MYkrstOTSn1rsgn/s6pf+LFlnoj3xWdvKFFDtmfjBN3T+SjWdns/W
         nA8n1goiD5ektUFw7ElFB9J6q0dow8tBCGBAxK1w=
Date:   Tue, 30 May 2023 15:13:06 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: page_alloc: remove unneeded header files
Message-Id: <20230530151306.b9f24b247c66ea7f80df6be8@linux-foundation.org>
In-Reply-To: <20230527100728.267992-1-linmiaohe@huawei.com>
References: <20230527100728.267992-1-linmiaohe@huawei.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 May 2023 18:07:28 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:

> Remove some unneeded header files. No functional change intended.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/page_alloc.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index e671c747892f..beb6db613238 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -24,9 +24,7 @@
>  #include <linux/kernel.h>
>  #include <linux/kasan.h>
>  #include <linux/kmsan.h>
> -#include <linux/module.h>

This contains the prototype for print_modules().  So we're now reliant
upon module.h being included via some other header, which is fragile.

>  #include <linux/suspend.h>
> -#include <linux/pagevec.h>
>  #include <linux/ratelimit.h>
>  #include <linux/oom.h>
>  #include <linux/topology.h>
> @@ -36,8 +34,6 @@
>  #include <linux/memory_hotplug.h>
>  #include <linux/nodemask.h>
>  #include <linux/vmstat.h>
> -#include <linux/sort.h>
> -#include <linux/pfn.h>
>  #include <linux/fault-inject.h>
>  #include <linux/compaction.h>
>  #include <trace/events/kmem.h>
> @@ -52,11 +48,9 @@
>  #include <linux/memcontrol.h>
>  #include <linux/ftrace.h>
>  #include <linux/lockdep.h>
> -#include <linux/nmi.h>
>  #include <linux/psi.h>
>  #include <linux/khugepaged.h>
>  #include <linux/delayacct.h>
> -#include <asm/div64.h>

Needed for do_div()?

>  #include "internal.h"
>  #include "shuffle.h"
>  #include "page_reporting.h"
> -- 
> 2.27.0
