Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47B4C67D129
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 17:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232606AbjAZQTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 11:19:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232646AbjAZQSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 11:18:44 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620F5233FD
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 08:18:43 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id c124so2555822ybb.13
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 08:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vvEyqxPpR8M4BC65XVopg/XEu9SCivMiAr3QBDUWiyU=;
        b=H348+fayL/o7ZK4OMOl0X4WP2eMya1R6g3s71mVa0DA8XCsYAD7Mno2OaEE7NA0CmO
         e4033coOL787sHvi/S6s9OFvGkRHoLaUuJ1duFsKOvl5kj/wYF8+5cRX76ijn0+r9mVN
         /MK6vYc4x8jCg28wjYXYjcmydOgZp19VGDCnfGGlA3w2bC3Yw6+bgXPCcc6kwlaa/Dld
         Xkvgt3oautRKkhJGYhlwnO6TvcpaegDMiJu4G7chvMyMJzFUHGEi5AWj6fisELCIR8Mt
         LiDJG1ULptGXP+W67GIwNcq68sjgGTmxbYOeP0BP5KnuDIfe/tA0SCD/oII/g1WHFURW
         dp6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vvEyqxPpR8M4BC65XVopg/XEu9SCivMiAr3QBDUWiyU=;
        b=NrKyNLH4tQpLBbNMBDAohDhcLS/MKSl/dj/ZQyYb4vpdJI4RVu7yqn35TWFvcDJko7
         zP5i5ctb+FXJLx1da/WUmxC4EzWWOEMZM4KrwIk3HNXlVnoPBFpoopscqdIC7a3TWcUM
         Owg3j+XDSrUlQz7Ku5uexiNMrxhmm12Pzo4TntFKWgI+M1pzmu6FvPdxcQTaNzbSW41i
         4VQsdQkkmkPxfEsRSgZUDEcGKTIGBdliWRNj90d4X8XHrb1C5Dl6AZX+2mvi3ulng/KF
         DVoNibj3tYImX6m4r4JolauiaDwQ7XdLoGAvHLMEY9A4ICwYfFMBG127frU6dXgag82Y
         3PZA==
X-Gm-Message-State: AO0yUKXkiM2a+ZXbyl2QkODOW4xF/7sYvIgqHfsxXizVY/N5t2JMzd1V
        H86LVmM41ZJwfkxaKV7h8PHGTXNfrhgtKBro7BUg/w==
X-Google-Smtp-Source: AK7set9P+5mtUtKJMZFiPeuyZhPr8TwEdg7FU3uDJVhz4F2UDpdSR6q0zVgkPPrpoaJxmCX2P+Pz2XDq0fuB0xLwifk=
X-Received: by 2002:a25:6811:0:b0:80b:c92b:ed7c with SMTP id
 d17-20020a256811000000b0080bc92bed7cmr466120ybc.593.1674749922312; Thu, 26
 Jan 2023 08:18:42 -0800 (PST)
MIME-Version: 1.0
References: <20230125233554.153109-1-surenb@google.com> <20230125233554.153109-7-surenb@google.com>
 <20230126154740.j3a3lu4x557c56yi@techsingularity.net>
In-Reply-To: <20230126154740.j3a3lu4x557c56yi@techsingularity.net>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 26 Jan 2023 08:18:31 -0800
Message-ID: <CAJuCfpHP6hQAWZr2exZEXOzLbMNU_c9qNNc7pa2NYAhYLe=EKQ@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] mm: introduce mod_vm_flags_nolock and use it in untrack_pfn
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     akpm@linux-foundation.org, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, dave@stgolabs.net, willy@infradead.org,
        liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, paulmck@kernel.org, mingo@redhat.com,
        will@kernel.org, luto@kernel.org, songliubraving@fb.com,
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

On Thu, Jan 26, 2023 at 7:47 AM Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Wed, Jan 25, 2023 at 03:35:53PM -0800, Suren Baghdasaryan wrote:
> > In cases when VMA flags are modified after VMA was isolated and mmap_lock
> > was downgraded, flags modifications would result in an assertion because
> > mmap write lock is not held.
>
> Add note that it's also used during exit when the locking of the VMAs
> becomes irrelevant (mm users is 0, should be no VMA modifications taking
> place other than zap).

Ack.

>
> The typical naming pattern when a caller either knows it holds the necessary
> lock or knows it does not matter is __mod_vm_flags()

Ok. It sounds less explicit but plenty of examples, so I'm fine with
such rename. Will apply in the next version.

>
> > Introduce mod_vm_flags_nolock to be used in such situation, when VMA is
> > not part of VMA tree and locking it is not required.
>
> Instead of such situations, describe in as "used when the caller takes
> responsibility for the required locking".

Ack.

>
> > Pass a hint to untrack_pfn to conditionally use mod_vm_flags_nolock for
> > flags modification and to avoid assertion.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>
> Patch itself looks ok. It strays close to being "conditional locking"
> though which might attract some complaints.

The description seems to accurately describe what's done here but I'm
open to better suggestions.
Thanks!

>
> --
> Mel Gorman
> SUSE Labs
