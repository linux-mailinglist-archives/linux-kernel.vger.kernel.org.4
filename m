Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3B35F4B0C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 23:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbiJDVm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 17:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbiJDVmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 17:42:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F89A6EF3A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 14:40:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E939A6153D
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 21:40:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DA37C433C1;
        Tue,  4 Oct 2022 21:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664919636;
        bh=ForlmmAsF74ELJ6pSqxgI3p02pEoNiK8z/JWIhmVIEI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=BUQ8jMAHTvxs+Kbi82To+4fyvzY8VQmiP/wc170uKmuFW5sGoRHvDckHsGSenJ+g1
         O1Wft3zWKygXxsu1ferUnAqfJxSOONvBg+Rka1Y5HKXgigzHHllWCbkVqdXB5WTurS
         xt0ZRgkoLJVatO9iXrp9IH+nTyvWvzFJU74+6ph7QKC0XqCeya+zof9GQ6JuUMobx9
         A/26qotR3Mvzdt2V6qciw6jrc6tJZLK5lKExr4KGJA5iiifmp9c0cWd4zwAifQuypt
         xwwqTdHlU0Jz3CBM6tZlRVQlxLkRaAK8zcZnUcuCYC7OgEJC64hyyTHhPzsQgl06Ws
         ANwpN1l+VAp+A==
Message-ID: <3c1c5e89-efe0-679c-3f86-2fea09a17317@kernel.org>
Date:   Wed, 5 Oct 2022 05:40:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v3] f2fs: support errors=remount-ro|continue|panic
 mountoption
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20221004135807.37082-1-chao@kernel.org>
 <YzyXaZx4SBIN8OTK@google.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <YzyXaZx4SBIN8OTK@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/10/5 4:28, Jaegeuk Kim wrote:
