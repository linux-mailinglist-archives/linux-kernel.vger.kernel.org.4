Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 307CC6D833A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 18:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233939AbjDEQMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 12:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231967AbjDEQLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 12:11:52 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46D110D8;
        Wed,  5 Apr 2023 09:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qldM/7DycK2kXcPvoSTAVSBVXOLKfEWimS0mzWEN0PA=; b=uKSk6Om2/NU3maf33acFrtO6gu
        OIv1XCwY94g5GkoS4nSdVHO+fLQ8yoVy+2oEIJb6Eo3G0IvV88q4ayMvjqIwIkhy9jUo/dDncVRnx
        u+FDJHTdt+0wDUVbp1CNAZyEQnlWJtPf53hY9zehTgyAL2CL1aYzhjezH39+RWlYzuamcLYNkzBMR
        gyC0cepCL3opJ5+N7WaQJlrqWASdTKBDzl5KN8gAS6OZC7+lIVrO3jC7sJmUwBmsmKsBcwZiQGM9M
        CK7UY2ggk7Q+b5T6z26zL9N5SsI2Z+tj3aiNuFML+3zLB2VD092PdAZgb5UWTSfuvpyP5ogr+yYpg
        FLUeMU/w==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pk5jQ-0054uI-1P;
        Wed, 05 Apr 2023 16:11:32 +0000
Date:   Wed, 5 Apr 2023 09:11:32 -0700
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
Message-ID: <ZC2dtI02ZIbjte2l@bombadil.infradead.org>
References: <20230405022702.753323-1-mcgrof@kernel.org>
 <20230405022702.753323-6-mcgrof@kernel.org>
 <CAHk-=whH+OsAY+9qLc9Hz+-W8u=dvD3NLWHemOQpZPcgZa52fA@mail.gmail.com>
 <ZC2cC+I1KTyD8UcC@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZC2cC+I1KTyD8UcC@bombadil.infradead.org>
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

On Wed, Apr 05, 2023 at 09:04:27AM -0700, Luis Chamberlain wrote:
> On Wed, Apr 05, 2023 at 08:26:18AM -0700, Linus Torvalds wrote:
> > So I realize why you use atomic64, but I really suspect you'd be
> > better off with just the regular "atomic_long".
> 
> <-- snip --> 
> 
> > So something like
> > 
> >         debugfs_create_ulong(... &val->counter ..);
> > 
> > instead of
> > 
> >         debugfs_create_atomic64(... &val ..);
> > 
> > Hmm?
> 
> We already have debugfs_create_ulong(), it just uses unsigned long
> with no atomic_long. I can just use that then.

Oh but I don't get the atomic incs, so we'd need debugfs_create_atomic_long_t().

  Luis
