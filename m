Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F01F3615A57
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 04:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbiKBD3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 23:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbiKBD3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 23:29:05 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4166410
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 20:29:03 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id m6so15304735pfb.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 20:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wxscppbd7CO4HZ9j9/10aVKDgnbCZgFQSCEpVRfHl0Y=;
        b=cyeIXizddRI28+BjmVZ/J7XNFddHenjeoTfy9K+DT7y0+xtEC7Jll84U9fbRz5QhCP
         T6cPKGowQzp+hdMXkJzOsylrt0aAoNLfYE6MsG1BrNCdGJGawcf1nVbzTn4cK/sGoP3U
         8D4KTAWMm6I+libcyOwmS2112+JqVyRDLdY28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wxscppbd7CO4HZ9j9/10aVKDgnbCZgFQSCEpVRfHl0Y=;
        b=gOZ4lZh7daagiU+eCabxjZbf1XYLoy1xt7X9nsk16kJAF2FLGDSQnqCJicmFypU2q/
         6qCzWXmPoh2ANMTfYAOSFIPVTLaioCzUHsLmxBZSep5AmvfA5mAflt7pgAbASR9I2Jvj
         ZHPaBAunWc+wbXO3O8YQKDXpTcYsKzNr4aF6jkjuGB2b4GgvGihh8GbZeGbt+FPmsV3t
         E3JTE2Tt+DOF5Z0lldCjuMerSyRcZpSkTM+fiBCfylfFyeiN31dcoRh5LC7FcwxjxK1+
         Rc6o9XJdkzKCWljnqw56vPdnNfqovA+4GZHg4T5m1RUZN56T9b9LDSkfL0bIIhryC8yY
         kumg==
X-Gm-Message-State: ACrzQf1Zqx/oAufdLO2+vnu2QfJ0RT78W/ZwvmObZcPBS3imYeKJgFHh
        GP4grvqJehmYsl/tiRNuN0hu4g==
X-Google-Smtp-Source: AMsMyM7XbsY6sJWV2ZedoRxQsL0dArAlDm4EY8V7+KE2FaG2i1FNEtHiEcMWQJ6OEd6huZ8OdW6ziA==
X-Received: by 2002:a65:4d07:0:b0:46f:ed91:a50d with SMTP id i7-20020a654d07000000b0046fed91a50dmr5308740pgt.343.1667359742885;
        Tue, 01 Nov 2022 20:29:02 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:f558:dfb0:7cb7:44d9])
        by smtp.gmail.com with ESMTPSA id s5-20020a17090a760500b0021282014066sm302684pjk.9.2022.11.01.20.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 20:29:02 -0700 (PDT)
Date:   Wed, 2 Nov 2022 12:28:56 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, minchan@kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: Re: [PATCH 2/5] zsmalloc: Consolidate zs_pool's migrate_lock and
 size_class's locks
Message-ID: <Y2Hj+H4VzlN/fcmR@google.com>
References: <20221026200613.1031261-1-nphamcs@gmail.com>
 <20221026200613.1031261-3-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221026200613.1031261-3-nphamcs@gmail.com>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/10/26 13:06), Nhat Pham wrote:
>  struct size_class {
> -	spinlock_t lock;
>  	struct list_head fullness_list[NR_ZS_FULLNESS];
>  	/*
>  	 * Size of objects stored in this class. Must be multiple
> @@ -247,8 +245,7 @@ struct zs_pool {
>  #ifdef CONFIG_COMPACTION
>  	struct work_struct free_work;
>  #endif
> -	/* protect page/zspage migration */
> -	rwlock_t migrate_lock;
> +	spinlock_t lock;
>  };

I'm not in love with this, to be honest. One big pool lock instead
of 255 per-class locks doesn't look attractive, as one big pool lock
is going to be hammered quite a lot when zram is used, e.g. as a regular
block device with a file system and is under heavy parallel writes/reads.
