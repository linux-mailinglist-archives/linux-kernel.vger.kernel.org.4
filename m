Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 008C368FF95
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 06:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjBIFBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 00:01:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjBIFBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 00:01:18 -0500
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F002316ADD
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 21:01:15 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VbETTZ7_1675918872;
Received: from 30.221.133.91(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VbETTZ7_1675918872)
          by smtp.aliyun-inc.com;
          Thu, 09 Feb 2023 13:01:12 +0800
Message-ID: <9ac23fbe-7bfe-68f6-a9b5-6c722d0fe629@linux.alibaba.com>
Date:   Thu, 9 Feb 2023 13:01:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 4/4] erofs: simplify the name collision checking in share
 domain mode
Content-Language: en-US
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org,
        zhujia.zj@bytedance.com, houtao1@huawei.com
Cc:     huyue2@coolpad.com, linux-kernel@vger.kernel.org
References: <cover.1675840368.git.jefflexu@linux.alibaba.com>
 <489d47915bcc71ef3c3ec7b8a437ec6e09c4c3db.1675840368.git.jefflexu@linux.alibaba.com>
In-Reply-To: <489d47915bcc71ef3c3ec7b8a437ec6e09c4c3db.1675840368.git.jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/8/23 3:17 PM, Jingbo Xu wrote:
> When share domain is enabled, data blobs can be shared among filesystem
> instances in the same domain for data deduplication, while bootstrap
> blobs are always dedicated to the corresponding filesystem instance, and
> have no need to be shared.
> 
> In the initial implementation of share domain (commit 7d41963759fe
> ("erofs: Support sharing cookies in the same domain")), bootstrap blobs
> are also in the share domain, and thus can be referenced by the
> following filesystem instances.  In this case, mounting twice with the
> same fsid and domain_id will trigger warning in sysfs.  Commit
> 27f2a2dcc626 ("erofs: check the uniqueness of fsid in shared domain in
> advance") fixes this by introducing the name collision checking.
> 
> This patch attempts to fix the above issue in another simpler way.
> Since the bootstrap blobs have no need to be shared, move them out of
> the share domain, so that one bootstrap blob can not be referenced by
> other filesystem instances.  Attempt to mount twice with the same fsid
> and domain_id will fail with info of duplicate cookies, which is
> consistent with the behavior in non-share-domain mode.
> 

In non-share-domain mode, the uniqueness of primary data blob is
actually guaranteed by fscache_acquire_volume(), since
fscache_acquire_volume() will fail if attempt to mount the same fsid twice.

Thus hold on for this patch.


-- 
Thanks,
Jingbo
