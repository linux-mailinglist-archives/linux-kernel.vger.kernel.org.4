Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AAAA6D82E0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 18:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238745AbjDEQEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 12:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238461AbjDEQEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 12:04:35 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0911C359D;
        Wed,  5 Apr 2023 09:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TTJqlOzBPX6Z6lfFHUBA0hntJ2NYe0aM0CZZgdoJKu8=; b=URtqACva/lTcYYiZuL1O+kwg1y
        QIrPTD0MuF3fUmsS/DKkTPr00LMG668SXNEFAA5HNBZnQr5CObVHs5Mayrjkhxnf/ZAY0dkuL5ZI7
        9gC86eZMhsdQ0UyfbEUa3/gCGwvwYp0rBBMTN1Ct94hqliLmowjZCYSawZCikgjLE7lpdQraexwPr
        Bg0VbchgJ3KWLoqEoTtBkcDKtQY++5jdKqaIUPLarmEBw20ri6/O51TSKqwqs5M41ndEKW2sOJhxe
        wz4xaKIzHHyn1mxRwZmyzZXVTohxvwbtjR+MoXNHI+MYdLwT2x1l+Iqu8IgtREM8F+hbwO/uNrQNv
        EU7x8Seg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pk5cZ-0053kr-12;
        Wed, 05 Apr 2023 16:04:27 +0000
Date:   Wed, 5 Apr 2023 09:04:27 -0700
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
Message-ID: <ZC2cC+I1KTyD8UcC@bombadil.infradead.org>
References: <20230405022702.753323-1-mcgrof@kernel.org>
 <20230405022702.753323-6-mcgrof@kernel.org>
 <CAHk-=whH+OsAY+9qLc9Hz+-W8u=dvD3NLWHemOQpZPcgZa52fA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whH+OsAY+9qLc9Hz+-W8u=dvD3NLWHemOQpZPcgZa52fA@mail.gmail.com>
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

On Wed, Apr 05, 2023 at 08:26:18AM -0700, Linus Torvalds wrote:
> So I realize why you use atomic64, but I really suspect you'd be
> better off with just the regular "atomic_long".

<-- snip --> 

> So something like
> 
>         debugfs_create_ulong(... &val->counter ..);
> 
> instead of
> 
>         debugfs_create_atomic64(... &val ..);
> 
> Hmm?

We already have debugfs_create_ulong(), it just uses unsigned long
with no atomic_long. I can just use that then.

  Luis
