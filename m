Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62015674077
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 19:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbjASSCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 13:02:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjASSCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 13:02:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC6A9084C
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 10:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674151326;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vaqYKA9gKcloEabUgO9UTR0QJlMjgtJTu1Mbgj1HV78=;
        b=SMhErcbea0DxHe/NuyZkcUTLkF7Akj8htj3g8ZMCWudPQKGHhDYiTZN+qwNrslkJ52P6Jx
        GXsoOgmYxPjFrHFM19OXk59coihd4LpuULYelqCq+NuzEoudoaUCG0NF7+MFRM8SgpSWxM
        tKPMf+/Hv0vK3zMPrG8XdeJzSAsdANQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-452-T3l97QkgOwK8iK2ynsYMNg-1; Thu, 19 Jan 2023 13:02:03 -0500
X-MC-Unique: T3l97QkgOwK8iK2ynsYMNg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DF7CA3803911;
        Thu, 19 Jan 2023 18:02:02 +0000 (UTC)
Received: from localhost (unknown [10.39.195.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 78BDA492B02;
        Thu, 19 Jan 2023 18:02:02 +0000 (UTC)
From:   Giuseppe Scrivano <gscrivan@redhat.com>
To:     Brian Masney <bmasney@redhat.com>
Cc:     linux-kernel@vger.kernel.org, keescook@chromium.org,
        bristot@redhat.com, ebiederm@xmission.com, brauner@kernel.org,
        cyphar@cyphar.com, viro@zeniv.linux.org.uk, alexl@redhat.com,
        peterz@infradead.org
Subject: Re: [PATCH v2 1/2] exec: add PR_HIDE_SELF_EXE prctl
References: <20230119170718.3129938-1-gscrivan@redhat.com>
        <Y8mCqn3fIaqk9N0Q@x1>
Date:   Thu, 19 Jan 2023 19:02:00 +0100
In-Reply-To: <Y8mCqn3fIaqk9N0Q@x1> (Brian Masney's message of "Thu, 19 Jan
        2023 12:49:30 -0500")
Message-ID: <87tu0mflnr.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Masney <bmasney@redhat.com> writes:

> On Thu, Jan 19, 2023 at 06:07:17PM +0100, Giuseppe Scrivano wrote:
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
>> 
>> Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>
>> ---
>>  fs/exec.c                        | 1 +
>>  fs/proc/base.c                   | 8 +++++---
>>  include/linux/sched.h            | 5 +++++
>>  include/uapi/linux/prctl.h       | 3 +++
>>  kernel/sys.c                     | 9 +++++++++
>>  tools/include/uapi/linux/prctl.h | 3 +++
>>  6 files changed, 26 insertions(+), 3 deletions(-)
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
>> diff --git a/fs/exec.c b/fs/exec.c
>> index ab913243a367..5a5dd964c3a3 100644
>> --- a/fs/exec.c
>> +++ b/fs/exec.c
>> @@ -1855,6 +1855,7 @@ static int bprm_execve(struct linux_binprm *bprm,
>>  	/* execve succeeded */
>>  	current->fs->in_exec = 0;
>>  	current->in_execve = 0;
>> +	task_clear_hide_self_exe(current);
>
> [snip]
>
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
>
> Perhaps I am missing something, but where is task_clear_hide_self_exe()
> and task_hide_self_exe() defined?

they are defined with:

TASK_PFA_TEST(HIDE_SELF_EXE, hide_self_exe)
TASK_PFA_SET(HIDE_SELF_EXE, hide_self_exe)
TASK_PFA_CLEAR(HIDE_SELF_EXE, hide_self_exe)

Regards,
Giuseppe

