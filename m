Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 401E87344E3
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 06:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbjFREjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 00:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjFREjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 00:39:06 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627ED171E
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 21:39:03 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-666e64e97e2so970913b3a.1
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 21:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687063143; x=1689655143;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aAJOlDCu6yVx1t8MZ/ubuxcuyCm4Ril/WvnJhr6PqTc=;
        b=kUubKdG83EbdbN9yvr/6QfOUKym5q05Ed1r/8j/3R/szNoGQPrh/JO3KLW6tJyuqhz
         +D+39zb+ZYEPMuLA4KzVBA/TWgLwnRkTUmMmpMpIzvWMJZ83yHkNA+VKjnuhO9ClnIXd
         9LB7UB28EWN39Y3xD6YA0dSmpgaGyxThOELjs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687063143; x=1689655143;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aAJOlDCu6yVx1t8MZ/ubuxcuyCm4Ril/WvnJhr6PqTc=;
        b=bSj5a+8pXUSOTvYyni7EvShC2pqHm8aVM2gpEcd0jOs/ALFDC5mF2qwpN87TPDBinE
         cnH+qwTT2L+ldKCS9tU8b5VLYo1qdkqhkHQCTXDV0fb96oW6Z7SKvtDULznvfoA37PXO
         Beo6IpfQJylN8APwcUhX+53YWDlz0LIMGj8l2vYS99oKV0X8bUxYHGhhE4Qbl7bUo/Am
         f0/rAwSjIHJHNuq0qkfrugUSCEKfuHM6AEJMBFDu7jnDiaI9ALuV1s05zKHZqZGvkNi8
         GD3p6R4TPnyNJD/iK4sxGZudSWg2d5VBDUstxKUpQE7guHK3Ac7AXpEFTWl62mYlcOzX
         P+4Q==
X-Gm-Message-State: AC+VfDyA/9dQ/hpg8i4PvWPIshjYH3RCBKUbF4ouFoorNK3Z7Te8sOwM
        huP75XuqBDS8qnpW8OVbYoo3uw==
X-Google-Smtp-Source: ACHHUZ4+TFCi4phLyTt7JUqdskJA2bGLOMWWIuJlsRlZUP2ul+hVjrGXXC+lEX1FtSBBiz7VyAaNvg==
X-Received: by 2002:a05:6a00:1789:b0:657:2f01:6078 with SMTP id s9-20020a056a00178900b006572f016078mr7030095pfg.28.1687063142869;
        Sat, 17 Jun 2023 21:39:02 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id e20-20020a62ee14000000b00640f51801e6sm13578671pfi.159.2023.06.17.21.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jun 2023 21:39:02 -0700 (PDT)
Date:   Sun, 18 Jun 2023 13:38:57 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Cc:     vitaly.wool@konsulko.com, minchan@kernel.org,
        senozhatsky@chromium.org, yosryahmed@google.com,
        linux-mm@kvack.org, ddstreet@ieee.org, sjenning@redhat.com,
        nphamcs@gmail.com, hannes@cmpxchg.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v3 1/7] mm: zswap: add pool shrinking mechanism
Message-ID: <20230618043857.GA2417524@google.com>
References: <20230612093815.133504-1-cerasuolodomenico@gmail.com>
 <20230612093815.133504-2-cerasuolodomenico@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612093815.133504-2-cerasuolodomenico@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/06/12 11:38), Domenico Cerasuolo wrote:
> +static int zswap_reclaim_entry(struct zswap_pool *pool)
> +{
> +	struct zswap_header *zhdr;
> +	struct zswap_entry *entry;
> +	struct zswap_tree *tree;
> +	pgoff_t swpoffset;
> +	int ret;
> +
> +	/* Get an entry off the LRU */
> +	spin_lock(&pool->lru_lock);
> +	if (list_empty(&pool->lru)) {
> +		spin_unlock(&pool->lru_lock);
> +		return -EINVAL;
> +	}
> +	entry = list_last_entry(&pool->lru, struct zswap_entry, lru);
> +	list_del_init(&entry->lru);

A quick question: should we zswap_entry_get() here?
