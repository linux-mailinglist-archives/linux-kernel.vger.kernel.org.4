Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2951262CD4A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 23:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233413AbiKPWCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 17:02:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbiKPWCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 17:02:36 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C0B5802E
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 14:02:35 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id s4so18519qtx.6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 14:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qxY4awyAHKJmDzgFV4/XFR7JoWvntkbK8PIidM5n6xM=;
        b=P/vCSrVMxBTxgyyVTAGqr+kX3kUkSOkZLYm1Q2r2BYuCqLJu+e9z8dnDJrVt5FiBwI
         T7tGBJXhcikcEqZY0vtQMKgOP8Z2fn2vzRU/MX3hd9/ayXYz6OmlN7PnuZEO/aIsAalz
         THWfcZ4svC8CckJ1tjNytN6RU45d7ZSiZM4t/Ero/29lUjJxI710U5B5XQDCABk+WpQE
         V2f+EtZxzI9/Opm/FNSxap51ne2dgZgd1ROcoooPB6EYNQHTN6q8KHEu0kQ5Z4OnL5Dy
         3glFZ25xyx2h9MwTX7KTE1htr+y6qq/FFpk3iAR1shfgmU/BsmwTF4ZxQ20hTXvMdxVR
         Rb0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qxY4awyAHKJmDzgFV4/XFR7JoWvntkbK8PIidM5n6xM=;
        b=gZQRVBqH2OuSqEERuYQ5jiihoD2EF1RTRNG1OX1DHxP61FYm5oSzzd8Q0lYMDim+2I
         GqJZjI3VWGhVIAEm/P5SUsL8wFTnBGDLUkWw9aBlDBeNdh4EWgs9ge7mzYvYcRZEX921
         VN+QWjEaMcoVgzJtzXKXDDrnFJXkz2TuovsPVCDVuLLjMmrU9WFSOvdAQuDbOTSeYXaI
         heIUCLovwh4GNDkHpY74i8rLo5X8vyv31M3XGzQ17QvoVQLVDvIgAsnP0Wnw2eeaHNyH
         SWni8isCI5I6XrkqnUj5CJ4w9yW0mjPY5+6t3FTQxN6ctuf09CAknR7e+Ba/NmkYcEx4
         84Fw==
X-Gm-Message-State: ANoB5plZWgUIj9X7U4sTevSY5B+yplpPrfP7Vo1VIi4F5czvCZTY7cSb
        8EyueB0Xa1jKywQSN0WCN/BptA==
X-Google-Smtp-Source: AA0mqf7Th5PDDsD9O68ylLIPWunbWRrlLQwthWg1Kh4MqsG9RSMusxhrWmoykqWy/vdDK4jdLWj1Fw==
X-Received: by 2002:ac8:474b:0:b0:3a5:177d:d9cb with SMTP id k11-20020ac8474b000000b003a5177dd9cbmr23019179qtp.64.1668636154579;
        Wed, 16 Nov 2022 14:02:34 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:bc4])
        by smtp.gmail.com with ESMTPSA id u16-20020a37ab10000000b006bb29d932e1sm10593433qke.105.2022.11.16.14.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 14:02:34 -0800 (PST)
Date:   Wed, 16 Nov 2022 17:02:57 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Nhat Pham <nphamcs@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ngupta@vflare.org,
        senozhatsky@chromium.org, akpm@linux-foundation.org,
        sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: Re: [PATCH v3 3/5] zsmalloc: Add a LRU to zs_pool to keep track of
 zspages in LRU order
Message-ID: <Y3VeEV5Qjbk0/t47@cmpxchg.org>
References: <Y2wh4b3oMaknNqGP@google.com>
 <20221110171831.19176-1-nphamcs@gmail.com>
 <Y21/wAkXt7IH/tXN@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y21/wAkXt7IH/tXN@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 02:48:32PM -0800, Minchan Kim wrote:
> On Thu, Nov 10, 2022 at 09:18:31AM -0800, Nhat Pham wrote:
> > > Please put the LRU logic under config ZSMALLOC_LRU since we don't need the
> > > additional logic to others.
> > 
> > I think the existing CONFIG_ZPOOL would be a good option for this purpose. It
> > should disable the LRU behavior for non-zswap use case (zram for e.g). The
> > eviction logic is also currently defined under this. What do you think,
> > Minchan?
> 
> That sounds good.
> 
> Sergey and I are working to change zsmalloc zspage size.
> https://lore.kernel.org/linux-mm/20221031054108.541190-1-senozhatsky@chromium.org/
> 
> Could you send a new version once we settle those change down
> in Andrew's tree to minimize conflict?
> (Feel free to join the review/discussion if you are also interested ;-))

I've been reading through that thread, and it doesn't look like it'll
be ready for the upcoming merge window. (I've tried to contribute
something useful to it, but it's a fairly difficult tuning problem,
and I don't know if a sysfs knob is the best answer, either...)

Would you have any objections to putting Nhat's patches here into 6.2?

It doesn't sound like there was any more feedback (except the trivial
ifdef around the LRU), and the patches are otherwise ready to go.
