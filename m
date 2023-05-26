Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 230A6712D95
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 21:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237371AbjEZTe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 15:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243609AbjEZTen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 15:34:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A88189
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 12:34:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 22E1F652FF
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 19:34:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2700BC433EF;
        Fri, 26 May 2023 19:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685129679;
        bh=0wIUbbcscAUBqw47efumjiTT+7DS3+Vtur3hdfNojAo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=A/8HIBZrrmAxGJRh9SaBBY8Qj0VUZwqkEnktkgclppGe22V8KtqflWm/GL54cNhhj
         wmIOMt3vUC0fsnYYGKXr+PhN5rtj3H2fEBXuaWJNKITJnzeDxd5zAs/xZ3E47bGIJ1
         kn/JNQKz5mJlTwurFvNmHGg4dIn+qGt1oNlQhLZCNs7tqrq49U8R+k3rsTwBEFJFjg
         Y+ZMXLZzlJcPcua0rSPGX3DEIhY1L+dW/FieEXXlqaFTZ1nA06mUu5jaNkFJ2LG95w
         BCEN9mn6LvRCNtrATuzeohvI5AwfZqg3Q9stimMjdUR47Ql7WD93MAaJZ1a1B/Zhx8
         cHb+ieJCrDQnA==
Date:   Fri, 26 May 2023 12:34:38 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Yunsheng Lin <linyunsheng@huawei.com>
Cc:     <davem@davemloft.net>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Eric Dumazet <edumazet@google.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH net] page_pool: fix inconsistency for
 page_pool_ring_[un]lock()
Message-ID: <20230526123438.3d3e7158@kernel.org>
In-Reply-To: <20230522031714.5089-1-linyunsheng@huawei.com>
References: <20230522031714.5089-1-linyunsheng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 May 2023 11:17:14 +0800 Yunsheng Lin wrote:
> page_pool_ring_[un]lock() use in_softirq() to decide which
> spin lock variant to use, and when they are called in the
> context with in_softirq() being false, spin_lock_bh() is
> called in page_pool_ring_lock() while spin_unlock() is
> called in page_pool_ring_unlock(), because spin_lock_bh()
> has disabled the softirq in page_pool_ring_lock(), which
> causes inconsistency for spin lock pair calling.
> 
> This patch fixes it by returning in_softirq state from
> page_pool_producer_lock(), and use it to decide which
> spin lock variant to use in page_pool_producer_unlock().
> 
> As pool->ring has both producer and consumer lock, so
> rename it to page_pool_producer_[un]lock() to reflect
> the actual usage. Also move them to page_pool.c as they
> are only used there, and remove the 'inline' as the
> compiler may have better idea to do inlining or not.
> 
> Fixes: 7886244736a4 ("net: page_pool: Add bulk support for ptr_ring")
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>

I just realized now while doing backports that the Fixes tag is
incorrect here. The correct Fixes tag is:

Fixes: 542bcea4be86 ("net: page_pool: use in_softirq() instead")

Before that we used in_serving_softirq() which was perfectly fine.
This explains the major mystery of how such a serious bug would survive
for 10+ releases... it didn't, it wasn't there :) It only came in 6.3.
We can't change the tag now but at least the universe makes sense again.
