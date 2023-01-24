Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC1196791FB
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 08:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232864AbjAXHai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 02:30:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjAXHah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 02:30:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DFDE1CF74
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 23:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674545393;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Qx1RbAHT5qrB3ss9onflU476htAeuefB/V7/7eAr+Dw=;
        b=aJ2oqcH59hum1opDYuQEu3qMzS8omjpL14r/pQhXJvOGeMskefIbAirr9G56K+qYho56tn
        ruph0jAxIRR/06DV2iLNE6V3EFq1kxbf4K19l1sqXovPV9LJ/8N6vNijyrETYVXs/T0/yO
        0xn+2xB94pUGGUo5IWR7ZO54UH9xX/E=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-453-Dcjf4pi4NpCkoL9xQYXb6Q-1; Tue, 24 Jan 2023 02:29:52 -0500
X-MC-Unique: Dcjf4pi4NpCkoL9xQYXb6Q-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D0D9E380406A;
        Tue, 24 Jan 2023 07:29:51 +0000 (UTC)
Received: from localhost (unknown [10.39.193.37])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 41074492C3C;
        Tue, 24 Jan 2023 07:29:51 +0000 (UTC)
From:   Giuseppe Scrivano <gscrivan@redhat.com>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     linux-kernel@vger.kernel.org, keescook@chromium.org,
        bristot@redhat.com, ebiederm@xmission.com, brauner@kernel.org,
        viro@zeniv.linux.org.uk, alexl@redhat.com, peterz@infradead.org,
        bmasney@redhat.com
Subject: Re: [PATCH v3 1/2] exec: add PR_HIDE_SELF_EXE prctl
In-Reply-To: <20230124015348.6rvic5g6ymsfvj4e@senku> (Aleksa Sarai's message
        of "Tue, 24 Jan 2023 12:53:48 +1100")
References: <20230120102512.3195094-1-gscrivan@redhat.com>
        <20230124015348.6rvic5g6ymsfvj4e@senku>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
Date:   Tue, 24 Jan 2023 08:29:49 +0100
Message-ID: <87h6wgcrv6.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Aleksa Sarai <cyphar@cyphar.com> writes:

> On 2023-01-20, Giuseppe Scrivano <gscrivan@redhat.com> wrote:
>> This patch adds a new prctl called PR_HIDE_SELF_EXE which allows
>> processes to hide their own /proc/*/exe file. When this prctl is
>> used, every access to /proc/*/exe for the calling process will
>> fail with ENOENT.
>> 
>> This is useful for preventing issues like CVE-2019-5736, where an
>> attacker can gain host root access by overwriting the binary
>> in OCI runtimes through file-descriptor mishandling in containers.
>> 
>> The current fix for CVE-2019-5736 is to create a read-only copy or
>> a bind-mount of the current executable, and then re-exec the current
>> process.  With the new prctl, the read-only copy or bind-mount copy is
>> not needed anymore.
>> 
>> While map_files/ also might contain symlinks to files in host,
>> proc_map_files_get_link() permissions checks are already sufficient.
>
> I suspect this doesn't protect against the execve("/proc/self/exe")
> tactic (because it clears the bit on execve), so I'm not sure this is
> much safer than PR_SET_DUMPABLE (yeah, it stops root in the source
> userns from accessing /proc/$pid/exe but the above attack makes that no
> longer that important).

it protects against that attack too.  It clears the bit _after_ the
execve() syscall is done.

If you attempt execve("/proc/self/exe") you still get ENOENT:

```
#include <stdlib.h>
#include <stdio.h>
#include <sys/prctl.h>
#include <unistd.h>

int main(void)
{
        int ret;

        ret = prctl(65, 1, 0, 0, 0);
        if (ret != 0)
                exit(1);

        execl("/proc/self/exe", "foo", NULL);
        exit(2);
}
```

# strace -e prctl,execve ./hide-self-exe
execve("./hide-self-exe", ["./hide-self-exe"], 0x7fff975a3690 /* 39 vars */) = 0
prctl(0x41 /* PR_??? */, 0x1, 0, 0, 0)  = 0
execve("/proc/self/exe", ["foo"], 0x7ffcf51868b8 /* 39 vars */) = -1 ENOENT (No such file or directory)
+++ exited with 2 +++

I've also tried execv'ing with a script that uses "#!/proc/self/exe" and
I get the same ENOENT.


>
> I think the only way to fix this properly is by blocking re-opens of
> magic links that have more permissions than they originally did. I just
> got back from vacation, but I'm working on fixing up [1] so it's ready
> to be an RFC so we can close this hole once and for all.

so that relies on the fact opening /proc/self/exe with O_WRONLY fails
with ETXTBSY?

