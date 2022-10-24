Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0121A60B53F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 20:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232684AbiJXSRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 14:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbiJXSR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 14:17:29 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353FD27B54D
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 09:58:50 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id g62so5447995pfb.10
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 09:58:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kIGjbP9zJPjIy2yzyFXS3DkAMVogbE+K2En/NCnUYeM=;
        b=NDGGOS8dG8JemCl0zfwXa40XSrZ860udAOe6g0OM0u+V2qtEQBj2EbSuwhKOj4RKxf
         33l1qJ5HWGbm+ram/fUdt/Z0XIQGtRwvtERgV5kNHX/xdDDHyvQhLti6PUeJg0pQXtB6
         6VL9rD7/M4RzztXGPS3FYlKmMWH4vDzE3bKTQIKh4YEGfwY1Yl0ILooQoB1+z4f0e3s9
         jEs5Nzr5voQ+G4Da/WCOMQLqYMjr7DYLXQrGjZCUmDHGDdG6OwV2XfoZZHk0/lIu3irl
         nwNCDjPqoI5su2h8z94uVrbXTE3WJWUqedZEfx2N2pPhy8Ch9bNDdRrflMr2+gPmXMly
         HAIw==
X-Gm-Message-State: ACrzQf0vzuKubpcbw3l/zS571Tchyo2Ljs+Sr+wCvQ494q/ufsA5uT89
        KpX9FVE4mw5wkke9sjGOHBo=
X-Google-Smtp-Source: AMsMyM4Hw4wD2EqxdPbc4wSaZOdf1mbANxGChCppXIyzUqWiOx01KHylU/hxqjpp9VnEv++7TQgJPA==
X-Received: by 2002:a63:824a:0:b0:46b:272f:d75f with SMTP id w71-20020a63824a000000b0046b272fd75fmr28564028pgd.268.1666630585932;
        Mon, 24 Oct 2022 09:56:25 -0700 (PDT)
Received: from fedora (136-24-99-118.cab.webpass.net. [136.24.99.118])
        by smtp.gmail.com with ESMTPSA id k3-20020aa79983000000b0056bfa2cf517sm62732pfh.3.2022.10.24.09.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 09:56:25 -0700 (PDT)
Date:   Mon, 24 Oct 2022 09:56:22 -0700
From:   Dennis Zhou <dennis@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Subject: Re: [PATCH 4/8] mm/percpu: add comment to state the empty populated
 pages accounting
Message-ID: <Y1bDtmfCee+V32Ml@fedora>
References: <20221024081435.204970-1-bhe@redhat.com>
 <20221024081435.204970-5-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221024081435.204970-5-bhe@redhat.com>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 04:14:31PM +0800, Baoquan He wrote:
> When allocating an area from a chunk, pcpu_block_update_hint_alloc()
> is called to update chunk metadata, including chunk's and global
> nr_empty_pop_pages. However, if the allocation is not atomic, some
> blocks may not be populated with pages yet, while we still account it
> here. The number of pages will be subtracted with pcpu_chunk_populated()
> when populating pages.
> 
> Adding code comment to make that more understandable.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  mm/percpu.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/percpu.c b/mm/percpu.c
> index a8121302a79c..09e407338573 100644
> --- a/mm/percpu.c
> +++ b/mm/percpu.c
> @@ -831,13 +831,15 @@ static void pcpu_block_update_hint_alloc(struct pcpu_chunk *chunk, int bit_off,
>  
>  	/*
>  	 * Update s_block.
> -	 * block->first_free must be updated if the allocation takes its place.
> -	 * If the allocation breaks the contig_hint, a scan is required to
> -	 * restore this hint.
>  	 */
>  	if (s_block->contig_hint == PCPU_BITMAP_BLOCK_BITS)
>  		nr_empty_pages++;
>  
> +	/*
> +	 * block->first_free must be updated if the allocation takes its place.
> +	 * If the allocation breaks the contig_hint, a scan is required to
> +	 * restore this hint.
> +	 */
>  	if (s_off == s_block->first_free)
>  		s_block->first_free = find_next_zero_bit(
>  					pcpu_index_alloc_map(chunk, s_index),
> @@ -912,6 +914,12 @@ static void pcpu_block_update_hint_alloc(struct pcpu_chunk *chunk, int bit_off,
>  		}
>  	}
>  
> +	/*
> +	 * If the allocation is not atomic, some blocks may not
> +	 * be populated with pages, while we account it here.
> +	 * The number of pages will be subtracted with
> +	 * pcpu_chunk_populated() when populating pages.
> +	 */
>  	if (nr_empty_pages)
>  		pcpu_update_empty_pages(chunk, -nr_empty_pages);
>  
> -- 
> 2.34.1
> 

Heh, that's a little more subtle than I remember it being.

Acked-by: Dennis Zhou <dennis@kernel.org>

Thanks,
Dennis
