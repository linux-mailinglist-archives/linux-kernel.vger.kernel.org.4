Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29D46633240
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 02:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbiKVBkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 20:40:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbiKVBkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 20:40:20 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC5CE1BFE
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 17:40:19 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id n17so12762193pgh.9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 17:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OmViSLFa5OllJV9pTGQkDLSySpGZUy3VM35OK0GlOcI=;
        b=K/hom9CbYbypJIGnzVOs25efj4/6n5Eehpw46jqAGqFhcK66ntifEwFgtLbyYz/qnh
         /zmvTQDD74uBFlz9Fu+kD+asOqO+yNezeg3tXoPhzLLsOMBENOmibVsFJ5GO7+57hXc0
         ytdwT9Yhs8eHoEgosmzLvEpacwy2I4nIQN1/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OmViSLFa5OllJV9pTGQkDLSySpGZUy3VM35OK0GlOcI=;
        b=jw3kLORlW18VPN9tLqqPek5J3c+KedHfpMGxQuPAKuFVMp3IFgJIzKnqj+rd1Bhw7W
         h+RFtCgjfpdy3uh5Rn1vkCnpaQf2h7Z4sma2XbsQLCChtU/aloEA/W0RX+52T1VdxlyF
         K1H3Q16ivpXvnlnFxWIWRf7wtXtvTzENwks+8aKUVafd+x1qnTqWkeKf0w8s/zqQ0yuX
         5DiWtsJ5fxLosMxoXKXgwJ5C4oVsxzmnthdHO9RXghVKFPBsZvWEaIfgdNBqVG+7UUg/
         16FcwSpWQ3ZdZQoZl5UUIsRXM5VYQMIyeDRO8iNqJRe9GmhzqOlJ1j4bFgiNEOoEVJQB
         1YSg==
X-Gm-Message-State: ANoB5plpxa5K4YTGNh9VcHvm+RMw38STxmdH6ll7nv2DWtOZcWXIgTbC
        I3vbvPa3u16ohF0jR41ZQPTW9w==
X-Google-Smtp-Source: AA0mqf4FhWFVIV3MNn2bOvl6m1yPm7gRKn6SNTWHXHYJ0R6v3cV3fqsy/Q7jRya/DTdCHn820x5chw==
X-Received: by 2002:a63:1f65:0:b0:470:8e8d:44ae with SMTP id q37-20020a631f65000000b004708e8d44aemr4487308pgm.382.1669081219500;
        Mon, 21 Nov 2022 17:40:19 -0800 (PST)
Received: from google.com ([240f:75:7537:3187:e258:71ac:37b7:2d52])
        by smtp.gmail.com with ESMTPSA id t20-20020a17090a951400b001fb1de10a4dsm7962686pjo.33.2022.11.21.17.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 17:40:19 -0800 (PST)
Date:   Tue, 22 Nov 2022 10:40:14 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, minchan@kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: Re: [PATCH v6 6/6] zsmalloc: Implement writeback mechanism for
 zsmalloc
Message-ID: <Y3wofgb32j9z8Im2@google.com>
References: <20221119001536.2086599-1-nphamcs@gmail.com>
 <20221119001536.2086599-7-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221119001536.2086599-7-nphamcs@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/11/18 16:15), Nhat Pham wrote:
> +static int zs_reclaim_page(struct zs_pool *pool, unsigned int retries);
> +
> +static int zs_zpool_shrink(void *pool, unsigned int pages,
> +			unsigned int *reclaimed)
> +{
> +	unsigned int total = 0;
> +	int ret = -EINVAL;
> +
> +	while (total < pages) {
> +		ret = zs_reclaim_page(pool, 8);

Just curious why 8 retries and how was 8 picked?

> +		if (ret < 0)
> +			break;
> +		total++;
> +	}
> +
> +	if (reclaimed)
> +		*reclaimed = total;
> +
> +	return ret;
> +}
