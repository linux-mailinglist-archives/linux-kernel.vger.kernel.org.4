Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B434F72FC2D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 13:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243806AbjFNLPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 07:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243754AbjFNLO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 07:14:59 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE221FD8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 04:14:56 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 050FD6606EFD;
        Wed, 14 Jun 2023 12:14:53 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686741294;
        bh=B5g6+rw/JvzeWfANtR8ueJtO19yy16bXmz+WyWHXEWs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GTbPVG5pwg3vd6kh+iNh30oTJI6/O4mxWZk6rAEJ8pjsWg2UihRR8EH8YDdVDliaB
         ZWBvp2164clsNR9YWPBKb46NkfzvQX9GDHQIiZtyF947H4eO3fkYklcHfMmVldadMm
         OpJL6O+5XmoUXyJuWB7J8gcPisHnbvza3Z5runhyQrVmIgishBKuclp0aKfOMJsby9
         YbhSH6kwIShosYVGyWQAj97rk/QCIdL/ZQNjW8SSuflJNMnDuNVaDG3Z7h0H5uxyxT
         xD/kDsi9cMGrAlC97ylvebMAsorilI07krwLVU9R04Z6n3vGPL7JBC8qmrTrhrmWxJ
         CGKdUVcdqvmwg==
Message-ID: <d02cff38-0713-b81c-11ac-85cea6508ef1@collabora.com>
Date:   Wed, 14 Jun 2023 13:14:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 3/3] misc : mediatek_mbraink : Collect the system
 process and memory data
Content-Language: en-US
To:     Wei Chin Tsai <Wei-chin.Tsai@mediatek.com>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     wsd_upstream@mediatek.com, mel.lee@mediatek.com,
        ivan.tseng@mediatek.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230614032038.11699-1-Wei-chin.Tsai@mediatek.com>
 <20230614032038.11699-4-Wei-chin.Tsai@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230614032038.11699-4-Wei-chin.Tsai@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 14/06/23 05:20, Wei Chin Tsai ha scritto:
> In this patch, we add the mediatek_mbrain folder
> including 7 files. Apart from Makefile and Kconfig,
> the aim of the other 5 files is to collect the
> process fork/exit tracing data and process memory
> pss, uss, rss, swap, and heap usage.
> User could use these kind of data to do the system
> analysis, and detect the unexpected process/memory
> issues. Furthermore, user can make use of process
> memory data to detect the memory leak issues.
>  From memory heap aspect, user could know the java
> and native layer heap usage.
> Also, user can capture those processes which run
> in a second and then terminate immediately by add
> the hook functions in "sched_process_fork" and
> "sched_process_exit".
> 

How is MediaTek MBrain different from the already existing debugging/tracing and
memory analysis infrastructure of the Linux kernel, and why is it needed?
If there's little difference, as in that you need some more features, you may as
well implement the missing features in the standard infra.

Another issue with this driver is that I can't find any source code for the
MediaTek MBrain userspace part (which is totally needed to use this driver).

Regards,
Angelo

