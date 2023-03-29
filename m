Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D45416CCFFB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 04:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjC2Cbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 22:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjC2Cbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 22:31:35 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F05E10F0;
        Tue, 28 Mar 2023 19:31:33 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4PmVsf2n46zKp9S;
        Wed, 29 Mar 2023 10:31:02 +0800 (CST)
Received: from [10.174.178.185] (10.174.178.185) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 29 Mar 2023 10:31:31 +0800
Subject: Re: [PATCH v2] xfs: fix BUG_ON in xfs_getbmap()
To:     "Darrick J. Wong" <djwong@kernel.org>,
        Ye Bin <yebin@huaweicloud.com>
References: <20230328142129.2636535-1-yebin@huaweicloud.com>
 <20230329010246.GA4126677@frogsfrogsfrogs>
CC:     <linux-xfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   "yebin (H)" <yebin10@huawei.com>
Message-ID: <6423A302.5020003@huawei.com>
Date:   Wed, 29 Mar 2023 10:31:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <20230329010246.GA4126677@frogsfrogsfrogs>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.185]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/3/29 9:02, Darrick J. Wong wrote:
> On Tue, Mar 28, 2023 at 10:21:29PM +0800, Ye Bin wrote:
>> From: Ye Bin <yebin10@huawei.com>
>>
>> There's issue as follows:
>> XFS: Assertion failed: (bmv->bmv_iflags & BMV_IF_DELALLOC) != 0, file: fs/xfs/xfs_bmap_util.c, line: 329
>> ------------[ cut here ]------------
>> kernel BUG at fs/xfs/xfs_message.c:102!
>> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
>> CPU: 1 PID: 14612 Comm: xfs_io Not tainted 6.3.0-rc2-next-20230315-00006-g2729d23ddb3b-dirty #422
>> RIP: 0010:assfail+0x96/0xa0
>> RSP: 0018:ffffc9000fa178c0 EFLAGS: 00010246
>> RAX: 0000000000000000 RBX: 0000000000000001 RCX: ffff888179a18000
>> RDX: 0000000000000000 RSI: ffff888179a18000 RDI: 0000000000000002
>> RBP: 0000000000000000 R08: ffffffff8321aab6 R09: 0000000000000000
>> R10: 0000000000000001 R11: ffffed1105f85139 R12: ffffffff8aacc4c0
>> R13: 0000000000000149 R14: ffff888269f58000 R15: 000000000000000c
>> FS:  00007f42f27a4740(0000) GS:ffff88882fc00000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 0000000000b92388 CR3: 000000024f006000 CR4: 00000000000006e0
>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> Call Trace:
>>   <TASK>
>>   xfs_getbmap+0x1a5b/0x1e40
>>   xfs_ioc_getbmap+0x1fd/0x5b0
>>   xfs_file_ioctl+0x2cb/0x1d50
>>   __x64_sys_ioctl+0x197/0x210
>>   do_syscall_64+0x39/0xb0
>>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
>>
>> Above issue may happen as follows:
>>           ThreadA                       ThreadB
>> do_shared_fault
>>   __do_fault
>>    xfs_filemap_fault
>>     __xfs_filemap_fault
>>      filemap_fault
>>                               xfs_ioc_getbmap -> Without BMV_IF_DELALLOC flag
>> 			      xfs_getbmap
>> 			       xfs_ilock(ip, XFS_IOLOCK_SHARED);
>> 			       filemap_write_and_wait
>>   do_page_mkwrite
>>    xfs_filemap_page_mkwrite
>>     __xfs_filemap_fault
>>      xfs_ilock(XFS_I(inode), XFS_MMAPLOCK_SHARED);
>>      iomap_page_mkwrite
>>       ...
>>       xfs_buffered_write_iomap_begin
>>        xfs_bmapi_reserve_delalloc -> Allocate delay extent
>>                                xfs_ilock_data_map_shared(ip)
>> 	                      xfs_getbmap_report_one
>> 			       ASSERT((bmv->bmv_iflags & BMV_IF_DELALLOC) != 0)
>> 	                        -> trigger BUG_ON
>>
>> As xfs_filemap_page_mkwrite() only hold XFS_MMAPLOCK_SHARED lock, there's
>> small window mkwrite can produce delay extent after file write in xfs_getbmap().
>> To solve above issue, just skip delalloc extents.
>>
>> Signed-off-by: Ye Bin <yebin10@huawei.com>
>> ---
>>   fs/xfs/xfs_bmap_util.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
>> index a09dd2606479..d2a109ceb922 100644
>> --- a/fs/xfs/xfs_bmap_util.c
>> +++ b/fs/xfs/xfs_bmap_util.c
>> @@ -322,7 +322,8 @@ xfs_getbmap_report_one(
>>   		 * extents.
>>   		 */
>>   		if (got->br_startoff < XFS_B_TO_FSB(ip->i_mount, XFS_ISIZE(ip)))
>> -			ASSERT((bmv->bmv_iflags & BMV_IF_DELALLOC) != 0);
>> +			if (!(bmv->bmv_iflags & BMV_IF_DELALLOC))
>> +				return 0;
> Why only hide the delalloc mapping if it's below EOF?
>
> --D
There should be no concurrency issues with normal buffer writes. But 
since we need
to skip here, we won't make any distinction. I will send another version.
>>   
>>   		p->bmv_oflags |= BMV_OF_DELALLOC;
>>   		p->bmv_block = -2;
>> -- 
>> 2.31.1
>>
> .
>

