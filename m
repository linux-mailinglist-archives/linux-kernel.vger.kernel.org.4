Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC926628E90
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 01:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236981AbiKOAmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 19:42:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236375AbiKOAmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 19:42:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 900F51B1EE
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 16:41:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 40202B810A0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 00:41:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C97EC433D7;
        Tue, 15 Nov 2022 00:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1668472891;
        bh=lAVWfOrc/rwWjzqaYTXRp+1KDrw37nDH3kkVtQ7yHEo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=f66AIpfdCswCix6JxHdGCmi4C7k/cPTKbqbjTLjEkN0MGuHhK0ndDkX9w1PI/WlJv
         a1FbyuVKd7Dq+DdS1gmqtpiPHjPORZM2rp5JywZpD+5J55mg32JQKNCcGc3xgkwXY8
         6BOkrX2OJgbgwfxbdo5KcN/of5Sh1uHHl0uXEUa4=
Date:   Mon, 14 Nov 2022 16:41:30 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>,
        Suleiman Souhlal <suleiman@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        coverity-bot <keescook+coverity-bot@chromium.org>
Subject: Re: [PATCH] zram: explicitly limit prio_max for static analyzers
Message-Id: <20221114164130.e45a95db4e8be2c3909bdba1@linux-foundation.org>
In-Reply-To: <20221114021420.4060601-1-senozhatsky@chromium.org>
References: <20221109115047.2921851-5-senozhatsky@chromium.org>
        <20221114021420.4060601-1-senozhatsky@chromium.org>
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

On Mon, 14 Nov 2022 11:14:20 +0900 Sergey Senozhatsky <senozhatsky@chromium.org> wrote:

> Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> ---
>  drivers/block/zram/zram_drv.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index 9d33801e8ba8..e67a124f2e88 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -1706,6 +1706,7 @@ static int zram_recompress(struct zram *zram, u32 index, struct page *page,
>  	 * Iterate the secondary comp algorithms list (in order of priority)
>  	 * and try to recompress the page.
>  	 */
> +	prio_max = min(prio_max, ZRAM_MAX_COMPS);
>  	for (; prio < prio_max; prio++) {
>  		if (!zram->comps[prio])
>  			continue;

I'll queue this as a fix to "zram: introduce recompress sysfs knob".

What's it do?  A little changelog would be nice, or at least a link to
the coverity report?