> Signed-off-by: Wei Chin Tsai <Wei-chin.Tsai@mediatek.com>
> ---
>   drivers/misc/mediatek_mbraink/Kconfig         |  15 +
>   drivers/misc/mediatek_mbraink/Makefile        |   5 +
>   drivers/misc/mediatek_mbraink/mbraink_data.c  | 417 ++++++++++++++++++
>   drivers/misc/mediatek_mbraink/mbraink_data.h  |  66 +++
>   .../mbraink_ioctl_struct_define.h             |  44 ++
>   drivers/misc/mediatek_mbraink/mbraink_main.c  | 239 ++++++++++
>   drivers/misc/mediatek_mbraink/mbraink_main.h  |  36 ++
>   7 files changed, 822 insertions(+)
>   create mode 100644 drivers/misc/mediatek_mbraink/Kconfig
>   create mode 100644 drivers/misc/mediatek_mbraink/Makefile
>   create mode 100644 drivers/misc/mediatek_mbraink/mbraink_data.c
>   create mode 100644 drivers/misc/mediatek_mbraink/mbraink_data.h
>   create mode 100644 drivers/misc/mediatek_mbraink/mbraink_ioctl_struct_define.h
>   create mode 100644 drivers/misc/mediatek_mbraink/mbraink_main.c
>   create mode 100644 drivers/misc/mediatek_mbraink/mbraink_main.h
> 
> diff --git a/drivers/misc/mediatek_mbraink/Kconfig b/drivers/misc/mediatek_mbraink/Kconfig
> new file mode 100644
> index 000000000000..4a96059e4c57
> --- /dev/null
> +++ b/drivers/misc/mediatek_mbraink/Kconfig
> @@ -0,0 +1,15 @@
> +config MTK_MBRAINK
> +	tristate "MTK MBRAINK support"
> +	help
> +          MBRAINK is a MediaTek in-house kernel module which can
> +          communicate with android MBrain.
> +          Set Y to enable this feature.
> +          If unsure, Set N to stay with legancy feature.
> +
> +config MTK_MBRAINK_EXPORT_DEPENDED
> +	tristate "MTK MBRAINK EXPORT DEPENDED support"
> +	help
> +	  MBRAINK EXPORT DEPENDED option which
> +	  needs to export extra function in upstram kernel.
> +	  Set Y to enable this feature.
> +	  If unsure, Set N to stay with legancy feature.
> diff --git a/drivers/misc/mediatek_mbraink/Makefile b/drivers/misc/mediatek_mbraink/Makefile
> new file mode 100644
> index 000000000000..8d75b41a8097
> --- /dev/null
> +++ b/drivers/misc/mediatek_mbraink/Makefile
> @@ -0,0 +1,5 @@
> +subdir-ccflags-y += -Wformat
> +
> +obj-${CONFIG_MTK_MBRAINK} += mtk_mbraink.o
> +
> +mtk_mbraink-objs += mbraink_data.o mbraink_main.o
> diff --git a/drivers/misc/mediatek_mbraink/mbraink_data.c b/drivers/misc/mediatek_mbraink/mbraink_data.c
> new file mode 100644
> index 000000000000..dad03124820a
> --- /dev/null
> +++ b/drivers/misc/mediatek_mbraink/mbraink_data.c
> @@ -0,0 +1,417 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2023 MediaTek Inc.
> + */
> +#include <linux/module.h>
> +#include <linux/fs.h>
> +#include <linux/rtc.h>
> +#include <linux/sched/clock.h>
> +#include <linux/kernel.h>
> +#include <linux/uaccess.h>
> +#include <linux/cdev.h>
> +#include <linux/proc_fs.h>
> +#include <linux/sched/signal.h>
> +#include <linux/pid_namespace.h>
> +#include <linux/mm.h>
> +#include <linux/sched/mm.h>
> +#include <linux/sched/task.h>
> +#include <linux/pagewalk.h>
> +#include <linux/shmem_fs.h>
> +#include <linux/pagemap.h>
> +#include <linux/mempolicy.h>
> +#include <linux/rmap.h>
> +#include <linux/sched/cputime.h>
> +#include <linux/math64.h>
> +#include <linux/refcount.h>
> +#include <linux/ctype.h>
> +#include <linux/stddef.h>
> +#include <linux/cred.h>
> +#include <linux/spinlock.h>
> +#include <linux/rtc.h>
> +#include <linux/sched/clock.h>
> +#include <trace/events/sched.h>
> +#include <linux/mm_inline.h>
> +
> +#include "mbraink_data.h"
> +
> +/*spinlock for mbraink tracing pidlist*/
> +static DEFINE_SPINLOCK(tracing_pidlist_lock);
> +/*Please make sure that tracing pidlist is protected by spinlock*/
> +struct mbraink_tracing_pidlist mbraink_tracing_pidlist_data[MAX_TRACE_NUM];
> +
> +#if IS_ENABLED(CONFIG_ANON_VMA_NAME)
> +struct anon_vma_name *mbraink_anon_vma_name(struct vm_area_struct *vma)
> +{
> +	if (vma->vm_file)
> +		return NULL;
> +
> +	return vma->anon_name;
> +}
> +#else
> +struct anon_vma_name *mbraink_anon_vma_name(struct vm_area_struct *vma)
> +{
> +	return NULL;
> +}
> +#endif
> +
> +void mbraink_map_vma(struct vm_area_struct *vma, unsigned long cur_pss,
> +		     unsigned long *native_heap, unsigned long *java_heap)
> +{
> +	struct mm_struct *mm = vma->vm_mm;
> +	const char *name = NULL;
> +
> +	if (vma->vm_file)
> +		return;
> +	/*
> +	 * Print the dentry name for named mappings, and a
> +	 * special [heap] marker for the heap:
> +	 */
> +
> +	if (vma->vm_ops && vma->vm_ops->name) {
> +		name = vma->vm_ops->name(vma);
> +		if (name) {
> +			if (strncmp(name, "dev/ashmem/libc malloc", 23) == 0)
> +				(*native_heap) += cur_pss;
> +			return;
> +		}
> +	}
> +
> +	name = arch_vma_name(vma);
> +	if (!name) {
> +		struct anon_vma_name *anon_name;
> +
> +		if (!mm)
> +			return;
> +
> +		if (vma->vm_start <= mm->brk && vma->vm_end >= mm->start_brk) {
> +			(*native_heap) += cur_pss;
> +			return;
> +		}
> +
> +		if (vma->vm_start <= vma->vm_mm->start_stack &&
> +		    vma->vm_end >= vma->vm_mm->start_stack)
> +			return;
> +
> +		anon_name = mbraink_anon_vma_name(vma);
> +		if (anon_name) {
> +			if (strstr(anon_name->name, "scudo"))
> +				(*native_heap) += cur_pss;
> +			else if (strstr(anon_name->name, "libc_malloc"))
> +				(*native_heap) += cur_pss;
> +			else if (strstr(anon_name->name, "GWP-ASan"))
> +				(*native_heap) += cur_pss;
> +			else if (strstr(anon_name->name, "dalvik-alloc space"))
> +				(*java_heap) += cur_pss;
> +			else if (strstr(anon_name->name, "dalvik-main space"))
> +				(*java_heap) += cur_pss;
> +			else if (strstr(anon_name->name, "dalvik-large object space"))
> +				(*java_heap) += cur_pss;
> +			else if (strstr(anon_name->name, "dalvik-free list large object space"))
> +				(*java_heap) += cur_pss;
> +			else if (strstr(anon_name->name, "dalvik-non moving space"))
> +				(*java_heap) += cur_pss;
> +			else if (strstr(anon_name->name, "dalvik-zygote space"))
> +				(*java_heap) += cur_pss;
> +		}
> +	}
> +}
> +
> +void mbraink_get_process_memory_info(pid_t current_pid,
> +				     struct mbraink_process_memory_data *process_memory_buffer)
> +{
> +	struct task_struct *t = NULL;
> +	struct mm_struct *mm = NULL;
> +	struct vm_area_struct *vma = NULL;
> +	struct mem_size_stats mss;
> +	unsigned short pid_count = 0;
> +	unsigned long pss, uss, rss, swap, cur_pss;
> +	unsigned long java_heap = 0, native_heap = 0;
> +	struct vma_iterator vmi;
> +
> +	memset(process_memory_buffer, 0, sizeof(struct mbraink_process_memory_data));
> +	process_memory_buffer->pid = 0;
> +
> +	read_lock(&tasklist_lock);
> +	for_each_process(t) {
> +		if (t->pid <= current_pid)
> +			continue;
> +
> +		mm = t->mm;
> +		if (mm) {
> +			java_heap = 0;
> +			native_heap = 0;
> +			pid_count = process_memory_buffer->pid_count;
> +
> +			process_memory_buffer->drv_data[pid_count].pid =
> +				(unsigned short)(t->pid);
> +			process_memory_buffer->pid =
> +				(unsigned short)(t->pid);
> +
> +			memset(&mss, 0, sizeof(mss));
> +			get_task_struct(t);
> +			mmgrab(mm);
> +			read_unlock(&tasklist_lock);
> +			mmap_read_lock(mm);
> +			vma_iter_init(&vmi, mm, 0);
> +			for_each_vma(vmi, vma) {
> +				cur_pss = (unsigned long)(mss.pss >> PSS_SHIFT);
> +				smap_gather_stats(vma, &mss, 0);
> +				cur_pss =
> +					((unsigned long)(mss.pss >> PSS_SHIFT)) - cur_pss;
> +				cur_pss = cur_pss / 1024;
> +				mbraink_map_vma(vma, cur_pss, &native_heap, &java_heap);
> +			}
> +			mmap_read_unlock(mm);
> +			read_lock(&tasklist_lock);
> +			mmdrop(mm);
> +			put_task_struct(t);
> +
> +			pss = (unsigned long)(mss.pss >> PSS_SHIFT) / 1024;
> +			uss = (mss.private_clean + mss.private_dirty) / 1024;
> +			rss = (mss.resident) / 1024;
> +			swap = (mss.swap) / 1024;
> +
> +			process_memory_buffer->drv_data[pid_count].pss = pss;
> +			process_memory_buffer->drv_data[pid_count].uss = uss;
> +			process_memory_buffer->drv_data[pid_count].rss = rss;
> +			process_memory_buffer->drv_data[pid_count].swap = swap;
> +			process_memory_buffer->drv_data[pid_count].java_heap =
> +									java_heap;
> +			process_memory_buffer->drv_data[pid_count].native_heap =
> +									native_heap;
> +			process_memory_buffer->pid_count++;
> +
> +			break;
> +		}
> +	}
> +	read_unlock(&tasklist_lock);
> +}
> +
> +/*****************************************************************
> + * Note: this function can only be used during tracing function
> + * This function is only used in tracing function so that there
> + * is no need for task t spinlock protection
> + *****************************************************************/
> +static u64 mbraink_get_specific_process_jiffies(struct task_struct *t)
> +{
> +	u64 stime = 0, utime = 0, cutime = 0, cstime = 0;
> +	u64 process_jiffies = 0;
> +
> +	if (t->pid == t->tgid) {
> +		cutime = t->signal->cutime;
> +		cstime = t->signal->cstime;
> +		if (t->flags & PF_KTHREAD)
> +			task_cputime_adjusted(t, &utime, &stime);
> +		else
> +			thread_group_cputime_adjusted(t, &utime, &stime);
> +
> +		process_jiffies = nsec_to_clock_t(utime) +
> +				nsec_to_clock_t(stime) +
> +				nsec_to_clock_t(cutime) +
> +				nsec_to_clock_t(cstime);
> +	} else {
> +		task_cputime_adjusted(t, &utime, &stime);
> +		process_jiffies = nsec_to_clock_t(utime) + nsec_to_clock_t(stime);
> +	}
> +
> +	return process_jiffies;
> +}
> +
> +/***************************************************************
> + * Note: this function can only be used during tracing function
> + * This function is only used in tracing function so that there
> + * is no need for task t spinlock protection
> + **************************************************************/
> +static u16 mbraink_get_specific_process_uid(struct task_struct *t)
> +{
> +	const struct cred *cred = NULL;
> +	u16 val = 0;
> +
> +	cred = get_task_cred(t);
> +	val = cred->uid.val;
> +	put_cred(cred);
> +
> +	return val;
> +}
> +
> +static void mbraink_trace_sched_process_exit(void *data, struct task_struct *t)
> +{
> +	int i = 0;
> +	struct timespec64 tv = { 0 };
> +	unsigned long flags;
> +
> +	if (t->pid == t->tgid) {
> +		spin_lock_irqsave(&tracing_pidlist_lock, flags);
> +		for (i = 0; i < MAX_TRACE_NUM; i++) {
> +			if (mbraink_tracing_pidlist_data[i].pid == (unsigned short)t->pid) {
> +				ktime_get_real_ts64(&tv);
> +				mbraink_tracing_pidlist_data[i].end =
> +					(tv.tv_sec * 1000) + (tv.tv_nsec / 1000000);
> +				mbraink_tracing_pidlist_data[i].jiffies =
> +						mbraink_get_specific_process_jiffies(t);
> +				mbraink_tracing_pidlist_data[i].dirty = true;
> +
> +				break;
> +			}
> +		}
> +		if (i == MAX_TRACE_NUM) {
> +			for (i = 0; i < MAX_TRACE_NUM; i++) {
> +				if (mbraink_tracing_pidlist_data[i].pid == 0) {
> +					mbraink_tracing_pidlist_data[i].pid =
> +							(unsigned short)(t->pid);
> +					mbraink_tracing_pidlist_data[i].tgid =
> +							(unsigned short)(t->tgid);
> +					mbraink_tracing_pidlist_data[i].uid =
> +							mbraink_get_specific_process_uid(t);
> +					mbraink_tracing_pidlist_data[i].priority =
> +							t->prio - MAX_RT_PRIO;
> +					memcpy(mbraink_tracing_pidlist_data[i].name,
> +					       t->comm, TASK_COMM_LEN);
> +					ktime_get_real_ts64(&tv);
> +					mbraink_tracing_pidlist_data[i].end =
> +							(tv.tv_sec * 1000) + (tv.tv_nsec / 1000000);
> +					mbraink_tracing_pidlist_data[i].jiffies =
> +							mbraink_get_specific_process_jiffies(t);
> +					mbraink_tracing_pidlist_data[i].dirty = true;
> +
> +					break;
> +				}
> +			}
> +			if (i == MAX_TRACE_NUM) {
> +				pr_info("%s pid=%u:%s.\n", __func__, t->pid, t->comm);
> +				memset(mbraink_tracing_pidlist_data, 0,
> +				       sizeof(struct mbraink_tracing_pidlist) * MAX_TRACE_NUM);
> +			}
> +		}
> +		spin_unlock_irqrestore(&tracing_pidlist_lock, flags);
> +	}
> +}
> +
> +static void mbraink_trace_sched_process_fork(void *data, struct task_struct *t,
> +					     struct task_struct *p)
> +{
> +	int i = 0;
> +	struct timespec64 tv = { 0 };
> +	unsigned long flags;
> +
> +	if (p->pid == p->tgid) {
> +		spin_lock_irqsave(&tracing_pidlist_lock, flags);
> +		for (i = 0; i < MAX_TRACE_NUM; i++) {
> +			if (mbraink_tracing_pidlist_data[i].pid == 0) {
> +				mbraink_tracing_pidlist_data[i].pid = (unsigned short)(p->pid);
> +				mbraink_tracing_pidlist_data[i].tgid = (unsigned short)(p->tgid);
> +				mbraink_tracing_pidlist_data[i].uid =
> +						mbraink_get_specific_process_uid(p);
> +				mbraink_tracing_pidlist_data[i].priority = p->prio - MAX_RT_PRIO;
> +				memcpy(mbraink_tracing_pidlist_data[i].name,
> +				       p->comm, TASK_COMM_LEN);
> +				ktime_get_real_ts64(&tv);
> +				mbraink_tracing_pidlist_data[i].start =
> +						(tv.tv_sec * 1000) + (tv.tv_nsec / 1000000);
> +				mbraink_tracing_pidlist_data[i].dirty = true;
> +				break;
> +			}
> +		}
> +
> +		if (i == MAX_TRACE_NUM) {
> +			pr_info("%s child_pid=%u:%s.\n", __func__, p->pid, p->comm);
> +			memset(mbraink_tracing_pidlist_data, 0,
> +			       sizeof(struct mbraink_tracing_pidlist) * MAX_TRACE_NUM);
> +		}
> +		spin_unlock_irqrestore(&tracing_pidlist_lock, flags);
> +	}
> +}
> +
> +int mbraink_process_tracer_init(void)
> +{
> +	int ret = 0;
> +
> +	memset(mbraink_tracing_pidlist_data, 0,
> +	       sizeof(struct mbraink_tracing_pidlist) * MAX_TRACE_NUM);
> +
> +	ret = register_trace_sched_process_fork(mbraink_trace_sched_process_fork, NULL);
> +	if (ret) {
> +		pr_notice("register_trace_sched_process_fork failed.\n");
> +		goto register_trace_sched_process_fork;
> +	}
> +	ret = register_trace_sched_process_exit(mbraink_trace_sched_process_exit, NULL);
> +	if (ret) {
> +		pr_notice("register register_trace_sched_process_exit failed.\n");
> +		goto register_trace_sched_process_exit;
> +	}
> +
> +	return ret;
> +
> +register_trace_sched_process_exit:
> +	unregister_trace_sched_process_fork(mbraink_trace_sched_process_fork, NULL);
> +register_trace_sched_process_fork:
> +	return ret;
> +}
> +
> +void mbraink_process_tracer_exit(void)
> +{
> +	unregister_trace_sched_process_fork(mbraink_trace_sched_process_fork, NULL);
> +	unregister_trace_sched_process_exit(mbraink_trace_sched_process_exit, NULL);
> +}
> +
> +void mbraink_get_tracing_pid_info(unsigned short current_idx,
> +				  struct mbraink_tracing_pid_data *tracing_pid_buffer)
> +{
> +	int i = 0;
> +	int ret = 0;
> +	unsigned long flags;
> +	unsigned short tracing_count = 0;
> +
> +	spin_lock_irqsave(&tracing_pidlist_lock, flags);
> +
> +	memset(tracing_pid_buffer, 0, sizeof(struct mbraink_tracing_pid_data));
> +
> +	for (i = current_idx; i < MAX_TRACE_NUM; i++) {
> +		if (mbraink_tracing_pidlist_data[i].dirty == 0) {
> +			continue;
> +		} else {
> +			tracing_count = tracing_pid_buffer->tracing_count;
> +			if (tracing_count < MAX_TRACE_PID_NUM) {
> +				tracing_pid_buffer->drv_data[tracing_count].pid =
> +						mbraink_tracing_pidlist_data[i].pid;
> +				tracing_pid_buffer->drv_data[tracing_count].tgid =
> +						mbraink_tracing_pidlist_data[i].tgid;
> +				tracing_pid_buffer->drv_data[tracing_count].uid =
> +						mbraink_tracing_pidlist_data[i].uid;
> +				tracing_pid_buffer->drv_data[tracing_count].priority =
> +						mbraink_tracing_pidlist_data[i].priority;
> +				memcpy(tracing_pid_buffer->drv_data[tracing_count].name,
> +				       mbraink_tracing_pidlist_data[i].name, TASK_COMM_LEN);
> +				tracing_pid_buffer->drv_data[tracing_count].start =
> +						mbraink_tracing_pidlist_data[i].start;
> +				tracing_pid_buffer->drv_data[tracing_count].end =
> +						mbraink_tracing_pidlist_data[i].end;
> +				tracing_pid_buffer->drv_data[tracing_count].jiffies =
> +						mbraink_tracing_pidlist_data[i].jiffies;
> +				tracing_pid_buffer->tracing_count++;
> +				/*Deal with the end process record*/
> +				if (mbraink_tracing_pidlist_data[i].end != 0) {
> +					mbraink_tracing_pidlist_data[i].pid = 0;
> +					mbraink_tracing_pidlist_data[i].tgid = 0;
> +					mbraink_tracing_pidlist_data[i].uid = 0;
> +					mbraink_tracing_pidlist_data[i].priority = 0;
> +					memset(mbraink_tracing_pidlist_data[i].name,
> +					       0, TASK_COMM_LEN);
> +					mbraink_tracing_pidlist_data[i].start = 0;
> +					mbraink_tracing_pidlist_data[i].end = 0;
> +					mbraink_tracing_pidlist_data[i].jiffies = 0;
> +					mbraink_tracing_pidlist_data[i].dirty = false;
> +				} else {
> +					mbraink_tracing_pidlist_data[i].dirty = false;
> +				}
> +			} else {
> +				ret = -1;
> +				tracing_pid_buffer->tracing_idx = i;
> +				break;
> +			}
> +		}
> +	}
> +	pr_info("%s: current_idx = %u, count = %u\n",
> +		__func__, tracing_pid_buffer->tracing_idx, tracing_pid_buffer->tracing_count);
> +	spin_unlock_irqrestore(&tracing_pidlist_lock, flags);
> +}
> diff --git a/drivers/misc/mediatek_mbraink/mbraink_data.h b/drivers/misc/mediatek_mbraink/mbraink_data.h
> new file mode 100644
> index 000000000000..2d1a6b488caa
> --- /dev/null
> +++ b/drivers/misc/mediatek_mbraink/mbraink_data.h
> @@ -0,0 +1,66 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2023 MediaTek Inc.
> + */
> +#ifndef MBRAINK_DATA_H
> +#define MBRAINK_DATA_H
> +#include <linux/string_helpers.h>
> +#include <linux/sched.h>
> +#include <linux/sched/task.h>
> +#include <linux/mm_types.h>
> +#include <linux/pid.h>
> +
> +#include "mbraink_ioctl_struct_define.h"
> +
> +#define PSS_SHIFT			12
> +#define MAX_RT_PRIO			100
> +#define MAX_TRACE_NUM			3072
> +
> +struct mbraink_tracing_pidlist {
> +	unsigned short pid;
> +	unsigned short tgid;
> +	unsigned short uid;
> +	int priority;
> +	char name[TASK_COMM_LEN];
> +	long long start;
> +	long long end;
> +	u64 jiffies;
> +	bool dirty;
> +};
> +
> +struct mem_size_stats {
> +	unsigned long resident;
> +	unsigned long shared_clean;
> +	unsigned long shared_dirty;
> +	unsigned long private_clean;
> +	unsigned long private_dirty;
> +	unsigned long referenced;
> +	unsigned long anonymous;
> +	unsigned long lazyfree;
> +	unsigned long anonymous_thp;
> +	unsigned long shmem_thp;
> +	unsigned long file_thp;
> +	unsigned long swap;
> +	unsigned long shared_hugetlb;
> +	unsigned long private_hugetlb;
> +	u64 pss;
> +	u64 pss_anon;
> +	u64 pss_file;
> +	u64 pss_shmem;
> +	u64 pss_locked;
> +	u64 swap_pss;
> +	bool check_shmem_swap;
> +};
> +
> +void mbraink_get_process_memory_info(pid_t current_pid,
> +				     struct mbraink_process_memory_data *process_memory_buffer);
> +int mbraink_process_tracer_init(void);
> +void mbraink_process_tracer_exit(void);
> +void mbraink_get_tracing_pid_info(unsigned short current_idx,
> +				  struct mbraink_tracing_pid_data *tracing_pid_buffer);
> +void smap_gather_stats(struct vm_area_struct *vma,
> +		       struct mem_size_stats *mss, unsigned long start);
> +void task_cputime_adjusted(struct task_struct *p, u64 *ut, u64 *st);
> +void thread_group_cputime_adjusted(struct task_struct *p, u64 *ut, u64 *st);
> +u64 nsec_to_clock_t(u64 x);
> +#endif
> diff --git a/drivers/misc/mediatek_mbraink/mbraink_ioctl_struct_define.h b/drivers/misc/mediatek_mbraink/mbraink_ioctl_struct_define.h
> new file mode 100644
> index 000000000000..d655d8893f0f
> --- /dev/null
> +++ b/drivers/misc/mediatek_mbraink/mbraink_ioctl_struct_define.h
> @@ -0,0 +1,44 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2023 MediaTek Inc.
> + */
> +#ifndef MBRAINK_IOCTL_STRUCT_H
> +#define MBRAINK_IOCTL_STRUCT_H
> +
> +#define MAX_MEM_STRUCT_SZ			4
> +#define MAX_TRACE_PID_NUM			16
> +
> +struct mbraink_process_memory_struct {
> +	unsigned short pid;
> +	unsigned long pss;
> +	unsigned long uss;
> +	unsigned long rss;
> +	unsigned long swap;
> +	unsigned long java_heap;
> +	unsigned long native_heap;
> +};
> +
> +struct mbraink_process_memory_data {
> +	unsigned short pid;
> +	unsigned short pid_count;
> +	struct mbraink_process_memory_struct drv_data[MAX_MEM_STRUCT_SZ];
> +};
> +
> +struct mbraink_tracing_pid {
> +	unsigned short pid;
> +	unsigned short tgid;
> +	unsigned short uid;
> +	int priority;
> +	char name[TASK_COMM_LEN];
> +	long long start;
> +	long long end;
> +	u64 jiffies;
> +};
> +
> +struct mbraink_tracing_pid_data {
> +	unsigned short tracing_idx;
> +	unsigned short tracing_count;
> +	struct mbraink_tracing_pid drv_data[MAX_TRACE_PID_NUM];
> +};
> +
> +#endif
> diff --git a/drivers/misc/mediatek_mbraink/mbraink_main.c b/drivers/misc/mediatek_mbraink/mbraink_main.c
> new file mode 100644
> index 000000000000..4e6aac51694a
> --- /dev/null
> +++ b/drivers/misc/mediatek_mbraink/mbraink_main.c
> @@ -0,0 +1,239 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2023 MediaTek Inc.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/fs.h>
> +#include <linux/uaccess.h>
> +#include <linux/compat.h>
> +#include <linux/errno.h>
> +#include <linux/slab.h>
> +#include <linux/pm_runtime.h>
> +
> +#include "mbraink_main.h"
> +#include "mbraink_data.h"
> +
> +struct mbraink_data mbraink_priv;
> +
> +static int mbraink_open(struct inode *inode, struct file *filp)
> +{
> +	return 0;
> +}
> +
> +static int mbraink_release(struct inode *inode, struct file *filp)
> +{
> +	return 0;
> +}
> +
> +static long mbraink_ioctl(struct file *filp,
> +			  unsigned int cmd,
> +			  unsigned long arg)
> +{
> +	long ret = 0;
> +
> +	switch (cmd) {
> +	case RO_PROCESS_MEMORY:
> +	{
> +		struct mbraink_process_memory_data process_memory_buffer;
> +
> +		pid_t pid = 1;
> +
> +		if (copy_from_user(&process_memory_buffer,
> +				   (struct mbraink_process_memory_data *)arg,
> +				   sizeof(process_memory_buffer))) {
> +			pr_notice("copy process memory info from user Err!\n");
> +			return -EPERM;
> +		}
> +
> +		if (process_memory_buffer.pid > PID_MAX_DEFAULT ||
> +		    process_memory_buffer.pid_count > PID_MAX_DEFAULT) {
> +			pr_notice("process memory: Invalid pid_idx %u or pid_count %u\n",
> +				  process_memory_buffer.pid, process_memory_buffer.pid_count);
> +			return -EINVAL;
> +		}
> +		pid = process_memory_buffer.pid;
> +
> +		mbraink_get_process_memory_info(pid, &process_memory_buffer);
> +
> +		if (copy_to_user((struct mbraink_process_memory_data *)arg,
> +				 &process_memory_buffer,
> +				 sizeof(process_memory_buffer))) {
> +			pr_notice("Copy process_memory_info to UserSpace error!\n");
> +			return -EPERM;
> +		}
> +		break;
> +	}
> +	case RO_TRACE_PROCESS:
> +	{
> +		struct mbraink_tracing_pid_data tracing_pid_buffer;
> +
> +		unsigned short tracing_idx = 0;
> +
> +		if (copy_from_user(&tracing_pid_buffer,
> +				   (struct mbraink_tracing_pid_data *)arg,
> +				   sizeof(tracing_pid_buffer))) {
> +			pr_notice("copy tracing_pid_buffer data from user Err!\n");
> +			return -EPERM;
> +		}
> +
> +		if (tracing_pid_buffer.tracing_idx > MAX_TRACE_NUM) {
> +			pr_notice("invalid tracing_idx %u !\n",
> +				  tracing_pid_buffer.tracing_idx);
> +			return -EINVAL;
> +		}
> +		tracing_idx = tracing_pid_buffer.tracing_idx;
> +
> +		mbraink_get_tracing_pid_info(tracing_idx, &tracing_pid_buffer);
> +
> +		if (copy_to_user((struct mbraink_tracing_pid_data *)arg,
> +				 &tracing_pid_buffer,
> +				 sizeof(tracing_pid_buffer))) {
> +			pr_notice("Copy tracing_pid_buffer to UserSpace error!\n");
> +			return -EPERM;
> +		}
> +		break;
> +	}
> +	default:
> +		pr_notice("illegal ioctl number %u.\n", cmd);
> +		return -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +#if IS_ENABLED(CONFIG_COMPAT)
> +static long mbraink_compat_ioctl(struct file *filp,
> +				 unsigned int cmd, unsigned long arg)
> +{
> +	return mbraink_ioctl(filp, cmd, (unsigned long)compat_ptr(arg));
> +}
> +#endif
> +
> +static const struct file_operations mbraink_fops = {
> +	.owner		= THIS_MODULE,
> +	.open		= mbraink_open,
> +	.release        = mbraink_release,
> +	.unlocked_ioctl = mbraink_ioctl,
> +#if IS_ENABLED(CONFIG_COMPAT)
> +	.compat_ioctl   = mbraink_compat_ioctl,
> +#endif
> +};
> +
> +#if IS_ENABLED(CONFIG_PM_SLEEP)
> +static int mbraink_suspend(struct device *dev)
> +{
> +	int ret;
> +
> +	pr_info("[MBK_INFO] %s\n", __func__);
> +
> +	ret = pm_generic_suspend(dev);
> +
> +	return ret;
> +}
> +
> +static int mbraink_resume(struct device *dev)
> +{
> +	int ret;
> +
> +	pr_info("[MBK_INFO] %s\n", __func__);
> +
> +	ret = pm_generic_resume(dev);
> +
> +	return ret;
> +}
> +
> +static const struct dev_pm_ops mbraink_class_dev_pm_ops = {
> +	.suspend	= mbraink_suspend,
> +	.resume	= mbraink_resume,
> +};
> +
> +#define MBRAINK_CLASS_DEV_PM_OPS (&mbraink_class_dev_pm_ops)
> +#else
> +#define MBRAINK_CLASS_DEV_PM_OPS NULL
> +#endif /*end of CONFIG_PM_SLEEP*/
> +
> +static int mbraink_dev_init(void)
> +{
> +	mbraink_priv.mbraink_dev_no = 0;
> +
> +	/*Allocating Major number*/
> +	if ((alloc_chrdev_region(&mbraink_priv.mbraink_dev_no, 0, 1, CHRDEV_NAME)) < 0) {
> +		pr_notice("Cannot allocate major number %u\n",
> +			  mbraink_priv.mbraink_dev_no);
> +		return -EBADF;
> +	}
> +
> +	/*Initialize cdev structure*/
> +	cdev_init(&mbraink_priv.mbraink_cdev, &mbraink_fops);
> +
> +	/*Adding character device to the system*/
> +	if ((cdev_add(&mbraink_priv.mbraink_cdev, mbraink_priv.mbraink_dev_no, 1)) < 0) {
> +		pr_notice("Cannot add the device to the system\n");
> +		goto r_class;
> +	}
> +
> +	mbraink_priv.mbraink_class = class_create(THIS_MODULE, "mbraink_host");
> +	/*Register mbraink class*/
> +	if (IS_ERR(mbraink_priv.mbraink_class)) {
> +		pr_notice("Cannot create the mbraink class\n");
> +		goto r_class;
> +	}
> +	mbraink_priv.mbraink_class->pm = MBRAINK_CLASS_DEV_PM_OPS;
> +
> +	/*Register mbraink device*/
> +	if (IS_ERR(device_create(mbraink_priv.mbraink_class,
> +				 NULL, mbraink_priv.mbraink_dev_no, NULL, "mbraink"))) {
> +		pr_notice("Cannot create the mbraink Device\n");
> +		goto r_device;
> +	}
> +	pr_info("[MBK_INFO] %s: Mbraink device init done.\n", __func__);
> +
> +	return 0;
> +
> +r_device:
> +	class_destroy(mbraink_priv.mbraink_class);
> +r_class:
> +	unregister_chrdev_region(mbraink_priv.mbraink_dev_no, 1);
> +
> +	return -EPERM;
> +}
> +
> +static int mbraink_init(void)
> +{
> +	int ret = 0;
> +
> +	ret = mbraink_dev_init();
> +	if (ret)
> +		pr_notice("mbraink device init failed.\n");
> +
> +	ret = mbraink_process_tracer_init();
> +	if (ret)
> +		pr_notice("mbraink tracer init failed.\n");
> +
> +	return ret;
> +}
> +
> +static void mbraink_dev_exit(void)
> +{
> +	device_destroy(mbraink_priv.mbraink_class, mbraink_priv.mbraink_dev_no);
> +	class_destroy(mbraink_priv.mbraink_class);
> +	cdev_del(&mbraink_priv.mbraink_cdev);
> +	unregister_chrdev_region(mbraink_priv.mbraink_dev_no, 1);
> +
> +	pr_info("[MBK_INFO] %s: MBraink device exit done\n", __func__);
> +}
> +
> +static void mbraink_exit(void)
> +{
> +	mbraink_dev_exit();
> +	mbraink_process_tracer_exit();
> +}
> +
> +module_init(mbraink_init);
> +module_exit(mbraink_exit);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("<Wei-chin.Tsai@mediatek.com>");
> +MODULE_DESCRIPTION("MBraink Linux Device Driver");
> +MODULE_VERSION("1.0");
> diff --git a/drivers/misc/mediatek_mbraink/mbraink_main.h b/drivers/misc/mediatek_mbraink/mbraink_main.h
> new file mode 100644
> index 000000000000..36549f0d90d1
> --- /dev/null
> +++ b/drivers/misc/mediatek_mbraink/mbraink_main.h
> @@ -0,0 +1,36 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2023 MediaTek Inc.
> + */
> +
> +#ifndef MBRAINK_MAIN_H
> +#define MBRAINK_MAIN_H
> +
> +#include <linux/ioctl.h>
> +#include <linux/cdev.h>
> +#include <linux/pid.h>
> +#include <linux/device.h>
> +#include <linux/kdev_t.h>
> +
> +#include "mbraink_ioctl_struct_define.h"
> +
> +#define IOC_MAGIC		'k'
> +
> +/*Mbrain Delegate Info List*/
> +#define PROCESS_MEMORY_INFO	'4'
> +#define TRACE_PROCESS_INFO      'a'
> +
> +/*Mbrain Delegate IOCTL List*/
> +#define RO_PROCESS_MEMORY	_IOR(IOC_MAGIC, PROCESS_MEMORY_INFO, \
> +				     struct mbraink_process_memory_data*)
> +#define RO_TRACE_PROCESS        _IOR(IOC_MAGIC, TRACE_PROCESS_INFO, \
> +				     struct mbraink_tracing_pid_data*)
> +
> +struct mbraink_data {
> +#define CHRDEV_NAME     "mbraink_chrdev"
> +	dev_t mbraink_dev_no;
> +	struct cdev mbraink_cdev;
> +	struct class *mbraink_class;
> +};
> +
> +#endif /*end of MBRAINK_MAIN_H*/

