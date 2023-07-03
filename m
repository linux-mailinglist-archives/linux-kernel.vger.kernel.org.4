Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9086746264
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 20:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbjGCSbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 14:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbjGCSbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 14:31:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66B9121;
        Mon,  3 Jul 2023 11:31:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 43EFC60FFA;
        Mon,  3 Jul 2023 18:31:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AA58C433C8;
        Mon,  3 Jul 2023 18:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688409068;
        bh=WFAyaT1zBQm/iWkDAeWv3kb/dymBVkbMfUBLGKdYW5s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BIqHRpak3i1WBkOOcQxmz4zZdBFnodO6CT37vQwO5m5E+wUrsVrXulKzpa/4z81PD
         skZl5ufsvgnuzsxzWOY80tKuIx2yNZH+G2KsmvAGu+SIKT0uEgxVftqsCU7JSpk/yh
         V5ICfyIS94uH0WzUDD2bK4J/+7GBLctk6Lcl6yf0=
Date:   Mon, 3 Jul 2023 20:31:06 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        songmuchun@bytedance.com, mike.kravetz@oracle.com,
        Ackerley Tng <ackerleytng@google.com>
Subject: Re: [PATCH 6.3.y] mm/hugetlb: revert use of page_cache_next_miss()
Message-ID: <2023070356-paddling-grip-b31a@gregkh>
References: <20230629211817.194786-1-sidhartha.kumar@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230629211817.194786-1-sidhartha.kumar@oracle.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2023 at 05:18:17PM -0400, Sidhartha Kumar wrote:
> commit fd4aed8d985a3236d0877ff6d0c80ad39d4ce81a upstream
> 
> Ackerley Tng reported an issue with hugetlbfs fallocate as noted in the
> Closes tag.  The issue showed up after the conversion of hugetlb page
> cache lookup code to use page_cache_next_miss.  User visible effects are:
> 
> - hugetlbfs fallocate incorrectly returns -EEXIST if pages are presnet
>   in the file.
> - hugetlb pages will not be included in core dumps if they need to be
>   brought in via GUP.
> - userfaultfd UFFDIO_COPY will not notice pages already present in the
>   cache.  It may try to allocate a new page and potentially return
>   ENOMEM as opposed to EEXIST.
> 
> Revert the use page_cache_next_miss() in hugetlb code.
> 
> The upstream fix[2] cannot be used used directly as the return value for
> filemap_get_folio() has been changed between 6.3 and upstream.
> 
> Closes: https://lore.kernel.org/linux-mm/cover.1683069252.git.ackerleytng@google.com
> Fixes: d0ce0e47b323 ("mm/hugetlb: convert hugetlb fault paths to use alloc_hugetlb_folio()")
> Cc: <stable@vger.kernel.org> #v6.3
> Reported-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> 
> [1] https://lore.kernel.org/linux-mm/cover.1683069252.git.ackerleytng@google.com/
> [2] https://lore.kernel.org/lkml/20230621230255.GD4155@monkey/
> ---
> 
>  fs/hugetlbfs/inode.c |  8 +++-----
>  mm/hugetlb.c         | 11 +++++------
>  2 files changed, 8 insertions(+), 11 deletions(-)

Now queued up, thanks.

greg k-h
