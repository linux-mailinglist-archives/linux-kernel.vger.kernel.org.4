Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84E7A680A8B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 11:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236122AbjA3KO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 05:14:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236075AbjA3KOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 05:14:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3297E27D66
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 02:14:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DDB55B80DEA
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 10:14:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F129C433D2;
        Mon, 30 Jan 2023 10:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675073657;
        bh=YQdo56Bx7FrNbXodWDmZnWDioobuuYl+se8HK0H8qZk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nwijJTkjSQj6rM+FN0ySHsRFb1lQuJ81ZKCJP8sVGc3BjUlroVq8/CvB5QwxoLvOf
         FX6fEHQdSMdRJoUcKH76xcbOms2W1BUdghnfE5BYPk6RiEJRcXK0rJLH4D37DqefRj
         MgHXX7/gNaDAEHugGGCm2IUfA1nwYgHT/8O+t5liR9EglQwjw5TrrHSmuxhuQo8eCU
         awAF+xqxFb1HkAO1GxBDEtr1fhN4K3AyY92EPVmobuNHUV/xAHncwInakZ3ohtPOzB
         grWeUdtJGmf4z2OTndK7fz0/jaruhDOFFid2JKikd/nLbqKCMDsBiqwhkOpVIwaDJ8
         5Gv1cAWGLDWmw==
Date:   Mon, 30 Jan 2023 12:14:04 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Hyunmin Lee <hn.min.lee@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] replace BUG_ON to WARN_ON
Message-ID: <Y9eYbPuq5Nw9Njxf@kernel.org>
References: <20230127115844.GA1124261@min-iamroot>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230127115844.GA1124261@min-iamroot>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jan 27, 2023 at 08:58:44PM +0900, Hyunmin Lee wrote:
> Replace unnacessary BUG_ON to WARN_ON. These BUG_ONs verify aruguments of a function. Thus, the WARN_ONs return an EINVAL error when their condition is true.

Some users enable panic_on_warn, so for them WARN_ON will still crash a
machine.

I think a simple if() will be sufficient.
 
> Co-Developed-by: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
> Co-Developed-by: Jeungwoo Yoo <casionwoo@gmail.com>
> Co-Developed-by: Sangyun Kim <sangyun.kim@snu.ac.kr>
> Signed-off-by: Hyunmin Lee <hn.min.lee@gmail.com>
> Signed-off-by: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
> Signed-off-by: Jeungwoo Yoo <casionwoo@gmail.com>
> Signed-off-by: Sangyun Kim <sangyun.kim@snu.ac.kr>
> Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> ---
>  mm/vmalloc.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 74afa2208558..9f9dba3132c5 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -1587,9 +1587,14 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
>  	int purged = 0;
>  	int ret;
>  
> -	BUG_ON(!size);
> -	BUG_ON(offset_in_page(size));
> -	BUG_ON(!is_power_of_2(align));
> +	if (WARN_ON(!size))
> +		return ERR_PTR(-EINVAL);
> +
> +	if (WARN_ON(offset_in_page(size)))
> +		return ERR_PTR(-EINVAL);
> +
> +	if (WARN_ON(!is_power_of_2(align)))
> +		return ERR_PTR(-EINVAL);
>  
>  	if (unlikely(!vmap_initialized))
>  		return ERR_PTR(-EBUSY);
> -- 
> 2.25.1
> 
> 

-- 
Sincerely yours,
Mike.
