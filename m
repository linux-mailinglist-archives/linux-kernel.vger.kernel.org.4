Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC42E696E06
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 20:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232531AbjBNTkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 14:40:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232284AbjBNTkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 14:40:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1D62CFF7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 11:40:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B7A6618A6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 19:40:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A6F9C433D2;
        Tue, 14 Feb 2023 19:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1676403616;
        bh=0LXw8JRUDtoPyyAboFWv208CWuieeyd4q3a7teZHquw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cp605a2Oj3lti83QtBZeb2dXcHH2XVW++5WVUtUa45Lzwbyb/rWLlgGh8WduACpdW
         leqoMvaYTETfFlU4dqEijCxp4unnzzOuq1p3+o4wnKsU4j/LTisjIamTNiJ5Cz+HS6
         bRyZdlWe3iVr8gzFzrSdZUs09rV8hv0OTnSHpVEo=
Date:   Tue, 14 Feb 2023 11:40:14 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev@googlegroups.com, Vernon Yang <vernon2gm@gmail.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [RFC] maple_tree: reduce stack usage with gcc-9 and
 earlier
Message-Id: <20230214114014.4ce0afb658fae97d81f32925@linux-foundation.org>
In-Reply-To: <20230214103030.1051950-1-arnd@kernel.org>
References: <20230214103030.1051950-1-arnd@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Feb 2023 11:30:24 +0100 Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> gcc-10 changed the way inlining works to be less aggressive, but
> older versions run into an oversized stack frame warning whenever
> CONFIG_KASAN_STACK is enabled, as that forces variables from
> inlined callees to be non-overlapping:
> 
> lib/maple_tree.c: In function 'mas_wr_bnode':
> lib/maple_tree.c:4320:1: error: the frame size of 1424 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]
> 
> Change the annotations on mas_store_b_node() and mas_commit_b_node()
> to explicitly forbid inlining in this configuration, which is
> the same behavior that newer versions already have.
> 
> ...
>
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -146,6 +146,13 @@ struct maple_subtree_state {
>  	struct maple_big_node *bn;
>  };
>  
> +#ifdef CONFIG_KASAN_STACK
> +/* Prevent mas_wr_bnode() from exceeding the stack frame limit */
> +#define noinline_for_kasan noinline_for_stack
> +#else
> +#define noinline_for_kasan inline
> +#endif

Should noinline_for_kasan be defined in kasan.h?  maple_tree.c is
unlikely to be the only place in the kernel which could use this
treatment?

I suppose we can do that when the need arises.
