Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4E3666AF51
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 05:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbjAOEVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 23:21:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbjAOEVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 23:21:40 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A0D4689
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 20:21:39 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id 200so12621946pfx.7
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 20:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ALsjGopWf+hZuhs7nMXhO/pSXNTGv/26Xn0WdBaHFYg=;
        b=b0b/7owMlcYKKx6n44kgErJ0X4MpjPnAodIgILqAjx2U7yjvSdxiXkLLbGACuOgZc4
         yrCdHqkodXVWTtbOoqjItH+Jr5TRL1BkFhbY6sZrJsCah3dE4BjAgVj7nWl/2Zk0QdDX
         TvlVurRKhQhnZb/t78+SPyHJcARCWA0BwVd20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ALsjGopWf+hZuhs7nMXhO/pSXNTGv/26Xn0WdBaHFYg=;
        b=RURKao52aLzNiJBrBP9Ocktb/y5Rdb2OHvafPI0mYtlrJQHgRUefvlwd8k7IbfQzXC
         xJGeETFpdGuNBhD7D7PpoUtDqZB5POHCf3m4lrUhJaLoLDZ21PROmaLrZZHtLeSc4ION
         3XJxavyguyj6oh/znhx4C1+kJKO0G/OxkzXCv37JeVYoBgDmgTXuWIhljqlHzl18DNSD
         72jv0zfnPehoU/9TKSWxVEc3TtesI5XjR+UxehxsUnWXthzBB7JTCCV1LARy6yRG+vqz
         ir4g+a8tM9awAJA+3NEKI9fEjHQX/m9MwUND5bKRePTYWC2uxpH4Vb/WXhktAsH5e36a
         UlUw==
X-Gm-Message-State: AFqh2krBq6hFkwVuWA2rcOkUCoI+VnaYCqh6b1tG0fQGNjqHyxnwbYUs
        tbJo1K47z8MzRZ1zrDg24zNI+Q==
X-Google-Smtp-Source: AMrXdXuMdyba1c18pSrzjUQQ67d8ohp6Yo5Xgp4BKX9lppikXZ/3+a5X6b5bAAytRkPdXQaa7xt2iA==
X-Received: by 2002:a62:1684:0:b0:587:8d47:acdd with SMTP id 126-20020a621684000000b005878d47acddmr21290384pfw.34.1673756498581;
        Sat, 14 Jan 2023 20:21:38 -0800 (PST)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id 4-20020a620404000000b00576ee69c130sm15797537pfe.4.2023.01.14.20.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jan 2023 20:21:37 -0800 (PST)
Date:   Sun, 15 Jan 2023 13:21:33 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv2 0/4] zsmalloc: make zspage chain size configurable
Message-ID: <Y8N/Te/t9aLkKi90@google.com>
References: <20230109033838.2779902-1-senozhatsky@chromium.org>
 <Y8G3nJ9+k2lB0kas@monkey>
 <Y8JU8iGlu5uLGdDt@google.com>
 <Y8Mf4f2TTH8yY8Ic@monkey>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8Mf4f2TTH8yY8Ic@monkey>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/01/14 13:34), Mike Kravetz wrote:
> I did the following:
> 
> - Start with clean v6.2-rc3
>   Perform echo, did not see issue
> 
> - Applied your 5 patches (includes the zsmalloc: turn chain size config option
>   into UL constant patch).  Took default value for ZSMALLOC_CHAIN_SIZE of 8.
>   Performed echo, recreated issue.
> 
> - Changed ZSMALLOC_CHAIN_SIZE to 1.
>   Perform echo, did not see issue

The patch set basically just adjusts $NUM in calculate_zspage_chain_size():

		for (i = 1; i <= $NUM; i++)

It changes default 4 to 8. Can't really see how this can cause problems.
