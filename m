Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2675369B7B0
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 03:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjBRCSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 21:18:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBRCSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 21:18:48 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BACE3A872;
        Fri, 17 Feb 2023 18:18:45 -0800 (PST)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4PJXKw5flWzJpsJ;
        Sat, 18 Feb 2023 10:13:56 +0800 (CST)
Received: from [10.174.178.185] (10.174.178.185) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.6; Sat, 18 Feb 2023 10:18:43 +0800
Subject: Re: [PATCH v3 1/2] ext4: commit super block if fs record error when
 journal record without error
To:     Jan Kara <jack@suse.cz>
References: <20230214022905.765088-1-yebin@huaweicloud.com>
 <20230214022905.765088-2-yebin@huaweicloud.com>
 <20230216173159.zkj4qd2nmj2yjpkr@quack3> <63EEDC19.6010204@huawei.com>
 <20230217105647.g6blbinkvnsyy2or@quack3>
CC:     Ye Bin <yebin@huaweicloud.com>, <tytso@mit.edu>,
        <adilger.kernel@dilger.ca>, <linux-ext4@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
From:   "yebin (H)" <yebin10@huawei.com>
Message-ID: <63F03582.1020303@huawei.com>
Date:   Sat, 18 Feb 2023 10:18:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <20230217105647.g6blbinkvnsyy2or@quack3>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.185]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/2/17 18:56, Jan Kara wrote:
> On Fri 17-02-23 09:44:57, yebin (H) wrote:
>> On 2023/2/17 1:31, Jan Kara wrote:
>>> On Tue 14-02-23 10:29:04, Ye Bin wrote:
>>>> From: Ye Bin <yebin10@huawei.com>
>>>>
>>>> Now, 'es->s_state' maybe covered by recover journal. And journal errno
>>>> maybe not recorded in journal sb as IO error. ext4_update_super() only
>>>> update error information when 'sbi->s_add_error_count' large than zero.
>>>> Then 'EXT4_ERROR_FS' flag maybe lost.
>>>> To solve above issue commit error information after recover journal.
>>>>
>>>> Signed-off-by: Ye Bin <yebin10@huawei.com>
>>>> ---
>>>>    fs/ext4/super.c | 12 ++++++++++++
>>>>    1 file changed, 12 insertions(+)
>>>>
>>>> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
>>>> index dc3907dff13a..b94754ba8556 100644
>>>> --- a/fs/ext4/super.c
>>>> +++ b/fs/ext4/super.c
>>>> @@ -5932,6 +5932,18 @@ static int ext4_load_journal(struct super_block *sb,
>>>>    		goto err_out;
>>>>    	}
>>>> +	if (unlikely(es->s_error_count && !jbd2_journal_errno(journal) &&
>>>> +		     !(le16_to_cpu(es->s_state) & EXT4_ERROR_FS))) {
>>>> +		EXT4_SB(sb)->s_mount_state |= EXT4_ERROR_FS;
>>>> +		es->s_state |= cpu_to_le16(EXT4_ERROR_FS);
>>>> +		err = ext4_commit_super(sb);
>>>> +		if (err) {
>>>> +			ext4_msg(sb, KERN_ERR,
>>>> +				 "Failed to commit error information, please repair fs force!");
>>>> +			goto err_out;
>>>> +		}
>>>> +	}
>>>> +
>>> Hum, I'm not sure I follow here. If journal replay has overwritten the
>>> superblock (and thus the stored error info), then I'd expect
>>> es->s_error_count got overwritten (possibly to 0) as well. And this is
>>> actually relatively realistic scenario with errors=remount-ro behavior when
>>> the first fs error happens.
>>>
>>> What I intended in my original suggestion was to save es->s_error_count,
>>> es->s_state & EXT4_ERROR_FS, es->s_first_error_*, es->s_last_error_* before
>>> doing journal replay in ext4_load_journal() and then after journal replay
>>> merge this info back to the superblock
>> Actually，commit 1c13d5c08728 ("ext4: Save error information to the
>> superblock for analysis")
>> already merged error info back to the superblock after journal replay except
>> 'es->s_state'.
>> The problem I have now is that the error flag in the journal superblock was
>> not recorded,
>> but the error message was recorded in the superblock. So it leads to
>> ext4_clear_journal_err()
>> does not detect errors and marks the file system as an error. Because
>> ext4_update_super() is
>> only set error flag  when 'sbi->s_add_error_count  > 0'. Although
>> 'sbi->s_mount_state' is
>> written to the super block when umount, but it is also conditional.
>> So I handle the scenario "es->s_error_count && !jbd2_journal_errno(journal)
>> &&
>> !(le16_to_cpu(es->s_state) & EXT4_ERROR_FS)". Maybe we can just store
>> 'EXT4_SB(sb)->s_mount_state & EXT4_ERROR_FS' back to the superblock. But i
>> prefer to mark fs as error if it contain detail error info without
>> EXT4_ERROR_FS.
> Aha, thanks for explanation! So now I finally understand what the problem
> exactly is. I'm not sure relying on es->s_error_count is too good. Probably
> it works but I'd be calmer if when saving error info we also did:
>
> 	bool error_fs = es->s_state & cpu_to_le16(EXT4_ERROR_FS);
>
> 	copy other info
> 	err = jbd2_journal_load(journal);
> 	restore other info
> 	if (error_fs)
> 		es->s_state |= cpu_to_le16(EXT4_ERROR_FS);
> 	/* Write out restored error information to the superblock */
> 	err2 = ext4_commit_super(sb);
>
> and be done with this. I don't think trying to optimize away the committing
> of the superblock when we had to replay the journal is really worth it.
>
> Does this solve your concerns?
>
> 								Honza
Thanks for your suggestion.

I think if journal super block has 'j_errno' ext4_clear_journal_err() 
will commit error info.
The scenario we need to deal with is:(1) journal super block has no 
'j_errno'; (2) super
block has detail error info, but 'es->s_state' has no 'EXT4_ERROR_FS', 
It means super
block in journal has no error flag and the newest super block has error 
flag. so we
need to store error flag to 'es->s_state', and commit it to disk.If 
'es->s_state' has
  'EXT4_ERROR_FS', it means super block in journal has error flag, so we 
do not need
to store error flag in super block.

I don't know if I can explain my idea of repair.

