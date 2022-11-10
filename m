Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBD95623819
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 01:23:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbiKJAX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 19:23:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbiKJAXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 19:23:54 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0240328E36
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 16:23:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 700F6CE2106
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 00:23:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 569C5C433C1;
        Thu, 10 Nov 2022 00:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1668039829;
        bh=nQjnhQ/Z6BeKWkSksU7eOI2J/OcBZ2ogxlcLcySNIBA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gRzQtlmk44B/pmF86iKIA9o/Qv1JY+RWFFmkj2JRd+FKDMWUz9Mt4AjcbxMbj1d79
         L4aXzi49ZdQRzLcXlOEooI+siTjXu0FsPDWlk/nbiiiZChPyBCwoD3dqRaDO4D1BO+
         c2bD4nTv7ohlrV8M5BWs53QVdSo8RBn5XwIHlN7s=
Date:   Wed, 9 Nov 2022 16:23:48 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Rong Tao <rtoax@foxmail.com>
Cc:     Rong Tao <rongtao@cestc.cn>, wuchi <wuchi.zero@gmail.com>,
        linux-kernel@vger.kernel.org (open list), linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] radix tree test suite: Fix uninitialized variable
 compilation warning
Message-Id: <20221109162348.3dbde3a7942c303af012276c@linux-foundation.org>
In-Reply-To: <tencent_DF74099967595DCEA93CBDC28D062026180A@qq.com>
References: <tencent_DF74099967595DCEA93CBDC28D062026180A@qq.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  9 Nov 2022 22:34:25 +0800 Rong Tao <rtoax@foxmail.com> wrote:

> [PATCH] radix tree test suite: Fix uninitialized variable compilation warning

This is not the test suite.

> We need to set an initial value for offset to eliminate compilation
> warning.
> 
> How to reproduce warning:
> 
> $ make -C tools/testing/radix-tree
> radix-tree.c: In function ‘radix_tree_tag_clear’:
> radix-tree.c:1046:17: warning: ‘offset’ may be used uninitialized in this function [-Wmaybe-uninitialized]
>  1046 |                 node_tag_clear(root, parent, tag, offset);
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> ...
>
> --- a/lib/radix-tree.c
> +++ b/lib/radix-tree.c
> @@ -1029,7 +1029,7 @@ void *radix_tree_tag_clear(struct radix_tree_root *root,
>  {
>  	struct radix_tree_node *node, *parent;
>  	unsigned long maxindex;
> -	int offset;
> +	int offset = 0;
>  
>  	radix_tree_load_root(root, &node, &maxindex);
>  	if (index > maxindex)

Are we sure this isn't actually a bug?  What happens if the tree is empty?
