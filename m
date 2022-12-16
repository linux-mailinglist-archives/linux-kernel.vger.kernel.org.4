Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD2B64F153
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 20:01:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbiLPTBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 14:01:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiLPTBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 14:01:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7A24F662
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 11:01:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F3EB9B8136A
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 19:01:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78CD0C433EF;
        Fri, 16 Dec 2022 19:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1671217300;
        bh=7DPRT0lvHrvQfKmUAwIVk2AORoB5ghy+f1Eolq71vYQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AHlKMqWE4RkGY9kg46mgGCSOAbVuA+HEFpkLCB7Lz8OY3Yt2ylDwmG1doZQ0UWyph
         XxSR9bRCKu6ic63gtny61f7E8PB5n7Gv4KMdtTjmM/dXU8PDC9jOlxoC7IrAsnUpBP
         UsuTYlNz+uOUQd1ka/zk6G1xe9Um6bjqrXOCyiJo=
Date:   Fri, 16 Dec 2022 11:01:39 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        Andrei Vagin <avagin@gmail.com>,
        "usama.anjum@collabora.com" <usama.anjum@collabora.com>,
        Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH] maple_tree: Fix mas_spanning_rebalance() on
 insufficient data
Message-Id: <20221216110139.fe9b0cc2951014e1856d0042@linux-foundation.org>
In-Reply-To: <20221216185233.2036415-1-Liam.Howlett@oracle.com>
References: <20221216185233.2036415-1-Liam.Howlett@oracle.com>
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

On Fri, 16 Dec 2022 18:53:15 +0000 Liam Howlett <liam.howlett@oracle.com> wrote:

> Mike Rapoport contacted me off-list with a regression in running criu.
> Periodic tests fail with an RCU stall during execution.  Although rare,
> it is possible to hit this with other uses so this patch should be
> backported to fix the regression.
> 
> An insufficient node was causing an out-of-bounds access on the node in
> mas_leaf_max_gap().  The cause was the faulty detection of the new node
> being a root node when overwriting many entries at the end of the tree.
> 
> Fix the detection of a new root and ensure there is sufficient data
> prior to entering the spanning rebalance loop.
> 
> Add a testcase to the maple tree test suite for this issue.

Shall do.

> Cc: Andrei Vagin <avagin@gmail.com>
> Cc: usama.anjum@collabora.com
> Reported-by: Mike Rapoport <rppt@kernel.org>
> Fixes: 54a611b60590 ("Maple Tree: add new data structure")
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>

I guess we want a cc:stable there?

>  lib/test_maple_tree.c | 23 +++++++++++++++++++++++

Belated review: all this code runs at __init time, so every dang
function in there really should be marked __init, data marked
__initdata, etc.  Like lib/test_bitmap.c.

I wonder if there's some trick we can do external to the .c file to
have the same effect.

Also, maple_tree_seed():set[] could be static ;).  So we don't have to
initialize it at runtime.  Better would be static const.  Nitpick.


