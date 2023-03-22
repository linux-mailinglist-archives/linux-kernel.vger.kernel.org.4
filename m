Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44BC96C5AB4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 00:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbjCVXn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 19:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbjCVXnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 19:43:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C075031E0B;
        Wed, 22 Mar 2023 16:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=J8OoOjpB2nOX7ZmeYEDkMXx+SeBdKnEhP1gUiVZouMw=; b=rrj9l+bQV8+426DL9CGMVi4ozL
        fqvlcHfrMw9/mqKKRSdGOEWKTC2HhlOfVqQRjPVfFznB7w4wEvIDXT7mVA4RK+X0YPsfP7r8nsf/b
        0O/zlHV2DGMXdxpXqAZEWYEvbEBcQdvMwHK1KGcLLEuiMuezNOwGg1cvUCmH1eQ6D43BY0FmBMr0V
        CgBwb9RMz2ET0uQNI1CpxZvst3GlIYY5kZPBBrg8l9y8fWnkZmuXfdjvtxclp3WEEMXTFeNaEGo/4
        tUytcHOnXfKW8HggmuVoCzajhGEY+8iuDCMbN/aQzL5cg0YO0dsmGJD4gNo0YxG27lDa8vlRKKoLM
        A+YoJkmA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pf86E-000BpP-1n;
        Wed, 22 Mar 2023 23:42:34 +0000
Date:   Wed, 22 Mar 2023 16:42:34 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        pmladek@suse.com, david@redhat.com, petr.pavlu@suse.com,
        prarit@redhat.com
Cc:     christophe.leroy@csgroup.eu, song@kernel.org
Subject: Re: [PATCH 00/12] module: cleanup and call taints after is inserted
Message-ID: <ZBuSajbkt7Ylah2j@bombadil.infradead.org>
References: <20230319212746.1783033-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230319212746.1783033-1-mcgrof@kernel.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 19, 2023 at 02:27:34PM -0700, Luis Chamberlain wrote:
> After posting my first RFC for "module: avoid userspace pressure on unwanted
> allocations" [0] I ended up doing much more cleanup on the module loading path.
> One of the things that became evident while ensuring we do *less* work before
> kmalloc all the things we need for the final module is we are doing a lot of
> work before we even add a module onto our linked list, once its accepted for
> loading and running init. We even *taint* the kernel even before we accept
> a module. We also do some tainting after kernel loading.
> 
> This converges both to one point -- right as soon as we accept module
> into our linked list. That is, the module is valid as per our kernel
> config and we're ready to go. Most of this is just tidying code up. The
> biggest functional changes is under the patch "converge taint work together".
> 
> I'll post the other functional changes in two other patch sets. This is
> mostly cleanup, the next one is the new ELF checks / sanity / cleanup,
> and I'm waiting to hear back from David Hildenbrand on the worthiness of
> some clutches for allocation. That last part would go in the last patch
> series.
> 
> In this series I've dropped completely the idea of using aliasing since
> different modules can share the same alias, so using that to check if
> a module is already loaded turns out not to be useful in any way.
> 
> [0] https://lkml.kernel.org/r/20230311051712.4095040-1-mcgrof@kernel.org

I've taken these into modules-next for more testing. If folks spot
issues in them though let me know and I can yank them before the merge
window.

  Luis
