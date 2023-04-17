Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 174F56E3E57
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 05:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbjDQDwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 23:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjDQDwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 23:52:43 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659BD139
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 20:52:42 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id l9-20020a17090a3f0900b0023d32684e7fso13144057pjc.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 20:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681703562; x=1684295562;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WTaC8jFgNYlM5AivUFM1gcPJigYzK2LIKWBXEllK3W4=;
        b=AUGJzuQSHCt5UDqx0rTAL9Yy+SUketTabUza7NWFbx6ye/lM2ccblA2XDccgSL6t0A
         Y0tGvwJJABKr8V7HPsklXM+p2dKulUFjWF8Qy60OijlGaqN+Z/M4Jcf8PM4YMNS9oIKP
         nF1cg82F10dUw8LMDAoo69tRUlBsBHQ9Y5kcU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681703562; x=1684295562;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WTaC8jFgNYlM5AivUFM1gcPJigYzK2LIKWBXEllK3W4=;
        b=TO36I47iBFg3gaGlq5YtFmJQXDdxnUlJMDPIBWyRECsT/+t5c5TkW0TYzslS0n7Hbe
         w1ovwq5UMJEALr4RLRAGQIw4lkQD1wtlM8AH/SCCY29qoVFl5b4LtBrhesuauJO8G7YY
         wtdmKlIOSdOl5mfTHd8Kt7YYtsF7Vq6RLUhm/8l5MIEj4MG4hZ+j2Q6vJGqpxrtOFS6F
         fwPrjjiUhZAV38V3tqEeW5KDsOSO4I7yemMOlzB+FbupanI462VMWIKHx+Q4V/xorJHK
         RErFey+qadXZg1SEd4kq/Zk09PdWrq1Af2A8z6wH5x0ClzDBFN7AiIhgM5vffWs3dYQG
         845Q==
X-Gm-Message-State: AAQBX9dtja1hgXuk2LSepJhNq/JKoq6JZfH4nfDCuGk5CvO8Rxw905Qr
        52AMJRgHr+O/zjqrWbX6vE4IFA==
X-Google-Smtp-Source: AKy350ZjJaBAPjIQ0A+KuGsO0zL6zvEp0Xd2pzMmZYTQAp9T09sikxUohuI9HvTgFyfudYcq/ylLLA==
X-Received: by 2002:a17:902:cec1:b0:1a1:e33f:d567 with SMTP id d1-20020a170902cec100b001a1e33fd567mr13736769plg.52.1681703561783;
        Sun, 16 Apr 2023 20:52:41 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id p7-20020a170903248700b001a68d45e52dsm6090709plw.249.2023.04.16.20.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 20:52:41 -0700 (PDT)
Date:   Mon, 17 Apr 2023 12:52:32 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv4 0/4] zsmalloc: fine-grained fullness and new compaction
 algorithm
Message-ID: <20230417035232.GM25053@google.com>
References: <20230304034835.2082479-1-senozhatsky@chromium.org>
 <CAOUHufZ6jPLJYeshO8=2TaqXRmpOFuMQ92E9sg-oCh54fkqW7g@mail.gmail.com>
 <20230416151853.GK25053@google.com>
 <CAOUHufZk+dxE8UXWwGzGbX1BYxomD_25u2xoWt3vnoQp4xSZqw@mail.gmail.com>
 <20230417024446.GL25053@google.com>
 <CAOUHufYJtB0n314GnMH1ByXL5PTtzzsrMvi2YbHz2YVqTTcYfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOUHufYJtB0n314GnMH1ByXL5PTtzzsrMvi2YbHz2YVqTTcYfA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/04/16 20:55), Yu Zhao wrote:
> > Do you run some specific test?
> 
> E.g.,
>   tools/testing/selftests/kvm/max_guest_memory_test -c 112 -m 800 -s 800
> with 112 CPUs and ~770GB DRAM + 32GB zram.

Hmm ...

Something like this maybe?

The src zspage pointer is not NULL-ed after non-empty zspage is
put back to corresponding fullness list.

---

@@ -2239,8 +2241,8 @@ static unsigned long __zs_compact(struct zs_pool *pool,
                if (fg == ZS_INUSE_RATIO_0) {
                        free_zspage(pool, class, src_zspage);
                        pages_freed += class->pages_per_zspage;
-                       src_zspage = NULL;
                }
+               src_zspage = NULL;

                if (get_fullness_group(class, dst_zspage) == ZS_INUSE_RATIO_100
                    || spin_is_contended(&pool->lock)) {
