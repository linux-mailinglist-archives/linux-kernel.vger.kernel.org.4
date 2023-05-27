Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA79E7130F3
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 02:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237305AbjE0AuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 20:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjE0AuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 20:50:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F233D135
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 17:50:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 85EA9654B2
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 00:50:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2CF1C433D2;
        Sat, 27 May 2023 00:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685148604;
        bh=PctGZlrrzibp7UAnk07C/sOmUfyQ9mUKgJg38V2xuBU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=b5IVwgYRE/2EVTpq7191D0vqSuCOLDLA9yxTg8kzF2RTtrFlASvkrFmPLaJtaVukQ
         dx5NKWsr6CkQoGLe9DVthIsfhGRUMLCIhOM3QVgrl7be2FWaDy+DnfW190vcVwTJ2s
         zU16jMx+fgyZWf833+TKCK1dS9ojn0TwISpmHXXc4A6MxBBQ/0mOPvMaIk698Velpj
         TprITEm52LvMpvY15nmUsfSBRWn/PIGwebDUf9F7yPhJw536eOoYIVLCUc4Fu6rjuw
         5mKxlb8geTfkhmlqwBdxW8lU1ju4L3hTlb8r95qR77Md4eoESwaMNVfTOzd1VQdYKQ
         4GtDL57/Vxi2w==
Date:   Fri, 26 May 2023 17:50:02 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Jeroen de Borst <jeroendb@google.com>,
        Catherine Sullivan <csully@google.com>,
        Shailend Chand <shailend@google.com>,
        Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH net-next 04/12] mm: Make the page_frag_cache allocator
 use multipage folios
Message-ID: <20230526175002.2591ccae@kernel.org>
In-Reply-To: <20230524153311.3625329-5-dhowells@redhat.com>
References: <20230524153311.3625329-1-dhowells@redhat.com>
        <20230524153311.3625329-5-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 May 2023 16:33:03 +0100 David Howells wrote:
> -	offset = nc->offset - fragsz;
> -	if (unlikely(offset < 0)) {
> -		page = virt_to_page(nc->va);
> -
> -		if (page_ref_count(page) != nc->pagecnt_bias)
> +	offset = nc->offset;
> +	if (unlikely(fragsz > offset)) {
> +		/* Reuse the folio if everyone we gave it to has finished with
> +		 * it.
> +		 */
> +		if (!folio_ref_sub_and_test(folio, nc->pagecnt_bias)) {
> +			nc->folio = NULL;
>  			goto refill;
> +		}
> +
>  		if (unlikely(nc->pfmemalloc)) {
> -			page_ref_sub(page, nc->pagecnt_bias - 1);
> -			__free_pages(page, compound_order(page));
> +			__folio_put(folio);

This is not a pure 1:1 page -> folio conversion.
Why mix conversion with other code changes?
