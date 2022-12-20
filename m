Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12788651FD2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 12:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232513AbiLTLjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 06:39:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiLTLjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 06:39:04 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427625F5E
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 03:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=t89MKrBwUBLS+ByzcZGzZZQEQJcYQVoYJCazuvi3KIQ=; b=EAe87txzRGIH62QagEKuf9gafY
        x965J8pybTHj1rp6tKY8G9ajKrYYFbG3HvN7WsDG7U61sApoWul5/WISscm0GoO4jK0XNyAnH1nC4
        3oIZ85eNPc/j2mSW+Fbm/1O9Im+FtlHNIizu7LMNQQ6QMIeKOafsReKYwdUIniMC1/BCdYFgJTsdZ
        OaTFDf5b8up5FSRNCSs1FSA0inFoQlbD6V2miDtEsND2LAQgZBpBohUKPy92lE6FT1WkrJIWODbAF
        sFrhCxHFrzdsawFQdaXbnY+d7VxoLG5VcHTUP+KlQOXmZky+C2KHJI2np255QxfjQQXnmc9HzTD2p
        pjxiN2Cg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p7axW-001kai-Jc; Tue, 20 Dec 2022 11:38:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 31E54300E86;
        Tue, 20 Dec 2022 12:38:47 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 12EAE20B0F896; Tue, 20 Dec 2022 12:38:47 +0100 (CET)
Date:   Tue, 20 Dec 2022 12:38:46 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        x86@kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCH] Revert "x86/apic/x2apic: Implement IPI shorthands
 support"
Message-ID: <Y6GextAcO4OZig3Y@hirez.programming.kicks-ass.net>
References: <Y6FJgh3fOYoF0wSV@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6FJgh3fOYoF0wSV@MiWiFi-R3L-srv>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 01:34:58PM +0800, Baoquan He wrote:
> This reverts commit 43931d350f30c6cd8c2f498d54ef7d65750abc92.
> 
> On kvm guest with 4 cpus deployed, when adding 'nr_cpus=2' to normal
> kernel's cmdline, and triggering crash to jump to kdump kernel, kdump
> kernel will stably hang. Reverting commit 43931d350f30 ("x86/apic/x2apic:
> Implement IPI shorthands support") can fix it.
> 
> The problem will disappear if removing 'nr_cpus=2' from normal kerne's
> cmdline.

And the root cause for this is... ? Does the kvm x2apic emulation
somehow get upset when we shorthand CPUs that haven't been initialized?
