Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8785074CF34
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 09:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbjGJH4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 03:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232286AbjGJH43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 03:56:29 -0400
Received: from out-34.mta1.migadu.com (out-34.mta1.migadu.com [95.215.58.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91CE5194
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 00:56:18 -0700 (PDT)
Date:   Mon, 10 Jul 2023 16:56:07 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1688975775;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pxpfsWCTlFG1v+7dBNIcVRA81FfHjZwtoCj7hQ1Emik=;
        b=OXMPdKFiMdjZEynNo2f5M+d2MB4748ozdgc0DsnBSIbSOX8ajZlQXXrj3eWfPrwmQvj81m
        +nLfMuKBEB1ReuphfOM7mMAKJl/HZBa502dIbIkwG4pf95lpowjqhhiHJAOldyUKWW1qQy
        dddbMwtfy0YLqcb99Oh3yoT6L8lAoiY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, naoya.horiguchi@nec.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] mm: memory-failure: fix potential permanently locked
 hpage
Message-ID: <20230710075607.GA1686200@ik1-406-35019.vs.sakura.ne.jp>
References: <20230708085744.3599311-1-linmiaohe@huawei.com>
 <20230708085744.3599311-2-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230708085744.3599311-2-linmiaohe@huawei.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 08, 2023 at 04:57:37PM +0800, Miaohe Lin wrote:
> If hpage isn't Hugetlb page, MF_DELAYED is returned without unlock hpage
> leading to hpage permanently locked. But this shouldn't trigger in the
> real world because this PageHuge() check is just for potential problems.

Right, so this if-block is dead code, how about simply removing it?

Thanks,
Naoya Horiguchi

> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/memory-failure.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index a6221a4bc5ea..d21ee27ad412 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1187,8 +1187,10 @@ static int me_huge_page(struct page_state *ps, struct page *p)
>  	struct address_space *mapping;
>  	bool extra_pins = false;
>  
> -	if (!PageHuge(hpage))
> +	if (!PageHuge(hpage)) {
> +		unlock_page(hpage);
>  		return MF_DELAYED;
> +	}
>  
>  	mapping = page_mapping(hpage);
>  	if (mapping) {
> -- 
> 2.33.0
> 
> 
> 
