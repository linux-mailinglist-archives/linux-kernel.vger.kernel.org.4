Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2DC627613
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 07:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235830AbiKNGtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 01:49:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234411AbiKNGtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 01:49:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486CDA46C
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 22:49:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CA6BDB80D2A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 06:49:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4997BC433D6;
        Mon, 14 Nov 2022 06:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668408554;
        bh=8PZWbscqSUAtFvVcT4bx3pQupc/7oaKz+h3mz7sDStg=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=mjl1NYy5+5tL8HzVz0wDk959GSFP7NE1W9ZbNAatnip7Ggs9188JSSzT2ltM2WKvO
         GRtQ5YeiTQ7OGSA0mp5cjHscm8/wBt4uCawKKmZcV04UKFfpAch8aSK+iqIPRyIxVt
         8v/YhPo0efSl9zy8UmQUQERFoq+Z2Kwt69DQMjWzKSgT/xshHQfAcjEIHrnLKsVcfG
         1P5D8VmDq44cZQcOYC/Z79+Q50uvZWh/qaUTFaZSo7IZ2cbsuRyHCdLb9rCNrpKzzt
         lolnEI3Hv03ytHx18zJxll0rApC4apdgUaWFM41lCCUHOV3y/maIx/pnJcwK61KWLz
         nxmOp9/KAN1XA==
Message-ID: <0f31c3ff-aa4f-f7bc-be0f-e47c43f2544f@kernel.org>
Date:   Mon, 14 Nov 2022 14:49:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [f2fs-dev] [PATCH v6] f2fs: support
 errors=remount-ro|continue|panic mountoption
Content-Language: en-US
From:   Chao Yu <chao@kernel.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20221106132748.134306-1-chao@kernel.org>
 <Y2l9V4Mi7lZo7ApM@google.com>
 <8768086f-c4be-1823-1904-6369e8c0d704@kernel.org>
In-Reply-To: <8768086f-c4be-1823-1904-6369e8c0d704@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/11/8 9:17, Chao Yu wrote:
> Jaegeuk,
> 
> On 2022/11/8 5:49, Jaegeuk Kim wrote:
>> Chao,
>>
>> Could you please run xfstests since I met some issues with this?
>> I had to drop this to test other patches.
> 
> Oops, I ran xfstests on v5, I didn't see any issus... and in v6 I just rebase
> codes on ("f2fs: fix to avoid accessing uninitialized spinlock"), there is no
> critial changes.

I did test w/ this patch on top of last dev-test branch, however, I don't see
any hang backtrace...

Could you please provide xfstest option to me?
e.g. F2FS_MOUNT_OPTIONS/F2FS_MKFS_OPTIONS

> 
> Did you keep any kernel/xfstest logs?

If it is easier to reproduce the bug in your environment, could you please provide
the log?

