Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A222B6BAC87
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 10:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjCOJtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 05:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232108AbjCOJsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 05:48:25 -0400
X-Greylist: delayed 492 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 15 Mar 2023 02:47:48 PDT
Received: from out-1.mta0.migadu.com (out-1.mta0.migadu.com [IPv6:2001:41d0:1004:224b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED6D41B68
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 02:47:48 -0700 (PDT)
Message-ID: <16613534-5482-23c5-fa97-cfaedecab3d7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1678873175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IJQpaLrSEutmV4KWPVUPTFEg5KqW6z8bi/taME87jzA=;
        b=WLxR4tmD7spuddY0C1rdTQ7+xpV7ABWic2YHTubAIQSDjRCrHIk73ooyRoPwUF/I41Um9V
        QOpU32alPXisrWLNUUHlW6QHf/6AsIlD8tUmKvyEne9/+lGKpF88xspl+Rk/VyiznSbp6G
        lsj1Zdfqfkq1MHjxLefW9vyVSSL2LkQ=
Date:   Wed, 15 Mar 2023 17:39:32 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v2 5/5] md: protect md_thread with a new disk level spin
 lock
Content-Language: en-US
To:     Yu Kuai <yukuai1@huaweicloud.com>, agk@redhat.com,
        snitzer@kernel.org, song@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
References: <20230315061810.653263-1-yukuai1@huaweicloud.com>
 <20230315061810.653263-6-yukuai1@huaweicloud.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
In-Reply-To: <20230315061810.653263-6-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/15/23 14:18, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
>
> Our test reports a uaf for 'mddev->sync_thread':
>
> T1                      T2
> md_start_sync
>   md_register_thread
> 			raid1d
> 			 md_check_recovery
> 			  md_reap_sync_thread
> 			   md_unregister_thread
> 			    kfree
>
>   md_wakeup_thread
>    wake_up
>    ->sync_thread was freed

Better to provide the relevant uaf (user after free perhaps you mean)
log from the test.

> Currently, a global spinlock 'pers_lock' is borrowed to protect
> 'mddev->thread', this problem can be fixed likewise, however, there might
> be similar problem for other md_thread, and I really don't like the idea to
> borrow a global lock.
>
> This patch use a disk level spinlock to protect md_thread in relevant apis.

It is array level I think, and you probably want to remove the comment.

* pers_lockdoes extra service to protect accesses to
* mddev->thread when the mutex cannot be held.

Thanks,
Guoqing
