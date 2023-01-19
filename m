Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A441D674053
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 18:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjASRug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 12:50:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjASRud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 12:50:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D7890B18
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 09:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674150575;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sPdHaDs3EIVBjhCyl53kRKQHFVJrB/x/AF0O9xv56DI=;
        b=jUR3oXvjkWizdg/xaPlVCyM8WEXFmJXeiEv67tT+vuTfP3XyyHQjwgOgOPdLGoGpSkVhvc
        DDyRqOPcaBiv0mu/fUmUA7hAd7AMcOqdpv5nRbDftOYQyMuRPteduuNj4cxrNLqmPCLNfg
        MbxboLP1zRd8NuLE+3YYvcLn8TBOyNo=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-463-Xjjp3C4BOzuMHT4SmneeTQ-1; Thu, 19 Jan 2023 12:49:33 -0500
X-MC-Unique: Xjjp3C4BOzuMHT4SmneeTQ-1
Received: by mail-io1-f69.google.com with SMTP id b21-20020a5d8d95000000b006fa39fbb94eso1498735ioj.17
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 09:49:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sPdHaDs3EIVBjhCyl53kRKQHFVJrB/x/AF0O9xv56DI=;
        b=0jBa4Ley0yx7A4MWLlg1bp2KAaDCegvfF/LWs/iU+IKcEV93htSyLjAwR1qG7yuxKA
         RfdaCFk998ZFgnHEAvPnvXpmS+tGBX7IXI0j84CSNJ7jeyqrMj7EZN9I3A7/v4nQVC/s
         jPrAYQzuBC26tm7sV43QAnD5rvd3OntPlEOIoD6IvBYEZnluPHD8c0stKy73rFf2OXnj
         O/vyu7W+cAJ0lNRecg7vLqj5q9BZ3ALWH0bqR0llUYhKfPsviJVCoRpQs2jiYmtwTsts
         J83AjOFQmQe9nBAbBmcGjWQA/GhAZ6i1PHDGdjztVhGlNQXEb3PGAPj1Xag6acq6RSQb
         Gakg==
X-Gm-Message-State: AFqh2krz7b+kkPOCvuiwK9Ejue4rX+19rRFKjney61xMVzPsrWymxh/j
        quBI5Q+bzHx4K64CTxNsgXTI9BbBOMgimjRFud5x+G+x/yhMeQ4K3vvEHGB4NHYLvbbK8vB6BM3
        iLFflGmhy3KmA4rmpeoc9YKYr
X-Received: by 2002:a92:d3c1:0:b0:30d:934c:f71b with SMTP id c1-20020a92d3c1000000b0030d934cf71bmr9670119ilh.1.1674150573167;
        Thu, 19 Jan 2023 09:49:33 -0800 (PST)
X-Google-Smtp-Source: AMrXdXs/wiTiOQVcQl8+I7bhyykQ1i2sxY3NvRLZ3n13Fukqkc/9HaQGELCmrtiXeVjjmLjb96nPNA==
X-Received: by 2002:a92:d3c1:0:b0:30d:934c:f71b with SMTP id c1-20020a92d3c1000000b0030d934cf71bmr9670105ilh.1.1674150572913;
        Thu, 19 Jan 2023 09:49:32 -0800 (PST)
Received: from x1 (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id r13-20020a02b10d000000b003a58ae912a7sm3523228jah.22.2023.01.19.09.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 09:49:32 -0800 (PST)
Date:   Thu, 19 Jan 2023 12:49:30 -0500
From:   Brian Masney <bmasney@redhat.com>
To:     Giuseppe Scrivano <gscrivan@redhat.com>
Cc:     linux-kernel@vger.kernel.org, keescook@chromium.org,
        bristot@redhat.com, ebiederm@xmission.com, brauner@kernel.org,
        cyphar@cyphar.com, viro@zeniv.linux.org.uk, alexl@redhat.com,
        peterz@infradead.org
Subject: Re: [PATCH v2 1/2] exec: add PR_HIDE_SELF_EXE prctl
Message-ID: <Y8mCqn3fIaqk9N0Q@x1>
References: <20230119170718.3129938-1-gscrivan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119170718.3129938-1-gscrivan@redhat.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 06:07:17PM +0100, Giuseppe Scrivano wrote:
> This patch adds a new prctl called PR_HIDE_SELF_EXE which allows
> processes to hide their own /proc/*/exe file. When this prctl is
> used, every access to /proc/*/exe for the calling process will
> fail with ENOENT.
> 
> This is useful for preventing issues like CVE-2019-5736, where an
> attacker can gain host root access by overwriting the binary
> in OCI runtimes through file-descriptor mishandling in containers.
> 
> The current fix for CVE-2019-5736 is to create a read-only copy or
> a bind-mount of the current executable, and then re-exec the current
> process.  With the new prctl, the read-only copy or bind-mount copy is
> not needed anymore.
> 
> While map_files/ also might contain symlinks to files in host,
> proc_map_files_get_link() permissions checks are already sufficient.
> 
> Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>
> ---
>  fs/exec.c                        | 1 +
>  fs/proc/base.c                   | 8 +++++---
>  include/linux/sched.h            | 5 +++++
>  include/uapi/linux/prctl.h       | 3 +++
>  kernel/sys.c                     | 9 +++++++++
>  tools/include/uapi/linux/prctl.h | 3 +++
>  6 files changed, 26 insertions(+), 3 deletions(-)
> 
> v1: https://lkml.org/lkml/2023/1/4/334
> 
> Differences from v1:
> 
> - amended more information in the commit message wrt map_files not
>   requiring the same protection.
> - changed the test to verify PR_HIDE_SELF_EXE cannot be unset after
>   a fork.
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index ab913243a367..5a5dd964c3a3 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1855,6 +1855,7 @@ static int bprm_execve(struct linux_binprm *bprm,
>  	/* execve succeeded */
>  	current->fs->in_exec = 0;
>  	current->in_execve = 0;
> +	task_clear_hide_self_exe(current);

[snip]

>  	rseq_execve(current);
>  	acct_update_integrals(current);
>  	task_numa_free(current, false);
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 9e479d7d202b..959968e2da0d 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -1723,19 +1723,21 @@ static int proc_exe_link(struct dentry *dentry, struct path *exe_path)
>  {
>  	struct task_struct *task;
>  	struct file *exe_file;
> +	long hide_self_exe;
>  
>  	task = get_proc_task(d_inode(dentry));
>  	if (!task)
>  		return -ENOENT;
>  	exe_file = get_task_exe_file(task);
> +	hide_self_exe = task_hide_self_exe(task);

Perhaps I am missing something, but where is task_clear_hide_self_exe()
and task_hide_self_exe() defined?

Brian

