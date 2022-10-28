Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03762611057
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 14:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiJ1MDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 08:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiJ1MDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 08:03:47 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340571D374E
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 05:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=82n6RBa9XoGODnQnRPQprS3ZGGcq4vGNRDRtnAIQpAo=; b=ZZa9sWqpWD4mk5ewernqXo0tZ7
        JDwneWcYgTU6S7HP4Pl8VVQ5/eVw8QH/z23oOG+DR+GY9yk1QbixPhXBUBrSYNbmPHPmGiJKTGVJD
        6eL3QKbayrf5zYd+Ws9Z/AZRBLBk8GDJRlLhYwEXOkqzepPEvM1lOrve4EX9PBnBBOPoymGXijBrw
        HbZFk3rpy1nO7ACSYfh5XFkhlHTJP/M8rYZHN6m1GX7wtcFnlCqAV5DuOFGnVFee0bpr8d9RApo6c
        dTA/IrSASCXEznfW7esYIIQzR2ACwUx9ONT7e7k4MChmMGe5uLNM5XKoRAk6P1p7ivLHYhU6I9IuN
        e3UJ4Iiw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ooO58-0076Ja-5d; Fri, 28 Oct 2022 12:03:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1528830035C;
        Fri, 28 Oct 2022 14:03:25 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E11C52C6CBA2E; Fri, 28 Oct 2022 14:03:24 +0200 (CEST)
Date:   Fri, 28 Oct 2022 14:03:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     David Laight <David.Laight@aculab.com>
Cc:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 0/4] x86/ibt: Implement FineIBT
Message-ID: <Y1vFDJ9UECgyAkDj@hirez.programming.kicks-ass.net>
References: <20221027092812.185993858@infradead.org>
 <322c0b333f0a4a60be2a89f0cdf7edde@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <322c0b333f0a4a60be2a89f0cdf7edde@AcuMS.aculab.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 11:01:08AM +0000, David Laight wrote:
> From: Peter Zijlstra
> > Sent: 27 October 2022 10:28
> > 
> > Hi all,
> > 
> > Updated FineIBT series; I've (hopefully) incorporated all feedback from last
> > time with the notable exception of the Kconfig CFI default -- I'm not sure we
> > want to add to the Kconfig space for this, also what would a distro do with it.
> > 
> > Anyway; please have a look, I'm hoping to merge this soonish so we can make the
> > next cycle.
> 
> Is there a test to ensure that modules are actually compiled
> with the required endbra, function prologue gap (etc).
> Having the module load fail is somewhat better than a crash.
> 
> It is almost certainly quite easy to generate an out of tree module that
> is missing all of those (even if compiled at the same time as the kernel).
> (Never mind issues with modules that contain binary blobs.)

There is not; it is always possible to load a 'malformed' module. We
have no sanity checking on modules. It is no different from any other
binary compatilibity issue; if you build a dud module, you get to keep
the pieces.
