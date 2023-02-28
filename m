Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 204D66A5DEA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 18:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjB1REp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 12:04:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjB1REm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 12:04:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD0189EE9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 09:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677603833;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uLkxFWJZoOWbhdfRTliUPcDXf7HJjLU8upPpqW9MN+E=;
        b=WKnZcnEDv8ni8c7nrWRdfM53Z64dgNBxjmTOAbW7mIoC+FW92v/5CLqgNHrrMW/ICgZiLa
        4JZnASriPUlMkB9b4dL+M46AAxbVcHrGDNyPBKIjKLCEjWFCnN1fxEmFtIYGgZDvo6w4ad
        Sdtb7skNamr6xb3/pkP/MdOJXMxZIcU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-656-MUOEg7B2MX2gDbAZOsCHxA-1; Tue, 28 Feb 2023 12:03:51 -0500
X-MC-Unique: MUOEg7B2MX2gDbAZOsCHxA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F35A73C0ED4A;
        Tue, 28 Feb 2023 17:03:49 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.252])
        by smtp.corp.redhat.com (Postfix) with SMTP id 4C88C404BEC5;
        Tue, 28 Feb 2023 17:03:47 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 28 Feb 2023 18:03:43 +0100 (CET)
Date:   Tue, 28 Feb 2023 18:03:40 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Gregory Price <gourry.memverge@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        avagin@gmail.com, peterz@infradead.org, luto@kernel.org,
        krisman@collabora.com, tglx@linutronix.de, corbet@lwn.net,
        shuah@kernel.org, Gregory Price <gregory.price@memverge.com>
Subject: Re: [PATCH v12 2/3] ptrace,syscall_user_dispatch: checkpoint/restore
 support for SUD
Message-ID: <20230228170339.GA15021@redhat.com>
References: <20230224233126.1936-1-gregory.price@memverge.com>
 <20230224233126.1936-3-gregory.price@memverge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230224233126.1936-3-gregory.price@memverge.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gregory,

I can't resist, I have a couple of cosmetic nits.

On 02/24, Gregory Price wrote:
>
> +int syscall_user_dispatch_get_config(struct task_struct *task, unsigned long size,
> +				     void __user *data)
> +{
> +	struct syscall_user_dispatch *sd = &task->syscall_dispatch;
> +	struct ptrace_sud_config config;
> +
> +	if (size != sizeof(struct ptrace_sud_config))
> +		return -EINVAL;
> +
> +	if (test_task_syscall_work(task, SYSCALL_USER_DISPATCH))
> +		config.mode = PR_SYS_DISPATCH_ON;
> +	else
> +		config.mode = PR_SYS_DISPATCH_OFF;
> +
> +	config.offset = sd->offset;
> +	config.len = sd->len;
> +	config.selector = (__u64)(uintptr_t)sd->selector;
> +
> +	if (copy_to_user(data, &config, sizeof(config)))

Let me repeat, do not mix sizeof(struct ptrace_sud_config) and sizeof(config).
Perhaps this is just me, but this looks confusing to me. Please use
sizeof(config) both times.

> +int syscall_user_dispatch_set_config(struct task_struct *task, unsigned long size,
> +				     void __user *data)
> +{
> +	int rc;
> +	struct ptrace_sud_config cfg;
                                 ^^^

Again, this is cosmetic but a bit annoying. Please use either "config" or
"cfg" in both functions to make the naming more consistent.


> +	rc = task_set_syscall_user_dispatch(task, cfg.mode, cfg.offset,
> +					    cfg.len, (char __user *)(uintptr_t)cfg.selector);


	rc = task_set_syscall_user_dispatch(task, cfg.mode, cfg.offset, cfg.len,
					   (char __user *)(uintptr_t)cfg.selector);

looks a bit better to me.

Oleg.

