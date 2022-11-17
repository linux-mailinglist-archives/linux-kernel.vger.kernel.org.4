Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A685862D030
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 01:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239057AbiKQAtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 19:49:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234506AbiKQAsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 19:48:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2316DCDF
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 16:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668645959;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dLyYTR0vgDLPN4t0KFfB1sbFaXYNr5zBEhazg8jRdTg=;
        b=AiGApzEQ/bSAI82NpwhH86IW5JTkAESN7hJO35lj7P41ZEpIPZtHFguYuI2hGOBBvO8VQK
        c5+u7aJ8Uci4Iag55DCVL84lKIMS7uKF0DavMm4UIEQ7ImxLSFucsuqRLa0NZs9ny+huuB
        LhoZK+NJ6rcUdcAm9RF8+litXBjYy1Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-557-o_RZ1q1TMTGEFSZIqGMhOQ-1; Wed, 16 Nov 2022 19:45:57 -0500
X-MC-Unique: o_RZ1q1TMTGEFSZIqGMhOQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3EEAA811E75;
        Thu, 17 Nov 2022 00:45:57 +0000 (UTC)
Received: from [10.22.10.207] (unknown [10.22.10.207])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 69BC72024CC8;
        Thu, 17 Nov 2022 00:45:56 +0000 (UTC)
Message-ID: <26c4e6ab-52ca-e258-bf8d-d4beb86e9c9a@redhat.com>
Date:   Wed, 16 Nov 2022 19:45:54 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v10 0/3] blk-cgroup: Optimize blkcg_rstat_flush()
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Ming Lei <ming.lei@redhat.com>
References: <20221105005902.407297-1-longman@redhat.com>
 <166864313668.13217.6182708630212912209.b4-ty@kernel.dk>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <166864313668.13217.6182708630212912209.b4-ty@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16/22 18:58, Jens Axboe wrote:
> On Fri, 4 Nov 2022 20:58:59 -0400, Waiman Long wrote:
>>   v10:
>>    - Update patch 3 to rename the rstat function to
>>      cgroup_rstat_css_cpu_flush().
>>
>>   v9:
>>    - Remove patch "llist: Allow optional sentinel node terminated lockless
>>      list" for now. This will be done as a follow-up patch.
>>    - Add a new lqueued field to blkg_iostat_set to store the status of
>>      whether lnode is in a lockless list.
>>    - Add a new patch 3 to speed up the freeing of blkcg by flushing out
>>      the rstat lockless lists at blkcg offline time.
>>
>> [...]
> Applied, thanks!
>
> [1/3] blk-cgroup: Return -ENOMEM directly in blkcg_css_alloc() error path
>        commit: b5a9adcbd5dc95d34d1f5fc84eff9af6fc60d284
> [2/3] blk-cgroup: Optimize blkcg_rstat_flush()
>        commit: 3b8cc6298724021da845f2f9fd7dd4b6829a6817
> [3/3] blk-cgroup: Flush stats at blkgs destruction path
>        commit: dae590a6c96c799434e0ff8156ef29b88c257e60
>
> Best regards,

Thanks a lot!

Cheers,
Longman

