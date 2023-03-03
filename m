Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7EB6A9EA2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 19:26:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbjCCS0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 13:26:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231583AbjCCS0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 13:26:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB17710D0
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 10:26:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 39A30B80EF2
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 18:26:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4991CC433D2;
        Fri,  3 Mar 2023 18:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677867995;
        bh=DSkurpKxMx8y54UF4lVb+7A5OkUioceZ/RbRt1Z30bI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BuvFWYIu/HVI0EgnY69jn3dhqrWhQZcsbdv59Lq8Ni3QTqOYiVwaOcqyjKaq3Zyu9
         dFFJYaLBgJs6zF1/r5EWCPBcioqqGG70dP432wtlzyLgvaJmWsVXkDxBQceqi/MDvd
         7B6pdzmLaP8E1XoL2be19YkR+K5mRacFGADciNjpFdbAIPY950D8uIYvAz7C4HyTET
         9TxwKEJr0mf2J3upDZ4BN+MeopBYcTCzUN1MYbx++E8i9bxrrJq0+ULvre0HBpQz3Y
         z1mBI7VF5ssOoENzPzeVddx+Qvn6xHMbOJ/vRCInZboL78YfU/ojigMWYdL/KEcd0u
         miGlX47ifhiTQ==
From:   SeongJae Park <sj@kernel.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, damon@lists.linux.dev
Subject: Re: [PATCH v2 3/3] mm/damon/paddr: minor refactor of damon_pa_mark_accessed_or_deactivate()
Date:   Fri,  3 Mar 2023 18:26:33 +0000
Message-Id: <20230303182633.113353-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230303084343.171958-4-wangkefeng.wang@huawei.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Mar 2023 16:43:43 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:

> Omit one line by unified folio_put(), and make code more clear.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  mm/damon/paddr.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> index 2ef9db0189ca..6930ebf3667c 100644
> --- a/mm/damon/paddr.c
> +++ b/mm/damon/paddr.c
> @@ -266,17 +266,16 @@ static inline unsigned long damon_pa_mark_accessed_or_deactivate(
>  		if (!folio)
>  			continue;
>  
> -		if (damos_pa_filter_out(s, folio)) {
> -			folio_put(folio);
> -			continue;
> -		}
> +		if (damos_pa_filter_out(s, folio))
> +			goto put_folio;
>  
>  		if (mark_accessed)
>  			folio_mark_accessed(folio);
>  		else
>  			folio_deactivate(folio);
> -		folio_put(folio);
>  		applied += folio_nr_pages(folio);
> +put_folio:
> +		folio_put(folio);

I think this change is ok, but shouldn't the 'folio_put()' have called before
'folio_nr_pages()' anyway?  If so, could we make the change as a separate fix
first, and then make this change, so that it can be easily applied to relevant
stable kernels?


Thanks,
SJ

>  	}
>  	return applied * PAGE_SIZE;
>  }
> -- 
> 2.35.3
> 
> 
