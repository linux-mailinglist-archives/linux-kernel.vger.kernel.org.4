Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE2B069F4DF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 13:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbjBVMtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 07:49:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbjBVMtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 07:49:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC0930295
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 04:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677070131;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Pwhafy9c9OVklvOu8fWr7CpmYP0sg2Cj0LDnB+q0JdQ=;
        b=Iw703xDVZk4ujrKnh05Za6BH8CK1wzP8sPgjHueyexCIhigNGzORqmn47SM4rgUzcRMfDL
        JhDSEvJ2m81yBVTYY0uvbapDnJQyrx0i4dB0gSqthnND6zpPJ3PZoM/W2ZWfkfHo4iXbIn
        9ibfOwR3zdTAHGRp8ypVz00tiLtbvuI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-136-yC4_3_61NByzTdmNpn1GFA-1; Wed, 22 Feb 2023 07:48:44 -0500
X-MC-Unique: yC4_3_61NByzTdmNpn1GFA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B11E73C10690;
        Wed, 22 Feb 2023 12:48:43 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.227.52])
        by smtp.corp.redhat.com (Postfix) with SMTP id 24BD82026D38;
        Wed, 22 Feb 2023 12:48:40 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 22 Feb 2023 13:48:38 +0100 (CET)
Date:   Wed, 22 Feb 2023 13:48:35 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Gregory Price <gourry.memverge@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        avagin@gmail.com, peterz@infradead.org, luto@kernel.org,
        krisman@collabora.com, tglx@linutronix.de, corbet@lwn.net,
        shuah@kernel.org, Gregory Price <gregory.price@memverge.com>
Subject: Re: [PATCH v11 2/2] ptrace,syscall_user_dispatch: checkpoint/restore
 support for SUD
Message-ID: <20230222124834.GA15591@redhat.com>
References: <20230221201740.2236-1-gregory.price@memverge.com>
 <20230221201740.2236-3-gregory.price@memverge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230221201740.2236-3-gregory.price@memverge.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/21, Gregory Price wrote:
>
> +struct ptrace_sud_config {
> +	__u8  mode;
> +	__u8  pad[7];
              ^^^^^^
Why?

> +int syscall_user_dispatch_get_config(struct task_struct *task, unsigned long size,
> +		                     void __user *data)
> +{
> +	struct syscall_user_dispatch *sd = &task->syscall_dispatch;
> +	struct ptrace_sud_config config;
> +	if (size != sizeof(struct ptrace_sud_config))
> +		return -EINVAL;

Andrei, do we really need this check?

> +
> +	if (test_task_syscall_work(task, SYSCALL_USER_DISPATCH))
> +		config.mode = PR_SYS_DISPATCH_ON;
> +	else
> +		config.mode = PR_SYS_DISPATCH_OFF;
> +
> +	config.offset = sd->offset;
> +	config.len = sd->len;
> +	config.selector = (__u64)sd->selector;

As the kernel test robot reports, this is not -Wpointer-to-int-cast friendly.
Please use uintptr_t. See for example ptrace_get_rseq_configuration(). Same
for syscall_user_dispatch_set_config().

> +	if (copy_to_user(data, &config, sizeof(config))) {

This leaks info in (uninitialized) config.pad[]. You can probably simply make
config.mode __u64 as well.

Minor, but sizeof(struct ptrace_sud_config) above vs this sizeof(config)) doesn't
look consistent to me...

> +static int sys_ptrace(int request, pid_t pid, void *addr, void *data)
> +{
> +	return syscall(SYS_ptrace, request, pid, addr, data);
> +}

Why can't you simply use ptrace() ?

Oleg.