> On 10/04, Chao Yu wrote:
>> This patch supports errors=remount-ro|continue|panic mount option.
>>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>> - clean up codes
>> - stop gc/discard threads after remount fs as readonly
>> - don't panic() after f2fs is shutdown
>>   Documentation/filesystems/f2fs.rst |   4 +
>>   fs/f2fs/checkpoint.c               |   7 +-
>>   fs/f2fs/f2fs.h                     |  18 ++++-
>>   fs/f2fs/file.c                     |   5 --
>>   fs/f2fs/super.c                    | 116 +++++++++++++++++++++++++++--
>>   5 files changed, 131 insertions(+), 19 deletions(-)
>>
>> diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
>> index d0c09663dae8..6f19e7f9e908 100644
>> --- a/Documentation/filesystems/f2fs.rst
>> +++ b/Documentation/filesystems/f2fs.rst
>> @@ -341,6 +341,10 @@ memory=%s		 Control memory mode. This supports "normal" and "low" modes.
>>   			 Because of the nature of low memory devices, in this mode, f2fs
>>   			 will try to save memory sometimes by sacrificing performance.
>>   			 "normal" mode is the default mode and same as before.
>> +errors=%s		 Specify f2fs behavior on critical errors. This supports modes:
>> +			 "panic", "continue" and "remount-ro", respectively, trigger
>> +			 panic immediately, continue without doing anything, and remount
>> +			 the partition in read-only mode (default behavior).
>>   ======================== ============================================================
>>   
>>   Debugfs Entries
>> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
>> index 0c82dae082aa..109e96c15b84 100644
>> --- a/fs/f2fs/checkpoint.c
>> +++ b/fs/f2fs/checkpoint.c
>> @@ -30,12 +30,9 @@ void f2fs_stop_checkpoint(struct f2fs_sb_info *sbi, bool end_io,
>>   						unsigned char reason)
>>   {
>>   	f2fs_build_fault_attr(sbi, 0, 0);
>> -	set_ckpt_flags(sbi, CP_ERROR_FLAG);
>> -	if (!end_io) {
>> +	if (!end_io)
>>   		f2fs_flush_merged_writes(sbi);
>> -
>> -		f2fs_handle_stop(sbi, reason);
>> -	}
>> +	f2fs_handle_critical_error(sbi, reason, end_io);
>>   }
>>   
>>   /*
>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>> index a0b2c8626a75..40c8e28f41ba 100644
>> --- a/fs/f2fs/f2fs.h
>> +++ b/fs/f2fs/f2fs.h
>> @@ -160,6 +160,7 @@ struct f2fs_mount_info {
>>   	int fs_mode;			/* fs mode: LFS or ADAPTIVE */
>>   	int bggc_mode;			/* bggc mode: off, on or sync */
>>   	int memory_mode;		/* memory mode */
>> +	int errors;			/* errors parameter */
>>   	int discard_unit;		/*
>>   					 * discard command's offset/size should
>>   					 * be aligned to this unit: block,
>> @@ -1382,7 +1383,11 @@ enum {
>>   	MEMORY_MODE_LOW,	/* memory mode for low memry devices */
>>   };
>>   
>> -
>> +enum errors_option {
>> +	MOUNT_ERRORS_READONLY,	/* remount fs ro on errors */
>> +	MOUNT_ERRORS_CONTINUE,	/* continue on errors */
>> +	MOUNT_ERRORS_PANIC,	/* panic on errors */
>> +};
>>   
>>   static inline int f2fs_test_bit(unsigned int nr, char *addr);
>>   static inline void f2fs_set_bit(unsigned int nr, char *addr);
>> @@ -1818,7 +1823,13 @@ struct f2fs_sb_info {
>>   
>>   	struct workqueue_struct *post_read_wq;	/* post read workqueue */
>>   
>> -	unsigned char errors[MAX_F2FS_ERRORS];	/* error flags */
>> +	/*
>> +	 * If we are in irq context, let's update error information into
>> +	 * on-disk superblock in the work.
>> +	 */
>> +	struct work_struct s_error_work;
>> +	unsigned char errors[MAX_F2FS_ERRORS];		/* error flags */
>> +	unsigned char stop_reason[MAX_STOP_REASON];	/* stop reason */
>>   	spinlock_t error_lock;			/* protect errors array */
>>   	bool error_dirty;			/* errors of sb is dirty */
>>   
>> @@ -3563,7 +3574,8 @@ int f2fs_enable_quota_files(struct f2fs_sb_info *sbi, bool rdonly);
>>   int f2fs_quota_sync(struct super_block *sb, int type);
>>   loff_t max_file_blocks(struct inode *inode);
>>   void f2fs_quota_off_umount(struct super_block *sb);
>> -void f2fs_handle_stop(struct f2fs_sb_info *sbi, unsigned char reason);
>> +void f2fs_handle_critical_error(struct f2fs_sb_info *sbi, unsigned char reason,
>> +							bool irq_context);
>>   void f2fs_handle_error(struct f2fs_sb_info *sbi, unsigned char error);
>>   int f2fs_commit_super(struct f2fs_sb_info *sbi, bool recover);
>>   int f2fs_sync_fs(struct super_block *sb, int sync);
>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>> index df5e7ad80096..acda670df676 100644
>> --- a/fs/f2fs/file.c
>> +++ b/fs/f2fs/file.c
>> @@ -2157,7 +2157,6 @@ static int f2fs_ioc_shutdown(struct file *filp, unsigned long arg)
>>   				ret = 0;
>>   				f2fs_stop_checkpoint(sbi, false,
>>   						STOP_CP_REASON_SHUTDOWN);
>> -				set_sbi_flag(sbi, SBI_IS_SHUTDOWN);
> 
> What about keeping this and bypassing panic if this is set?

Please check below code, it processes like you suggested:

+	if (F2FS_OPTION(sbi).errors == MOUNT_ERRORS_PANIC &&
+				!shutdown && !system_going_down() &&
+				!is_sbi_flag_set(sbi, SBI_IS_SHUTDOWN))
+		panic("F2FS-fs (device %s): panic forced after error\n",
+							sb->s_id);
+
+	if (shutdown)
+		set_sbi_flag(sbi, SBI_IS_SHUTDOWN);

Thanks,

> 
>>   				trace_f2fs_shutdown(sbi, in, ret);
>>   			}
>>   			return ret;
>> @@ -2170,7 +2169,6 @@ static int f2fs_ioc_shutdown(struct file *filp, unsigned long arg)
>>   		if (ret)
>>   			goto out;
>>   		f2fs_stop_checkpoint(sbi, false, STOP_CP_REASON_SHUTDOWN);
>> -		set_sbi_flag(sbi, SBI_IS_SHUTDOWN);
>>   		thaw_bdev(sb->s_bdev);
>>   		break;
>>   	case F2FS_GOING_DOWN_METASYNC:
>> @@ -2179,16 +2177,13 @@ static int f2fs_ioc_shutdown(struct file *filp, unsigned long arg)
>>   		if (ret)
>>   			goto out;
>>   		f2fs_stop_checkpoint(sbi, false, STOP_CP_REASON_SHUTDOWN);
>> -		set_sbi_flag(sbi, SBI_IS_SHUTDOWN);
>>   		break;
>>   	case F2FS_GOING_DOWN_NOSYNC:
>>   		f2fs_stop_checkpoint(sbi, false, STOP_CP_REASON_SHUTDOWN);
>> -		set_sbi_flag(sbi, SBI_IS_SHUTDOWN);
>>   		break;
>>   	case F2FS_GOING_DOWN_METAFLUSH:
>>   		f2fs_sync_meta_pages(sbi, META, LONG_MAX, FS_META_IO);
>>   		f2fs_stop_checkpoint(sbi, false, STOP_CP_REASON_SHUTDOWN);
>> -		set_sbi_flag(sbi, SBI_IS_SHUTDOWN);
>>   		break;
>>   	case F2FS_GOING_DOWN_NEED_FSCK:
>>   		set_sbi_flag(sbi, SBI_NEED_FSCK);
>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>> index 6cf72fbf2054..787010893a12 100644
>> --- a/fs/f2fs/super.c
>> +++ b/fs/f2fs/super.c
>> @@ -161,6 +161,7 @@ enum {
>>   	Opt_nogc_merge,
>>   	Opt_discard_unit,
>>   	Opt_memory_mode,
>> +	Opt_errors,
>>   	Opt_err,
>>   };
>>   
>> @@ -238,6 +239,7 @@ static match_table_t f2fs_tokens = {
>>   	{Opt_nogc_merge, "nogc_merge"},
>>   	{Opt_discard_unit, "discard_unit=%s"},
>>   	{Opt_memory_mode, "memory=%s"},
>> +	{Opt_errors, "errors=%s"},
>>   	{Opt_err, NULL},
>>   };
>>   
>> @@ -1253,6 +1255,25 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
>>   			}
>>   			kfree(name);
>>   			break;
>> +		case Opt_errors:
>> +			name = match_strdup(&args[0]);
>> +			if (!name)
>> +				return -ENOMEM;
>> +			if (!strcmp(name, "remount-ro")) {
>> +				F2FS_OPTION(sbi).errors =
>> +						MOUNT_ERRORS_READONLY;
>> +			} else if (!strcmp(name, "continue")) {
>> +				F2FS_OPTION(sbi).errors =
>> +						MOUNT_ERRORS_CONTINUE;
>> +			} else if (!strcmp(name, "panic")) {
>> +				F2FS_OPTION(sbi).errors =
>> +						MOUNT_ERRORS_PANIC;
>> +			} else {
>> +				kfree(name);
>> +				return -EINVAL;
>> +			}
>> +			kfree(name);
>> +			break;
>>   		default:
>>   			f2fs_err(sbi, "Unrecognized mount option \"%s\" or missing value",
>>   				 p);
>> @@ -2031,6 +2052,13 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
>>   	else if (F2FS_OPTION(sbi).memory_mode == MEMORY_MODE_LOW)
>>   		seq_printf(seq, ",memory=%s", "low");
>>   
>> +	if (F2FS_OPTION(sbi).errors == MOUNT_ERRORS_READONLY)
>> +		seq_printf(seq, ",errors=%s", "remount-ro");
>> +	else if (F2FS_OPTION(sbi).errors == MOUNT_ERRORS_CONTINUE)
>> +		seq_printf(seq, ",errors=%s", "continue");
>> +	else if (F2FS_OPTION(sbi).errors == MOUNT_ERRORS_PANIC)
>> +		seq_printf(seq, ",errors=%s", "panic");
>> +
>>   	return 0;
>>   }
>>   
>> @@ -2053,6 +2081,7 @@ static void default_options(struct f2fs_sb_info *sbi)
>>   	F2FS_OPTION(sbi).compress_mode = COMPR_MODE_FS;
>>   	F2FS_OPTION(sbi).bggc_mode = BGGC_MODE_ON;
>>   	F2FS_OPTION(sbi).memory_mode = MEMORY_MODE_NORMAL;
>> +	F2FS_OPTION(sbi).errors = MOUNT_ERRORS_READONLY;
>>   
>>   	sbi->sb->s_flags &= ~SB_INLINECRYPT;
>>   
>> @@ -3846,21 +3875,30 @@ int f2fs_commit_super(struct f2fs_sb_info *sbi, bool recover)
>>   	return err;
>>   }
>>   
>> -void f2fs_handle_stop(struct f2fs_sb_info *sbi, unsigned char reason)
>> +static void save_stop_reason(struct f2fs_sb_info *sbi, unsigned char reason)
>> +{
>> +	spin_lock(&sbi->error_lock);
>> +	if (sbi->stop_reason[reason] < ((1 << BITS_PER_BYTE) - 1))
>> +		sbi->stop_reason[reason]++;
>> +	spin_unlock(&sbi->error_lock);
>> +}
>> +
>> +void f2fs_record_stop_reason(struct f2fs_sb_info *sbi)
>>   {
>>   	struct f2fs_super_block *raw_super = F2FS_RAW_SUPER(sbi);
>>   	int err;
>>   
>>   	f2fs_down_write(&sbi->sb_lock);
>>   
>> -	if (raw_super->s_stop_reason[reason] < ((1 << BITS_PER_BYTE) - 1))
>> -		raw_super->s_stop_reason[reason]++;
>> +	spin_lock(&sbi->error_lock);
>> +	memcpy(raw_super->s_stop_reason, sbi->stop_reason, MAX_STOP_REASON);
>> +	spin_unlock(&sbi->error_lock);
>>   
>>   	err = f2fs_commit_super(sbi, false);
>> -	if (err)
>> -		f2fs_err(sbi, "f2fs_commit_super fails to record reason:%u err:%d",
>> -								reason, err);
>> +
>>   	f2fs_up_write(&sbi->sb_lock);
>> +	if (err)
>> +		f2fs_err(sbi, "f2fs_commit_super fails to record err:%d", err);
>>   }
>>   
>>   static void f2fs_save_errors(struct f2fs_sb_info *sbi, unsigned char flag)
>> @@ -3908,6 +3946,70 @@ void f2fs_handle_error(struct f2fs_sb_info *sbi, unsigned char error)
>>   	f2fs_up_write(&sbi->sb_lock);
>>   }
>>   
>> +static bool system_going_down(void)
>> +{
>> +	return system_state == SYSTEM_HALT || system_state == SYSTEM_POWER_OFF
>> +		|| system_state == SYSTEM_RESTART;
>> +}
>> +
>> +void f2fs_handle_critical_error(struct f2fs_sb_info *sbi, unsigned char reason,
>> +							bool irq_context)
>> +{
>> +	struct super_block *sb = sbi->sb;
>> +	bool shutdown = reason == STOP_CP_REASON_SHUTDOWN;
>> +	bool continue_fs = !shutdown &&
>> +			F2FS_OPTION(sbi).errors == MOUNT_ERRORS_CONTINUE;
>> +
>> +	if (!continue_fs && !f2fs_readonly(sb))
>> +		set_ckpt_flags(sbi, CP_ERROR_FLAG);
>> +
>> +	if (!bdev_read_only(sb->s_bdev)) {
>> +		save_stop_reason(sbi, reason);
>> +
>> +		if (irq_context)
>> +			schedule_work(&sbi->s_error_work);
>> +		else
>> +			f2fs_record_stop_reason(sbi);
>> +	}
>> +
>> +	/*
>> +	 * We force ERRORS_RO behavior when system is rebooting. Otherwise we
>> +	 * could panic during 'reboot -f' as the underlying device got already
>> +	 * disabled.
>> +	 */
>> +	if (F2FS_OPTION(sbi).errors == MOUNT_ERRORS_PANIC &&
>> +				!shutdown && !system_going_down() &&
>> +				!is_sbi_flag_set(sbi, SBI_IS_SHUTDOWN))
>> +		panic("F2FS-fs (device %s): panic forced after error\n",
>> +							sb->s_id);
>> +
>> +	if (shutdown)
>> +		set_sbi_flag(sbi, SBI_IS_SHUTDOWN);
>> +
>> +	/* continue filesystem operators if errors=continue */
>> +	if (continue_fs || f2fs_readonly(sb))
>> +		return;
>> +
>> +	f2fs_warn(sbi, "Remounting filesystem read-only");
>> +	/*
>> +	 * Make sure updated value of ->s_mount_flags will be visible before
>> +	 * ->s_flags update
>> +	 */
>> +	smp_wmb();
>> +	sb->s_flags |= SB_RDONLY;
>> +
>> +	f2fs_stop_gc_thread(sbi);
>> +	f2fs_stop_discard_thread(sbi);
>> +}
>> +
>> +static void flush_error_work(struct work_struct *work)
>> +{
>> +	struct f2fs_sb_info *sbi = container_of(work,
>> +					struct f2fs_sb_info, s_error_work);
>> +
>> +	f2fs_record_stop_reason(sbi);
>> +}
>> +
>>   static int f2fs_scan_devices(struct f2fs_sb_info *sbi)
>>   {
>>   	struct f2fs_super_block *raw_super = F2FS_RAW_SUPER(sbi);
>> @@ -4255,8 +4357,10 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
>>   		goto free_devices;
>>   	}
>>   
>> +	INIT_WORK(&sbi->s_error_work, flush_error_work);
>>   	spin_lock_init(&sbi->error_lock);
>>   	memcpy(sbi->errors, raw_super->s_errors, MAX_F2FS_ERRORS);
>> +	memcpy(sbi->stop_reason, raw_super->s_stop_reason, MAX_STOP_REASON);
>>   
>>   	sbi->total_valid_node_count =
>>   				le32_to_cpu(sbi->ckpt->valid_node_count);
>> -- 
>> 2.36.1
