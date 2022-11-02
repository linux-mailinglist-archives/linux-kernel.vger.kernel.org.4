Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10067616E76
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 21:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbiKBUUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 16:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiKBUUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 16:20:12 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A711FE07
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 13:20:11 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id m6so17453275pfb.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 13:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9DjpWuBA9exOzLUYvqxZg1Cix0esC/PPOjwfygnWeME=;
        b=LiDV59gEZWcERwqLtJpyFpunwq9VioEGhoQlabJ+/2PMgE8V2BXCgxJJ6uBk4XqOZP
         LtquxJ6s33xnCmo2YekpzjPq1CnFqGcpD7lgm/WjNMel8i7oMl67r3OPcyw2znULQimS
         KXQOqJsBOEUnGSmkIf1Di2D98TS2zraNPMdwpsjucWL11fZ14NTh/BE3HPitMuFBE6iC
         IqHQHJXmK/l2UwxWZR3hu5K1IIG1QW5cb8aS8F8F9HAgA90VtHwkNvTIsVVYkioBBAAn
         6ARurfgrRPezG81fwKEizuk2facw9IBsvzcn7c0It8jy3yz1g8dIhf3gY2Ws0U7lcX7H
         7fJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9DjpWuBA9exOzLUYvqxZg1Cix0esC/PPOjwfygnWeME=;
        b=LQok1zduBevl7bam5bancTAiBRS863fI9oENBR0VQwYk2S30KLT/Z+6SUJ3EF9cjCN
         CdN2ByQbWzL5vJlXuFlA/kBk4TquSFRo8aDwO/rXVpOzH0eqAjhrm9Y0nmLFQTD4nLp3
         jyfyJ+h8uxDHWZqGmN55WAfrCF/xnKpkeqwVqDms08xj8C+NYZTTVT/fD3DizL4ySKwW
         hRKkq3jkgooJpDIv3DUASDWbEYz9BZhAE1IOZS20UvkuefJyOv2uH+avimH7/sIAsJGq
         sqijg/z27ePpoFVPijcYz36GJnaYMPs7k5ACvTh9UuBgp0oVGOPuXDnRPkEc0flLhz8I
         J9Jw==
X-Gm-Message-State: ACrzQf0jP725dc5zoOpOs5O2qGtgZIJWJRqh1GrsYaDSuigOHw26BJGM
        gZELs6r1fQ8Gbi5Q5X7d228=
X-Google-Smtp-Source: AMsMyM4Hvi439RG9EixT+nWpTjrrJxbl8sgAOJl1+3mSajMFITJwd6AL7yU/bh3NnD3bo9yU7OqYog==
X-Received: by 2002:a05:6a00:1da6:b0:56c:318a:f8ab with SMTP id z38-20020a056a001da600b0056c318af8abmr26972646pfw.82.1667420411185;
        Wed, 02 Nov 2022 13:20:11 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:3fd5:8614:6eb0:846b])
        by smtp.gmail.com with ESMTPSA id q5-20020a17090311c500b0017f49b41c12sm8782387plh.173.2022.11.02.13.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 13:20:10 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 2 Nov 2022 13:20:09 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCHv4 3/9] zram: Factor out WB and non-WB zram read functions
Message-ID: <Y2LQ+Wv/3xQmrfmL@google.com>
References: <20221018045533.2396670-1-senozhatsky@chromium.org>
 <20221018045533.2396670-4-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018045533.2396670-4-senozhatsky@chromium.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 01:55:27PM +0900, Sergey Senozhatsky wrote:
> We will use non-WB variant in ZRAM page recompression path.
> 
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> ---
>  drivers/block/zram/zram_drv.c | 73 ++++++++++++++++++++++++-----------
>  1 file changed, 50 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index a8ef3c0c3dae..94c62d7ea818 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -1314,8 +1314,30 @@ static void zram_free_page(struct zram *zram, size_t index)
>  		~(1UL << ZRAM_LOCK | 1UL << ZRAM_UNDER_WB));
>  }
>  
> -static int __zram_bvec_read(struct zram *zram, struct page *page, u32 index,
> -				struct bio *bio, bool partial_io)
> +/*
> + * Reads a page from the writeback devices. Corresponding ZRAM slot
> + * should be unlocked.
> + */
> +static int zram_read_from_writeback(struct zram *zram, struct page *page,

How about zram_read_from_bdev?
