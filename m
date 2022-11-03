Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37024617904
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 09:46:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbiKCIqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 04:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiKCIqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 04:46:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A1765E9
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 01:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oAqvFyQrajNwHbafj8fvIr3muUNPcNRav0TRZTTSIk8=; b=X+7has0oFSb6giM000j7OHQhdU
        PCoXtZYtForGNRH94B5/H/1KXG31otH6VwwtdkWbyLAjlFojAC/auquDESERab2VSbvnFv7IF+ekv
        YIMpusB+L4XUPogzVnfXFItfqERKjqmYrXROPw5mC6ZLhDhBclSX9t/EGJN9HQFq7Wj0dpbrRnb9l
        fxqy0wKZD7vI7pOWxXEeFm9pPQZB4tHWx6zp2Tqx3hRB8hp//M2LPOpte2anZ+VzLvVE5APDyobki
        m/eX8xTG2m09GiH2ngiGsb5+LaVUVtPZlgq/7/Z44V26hpoc50R9vMgH+VZIQva0Ot8N8I61Rt97b
        KazyevXA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oqVrb-006JXn-HX; Thu, 03 Nov 2022 08:46:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 99B0F3003E1;
        Thu,  3 Nov 2022 09:46:09 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7D09A203E2FCB; Thu,  3 Nov 2022 09:46:09 +0100 (CET)
Date:   Thu, 3 Nov 2022 09:46:09 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, djwong@kernel.org,
        yujie.liu@intel.com, tglx@linutronix.de, joao.moreira@intel.com,
        samitolvanen@google.com
Subject: Re: [PATCH 3/5] objtool: Avoid O(bloody terrible) behaviour -- an
 ode to libelf
Message-ID: <Y2N/0YarDv6yeuuw@hirez.programming.kicks-ass.net>
References: <20221028194022.388521751@infradead.org>
 <20221028194453.461658986@infradead.org>
 <20221102222222.r4xkj6uynlj6n2t6@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102222222.r4xkj6uynlj6n2t6@treble>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 03:22:22PM -0700, Josh Poimboeuf wrote:
> On Fri, Oct 28, 2022 at 09:40:25PM +0200, Peter Zijlstra wrote:
> > Due to how gelf_update_sym*() requires an Elf_Data pointer, and how
> > libelf keeps Elf_Data in a linked list per section,
> > elf_update_symbol() ends up having to iterate this list on each
> > update to find the correct Elf_Data for the index'ed symbol.
> > 
> > By allocating one Elf_Data per new symbol, the list grows per new
> > symbol, giving an effective O(n^2) insertion time. This is obviously
> > bloody terrible.
> > 
> > Therefore over-allocate the Elf_Data when an extention is needed.
> > Except it turns out libelf disregards Elf_Scn::sh_size in favour of
> > the sum of Elf_Data::d_size. IOW it will happily write out all the
> > unused space and fill it with:
> > 
> >   0000000000000000     0 NOTYPE  LOCAL  DEFAULT  UND
> > 
> > entries (aka zeros). Which obviously violates the STB_LOCAL placement
> > rule, and is a general pain in the backside for not being the desired
> > behaviour.
> > 
> > Manually fix-up the Elf_Data size to avoid this problem before calling
> > elf_update().
> > 
> > This significantly improves performance when adding a significant
> > number of symbols.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> Instead of going through libelf to add each symbol, and
> adjusting/shifting/reallocating the d_buf one symbol at a time, it would
> probably be a lot easier (and faster) to just manually do all that at
> the end, just before writing the file.

Yeah, I've been >< close to doing that at least twice now. The only
consideration is that we then also must rewrite all relocs but I think
we end up doing that anyway.

I'll go do the patch to see what it looks like.
