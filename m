Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B33B37416EE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 19:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbjF1RFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 13:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbjF1RFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 13:05:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F6C1BE4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 10:05:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E02946137F
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 17:05:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2060EC433C0;
        Wed, 28 Jun 2023 17:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687971932;
        bh=mNG2phQkDSi2Z55SBPtVSXzhKFAaIQvHo2PEEehdbmo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GQMP5mnmICxnr3/RzvVZpvtaVhIFXKl4rF98My1i7fStrM+rDcRKYZGvEhV0fSyDL
         j2xzDYK3xaQpzAj4eBld+c1Rhu3qmxBt/rcKtQCWbPQhM0SZ8EwSpWulaXrSB8nS7H
         XMj+FTpRAmKnRRsPsDltJi9k7Bp4Z7I+6FitmSa2hTleOXK/yY4/+OGbcR01xTR6W5
         fcNP3SpwhLfnpQabkybMPHwjbGJM46BX1WhzvStrZodkK5s+RHL+FLtE+vFEl/aUA2
         uE8wdJBJ74gCb2vyFUvJjPE5Bdf7Jn+278rSHupftt835HHmWOJdTP/EAaxFB7Bz6g
         XJHn72G7TuEDw==
Date:   Wed, 28 Jun 2023 10:05:30 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: build failure after commit eb0481bbc4ce ("objtool: Fix
 reloc_hash size")
Message-ID: <20230628170530.derop5w2gtmgjeis@treble>
References: <20230628115825.ahqejf5y4hgxhyqj@lion.mk-sys.cz>
 <20230628151654.zqwy5zsc2cymqghr@treble>
 <20230628154432.4drtq4pivlkkg6v2@lion.mk-sys.cz>
 <20230628160631.ryt4icjeck627efs@lion.mk-sys.cz>
 <20230628164554.womrvwq7chnjtva4@lion.mk-sys.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230628164554.womrvwq7chnjtva4@lion.mk-sys.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 06:45:54PM +0200, Michal Kubecek wrote:
> On Wed, Jun 28, 2023 at 06:06:31PM +0200, Michal Kubecek wrote:
> > On Wed, Jun 28, 2023 at 05:44:32PM +0200, Michal Kubecek wrote:
> > > On Wed, Jun 28, 2023 at 08:16:54AM -0700, Josh Poimboeuf wrote:
> > > > Interesting.  Can you add the below patch and also do:
> > > > 
> > > >   make net/ipv4/netfilter/iptable_nat.o OBJTOOL_ARGS="--stats"
> > > > 
> > > > and report the output?
> > > 
> > > With these, I get
> > > 
> > >     ...
> > >       CC [M]  net/ipv4/netfilter/iptable_nat.o
> > >     nr_sections: 40
> > >     section_bits: 10
> > >     nr_symbols: 41
> > >     symbol_bits: 10
> > >     mmap reloc: Invalid argument
> > >     make[1]: Leaving directory '/srv/ram/kobj'
> > 
> > Not sure if it's of any use but I also tried to run it under strace and
> > the failed mmap() call seems to be
> > 
> >   18761 mmap(NULL, 0, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = -1 EINVAL (Invalid argument)
> > 
> > Perhaps the problem could be that elf->num_relocs may be zero?
> 
> I added a printf() and got
> 
>   size = -4991471925827290382 = 0xbababababababaf2
> 
> for the elf_alloc_hash() invocation resulting in failed mmap().

Wut.  Can you share the .o file?

-- 
Josh
