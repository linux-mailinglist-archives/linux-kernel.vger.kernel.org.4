Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8579C6BDBBC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 23:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjCPWeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 18:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjCPWeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 18:34:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE976D301
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 15:33:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5FE5362139
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 22:33:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BB5EC433EF;
        Thu, 16 Mar 2023 22:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1679006035;
        bh=w4XOX2cU6kWPrGSypzqJwl9GB+zrKQD9lnQHI4Vl09k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fYPeQi0lFmGdWl4DBx4G6g2x06lt+UllisB6eaiCfgpDsIJaR6iuwkjfZ63XzfFWk
         XxN/v5bJKwA8EpKZoNo7q50Uk7mKzDgRu2e5slOMiHgJwYr1IAua+3Y2UyR6Gj8Tsa
         ee8XNhC4z2vWNbadrjRjy5CyyN6mgXHAgxfUmTWA=
Date:   Thu, 16 Mar 2023 15:33:54 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Marco Elver <elver@google.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH] kfence, kcsan: avoid passing -g for tests
Message-Id: <20230316153354.bc31b9583eae6a79a1789de0@linux-foundation.org>
In-Reply-To: <20230316155104.594662-1-elver@google.com>
References: <20230316155104.594662-1-elver@google.com>
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

On Thu, 16 Mar 2023 16:51:04 +0100 Marco Elver <elver@google.com> wrote:

> Nathan reported that when building with GNU as and a version of clang
> that defaults to DWARF5:
> 
>   $ make -skj"$(nproc)" ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu- \
> 			LLVM=1 LLVM_IAS=0 O=build \
> 			mrproper allmodconfig mm/kfence/kfence_test.o
>   /tmp/kfence_test-08a0a0.s: Assembler messages:
>   /tmp/kfence_test-08a0a0.s:14627: Error: non-constant .uleb128 is not supported
>   /tmp/kfence_test-08a0a0.s:14628: Error: non-constant .uleb128 is not supported
>   /tmp/kfence_test-08a0a0.s:14632: Error: non-constant .uleb128 is not supported
>   /tmp/kfence_test-08a0a0.s:14633: Error: non-constant .uleb128 is not supported
>   /tmp/kfence_test-08a0a0.s:14639: Error: non-constant .uleb128 is not supported
>   ...
> 
> This is because `-g` defaults to the compiler debug info default. If the
> assembler does not support some of the directives used, the above errors
> occur. To fix, remove the explicit passing of `-g`.
> 
> All these tests want is that stack traces print valid function names,
> and debug info is not required for that. I currently cannot recall why I
> added the explicit `-g`.

Does this need to be backported into earlier kernels?

If so, we'd need to do it as two patches, each with the relevant
Fixes:, which appear to be a146fed56f8 and bc8fbc5f30.

