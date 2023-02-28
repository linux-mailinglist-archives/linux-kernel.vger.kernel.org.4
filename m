Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF446A5DBB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 17:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjB1QzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 11:55:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbjB1QzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 11:55:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D87AB360B8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 08:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677603174;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zCkSECvXS7yB7KD0+uxNsAJHsyUzclFZ5TPFGlTqNhA=;
        b=LYHDI7T2KgArZmWGQD/n69LhteayWHvk+RbPkFPv8YYiyoEV17qYo7jseMwDlSi/vEYPzI
        O0pFmalruQukwFSLEAZ9oqBaXU/VGo4OMT/vqTh6zbdZLYHjX/Ms3HtRvPypfYly5joutM
        UKVjD3zj+8w0VNN2fHs8xC/tK6Fr6UQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-605-7BXfBiSpNsaGYExb4C9rcw-1; Tue, 28 Feb 2023 11:52:51 -0500
X-MC-Unique: 7BXfBiSpNsaGYExb4C9rcw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AA670811E9C;
        Tue, 28 Feb 2023 16:52:50 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.252])
        by smtp.corp.redhat.com (Postfix) with SMTP id C9D3018EC6;
        Tue, 28 Feb 2023 16:52:47 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 28 Feb 2023 17:52:44 +0100 (CET)
Date:   Tue, 28 Feb 2023 17:52:40 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Dmitry Safonov <0x7f454c46@gmail.com>
Cc:     Gregory Price <gourry.memverge@gmail.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        avagin@gmail.com, peterz@infradead.org, luto@kernel.org,
        krisman@collabora.com, tglx@linutronix.de, corbet@lwn.net,
        shuah@kernel.org, Gregory Price <gregory.price@memverge.com>
Subject: Re: [PATCH v12 2/3] ptrace,syscall_user_dispatch: checkpoint/restore
 support for SUD
Message-ID: <20230228165217.GA16798@redhat.com>
References: <20230224233126.1936-1-gregory.price@memverge.com>
 <20230224233126.1936-3-gregory.price@memverge.com>
 <CAJwJo6YnELNhU8RmR-z37vDZ=xb0CmUUBgrPGgHP2dqjVm=O2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJwJo6YnELNhU8RmR-z37vDZ=xb0CmUUBgrPGgHP2dqjVm=O2g@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/27, Dmitry Safonov wrote:
>
> > +int syscall_user_dispatch_set_config(struct task_struct *task, unsigned long size,
> > +                                    void __user *data)
> > +{
> > +       int rc;
> > +       struct ptrace_sud_config cfg;
> > +
> > +       if (size != sizeof(struct ptrace_sud_config))
> > +               return -EINVAL;
> > +
> > +       if (copy_from_user(&cfg, data, sizeof(struct ptrace_sud_config)))
> > +               return -EFAULT;
>
> It seems that the tool you want here would be copy_struct_from_user(),
> which is designed for extendable syscalls.

Hmm. Why?

In this case ksize == usize, so why do we need copy_struct_from_user ?

Oleg.

