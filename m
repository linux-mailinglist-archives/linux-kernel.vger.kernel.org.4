Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9C3267B6F4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 17:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235020AbjAYQbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 11:31:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbjAYQbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 11:31:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2731043F
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 08:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674664245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JBeDLOHoOES+39Ztu3Hollt0jQ+hn2zacalI5JTrttM=;
        b=dHi5mEzuVTG1Eo+DiQgDA4sQ0pMF5VAqCi9/dvRlqET8cl9USpaSr2wWjEQ7py7FAIQJC5
        I1JtqjEmgSQCIYdOSsvA1S7mVHSv00oXrmaUzMmNosiVxm841sonG6AQFsWG68vz1B7aZQ
        x+XQRTL4K5iYNjFP8hGELg72qXrqMn8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-663-ICb2TN-RPS6mJxRLcrPizA-1; Wed, 25 Jan 2023 11:30:41 -0500
X-MC-Unique: ICb2TN-RPS6mJxRLcrPizA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 33282101A521;
        Wed, 25 Jan 2023 16:30:41 +0000 (UTC)
Received: from localhost (unknown [10.39.195.120])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1987614171BB;
        Wed, 25 Jan 2023 16:30:39 +0000 (UTC)
From:   Giuseppe Scrivano <gscrivan@redhat.com>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     linux-kernel@vger.kernel.org, keescook@chromium.org,
        bristot@redhat.com, ebiederm@xmission.com, brauner@kernel.org,
        viro@zeniv.linux.org.uk, alexl@redhat.com, peterz@infradead.org,
        bmasney@redhat.com
Subject: Re: [PATCH v3 1/2] exec: add PR_HIDE_SELF_EXE prctl
References: <20230120102512.3195094-1-gscrivan@redhat.com>
        <20230124015348.6rvic5g6ymsfvj4e@senku> <87h6wgcrv6.fsf@redhat.com>
        <20230125152847.wr443tggzb3no6mg@senku>
Date:   Wed, 25 Jan 2023 17:30:37 +0100
In-Reply-To: <20230125152847.wr443tggzb3no6mg@senku> (Aleksa Sarai's message
        of "Thu, 26 Jan 2023 02:28:47 +1100")
Message-ID: <871qnibmqa.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
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

> On 2023-01-24, Giuseppe Scrivano <gscrivan@redhat.com> wrote:
>> Aleksa Sarai <cyphar@cyphar.com> writes:
>> 
>> > On 2023-01-20, Giuseppe Scrivano <gscrivan@redhat.com> wrote:
>> >> This patch adds a new prctl called PR_HIDE_SELF_EXE which allows
>> >> processes to hide their own /proc/*/exe file. When this prctl is
>> >> used, every access to /proc/*/exe for the calling process will
>> >> fail with ENOENT.
>> >> 
>> >> This is useful for preventing issues like CVE-2019-5736, where an
>> >> attacker can gain host root access by overwriting the binary
>> >> in OCI runtimes through file-descriptor mishandling in containers.
>> >> 
>> >> The current fix for CVE-2019-5736 is to create a read-only copy or
>> >> a bind-mount of the current executable, and then re-exec the current
>> >> process.  With the new prctl, the read-only copy or bind-mount copy is
>> >> not needed anymore.
>> >> 
>> >> While map_files/ also might contain symlinks to files in host,
>> >> proc_map_files_get_link() permissions checks are already sufficient.
>> >
>> > I suspect this doesn't protect against the execve("/proc/self/exe")
>> > tactic (because it clears the bit on execve), so I'm not sure this is
>> > much safer than PR_SET_DUMPABLE (yeah, it stops root in the source
>> > userns from accessing /proc/$pid/exe but the above attack makes that no
>> > longer that important).
>> 
>> it protects against that attack too.  It clears the bit _after_ the
>> execve() syscall is done.
>> 
>> If you attempt execve("/proc/self/exe") you still get ENOENT:
>> 
>> ```
>> #include <stdlib.h>
>> #include <stdio.h>
>> #include <sys/prctl.h>
>> #include <unistd.h>
>> 
>> int main(void)
>> {
>>         int ret;
>> 
>>         ret = prctl(65, 1, 0, 0, 0);
>>         if (ret != 0)
>>                 exit(1);
>> 
>>         execl("/proc/self/exe", "foo", NULL);
>>         exit(2);
>> }
>> ```
>> 
>> # strace -e prctl,execve ./hide-self-exe
>> execve("./hide-self-exe", ["./hide-self-exe"], 0x7fff975a3690 /* 39 vars */) = 0
>> prctl(0x41 /* PR_??? */, 0x1, 0, 0, 0)  = 0
>> execve("/proc/self/exe", ["foo"], 0x7ffcf51868b8 /* 39 vars */) = -1 ENOENT (No such file or directory)
>> +++ exited with 2 +++
>> 
>> I've also tried execv'ing with a script that uses "#!/proc/self/exe" and
>> I get the same ENOENT.
>
> Ah, you're right. As you mentioned, you could still do the attack
> through /proc/self/map_files but that would require you to know where
> the binary will be located (and being non-dumpable blocks container
> processes from doing tricks to get the right path).
>
> I wonder if we should somehow require (or auto-apply) SUID_DUMP_NONE
> when setting this prctl, since it does currently depend on it to be
> properly secure...

