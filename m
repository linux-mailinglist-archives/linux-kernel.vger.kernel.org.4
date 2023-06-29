Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4CD742BF4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 20:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233929AbjF2SfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 14:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232902AbjF2SeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 14:34:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF1F1719;
        Thu, 29 Jun 2023 11:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=8G2XND6WYYBgieuCNXQSJ0h8yM1THsepfLIyxBzOQdM=; b=aEGaXNVYMMI9ZJt0oeCDZ/svCc
        exHWLiuPiysn9Ks+cpi3DZ0bmBihjeD6UviXcMmED95/uIQexzmrUsT6URaqJxmwGPhEfSfN10JU2
        vtqXW3boponYUK8F66mpxozNHAPMLFh5fSS5ctUaWPG71ptmqXYI1MjMWeaXPenxEapadwkQ3423W
        lMTDwe+8SgXWyR2aJNBeOulLYVSjjF/ywhBxoHzRHxDio0UWamQch2p7hwhXOtUYBR2FHuC9J4zjd
        oNw24Mpswj9X1UqbXTc30lJCwFib7tZPcak83APHLqU+siC8/MSa0rFZIadFLzUxy8lDtOLqmgg3l
        Xn51G4Lw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qEwT2-0054UW-Tl; Thu, 29 Jun 2023 18:34:08 +0000
Date:   Thu, 29 Jun 2023 19:34:08 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Matt Whitlock <kernel@mattwhitlock.name>,
        David Howells <dhowells@redhat.com>, netdev@vger.kernel.org,
        Dave Chinner <david@fromorbit.com>,
        Jens Axboe <axboe@kernel.dk>, linux-fsdevel@kvack.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/4] splice: Fix corruption in data spliced to pipe
Message-ID: <ZJ3OoCcSxZzzgUur@casper.infradead.org>
References: <20230629155433.4170837-1-dhowells@redhat.com>
 <CAHk-=wiDwfyj0CCupT-oEToqsNLcbsTQdcgDupF=ZETUjJQJtQ@mail.gmail.com>
 <4bd92932-c9d2-4cc8-b730-24c749087e39@mattwhitlock.name>
 <CAHk-=whYWEUU69nY6k4j1_EQnQDNPy4TqAMvpf1UA111UDdmYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=whYWEUU69nY6k4j1_EQnQDNPy4TqAMvpf1UA111UDdmYg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2023 at 11:19:36AM -0700, Linus Torvalds wrote:
> On Thu, 29 Jun 2023 at 11:05, Matt Whitlock <kernel@mattwhitlock.name> wrote:
> >
> > I don't know why SPLICE_F_MOVE is being ignored in this thread. Sure, maybe
> > the way it has historically been implemented was only relevant when the
> > input FD is a pipe, but that's not what the man page implies. You have the
> > opportunity to make it actually do what it says on the tin.
> 
> First off, when documentation and reality disagree, it's the
> documentation that is garbage.
> 
> Secondly, your point is literally moot, from what I can tell:
> 
>        SPLICE_F_MOVE
>               Unused for vmsplice(); see splice(2).
> 
> that's the doc I see right now for "man vmsplice".
> 
> There's no "implies" there. There's an actual big honking clear
> statement at the top of the man-page saying that what you claim is
> simply not even remotely true.
> 
> Also, the reason SPLICE_F_MOVE is unused for vmsplice() is that
> actually trying to move pages would involve having to *remove* them
> from the VM source. And the TLB invalidation involved with that is
> literally more expensive than the memory copy would be.

I think David muddied the waters by talking about vmsplice().  The
problem encountered is with splice() from the page cache.  Reading
the documentation,

       splice()  moves  data  between two file descriptors without copying be‐
       tween kernel address space and user address space.  It transfers up  to
       len bytes of data from the file descriptor fd_in to the file descriptor
       fd_out, where one of the file descriptors must refer to a pipe.

The bug reported is actually with using FALLOC_FL_PUNCH_HOLE, but a
simpler problem is:

#define _GNU_SOURCE
#include <unistd.h>
#include <fcntl.h>
#include <stdio.h>

#define PAGE_SIZE 4096

int main(int argc, char **argv)
{
        int fd = open(argv[1], O_RDWR | O_CREAT, 0644);

        err = ftruncate(fd, PAGE_SIZE);
        pwrite(fd, "old", 3, 0);
        splice(fd, NULL, 1, NULL, PAGE_SIZE, 0);
        pwrite(fd, "new", 3, 0);

        return 0;
}

That outputs "new".  Should it?  If so, the manpage is really wrong.
It says the point of splice() is to remove the kernel-user-kernel copy,
and notes that zerocopy might be happening, but that's an optimisation
the user shouldn't notice.
