Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC5B6F8984
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 21:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232390AbjEET33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 15:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232168AbjEET31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 15:29:27 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C90ECC
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 12:29:26 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-61b6a4233a1so20438036d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 12:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1683314965; x=1685906965;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k4OBZwOfgQ7iDHjVCotWx7AHHpe0XJZsVACen/SNKMA=;
        b=XAhb1T95EXEreL7o7txc4tTPVAfb8y2l+kO5fRiLkDiFggNZdCfj5IOw/yGO70oQF7
         eTSAkEvWhHGIaq9saW6YSNl1dGPfTyYDcICwQe3jzT0P7pmBwJWdzUn5kXtRqoFgtmv9
         akK6FqxuxZSPZjjuwzXuluOeOMV9TCW1KIuTo7b0OX5hmjoSQCqsQ8z2ksJ6JK3nFPaU
         D7v9RGNumb4VCZpWScTvA0ooTZfsvALxGMiGqWYyiRUmtT3iDzqVYGYTxbYNbkJbCQqE
         Fa6xGOYBuEvbSAgqoD/rL1tcy/TNkjvIUQnYZkLwi0icgUAVFPttml2rFd7Nqw1uYziL
         7yDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683314965; x=1685906965;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k4OBZwOfgQ7iDHjVCotWx7AHHpe0XJZsVACen/SNKMA=;
        b=NB8/+KetF22NsLZ+G6S+cYBTkY5hhn+3IbGgTfkRQ1qPPnxa5FFxAdw73imCbfInU9
         cV88akqjsKTPCOGADqcjNjWPVbQ3ASCXi+0s5Zlrvg5zaPny9hYBOLV8wc8UJm7oC5Tg
         ZPMyTpU071eJ1rR0cj6S6pkI1mdROFbVq5A6UWNjjlylfRYWPLbUb+rmOLAPZMPiq2Yt
         5+BwhDiqVZnDRC7EiLUEOmzNqGPB5tSJAPU4KQ/SWxzoM6gGphWvgq2PtgkGyGTe+2SK
         MCopM15ScluF8VZesAn8g9mVoZSVbnkYVe9v1gSIGVsSVJNVmBI7ShDEtjj82d/rkbBx
         IlNw==
X-Gm-Message-State: AC+VfDyg/DgegqG65FTPtebt/U/n9CuacLUrwLlcCIllS/eWY6JEUQWW
        xFWAwBK+Fgbt002SwB5dJDOT+g==
X-Google-Smtp-Source: ACHHUZ6AGTOxdftQQ/CWty8p4ItRKTM3t/EBI+AzATnRtG8hajEGHvAOBZUrmliUPxPQHYVCyY/d8Q==
X-Received: by 2002:ad4:5baa:0:b0:5e6:3da1:70fd with SMTP id 10-20020ad45baa000000b005e63da170fdmr4012038qvq.25.1683314965378;
        Fri, 05 May 2023 12:29:25 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:57f7])
        by smtp.gmail.com with ESMTPSA id z12-20020a0cf24c000000b0061b7bbb7624sm792932qvl.130.2023.05.05.12.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 12:29:25 -0700 (PDT)
Date:   Fri, 5 May 2023 15:29:24 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Nhat Pham <nphamcs@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, minchan@kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com, kernel-team@meta.com
Subject: Re: [PATCH] zsmalloc: move LRU update from zs_map_object() to
 zs_malloc()
Message-ID: <20230505192924.GA855623@cmpxchg.org>
References: <20230505185054.2417128-1-nphamcs@gmail.com>
 <20230505121401.31826e1251fb8792fe64f675@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230505121401.31826e1251fb8792fe64f675@linux-foundation.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 05, 2023 at 12:14:01PM -0700, Andrew Morton wrote:
> On Fri,  5 May 2023 11:50:54 -0700 Nhat Pham <nphamcs@gmail.com> wrote:
> 
> > Under memory pressure, we sometimes observe the following crash:
> > 
> > [ 5694.832838] ------------[ cut here ]------------
> > [ 5694.842093] list_del corruption, ffff888014b6a448->next is LIST_POISON1 (dead000000000100)
> > 
> > ...
> > 
> > Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> > Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> 
> Am I correct in believing that we should backport this fix into earlier
> kernels?
>
> And that a suitable Fixes: target is 64f768c6b32e ("zsmalloc: add a LRU
> to zs_pool to keep track of zspages in LRU order)"?

Yes, I agree. The tags in the mm-unstable commit look right to me.

Thanks
