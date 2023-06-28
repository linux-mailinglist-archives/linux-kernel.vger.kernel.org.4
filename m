Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E65D741730
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 19:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbjF1R2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 13:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232418AbjF1R1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 13:27:09 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C1E210E
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 10:27:01 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D2F9F1F8C2;
        Wed, 28 Jun 2023 17:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1687973219; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5oLZKi78HZk9icpAl8Mot2rDZMpqxuqacCyU/wDSgXo=;
        b=OCb8rIjolX3r+BNTR+0h0ewkRnzf+kpxSTtxz3q5GU5RTWtl4Lu9PRcoB1kqGvOazcU1Jg
        lGAgl5Nj9i+leQ6hpamnvWExckFiJvQYBUNWYO1VHvjl00UQXFHa8glTIaCYxIL7X9RDSK
        HgoCb34aD9s9TQwaY1K0vQX04sXxkAc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1687973219;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5oLZKi78HZk9icpAl8Mot2rDZMpqxuqacCyU/wDSgXo=;
        b=0sd9gm7+5oT/kZ5WHAQyKXtGQ6XEUTiIvCCFY4invVjeU0xhf5R8iZaoH9traQxOI6j+gS
        eWdQ5o/1xrtJj9Aw==
Received: from lion.mk-sys.cz (unknown [10.163.44.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C2DB02C141;
        Wed, 28 Jun 2023 17:26:59 +0000 (UTC)
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
        id A2565608BE; Wed, 28 Jun 2023 19:26:59 +0200 (CEST)
Date:   Wed, 28 Jun 2023 19:26:59 +0200
From:   Michal Kubecek <mkubecek@suse.cz>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: build failure after commit eb0481bbc4ce ("objtool: Fix
 reloc_hash size")
Message-ID: <20230628172659.6qwbswgz4ki24wyv@lion.mk-sys.cz>
References: <20230628115825.ahqejf5y4hgxhyqj@lion.mk-sys.cz>
 <20230628151654.zqwy5zsc2cymqghr@treble>
 <20230628154432.4drtq4pivlkkg6v2@lion.mk-sys.cz>
 <20230628160631.ryt4icjeck627efs@lion.mk-sys.cz>
 <20230628164554.womrvwq7chnjtva4@lion.mk-sys.cz>
 <20230628170530.derop5w2gtmgjeis@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628170530.derop5w2gtmgjeis@treble>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 10:05:30AM -0700, Josh Poimboeuf wrote:
> On Wed, Jun 28, 2023 at 06:45:54PM +0200, Michal Kubecek wrote:
> > On Wed, Jun 28, 2023 at 06:06:31PM +0200, Michal Kubecek wrote:
> > > On Wed, Jun 28, 2023 at 05:44:32PM +0200, Michal Kubecek wrote:
> > > > On Wed, Jun 28, 2023 at 08:16:54AM -0700, Josh Poimboeuf wrote:
> > > > > Interesting.  Can you add the below patch and also do:
> > > > > 
> > > > >   make net/ipv4/netfilter/iptable_nat.o OBJTOOL_ARGS="--stats"
> > > > > 
> > > > > and report the output?
> > > > 
> > > > With these, I get
> > > > 
> > > >     ...
> > > >       CC [M]  net/ipv4/netfilter/iptable_nat.o
> > > >     nr_sections: 40
> > > >     section_bits: 10
> > > >     nr_symbols: 41
> > > >     symbol_bits: 10
> > > >     mmap reloc: Invalid argument
> > > >     make[1]: Leaving directory '/srv/ram/kobj'
> > > 
> > > Not sure if it's of any use but I also tried to run it under strace and
> > > the failed mmap() call seems to be
> > > 
> > >   18761 mmap(NULL, 0, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = -1 EINVAL (Invalid argument)
> > > 
> > > Perhaps the problem could be that elf->num_relocs may be zero?
> > 
> > I added a printf() and got
> > 
> >   size = -4991471925827290382 = 0xbababababababaf2
> > 
> > for the elf_alloc_hash() invocation resulting in failed mmap().
> 
> Wut.  Can you share the .o file?

It is at http://www.mk-sys.cz/tmp/iptable_nat.o

I digged some more and my guess is that the problem is that
elf_open_read() does

	memset(elf, 0, offsetof(struct elf, sections));

but commit eb0481bbc4ce ("objtool: Fix reloc_hash size") added
num_relocs after sections so that it is not zeroed (0xbabababababababa
is probably some kind of poison).

So I tried

------------------------------------------------------------------------
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -84,8 +84,8 @@ struct elf {
 	bool changed;
 	char *name;
 	unsigned int num_files;
-	struct list_head sections;
 	unsigned long num_relocs;
+	struct list_head sections;
 
 	int symbol_bits;
 	int symbol_name_bits;
------------------------------------------------------------------------

and the build succeeds now. But I cannot say if it's enough.

Michal
