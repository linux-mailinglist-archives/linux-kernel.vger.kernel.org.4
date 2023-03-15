Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38D9A6BAACB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 09:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbjCOIaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 04:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231592AbjCOIaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 04:30:35 -0400
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6013E608;
        Wed, 15 Mar 2023 01:30:28 -0700 (PDT)
Received: from [192.168.0.2] (ip5f5aedf0.dynamic.kabel-deutschland.de [95.90.237.240])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id DE75561CC40F9;
        Wed, 15 Mar 2023 09:30:26 +0100 (CET)
Message-ID: <e1a5fe1c-ea3d-adef-62ec-3b30bedbe4f8@molgen.mpg.de>
Date:   Wed, 15 Mar 2023 09:30:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 0/5] md: fix uaf for sync_thread
Content-Language: en-US
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Yu Kuai <yukuai1@huaweicloud.com>, agk@redhat.com,
        snitzer@kernel.org, song@kernel.org, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com, yangerkun@huawei.com
References: <20230315061810.653263-1-yukuai1@huaweicloud.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20230315061810.653263-1-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Logan,


Am 15.03.23 um 07:18 schrieb Yu Kuai:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Changes in v2:
>   - fix a compile error for for md-cluster in patch 2
>   - replace spin_lock/unlock with spin_lock/unlock_irq in patch 5
>   - don't wake up inside the new lock in md wakeup_thread in patch 5
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
> 
> Currently, a global spinlock 'pers_lock' is borrowed to protect
> 'mddev->thread', this problem can be fixed likewise, however, there might
> be similar problem for other md_thread, and I really don't like the idea to
> borrow a global lock.
> 
> This patchset do some refactor, and then use a disk level spinlock to
> protect md_thread in relevant apis.
> 
> I tested this pathset with mdadm tests, and there are no new regression,
> by the way, following test will failed with or without this patchset:
> 
> 01raid6integ
> 04r1update
> 05r6tor0
> 10ddf-create
> 10ddf-fail-spare
> 10ddf-fail-stop-readd
> 10ddf-geometry

As you improved the tests in the past, can you confirm, these failed on 
your test systems too and are fixed now?

[…]


Kind regards,

Paul
