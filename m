Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7925F6EBD28
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 07:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjDWFT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 01:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjDWFT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 01:19:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 628241FE3
        for <linux-kernel@vger.kernel.org>; Sat, 22 Apr 2023 22:19:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA8E8615E1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 05:19:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F285C433D2;
        Sun, 23 Apr 2023 05:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682227196;
        bh=3PDZm9BiZEEETNhdvASh02SE/wUksEg3iKZOOpAuxps=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KrK++LDYcJEMTpdahkeJfxFn85sgAPdxsExLG3PS5KUgk+iwQcXUUrYRH7RTjaMub
         BPqc8/dWd2YlXug6TtCX5tahqzhWtfKLe+uybSGE6/K2blhLO0ckfirVaAt+XcDUrG
         NdqHi1Ty4PaWSpeh29iisTpIH6FWx4t40w3LHtcRBvGDZ9lF92RmQzZfPb4u+Q76zt
         G/gZXlvVpm/1l61pchX1CgJ77r759YoGK/Of+JaXR4TRAJ5g2ljTntjvQuL4lE3K6l
         jr1Q4LgG47bH4299flYs6zj46LTlkJN1z52+KMMLmmaknme3YXqYIb8cc9Dw/ax+XM
         ifz/UcNEFsZlA==
Date:   Sun, 23 Apr 2023 08:19:43 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, ying.huang@intel.com,
        mgorman@techsingularity.net, vbabka@suse.cz, mhocko@suse.com,
        david@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm/page_alloc: add some comments to explain the
 possible hole in __pageblock_pfn_to_page()
Message-ID: <ZES/7+zfs0h+lg7y@kernel.org>
References: <c2eee65ecd15779721af85c9ff109a35345b52d4.1682158312.git.baolin.wang@linux.alibaba.com>
 <02defcbe9d7a797a2257e5f6a28ff7ea78e394e5.1682158312.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02defcbe9d7a797a2257e5f6a28ff7ea78e394e5.1682158312.git.baolin.wang@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Apr 22, 2023 at 06:15:18PM +0800, Baolin Wang wrote:
> Now the __pageblock_pfn_to_page() is used by set_zone_contiguous(), which
> checks whether the given zone contains holes, and uses pfn_to_online_page()
> to validate if the start pfn is online and valid, as well as using pfn_valid()
> to validate the end pfn.
> 
> However, though the start pfn of a pageblock is valid, it can not always
> guarantee the end pfn of the pageblock is also valid (may be holes) in some
> cases. For example, if the pageblock order is MAX_ORDER - 1, which will fall

Nit: in the current mm tree the default pageblock order is MAX_ORDER.

> into 2 sub-sections, and the end pfn of the pageblock may be hole even though
> the start pfn is online and valid.
> 
> This did not break anything until now, but the zone continuous is fragile
> in this possible scenario. So as previous discussion[1], it is better to
> add some comments to explain this possible issue in case there are some
> future pfn walkers that rely on this.
> 
> [1] https://lore.kernel.org/all/87r0sdsmr6.fsf@yhuang6-desk2.ccr.corp.intel.com/
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  mm/page_alloc.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 6457b64fe562..dc4005b32ae0 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1502,6 +1502,14 @@ void __free_pages_core(struct page *page, unsigned int order)
>   * interleaving within a single pageblock. It is therefore sufficient to check
>   * the first and last page of a pageblock and avoid checking each individual
>   * page in a pageblock.
> + *
> + * Note: if the start pfn of a pageblock is valid, but it can not always guarantee
> + * the end pfn of the pageblock is also valid (may be holes) in some cases. For
> + * example, if the pageblock order is MAX_ORDER - 1, which will fall into 2
> + * sub-sections, and the end pfn of the pageblock may be hole even though the
> + * start pfn is online and valid. This did not break anything until now, but be
> + * careful this possible issue when checking if the whole pfns are valid of a

careful about ...

> + * pageblock.
>   */
>  struct page *__pageblock_pfn_to_page(unsigned long start_pfn,
>  				     unsigned long end_pfn, struct zone *zone)
> -- 
> 2.27.0
> 
> 

-- 
Sincerely yours,
Mike.
