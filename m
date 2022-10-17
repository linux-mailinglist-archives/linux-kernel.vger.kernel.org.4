Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37725601643
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 20:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbiJQS1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 14:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbiJQS11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 14:27:27 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170BD74DEF
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 11:27:21 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id w3so8250461qtv.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 11:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zmaKaOskyDEP07VNlz3xmfh/tqhUu/L+2TquVBpNhZY=;
        b=irazOzM4ASvlywgucqMF4REBu2/swLVa43rA8LaqSR7jySzDQIligyjApbjGDuRMnS
         vQ9T4lVgXghfnASSDN1i8Xm5LuOSSmKrQeI+6Q3lSUMmcQ+S1ZMTwud4rwmdl2bKdUJb
         5A06jqIl6l0Q2ioGWFm1rgsyyv4+WVSI4vYkLYIuU7cq4ky+UG4BGvxh1YPFxlUM/mIS
         Aw95Uxl1xiMYZ1r6HA1cYcy6yLf9NSiyJC6i/20sgvkT64Wy2hfytLqNbB9lJrafEKAJ
         uYrMCySQfhbY4F4nodfn5APsYFVG5AQ69EqSfJVLIC4k3huk52b7fymAHztEqux5yncf
         8vfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zmaKaOskyDEP07VNlz3xmfh/tqhUu/L+2TquVBpNhZY=;
        b=W8a1dLZ2DVmjTln0bTZOHgGe0QGTpj1cetuRPFd7ufOiG8b6viCQG6K1VZsi10O6Fr
         MyXkSLfdv8JsGizkaLZlCbCG7TX+asvJY+zWI+ZqSCJUEVI40tiu+36NRajOZ/mLpVtK
         f/9aoEZJ5taWh79jPAgwaxEWD4weybkgM8chhI42Uui7vV6Yr6bWAnP/jLWs1hI0Ytyi
         lQKpsbniancLQ1EKCr1///QwgQaiEEUCz4nV5MWqdjPfF/JnaAaPaktAWmOJOoVCKjj4
         3vzobLN3/Jmbh0uXzdoURK0m9d5NBX7Z8bCnVhm9tvOBhESxgwLtVm806+4NwBmZpIZa
         S/Nw==
X-Gm-Message-State: ACrzQf1MHadhz4bNSfsDkhY56O2CEAROoJYXUQd9xHu6PvOWlahstvZK
        pBntSFIbezFlfnsqXQAo93he9w==
X-Google-Smtp-Source: AMsMyM4igYNUwBf0hwVsh4teTfB3/xMYGqk+IWEEDwmgjOt9x5IrU4vFE39yv2doSWS5Ujoe43UXCA==
X-Received: by 2002:a05:622a:209:b0:39c:d88f:20ed with SMTP id b9-20020a05622a020900b0039cd88f20edmr9863627qtx.131.1666031240047;
        Mon, 17 Oct 2022 11:27:20 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id dt27-20020a05620a479b00b006b9c9b7db8bsm388323qkb.82.2022.10.17.11.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 11:27:19 -0700 (PDT)
Date:   Mon, 17 Oct 2022 14:27:18 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Kemeng Shi <shikemeng@huawei.com>
Cc:     tj@kernel.org, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] block: Replace struct rq_depth with unsigned int in
 struct iolatency_grp
Message-ID: <Y02ehhyqSSLIV5ZS@localhost.localdomain>
References: <20220929074055.30080-1-shikemeng@huawei.com>
 <20220929074055.30080-4-shikemeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929074055.30080-4-shikemeng@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 03:40:55PM +0800, Kemeng Shi wrote:
> We only need a max queue depth for every iolatency to limit the inflight io
> number. Replace struct rq_depth with unsigned int to simplfy "struct
> iolatency_grp" and save memory.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huawei.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
