Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23F2D749056
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 23:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232461AbjGEV4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 17:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232319AbjGEV4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 17:56:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BEA7E70
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 14:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688594151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p8it7Lv2/nZ5IAyyTTUfkyPQztkID/BOuHs31KerV44=;
        b=ec/W0L1Zag4xEwbBn74xAo3x5+sO+e8to1uenVMUP1OaTD5Q4ty7ZYvDM9Us778VX7T8aL
        39D1JYf+8Mjq1CqfwBSfNFdntbdRptUzRzClxjq1z4voLNVYpLv1SoBq0o8CwTKFzeAPw6
        I9QDWGLIKOEZ0PvDlq326elm320igIs=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-cdLUzN4UMnSMZVKE4HNrbQ-1; Wed, 05 Jul 2023 17:55:50 -0400
X-MC-Unique: cdLUzN4UMnSMZVKE4HNrbQ-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-765ad67e690so1461885a.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 14:55:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688594150; x=1689198950;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p8it7Lv2/nZ5IAyyTTUfkyPQztkID/BOuHs31KerV44=;
        b=eqzDAzfnmdWjyOQjBg0J7Qh6okN78Rllq0ZDizRvsEiQUw61IgcfVdVuzIqZz26E94
         0y5y5ciRzGAkCRsSVcbkt7v8l7EKgEYTWxwSnKqrK/s0ZeZXkO5lYmYXAwJAV74WiWY6
         GdR4OmQUy36fLSrnsQJTy1IqvNI95nKUcJZDZ/CQ4HTRUEGzuSBE0x89f9nevC7HYtLb
         O+Lxk7HY4QTgAVytXNC+7ap7tzgnPL4i534QKSRo47Eb0lUsjuqD2vbbqqU//C+C4xL4
         ya6nykMZbS9KIwSQ1gdOwqaZcQ+FzpvwrYfWzjoWcWfCPrhwXnc/NnBEVfdKO04wgt7H
         jc0g==
X-Gm-Message-State: ABy/qLZItw+EUVAUCFYySiCPXyeOG5p9OlFFuZWVbIdz/2HfJL0bK8C/
        Gg4Ybok7MdY+QNEhEpOmc9Z6pm4127EiOI/WoFCGlg87tGw167mXFb1yrljRqXT7nOXRHC34wPE
        yUYtsO+1k+D1Xv9G2hCjad50R
X-Received: by 2002:a05:622a:1007:b0:3fd:eb2f:8627 with SMTP id d7-20020a05622a100700b003fdeb2f8627mr139698qte.6.1688594150346;
        Wed, 05 Jul 2023 14:55:50 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFS1Zqb8dW+nnR0VfNrKnZqetvGlvmOAqFlQ2Rc3WjjU7RuXgl/GHphQfsW5FoHA6F+36rEYw==
X-Received: by 2002:a05:622a:1007:b0:3fd:eb2f:8627 with SMTP id d7-20020a05622a100700b003fdeb2f8627mr139676qte.6.1688594150076;
        Wed, 05 Jul 2023 14:55:50 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id ci7-20020a05622a260700b00401e22b9fcesm11824110qtb.53.2023.07.05.14.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 14:55:49 -0700 (PDT)
Date:   Wed, 5 Jul 2023 17:55:47 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        David Hildenbrand <david@redhat.com>,
        akpm@linux-foundation.org, jirislaby@kernel.org,
        jacobly.alt@gmail.com, holger@applied-asynchrony.com,
        hdegoede@redhat.com, michel@lespinasse.org, jglisse@google.com,
        mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org,
        mgorman@techsingularity.net, dave@stgolabs.net,
        liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, paulmck@kernel.org, mingo@redhat.com,
        will@kernel.org, luto@kernel.org, songliubraving@fb.com,
        dhowells@redhat.com, hughd@google.com, bigeasy@linutronix.de,
        kent.overstreet@linux.dev, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, peterjung1337@gmail.com, rientjes@google.com,
        chriscli@google.com, axelrasmussen@google.com, joelaf@google.com,
        minchan@google.com, rppt@kernel.org, jannh@google.com,
        shakeelb@google.com, tatashin@google.com, edumazet@google.com,
        gthelen@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 2/2] mm: disable CONFIG_PER_VMA_LOCK until its fixed
Message-ID: <ZKXm41CPurR20wYr@x1n>
References: <20230705171213.2843068-1-surenb@google.com>
 <20230705171213.2843068-3-surenb@google.com>
 <3cdaa7d4-1293-3806-05ce-6b7fc4382458@redhat.com>
 <CAJuCfpGTNF9BWBxZoqYKSDrtq=iJoN1n8oTc=Yu0pPzW8cs8rQ@mail.gmail.com>
 <ZKXRsQC8ufiebDGu@x1n>
 <ZKXgXFfrBzUjfkDN@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZKXgXFfrBzUjfkDN@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2023 at 10:27:56PM +0100, Matthew Wilcox wrote:
> On Wed, Jul 05, 2023 at 04:25:21PM -0400, Peter Xu wrote:
> > There'll still try to be a final fix, am I right?  As IIRC allowing page
> > faults during fork() is one of the major goals of vma lock.
> 
> Good grief, no.  Why would we want to optimise something that happens
> so rarely?  The goal is, as usual, more performance.  Satisfying page
> faults while mmap()/munmap()/mprotect() are happening is worthwhile.
> Those happen a lot more than fork().
> 
> In this case though, there's also a priority-inversion problem that
> we're trying to solve where process A (high priority) calls mmap() while
> process B (low priority) is reading /proc/$pid/smaps and now (because
> rwsems are fair), none of process A's other threads can satisy any page
> faults until process B is scheduled.

Is it possible to extend vma lock to things like smaps?

> 
> Where on earth did you get the idea that we cared even a little bit
> about the performance of page fault during fork()?

My memory, when I was talking to someone during the conference that
mentioned such a use case.  But my memory can be just wrong, in that case
it's my fault, but I hope it's still fine to just ask here.

-- 
Peter Xu

