Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34AD166A0F8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 18:45:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjAMRpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 12:45:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbjAMRos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 12:44:48 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1378576214
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 09:32:24 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id dw9so21661635pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 09:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PmYXy2OEtQ8VHSUKHtw2ymRz/ihI4R4a9w+pBYXSPOk=;
        b=hLV1A+louwagu6kcroNKyxrNallo6byaj7ZHPnU0W+/GRK0nax01Q90awWU6d+vv43
         ULDGVYWByxYf9MJq1f+DY1UEnnqLw9XTXJ75m2YYsF3fQSxqVouFC0WdWAXZ/hmvEDZi
         vpztpxGwNuCC3h+0tg3vKgTGsGTylRY2gEkAv/8xQ+Y9JJqMrH3BGDYBW1vjlZlDck5l
         q1lu2kWpAe7dL3MvNYj8XMaIyHhcBujnQ/Cir7An0foAFgOFvNMQuScNru543rofLbqx
         fFz5+WrkewTQZNiRMsLq9esZwORC0bRoxRDlzniRkVJyrPYANWEgF8zbecUAsW7Y6CTs
         DxUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PmYXy2OEtQ8VHSUKHtw2ymRz/ihI4R4a9w+pBYXSPOk=;
        b=OLCYXVSLVzSoEyainv86uWsawO0+lSE0LLg5qPPVgfEvV9WiHakcDNGBeNTBqqqWOt
         EsBR1Vmkn3SC+3gnPoK28Nf1T/mzI16BPVLU4+6nKRObSRaMxwXXkcim+F7JeKWgAQOO
         Ej9/1K4paUq2hk1usqTn5HbHi8QV20SPm4s35giwk3htvelsAmyEjGWJk1yF2UoC48Ma
         wgTW3dNWaOMexk9IDyuTtfw/rPvLewN7Hsgmo6sIDhHcND5R6WXpzEqlhqS4FUHsa13J
         ZQRbmVyfyanHcbKZSbzNQPYwlhIARdnbvbZWibIa7LJHkqxEo7BZL7VLKywgTNTvlhHl
         6eQQ==
X-Gm-Message-State: AFqh2koz3kQRlT61UgsNnjA4KiYMJPEZMZNRTslRjkDt0EkkKJqk+hFk
        xV1l9wT2oPP7u/5ZLQKkl0g=
X-Google-Smtp-Source: AMrXdXuZyYlG0xrvFopsJeYUWHJNpEbJJ7r7UFeIZlj2zJ+CVQQDjGr6jRS9fO898GVGsAyBjT2XCA==
X-Received: by 2002:a17:902:bb86:b0:192:afb0:8960 with SMTP id m6-20020a170902bb8600b00192afb08960mr46334594pls.3.1673631143514;
        Fri, 13 Jan 2023 09:32:23 -0800 (PST)
Received: from google.com ([2620:15c:211:201:2e4e:fba:501b:3a8c])
        by smtp.gmail.com with ESMTPSA id l6-20020a170903244600b0019467381dd6sm2392322pls.33.2023.01.13.09.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 09:32:22 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Fri, 13 Jan 2023 09:32:21 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv2 1/4] zsmalloc: rework zspage chain size selection
Message-ID: <Y8GVpW0FkRh028hU@google.com>
References: <20230109033838.2779902-1-senozhatsky@chromium.org>
 <20230109033838.2779902-2-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230109033838.2779902-2-senozhatsky@chromium.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2023 at 12:38:35PM +0900, Sergey Senozhatsky wrote:
> Computers are bad at division. We currently decide the best
> zspage chain size (max number of physical pages per-zspage)
> by looking at a `used percentage` value. This is not enough
> as we lose precision during usage percentage calculations
> For example, let's look at size class 208:
> 
> pages per zspage       wasted bytes         used%
>        1                   144               96
>        2                    80               99
>        3                    16               99
>        4                   160               99
> 
> Current algorithm will select 2 page per zspage configuration,
> as it's the first one to reach 99%. However, 3 pages per zspage
> waste less memory.
> 
> Change algorithm and select zspage configuration that has
> lowest wasted value.
> 
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Acked-by: Minchan Kim <minchan@kernel.org>
