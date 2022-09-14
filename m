Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBBA45B9007
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 23:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiINVT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 17:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiINVTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 17:19:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E9945057
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 14:19:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 87B25B81CDC
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 21:19:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF0F6C433D6;
        Wed, 14 Sep 2022 21:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1663190360;
        bh=SE/1uEBMr3SKBdrsW9xCRtD5tFJ11wzPFGBH/vi9J78=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Lcjw3ZRwmBprq/ZUHbmDTESzH8APW6M71TpkOSLF6y9clCrNjhRRm0V95nDQfLp/g
         wLS3FXM7UCUDzLP4B5W/H32o1ZlSECFzgvbP3CTZ3NGaUqTtNIim/kl3biH1/WEWW3
         ZhX8jxpOgSvIrCNav64BfdE7Dwd0ST05aso80xWA=
Date:   Wed, 14 Sep 2022 14:19:19 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc:     Zhaoyang Huang <huangzhaoyang@gmail.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <ke.wang@unisoc.com>
Subject: Re: [PATCH] mm: No need to check pcp page when free it to buddy
Message-Id: <20220914141919.9f2c3ac357696d2d829d8f69@linux-foundation.org>
In-Reply-To: <1663152820-608-1-git-send-email-zhaoyang.huang@unisoc.com>
References: <1663152820-608-1-git-send-email-zhaoyang.huang@unisoc.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Sep 2022 18:53:40 +0800 "zhaoyang.huang" <zhaoyang.huang@unisoc.com> wrote:

> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> The pages on pcp list have been checked the validity from each entrance. It is
> no need to check it again when free them back to buddy.
> 

I'm not sure what "from each entrance" means.  Please identify the
codesite where this other check is occurring?

> ---
>  mm/page_alloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index e008a3d..131536e 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1445,7 +1445,7 @@ static bool free_pcp_prepare(struct page *page, unsigned int order)
>  
>  static bool bulkfree_pcp_prepare(struct page *page)
>  {
> -	return check_free_page(page);
> +	return false;
>  }
>  #endif /* CONFIG_DEBUG_VM */

