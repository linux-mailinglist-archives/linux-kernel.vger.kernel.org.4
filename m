Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A59A674E9A5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 11:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbjGKJBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 05:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbjGKJBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 05:01:03 -0400
Received: from out-26.mta0.migadu.com (out-26.mta0.migadu.com [IPv6:2001:41d0:1004:224b::1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F252E135
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 02:01:02 -0700 (PDT)
Date:   Tue, 11 Jul 2023 18:00:54 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1689066061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8prDY+X+iYILjO7R/8XWZU8ZCBnkl0AIfcoAHpqpNkY=;
        b=tWhdIP3tYXkCRM5aUkWNieZXrrq2a5sekriw98u2PZGTFAhKQ04lUR4ULr/T7/SP9IZJy9
        mpgdK9hwzhHjNEvBCDMrQ/3H1D9jtepKb26uuZ7C7RqluYVUHrelF2DK0RUhSPhc++HuDi
        ZffjFGticrD5KjU5UzVV/sT1jNeOCQE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, naoya.horiguchi@nec.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/8] mm: memory-failure: remove unneeded PageHuge()
 check
Message-ID: <20230711090054.GA2221061@ik1-406-35019.vs.sakura.ne.jp>
References: <20230711055016.2286677-1-linmiaohe@huawei.com>
 <20230711055016.2286677-2-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230711055016.2286677-2-linmiaohe@huawei.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 01:50:09PM +0800, Miaohe Lin wrote:
> PageHuge() check in me_huge_page() is just for potential problems. Remove
> it as it's actually dead code and won't catch anything.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Thank you for updating.

Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>

> ---
>  mm/memory-failure.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 64d7d34c177a..913fcf02ad38 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1187,9 +1187,6 @@ static int me_huge_page(struct page_state *ps, struct page *p)
>  	struct address_space *mapping;
>  	bool extra_pins = false;
>  
> -	if (!PageHuge(hpage))
> -		return MF_DELAYED;
> -
>  	mapping = page_mapping(hpage);
>  	if (mapping) {
>  		res = truncate_error_page(hpage, page_to_pfn(p), mapping);
> -- 
> 2.33.0
> 
> 
> 
