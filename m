Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC8215BD99B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 03:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbiITBqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 21:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiITBqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 21:46:07 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02DD4E602
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 18:46:05 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id f9so1416626lfr.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 18:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=SiROIzHdLfdD7MXkY/PQu07S3gAEb3MJz3ltBVhCFts=;
        b=FuGPRnmnGnWAfxVFOhTFaINj5IEF45tiLxl4GJjvtCqJREqPIZoy2MXft7Eh9FqxcK
         7AWd7UNeKebDzDfcgKtmklu87k8UDVzyWo1IgiUzixekxKgLvSA7bVoDcmf2Aa52f9Dk
         3/CjTbk1g2abyKsDkACF54Ik1xrRIsZx5myEDh779eiftW1ztbE0K3+2U2GhQQHLUFF3
         2Y0EkmaH+Ks4GgPXwa9X8BR1MihiR8IUUjWQYIqmaqHJPXYCt2o7MlwhRmismjWf1/aP
         /igFLJN/MsEQSa1wUFGlZ6efUF9kwMnBgCcWW4cmyARlDtFrMT2Umtbh4d/sRGh5gf0t
         1dEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=SiROIzHdLfdD7MXkY/PQu07S3gAEb3MJz3ltBVhCFts=;
        b=vlD5do14FIQJFRFyz8tHD9fpSBQZ1Ik4Zfv/yLFpb8cmo4pZx64/hEfeTN+Fg6d9vz
         xWNthFibkit1oYD4I+Ma07ycf5gNXQhHFihqZJXGp4f3hJ0EMbPzZIyhBSu9SKQjEZ7h
         vr2WwUoAYjEuW7v/NxsviMr0+EtBRNpOp03zDT196On/m/cfZAenexBeYQkUmHbndR9j
         1ozIbp7aYvyAEIOUYL+KzjHpHKjmW6WR1+IS9MrzZwaGB6ABCKSgk37VTUdhhjGDvAk0
         8uvJaK2yWiLE8bfs2NE+Is+vSE9hfgXlLbzH8SzDwlT5IgJ3a34z85yZNKmk4UDDr6M+
         RxHw==
X-Gm-Message-State: ACrzQf3FnYtvpBxEBLJpiJXXQJRCPRltPgLygTpD0JJQSXduQiwn8F9d
        eqGTfGyk1pGfHhoRQ24hqjdyG4BgbV3ZoHnTj8LmZ/qt
X-Google-Smtp-Source: AMsMyM4+mvkBq1ml2Ucbtd0poKJ629xI1B25b9Jj50XgMwBW7hrZio/+hObBH9+I8W1/iDPNKDoWNxf7xEZeLmlewgw=
X-Received: by 2002:a05:6512:2242:b0:49d:7f0e:eb4b with SMTP id
 i2-20020a056512224200b0049d7f0eeb4bmr6860772lfu.128.1663638364151; Mon, 19
 Sep 2022 18:46:04 -0700 (PDT)
MIME-Version: 1.0
References: <1663325892-9825-1-git-send-email-zhaoyang.huang@unisoc.com> <20220919101629.xlafi2y2dk357wk3@techsingularity.net>
In-Reply-To: <20220919101629.xlafi2y2dk357wk3@techsingularity.net>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Tue, 20 Sep 2022 09:45:35 +0800
Message-ID: <CAGWkznFEBDwDVeR1AH6gk30PHU3pvSHBusOSQgEB2L7mZD4Mxg@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: check global free_list if there is ongoing
 reclaiming when pcp fail
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, Ke Wang <ke.wang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2022 at 6:22 PM Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Fri, Sep 16, 2022 at 06:58:12PM +0800, zhaoyang.huang wrote:
> > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> >
> > Check the global free list again even if rmqueue_bulk failed for pcp pages when
> > there is ongoing reclaiming, which could eliminate potential direct reclaim by
> > chance.
> >
> > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
>
> Patch does not apply and may be based on a custom kernel that introduced
> a problem. There is no description of what problem this is trying to
> fix. Checking the status of reclaim for a specific zone in this path would
> be a little unexpected.  If allocation pressure is exceeding the ability
> of reclaim to make progress then the caller likely needs to take action
> like direct reclaim. If the allocation failure is due to a high-order
> failure then it may need to enter direct compaction etc.
Agree with the above comment. This is a proposal aiming at avoiding
direct reclaiming things with minimum cost, that is to say, about 5
CPU instructions in return with the overhead of function calls which
has both of several loops inside and potential throttle sleep by IO
congestion etc.
>
> --
> Mel Gorman
> SUSE Labs