> [1]: https://github.com/cyphar/linux/tree/magiclink/open_how-reopen
>
>> 
>> Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>
>> ---
>> v2: https://lkml.org/lkml/2023/1/19/849
>> 
>> Differences from v2:
>> 
>> - fixed the test to check PR_SET_HIDE_SELF_EXE after fork
>> 
>> v1: https://lkml.org/lkml/2023/1/4/334
>> 
>> Differences from v1:
>> 
>> - amended more information in the commit message wrt map_files not
>>   requiring the same protection.
>> - changed the test to verify PR_HIDE_SELF_EXE cannot be unset after
>>   a fork.
>> 
>> fs/exec.c                        | 1 +
>>  fs/proc/base.c                   | 8 +++++---
>>  include/linux/sched.h            | 5 +++++
>>  include/uapi/linux/prctl.h       | 3 +++
>>  kernel/sys.c                     | 9 +++++++++
>>  tools/include/uapi/linux/prctl.h | 3 +++
>>  6 files changed, 26 insertions(+), 3 deletions(-)
>> 
>> diff --git a/fs/exec.c b/fs/exec.c
>> index ab913243a367..5a5dd964c3a3 100644
>> --- a/fs/exec.c
>> +++ b/fs/exec.c
>> @@ -1855,6 +1855,7 @@ static int bprm_execve(struct linux_binprm *bprm,
>>  	/* execve succeeded */
>>  	current->fs->in_exec = 0;
>>  	current->in_execve = 0;
>> +	task_clear_hide_self_exe(current);
>>  	rseq_execve(current);
>>  	acct_update_integrals(current);
>>  	task_numa_free(current, false);
>> diff --git a/fs/proc/base.c b/fs/proc/base.c
>> index 9e479d7d202b..959968e2da0d 100644
>> --- a/fs/proc/base.c
>> +++ b/fs/proc/base.c
>> @@ -1723,19 +1723,21 @@ static int proc_exe_link(struct dentry *dentry, struct path *exe_path)
>>  {
>>  	struct task_struct *task;
>>  	struct file *exe_file;
>> +	long hide_self_exe;
>>  
>>  	task = get_proc_task(d_inode(dentry));
>>  	if (!task)
>>  		return -ENOENT;
>>  	exe_file = get_task_exe_file(task);
>> +	hide_self_exe = task_hide_self_exe(task);
>>  	put_task_struct(task);
>> -	if (exe_file) {
>> +	if (exe_file && !hide_self_exe) {
>>  		*exe_path = exe_file->f_path;
>>  		path_get(&exe_file->f_path);
>>  		fput(exe_file);
>>  		return 0;
>> -	} else
>> -		return -ENOENT;
>> +	}
>> +	return -ENOENT;
>>  }
>>  
>>  static const char *proc_pid_get_link(struct dentry *dentry,
>> diff --git a/include/linux/sched.h b/include/linux/sched.h
>> index 853d08f7562b..8db32d5fc285 100644
>> --- a/include/linux/sched.h
>> +++ b/include/linux/sched.h
>> @@ -1790,6 +1790,7 @@ static __always_inline bool is_percpu_thread(void)
>>  #define PFA_SPEC_IB_DISABLE		5	/* Indirect branch speculation restricted */
>>  #define PFA_SPEC_IB_FORCE_DISABLE	6	/* Indirect branch speculation permanently restricted */
>>  #define PFA_SPEC_SSB_NOEXEC		7	/* Speculative Store Bypass clear on execve() */
>> +#define PFA_HIDE_SELF_EXE		8	/* Hide /proc/self/exe for the process */
>>  
>>  #define TASK_PFA_TEST(name, func)					\
>>  	static inline bool task_##func(struct task_struct *p)		\
>> @@ -1832,6 +1833,10 @@ TASK_PFA_CLEAR(SPEC_IB_DISABLE, spec_ib_disable)
>>  TASK_PFA_TEST(SPEC_IB_FORCE_DISABLE, spec_ib_force_disable)
>>  TASK_PFA_SET(SPEC_IB_FORCE_DISABLE, spec_ib_force_disable)
>>  
>> +TASK_PFA_TEST(HIDE_SELF_EXE, hide_self_exe)
>> +TASK_PFA_SET(HIDE_SELF_EXE, hide_self_exe)
>> +TASK_PFA_CLEAR(HIDE_SELF_EXE, hide_self_exe)
>> +
>>  static inline void
>>  current_restore_flags(unsigned long orig_flags, unsigned long flags)
>>  {
>> diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
>> index a5e06dcbba13..f12f3df12468 100644
>> --- a/include/uapi/linux/prctl.h
>> +++ b/include/uapi/linux/prctl.h
>> @@ -284,4 +284,7 @@ struct prctl_mm_map {
>>  #define PR_SET_VMA		0x53564d41
>>  # define PR_SET_VMA_ANON_NAME		0
>>  
>> +#define PR_SET_HIDE_SELF_EXE		65
>> +#define PR_GET_HIDE_SELF_EXE		66
>> +
>>  #endif /* _LINUX_PRCTL_H */
>> diff --git a/kernel/sys.c b/kernel/sys.c
>> index 5fd54bf0e886..e992f1b72973 100644
>> --- a/kernel/sys.c
>> +++ b/kernel/sys.c
>> @@ -2626,6 +2626,15 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
>>  	case PR_SET_VMA:
>>  		error = prctl_set_vma(arg2, arg3, arg4, arg5);
>>  		break;
>> +	case PR_SET_HIDE_SELF_EXE:
>> +		if (arg2 != 1 || arg3 || arg4 || arg5)
>> +			return -EINVAL;
>> +		task_set_hide_self_exe(current);
>> +		break;
>> +	case PR_GET_HIDE_SELF_EXE:
>> +		if (arg2 || arg3 || arg4 || arg5)
>> +			return -EINVAL;
>> +		return task_hide_self_exe(current) ? 1 : 0;
>>  	default:
>>  		error = -EINVAL;
>>  		break;
>> diff --git a/tools/include/uapi/linux/prctl.h b/tools/include/uapi/linux/prctl.h
>> index a5e06dcbba13..f12f3df12468 100644
>> --- a/tools/include/uapi/linux/prctl.h
>> +++ b/tools/include/uapi/linux/prctl.h
>> @@ -284,4 +284,7 @@ struct prctl_mm_map {
>>  #define PR_SET_VMA		0x53564d41
>>  # define PR_SET_VMA_ANON_NAME		0
>>  
>> +#define PR_SET_HIDE_SELF_EXE		65
>> +#define PR_GET_HIDE_SELF_EXE		66
>> +
>>  #endif /* _LINUX_PRCTL_H */
>> -- 
>> 2.38.1
>> 

