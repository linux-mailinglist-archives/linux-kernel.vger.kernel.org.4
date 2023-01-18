Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A72E672A40
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 22:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbjARVSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 16:18:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbjARVSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 16:18:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050052C65A
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 13:18:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ABE3FB81F0E
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 21:18:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42EBBC433D2;
        Wed, 18 Jan 2023 21:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1674076706;
        bh=vHeTPswFT6UGjKqMulF60/zXR5ZS1Aukp1xmbcZxG9M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DDOiIi8+wJ2qaoD3NYtfyOjfMxSNIRA4oPekbbjCFnzlhyhYUdFoTOmd7IzVSOLPb
         FUJDeKwLOB0ypAqlh/Z2OeThvAwjOtf4+A5q4cEIAJDATa/9945i//BMBK8hSftmt8
         anl1u+j8D1QJ5oifC5z0VevIp+gskhTlyPb9ZZ8M=
Date:   Wed, 18 Jan 2023 13:18:25 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/genalloc: use try_cmpxchg in {set,clear}_bits_ll
Message-Id: <20230118131825.c6daea81ea1e2dc6aa014f38@linux-foundation.org>
In-Reply-To: <20230118150703.4024-1-ubizjak@gmail.com>
References: <20230118150703.4024-1-ubizjak@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Jan 2023 16:07:03 +0100 Uros Bizjak <ubizjak@gmail.com> wrote:

> Use try_cmpxchg instead of cmpxchg (*ptr, old, new) == old in
> {set,clear}_bits_ll.  x86 CMPXCHG instruction returns success in ZF
> flag, so this change saves a compare after cmpxchg (and related move
> instruction in front of cmpxchg).
> 
> Also, try_cmpxchg implicitly assigns old *ptr value to "old"
> when cmpxchg fails.
> 
> Note that the value from *ptr should be read using READ_ONCE to prevent
> the compiler from merging, refetching or reordering the read.
> 
> The patch also declares these two functions inline, to ensure inlining.

But why is that better?  This adds a few hundred bytes more text, which
has a cost.

