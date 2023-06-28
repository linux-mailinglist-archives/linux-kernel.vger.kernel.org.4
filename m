Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 230D47418E9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 21:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbjF1Tcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 15:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231839AbjF1Tch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 15:32:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2ACB10F0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 12:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Xn2BdDIsixleW0Us8abiaWOPBvctMAbH6QL8qcvYYmI=; b=kMIC4L0rPzyHuVRd2VVpyoPu+8
        /603BunLqW70Bl0e+owrJHLtvsmJ+GtWLgSEFWp0CaEgqm12nuQipeAM2ibxihyW7EXscbKa/s/Lp
        qlkHgyL3TU6LP/nB4nBQWT2jaio5KldYWqvY3FEwz4bHI6reEvOovkosDMq4UhhqyQwPsJ13qWrqt
        Lm7rKKe2p1aLaTRfdh+XfRc9Xy/uF5AZttHdciSLRTDt5lUzZKyLHuFf4iQehvAbn428MRJ1t7TFu
        YA/Ybz1O39a0Oic58SdEabutvK4/Ce6MZLwvvW2aDkiYX1L0vs/JtQ/taUl9XHqE1dFgpTpUAvDl9
        B4oFLurg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qEau0-00498Q-90; Wed, 28 Jun 2023 19:32:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 67F39300118;
        Wed, 28 Jun 2023 21:32:31 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 44C10214D80C4; Wed, 28 Jun 2023 21:32:31 +0200 (CEST)
Date:   Wed, 28 Jun 2023 21:32:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Michal Kubecek <mkubecek@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: build failure after commit eb0481bbc4ce ("objtool: Fix
 reloc_hash size")
Message-ID: <20230628193231.GX83892@hirez.programming.kicks-ass.net>
References: <20230628115825.ahqejf5y4hgxhyqj@lion.mk-sys.cz>
 <20230628151654.zqwy5zsc2cymqghr@treble>
 <20230628154432.4drtq4pivlkkg6v2@lion.mk-sys.cz>
 <20230628160631.ryt4icjeck627efs@lion.mk-sys.cz>
 <20230628164554.womrvwq7chnjtva4@lion.mk-sys.cz>
 <20230628170530.derop5w2gtmgjeis@treble>
 <20230628172659.6qwbswgz4ki24wyv@lion.mk-sys.cz>
 <20230628181019.cmgfbygxfvwamzur@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628181019.cmgfbygxfvwamzur@treble>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 11:10:19AM -0700, Josh Poimboeuf wrote:
> On Wed, Jun 28, 2023 at 07:26:59PM +0200, Michal Kubecek wrote:
> > I digged some more and my guess is that the problem is that
> > elf_open_read() does
> > 
> > 	memset(elf, 0, offsetof(struct elf, sections));
> > 
> > but commit eb0481bbc4ce ("objtool: Fix reloc_hash size") added
> > num_relocs after sections so that it is not zeroed (0xbabababababababa
> > is probably some kind of poison).
> 
> Argh, that memset() is subtle as heck.  Peter, why?!?

Well, at the time struct elf had a bunch of fairly large hash tables
embedded inside it. memset() on those was a significant performance fail
-- esp. since we called objtool on every .o file.

 struct elf {
   Elf *elf;
   GElf_Ehdr ehdr;
   int fd;
   char *name;
   struct list_head sections;
   DECLARE_HASHTABLE(symbol_hash, 20);
   DECLARE_HASHTABLE(symbol_name_hash, 20);
   DECLARE_HASHTABLE(section_hash, 16);
   DECLARE_HASHTABLE(section_name_hash, 16);
   DECLARE_HASHTABLE(rela_hash, 20);
 };

Those embedded hash-tables have gone away, but apparently someone forgot
about this thing :/

Yes, this can go, struct elf is no longer like that.
