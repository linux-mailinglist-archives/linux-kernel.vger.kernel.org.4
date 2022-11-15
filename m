Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 361C062A209
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 20:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbiKOTim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 14:38:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbiKOTij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 14:38:39 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF2EDE8D
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 11:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YjA/Ad/XxCVAlWu1iPIeT3IVaSA8C09QDHCG8r7fee0=; b=XjA7TarsVxzV99sbuNHH8kY/A7
        iG24UfHkxnZnkKHbHyGB8C1Kng1egEKviH4iKiRXW5lSjrJxFMKZ69/hosSY4Zy++gBE/AFCJdhSy
        kuYSmsrlWpx5Cj84lO/wkVh20MTxtbKP8KMadWr3TPfq1Y+f9dDfmPyZU7G4mnPKlIun2Zv8koUPX
        96k9XuXameTjMqOCdz2emhRsIReUHYNLffZBm9zJx2eaefVe8dIbE660V5hBIOrNCJmOUT27UgMXF
        v5n+axW3SPk1a1maD5p3m/Hh8SKvspIFWAd4UY5s2/8OCiGLjqvTaV9Wfk4EgpmJySStq+9KMJQx1
        y4rO7t5A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ov1lM-0015NK-Vv; Tue, 15 Nov 2022 19:38:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9AE6B30115B;
        Tue, 15 Nov 2022 19:45:03 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 859EB20C99E5C; Tue, 15 Nov 2022 19:45:03 +0100 (CET)
Date:   Tue, 15 Nov 2022 19:45:03 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: CET shadow stack app compatibility
Message-ID: <Y3PeLxWstXnMlB1u@hirez.programming.kicks-ass.net>
References: <7d8133c7e0186bdaeb3893c1c808148dc0d11945.camel@intel.com>
 <Y3NfX0zXDIZztwKL@hirez.programming.kicks-ass.net>
 <883ed1a3f4de8d508c4bc2f504ae4a5c8db19a20.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <883ed1a3f4de8d508c4bc2f504ae4a5c8db19a20.camel@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 05:04:40PM +0000, Edgecombe, Rick P wrote:
> > ELF bits should not, must not, be called CET. API, not CET, Compiler
> > features, also not CET.
> 
> So the arch_prctl()s can't be shared between shadow stack and IBT? They
> don't have to be, but this is a new thing after a fair amount of
> earlier discussion.

I would very strongly suggest IBT not use that interface and instead we
follow ARM64 BTI's lead -- such that application developers don't go
insane trying to use two nearly identical solutions.

I mean, the toolchain folks made a godawefull mess of things, but we
don't have to.
