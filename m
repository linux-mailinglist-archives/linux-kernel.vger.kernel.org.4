Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26D6F70B7BA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 10:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232298AbjEVIfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 04:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbjEVIfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 04:35:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EBDDB0;
        Mon, 22 May 2023 01:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=m31uO0f8F/ozSNGIQ728G+whj+ekxuEhuW+7zVs2Fno=; b=NZOyxWu48JCyy9CSgR+tK5vU4n
        Yrf+NFRMDntJNcJ5IqzbOl2WEQWUIqo/hUhCe5zcqD1SCeZG82nmBOaO4kQMejxfh3MjMO1hmsWqN
        dc8M52FSi1UDDz0vW6ek1Msq0vKgqmU5eFCDuTrU1S0npl/heWLFyojPHwqNxBzuxJlKSrAQFq4wl
        ZHN4ajm4zRpVCPN9ZmHehpDPHs0EzvaCoGGN6NhWdPyFUmyu23NQPKJlt/TWOpe9HSH3yQtl4rDmR
        d3rET2Tn17QeiGQIZdWpGn+4bRKGnQeDKTcMo114idvASOMq19VoyQ4VZ60d8J2atMSbeRFeoNGfA
        DtciWq8g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q110N-008vMV-Gv; Mon, 22 May 2023 08:35:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 67AF330003A;
        Mon, 22 May 2023 10:34:58 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4C89D20564757; Mon, 22 May 2023 10:34:58 +0200 (CEST)
Date:   Mon, 22 May 2023 10:34:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Coly Li <colyli@suse.de>
Cc:     linux-tip-commits@vger.kernel.org,
        Kent Overstreet <kent.overstreet@linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        "Coly Li <colyli@suse.de>" <colyli@suse.de>, x86@kernel.org
Subject: Re: [tip: locking/core] bcache: Convert to lock_cmp_fn
Message-ID: <20230522083458.GM83892@hirez.programming.kicks-ass.net>
References: <20230509195847.1745548-2-kent.overstreet@linux.dev>
 <168457974565.404.16611061652498882569.tip-bot2@tip-bot2>
 <1FBFDA28-6886-4315-A942-88F3542CE244@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1FBFDA28-6886-4315-A942-88F3542CE244@suse.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 21, 2023 at 09:21:36PM +0800, Coly Li wrote:
> 
> 
> > 2023年5月20日 18:49，tip-bot2 for Kent Overstreet <tip-bot2@linutronix.de> 写道：
> > 
> > The following commit has been merged into the locking/core branch of tip:
> > 
> > Commit-ID:     0ad397b556936a14052aa65d8fa958a9f3175add
> > Gitweb:        https://git.kernel.org/tip/0ad397b556936a14052aa65d8fa958a9f3175add
> > Author:        Kent Overstreet <kent.overstreet@linux.dev>
> > AuthorDate:    Tue, 09 May 2023 15:58:47 -04:00
> > Committer:     Peter Zijlstra <peterz@infradead.org>
> > CommitterDate: Fri, 19 May 2023 12:35:10 +02:00
> > 
> > bcache: Convert to lock_cmp_fn
> > 
> > Replace one of bcache's lockdep_set_novalidate_class() usage with the
> > newly introduced custom lock nesting annotation.
> > 
> > [peterz: changelog]
> > Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Acked-by: Coly Li <colyli@suse.de <mailto:colyli@suse.de>>
> 
> 
> Can the above “<mailto:colyli@suse.de>” be removed from my acked-by. This was automatically and invisibly added by MacOS email client, which just introduced chaos in such use case.
> 
> Thanks.

Urgh, something I should add to my script on a rainy day I suppose.

I'll have to rebase the tree, but I suppose I can do that. Let me go see
if I can remember the git incantations required.
