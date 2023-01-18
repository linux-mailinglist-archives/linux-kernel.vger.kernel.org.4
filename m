Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2323A670FE8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 02:21:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjARBVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 20:21:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbjARBVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 20:21:18 -0500
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F413A93
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 17:19:58 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-4bf16baa865so447239607b3.13
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 17:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JXWFfS4aiyJcUPRd+ryee/bpyv1wIIuVm8HjnFM4YwU=;
        b=Px76etJtqo+vzkJY5k26UOhb6WDYZwrowUwMIothVbfItA611chAfKe1cZZbCYe18v
         pWUOMkcFzisLL0UjLaeC38Vc9PdYHX+FX9AkzPAIJIhgrpwsvPVhbVFn0veZqmzECQNx
         X2BdlNyIyKIuzT2YeQCjVFDL8FE/Px/uceIbST/a1pV7aGbsLQCPDpebAGoJMjSuOLWv
         SKIu71ReD/rafQACFoXcYwdxqjH3PldndZq0ZsWTh9tgYpIH5Ip+0a0UN0bLIZhXeYPf
         HFNTn/s/dz5HXxIDO+CufvyshmF9uyF9zYjoFxKQAKHhdN7hU0pJIUOPsqK1VZhIER13
         SQtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JXWFfS4aiyJcUPRd+ryee/bpyv1wIIuVm8HjnFM4YwU=;
        b=jkwt652IRd4F13LKSKzVBlZu+bHEsB6aBwP9T8DgoOIBWiTr9w55TM8hyO4wkFIKve
         KJZLIrztbQJ0RYuWOGPWqysmZllHzTNt/6VDvrYO3ap4RuBjJpqT0ot2uJohN8NyxHXo
         tkzNSmP580jfPJk85RzI/bdUWfHsGMGwPDXGmDbNXZFaQBtectolXx54Iklt/Q8/Ogi/
         8Gq8HDd958RF8HYPc4DcvRtx/UgHefPtHQoGbAXDpg8BilRe/6DfEnXXN5jUi6gr9KQv
         lGw+gTO8wKExhu3SB7/XuWp57GJ8eY8mv0RmwCwScx2XiwUI1u+pjb7dh1P5lRaYWspI
         HQ3Q==
X-Gm-Message-State: AFqh2kpAGM0dpRtiG0WBOzI+sJMxGHjswhkXPx21yAf6xDLwfZ7LqAhc
        KdD9Pv0Qmk6kRwOLLISVsn12IOdtg0GRdzRoe4YLvg==
X-Google-Smtp-Source: AMrXdXuusAXlckmOHYo/FB3BTugnLiciDCWeH/OH9DYwge23YcEvOJoTVCiUAgQM3zYMQEArpfk5YvktjC1zXfSXUx0=
X-Received: by 2002:a0d:fc05:0:b0:3ea:454d:d1ef with SMTP id
 m5-20020a0dfc05000000b003ea454dd1efmr676859ywf.409.1674004797702; Tue, 17 Jan
 2023 17:19:57 -0800 (PST)
MIME-Version: 1.0
References: <20230109205336.3665937-1-surenb@google.com> <20230109205336.3665937-40-surenb@google.com>
 <Y8bFdB47JT/luMld@dhcp22.suse.cz>
In-Reply-To: <Y8bFdB47JT/luMld@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 17 Jan 2023 17:19:46 -0800
Message-ID: <CAJuCfpHVYW5aBVmT0vwn+j=m=Jo2KhSTzgVtxSEusUZJdzetUA@mail.gmail.com>
Subject: Re: [PATCH 39/41] kernel/fork: throttle call_rcu() calls in vm_area_free
To:     Michal Hocko <mhocko@suse.com>
Cc:     akpm@linux-foundation.org, michel@lespinasse.org,
        jglisse@google.com, vbabka@suse.cz, hannes@cmpxchg.org,
        mgorman@techsingularity.net, dave@stgolabs.net,
        willy@infradead.org, liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        paulmck@kernel.org, luto@kernel.org, songliubraving@fb.com,
        peterx@redhat.com, david@redhat.com, dhowells@redhat.com,
        hughd@google.com, bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        jannh@google.com, shakeelb@google.com, tatashin@google.com,
        edumazet@google.com, gthelen@google.com, gurua@google.com,
        arjunroy@google.com, soheil@google.com, hughlynch@google.com,
        leewalsh@google.com, posk@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 7:57 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Mon 09-01-23 12:53:34, Suren Baghdasaryan wrote:
> > call_rcu() can take a long time when callback offloading is enabled.
> > Its use in the vm_area_free can cause regressions in the exit path when
> > multiple VMAs are being freed.
>
> What kind of regressions.
>
> > To minimize that impact, place VMAs into
> > a list and free them in groups using one call_rcu() call per group.
>
> Please add some data to justify this additional complexity.

Sorry, should have done that in the first place. A 4.3% regression was
noticed when running execl test from unixbench suite. spawn test also
showed 1.6% regression. Profiling revealed that vma freeing was taking
longer due to call_rcu() which is slow when RCU callback offloading is
enabled. I asked Paul McKenney and he explained to me that because the
callbacks are offloaded to some other kthread, possibly running on
some other CPU, it is necessary to use explicit locking.  Locking on a
per-call_rcu() basis would result in excessive contention during
callback flooding. So, by batching call_rcu() work we cut that
overhead and reduce this lock contention.


> --
> Michal Hocko
> SUSE Labs