from what I can see, access to /proc/*/map_files is already protected
by proc_map_files_get_link() that requires either CAP_SYS_ADMIN in the
initial user namespace or CAP_CHECKPOINT_RESTORE in the user namespace.

Setting SUID_DUMP_NONE wouldn't hurt though :-)

After reading some comments on the LWN.net article, I wonder if
PR_HIDE_SELF_EXE should apply to CAP_SYS_ADMIN in the initial user
namespace or if in this case root should keep the privilege to inspect
the binary of a process.  If a container runs with that many privileges
then it has already other ways to damage the host anyway.

>> > I think the only way to fix this properly is by blocking re-opens of
>> > magic links that have more permissions than they originally did. I just
>> > got back from vacation, but I'm working on fixing up [1] so it's ready
>> > to be an RFC so we can close this hole once and for all.
>> 
>> so that relies on the fact opening /proc/self/exe with O_WRONLY fails
>> with ETXTBSY?
>
> Not quite, it relies on the fact that /proc/self/exe (and any other
> magiclink to /proc/self/exe) does not have a write mode (semantically,
> because of -ETXTBSY) and thus blocks any attempt to open it (or re-open
> it) with a write mode. It also fixes some other possible issues and lets
> you have upgrade masks (a-la capabilities) to file descriptors.
>
> Ultimately I think having a complete "no really, nobody can touch this"
> knob is also a good idea, and as this is is much simpler we can it in
> much quicker than the magiclink stuff (which I still think is necessary
> in general).
>
>> > [1]: https://github.com/cyphar/linux/tree/magiclink/open_how-reopen
>> >
>> >> 
>> >> Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>
>> >> ---
>> >> v2: https://lkml.org/lkml/2023/1/19/849
>> >> 
>> >> Differences from v2:
>> >> 
>> >> - fixed the test to check PR_SET_HIDE_SELF_EXE after fork
>> >> 
>> >> v1: https://lkml.org/lkml/2023/1/4/334
>> >> 
>> >> Differences from v1:
>> >> 
>> >> - amended more information in the commit message wrt map_files not
>> >>   requiring the same protection.
>> >> - changed the test to verify PR_HIDE_SELF_EXE cannot be unset after
>> >>   a fork.
>> >> 
>> >> fs/exec.c                        | 1 +
>> >>  fs/proc/base.c                   | 8 +++++---
>> >>  include/linux/sched.h            | 5 +++++
>> >>  include/uapi/linux/prctl.h       | 3 +++
>> >>  kernel/sys.c                     | 9 +++++++++
>> >>  tools/include/uapi/linux/prctl.h | 3 +++
>> >>  6 files changed, 26 insertions(+), 3 deletions(-)
>> >> 
>> >> diff --git a/fs/exec.c b/fs/exec.c
>> >> index ab913243a367..5a5dd964c3a3 100644
>> >> --- a/fs/exec.c
>> >> +++ b/fs/exec.c
>> >> @@ -1855,6 +1855,7 @@ static int bprm_execve(struct linux_binprm *bprm,
>> >>  	/* execve succeeded */
>> >>  	current->fs->in_exec = 0;
>> >>  	current->in_execve = 0;
>> >> +	task_clear_hide_self_exe(current);
>> >>  	rseq_execve(current);
>> >>  	acct_update_integrals(current);
>> >>  	task_numa_free(current, false);
>> >> diff --git a/fs/proc/base.c b/fs/proc/base.c
>> >> index 9e479d7d202b..959968e2da0d 100644
>> >> --- a/fs/proc/base.c
>> >> +++ b/fs/proc/base.c
>> >> @@ -1723,19 +1723,21 @@ static int proc_exe_link(struct dentry *dentry, struct path *exe_path)
>> >>  {
>> >>  	struct task_struct *task;
>> >>  	struct file *exe_file;
>> >> +	long hide_self_exe;
>> >>  
>> >>  	task = get_proc_task(d_inode(dentry));
>> >>  	if (!task)
>> >>  		return -ENOENT;
>> >>  	exe_file = get_task_exe_file(task);
>> >> +	hide_self_exe = task_hide_self_exe(task);
>> >>  	put_task_struct(task);
>> >> -	if (exe_file) {
>> >> +	if (exe_file && !hide_self_exe) {
>> >>  		*exe_path = exe_file->f_path;
>> >>  		path_get(&exe_file->f_path);
>> >>  		fput(exe_file);
>> >>  		return 0;
>> >> -	} else
>> >> -		return -ENOENT;
>> >> +	}
>> >> +	return -ENOENT;
>> >>  }
>> >>  
>> >>  static const char *proc_pid_get_link(struct dentry *dentry,
>> >> diff --git a/include/linux/sched.h b/include/linux/sched.h
>> >> index 853d08f7562b..8db32d5fc285 100644
>> >> --- a/include/linux/sched.h
>> >> +++ b/include/linux/sched.h
>> >> @@ -1790,6 +1790,7 @@ static __always_inline bool is_percpu_thread(void)
>> >>  #define PFA_SPEC_IB_DISABLE		5	/* Indirect branch speculation restricted */
>> >>  #define PFA_SPEC_IB_FORCE_DISABLE	6	/* Indirect branch speculation permanently restricted */
>> >>  #define PFA_SPEC_SSB_NOEXEC		7	/* Speculative Store Bypass clear on execve() */
>> >> +#define PFA_HIDE_SELF_EXE		8	/* Hide /proc/self/exe for the process */
>> >>  
>> >>  #define TASK_PFA_TEST(name, func)					\
>> >>  	static inline bool task_##func(struct task_struct *p)		\
>> >> @@ -1832,6 +1833,10 @@ TASK_PFA_CLEAR(SPEC_IB_DISABLE, spec_ib_disable)
>> >>  TASK_PFA_TEST(SPEC_IB_FORCE_DISABLE, spec_ib_force_disable)
>> >>  TASK_PFA_SET(SPEC_IB_FORCE_DISABLE, spec_ib_force_disable)
>> >>  
>> >> +TASK_PFA_TEST(HIDE_SELF_EXE, hide_self_exe)
>> >> +TASK_PFA_SET(HIDE_SELF_EXE, hide_self_exe)
>> >> +TASK_PFA_CLEAR(HIDE_SELF_EXE, hide_self_exe)
>> >> +
>> >>  static inline void
>> >>  current_restore_flags(unsigned long orig_flags, unsigned long flags)
>> >>  {
>> >> diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
>> >> index a5e06dcbba13..f12f3df12468 100644
>> >> --- a/include/uapi/linux/prctl.h
>> >> +++ b/include/uapi/linux/prctl.h
>> >> @@ -284,4 +284,7 @@ struct prctl_mm_map {
>> >>  #define PR_SET_VMA		0x53564d41
>> >>  # define PR_SET_VMA_ANON_NAME		0
>> >>  
>> >> +#define PR_SET_HIDE_SELF_EXE		65
>> >> +#define PR_GET_HIDE_SELF_EXE		66
>> >> +
>> >>  #endif /* _LINUX_PRCTL_H */
>> >> diff --git a/kernel/sys.c b/kernel/sys.c
>> >> index 5fd54bf0e886..e992f1b72973 100644
>> >> --- a/kernel/sys.c
>> >> +++ b/kernel/sys.c
>> >> @@ -2626,6 +2626,15 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
>> >>  	case PR_SET_VMA:
>> >>  		error = prctl_set_vma(arg2, arg3, arg4, arg5);
>> >>  		break;
>> >> +	case PR_SET_HIDE_SELF_EXE:
>> >> +		if (arg2 != 1 || arg3 || arg4 || arg5)
>> >> +			return -EINVAL;
>> >> +		task_set_hide_self_exe(current);
>> >> +		break;
>> >> +	case PR_GET_HIDE_SELF_EXE:
>> >> +		if (arg2 || arg3 || arg4 || arg5)
>> >> +			return -EINVAL;
>> >> +		return task_hide_self_exe(current) ? 1 : 0;
>> >>  	default:
>> >>  		error = -EINVAL;
>> >>  		break;
>> >> diff --git a/tools/include/uapi/linux/prctl.h b/tools/include/uapi/linux/prctl.h
>> >> index a5e06dcbba13..f12f3df12468 100644
>> >> --- a/tools/include/uapi/linux/prctl.h
>> >> +++ b/tools/include/uapi/linux/prctl.h
>> >> @@ -284,4 +284,7 @@ struct prctl_mm_map {
>> >>  #define PR_SET_VMA		0x53564d41
>> >>  # define PR_SET_VMA_ANON_NAME		0
>> >>  
>> >> +#define PR_SET_HIDE_SELF_EXE		65
>> >> +#define PR_GET_HIDE_SELF_EXE		66
>> >> +
>> >>  #endif /* _LINUX_PRCTL_H */
>> >> -- 
>> >> 2.38.1
>> >> 
>> 