> 
> Thanks,
> 
>>
>> Thanks,
>>
>> On 11/06, Chao Yu wrote:
>>> This patch supports errors=remount-ro|continue|panic mount option.
>>>
>>> Signed-off-by: Chao Yu <chao@kernel.org>
>>> Signed-off-by: Yangtao Li <frank.li@vivo.com>
>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>> ---
>>> v6:
>>> - rebase the code
>>>   Documentation/filesystems/f2fs.rst |   4 +
>>>   fs/f2fs/checkpoint.c               |   7 +-
>>>   fs/f2fs/f2fs.h                     |  18 +++-
>>>   fs/f2fs/file.c                     |   5 --
>>>   fs/f2fs/gc.c                       |   2 +-
>>>   fs/f2fs/super.c                    | 135 ++++++++++++++++++++++++++---
>>>   6 files changed, 147 insertions(+), 24 deletions(-)
>>>
>>> diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
>>> index 6e67c5e6c7c3..1d73bc91b9ae 100644
>>> --- a/Documentation/filesystems/f2fs.rst
>>> +++ b/Documentation/filesystems/f2fs.rst
>>> @@ -343,6 +343,10 @@ memory=%s         Control memory mode. This supports "normal" and "low" modes.
>>>                Because of the nature of low memory devices, in this mode, f2fs
>>>                will try to save memory sometimes by sacrificing performance.
>>>                "normal" mode is the default mode and same as before.
>>> +errors=%s         Specify f2fs behavior on critical errors. This supports modes:
>>> +             "panic", "continue" and "remount-ro", respectively, trigger
>>> +             panic immediately, continue without doing anything, and remount
>>> +             the partition in read-only mode (default behavior).
>>>   ======================== ============================================================
>>>   Debugfs Entries
>>> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
>>> index 56f7d0d6a8b2..913cea4ebea4 100644
>>> --- a/fs/f2fs/checkpoint.c
>>> +++ b/fs/f2fs/checkpoint.c
>>> @@ -30,12 +30,9 @@ void f2fs_stop_checkpoint(struct f2fs_sb_info *sbi, bool end_io,
>>>                           unsigned char reason)
>>>   {
>>>       f2fs_build_fault_attr(sbi, 0, 0);
>>> -    set_ckpt_flags(sbi, CP_ERROR_FLAG);
>>> -    if (!end_io) {
>>> +    if (!end_io)
>>>           f2fs_flush_merged_writes(sbi);
>>> -
>>> -        f2fs_handle_stop(sbi, reason);
>>> -    }
>>> +    f2fs_handle_critical_error(sbi, reason, end_io);
>>>   }
>>>   /*
>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>>> index 04ef4cce3d7f..af9e114d03a6 100644
>>> --- a/fs/f2fs/f2fs.h
>>> +++ b/fs/f2fs/f2fs.h
>>> @@ -161,6 +161,7 @@ struct f2fs_mount_info {
>>>       int fs_mode;            /* fs mode: LFS or ADAPTIVE */
>>>       int bggc_mode;            /* bggc mode: off, on or sync */
>>>       int memory_mode;        /* memory mode */
>>> +    int errors;            /* errors parameter */
>>>       int discard_unit;        /*
>>>                        * discard command's offset/size should
>>>                        * be aligned to this unit: block,
>>> @@ -1381,7 +1382,11 @@ enum {
>>>       MEMORY_MODE_LOW,    /* memory mode for low memry devices */
>>>   };
>>> -
>>> +enum errors_option {
>>> +    MOUNT_ERRORS_READONLY,    /* remount fs ro on errors */
>>> +    MOUNT_ERRORS_CONTINUE,    /* continue on errors */
>>> +    MOUNT_ERRORS_PANIC,    /* panic on errors */
>>> +};
>>>   static inline int f2fs_test_bit(unsigned int nr, char *addr);
>>>   static inline void f2fs_set_bit(unsigned int nr, char *addr);
>>> @@ -1818,7 +1823,13 @@ struct f2fs_sb_info {
>>>       struct workqueue_struct *post_read_wq;    /* post read workqueue */
>>> -    unsigned char errors[MAX_F2FS_ERRORS];    /* error flags */
>>> +    /*
>>> +     * If we are in irq context, let's update error information into
>>> +     * on-disk superblock in the work.
>>> +     */
>>> +    struct work_struct s_error_work;
>>> +    unsigned char errors[MAX_F2FS_ERRORS];        /* error flags */
>>> +    unsigned char stop_reason[MAX_STOP_REASON];    /* stop reason */
>>>       spinlock_t error_lock;            /* protect errors array */
>>>       bool error_dirty;            /* errors of sb is dirty */
>>> @@ -3563,7 +3574,8 @@ int f2fs_enable_quota_files(struct f2fs_sb_info *sbi, bool rdonly);
>>>   int f2fs_quota_sync(struct super_block *sb, int type);
>>>   loff_t max_file_blocks(struct inode *inode);
>>>   void f2fs_quota_off_umount(struct super_block *sb);
>>> -void f2fs_handle_stop(struct f2fs_sb_info *sbi, unsigned char reason);
>>> +void f2fs_handle_critical_error(struct f2fs_sb_info *sbi, unsigned char reason,
>>> +                            bool irq_context);
>>>   void f2fs_handle_error(struct f2fs_sb_info *sbi, unsigned char error);
>>>   int f2fs_commit_super(struct f2fs_sb_info *sbi, bool recover);
>>>   int f2fs_sync_fs(struct super_block *sb, int sync);
>>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>>> index c605a4f2bce2..9df5fac57666 100644
>>> --- a/fs/f2fs/file.c
>>> +++ b/fs/f2fs/file.c
>>> @@ -2197,7 +2197,6 @@ static int f2fs_ioc_shutdown(struct file *filp, unsigned long arg)
>>>                   ret = 0;
>>>                   f2fs_stop_checkpoint(sbi, false,
>>>                           STOP_CP_REASON_SHUTDOWN);
>>> -                set_sbi_flag(sbi, SBI_IS_SHUTDOWN);
>>>                   trace_f2fs_shutdown(sbi, in, ret);
>>>               }
>>>               return ret;
>>> @@ -2210,7 +2209,6 @@ static int f2fs_ioc_shutdown(struct file *filp, unsigned long arg)
>>>           if (ret)
>>>               goto out;
>>>           f2fs_stop_checkpoint(sbi, false, STOP_CP_REASON_SHUTDOWN);
>>> -        set_sbi_flag(sbi, SBI_IS_SHUTDOWN);
>>>           thaw_bdev(sb->s_bdev);
>>>           break;
>>>       case F2FS_GOING_DOWN_METASYNC:
>>> @@ -2219,16 +2217,13 @@ static int f2fs_ioc_shutdown(struct file *filp, unsigned long arg)
>>>           if (ret)
>>>               goto out;
>>>           f2fs_stop_checkpoint(sbi, false, STOP_CP_REASON_SHUTDOWN);
>>> -        set_sbi_flag(sbi, SBI_IS_SHUTDOWN);
>>>           break;
>>>       case F2FS_GOING_DOWN_NOSYNC:
>>>           f2fs_stop_checkpoint(sbi, false, STOP_CP_REASON_SHUTDOWN);
>>> -        set_sbi_flag(sbi, SBI_IS_SHUTDOWN);
>>>           break;
>>>       case F2FS_GOING_DOWN_METAFLUSH:
>>>           f2fs_sync_meta_pages(sbi, META, LONG_MAX, FS_META_IO);
>>>           f2fs_stop_checkpoint(sbi, false, STOP_CP_REASON_SHUTDOWN);
>>> -        set_sbi_flag(sbi, SBI_IS_SHUTDOWN);
>>>           break;
>>>       case F2FS_GOING_DOWN_NEED_FSCK:
>>>           set_sbi_flag(sbi, SBI_NEED_FSCK);
>>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
>>> index 6466db75af5d..72f165048a3c 100644
>>> --- a/fs/f2fs/gc.c
>>> +++ b/fs/f2fs/gc.c
>>> @@ -59,7 +59,7 @@ static int gc_thread_func(void *data)
>>>           if (gc_th->gc_wake)
>>>               gc_th->gc_wake = 0;
>>> -        if (try_to_freeze()) {
>>> +        if (try_to_freeze() || f2fs_readonly(sbi->sb)) {
>>>               stat_other_skip_bggc_count(sbi);
>>>               continue;
>>>           }
>>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>>> index afa6f9155bed..3e06b2acc73a 100644
>>> --- a/fs/f2fs/super.c
>>> +++ b/fs/f2fs/super.c
>>> @@ -163,6 +163,7 @@ enum {
>>>       Opt_nogc_merge,
>>>       Opt_discard_unit,
>>>       Opt_memory_mode,
>>> +    Opt_errors,
>>>       Opt_err,
>>>   };
>>> @@ -241,6 +242,7 @@ static match_table_t f2fs_tokens = {
>>>       {Opt_nogc_merge, "nogc_merge"},
>>>       {Opt_discard_unit, "discard_unit=%s"},
>>>       {Opt_memory_mode, "memory=%s"},
>>> +    {Opt_errors, "errors=%s"},
>>>       {Opt_err, NULL},
>>>   };
>>> @@ -1259,6 +1261,25 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
>>>               }
>>>               kfree(name);
>>>               break;
>>> +        case Opt_errors:
>>> +            name = match_strdup(&args[0]);
>>> +            if (!name)
>>> +                return -ENOMEM;
>>> +            if (!strcmp(name, "remount-ro")) {
>>> +                F2FS_OPTION(sbi).errors =
>>> +                        MOUNT_ERRORS_READONLY;
>>> +            } else if (!strcmp(name, "continue")) {
>>> +                F2FS_OPTION(sbi).errors =
>>> +                        MOUNT_ERRORS_CONTINUE;
>>> +            } else if (!strcmp(name, "panic")) {
>>> +                F2FS_OPTION(sbi).errors =
>>> +                        MOUNT_ERRORS_PANIC;
>>> +            } else {
>>> +                kfree(name);
>>> +                return -EINVAL;
>>> +            }
>>> +            kfree(name);
>>> +            break;
>>>           default:
>>>               f2fs_err(sbi, "Unrecognized mount option \"%s\" or missing value",
>>>                    p);
>>> @@ -1621,6 +1642,9 @@ static void f2fs_put_super(struct super_block *sb)
>>>       f2fs_destroy_node_manager(sbi);
>>>       f2fs_destroy_segment_manager(sbi);
>>> +    /* flush s_error_work before sbi destroy */
>>> +    flush_work(&sbi->s_error_work);
>>> +
>>>       f2fs_destroy_post_read_wq(sbi);
>>>       kvfree(sbi->ckpt);
>>> @@ -2047,6 +2071,13 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
>>>       else if (F2FS_OPTION(sbi).memory_mode == MEMORY_MODE_LOW)
>>>           seq_printf(seq, ",memory=%s", "low");
>>> +    if (F2FS_OPTION(sbi).errors == MOUNT_ERRORS_READONLY)
>>> +        seq_printf(seq, ",errors=%s", "remount-ro");
>>> +    else if (F2FS_OPTION(sbi).errors == MOUNT_ERRORS_CONTINUE)
>>> +        seq_printf(seq, ",errors=%s", "continue");
>>> +    else if (F2FS_OPTION(sbi).errors == MOUNT_ERRORS_PANIC)
>>> +        seq_printf(seq, ",errors=%s", "panic");
>>> +
>>>       return 0;
>>>   }
>>> @@ -2069,6 +2100,7 @@ static void default_options(struct f2fs_sb_info *sbi)
>>>       F2FS_OPTION(sbi).compress_mode = COMPR_MODE_FS;
>>>       F2FS_OPTION(sbi).bggc_mode = BGGC_MODE_ON;
>>>       F2FS_OPTION(sbi).memory_mode = MEMORY_MODE_NORMAL;
>>> +    F2FS_OPTION(sbi).errors = MOUNT_ERRORS_READONLY;
>>>       sbi->sb->s_flags &= ~SB_INLINECRYPT;
>>> @@ -2270,6 +2302,9 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
>>>       if (err)
>>>           goto restore_opts;
>>> +    /* flush outstanding errors before changing fs state */
>>> +    flush_work(&sbi->s_error_work);
>>> +
>>>       /*
>>>        * Previous and new state of filesystem is RO,
>>>        * so skip checking GC and FLUSH_MERGE conditions.
>>> @@ -3863,45 +3898,60 @@ int f2fs_commit_super(struct f2fs_sb_info *sbi, bool recover)
>>>       return err;
>>>   }
>>> -void f2fs_handle_stop(struct f2fs_sb_info *sbi, unsigned char reason)
>>> +static void save_stop_reason(struct f2fs_sb_info *sbi, unsigned char reason)
>>> +{
>>> +    unsigned long flags;
>>> +
>>> +    spin_lock_irqsave(&sbi->error_lock, flags);
>>> +    if (sbi->stop_reason[reason] < ((1 << BITS_PER_BYTE) - 1))
>>> +        sbi->stop_reason[reason]++;
>>> +    spin_unlock_irqrestore(&sbi->error_lock, flags);
>>> +}
>>> +
>>> +static void f2fs_record_stop_reason(struct f2fs_sb_info *sbi)
>>>   {
>>>       struct f2fs_super_block *raw_super = F2FS_RAW_SUPER(sbi);
>>> +    unsigned long flags;
>>>       int err;
>>>       f2fs_down_write(&sbi->sb_lock);
>>> -    if (raw_super->s_stop_reason[reason] < ((1 << BITS_PER_BYTE) - 1))
>>> -        raw_super->s_stop_reason[reason]++;
>>> +    spin_lock_irqsave(&sbi->error_lock, flags);
>>> +    memcpy(raw_super->s_stop_reason, sbi->stop_reason, MAX_STOP_REASON);
>>> +    spin_unlock_irqrestore(&sbi->error_lock, flags);
>>>       err = f2fs_commit_super(sbi, false);
>>> -    if (err)
>>> -        f2fs_err(sbi, "f2fs_commit_super fails to record reason:%u err:%d",
>>> -                                reason, err);
>>> +
>>>       f2fs_up_write(&sbi->sb_lock);
>>> +    if (err)
>>> +        f2fs_err(sbi, "f2fs_commit_super fails to record err:%d", err);
>>>   }
>>>   static void f2fs_save_errors(struct f2fs_sb_info *sbi, unsigned char flag)
>>>   {
>>> -    spin_lock(&sbi->error_lock);
>>> +    unsigned long flags;
>>> +
>>> +    spin_lock_irqsave(&sbi->error_lock, flags);
>>>       if (!test_bit(flag, (unsigned long *)sbi->errors)) {
>>>           set_bit(flag, (unsigned long *)sbi->errors);
>>>           sbi->error_dirty = true;
>>>       }
>>> -    spin_unlock(&sbi->error_lock);
>>> +    spin_unlock_irqrestore(&sbi->error_lock, flags);
>>>   }
>>>   static bool f2fs_update_errors(struct f2fs_sb_info *sbi)
>>>   {
>>> +    unsigned long flags;
>>>       bool need_update = false;
>>> -    spin_lock(&sbi->error_lock);
>>> +    spin_lock_irqsave(&sbi->error_lock, flags);
>>>       if (sbi->error_dirty) {
>>>           memcpy(F2FS_RAW_SUPER(sbi)->s_errors, sbi->errors,
>>>                               MAX_F2FS_ERRORS);
>>>           sbi->error_dirty = false;
>>>           need_update = true;
>>>       }
>>> -    spin_unlock(&sbi->error_lock);
>>> +    spin_unlock_irqrestore(&sbi->error_lock, flags);
>>>       return need_update;
>>>   }
>>> @@ -3925,6 +3975,67 @@ void f2fs_handle_error(struct f2fs_sb_info *sbi, unsigned char error)
>>>       f2fs_up_write(&sbi->sb_lock);
>>>   }
>>> +static bool system_going_down(void)
>>> +{
>>> +    return system_state == SYSTEM_HALT || system_state == SYSTEM_POWER_OFF
>>> +        || system_state == SYSTEM_RESTART;
>>> +}
>>> +
>>> +void f2fs_handle_critical_error(struct f2fs_sb_info *sbi, unsigned char reason,
>>> +                            bool irq_context)
>>> +{
>>> +    struct super_block *sb = sbi->sb;
>>> +    bool shutdown = reason == STOP_CP_REASON_SHUTDOWN;
>>> +    bool continue_fs = !shutdown &&
>>> +            F2FS_OPTION(sbi).errors == MOUNT_ERRORS_CONTINUE;
>>> +
>>> +    if (!continue_fs && !f2fs_readonly(sb))
>>> +        set_ckpt_flags(sbi, CP_ERROR_FLAG);
>>> +
>>> +    if (!bdev_read_only(sb->s_bdev)) {
>>> +        save_stop_reason(sbi, reason);
>>> +
>>> +        if (irq_context)
>>> +            schedule_work(&sbi->s_error_work);
>>> +        else
>>> +            f2fs_record_stop_reason(sbi);
>>> +    }
>>> +
>>> +    /*
>>> +     * We force ERRORS_RO behavior when system is rebooting. Otherwise we
>>> +     * could panic during 'reboot -f' as the underlying device got already
>>> +     * disabled.
>>> +     */
>>> +    if (F2FS_OPTION(sbi).errors == MOUNT_ERRORS_PANIC &&
>>> +                !shutdown && !system_going_down() &&
>>> +                !is_sbi_flag_set(sbi, SBI_IS_SHUTDOWN))
>>> +        panic("F2FS-fs (device %s): panic forced after error\n",
>>> +                            sb->s_id);
>>> +
>>> +    if (shutdown)
>>> +        set_sbi_flag(sbi, SBI_IS_SHUTDOWN);
>>> +
>>> +    /* continue filesystem operators if errors=continue */
>>> +    if (continue_fs || f2fs_readonly(sb))
>>> +        return;
>>> +
>>> +    f2fs_warn(sbi, "Remounting filesystem read-only");
>>> +    /*
>>> +     * Make sure updated value of ->s_mount_flags will be visible before
>>> +     * ->s_flags update
>>> +     */
>>> +    smp_wmb();
>>> +    sb->s_flags |= SB_RDONLY;
>>> +}
>>> +
>>> +static void f2fs_record_error_work(struct work_struct *work)
>>> +{
>>> +    struct f2fs_sb_info *sbi = container_of(work,
>>> +                    struct f2fs_sb_info, s_error_work);
>>> +
>>> +    f2fs_record_stop_reason(sbi);
>>> +}
>>> +
>>>   static int f2fs_scan_devices(struct f2fs_sb_info *sbi)
>>>   {
>>>       struct f2fs_super_block *raw_super = F2FS_RAW_SUPER(sbi);
>>> @@ -4205,8 +4316,10 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
>>>       if (err)
>>>           goto free_bio_info;
>>> +    INIT_WORK(&sbi->s_error_work, f2fs_record_error_work);
>>>       spin_lock_init(&sbi->error_lock);
>>>       memcpy(sbi->errors, raw_super->s_errors, MAX_F2FS_ERRORS);
>>> +    memcpy(sbi->stop_reason, raw_super->s_stop_reason, MAX_STOP_REASON);
>>>       init_f2fs_rwsem(&sbi->cp_rwsem);
>>>       init_f2fs_rwsem(&sbi->quota_sem);
>>> @@ -4542,6 +4655,8 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
>>>       f2fs_destroy_segment_manager(sbi);
>>>   stop_ckpt_thread:
>>>       f2fs_stop_ckpt_thread(sbi);
>>> +    /* flush s_error_work before sbi destroy */
>>> +    flush_work(&sbi->s_error_work);
>>>       f2fs_destroy_post_read_wq(sbi);
>>>   free_devices:
>>>       destroy_device_list(sbi);
>>> -- 
>>> 2.36.1
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
