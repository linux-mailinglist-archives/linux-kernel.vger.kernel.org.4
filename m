Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9AB96366F7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 18:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238448AbiKWR12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 12:27:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236514AbiKWR1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 12:27:23 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196CC8E0AF
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 09:27:22 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id c15so11666368qtw.8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 09:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X4ror3WW8EMAvSzzIPDDvs1aj+7+7UMUKzLin0vg3Y4=;
        b=et+IYbyjRj/0/GetQ/OQK6v6unqnZJqfadSoTXdZs21oe7kqXw9yKumIOsLRcvRLAb
         2/qw/Rsk7xO45+SrRMfYSGUiAqqtTnXRxtrFLEWwgoVRvMVwXOf9qtiG750xi/ea/OZf
         VzuwqsPshGK2ywA0l0zPNSTfxrMw1DpOs27nfyk+XXx/nqLV2RiQM4IVoTqKJjnJoron
         n0Ls1hCzNECE3owA0A6xRaqpDJzecJgrDcEHkERtwfk0IpehdenGT9jev9GhUhoLbGIF
         Xswb7Expvq/oZtmkh5WIMAcirILqMPlKPRZ+ixpIERfSmcgszoY+zY2P80xsK/2b4Dqh
         VXug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X4ror3WW8EMAvSzzIPDDvs1aj+7+7UMUKzLin0vg3Y4=;
        b=muNe67hoCh34P3TKuBLHxRIaqCzd/6q08snLHRBCwN8IwbCJTvi6E0yjtR92S+nZTW
         SREADSHWEuM7vUQKr+WmqK7iHvzUCLkDwN9wjBOiPjZAhdPG8jtnLzX4LHifemGZGSmJ
         kQbka/3fVOATulsci6SmSb7NuDzh2KZOiPHrEddWw3sGUA8I4Z+vFsKz7ieJgdGWEPNJ
         e/Tw8ECJUdZ0hBwSk83l9SwPgWym4/jaYD/INc21BiXEVUGXhPON+Ir5zaPoNTDXXqP8
         C7Yg4Z0W7eMpMyQYpyLQjq+cgONScys+bNxFYvgB9KGgwE/isFICQxBD+2GNZA/zGSe3
         DBxQ==
X-Gm-Message-State: ANoB5pkpZY+GweRqnTCf4qpcDov10SuG6L/FUTk53Ur5OkRP7aaQs81Q
        4+iE6nWu4MpROgJU19oUv0mZbA==
X-Google-Smtp-Source: AA0mqf7g8nd6AoDgQOa5G02kZfOqxagyJQeBvC7rocH/QPZ/xTbkw/zaXC17S4uqYkFQsKK3WS83Rw==
X-Received: by 2002:ac8:1347:0:b0:39c:b637:a890 with SMTP id f7-20020ac81347000000b0039cb637a890mr26964943qtj.613.1669224441270;
        Wed, 23 Nov 2022 09:27:21 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:bc4])
        by smtp.gmail.com with ESMTPSA id l16-20020a05620a28d000b006f3e6933bacsm12849206qkp.113.2022.11.23.09.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 09:27:20 -0800 (PST)
Date:   Wed, 23 Nov 2022 12:27:47 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     senozhatsky@chromium.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, minchan@kernel.org,
        ngupta@vflare.org, akpm@linux-foundation.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: Re: [PATCH v6 6/6] zsmalloc: Implement writeback mechanism for
 zsmalloc
Message-ID: <Y35YE8wUtmplpInd@cmpxchg.org>
References: <Y3xuKXmNjs87q3AW@google.com>
 <20221123163044.2029016-1-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221123163044.2029016-1-nphamcs@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 08:30:44AM -0800, Nhat Pham wrote:
> I'll put it right after releasing the pool's lock in the retry loop:
> 
> 		/* Lock out object allocations and object compaction */
> 		remove_zspage(class, zspage, fullness);
> 
> 		spin_unlock(&pool->lock);
> 		cond_resched();
> 
> 		/* Lock backing pages into place */
> 		lock_zspage(zspage);
> 
> This will also appear in v7. In the meantime, please feel free to discuss all
> the patches - I'll try to batch the changes to minimize the churning.

Oh, our emails collided. This is easier than my version :)
