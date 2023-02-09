Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F186D69059F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 11:48:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbjBIKs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 05:48:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjBIKrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 05:47:17 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D07D6F201;
        Thu,  9 Feb 2023 02:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YzYgqFxJF25KpnC1xRu8kFUkiOv0UOE6zamexDTt09Q=; b=Eo1tHCfmKgNE/9inu6jHNAlls1
        jy4Obkcolm+Ktn2JDSbDV1ybslx0+cQ9WrKoaSHuP3m4yLjzj2fQeJEaELjSp7XEmAoSoDd9GFk9S
        KpuXzm6R41kw700dG5qz2c8fRmSYMtLTZf4R45EnDNxMadSh8/akb4mg82DyAxCO18uaXm7+cAc45
        dIoaFM910VejhtJbgtt1mMyS6cQrD+YlHM63EJBtMUlB9GSdaFX0ad9y+NF6guW0rWoRKZVmoCaJz
        wurI/17YyucpPGKeWphpSsFMqWjx+9NCTlbW65DEGMn7M5wm0d7I9yHac5OfdMPn4As2ewtnaBOJ3
        S4a7YpFQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pQ4QM-007sfP-22;
        Thu, 09 Feb 2023 10:45:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9F3F33002BF;
        Thu,  9 Feb 2023 11:45:44 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 02458209F7529; Thu,  9 Feb 2023 11:45:43 +0100 (CET)
Date:   Thu, 9 Feb 2023 11:45:43 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH] tracing/selftests: Ignore __pfx_ symbols in kprobe test
Message-ID: <Y+TO1+k58kj2Z29t@hirez.programming.kicks-ass.net>
References: <20230207135147.5ce618d6@gandalf.local.home>
 <20230207135402.38f73bb6@gandalf.local.home>
 <Y+PkVD1+myADYns+@hirez.programming.kicks-ass.net>
 <20230208170304.388c1786@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230208170304.388c1786@gandalf.local.home>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 05:03:04PM -0500, Steven Rostedt wrote:
> On Wed, 8 Feb 2023 19:05:08 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > > This is assuming that kprobes can not be added on top of these. But another
> > > solution could be to have kprobes just pick the function the __pfx_ is for.
> > > Would that be a better solution?  
> > 
> > Simply refusing them is simplest. I don't see a compelling reason to
> > make this complicated.
> 
> OK, so you are good with the patch as is then?

Yeah, but given I've no idea about the whole test thing or .tc files I
didn't ack.
