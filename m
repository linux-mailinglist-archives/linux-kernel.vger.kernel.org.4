Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F36C5F76FA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 12:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbiJGKiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 06:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiJGKh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 06:37:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E5CD57D2
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 03:37:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 332CCB822A2
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 10:37:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6C3FC433D6;
        Fri,  7 Oct 2022 10:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665139073;
        bh=Pl3iAD/5G+SNfYl4QrD98UtT2vc2ZQkXtR5hchYEjR4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=HJITOn3VdHp8rGYkojtpynvaJW2Vw9oKfMHMoaajkW7kCXUOzoPXQRP7w1O0oflPr
         WWNKaU1oIKqyT/10kNG43TF2cG93qM6fvt6UuqMgQjERVdB43gQLY9th6wzKv7dRaC
         MImY8jGI84orLfWXNNLBcLnMpqxo602o4KiKnxLdDVPszTV8VHyfn///k3i2kZPa6x
         irAWLyYpE6MEjyYoGip9YQyLtl3pKpIMujUJ99DYeOmZu1x+q6puh7zJNUcIcPRkrS
         fw2gUYksOIJ37vVTYDzxf8XdY5ZeN1einUeytMNg5xpXzYl1SlTbOKYt6vOWn92h/h
         hoecf0S/63khg==
Message-ID: <4d7f250d-19c0-acd0-dde4-752f95c5fc2a@kernel.org>
Date:   Fri, 7 Oct 2022 18:37:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [f2fs-dev] [PATCH v4 1/2] f2fs: correct i_size change for atomic
 writes
To:     Daeho Jeong <daeho43@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
References: <20221004171351.3678194-1-daeho43@gmail.com>
 <b1ca9048-99c5-1ab4-fb77-5fe0bbc6d4de@kernel.org>
 <CACOAw_zXTHzc5mjPchGNXkgnswZLxLEBfRoEztB7VFdV-rtpwQ@mail.gmail.com>
