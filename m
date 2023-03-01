Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862876A66DA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 05:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjCAEF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 23:05:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjCAEF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 23:05:26 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382A21517F
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 20:05:25 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id a9so2554209plh.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 20:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2FPGRrE+V/xFQnOXY47Z4N5HYXwwKgdZ1V3Mwf45FFw=;
        b=HR8GKavdpOywG5msuZfmCzJY8trT5TMtz0JxwK42GoYzZQ3BRSdh95NC9MZ2Gs6dB9
         /8/Bi8h70aBOVv9tPJSASYflzLWjCiHcWLY6jrCTO9qBD72/Xe+r3ell0M3PkCyqYpPS
         9hdXYMXaGYn5liN+yf6qKoaW4obLlwtHRZfCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2FPGRrE+V/xFQnOXY47Z4N5HYXwwKgdZ1V3Mwf45FFw=;
        b=KiLVbCdGVgl4mjdr7qX4FXW2kdA7V8C9sYTE4JZn3pluItVrN70iwlRkTrIVz+f9Q0
         2hmF2ehyPIv/V3yzWhz9PILy0tI30u9Zw+e/M6NVkxIdLHhte1qvmgSuwraLEpWo6o4b
         w1fbl2MUQPKoOzhQPrVqiv+lgIEvZ+cyn6abDsbTnZhlQ7+16HeZ7J7xdoRns94+jAL5
         RihUPymqtitxxY98YAtp7DYKaxhyfxw+U1701oBtAs6jaN0myTS4Ntyvb5oN4b6gPMkt
         HK2YzTjAOe1TYM0Hr75YrAPxi9FJKonAoBo0bBwfYU/t3+EmJi4HqtnWpvWeLcK5J8zx
         CZ/g==
X-Gm-Message-State: AO0yUKUTZG5sw+nyRzUdT0Hq+awdp6yn65mudoxCn0n2iVcRD/T1V5OF
        4NszwVPE+VHvkvLyTdfytUNbcw==
X-Google-Smtp-Source: AK7set8UDDWK+HqQf3vdr+m6xpSpUGiLi5vsnrM+tZBNDX0NwjF7KAiTN2QnAELwgMYpevySd0uRWg==
X-Received: by 2002:a17:902:74c4:b0:19d:1bc8:4889 with SMTP id f4-20020a17090274c400b0019d1bc84889mr4422404plt.57.1677643524679;
        Tue, 28 Feb 2023 20:05:24 -0800 (PST)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id l17-20020a170902eb1100b001992fc0a8eesm7269787plb.174.2023.02.28.20.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 20:05:24 -0800 (PST)
Date:   Wed, 1 Mar 2023 13:05:20 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv2 3/6] zsmalloc: fine-grained inuse ratio based fullness
 grouping
Message-ID: <Y/7PAAIfI1pydXWs@google.com>
References: <20230223030451.543162-1-senozhatsky@chromium.org>
 <20230223030451.543162-4-senozhatsky@chromium.org>
 <Y/f2WvhNlwhsf2Cz@google.com>
 <Y/riPlQ2UK00WirI@google.com>
 <Y/6GAYJ4c9W0bPzp@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/6GAYJ4c9W0bPzp@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/02/28 14:53), Minchan Kim wrote:
[..]
> > As of why I decided to go with defines, this is because zspage fullness
> > values and class stats are two conceptually different things, they don't
> > really fit in one single enum, unless enum's name is "zs_constants".
> > What do you think?
> 
> Agree. We don't need to combine them, then. 
> BTW, I still prefer the enum instead of 10 define.
> 
> enum fullness_group {
>     ZS_EMPTY,
>     ZS_INUSE_RATIO_MIN,
>     ZS_INUSE_RATIO_ALMOST_FULL = 7,
>     ZS_INUSE_RATIO_MAX = 10,
>     ZS_FULL,
>     NR_ZS_FULLNESS,
> }

So we keep enum nesting? Sorry, I'm not exactly following.

We have fullness values (which we use independently) and stats array
which has overlapping offsets with fullness values.

[..]
> > I can change it to
> > 
> > 	for (r = ZS_INUSE_RATIO_10; r <= ZS_INUSE_RATIO_70; r++)
> > and
> > 	for (r = ZS_INUSE_RATIO_80; r <= ZS_INUSE_RATIO_99; r++)
> > 
> > which would be safer than using hard-coded numbers.
> 
> I didn't mean to have hard code either but just wanted to show
> the intention to use the loop.

Got it. I just wanted to show that being very verbose (having every
constant documented) is nice :)

> > 
> > Shall we actually instead report per inuse ratio stats instead? I sort
> > of don't see too many reasons to keep that below/above 3/4 thing.
> 
> Oh, yeah. Since it's debugfs, we would get excuse to break.

This was in my original patch, but I decided to put a comment and keep
the old  behavior. I probably will switch to a more precise reporting
(per inuse ratio) in a separate patch, so that we can easily revert it
without any impact on new fullness grouping.
