Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDE8D72D710
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 03:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238116AbjFMBn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 21:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232149AbjFMBn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 21:43:28 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A5D1718
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 18:43:26 -0700 (PDT)
Received: from kwepemm600012.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QgBC31kygzTlJV;
        Tue, 13 Jun 2023 09:42:55 +0800 (CST)
Received: from [10.174.178.220] (10.174.178.220) by
 kwepemm600012.china.huawei.com (7.193.23.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 13 Jun 2023 09:43:23 +0800
Message-ID: <cfaf1f19-65b6-26b2-eb8d-7a53b71aa211@huawei.com>
Date:   Tue, 13 Jun 2023 09:43:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 0/2] Fix out-of-bound access if pagecache of udf device is
 corrupted
To:     Jan Kara <jack@suse.cz>
CC:     Jan Kara <jack@suse.com>, <linux-kernel@vger.kernel.org>,
        <linfeilong@huawei.com>
References: <20230613032254.1235752-1-haowenchao2@huawei.com>
 <20230612144009.s436o52pctxgctr2@quack3>
Content-Language: en-US
From:   "haowenchao (C)" <haowenchao2@huawei.com>
In-Reply-To: <20230612144009.s436o52pctxgctr2@quack3>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.220]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600012.china.huawei.com (7.193.23.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/6/12 22:40, Jan Kara wrote:
> On Tue 13-06-23 11:22:52, Wenchao Hao wrote:
>> Following steps would cause out-of-bound access and even cause kernel
>> panic when using udf:
>>
>> dd if=/dev/zero of=udf.img bs=1M count=512
>> mkfs.udf udf.img
>> mount -o loop -t udf udf.img /mnt
>> dd if=/dev/random of=/dev/loop0 bs=512 count=1 seek=128
>> umount /mnt
>>
>> [if /mnt is mounted on /dev/loop0]
>>
>> It is because we did not check if udf_sb_info->s_lvid_bh is valid in
>> udf_sb_lvidiu().
>>
>> Although it's illegal to write backend device since filesystem has been
>> mounted, but we should avoid kernel panic if it happened.
> 
> No, it is perfectly valid to crash the kernel if someone writes the buffer
> cache of the device while the device is mounted (which your example above
> does). There is no practical protection against this because someone could
> overwrite the buffer just after the moment you verify its validity. The
> only protection would be to lock the buffer for each access and fully
> verify validity of the data after each locking but the performance and
> maintenance overhead of this is too high to justify. So I'm sorry but I
> will not take any patches that try to "fix" situations when someone writes
> buffer cache while the filesystem is mounted.
> 
> I guess your work is motivated by some syzbot reproducer which was doing
> this. Let me work on a kernel option which syzbot can use to not report
> these issues.
> 
> 
> 								Honza

Yes, the issue is discovered by syzbot. Looking forward you patches.

