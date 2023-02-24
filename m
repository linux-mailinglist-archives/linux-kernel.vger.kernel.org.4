Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF33D6A1C2D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 13:32:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjBXMc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 07:32:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjBXMcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 07:32:24 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9482664E0E;
        Fri, 24 Feb 2023 04:32:22 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: lina@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id C34F441A42;
        Fri, 24 Feb 2023 12:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1677241940;
        bh=WbHKzmA/CGBikeu9gnrsWFqdgDb2gl7mzdzdF/0SXoE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=BlERoB625oIXQaoR/mBHMYl0u/f4ni6sUkOhc1aBaX2jbL1V0k10w1b0YkKkdprDH
         wOQqUr8+8DMKDB8zLYgG/Nx9S6Da8VhYNqD14Bkp0BgXe1hsukc1l+tgtibrRVeTLI
         W2tVyYMz/ocir1jQ19vG3eRncZPUBCQS7g0gYdvhUYS19/TdCcHFAzMuCuqLJEp1DF
         B9jrm2JfDauHu8ONBMD+oEa8UqEjz/b27WCat/RWx4k8Lq9cVhCyRwZV2R+VOZ7axN
         moKT3KaRsmSvoMNRIOJXdtZMs93GsN+nDARhrORQgHfn2ird62EuY+vsFdknRj85+K
         4eTdJ3TOJF9Fw==
Message-ID: <d48d2634-408c-9ba9-2d2f-5c9629656c2e@asahilina.net>
Date:   Fri, 24 Feb 2023 21:32:15 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] rust: xarray: Add an abstraction for XArray
Content-Language: en-US
To:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Neal Gompa <neal@gompa.dev>, linux-kernel@vger.kernel.org,
        rust-for-linux@vger.kernel.org, asahi@lists.linux.dev
References: <20230224-rust-xarray-v1-1-80f0904ce5d3@asahilina.net>
From:   Asahi Lina <lina@asahilina.net>
In-Reply-To: <20230224-rust-xarray-v1-1-80f0904ce5d3@asahilina.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/02/2023 20.44, Asahi Lina wrote:
> The XArray is an abstract data type which behaves like a very large
> array of pointers. Add a Rust abstraction for this data type.
> 
> The initial implementation uses explicit locking on get operations and
> returns a guard which blocks mutation, ensuring that the referenced
> object remains alive. To avoid excessive serialization, users are
> expected to use an inner type that can be efficiently cloned (such as
> Arc<T>), and eagerly clone and drop the guard to unblock other users
> after a lookup.
> 
> Future variants may support using RCU instead to avoid mutex locking.
> 
> This abstraction also introduces a reservation mechanism, which can be
> used by alloc-capable XArrays to reserve a free slot without immediately
> filling it, and then do so at a later time. If the reservation is
> dropped without being filled, the slot is freed again for other users,
> which eliminates the need for explicit cleanup code.
> 
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> ---

I forgot to mention this depends on the Error series [1]. Sorry about that!

[1]
https://lore.kernel.org/rust-for-linux/20230224-rust-error-v1-0-f8f9a9a87303@asahilina.net/T/#t

~~ Lina
