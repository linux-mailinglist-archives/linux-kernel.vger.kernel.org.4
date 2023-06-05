Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3AB72286C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 16:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234272AbjFEOKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 10:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234588AbjFEOJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 10:09:51 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D387710D4
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 07:08:57 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4QZb5Y1bVtzLm1k;
        Mon,  5 Jun 2023 22:07:13 +0800 (CST)
Received: from [10.174.178.185] (10.174.178.185) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 5 Jun 2023 22:08:53 +0800
Subject: Re: [PATCH 1/2] quota: fix null-ptr-deref in ext4_acquire_dquot()
To:     Jan Kara <jack@suse.cz>
References: <20230527014018.47396-1-yebin10@huawei.com>
 <20230527014018.47396-2-yebin10@huawei.com>
 <20230530095726.t2grmww5rzofx5gp@quack3> <647ADA33.5010508@huawei.com>
 <20230605115143.i3squdbqmqebu5ue@quack3>
CC:     <jack@suse.com>, <linux-kernel@vger.kernel.org>,
        <syzbot+e633c79ceaecbf479854@syzkaller.appspotmail.com>
From:   "yebin (H)" <yebin10@huawei.com>
Message-ID: <647DEC75.7080300@huawei.com>
Date:   Mon, 5 Jun 2023 22:08:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <20230605115143.i3squdbqmqebu5ue@quack3>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.185]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/6/5 19:51, Jan Kara wrote:
> On Sat 03-06-23 14:14:11, yebin (H) wrote:
>>
>> On 2023/5/30 17:57, Jan Kara wrote:
>>> On Sat 27-05-23 09:40:17, Ye Bin wrote:
>>>> Syzbot found the following issue:
>>>> Unable to handle kernel paging request at virtual address dfff800000000005
>>>> KASAN: null-ptr-deref in range [0x0000000000000028-0x000000000000002f]
>>> ...
>>>> CPU: 0 PID: 6080 Comm: syz-executor747 Not tainted 6.3.0-rc7-syzkaller-g14f8db1c0f9a #0
>>>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/14/2023
>>>> pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>>>> pc : ext4_acquire_dquot+0x1d4/0x398 fs/ext4/super.c:6766
>>>> lr : dquot_to_inode fs/ext4/super.c:6740 [inline]
>>>> lr : ext4_acquire_dquot+0x1ac/0x398 fs/ext4/super.c:6766
>>> OK, this is bad...
>>>
>>>> Above issue may happens as follows:
>>>> ProcessA              ProcessB                    ProcessC
>>>> sys_fsconfig
>>>>     vfs_fsconfig_locked
>>>>      reconfigure_super
>>>>        ext4_remount
>>>>         dquot_suspend -> suspend all type quota
>>>>
>>>>                    sys_fsconfig
>>>> 		  vfs_fsconfig_locked
>>>> 		    reconfigure_super
>>>> 		     ext4_remount
>>>> 		      dquot_resume
>>>> 		       ret = dquot_load_quota_sb
>>>>                           add_dquot_ref
>>>> 		                           do_open  -> open file O_RDWR
>>>> 					    vfs_open
>>>> 					     do_dentry_open
>>>> 					      get_write_access
>>>> 					       atomic_inc_unless_negative(&inode->i_writecount)
>>>>                                                 ext4_file_open
>>>> 					       dquot_file_open
>>>> 					        dquot_initialize
>>>> 						  __dquot_initialize
>>>> 						   dqget
>>>> 						    if (!test_bit(DQ_ACTIVE_B, &dquot->dq_flags))
>>>>
>>>> 			  __dquot_initialize
>>>> 			   __dquot_initialize
>>>> 			    dqget
>>>> 			     if (!test_bit(DQ_ACTIVE_B, &dquot->dq_flags))
>>>> 	                       ext4_acquire_dquot -> Return error
>>>> 		       if (ret < 0)
>>>> 	                 vfs_cleanup_quota_inode
>>>> 			  dqopt->files[type] = NULL;
>>> But I don't see how this can happen. The code in dquot_load_quota_sb()
>>> looks like:
>>>
>>>           error = add_dquot_ref(sb, type);
>>>           if (error)
>>>                   dquot_disable(sb, type, flags);
>>>
>>> So if an error happens in add_dquot_ref(), we'll call dquot_disable().
>>> dquot_disable() then does:
>>>
>>>                   drop_dquot_ref(sb, cnt);
>>>                   invalidate_dquots(sb, cnt);
>>>
>>> and invalidate_dquots() waits for reference count of all dquots to drop to
>>> 0. Hence if dqget() returned a dquot pointer to ProcessC, then ProcessB
>>> should wait until ProcessC drops the dquot reference (hence
>>> ext4_acquire_dquot() is done).
>>>
>>> What am I missing?
>>>
>>> 								Honza
>> My reproduction condition is:
>> mkfs.ext4 -F /dev/sda
>> tune2fs  -Q usrquota /dev/sda
>>
>> dquot_disable
>> ...
>>           if ((flags & DQUOT_USAGE_ENABLED && !(flags &
>> DQUOT_LIMITS_ENABLED))
>>               || (flags & DQUOT_SUSPENDED && flags & (DQUOT_LIMITS_ENABLED |
>>               DQUOT_USAGE_ENABLED)))
>>                   return -EINVAL;
>> ...
>> If without enable DQUOT_LIMITS_ENABLED dquot_disable() will just return
>> -EINVAL.
> Aha, that is the bug! Does attached patch fix your problem?
>
> 								Honza
Yes , it's works.

