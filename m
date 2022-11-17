Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7385B62E4FD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 20:10:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239397AbiKQTKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 14:10:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233563AbiKQTKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 14:10:47 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4675A5F867
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 11:10:46 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id q1so2828792pgl.11
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 11:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vWIMIJOLR1ZWP39J9pWvnWbHjuvpXRyJAoGNGTtOVYI=;
        b=EQwEPuLgzqoeTKcS7jmfdO1ts/EI4TuE1KFLzpSYgKpRdkHrkzO8YvoL5CXrFCgkgM
         RWENzn3GNhTboobst1d+kvL3HAHHIYliEMYopWa0nMuRYWOJAM7zHZSihydj8tMSwfPT
         7Mbu2XmUDBniPYl1i3bJudB7CEAhox1GM6xOhrpgcVuKwHmMkFacyl6ZIc1ReWMLmh6N
         1/D5un05T65bD6c03whgTPgnpTNDOWWrbhN+vAdFFwuG/RUgC2ml6nC9qiykbfzAE/NM
         wyw4lb2zr38xXeIMCOIqbspEj6lhYFSpOC1j80AQ7vBI5yfUBJVZD73HU1UpSQHzYm3f
         PaDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vWIMIJOLR1ZWP39J9pWvnWbHjuvpXRyJAoGNGTtOVYI=;
        b=kR80uLqYtLp8KkdznWe0h2jDqTuckqafVB95VLBZJ4QxCw9AlgQLSpDY+S9kzMbX50
         SgncGFtemrVch1KgwViwLyykR0GfMoFtmkBPRTm58xxrvvNcW09cpOJesFPBWmP2r/le
         4OQioQSQloZ7CegiEHZGVNy7jMw9vZJa/YU7d8BwgWWmlaqfGQiXH0vfi32GQFWDqd3E
         JkS7jCsgWul1VTpa2qOmsukZwcARGAn6BxRU3XCsGHfRwRW/0pZYbYQIZTo1oUgKN5PW
         TL3TW5q1xf1aR6EVjgg7R/hVCPQQLz+K4qBXyWx/YbIXh4lCSjHcZEMt4E/V4C5NwcYd
         uc1A==
X-Gm-Message-State: ANoB5pmmvudFbf7bHSoU8V1xFZEHB7o0A/VMkvLyCZDnM+7NulE1NWup
        xqUmOz3dkaVDoWd8N2Jt0So2Add2/XJbEw==
X-Google-Smtp-Source: AA0mqf6P4WdUgFu5uypTYxFGUm6JCIFL4DiQGiM+DvuY36mevs4XCEDFbK83+RPxg837oTFGmj9LMA==
X-Received: by 2002:a62:1a05:0:b0:56c:1277:d056 with SMTP id a5-20020a621a05000000b0056c1277d056mr4278757pfa.23.1668712245558;
        Thu, 17 Nov 2022 11:10:45 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id v185-20020a622fc2000000b0053e38ac0ff4sm1501912pfv.115.2022.11.17.11.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 11:10:45 -0800 (PST)
Date:   Thu, 17 Nov 2022 19:10:41 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
        Florian Weimer <fw@deneb.enyo.de>, David.Laight@aculab.com,
        carlos@redhat.com, Peter Oskolkov <posk@posk.io>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        Chris Kennelly <ckennelly@google.com>
Subject: Re: [PATCH v5 08/24] sched: Introduce per memory space current
 virtual cpu id
Message-ID: <Y3aHMTNv0yiyHCun@google.com>
References: <20221103200359.328736-1-mathieu.desnoyers@efficios.com>
 <20221103200359.328736-9-mathieu.desnoyers@efficios.com>
 <CALCETrW1doHX3=za+KDuB=4y+wHsnaZpVkDP3OhZXGrQU2iffw@mail.gmail.com>
 <2f191ddb-de89-52c0-e7da-26ac0239b8fe@efficios.com>
 <Y3KpxR4ABRxvD+kj@google.com>
 <273f4883-25bc-44ad-9c35-3950ca8a3fcf@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <273f4883-25bc-44ad-9c35-3950ca8a3fcf@efficios.com>
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

On Thu, Nov 17, 2022, Mathieu Desnoyers wrote:
> On 2022-11-14 15:49, Sean Christopherson wrote:
> > On Fri, Nov 11, 2022, Mathieu Desnoyers wrote:
> > > On 2022-11-10 23:41, Andy Lutomirski wrote:
> > > > On Thu, Nov 3, 2022 at 1:05 PM Mathieu Desnoyers
> > > > <mathieu.desnoyers@efficios.com> wrote:
> > > > Also, in my mind "virtual cpu" is vCPU, which this isn't.  Maybe
> > > > "compacted cpu" or something?  It's a strange sort of concept.
> > > 
> > > I've kept the same wording that has been introduced in 2011 by Paul Turner
> > > and used internally at Google since then, although it may be confusing if
> > > people expect kvm-vCPU and rseq-vcpu to mean the same thing. Both really end
> > > up providing the semantic of a virtually assigned cpu id (in opposition to
> > > the logical cpu id on the system), but this is much more involved in the
> > > case of KVM.
> > 
> > I had the same reaction as Andy.  The rseq concepts don't worry me so much as the
> > existence of "vcpu" in mm_struct/task_struct, e.g. switch_mm_vcpu() when switching
> > between KVM vCPU tasks is going to be super confusing.  Ditto for mm_vcpu_get()
> > and mm_vcpu_put() in the few cases where KVM currently does mmget()/mmput().
> 
> I'm fine with changing the wording if it helps make things less confusing.
> 
> Should we go for "compact-cpu-id" ? "packed-cpu-id" ? Other ideas ?

What about something like "process-local-cpu-id" to capture that the ID has meaning
only within the associated address space / process?
