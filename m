Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 382CF70C49E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 19:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233029AbjEVRtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 13:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232901AbjEVRtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 13:49:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9DEFF
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 10:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684777702;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b7LSkGuXeXqte2Z5Adf2PWVtK/h6XyI9Wqw3/+z8Mgw=;
        b=Fe9S92bw4lb0phNnSvA29psaM8TsE1afHolDYUDexdsjgcnLvhjTHnwmAtlDeeQlsCU/hc
        qQYuZrXvcruviIncJssXll8iUb9ftO176IX44DT/zV9MvtK1M+W5+4k5rkhsdslPG3BzFJ
        BmTGKv8pfCUQweiyjN0myZTxsQqUuc4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-150-Z9dhIrpdOzKq_gulj_8cBw-1; Mon, 22 May 2023 13:48:19 -0400
X-MC-Unique: Z9dhIrpdOzKq_gulj_8cBw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 20E2B811E94;
        Mon, 22 May 2023 17:48:18 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.202])
        by smtp.corp.redhat.com (Postfix) with SMTP id 42E2A2166B25;
        Mon, 22 May 2023 17:48:15 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 22 May 2023 19:48:01 +0200 (CEST)
Date:   Mon, 22 May 2023 19:47:58 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     linux@leemhuis.info, nicolas.dichtel@6wind.com, axboe@kernel.dk,
        ebiederm@xmission.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        brauner@kernel.org
Subject: Re: [PATCH 3/3] fork, vhost: Use CLONE_THREAD to fix freezer/ps
 regression
Message-ID: <20230522174757.GC22159@redhat.com>
References: <20230522025124.5863-1-michael.christie@oracle.com>
 <20230522025124.5863-4-michael.christie@oracle.com>
 <20230522123029.GA22159@redhat.com>
 <cfca7764-d210-6df9-e182-2c093101c6cf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cfca7764-d210-6df9-e182-2c093101c6cf@oracle.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/22, Mike Christie wrote:
>
> On 5/22/23 7:30 AM, Oleg Nesterov wrote:
> >> +			/*
> >> +			 * When we get a SIGKILL our release function will
> >> +			 * be called. That will stop new IOs from being queued
> >> +			 * and check for outstanding cmd responses. It will then
> >> +			 * call vhost_task_stop to tell us to return and exit.
> >> +			 */
> >
> > But who will call the release function / vhost_task_stop() and when this
> > will happen after this thread gets SIGKILL ?
>
> When we get a SIGKILL, the thread that owns the device/vhost_task will
> also exit since it's the same thread group and it does:
>
> do_exit -> exit_files -> put_files_struct -> close_files -> fput

Ah. thanks. I confused CLONE_FS in vhost_task_create() with CLONE_FILES.

> > Also. Suppose that vhost_worker() dequeues SIGKILL and clears TIF_SIGPENDING.
> >
> > SIGSTOP, PTRACE_INTERRUPT, freezer can come and set TIF_SIGPENDING again.
> > In this case the main for (;;) loop will spin without sleeping until
> > vhost_task_should_stop() becomes true?
>
> I see. So I either have to be able to call get_signal after SIGKILL or
> at this time work like a kthread and ignore signals like a
>
> if (dead && signal_pending())
> 	flush_signals()
> ?

Right now I think that "int dead" should die, and you should simply do
get_signal() + clear(SIGPENDING) if signal_pending() == T , but let me
think tomorrow.

Oleg.

