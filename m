Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 418896EBD50
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 08:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjDWGI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 02:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjDWGI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 02:08:56 -0400
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A92191BC2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Apr 2023 23:08:54 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VgibI3g_1682230129;
Received: from 30.97.49.3(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VgibI3g_1682230129)
          by smtp.aliyun-inc.com;
          Sun, 23 Apr 2023 14:08:50 +0800
Message-ID: <89dc2886-daeb-67ff-be6d-4d70343d2d8b@linux.alibaba.com>
Date:   Sun, 23 Apr 2023 14:08:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [PATCH v2 1/4] mm/filemap: Add folio_lock_timeout()
To:     Hillf Danton <hdanton@sina.com>,
        Douglas Anderson <dianders@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Yu Zhao <yuzhao@google.com>,
        Matthew Wilcox <willy@infradead.org>
References: <20230421221249.1616168-1-dianders@chromium.org>
 <20230422051858.1696-1-hdanton@sina.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230422051858.1696-1-hdanton@sina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/4/22 13:18, Hillf Danton wrote:
> On 21 Apr 2023 15:12:45 -0700 Douglas Anderson <dianders@chromium.org>
>> Add a variant of folio_lock() that can timeout. This is useful to
>> avoid unbounded waits for the page lock in kcompactd.
> 
> Given no mutex_lock_timeout() (perhaps because timeout makes no sense for
> spinlock), I suspect your fix lies in the right layer. If waiting for
> page under IO causes trouble for you, another simpler option is make
> IO faster (perhaps all you can do) for instance. If kcompactd is waken
> up by kswapd, waiting for slow IO is the right thing to do.


A bit out of topic.  That is almost our original inital use scenarios for
EROFS [1] although we didn't actually test Chrome OS, there lies four
points:

  1) 128kb compressed size unit is not suitable for memory constraint
     workload, especially memory pressure scenarios, that amplify both I/Os
     and memory footprints (EROFS was initially optimized with 4KiB
     pclusters);

  2) If you turn into a small compressed size (e.g. 4 KiB), some fs behaves
     ineffective since its on-disk compressed index isn't designed to be
     random accessed (another in-memory cache for random access) so you have
     to count one by one to calculate physical data offset if cache miss;

  3) compressed data needs to take extra memory during I/O (especially
     low-ended devices) that makes the cases worse and our camera app
     workloads once cannot be properly launched under heavy memory pressure,
     but in order to keep user best experience we have to keep as many as
     apps active so that it's hard to kill apps directly.  So inplace I/O +
     decompression is needed in addition to small compressed sizes for
     overall performance.

  4) If considering real-time performance, some algorithms are not quite
     suitable for extreme pressure cases;

  etc.

I could give more details on this year LSF/MM about this, although it's not
a new topic and I'm not a Android guy now.

[1] https://www.usenix.org/conference/atc19/presentation/gao

Thanks,
Gao Xiang

> 
> 
