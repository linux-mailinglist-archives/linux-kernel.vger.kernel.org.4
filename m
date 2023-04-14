Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83B606E294E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 19:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjDNRZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 13:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbjDNRZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 13:25:36 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F289B618C;
        Fri, 14 Apr 2023 10:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=J/6fKZJeiVQu9MpxQ2IzLW5njfnFTm8vpA4Cqb6je8s=; b=Nfmpo1Xz+ROfplpuPLDd/rZuP7
        tnbpDoKbH654bILM+4w++OLD+Rb44/gAhB5RstSVHJDja1+ji7D1SLE5z5eGgS7mWTzqtWtX7YRqX
        VPbJ908JpKdhJl8aP0PjEab7NT98TcciYwSPb1t7GXkEbALRGykckVZ/nL5yxgS7TZAZk80Lo4/Ci
        +XPM3T4J+skaklt3kjdXQ5voC2Y+DmO9Yk/5i5FmA7Ygv24i6kGlH/bYGF/iBN8Pns0a5BCG1c2Xj
        2i70Rw9gRjHL89v3GD5Vh65FsaXu47JAS6ikx2hKouoCOvzWSwj+euAfTLAkX9uG4Kdt0Zdtq9Nmy
        NL4lE/bA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pnNAZ-00AEdf-30;
        Fri, 14 Apr 2023 17:25:07 +0000
Date:   Fri, 14 Apr 2023 10:25:07 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Kees Cook <keescook@chromium.org>,
        Christoph Hellwig <hch@infradead.org>, david@redhat.com,
        patches@lists.linux.dev, linux-modules@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, pmladek@suse.com,
        petr.pavlu@suse.com, prarit@redhat.com,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        rafael@kernel.org
Cc:     christophe.leroy@csgroup.eu, tglx@linutronix.de,
        peterz@infradead.org, song@kernel.org, rppt@kernel.org,
        dave@stgolabs.net, willy@infradead.org, vbabka@suse.cz,
        mhocko@suse.com, dave.hansen@linux.intel.com,
        colin.i.king@gmail.com, jim.cromie@gmail.com,
        catalin.marinas@arm.com, jbaron@akamai.com,
        rick.p.edgecombe@intel.com
Subject: Re: [RFC 0/2] module: fix virtual memory wasted on finit_module()
Message-ID: <ZDmMc/95CulxNj4q@bombadil.infradead.org>
References: <20230414052840.1994456-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230414052840.1994456-1-mcgrof@kernel.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2023 at 10:28:38PM -0700, Luis Chamberlain wrote:
> At first I wondered if
> we could use file descriptor hints to just exlude users early on boot
> before SYSTEM_RUNNING. I couldn't find much, but if there are some ways
> to do that -- then the last patch can be simplified to do just that.
> The second patch proves essentially that we can just send -EBUSY to
> duplicate requests, at least for duplicate module loads and the world
> doesn't fall apart. It *would* solve the issue. The patch however
> borrows tons of the code from the first, and if we're realy going to
> rely on something like that we may as well share. But I'm hopeful that
> perhaps there are some jucier file descriptor tricks we can use to
> just make a file mutually exlusivive and introduce a new kread which
> lets finit_module() use that. The saving grace is that at least all
> finit_module() calls *wait*, contray to request_module() calls and so
> the solution can be much simpler.
> 
> The end result is 0 wasted virtual memory bytes.
> 
> Any ideas how not to make patch 2 suck as-is ?

The more I think about it, a file descriptor based approach would
have to loop over all tasks as we're not sure if userspace would
use the same thread and just fork requests or what. One would
then have to loop over all tasks and look for files that match the
same name. This approach is domain specific to internal kernel reads
and I am thinking now it is more appropriate.

Since this is a bootup issue for races with module loading what we
could do is just have say kernel_read_file_from_fd_excl() which
would just call a shared __kernel_read_file_from_fd(..., bool excl, ...)
and the kernel_read_file_from_fd() could just set that excl to false
while the new one sets it to true. Then finit_module() could just use
that.

  Luis
