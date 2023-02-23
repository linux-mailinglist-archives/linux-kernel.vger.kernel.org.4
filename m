Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05DAF6A1382
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 00:09:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjBWXJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 18:09:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjBWXJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 18:09:36 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5CF1633A
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 15:09:35 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id s5so14782029plg.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 15:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677193775;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dbpW+ci7vAAbVs11HVGBMJ2nIWBV8zhBVEdP65zp1Mg=;
        b=S6kS+0hzuWSn3ITuRcHTXU3ATnsL2V4jyhKhHnc+kf8eukn6OSfPKFUIQErz7NSro2
         aQuwsbnxvrKpUWa6d7AM1dwe88+QR4x6BMrJlnxiFQnIxThz3OBVCd3PO2P7hVo5cvhj
         sa3BzF+QimwRRNhyGHDIlTQk5jujfAhu8KFMWlXWLzCPglu+780Qb27FXGC3ydZUssBz
         FGk1/479vVsxchfxbC8FoOtrppS2qivD2QhkgFhT+lgj3GqSqVVSF8OzbGGpmDlU73XS
         o8vFf4uNes+PL4Cj/bzv0ZM49798EASOL7OF3M3zJc4C39DnG2B2bmqil58GdPbrqO7u
         6Z7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677193775;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dbpW+ci7vAAbVs11HVGBMJ2nIWBV8zhBVEdP65zp1Mg=;
        b=oEzhl/i3MXJNG42oCIgzEmMk/sRfEvhod4sJu3+vAKT88mnI4e3jhEUU3kGz/wXmnh
         vNZlDg8np7beR/z/x7CFWot8xHc+5k/arO8bkkhJ799zwSjhAj2bgY6OXo0s0Z2F1ZCU
         YuCTFREusKx1t6lyZphsB3kEqplKultSiffGRHjRiJEg5uYfU/+mNsTqqW5uE7zdgmyW
         TtyZ/CJEqe1N0vPJfb4SxG/NpPrzacuFF2Tqes7lC9BFlf0PcGN4ZCL4fyQ6VmasUaGA
         iXGp4B3mFgkBnK1KX8Tt+xYuH+N0Ug4g1o0kaX3kMIV/9CjZKZMrjlNavM4hyKlNT7LZ
         xYUw==
X-Gm-Message-State: AO0yUKXs/eOVdjRLM/mPjO74Aae5FQUb7EEQMezaKGUqtm2W9rSRnzA0
        r+Mdk6RgdQTw8BYlghXCNuw=
X-Google-Smtp-Source: AK7set8br1StPmJ6VLNmzpS9FfvB+x0aTOgZ56stNNaaMSPtzCyZcFKOAK3YPZvPz5kOxTh6Pxv1cw==
X-Received: by 2002:a17:903:22c8:b0:198:fded:3b69 with SMTP id y8-20020a17090322c800b00198fded3b69mr17180677plg.53.1677193774909;
        Thu, 23 Feb 2023 15:09:34 -0800 (PST)
Received: from google.com ([2620:15c:211:201:be5:a687:1e9d:ec53])
        by smtp.gmail.com with ESMTPSA id x3-20020a1709027c0300b00186b69157ecsm3419109pll.202.2023.02.23.15.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 15:09:34 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 23 Feb 2023 15:09:32 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv2 1/6] zsmalloc: remove insert_zspage() ->inuse
 optimization
Message-ID: <Y/fyLONTVVjEf22Q@google.com>
References: <20230223030451.543162-1-senozhatsky@chromium.org>
 <20230223030451.543162-2-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230223030451.543162-2-senozhatsky@chromium.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023 at 12:04:46PM +0900, Sergey Senozhatsky wrote:
> This optimization has no effect. It only ensures that
> when a page was added to its corresponding fullness
> list, its "inuse" counter was higher or lower than the
> "inuse" counter of the page at the head of the list.
> The intention was to keep busy pages at the head, so
> they could be filled up and moved to the ZS_FULL
> fullness group more quickly. However, this doesn't work
> as the "inuse" counter of a page can be modified by

                              zspage

Let's use term zspage instead of page to prevent confusing.

> obj_free() but the page may still belong to the same
> fullness list. So, fix_fullness_group() won't change

Yes. I didn't expect it should be perfect from the beginning
but would help just little optimization.

> the page's position in relation to the head's "inuse"
> counter, leading to a largely random order of pages
> within the fullness list.

Good point.

> 
> For instance, consider a printout of the "inuse"
> counters of the first 10 pages in a class that holds
> 93 objects per zspage:
> 
>  ZS_ALMOST_EMPTY:  36  67  68  64  35  54  63  52
> 
> As we can see the page with the lowest "inuse" counter
> is actually the head of the fullness list.

Let's write what the patch is doing cleary

"So, let's remove the pointless optimization" or something better word.

> 
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> ---
>  mm/zsmalloc.c | 29 ++++++++---------------------
>  1 file changed, 8 insertions(+), 21 deletions(-)
> 
> diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> index 3aed46ab7e6c..b57a89ed6f30 100644
> --- a/mm/zsmalloc.c
> +++ b/mm/zsmalloc.c
> @@ -753,37 +753,24 @@ static enum fullness_group get_fullness_group(struct size_class *class,
>  }
>  
>  /*
> - * Each size class maintains various freelists and zspages are assigned
> - * to one of these freelists based on the number of live objects they
> - * have. This functions inserts the given zspage into the freelist
> - * identified by <class, fullness_group>.
> + * This function adds the given zspage to the fullness list identified
> + * by <class, fullness_group>.
>   */
>  static void insert_zspage(struct size_class *class,
> -				struct zspage *zspage,
> -				enum fullness_group fullness)
> +			  struct zspage *zspage,
> +			  enum fullness_group fullness)

Unnecessary changes

>  {
> -	struct zspage *head;
> -
>  	class_stat_inc(class, fullness, 1);
> -	head = list_first_entry_or_null(&class->fullness_list[fullness],
> -					struct zspage, list);
> -	/*
> -	 * We want to see more ZS_FULL pages and less almost empty/full.
> -	 * Put pages with higher ->inuse first.
> -	 */
> -	if (head && get_zspage_inuse(zspage) < get_zspage_inuse(head))
> -		list_add(&zspage->list, &head->list);
> -	else
> -		list_add(&zspage->list, &class->fullness_list[fullness]);
> +	list_add(&zspage->list, &class->fullness_list[fullness]);
>  }
>  
>  /*
> - * This function removes the given zspage from the freelist identified
> + * This function removes the given zspage from the fullness list identified
>   * by <class, fullness_group>.
>   */
>  static void remove_zspage(struct size_class *class,
> -				struct zspage *zspage,
> -				enum fullness_group fullness)
> +			  struct zspage *zspage,
> +			  enum fullness_group fullness)

Ditto.

Other than that, looks good to me.
