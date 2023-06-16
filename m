Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22E61733CD8
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 01:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344566AbjFPXWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 19:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233846AbjFPXWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 19:22:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C521B5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 16:22:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D84162919
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 23:22:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D26F9C433C8;
        Fri, 16 Jun 2023 23:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1686957723;
        bh=8PoaaNogsT637+v6ZJe4En4gUwxV3uGkPUoRKIM4K7o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=apqKcKSirGitS5wrV/f6xskgZzdE9iWJoI2ALlCc2trdzfZJk4ShMl/w1IwUILzmN
         SBTeyEZfndOVGaZOlwsL2c0Le97/6w0EUqKjpNB9+CYK1i0/jRm57nPFbrtHY3Efs/
         kXXgOjFnQxAfAtwgSMQUPQZZ8Javl0fWi2htrN0s=
Date:   Fri, 16 Jun 2023 16:22:02 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Howells <dhowells@redhat.com>
Cc:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] afs: Fix waiting for writeback then skipping folio
Message-Id: <20230616162202.f46e1279d6b638406fd0eecd@linux-foundation.org>
In-Reply-To: <702179.1686955382@warthog.procyon.org.uk>
References: <20230608175031.9c534e7f554de89e3d972ab2@linux-foundation.org>
        <20230607204120.89416-1-vishal.moola@gmail.com>
        <20230607204120.89416-2-vishal.moola@gmail.com>
        <702179.1686955382@warthog.procyon.org.uk>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Jun 2023 23:43:02 +0100 David Howells <dhowells@redhat.com> wrote:

> Andrew Morton <akpm@linux-foundation.org> wrote:
> 
> > > Commit acc8d8588cb7 converted afs_writepages_region() to write back a
> > > folio batch. The function waits for writeback to a folio, but then
> > > proceeds to the rest of the batch without trying to write that folio
> > > again. This patch fixes has it attempt to write the folio again.
> > > 
> > > This has only been compile tested.
> > 
> > This seems fairly serious?
> 
> We will try to write the again later, but sync()/fsync() might now have
> skipped it.
> 
> > From my reading, we'll fail to write out the dirty data.  Presumably
> > not easily observable, as it will get written out again later on.
> 
> As it's a network filesystem, interactions with third parties could cause
> apparent corruption.  Closing a file will flush it - but if there's a
> simultaneous op of some other kind, a bit of a flush or a sync may get missed
> and the copy visible to another user be temporarily missing that bit.
> 
> > But we're also calling afs_write_back_from_locked_folio() with an unlocked
> > folio, which might cause mayhem.
> 
> Without this patch, you mean?  There's a "continue" statement that should send
> us back to the top of the loop before we get as far as
> afs_write_back_from_locked_folio() - and then the folio_unlock() there would
> go bang.
> 

Well, what I'm really asking is the thing I ask seven times a day:

- what are the end-user visible effects of the bug

- should be fix be backported into earlier kernels
