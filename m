Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20E866B6B7F
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 21:50:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbjCLUur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 16:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbjCLUuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 16:50:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C13301BD
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 13:50:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DFA6360F24
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 20:50:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18E20C433EF;
        Sun, 12 Mar 2023 20:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1678654208;
        bh=9LYsWqzzKgaDmQwv3KDskqOC/HJwLvXuguPk+Bof6rw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZdciYdaAnnGvdIKOMxL9QcZTE3yz7x5ChSV9HgxVnkq7PojcgSDQ3AqhGzaBiPkTX
         RC0gQjSmyEs0GwIYl1fU3oxZl3wdlfS8a3KW5ExsMH1hVTpE3o5yGmgxVAl7rQzYoZ
         8e2qrPjPTINZBwkJx1+rE/BE/8gW+qIaUMGFvncs=
Date:   Sun, 12 Mar 2023 13:50:07 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Naoya Horiguchi <naoya.horiguchi@nec.com>, <linux-mm@kvack.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: memory-failure: correct HWPOISON_INJECT config
Message-Id: <20230312135007.05a4fcea4d26c698a5d48b43@linux-foundation.org>
In-Reply-To: <20230310133843.76883-1-wangkefeng.wang@huawei.com>
References: <20230310133843.76883-1-wangkefeng.wang@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
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

On Fri, 10 Mar 2023 21:38:43 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:

> Use IS_ENABLED(CONFIG_HWPOISON_INJECT) to check whether or not to
> enable HWPoison injector module.

This is quite clear from the patch itself.  What is unclear is "why". 
Does it fix a build error?  If so, please describe and add a Fixes: if
appropriate.  Is it just a cleanup?  etcetera.

Thanks.

> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -168,7 +168,7 @@ static bool page_handle_poison(struct page *page, bool hugepage_or_freepage, boo
>  	return true;
>  }
>  
> -#if defined(CONFIG_HWPOISON_INJECT) || defined(CONFIG_HWPOISON_INJECT_MODULE)
> +#if IS_ENABLED(CONFIG_HWPOISON_INJECT)
>  
>  u32 hwpoison_filter_enable = 0;
>  u32 hwpoison_filter_dev_major = ~0U;
> -- 
> 2.35.3
