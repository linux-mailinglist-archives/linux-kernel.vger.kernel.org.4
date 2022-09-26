Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 416145E9807
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 04:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbiIZClT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 22:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233410AbiIZClB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 22:41:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694B926AF4
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 19:40:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EAF63616D0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 02:40:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B094AC433C1;
        Mon, 26 Sep 2022 02:40:57 +0000 (UTC)
Date:   Sun, 25 Sep 2022 22:42:04 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Kassey Li <quic_yingangl@quicinc.com>
Cc:     <mingo@redhat.com>, <tj@kernel.org>,
        <william.kucharski@oracle.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] cgroup: align the comm length with TASK_COMM_LEN
Message-ID: <20220925224204.4e5d341e@gandalf.local.home>
In-Reply-To: <fee4b5ec-0e0d-8158-7e60-90f0918cab51@quicinc.com>
References: <20220923075105.28251-1-quic_yingangl@quicinc.com>
        <20220923110044.7261afa0@gandalf.local.home>
        <fee4b5ec-0e0d-8158-7e60-90f0918cab51@quicinc.com>
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

On Mon, 26 Sep 2022 10:18:55 +0800
Kassey Li <quic_yingangl@quicinc.com> wrote:

> >> @@ -139,12 +139,12 @@ DECLARE_EVENT_CLASS(cgroup_migrate,
> >>   		__entry->dst_level = dst_cgrp->level;
> >>   		__assign_str(dst_path, path);
> >>   		__entry->pid = task->pid;
> >> -		__assign_str(comm, task->comm);
> >> +		memcpy(__entry->comm, task->comm, TASK_COMM_LEN);  
> 	I think the problem is here, __assign_str using strcpy
> 	the task->comm here tail is not '\0'
> 	that's why it out of bounds access.
> 

If this is the case, then there's a lot more than just tracing that will
break. There are other places in the kernel has used strcpy() on task->comm,
and many more that do "%s" on task->comm, which would also crash on this.

> 	do you want to this version or just modify the memcpy or strncpy to do 
> with a known length ?  please give suggest so I can modify .

I'm guessing a problem exists elsewhere that makes it look like this is the
issue. I suggest finding where the '\0' is dropped (if that is indeed the
case).

-- Steve
