Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA4969415C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 10:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbjBMJhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 04:37:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbjBMJgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 04:36:50 -0500
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E2D15C87
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 01:35:51 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=guorui.yu@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VbZAMby_1676280947;
Received: from 30.221.130.243(mailfrom:GuoRui.Yu@linux.alibaba.com fp:SMTPD_---0VbZAMby_1676280947)
          by smtp.aliyun-inc.com;
          Mon, 13 Feb 2023 17:35:49 +0800
Message-ID: <36c2bc37-714b-2251-942f-1d02f4b77d5a@linux.alibaba.com>
Date:   Mon, 13 Feb 2023 17:35:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH] swiotlb: fix the deadlock in swiotlb_do_find_slots
To:     kernel test robot <lkp@intel.com>, hch@lst.de,
        m.szyprowski@samsung.com
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        robin.murphy@arm.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, xiaokang.hxk@alibaba-inc.com
References: <20230213063604.127526-1-GuoRui.Yu@linux.alibaba.com>
 <202302131748.pa5NGbb9-lkp@intel.com>
From:   Guorui Yu <GuoRui.Yu@linux.alibaba.com>
In-Reply-To: <202302131748.pa5NGbb9-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/2/13 17:28, kernel test robot 写道:
> Hi GuoRui.Yu",
> 
> Thank you for the patch! Perhaps something to improve:
> 
>     654		spin_lock_irqsave(&area->lock, flags);
>     655		if (unlikely(nslots > mem->area_nslabs - area->used))
>     656			goto not_found;
>     657	
>     658		slot_base = area_index * mem->area_nslabs;
>     659		index = wrap = wrap_area_index(mem, ALIGN(area->index, stride));
index_nowrap should be initialized to "index" here, and I will add this 
in v2.

I have done some stress tests locally to check if they can avoid the 
deadlock but they did not reveal this problem, I will pay more attention 
next time.
>     660	
>     661		do {

Guorui