Content-Language: en-US
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <CACOAw_zXTHzc5mjPchGNXkgnswZLxLEBfRoEztB7VFdV-rtpwQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/10/6 0:06, Daeho Jeong wrote:
> On Wed, Oct 5, 2022 at 6:46 AM Chao Yu <chao@kernel.org> wrote:
>>
>> On 2022/10/5 1:13, Daeho Jeong wrote:
>>> From: Daeho Jeong <daehojeong@google.com>
>>>
>>> We need to make sure i_size doesn't change until atomic write commit is
>>> successful and restore it when commit is failed.
>>>
>>> Signed-off-by: Daeho Jeong <daehojeong@google.com>
>>> ---
>>> v4: move i_size update after clearing atomic file flag in
>>>       f2fs_abort_atomic_write()
>>> v3: make sure inode is clean while atomic writing
>>> ---
>>>    fs/f2fs/f2fs.h    |  1 +
>>>    fs/f2fs/file.c    | 18 +++++++++++-------
>>>    fs/f2fs/inode.c   |  3 +++
>>>    fs/f2fs/segment.c |  7 +++++--
>>>    4 files changed, 20 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>>> index dee7b67a17a6..539da7f12cfc 100644
>>> --- a/fs/f2fs/f2fs.h
>>> +++ b/fs/f2fs/f2fs.h
>>> @@ -821,6 +821,7 @@ struct f2fs_inode_info {
>>>        unsigned int i_cluster_size;            /* cluster size */
>>>
>>>        unsigned int atomic_write_cnt;
>>> +     loff_t original_i_size;         /* original i_size before atomic write */
>>>    };
>>>
>>>    static inline void get_extent_info(struct extent_info *ext,
>>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>>> index 5efe0e4a725a..ce2336d2f688 100644
>>> --- a/fs/f2fs/file.c
>>> +++ b/fs/f2fs/file.c
>>> @@ -1989,6 +1989,7 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
>>>        struct f2fs_inode_info *fi = F2FS_I(inode);
>>>        struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>>>        struct inode *pinode;
>>> +     loff_t isize;
>>>        int ret;
>>>
>>>        if (!inode_owner_or_capable(mnt_userns, inode))
>>> @@ -2047,7 +2048,12 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
>>>                f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
>>>                goto out;
>>>        }
>>> -     f2fs_i_size_write(fi->cow_inode, i_size_read(inode));
>>> +
>>> +     f2fs_write_inode(inode, NULL);
>>> +
>>> +     isize = i_size_read(inode);
>>> +     fi->original_i_size = isize;
>>> +     f2fs_i_size_write(fi->cow_inode, isize);
>>>
>>>        spin_lock(&sbi->inode_lock[ATOMIC_FILE]);
>>>        sbi->atomic_files++;
>>> @@ -2087,16 +2093,14 @@ static int f2fs_ioc_commit_atomic_write(struct file *filp)
>>>
>>>        if (f2fs_is_atomic_file(inode)) {
>>>                ret = f2fs_commit_atomic_write(inode);
>>> -             if (ret)
>>> -                     goto unlock_out;
>>> -
>>> -             ret = f2fs_do_sync_file(filp, 0, LLONG_MAX, 0, true);
>>>                if (!ret)
>>> -                     f2fs_abort_atomic_write(inode, false);
>>> +                     ret = f2fs_do_sync_file(filp, 0, LLONG_MAX, 0, true);
>>> +
>>> +             f2fs_abort_atomic_write(inode, ret);
>>>        } else {
>>>                ret = f2fs_do_sync_file(filp, 0, LLONG_MAX, 1, false);
>>>        }
>>> -unlock_out:
>>> +
>>>        inode_unlock(inode);
>>>        mnt_drop_write_file(filp);
>>>        return ret;
>>> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
>>> index cde0a3dc80c3..64d7772b4cd9 100644
>>> --- a/fs/f2fs/inode.c
>>> +++ b/fs/f2fs/inode.c
>>> @@ -30,6 +30,9 @@ void f2fs_mark_inode_dirty_sync(struct inode *inode, bool sync)
>>>        if (f2fs_inode_dirtied(inode, sync))
>>>                return;
>>>
>>> +     if (f2fs_is_atomic_file(inode))
>>> +             return;
>>
>> One question, after f2fs_inode_dirtied(), atomic_file is added to
>> inode_list[DIRTY_META], and it will be flushed by checkpoint()
>> triggered in between write() and atomic_commit ioctl, is it not
>> expected that inode w/ new i_size will be persisted?
> 
> Isn't it okay if we move f2fs_is_atomic_file() ahead of f2fs_inode_dirtied()?

Fine to me.

But another question is, now it allows GC to migrate blocks belong
to atomic files, so, during migration, it may update extent cache,
once largest extent was updated, it will mark inode dirty, but after
this patch, it may lose the extent change? thoughts?

> 
>>
>> Should write_end() skip updating atomic_file's i_size and let
>> atomic_commit() update it if there is no error?
> 
> In this case, the user can't see the changed i_size while writing an
> atomic file.

Oh, right, please ignore this comment...

Thanks,

> 
>>
>> Thanks,
>>
>>> +
>>>        mark_inode_dirty_sync(inode);
>>>    }
>>>
>>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>>> index 460048f3c850..abb55cd418c1 100644
>>> --- a/fs/f2fs/segment.c
>>> +++ b/fs/f2fs/segment.c
>>> @@ -193,14 +193,17 @@ void f2fs_abort_atomic_write(struct inode *inode, bool clean)
>>>        if (!f2fs_is_atomic_file(inode))
>>>                return;
>>>
>>> -     if (clean)
>>> -             truncate_inode_pages_final(inode->i_mapping);
>>>        clear_inode_flag(fi->cow_inode, FI_COW_FILE);
>>>        iput(fi->cow_inode);
>>>        fi->cow_inode = NULL;
>>>        release_atomic_write_cnt(inode);
>>>        clear_inode_flag(inode, FI_ATOMIC_FILE);
>>>
>>> +     if (clean) {
>>> +             truncate_inode_pages_final(inode->i_mapping);
>>> +             f2fs_i_size_write(inode, fi->original_i_size);
>>> +     }
>>> +
>>>        spin_lock(&sbi->inode_lock[ATOMIC_FILE]);
>>>        sbi->atomic_files--;
>>>        spin_unlock(&sbi->inode_lock[ATOMIC_FILE]);
