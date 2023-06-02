Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9214720880
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 19:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236944AbjFBRlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 13:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235789AbjFBRlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 13:41:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 341621B9
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 10:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685727627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wbtd2XCVq+/sFLE2jxa6+mJAIWTP4JlHCpeKfF2/aOU=;
        b=FL0FZSB8o/TqIo7SPRvxchPKqz1PmRTQjBJ84FaRyK/FcwTe6zmcPKLh4IkVjlIz2o0HJW
        2UMvKupEq9o55pUGJr1nrWlq6cZO6dO8S0VN2UYPVIWQ7DKux4Q4t+WVBfn1mhZ/nN6IwV
        DiqqrikJo5rEWvp9wAegp4Me3jMrrN0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-517-Y5BaPcR8NzKjlfIPcJuT6A-1; Fri, 02 Jun 2023 13:40:23 -0400
X-MC-Unique: Y5BaPcR8NzKjlfIPcJuT6A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AF386800B35;
        Fri,  2 Jun 2023 17:40:22 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.50])
        by smtp.corp.redhat.com (Postfix) with SMTP id C9F649E63;
        Fri,  2 Jun 2023 17:40:17 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri,  2 Jun 2023 19:40:01 +0200 (CEST)
Date:   Fri, 2 Jun 2023 19:39:56 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Wander Lairson Costa <wander@redhat.com>
Cc:     "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Brian Cain <bcain@quicinc.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Stafford Horne <shorne@gmail.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrei Vagin <avagin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Yu Zhao <yuzhao@google.com>,
        Alexey Gladkov <legion@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Yang Shi <shy828301@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Hu Chunyu <chuhu@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Luis Goncalves <lgoncalv@redhat.com>
Subject: Re: [PATCH v9] kernel/fork: beware of __put_task_struct calling
 context
Message-ID: <20230602173955.GA555@redhat.com>
References: <20230516191441.34377-1-wander@redhat.com>
 <20230517152632.GC1286@redhat.com>
 <CAAq0SUkE_4qF5RuWE7MxnzcbchE4SHkyMvJxHAQeJ+=ZTEwdgg@mail.gmail.com>
 <20230529122256.GA588@redhat.com>
 <CAAq0SUkjFiN3Xap-S2awymDqDWZceCnAWBQnESVMVya7RpFFUw@mail.gmail.com>
 <20230601181359.GA23852@redhat.com>
 <CAAq0SUk3c5H8YCVAfRAU=pZFNLrA90mNMq=k5BohTutM7cfcvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAq0SUk3c5H8YCVAfRAU=pZFNLrA90mNMq=k5BohTutM7cfcvg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/01, Wander Lairson Costa wrote:
>
> On Thu, Jun 1, 2023 at 3:14 PM Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > > but only in the RT kernel
> >
> > this again suggests that your testing was wrong or I am totally confused (quite
> > possible, I know nothing about RT). I did the testing without CONFIG_PREEMPT_RT.
> >
>
> Hrm, could you please share your .config?

Sure. I do not want to spam the list, I'll send you a private email.

Can you share your kernel module code?

Did you verify that debug_locks != 0 as I asked in my previous email ?

> > > But running the reproducer for put_task_struct(), works fine.
> >
> > which reproducer ?
> >
>
> Only now I noticed I didn't add the reproducer to the commit message:
>
> while true; do
>     stress-ng --sched deadline --sched-period 1000000000
> --sched-runtime 800000000 --sched-deadline 1000000000 --mmapfork 23 -t
> 20
> done

Cough ;) I think we need something more simple to ensure that
refcount_sub_and_test(nr, &t->usage) returns true under raw_spin_lock()
and then __put_task_struct() actually takes spin_lock().

Oleg.

