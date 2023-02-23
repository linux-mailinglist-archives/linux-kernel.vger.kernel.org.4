Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF0C6A13FC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 00:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjBWXvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 18:51:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjBWXvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 18:51:08 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7A351FB3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 15:51:04 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id y2so10460994pjg.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 15:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677196264;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5IdfJE8AvP5t+Iu3xidru+ELJWM2yxeVWcyHiD78toI=;
        b=Y8X1mBI0vnw77UgdAQb9BDMxKwDzZJHNi9poxgJfxJpv6bfef55B+T2EYwCLJgKwUx
         edxmOF0z3PjK8afqi0NqGbfvppkYw/pO+nEpxyDO4LhUbtUAZH/AKKKhNicMn3f2XmJH
         EW71MwM1YtvbKrJcYfDmJ1NrF/5NVVr8D6ptYyhFlzHnjCVvsezWrk5RteFw16kLjO01
         wLVHKZ+JyM+BI1XvoqHFZrze96Ieo7jRZQnaC+aY/aeOdd2w4RYUV80EpkPq8eG1gNWN
         0sLBOGJWIu0ccS+ok6DULbnVFjehSqLmCC3IhXh4ibe4ZvQ/iM8ZUMHpYjFm9z7PcxFR
         XepQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677196264;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5IdfJE8AvP5t+Iu3xidru+ELJWM2yxeVWcyHiD78toI=;
        b=gRLdcEZFF/D+uOCBEtvTVT93GCVQlzFCjS5SiqKwlKlJhlzns+SmKN4O0RiPo0fPcF
         N6JYUWoGw6YHlIN4mlXdf3T9fsR66lZ1pi9TxI6MgaIFNLnflUMo0ZFntpEeQF7ELfAs
         +wI93MkygqLtCeOvY53ykw6HxPAk+xPFcsYz3ajgRbFkW2PVxOvSV9Iq04Z8vOguNWa9
         URyFHqT21Wof3OpJs5u1mnpcIny3H6YQt2s17UjsGJNP0J7e0JA6zX4HSRc6ZUxYx3tL
         J63eQ17aZJ0okzzC2i+e69zOLSCIkZgferD4zCgRoRDD30DaoE02hVn0jezP0UWV/Ndf
         5VOA==
X-Gm-Message-State: AO0yUKUhLBU20un/R7+n43wgSz1MoW/0fk5dZJgL3sA4lUPZpaz4v62X
        b9US+xJ80NSR9/5b1f03pXA=
X-Google-Smtp-Source: AK7set/x1UtpmPStjTvqQISFJnvoWw0VqkAy7Uz37AwqJBrUKr4JcpCfcgF7uo9jBDigq6igDvbqZQ==
X-Received: by 2002:a17:90b:3b87:b0:236:6e4f:bc1e with SMTP id pc7-20020a17090b3b8700b002366e4fbc1emr14609910pjb.49.1677196263764;
        Thu, 23 Feb 2023 15:51:03 -0800 (PST)
Received: from google.com ([2620:15c:211:201:be5:a687:1e9d:ec53])
        by smtp.gmail.com with ESMTPSA id q14-20020a170902b10e00b0019a8b057359sm2137413plr.130.2023.02.23.15.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 15:51:02 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 23 Feb 2023 15:51:01 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv2 5/6] zsmalloc: extend compaction statistics
Message-ID: <Y/f75fkcQg6m3cbG@google.com>
References: <20230223030451.543162-1-senozhatsky@chromium.org>
 <20230223030451.543162-6-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230223030451.543162-6-senozhatsky@chromium.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023 at 12:04:50PM +0900, Sergey Senozhatsky wrote:
> Extend zsmalloc zs_pool_stats with a new member that
> holds the number of objects pool compaction moved
> between pool pages.

I totally understand this new stat would be very useful for your
development but not sure it's really useful for workload tune or
monitoring.

Unless we have strong usecase, I'd like to avoid new stat.

> 
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> ---
>  include/linux/zsmalloc.h | 2 ++
>  mm/zsmalloc.c            | 1 +
>  2 files changed, 3 insertions(+)
> 
> diff --git a/include/linux/zsmalloc.h b/include/linux/zsmalloc.h
> index a48cd0ffe57d..8b3fa5b4a68c 100644
> --- a/include/linux/zsmalloc.h
> +++ b/include/linux/zsmalloc.h
> @@ -36,6 +36,8 @@ enum zs_mapmode {
>  struct zs_pool_stats {
>  	/* How many pages were migrated (freed) */
>  	atomic_long_t pages_compacted;
> +	/* How many objects were migrated during compaction */
> +	atomic_long_t objs_moved;
>  };
>  
>  struct zs_pool;
> diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> index eacf9e32da5c..f7e69df48fb0 100644
> --- a/mm/zsmalloc.c
> +++ b/mm/zsmalloc.c
> @@ -1815,6 +1815,7 @@ static void migrate_zspage(struct zs_pool *pool, struct size_class *class,
>  		obj_idx++;
>  		record_obj(handle, free_obj);
>  		obj_free(class->size, used_obj, NULL);
> +		atomic_long_inc(&pool->stats.objs_moved);
>  	}

