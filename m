Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB85618A2F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 22:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiKCVGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 17:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiKCVG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 17:06:28 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481C126E0
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 14:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KOL4f93sZFqwUQJ2tEZqUOqeObdUym0cD67POeXVsgg=; b=SNbNBE3WX1ZPZ8kU/LCKmx5kl8
        ujdUG6wwS4F3TdJX3qBJre/xBxiwNfePLp6nrh7FJE10PgcT6ixPI73C/UegN3NYo5FFNh4yi1c2g
        MgZWoemSa2cFfxsOnMTXXKdE+anM0qRaMhLIA+FlOOoXsxKlDON6R4Hze5J1vpdDEqGKSVbcuvtbM
        8U1K+fyAzO7yhpMghW0mVdWRi4+o7PkhJzXivA4m4h6xRC2CTKJ6WXzzlGlUTkzT935qgLjJKeTv1
        5oz5KHYpPufF+xYJLK1njHqUlR1suKEnzTg8DsmnVdN8Dx10gzdAnYeiS3qHJ5zVG3vTroNGWCifz
        yUmvShig==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oqhPc-008mUe-AL; Thu, 03 Nov 2022 21:06:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C8E47300137;
        Thu,  3 Nov 2022 22:06:05 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id ACB65205BD11D; Thu,  3 Nov 2022 22:06:05 +0100 (CET)
Date:   Thu, 3 Nov 2022 22:06:05 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Uros Bizjak <ubizjak@gmail.com>, x86@kernel.org,
        willy@infradead.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        aarcange@redhat.com, kirill.shutemov@linux.intel.com,
        jroedel@suse.de
Subject: Re: [PATCH 11/13] x86_64: Remove pointless set_64bit() usage
Message-ID: <Y2QtPe5fmFpWQoZ4@hirez.programming.kicks-ass.net>
References: <20221022111403.531902164@infradead.org>
 <20221022114425.168036718@infradead.org>
 <Y2QR/BRHjjYUNszh@dev-arch.thelio-3990X>
 <CAFULd4bkn3i0ds1ywhxAZBQH+1O-zbPWscUqjoEcv4xvnxOnSw@mail.gmail.com>
 <Y2QYHZsZNs33NXZB@dev-arch.thelio-3990X>
 <CAHk-=wjCBOwSWec+=h08q3Gbr4UjSfX46GrQjzHZLFokziS7nA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjCBOwSWec+=h08q3Gbr4UjSfX46GrQjzHZLFokziS7nA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 01:39:17PM -0700, Linus Torvalds wrote:
> On Thu, Nov 3, 2022 at 12:36 PM Nathan Chancellor <nathan@kernel.org> wrote:
> >
> > Thanks, I also realized that only a couple minutes after I sent my
> > initial message. I just got done testing the following diff, which
> > resolves my issue.
> 
> That looks obviously correct.

I'll force-push tip/x86/mm with the fix from Nathan and I'll try and
look into the rest of the trainwreck tomorrow with the brain awake --
after I figure out that other fail Nathan reported :/

Sorry for breaking all your machines Nate.
