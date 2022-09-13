Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA88A5B6E35
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 15:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbiIMNRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 09:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232294AbiIMNQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 09:16:29 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1911D1276A
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 06:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HxCe9N2ZPr/5kCwic9CoLe8DjVEylSYlBt3jF6Yv8Fg=; b=Zd//mRqGShzJlFQxc6viPN+bIw
        kbZezimhUR3BjYgIkXV6eQcAOXQKJIeSbcBMLodKuMgyEHsA12CxrVYSUiKwy96TGXF87SetMBnQU
        ad0kfKMW2qywRdTrsOP/x0TX99WEPu5XngPrP4oqFMDDXUajGueV6vNhr46lDHpzVaam6f9nnGCzJ
        yxobQy5BhxW2Fz5ylxWcmgi3fmm+Kc9dWrTPUrR37Ub8rmscjivgoPCdcACXrxWqiABaaIaedUqpJ
        rBJ0htLB0LG9V1WHhCip0bYTJIsthMuhu5jP0Bdn+SukC0dF72bKKQt2QKk8qM0jLuvbep3UiViGf
        we/3HZBQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oY5l5-00C5UN-Tf; Tue, 13 Sep 2022 13:15:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6CA993002AE;
        Tue, 13 Sep 2022 15:15:20 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3D49F2027D6A2; Tue, 13 Sep 2022 15:15:20 +0200 (CEST)
Date:   Tue, 13 Sep 2022 15:15:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Sathvika Vasireddy <sv@linux.ibm.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "aik@ozlabs.ru" <aik@ozlabs.ru>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mbenes@suse.cz" <mbenes@suse.cz>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "chenzhongjin@huawei.com" <chenzhongjin@huawei.com>,
        "naveen.n.rao@linux.vnet.ibm.com" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 02/16] powerpc: Override __ALIGN and __ALIGN_STR macros
Message-ID: <YyCCaPzVi3Yv0tFB@hirez.programming.kicks-ass.net>
References: <20220912082020.226755-1-sv@linux.ibm.com>
 <20220912082020.226755-3-sv@linux.ibm.com>
 <YyBxqjtC0DAhmQrT@hirez.programming.kicks-ass.net>
 <8480c380-2eb9-4eff-ceb4-f8bbcb425149@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8480c380-2eb9-4eff-ceb4-f8bbcb425149@csgroup.eu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2022 at 12:21:51PM +0000, Christophe Leroy wrote:

> > Like mentioned last time; I'm fixing this (but you're right to not wait
> > on that), that said, would it make sense to write it like:
> > 
> > #define __ALIGN		.balign 4
> > #define __ALIGN_STR	__stringify(__ALIGN)
> 
> By the way, I commented to Sathvika to not use __stringify() in order to 
> avoid having to include stringify.h as we are trying to minimise 
> dependencies between headers.
> 
> Several other architectures also do it that way.

stringify.h is a trivial header and included by linux/linkage.h before
it includes asm/linkage.

Anyway, I was thinking of having:

#ifndef __ALIGN_STR
#define __ALIGN_STR __stringify(__ALIGN)
#endif

in linux/linkage.h, that avoids having to duplicate this all over the
place.
