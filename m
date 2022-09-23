Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF6DE5E7DCF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 17:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232136AbiIWO76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 10:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbiIWO7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 10:59:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C350319002
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 07:59:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F56361219
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 14:59:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DEF1C433D6;
        Fri, 23 Sep 2022 14:59:40 +0000 (UTC)
Date:   Fri, 23 Sep 2022 11:00:44 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Kassey Li <quic_yingangl@quicinc.com>
Cc:     mingo@redhat.com, tj@kernel.org, william.kucharski@oracle.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cgroup: align the comm length with TASK_COMM_LEN
Message-ID: <20220923110044.7261afa0@gandalf.local.home>
In-Reply-To: <20220923075105.28251-1-quic_yingangl@quicinc.com>
References: <20220923075105.28251-1-quic_yingangl@quicinc.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Sep 2022 15:51:05 +0800
Kassey Li <quic_yingangl@quicinc.com> wrote:

> __string could get a dst string with length less than
> TASK_COMM_LEN.
> 
> A task->comm may change that can cause out of bounds access
> for the dst string buffer, e.g in the call trace of below:
> 
> Call trace:
> 
>     dump_backtrace.cfi_jt+0x0/0x4
>     show_stack+0x14/0x1c
>     dump_stack+0xa0/0xd8
>     die_callback+0x248/0x24c
>     notify_die+0x7c/0xf8
>     die+0xac/0x290
>     die_kernel_fault+0x88/0x98
>     die_kernel_fault+0x0/0x98
>     do_page_fault+0xa0/0x544
>     do_mem_abort+0x60/0x10c
>     el1_da+0x1c/0xc4
>     trace_event_raw_event_cgroup_migrate+0x124/0x170
>     cgroup_attach_task+0x2e8/0x41c
>     __cgroup1_procs_write+0x114/0x1ec
>     cgroup1_tasks_write+0x10/0x18
>     cgroup_file_write+0xa4/0x208
>     kernfs_fop_write+0x1f0/0x2f4
>     __vfs_write+0x5c/0x200
>     vfs_write+0xe0/0x1a0
>     ksys_write+0x74/0xdc
>     __arm64_sys_write+0x18/0x20
>     el0_svc_common+0xc0/0x1a4
>     el0_svc_compat_handler+0x18/0x20
>     el0_svc_compat+0x8/0x2c
> 
> Change it as arrary with same length TASK_COMM_LEN,
> This idea is from commit d1eb650ff413 ("tracepoint: Move signal sending
> tracepoint to events/signal.h").

This does not make sense. What exactly is the bug here?

__string() will do a strlen(task->comm) + 1 to allocate on the ring buffer.
It should not be less that task->comm. The above stack dump does not show
what happened.

This looks like another bug and I do not see how this patch addresses
the issue.

-- Steve

> 
> Signed-off-by: Kassey Li <quic_yingangl@quicinc.com>
> ---
>  include/trace/events/cgroup.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/trace/events/cgroup.h b/include/trace/events/cgroup.h
> index dd7d7c9efecd..b4ef0ffa38a4 100644
> --- a/include/trace/events/cgroup.h
> +++ b/include/trace/events/cgroup.h
> @@ -130,7 +130,7 @@ DECLARE_EVENT_CLASS(cgroup_migrate,
>  		__field(	u64,		dst_id			)
>  		__field(	int,		pid			)
>  		__string(	dst_path,	path			)
> -		__string(	comm,		task->comm		)
> +		__array(char, comm, TASK_COMM_LEN)
>  	),
>  
>  	TP_fast_assign(
> @@ -139,12 +139,12 @@ DECLARE_EVENT_CLASS(cgroup_migrate,
>  		__entry->dst_level = dst_cgrp->level;
>  		__assign_str(dst_path, path);
>  		__entry->pid = task->pid;
> -		__assign_str(comm, task->comm);
> +		memcpy(__entry->comm, task->comm, TASK_COMM_LEN);
>  	),
>  
>  	TP_printk("dst_root=%d dst_id=%llu dst_level=%d dst_path=%s pid=%d comm=%s",
>  		  __entry->dst_root, __entry->dst_id, __entry->dst_level,
> -		  __get_str(dst_path), __entry->pid, __get_str(comm))
> +		  __get_str(dst_path), __entry->pid, __entry->comm)
>  );
>  
>  DEFINE_EVENT(cgroup_migrate, cgroup_attach_task,

