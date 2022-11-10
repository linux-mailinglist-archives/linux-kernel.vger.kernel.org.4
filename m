Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 821496238BE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 02:20:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbiKJBT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 20:19:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbiKJBT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 20:19:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 818F0E008
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 17:19:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 32DFEB81F73
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 01:19:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AACB5C433C1;
        Thu, 10 Nov 2022 01:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1668043193;
        bh=hoIVUAv2wSp3yzcP/AxEyzqSJJMdw1gGZJ5IgO/eaM8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hGjTGteerh5bd6wAMMT5SZ8cZZk9BUWncMJC4+soW6JE2TZtECj2avj9Y4s13pFey
         aNTsoTApUmkZLIxFTB3gKgiGyg0/Orsyc430SjT+BSVPu6CNaIwJun9YuL/ER+Iv6L
         E1JX/6TZiFsnPIusCnLxlmg5072QTh1Tmh0IV/AQ=
Date:   Wed, 9 Nov 2022 17:19:52 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Chao Xu <amos.xuchao@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Chao Xu <Chao.Xu9@zeekrlife.com>
Subject: Re: [PATCH] mm/vmscan: simplify the nr assignment logic for pages
 to scan
Message-Id: <20221109171952.826d991327e07319c5eb8cd3@linux-foundation.org>
In-Reply-To: <20221109070416.620887-1-Chao.Xu9@zeekrlife.com>
References: <20221109070416.620887-1-Chao.Xu9@zeekrlife.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  9 Nov 2022 15:04:16 +0800 Chao Xu <amos.xuchao@gmail.com> wrote:

> By default the assignment logic of anonymouns or file inactive
> pages and active pages to scan using the same duplicated code
> snippet. To simplify the logic, merge the same part.
> 
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -5932,14 +5932,11 @@ static void shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
>  		 * scan target and the percentage scanning already complete
>  		 */
>  		lru = (lru == LRU_FILE) ? LRU_BASE : LRU_FILE;
> -		nr_scanned = targets[lru] - nr[lru];
> -		nr[lru] = targets[lru] * (100 - percentage) / 100;
> -		nr[lru] -= min(nr[lru], nr_scanned);
> -
> -		lru += LRU_ACTIVE;
> -		nr_scanned = targets[lru] - nr[lru];
> -		nr[lru] = targets[lru] * (100 - percentage) / 100;
> -		nr[lru] -= min(nr[lru], nr_scanned);
> +		for ( ; lru <= lru + LRU_ACTIVE; lru++) {

The "lru++" implicitly assumes that LRU_ACTIVE=1.  That happens to be
the case, but a more accurate translation of the existing code would
use "lru += LRU_ACTIVE" here, yes?

> +			nr_scanned = targets[lru] - nr[lru];
> +			nr[lru] = targets[lru] * (100 - percentage) / 100;
> +			nr[lru] -= min(nr[lru], nr_scanned);
> +		}
>  
>  		scan_adjusted = true;
>  	}

