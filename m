Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 222DB6335B0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 08:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbiKVHK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 02:10:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiKVHKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 02:10:21 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F5D303E8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 23:10:20 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id k2so9647721qkk.7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 23:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N0ePOSWm5GF0+U93OsaUkQqKYc/c980Yryga0ApomJ0=;
        b=2AS8IwguOVXBUzclfYlmbCqYBHG0NHX+aQ3smSIgb1aDeYTSneuiqM1lRUGI57ueox
         CqNiKQS4Fh73VOCUKCay2gN86S67NKcmRzh59+aE0F+8CEHW17KDjcgc3Y2pwd4iqLXv
         c/Rj/NjZQxPWUSyb5EoJhC28oN8FRjqEJZr/GAVCIHgXlEBL6zaCpWhJ6zatcfn37Lau
         MhBjtdfecBLj+BGLoU7nSLzYEvIcJoUB+U+3r0XAoUOcOPGi3v+JBUWygJEnWWhSq64o
         IxPLC0b0ZpggBGiTcu4sLDvQihOYIH9gAmToKUy6SvAuf5tU07VZm6FKmKmE96VmhXPZ
         bWZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N0ePOSWm5GF0+U93OsaUkQqKYc/c980Yryga0ApomJ0=;
        b=6BIX3RONwwQxmHPb2Yqf9piclb2RoP9iLf7gJbYOHwyooecE0mHyV6WEXbNC4r23D8
         T+PxyeNzmCOZXAC4H8L/4MxWkykFabNWirJPMwzd+hMcukijhHKe8JR98YTlXgrkqzxg
         EhRwz6zYhYHgg/F3F+zAP4rB7vbulXj9kYNuep4FVMrvdbCG68IpibtjSllh0t5WOmiU
         wnRSBPTMVoDpGkAn3uqjQWO59wN4x7CehSXqjIifn6KKgabOkdNiSlhIj2I2rUC3dIPk
         xNIGOrmgW9UL5kvTwVP6uUjiVuYAZ5KFVSaVTQ1tEA2i7gZxX5DkA1lDsEFCtOMDi00O
         WtmQ==
X-Gm-Message-State: ANoB5pk3850zxXsTc3zZy3a6EfeZbBnNl+Kg/U7270anALcQqguvi7Tn
        QUwlntLy3O8EG/CUhyudFUU11A==
X-Google-Smtp-Source: AA0mqf5uIsVlGin2a0JGaSWWceiuaeqiHi/K1ZQltP+24OvdER1NKz2UraFtIV1/KNqJPuv6DHNY8w==
X-Received: by 2002:a05:620a:1423:b0:6f3:e3b7:6a5b with SMTP id k3-20020a05620a142300b006f3e3b76a5bmr19599460qkj.607.1669100986453;
        Mon, 21 Nov 2022 23:09:46 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:bc4])
        by smtp.gmail.com with ESMTPSA id x13-20020a05620a448d00b006fa4ac86bfbsm9604082qkp.55.2022.11.21.23.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 23:09:45 -0800 (PST)
Date:   Tue, 22 Nov 2022 02:10:11 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        minchan@kernel.org, ngupta@vflare.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: Re: [PATCH v6 6/6] zsmalloc: Implement writeback mechanism for
 zsmalloc
Message-ID: <Y3x109XxGY02Y7Vp@cmpxchg.org>
References: <20221119001536.2086599-1-nphamcs@gmail.com>
 <20221119001536.2086599-7-nphamcs@gmail.com>
 <Y3wwuMSy8YC86QAi@google.com>
 <Y3w+C8ClzP6VbqrA@cmpxchg.org>
 <Y3xFHIgkiZNYCbHi@google.com>
 <Y3xnf7pR4vI7o9PV@cmpxchg.org>
 <Y3xtpoQpb8DuiTlh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3xtpoQpb8DuiTlh@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 03:35:18PM +0900, Sergey Senozhatsky wrote:
> On (22/11/22 01:09), Johannes Weiner wrote:
> > On Tue, Nov 22, 2022 at 12:42:20PM +0900, Sergey Senozhatsky wrote:
> > > On (22/11/21 22:12), Johannes Weiner wrote:
> > > > On Tue, Nov 22, 2022 at 11:15:20AM +0900, Sergey Senozhatsky wrote:
> > > > > On (22/11/18 16:15), Nhat Pham wrote:
> 
> [..]
> 
> > > What I meant was: if zs_reclaim_page() makes only partial progress
> > > with the current LRU tail zspage and returns -EAGAIN, then we just
> > > don't increment `total` and continue looping in zs_zpool_shrink().
> > 
> > Hm, but it breaks on -EAGAIN, it doesn't continue.
> 
> Yes. "What if it would continue". Would it make sense to not
> break on EAGAIN?
> 
> 	while (total < pages) {
> 		ret = zs_reclaim_page(pool);
> 		if (ret == -EAGAIN)
> 			continue;
> 		if (ret < 0)
> 			break;
> 		total++;
> 	}
> 
> Then we don't need retry loop in zs_reclaim_page().

But that's an indefinite busy-loop?

I don't see what the problem with limited retrying in
zs_reclaim_page() is. It's robust and has worked for years.
