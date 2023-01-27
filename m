Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E414567DC55
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 03:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233525AbjA0CkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 21:40:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232017AbjA0Cj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 21:39:59 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8FD6539AE
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 18:39:58 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id x2-20020a17090a46c200b002295ca9855aso7260702pjg.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 18:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JmA1hDZ+MeoPFm9Yjjv0t7YVH1mZV4xy4MwoNik2CbQ=;
        b=tBLISifPko9ljpQXoRW1C/WvYxncmvA27w9hF/z1oOC3769navvqXQ2aSLcOoi15GZ
         NMbjqKBRBg5qrDhIbEaTz89p7VEUm2IiZ53NJiV2N4c9DR+gVc0dLpE0J5t5WX5V2nvl
         /Vpqb/uAenFA74Ffkfoppsdig9IWA0kEjOz4Q2VJd0qzGDwH5J8ji2NYRQFz7HfjjLrr
         wS8RA76snYI8CxEOx0JHnlFfD7kPaNhgQTlCQgBxM512r8WQNwjdLNlBkQU0a4Riv+8H
         5PVfPhsJyR6qFKi+jcYoMGmf5EvcPqOga2/4u2hDutt9h2VwPYX7or0dIQXLyXUiNJ1A
         MLgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JmA1hDZ+MeoPFm9Yjjv0t7YVH1mZV4xy4MwoNik2CbQ=;
        b=wlghT+4dSKvazyS7/mPziQHhKUSN/ws8j0PvgHmX3iU9hLD/r7HXpP9NQsa+suvyTm
         6hLQhKFsENlkUxOBT2lI3WStgerK3OF6u5p4k1C6wrxeOU/hxVEzKUwrImMAu/wzdqhY
         bCMR7dhKz3HCKI1FtXM06r0n0sO9Fifwgc5nD2UbdTJ/HympCCnfGrUPRnzg6FAtWnbJ
         hDDwIiHDRvAI1/B0qB0xbN5KwXQBcWhjCvQ+YOz4UoYh0pC/tsx3PHAKmJ3q/YtMEueL
         l35ZGDt0kr0U6tz+F2LAEF5oEUL9YgwP3Z/tu87Tnyh47ZAitFftKQ15om8RxpeOiuKx
         0mpw==
X-Gm-Message-State: AO0yUKV36weyqSfedG2Q2RKLNV0YsoFMlU60yuHNXvwhqxVllWLlwdLe
        mWlWDkVCI02c5V3V+YwdfoaEZA==
X-Google-Smtp-Source: AK7set9gr8/5ImFQDM4ddHsTo3zTKcVeS38DHQOR23X+Tb9p8uf/UMnwHvYLYorFup38S3BtMufcXw==
X-Received: by 2002:a17:902:7886:b0:194:d5ff:3ae3 with SMTP id q6-20020a170902788600b00194d5ff3ae3mr1228848pll.2.1674787197920;
        Thu, 26 Jan 2023 18:39:57 -0800 (PST)
Received: from google.com ([2620:15c:2d:3:497:8b7d:bb75:1c3])
        by smtp.gmail.com with ESMTPSA id y14-20020a17090322ce00b00196191b6b29sm1649839plg.140.2023.01.26.18.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 18:39:57 -0800 (PST)
Date:   Thu, 26 Jan 2023 18:39:53 -0800
From:   Isaac Manjarres <isaacmanjarres@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Saravana Kannan <saravanak@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        kernel-team@android.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v1 0/2] Fixes for kmemleak tracking with CMA regions
Message-ID: <Y9M5eYzJcFbwlC9g@google.com>
References: <20230109221624.592315-1-isaacmanjarres@google.com>
 <Y8gpfgEXtialPVLk@arm.com>
 <Y8neaPB2y689WKOf@google.com>
 <Y8/96eIu47UfqsWO@arm.com>
 <Y9BLfUz5GY69zmjn@google.com>
 <Y9Eb2k3COoUXJ0CB@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9Eb2k3COoUXJ0CB@arm.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2023 at 12:08:58PM +0000, Catalin Marinas wrote:
> That's an option. If there's too much churn to add a flag, an
> alternative is to use the bottom bit of 'end' to set the noleaktrace
> flag.
Using the least significant bit won't work; there are allocations for
CMA regions that can be specified to occur within the first 4 GB of
memory, and would have an alloc-ranges of [0 0xffff_ffff]. I also don't
think there's anything in the memblock documentation that ensures that
those bits are supposed to be clear all the time.

> Yet another idea is to avoid the kmemleak callback on all the 'phys'
> memblock allocations. We can add the callback to the higher level
> memblock_alloc() which returns a VA but the lower level 'phys' variants
> could simply avoid it. However, I think we still need the
> MEMBLOCK_ALLOC_NOLEAKTRACE flag for the kasan shadow allocation. Well,
> given that this flag is not widely used, we can add explicit
> kmemleak_ignore() calls in those four places.
> 
> I think the latter, if it works, would be the least intrusive.

I agree; I think using kmemleak_ignore() would be best. I will
split that into series: 1 series that fixes the kmemleak issue
with CMA regions by reverting Calvin's patch and adding a call
to kmemleak_ignore in the call-stack I referenced earlier, and
then another series that cleans up the usage of the flag.

--Isaac
