Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3024067F164
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 23:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjA0Wvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 17:51:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjA0Wvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 17:51:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01BE7293
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 14:51:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 84ED961DD7
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 22:51:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D9C1C433D2;
        Fri, 27 Jan 2023 22:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1674859900;
        bh=IS6HJYpOFVi4CPNNzsDzDEh+FBChpu2Srs6gQMB3T7c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xdl9dDNiVfKw9plbtOCSZ3wgAXFIUPm0+vCYThT9kkVXydC3Lpt4rCbsKFSpmh5J6
         xhw22O9gnJ3RCXD8MMY2pf3uVqv2FVCAMMyU94nKeibSdmQ1nrUKmVGl402SKKokDs
         C4VaPgO8KEB+Pk7caieUiDgaDjEAhyGy9DYMnZ7o=
Date:   Fri, 27 Jan 2023 14:51:38 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@techsingularity.net,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        peterz@infradead.org, ldufour@linux.ibm.com, paulmck@kernel.org,
        mingo@redhat.com, will@kernel.org, luto@kernel.org,
        songliubraving@fb.com, peterx@redhat.com, david@redhat.com,
        dhowells@redhat.com, hughd@google.com, bigeasy@linutronix.de,
        kent.overstreet@linux.dev, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, peterjung1337@gmail.com, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        rppt@kernel.org, jannh@google.com, shakeelb@google.com,
        tatashin@google.com, edumazet@google.com, gthelen@google.com,
        gurua@google.com, arjunroy@google.com, soheil@google.com,
        leewalsh@google.com, posk@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v2 00/33] Per-VMA locks
Message-Id: <20230127145138.8cc44bf00ebf289dffec0975@linux-foundation.org>
In-Reply-To: <20230127194110.533103-1-surenb@google.com>
References: <20230127194110.533103-1-surenb@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Jan 2023 11:40:37 -0800 Suren Baghdasaryan <surenb@google.com> wrote:

> Per-vma locks idea that was discussed during SPF [1] discussion at LSF/MM
> last year [2], which concluded with suggestion that “a reader/writer
> semaphore could be put into the VMA itself; that would have the effect of
> using the VMA as a sort of range lock. There would still be contention at
> the VMA level, but it would be an improvement.” This patchset implements
> this suggested approach.

I think I'll await reviewer/tester input for a while.

> The patchset implements per-VMA locking only for anonymous pages which
> are not in swap and avoids userfaultfs as their implementation is more
> complex. Additional support for file-back page faults, swapped and user
> pages can be added incrementally.

This is a significant risk.  How can we be confident that these as yet
unimplemented parts are implementable and that the result will be good?

