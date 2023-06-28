Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2C767416AB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 18:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjF1QqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 12:46:02 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:34286 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231597AbjF1Qpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 12:45:55 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 5A8E521855;
        Wed, 28 Jun 2023 16:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1687970754; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UHUGho7/Y5/5aYN0Kp0tNdcyjj8Xk/D+mqY5gIusWj4=;
        b=xAsUzyb4K7ZwBBC50Bl06X+PuMsCowkJljK1DwD6bYQ6J9MedO1zUAZg316abHY+GrE0DZ
        Dr2DJ9rbQYNxMhzLQfdKMnNtUBrFamsM+epLynbDTFRbflkhnex8z03TzFHSvSlsSEIlU/
        wd6RlhznyJcMi5IHONgqZuUSrY5a1KY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1687970754;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UHUGho7/Y5/5aYN0Kp0tNdcyjj8Xk/D+mqY5gIusWj4=;
        b=jAcEphK8qLgI0qsZhVZ9ZdseRHoAeSA22UkHeVa5CMvujk51yfduq41D3UfOLmgOUqNdGz
        YkPm+MYFFyq7MMDA==
Received: from lion.mk-sys.cz (unknown [10.163.44.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 474672C142;
        Wed, 28 Jun 2023 16:45:54 +0000 (UTC)
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
        id 2E45D608BE; Wed, 28 Jun 2023 18:45:54 +0200 (CEST)
Date:   Wed, 28 Jun 2023 18:45:54 +0200
From:   Michal Kubecek <mkubecek@suse.cz>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: build failure after commit eb0481bbc4ce ("objtool: Fix
 reloc_hash size")
Message-ID: <20230628164554.womrvwq7chnjtva4@lion.mk-sys.cz>
References: <20230628115825.ahqejf5y4hgxhyqj@lion.mk-sys.cz>
 <20230628151654.zqwy5zsc2cymqghr@treble>
 <20230628154432.4drtq4pivlkkg6v2@lion.mk-sys.cz>
 <20230628160631.ryt4icjeck627efs@lion.mk-sys.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628160631.ryt4icjeck627efs@lion.mk-sys.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 06:06:31PM +0200, Michal Kubecek wrote:
> On Wed, Jun 28, 2023 at 05:44:32PM +0200, Michal Kubecek wrote:
> > On Wed, Jun 28, 2023 at 08:16:54AM -0700, Josh Poimboeuf wrote:
> > > Interesting.  Can you add the below patch and also do:
> > > 
> > >   make net/ipv4/netfilter/iptable_nat.o OBJTOOL_ARGS="--stats"
> > > 
> > > and report the output?
> > 
> > With these, I get
> > 
> >     ...
> >       CC [M]  net/ipv4/netfilter/iptable_nat.o
> >     nr_sections: 40
> >     section_bits: 10
> >     nr_symbols: 41
> >     symbol_bits: 10
> >     mmap reloc: Invalid argument
> >     make[1]: Leaving directory '/srv/ram/kobj'
> 
> Not sure if it's of any use but I also tried to run it under strace and
> the failed mmap() call seems to be
> 
>   18761 mmap(NULL, 0, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = -1 EINVAL (Invalid argument)
> 
> Perhaps the problem could be that elf->num_relocs may be zero?

I added a printf() and got

  size = -4991471925827290382 = 0xbababababababaf2

for the elf_alloc_hash() invocation resulting in failed mmap().

Michal
