Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F34136D8422
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 18:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233284AbjDEQxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 12:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjDEQxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 12:53:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A971DE41;
        Wed,  5 Apr 2023 09:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=ibm+nWW7IW9tcDE0xVaQziVWYwGIW9klab1GLTkBWA8=; b=Vszq9Sjag0KovbFyUMSIcdP524
        sx4GTfSXPdQPMNeFs+3wFwwWnKOBYkz+C33wureTGP8x88exBW5FHohne8bJGpScLFtLp+RPI5CaN
        Kut8dzMCf0y59hZNjJCXQcOfUrizMO5bph1jpdXdhCsYgNeG7L0oozB3WVaomOOpdtose9ebh6BBV
        fOQmoxAnQliQsozhiVBeZzU6VmXbABZUOT9nbGZ08aCmcCEOJpsAvzfRbwfnnJiQ1ly6XCTacLdSn
        OWB3x2K7tk6m8/9LJIfUd/ucqlolkGqzUHepQBIe9h5b0nfy3tUUQ6cGA/xrcngBZohsJkwiuFqVa
        Pg1Ne22w==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pk6Na-005BOz-1J;
        Wed, 05 Apr 2023 16:53:02 +0000
Date:   Wed, 5 Apr 2023 09:53:02 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     david@redhat.com, patches@lists.linux.dev,
        linux-modules@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pmladek@suse.com,
        petr.pavlu@suse.com, prarit@redhat.com, gregkh@linuxfoundation.org,
        rafael@kernel.org, christophe.leroy@csgroup.eu, tglx@linutronix.de,
        peterz@infradead.org, song@kernel.org, rppt@kernel.org,
        dave@stgolabs.net, willy@infradead.org, vbabka@suse.cz,
        mhocko@suse.com, dave.hansen@linux.intel.com,
        colin.i.king@gmail.com, jim.cromie@gmail.com,
        catalin.marinas@arm.com, jbaron@akamai.com,
        rick.p.edgecombe@intel.com
Subject: Re: [PATCH v2 5/6] debugfs: add debugfs_create_atomic64_t for
 atomic64_t
Message-ID: <ZC2nbiarELlUVcSj@bombadil.infradead.org>
References: <20230405022702.753323-1-mcgrof@kernel.org>
 <20230405022702.753323-6-mcgrof@kernel.org>
 <CAHk-=whH+OsAY+9qLc9Hz+-W8u=dvD3NLWHemOQpZPcgZa52fA@mail.gmail.com>
 <ZC2cC+I1KTyD8UcC@bombadil.infradead.org>
 <ZC2dtI02ZIbjte2l@bombadil.infradead.org>
 <CAHk-=wiGhHk4u2RRZmJinA4Apb47pXXJPW9cOZ_2-yUqOvaC7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wiGhHk4u2RRZmJinA4Apb47pXXJPW9cOZ_2-yUqOvaC7Q@mail.gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 05, 2023 at 09:23:09AM -0700, Linus Torvalds wrote:
> On Wed, Apr 5, 2023 at 9:11 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >
> > Oh but I don't get the atomic incs, so we'd need debugfs_create_atomic_long_t().
> 
>   debugfs_create_ulong("total_mod_size",
>        0400, mod_debugfs_root,
>        &total_mod_size.counter);
> 
> but I didn't actually try to compile that kind of version.
> 
> (I think "counter" is actually a _signed_ long, so maybe the types don't match).

I see yes, sadly we'd have to cast to (unsigned long *) to make that
work as atomic_long counters are long long int:

   debugfs_create_ulong("total_mod_size",
        0400, mod_debugfs_root,
-        &total_mod_size.counter);
+        (unsigned long *)&total_mod_size.counter);

That's:

unsigned long min bits 32
long long     min bits 64

But since we'd be doing our accounting in atomic_long and just use
debugfs for prints I think that's fine. Just a bit ugly.

  Luis
