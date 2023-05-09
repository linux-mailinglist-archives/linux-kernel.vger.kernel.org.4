Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E23226FC168
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 10:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234925AbjEIILm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 04:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235073AbjEIILY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 04:11:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E59561BF;
        Tue,  9 May 2023 01:11:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E72F644F2;
        Tue,  9 May 2023 08:10:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04613C433EF;
        Tue,  9 May 2023 08:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683619858;
        bh=WXMC7u/DQzxADg0YM9i8LeJYiu5SJNEj74paM0J7l50=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kj5o24cUk7Fa6tWkPQ+fy3OzF18n7Rb3TJ3AknPltp0rmPFfRqJ0DZsguxTC1cZtb
         ir8aVE+Miud7+m014RyDeZeQFlsx1u9ddcOTB1rMprGWG02iQf8RgcJPujrpbAwJvz
         9ONuXZtFnKT9NtoKpbzt8c6/AW0RiUNadhQVfg2U9UqSZoMlvKXLGegWtIBdBjTBqm
         11k8jlRXmdgDQD0v2dsmAw1u1gcT0LoyiwwmW41d51MPriwGHVqkbMaGRjuHjc1jTG
         1+3EB47ENNLW4fJkSzXHutMml0UCCrKg/aXyFg2REz5YJgW99/3BkmMhZ8l+X7lYGW
         LuCAHd1Z19YlQ==
Date:   Tue, 9 May 2023 11:10:54 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: skbuff: remove special handling for SLOB
Message-ID: <20230509081054.GH38143@unreal>
References: <20230509071207.28942-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230509071207.28942-1-lukas.bulwahn@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2023 at 09:12:07AM +0200, Lukas Bulwahn wrote:
> Commit c9929f0e344a ("mm/slob: remove CONFIG_SLOB") removes CONFIG_SLOB.
> Now, we can also remove special handling for socket buffers with the SLOB
> allocator. The code with HAVE_SKB_SMALL_HEAD_CACHE=1 is now the default
> behavior for all allocators.
> 
> Remove an unnecessary distinction between SLOB and SLAB/SLUB allocator
> after the SLOB allocator is gone.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
>  net/core/skbuff.c | 17 -----------------
>  1 file changed, 17 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
