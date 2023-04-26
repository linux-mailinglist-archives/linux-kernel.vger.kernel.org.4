Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCAC76EFDA6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 00:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240424AbjDZWta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 18:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240197AbjDZWt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 18:49:28 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1613D7
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 15:49:25 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Q6DZQ106hz4x5c;
        Thu, 27 Apr 2023 08:49:18 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1682549359;
        bh=9hSAAAKNZdoaKCo/vqVSwb9UYrU/fz0nvs4rfK4bbMs=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=K+NoNO4JJ70Ezbh3yN9FVpVO2zylLPQ++7YyOumIvLCa6LOGt9SHrbwhE4kKduC+l
         LkVuDoZLPJ99pUzfN+8PhhRasUbMxhGcCzByls1V1HIGCQijlG0w1zoed1iVHYLtHH
         mmC4U4i3ZiQsM1GAfaGcS1lEkZohWk5wcFA6Fzqhp0XzoZuVmPqO4WVe7xXVDKjlDK
         OD62pJ1AUEOHDniD21RNDWYihq2qLext6tmSnUWif7TlNOdXOf9bplHwsciRdwSEvy
         h8oVqqk1XD4xETjvQ5KZOanNC6qnxjEpZb3uQ1MdVGeb9OY9d4hWnqZaxUpDzb+cKO
         lh5cNNgP+H2ww==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
Cc:     Thomas =?utf-8?Q?Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: mainline build failure due to 322458c2bb1a ("drm/ttm: Reduce
 the number of used allocation orders for TTM pages")
In-Reply-To: <CAHk-=winmePW-RJdPEE031U=7z92aAv5TAnTU0bR74uEZOMb3Q@mail.gmail.com>
References: <ZEljCgVFnDl/C+l3@debian>
 <CAHk-=winmePW-RJdPEE031U=7z92aAv5TAnTU0bR74uEZOMb3Q@mail.gmail.com>
Date:   Thu, 27 Apr 2023 08:49:11 +1000
Message-ID: <871qk6z2c8.fsf@mail.concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:
> On Wed, Apr 26, 2023 at 10:44=E2=80=AFAM Sudip Mukherjee (Codethink)
> <sudipm.mukherjee@gmail.com> wrote:
>>
>> drivers/gpu/drm/ttm/ttm_pool.c:73:29: error: variably modified 'global_w=
rite_combined' at file scope
>>    73 | static struct ttm_pool_type global_write_combined[TTM_DIM_ORDER];
>>       |                             ^~~~~~~~~~~~~~~~~~~~~
>
> Ugh.
>
> This is because we have
>
>   #define TTM_DIM_ORDER (__TTM_DIM_ORDER <=3D MAX_ORDER ?
> __TTM_DIM_ORDER : MAX_ORDER)
>
> which looks perfectly fine as a constant ("pick the smaller of
> MAX_ORDER and __TTM_DIM_ORDER").
>
> But:
>
>   #define __TTM_DIM_ORDER (TTM_MAX_ORDER + 1)
>   #define TTM_MAX_ORDER (PMD_SHIFT - PAGE_SHIFT)
>
> which still _looks_ fine, but  on 64-bit powerpc, we then have
>
>    #define PTE_INDEX_SIZE  __pte_index_size
>
> so that __TTM_DIM_ORDER constant isn't actually a constant at all.
..
>
> It's a bit sad how that macro that _looks_ like a constant (and is one
> pretty much everywhere else) isn't actually constant on powerpc, but
> looking around it looks fairly unavoidable.

Yeah, it allows us to build a single kernel that can choose at runtime
whether it uses the HPT or Radix MMU. The page table geometry is
different between the MMUs because they support a different sized huge
page for THP.

cheers
