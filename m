Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 533A06A138A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 00:11:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjBWXLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 18:11:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjBWXLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 18:11:31 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719A94DE00
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 15:11:30 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id y2so10380062pjg.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 15:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677193890;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZMPTwn6A1SJ1IFAEdre49nDDwVXbknbqks5KCgESScg=;
        b=FVvpdyBXZvuPwD2DHr3E2e4M11bO2iyWULgET72pY/dqODfAzGkwrghbnLPa6U0gic
         4XQ97gMXC2btoOwB1tfzjNrG5eKtyJHSAL4VDP/Ltpe3y80GVwWAOGyOyzo0JCC6tUO7
         Z4X6WA+NRxsWEln/Jrf5a7SvdiRaQE+lgd30JiWR04CSzUr6cEUMqBsHCLqqvQI2Fhzc
         MPidMqO2dtPeXht9yCJGgRbt4Aga9+HvQCy8Px0ZFO0QjOFdfRvVmWJE8Rjl1P6bxYKR
         FKBMtSOgbs1wQCfkR6cxla4lYWVNI8CmVHOIV3Vg5tY33gCJOrjuAtXpBTZwEe80VrfK
         rBlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677193890;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZMPTwn6A1SJ1IFAEdre49nDDwVXbknbqks5KCgESScg=;
        b=tY6JckfhUz8css4m+A8/aRhLuZt+oLVnWmOcFI2Z/gE3tdRb7ODKU6z9BfzGN0ofax
         f7sFWVpsDKQqg8+q2ouS2BNWYAr1ybanEeggu1UI6eh5SW4YAwdIZpWxLe9CDuEjqUns
         wNz5czCM2a3JD7rUfCSBT/X40ZCVxLLWozUDFNVrPq/joBJ0eFovztnqsocjiorfVj5N
         dmTK05IRSxBincyuL5VegbzTCElzmzwB6xRjy8nKpM+Yu/TStmSnWV8vF8ilvvaSIvPi
         /C8eBzQwDTMbDZyIGZRrnCoYd9j92uiG4MjbOvElZ28XZI21OCLT2vf4g85HKmkgpnft
         bRHA==
X-Gm-Message-State: AO0yUKVuQ+SjQu/aYmuIqKyX4o5BRee8+lTfaJu5Dg373ikYk8DDF7eA
        JJfG/tuAJPYogiP9ZSKh2QbGzqeJnw4=
X-Google-Smtp-Source: AK7set9GZqJGj4EAL6Agk48dPwa/lldbWp0ErKJKTubGj6DHDIKo/TWBCeW7Oanq/NRfGRS7Dis/2g==
X-Received: by 2002:a17:90b:1e02:b0:233:af77:c075 with SMTP id pg2-20020a17090b1e0200b00233af77c075mr14177342pjb.36.1677193889885;
        Thu, 23 Feb 2023 15:11:29 -0800 (PST)
Received: from google.com ([2620:15c:211:201:be5:a687:1e9d:ec53])
        by smtp.gmail.com with ESMTPSA id i9-20020a17090a2a0900b00230b572e90csm223340pjd.35.2023.02.23.15.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 15:11:29 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 23 Feb 2023 15:11:27 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv2 2/6] zsmalloc: remove stat and fullness enums
Message-ID: <Y/fyn1u5RhDwgG1J@google.com>
References: <20230223030451.543162-1-senozhatsky@chromium.org>
 <20230223030451.543162-3-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230223030451.543162-3-senozhatsky@chromium.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023 at 12:04:47PM +0900, Sergey Senozhatsky wrote:
> The fullness_group enum is nested (sub-enum) within the
> class_stat_type enum. zsmalloc requires the values in both
> enums to match, because zsmalloc passes these values to
> generic functions, e.g. class_stat_inc() and class_stat_dec(),
> after casting them to integers.
> 
> Replace these enums (and enum nesting) and use simple defines
> instead. Also rename some of zsmalloc stats defines, as they
> sort of clash with zspage object tags.
> 
> Suggested-by: Yosry Ahmed <yosryahmed@google.com>
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> ---
>  mm/zsmalloc.c | 104 ++++++++++++++++++++++----------------------------
>  1 file changed, 45 insertions(+), 59 deletions(-)
> 
> diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> index b57a89ed6f30..38ae8963c0eb 100644
> --- a/mm/zsmalloc.c
> +++ b/mm/zsmalloc.c
> @@ -159,26 +159,18 @@
>  #define ZS_SIZE_CLASSES	(DIV_ROUND_UP(ZS_MAX_ALLOC_SIZE - ZS_MIN_ALLOC_SIZE, \
>  				      ZS_SIZE_CLASS_DELTA) + 1)
>  
> -enum fullness_group {
> -	ZS_EMPTY,
> -	ZS_ALMOST_EMPTY,
> -	ZS_ALMOST_FULL,
> -	ZS_FULL,
> -	NR_ZS_FULLNESS,
> -};
> +#define ZS_EMPTY		0
> +#define ZS_ALMOST_EMPTY		1
> +#define ZS_ALMOST_FULL		2
> +#define ZS_FULL			3
> +#define ZS_OBJS_ALLOCATED	4
> +#define ZS_OBJS_INUSE		5
>  
> -enum class_stat_type {
> -	CLASS_EMPTY,
> -	CLASS_ALMOST_EMPTY,
> -	CLASS_ALMOST_FULL,
> -	CLASS_FULL,
> -	OBJ_ALLOCATED,
> -	OBJ_USED,
> -	NR_ZS_STAT_TYPE,
> -};
> +#define NR_ZS_STAT		6
> +#define NR_ZS_FULLNESS		4

Using define list instead of enum list looks like going backward. :)

Why can't we do this?

enum class_stat_type {
    ZS_EMPTY,
    ZS_ALMOST_EMPTY,
    ZS_ALMOST_FULL,
    ZS_FULL,
    NR_ZS_FULLNESS,
    ZS_OBJ_ALLOCATED = NR_ZS_FULLNESS,
    ZS_OBJ_USED,
    NR_ZS_STAT,
}


};
>  
>  struct zs_size_stat {
> -	unsigned long objs[NR_ZS_STAT_TYPE];
> +	unsigned long objs[NR_ZS_STAT];
>  };
>  
