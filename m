Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4403768EC2C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 10:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbjBHJwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 04:52:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbjBHJvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 04:51:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225753CE3B;
        Wed,  8 Feb 2023 01:51:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A97EDB81D1A;
        Wed,  8 Feb 2023 09:51:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4833C433D2;
        Wed,  8 Feb 2023 09:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675849885;
        bh=xE2QtHnNlY4p46ZdnYaxlkn6amrvbqwlWSdnNmpJ+Pk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FZl+W5DSpv4oPiT7JEccqxA+H6j7G50xyqSyHDub/Z0dz7a5WZCtRz48lF2pjzB19
         zS4YIqLJF+/zY1NYAeiD+TAprcmklnwUUF4mc/HotKIlYBoVezBJxI8a4Fd1GnOIis
         2uouv7czkXv/fUfI9lOTJpgYal6iAs5IqVCYXK35zjismd0R+0o+R75JzkWPHVFjxu
         x+2HFgCQxInj76sPUefS1+nuPx2+qd5O9lurQZxAIC+dla1SMcmKedawMZoE97viIn
         8gpNO9vlKAT5cTIEEIEet3lLi1ue8yRZBcK5Vmt9B/o004sUCpbuK1WHcvnf7AriNp
         X/PQab/8HT8Og==
Date:   Wed, 8 Feb 2023 11:51:12 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Usama Arif <usama.arif@bytedance.com>
Cc:     songmuchun@bytedance.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        fam.zheng@bytedance.com, liangma@liangbit.com
Subject: Re: [PATCH] docs: mm: Fix number of base pages for 1GB HugeTLB
Message-ID: <Y+NwkCsDnOBSCqVu@kernel.org>
References: <20230207114456.2304801-1-usama.arif@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230207114456.2304801-1-usama.arif@bytedance.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2023 at 11:44:56AM +0000, Usama Arif wrote:
> 1GB HugeTLB page consists of 262144 base pages.
> 
> Signed-off-by: Usama Arif <usama.arif@bytedance.com>

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  Documentation/mm/vmemmap_dedup.rst | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/mm/vmemmap_dedup.rst b/Documentation/mm/vmemmap_dedup.rst
> index a4b12ff906c4..689a6907c70b 100644
> --- a/Documentation/mm/vmemmap_dedup.rst
> +++ b/Documentation/mm/vmemmap_dedup.rst
> @@ -1,3 +1,4 @@
> +
>  .. SPDX-License-Identifier: GPL-2.0
>  
>  =========================================
> @@ -17,7 +18,7 @@ HugeTLB pages consist of multiple base page size pages and is supported by many
>  architectures. See Documentation/admin-guide/mm/hugetlbpage.rst for more
>  details. On the x86-64 architecture, HugeTLB pages of size 2MB and 1GB are
>  currently supported. Since the base page size on x86 is 4KB, a 2MB HugeTLB page
> -consists of 512 base pages and a 1GB HugeTLB page consists of 4096 base pages.
> +consists of 512 base pages and a 1GB HugeTLB page consists of 262144 base pages.
>  For each base page, there is a corresponding ``struct page``.
>  
>  Within the HugeTLB subsystem, only the first 4 ``struct page`` are used to
> -- 
> 2.25.1
> 

-- 
Sincerely yours,
Mike.
