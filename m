Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDBBA6A2E37
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 05:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjBZElH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 23:41:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBZElF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 23:41:05 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D977EA267
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 20:41:03 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id qa18-20020a17090b4fd200b0023750b675f5so6842669pjb.3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 20:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5CkI3p95+BKxUz3UWDc+PdmENtlxKtCdnLjz+5IgsQQ=;
        b=UnHE4lQlNzpEc7o594cjMh7FEmzUagPxnugcL8/vxuPrP3xXB+9JKtEH4Er6vrcqbI
         kwnqV07WkfFkzPz4xGNfVrSOxu2zUP3YFxEOzu5A9Q9RzPhA9Y97ez/zEoMHN32Tfeax
         1iO+WITmmKbRE0T8msIjVf5UClSgl51KHK1EM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5CkI3p95+BKxUz3UWDc+PdmENtlxKtCdnLjz+5IgsQQ=;
        b=N6kRx4INNln3+qVTNCkVkQ4Opf3ucZqc7NhS4oxbL//h5VKLn36nfeBnrTwxURzVLR
         77eDDYoJh/kFy1F9OAcmHOF8UCCtkimlwQ84v/YuQEusZNpxf2EWwdiRChcSLC7hBAXy
         OMV2VJiaPT0HsOHOXyzXq71Jt9T1Ca95Byyv4vsffd/dme2TYLWNo5Rv/bgWFlpcGRlH
         pt8bR2tlNfDcwaQnWCfkmSiYQ9SrZ1BBjbczKab25KB0S6/yFGwMx6UL2/0fSSVLGka4
         o6b/qi7l87XkQMu4Jtxh7gbzb4FgnTG7Ah7q9xo3GJIEU/4vTUbaOR+R7nhyikGIcKtX
         rReg==
X-Gm-Message-State: AO0yUKX6diUSDLjahV2lAa894h4QMtVZmna3Gb6Dk/KencaTnnzNyP41
        J7X3KXkoKBcDGr7iKLtnzVq7LA==
X-Google-Smtp-Source: AK7set+8v6utm/rjrX3ZwqE6MyvujVXPUFILKFPT9BPLT873DmDNG9xsP1nuJYyH7Dm5AYcZ+QIFPA==
X-Received: by 2002:a17:90b:4f8f:b0:234:190d:e636 with SMTP id qe15-20020a17090b4f8f00b00234190de636mr22436929pjb.8.1677386463323;
        Sat, 25 Feb 2023 20:41:03 -0800 (PST)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id o8-20020a17090a3d4800b00233ebab3770sm1989594pjf.23.2023.02.25.20.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Feb 2023 20:41:02 -0800 (PST)
Date:   Sun, 26 Feb 2023 13:40:58 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv2 1/6] zsmalloc: remove insert_zspage() ->inuse
 optimization
Message-ID: <Y/ri2v4w+1bSu2J/@google.com>
References: <20230223030451.543162-1-senozhatsky@chromium.org>
 <20230223030451.543162-2-senozhatsky@chromium.org>
 <Y/fyLONTVVjEf22Q@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/fyLONTVVjEf22Q@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/02/23 15:09), Minchan Kim wrote:
> 
> On Thu, Feb 23, 2023 at 12:04:46PM +0900, Sergey Senozhatsky wrote:
> > This optimization has no effect. It only ensures that
> > when a page was added to its corresponding fullness
> > list, its "inuse" counter was higher or lower than the
> > "inuse" counter of the page at the head of the list.
> > The intention was to keep busy pages at the head, so
> > they could be filled up and moved to the ZS_FULL
> > fullness group more quickly. However, this doesn't work
> > as the "inuse" counter of a page can be modified by
> 
>                               zspage
> 
> Let's use term zspage instead of page to prevent confusing.
> 
> > obj_free() but the page may still belong to the same
> > fullness list. So, fix_fullness_group() won't change
> 
> Yes. I didn't expect it should be perfect from the beginning
> but would help just little optimization.
> 
> > the page's position in relation to the head's "inuse"
> > counter, leading to a largely random order of pages
> > within the fullness list.
> 
> Good point.
> 
> > 
> > For instance, consider a printout of the "inuse"
> > counters of the first 10 pages in a class that holds
> > 93 objects per zspage:
> > 
> >  ZS_ALMOST_EMPTY:  36  67  68  64  35  54  63  52
> > 
> > As we can see the page with the lowest "inuse" counter
> > is actually the head of the fullness list.
> 
> Let's write what the patch is doing cleary
> 
> "So, let's remove the pointless optimization" or something better word.

ACK to all feedback (for all the patches). Thanks!
