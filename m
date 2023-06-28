Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67EA2741608
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 18:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbjF1QGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 12:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjF1QGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 12:06:35 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A9F2689
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 09:06:34 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D0A2E21845;
        Wed, 28 Jun 2023 16:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1687968391; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1wuA7yYIFtBsvM69F2jgWxuaa042Siq/wcHMKARW6sE=;
        b=dN6FJJWNEsXJ4wq/4JX2PS36QcmUDPmfq2YdNsQc14wOFF24EeH4mYgcLyA3Aeq8lbM89K
        jrdDRNgATM6N+tRuU2IclkXGFDm//5i9HJoQNIs3wug9gr4usQys+j5YpqeKh1NTY9Hcdm
        3zlAGYXi/edpfGAITEFl5qSRpaeRvTI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1687968391;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1wuA7yYIFtBsvM69F2jgWxuaa042Siq/wcHMKARW6sE=;
        b=pyfHGf6Cmgj7sJ1UvcSSzE5EE1NfOVVs4qZRfS7qqIiGaAv4hRbAqhHQzGkihLMgrJ3IgK
        HUvu0ywf78HIP5Bg==
Received: from lion.mk-sys.cz (unknown [10.163.44.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id BF1E52C36C;
        Wed, 28 Jun 2023 16:06:31 +0000 (UTC)
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
        id 99773608BE; Wed, 28 Jun 2023 18:06:31 +0200 (CEST)
Date:   Wed, 28 Jun 2023 18:06:31 +0200
From:   Michal Kubecek <mkubecek@suse.cz>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: build failure after commit eb0481bbc4ce ("objtool: Fix
 reloc_hash size")
Message-ID: <20230628160631.ryt4icjeck627efs@lion.mk-sys.cz>
References: <20230628115825.ahqejf5y4hgxhyqj@lion.mk-sys.cz>
 <20230628151654.zqwy5zsc2cymqghr@treble>
 <20230628154432.4drtq4pivlkkg6v2@lion.mk-sys.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628154432.4drtq4pivlkkg6v2@lion.mk-sys.cz>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 05:44:32PM +0200, Michal Kubecek wrote:
> On Wed, Jun 28, 2023 at 08:16:54AM -0700, Josh Poimboeuf wrote:
> > Interesting.  Can you add the below patch and also do:
> > 
> >   make net/ipv4/netfilter/iptable_nat.o OBJTOOL_ARGS="--stats"
> > 
> > and report the output?
> 
> With these, I get
> 
>     ...
>       CC [M]  net/ipv4/netfilter/iptable_nat.o
>     nr_sections: 40
>     section_bits: 10
>     nr_symbols: 41
>     symbol_bits: 10
>     mmap reloc: Invalid argument
>     make[1]: Leaving directory '/srv/ram/kobj'

Not sure if it's of any use but I also tried to run it under strace and
the failed mmap() call seems to be

  18761 mmap(NULL, 0, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = -1 EINVAL (Invalid argument)

Perhaps the problem could be that elf->num_relocs may be zero?

Michal
