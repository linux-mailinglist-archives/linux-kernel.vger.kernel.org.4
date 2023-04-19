Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2376E718D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 05:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbjDSDYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 23:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjDSDYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 23:24:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9914D2;
        Tue, 18 Apr 2023 20:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=Y0jC6pG5iyPnBukJ2foYlHjpDWbyen476EaJAQv4Kk0=; b=Fh61qubkIA4NQ/t+TuAGmvG6/Z
        8ae3FW5/kyHKxUStAxLa7mpvkzLtwMNYgJQbnpb+2CAPczsqmR4FOhqqXBgjrj3RsvK6cBbn2Z23m
        y1eMdPe58ajYGb7XwBpgtdn2A0zmspDoqqDjOG9EbGqZzF0c2i0KcZMghhQK1Rnk3/CMPeBof4m/8
        PNA4p/h1AHaAGp0lUFAhoFL0Uyxc8DKnpiw1DPdsayJ4imPlaJRwJ2XRbzFpJFCymq5GNcX8nyqlY
        882ux3LVtdcusDvul2SLTD2YkUiZ6PGrENVpWkanrH7HMAJKUBMiU2CalsAYoac+84Z/fgVGzFWyd
        9PPgBDkQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1poyQm-00CvFm-U9; Wed, 19 Apr 2023 03:24:28 +0000
Date:   Wed, 19 Apr 2023 04:24:28 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Joe Mario <jmario@redhat.com>,
        Barry Marson <bmarson@redhat.com>,
        Rafael Aquini <aquini@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH] mm/mmap: Map MAP_STACK to VM_STACK
Message-ID: <ZD9e7A4gaZ6qkGhy@casper.infradead.org>
References: <20230418210230.3495922-1-longman@redhat.com>
 <20230418141852.75e551e57e97f4b522957c5c@linux-foundation.org>
 <6c3c68b1-c4d4-dd82-58e8-f7013fb6c8e5@redhat.com>
 <cffc7454-614-1939-f235-7b139dc46b41@google.com>
 <22aee5ea-dd6b-ac2b-0b28-a25ee6602b48@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <22aee5ea-dd6b-ac2b-0b28-a25ee6602b48@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 09:45:34PM -0400, Waiman Long wrote:
> 
> On 4/18/23 21:36, Hugh Dickins wrote:
> > On Tue, 18 Apr 2023, Waiman Long wrote:
> > > On 4/18/23 17:18, Andrew Morton wrote:
> > > > On Tue, 18 Apr 2023 17:02:30 -0400 Waiman Long <longman@redhat.com> wrote:
> > > > 
> > > > > One of the flags of mmap(2) is MAP_STACK to request a memory segment
> > > > > suitable for a process or thread stack. The kernel currently ignores
> > > > > this flags. Glibc uses MAP_STACK when mmapping a thread stack. However,
> > > > > selinux has an execstack check in selinux_file_mprotect() which disallows
> > > > > a stack VMA to be made executable.
> > > > > 
> > > > > Since MAP_STACK is a noop, it is possible for a stack VMA to be merged
> > > > > with an adjacent anonymous VMA. With that merging, using mprotect(2)
> > > > > to change a part of the merged anonymous VMA to make it executable may
> > > > > fail. This can lead to sporadic failure of applications that need to
> > > > > make those changes.
> > > > "Sporadic failure of applications" sounds quite serious.  Can you
> > > > provide more details?
> > > The problem boils down to the fact that it is possible for user code to mmap a
> > > region of memory and then for the kernel to merge the VMA for that memory with
> > > the VMA for one of the application's thread stacks. This is causing random
> > > SEGVs with one of our large customer application.
> > > 
> > > At a high level, this is what's happening:
> > > 
> > >   1) App runs creating lots of threads.
> > >   2) It mmap's 256K pages of anonymous memory.
> > >   3) It writes executable code to that memory.
> > >   4) It calls mprotect() with PROT_EXEC on that memory so
> > >      it can subsequently execute the code.
> > > 
> > > The above mprotect() will fail if the mmap'd region's VMA gets merged with the
> > > VMA for one of the thread stacks.  That's because the default RHEL SELinux
> > > policy is to not allow executable stacks.
> > Then wouldn't the bug be at the SELinux end?  VMAs may have been merged
> > already, but the mprotect() with PROT_EXEC of the good non-stack range
> > will then split that area off from the stack again - maybe the SELinux
> > check does not understand that must happen?
> 
> The SELinux check is done per VMA, not a region within a VMA. After VMA
> merging, SELinux is probably not able to determine which part of a VMA is a
> stack unless we keep that information somewhere and provide an API for
> SELinux to query. That can be quite a lot of work. So the easiest way to
> prevent this problem is to avoid merging a stack VMA with a regular
> anonymous VMA.

To paraphrase you, "Yes, SELinux is buggy, but we don't want to fix it".

Cc'ing the SELinux people so it can be fixed properly.
