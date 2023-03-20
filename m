Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51CCB6C23B4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 22:31:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbjCTVbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 17:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbjCTVba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 17:31:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762C430B3C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 14:30:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 52E4260FCD
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 21:29:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54EAFC433D2;
        Mon, 20 Mar 2023 21:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1679347795;
        bh=xye89Jo0Go8cey4g9/6Jk9Xa2r3IpjAoyg0qZdZdGVo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qmJ2xFhNLK+5qz/Untp24587hIyM5BUWFN7+XOzM4SYdJovYOmvfBopCxrtdVwIwQ
         So4yAFC0qRTMCYs80jd0YOkMq6EnkPK/mlHgrWY0PUnzw9Qxv80ghfx7lKP7KKigxb
         ZZloLRRwPNWPBZn7vwU3G8N05xVQvsFG/yaf8yYU=
Date:   Mon, 20 Mar 2023 14:29:54 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     glider@google.com, elver@google.com, dvyukov@google.com,
        sjpark@amazon.de, jannh@google.com, muchun.song@linux.dev,
        roman.gushchin@linux.dev, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: kfence: fix PG_slab and memcg_data clearing
Message-Id: <20230320142954.fd314c5e46c1d18887ccf8cc@linux-foundation.org>
In-Reply-To: <20230320030059.20189-1-songmuchun@bytedance.com>
References: <20230320030059.20189-1-songmuchun@bytedance.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Mar 2023 11:00:59 +0800 Muchun Song <songmuchun@bytedance.com> wrote:

> It does not reset PG_slab and memcg_data when KFENCE fails to initialize
> kfence pool at runtime. It is reporting a "Bad page state" message when
> kfence pool is freed to buddy. The checking of whether it is a compound
> head page seems unnecessary sicne we already guarantee this when allocating
> kfence pool, removing the check to simplify the code.
> 
> Fixes: 0ce20dd84089 ("mm: add Kernel Electric-Fence infrastructure")
> Fixes: 8f0b36497303 ("mm: kfence: fix objcgs vector allocation")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

I'm not sure how the -stable maintainers are to handle two Fixes: tags.
Can we narrow it down to one please?  I assume 8f0b36497303 triggered
the bad_page() warning?

