Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B19962F256
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 11:18:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241469AbiKRKR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 05:17:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241507AbiKRKRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 05:17:53 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E65F8FFBF
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 02:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=B3/GIXKJuLbpDVrFdUm6zkzoboeBdzy/xsx3HgypraA=; b=iKknHtF0iqJPrnOfa/UWeHA+DO
        7aWDC5HaN8rqcjKwZ/gXWDAHPfR+yklnJ9jdIG5HjmF010GT2Wu3U+bKjsDiBOLhXTqkyxngsDvyn
        sS+IxQ7GMdkJNCdrGJwuUSY6EAlfpuIT7Z7DXXfdxXLGMs9h3EkrH1qhRJFF49jqs8TBIByfS7Sh3
        tcKJr5Do7jcAa4hnZwbLwHAq2rvM1gw0bgHk+WfD74whsJ3xv51/efIVKiIC6bJEN36NK9y1e1c1S
        ufMPuzN+vrlP+nY8j7NZdv1JHv3Nz6Iv8vQeyShM1ULBbpHIIoDbYpVc9oLu9FOTsTY4k/zN5sPOU
        ERiSiuhA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ovyR1-001wp5-RR; Fri, 18 Nov 2022 10:17:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2DD44300244;
        Fri, 18 Nov 2022 11:17:22 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id ECB60201A1023; Fri, 18 Nov 2022 11:17:21 +0100 (CET)
Date:   Fri, 18 Nov 2022 11:17:21 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com, bvanassche@acm.org
Subject: Re: [PATCH] locking/lockdep: fix null-ptr-deref in check_prev_add()
Message-ID: <Y3dbsSUwIp8yfT3l@hirez.programming.kicks-ass.net>
References: <20221118083102.4011977-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221118083102.4011977-1-yangyingliang@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 04:31:02PM +0800, Yang Yingliang wrote:
> I got a null-ptr-deref report as following:
> 
> general protection fault, probably for non-canonical address 0xdffffc0000000008: 0000 [#1] PREEMPT SMP KASAN PTI
> KASAN: null-ptr-deref in range [0x0000000000000040-0x0000000000000047]
> CPU: 0 PID: 500 Comm: systemd-udevd Tainted: G        W          6.1.0-rc5-00144-gabd8ea84ca72-dirty #1320
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
> RIP: 0010:check_prevs_add+0x2f8/0x2780
> Call Trace:
>  <TASK>
>  __lock_acquire+0x2ae8/0x3d60
>  lock_acquire+0x195/0x4e0
>  fs_reclaim_acquire+0x119/0x160
>  kmem_cache_alloc_node+0x47/0x310
>  __alloc_skb+0x205/0x2d0
>  devlink_compat_running_version+0x10b/0x6a0
>  dev_ethtool+0x285/0x380
>  dev_ioctl+0x16c/0xff0
>  sock_do_ioctl+0x1ae/0x220
>  sock_ioctl+0x55f/0x600
>  __x64_sys_ioctl+0x156/0x1d0
>  do_syscall_64+0x37/0x90
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> If in use bit of lock_class is not set, hlock_class() returns NULL,

Why is that a valid premise?

That is; you think it is OK for a held_lock to not have an in-use
lock_class?

I'm thinking there's more to this problem you found.

