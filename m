Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82FC9740401
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 21:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbjF0Ta6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 15:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjF0Tav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 15:30:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF40019B5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 12:30:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4DB2F6120E
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 19:30:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A0C6C433C8;
        Tue, 27 Jun 2023 19:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1687894247;
        bh=qyL7k4x2MyCgP1gFHf5PfFyJg9/NSQ4dtkkM96Ww+3c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qRbNX/YF7zcQlP1FGxbD2rHq2rIsxYzfvJ9ST87O1hP+xSY00uHWo0IRMrwCC4XSM
         BjGafaZFLnMVCtW7D8y7MNFcB+k//AAkn2R822RwFhTfnuNnsPEHtWsOac5GVF8zI+
         z4n5yHU5tOF0quf+S+S0sHiZ+iKHEM5/8N1FvqyU=
Date:   Tue, 27 Jun 2023 12:30:46 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     <naoya.horiguchi@nec.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: memory-failure: fix unexpected return value in
 soft_offline_page()
Message-Id: <20230627123046.ef7e791208214bbfecd71e42@linux-foundation.org>
In-Reply-To: <20230627112808.1275241-1-linmiaohe@huawei.com>
References: <20230627112808.1275241-1-linmiaohe@huawei.com>
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

On Tue, 27 Jun 2023 19:28:08 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:

> When page_handle_poison() fails to handle the hugepage or free page in
> retry path, soft_offline_page() will return 0 while -EBUSY is expected
> in this case.

What are the user visible effects of the bug?

> Fixes: b94e02822deb ("mm,hwpoison: try to narrow window race for free pages")
>
> ...
>
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -2737,10 +2737,13 @@ int soft_offline_page(unsigned long pfn, int flags)
>  	if (ret > 0) {
>  		ret = soft_offline_in_use_page(page);
>  	} else if (ret == 0) {
> -		if (!page_handle_poison(page, true, false) && try_again) {
> -			try_again = false;
> -			flags &= ~MF_COUNT_INCREASED;
> -			goto retry;
> +		if (!page_handle_poison(page, true, false)) {
> +			if (try_again) {
> +				try_again = false;
> +				flags &= ~MF_COUNT_INCREASED;
> +				goto retry;
> +			}
> +			ret = -EBUSY;
>  		}
>  	}
