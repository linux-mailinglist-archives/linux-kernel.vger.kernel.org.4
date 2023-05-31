Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4917071781F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 09:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234200AbjEaH0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 03:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234502AbjEaH01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 03:26:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17CEF113
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 00:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685517940;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N34/mNWQwnGZ07cT22bXzRfAdms5vf9xTB7hi2yghbc=;
        b=TdREAGaRv2Rq1xJgnvLkrYMCxdbnSf7sY+SYEmiJU2uRmiMlQamRNbNaNtzUxqvIru9qsH
        +a9v9+rIoo1CmW4wKqVxUrhApreVctr3gQoJk62ObWVto7r7Df9QS1NsjVS/Wdw9cIngbU
        DOAUwY35ARh+AELOs5ZbfRTsHxS1+8w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-621-RzkGs-_iNSSyNN3HlogBmw-1; Wed, 31 May 2023 03:25:34 -0400
X-MC-Unique: RzkGs-_iNSSyNN3HlogBmw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3FEB7185A7A5;
        Wed, 31 May 2023 07:25:34 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.238])
        by smtp.corp.redhat.com (Postfix) with SMTP id 6B5E5492B0A;
        Wed, 31 May 2023 07:25:31 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 31 May 2023 09:25:14 +0200 (CEST)
Date:   Wed, 31 May 2023 09:25:11 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Mike Christie <michael.christie@oracle.com>, linux@leemhuis.info,
        nicolas.dichtel@6wind.com, axboe@kernel.dk, ebiederm@xmission.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, stefanha@redhat.com, brauner@kernel.org
Subject: Re: [PATCH 3/3] fork, vhost: Use CLONE_THREAD to fix freezer/ps
 regression
Message-ID: <20230531072449.GA25046@redhat.com>
References: <20230522025124.5863-1-michael.christie@oracle.com>
 <20230522025124.5863-4-michael.christie@oracle.com>
 <20230522123029.GA22159@redhat.com>
 <cfca7764-d210-6df9-e182-2c093101c6cf@oracle.com>
 <20230522174757.GC22159@redhat.com>
 <20230523121506.GA6562@redhat.com>
 <26c87be0-8e19-d677-a51b-e6821e6f7ae4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <26c87be0-8e19-d677-a51b-e6821e6f7ae4@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/31, Jason Wang wrote:
>
> 在 2023/5/23 20:15, Oleg Nesterov 写道:
> >
> >		/* make sure flag is seen after deletion */
> >		smp_wmb();
> >		llist_for_each_entry_safe(work, work_next, node, node) {
> >			clear_bit(VHOST_WORK_QUEUED, &work->flags);
> >
> >I am not sure about smp_wmb + clear_bit. Once we clear VHOST_WORK_QUEUED,
> >vhost_work_queue() can add this work again and change work->node->next.
> >
> >That is why we use _safe, but we need to ensure that llist_for_each_safe()
> >completes LOAD(work->node->next) before VHOST_WORK_QUEUED is cleared.
>
> This should be fine since store is not speculated, so work->node->next needs
> to be loaded before VHOST_WORK_QUEUED is cleared to meet the loop condition.

I don't understand you. OK, to simplify, suppose we have 2 global vars

	void *PTR = something_non_null;
	unsigned long FLAGS = -1ul;

Now I think this code

	CPU_0				CPU_1

	void *ptr = PTR;		if (!test_and_set_bit(0, FLAGS))
	clear_bit(0, FLAGS);			PTR = NULL;
	BUG_ON(!ptr);

is racy and can hit the BUG_ON(!ptr).

I guess it is fine on x86, but in general you need smp_mb__before_atomic()
before clear_bit(), or clear_bit_unlock().

> >			__set_current_state(TASK_RUNNING);
> >
> >Why do we set TASK_RUNNING inside the loop? Does this mean that work->fn()
> >can return with current->state != RUNNING ?
>
> It is because the state were set to TASK_INTERRUPTIBLE in the beginning of
> the loop otherwise it might be side effect while executing work->fn().

Again, I don't understand you. So let me repeat: can work->fn() return with
current->_state != TASK_RUNNING ? If not (and I'd say it should not), you can
do __set_current_state(TASK_RUNNING) once, before llist_for_each_entry_safe().

> >Now the main question. Whatever we do, SIGKILL/SIGSTOP/etc can come right
> >before we call work->fn(). Is it "safe" to run this callback with
> >signal_pending() or fatal_signal_pending() ?
>
> It looks safe since:
>
> 1) vhost hold refcnt of the mm
> 2) release will sync with the worker

Well, that's not what I asked... nevermind, please forget.

Thanks.

Oleg.

