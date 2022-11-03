Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A48361790F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 09:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbiKCItk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 04:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbiKCItg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 04:49:36 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03355C763
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 01:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=RkNBU0hMoTYlB2liiWMqN64OIbK7z1nAKBDJNEYxYl8=; b=kIRzdGpp5IiM+w+fgoLf251UIs
        Ww3hqVs5vMpGY8H1WlW6kLu1T9HRaH9Dr1/Kb5i7hTP8gZNWod4xJebC2ZpOBFzk4zCxuKbbh6bcf
        WzIb6eTvtNwlcOhE15rcDxptNYLqlQenlkw9+TfFe6KqyaI9RDwxBcHiyln1cClH6kzRT2jYPtHZZ
        5SOaY1X7Z72tH+8YcywB48rRypL1f9lpfP+R/uJxnA2WxVTYSlUIAcaFpLTCaAnb+J5q6qe1DDJpZ
        bIBqyMVcx5gc1w2hnQ2Q4yyZSOcBKTE+aoPmoOzgeXKOQEANprZCBehgGQ1hWYqF2WWWmw9Ijf2R8
        avXk5oqw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oqVuB-008dfK-G1; Thu, 03 Nov 2022 08:48:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2FE5A300130;
        Thu,  3 Nov 2022 09:48:53 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0BA4E20AB8864; Thu,  3 Nov 2022 09:48:53 +0100 (CET)
Date:   Thu, 3 Nov 2022 09:48:52 +0100
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
Subject: Re: [PATCH v5 02/16] powerpc: Override __ALIGN and __ALIGN_STR macros
Message-ID: <Y2OAdHBIGXVnN5Ud@hirez.programming.kicks-ass.net>
References: <20221028143346.183569-1-sv@linux.ibm.com>
 <20221028143346.183569-3-sv@linux.ibm.com>
 <327c371a-a8f4-1676-3da8-f454612b5c58@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <327c371a-a8f4-1676-3da8-f454612b5c58@csgroup.eu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 12:35:07PM +0000, Christophe Leroy wrote:
> 
> 
> Le 28/10/2022 à 16:33, Sathvika Vasireddy a écrit :
> > In a subsequent patch, we would want to annotate powerpc assembly functions
> > with SYM_FUNC_START_LOCAL macro. This macro depends on __ALIGN macro.
> > 
> > The default expansion of __ALIGN macro is:
> >          #define __ALIGN      .align 4,0x90
> > 
> > So, override __ALIGN and __ALIGN_STR macros to use the same alignment as
> > that of the existing _GLOBAL macro. Also, do not pad with 0x90, because
> > repeated 0x90s are not a nop or trap on powerpc.
> 
> By the way, do we know what the instruction 0x90909090 is on powerpc ? 
> Is that something valid or not ?

Please also look at the version that's in tip/x86/core (and next). This
stuff should be gone now.

include/linux/linkage.h now reads like:

#ifndef __ALIGN
#define __ALIGN                 .balign CONFIG_FUNCTION_ALIGNMENT
#define __ALIGN_STR             __stringify(__ALIGN)
#endif
