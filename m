Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 218276DC973
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 18:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbjDJQlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 12:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjDJQlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 12:41:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 531E4E56;
        Mon, 10 Apr 2023 09:41:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E201761D03;
        Mon, 10 Apr 2023 16:41:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EB39C433D2;
        Mon, 10 Apr 2023 16:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681144869;
        bh=zz8rVoloOKCPdCyFenJt8RAA9ls+uQJna7oAZHgsD9Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YQRgGe/HZZXRBjj3tFQYBBklu/9e3YmhJ1Pt1l/aornMes8Hx8Y11OfM6V6V6M6r/
         drh+NIPlojIbSsPm7Sht1YpA22EF62hchPoGv6PJnmjyrruFwiT4KeSl7cIULX7MxS
         30PuglPFIEacD4MIthT4vM5mZS2LAdvXdqMEOd4JH1o81eBCr57VWj7tiLGwd0vPA7
         9YP+gWi90lW19MvExGBfE+I1sBz/rwVlfvHAeGCvlm5UBbUqrmP09OtPgoR2NW8ITi
         Ij3TDHVUbSdPCI8r0XxZ5DpuuckwxglXmol4JBUdrxW48cVL1KYEpnZIfSY0BFZ9nY
         RUIC98mkikC4Q==
Date:   Mon, 10 Apr 2023 19:40:54 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Lucas Tanure <tanure@linux.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, jbrunet@baylibre.com,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        martin.blumenstingl@googlemail.com, narmstrong@baylibre.com,
        stefan@agner.ch
Subject: Re: [PATCH v2 1/1] of: fdt: Scan /memreserve/ last
Message-ID: <ZDQ8FpOtO7UINuFn@kernel.org>
References: <20230410120017.41664-1-tanure@linux.com>
 <20230410120017.41664-2-tanure@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230410120017.41664-2-tanure@linux.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 10, 2023 at 08:00:17AM -0400, Lucas Tanure wrote:
> Change the order of scanning /memreserve/ and /reserved-memory node.
> /reserved-memory node should go first, as it has a more updated
> description of the memory regions and it can apply flags, like nomap.
> Also, /memreserve/ should avoid reserving regions described in
> /reserved-memory node.
> 
> Signed-off-by: Lucas Tanure <tanure@linux.com>
> ---
>  drivers/of/fdt.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index d1a68b6d03b3..26e608d8025d 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -635,16 +635,21 @@ void __init early_init_fdt_scan_reserved_mem(void)
>  	if (!initial_boot_params)
>  		return;
>  
> +	fdt_scan_reserved_mem();
> +	fdt_reserve_elfcorehdr();
> +
>  	/* Process header /memreserve/ fields */
>  	for (n = 0; ; n++) {
>  		fdt_get_mem_rsv(initial_boot_params, n, &base, &size);
>  		if (!size)
>  			break;
> +		if (memblock_overlaps_region(&memblock.memory, base, size) &&
> +		    memblock_is_region_reserved(base, size))
> +			break;

I don't think this is really needed, it's ok to reserve the same ranges
multiple times.
Both checks are not cheap, so it'll be better to just reserve everything
both from performance and simplicity points of view.

> +
>  		memblock_reserve(base, size);
>  	}
>  
> -	fdt_scan_reserved_mem();
> -	fdt_reserve_elfcorehdr();
>  	fdt_init_reserved_mem();
>  }
>  
> -- 
> 2.40.0
> 

-- 
Sincerely yours,
Mike.
