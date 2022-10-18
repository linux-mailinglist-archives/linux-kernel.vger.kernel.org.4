Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9506B602F11
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 17:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbiJRPA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 11:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbiJRPAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 11:00:50 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A368B8C29
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 08:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=d1DPVHkTn4Pqqx1MLW607HRc8S0dQBAmdHgZ0c3/CNM=; b=P8CW7Cd/plk67zCr9b68PDFgRx
        +6vsS3zvvmlKhhvfNk84UgxsLHZtuPKsmWbW+5iHI8hJg1fq0WpWjmzvVRqm8BSCmwMrRTlsxJtpI
        D3wuappA63vya2JCuQTGfQMZvl/zpwwPeGQfpT5wl7xO2qfxgZgCf3Lv5TFyzPAzYaYnj2Fdb2e3W
        HLf7g9g703YQW/cY0ZvDjUVMDJwd+p0oQhE31dP1eVcZy3ic09FqPQrlRlft6O9FIxLZiqKxe2/gB
        SwzrKSVMacGyxzkpwpyCWJEGU+6ZZULkwvMbJ+bDlSL6jF827nGZWAD+SVGX2OoydCpD/T3Lk/Rq6
        4FkWybKA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oko54-004Vou-8n; Tue, 18 Oct 2022 15:00:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2E866300431;
        Tue, 18 Oct 2022 17:00:33 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 15930299DA318; Tue, 18 Oct 2022 17:00:33 +0200 (CEST)
Date:   Tue, 18 Oct 2022 17:00:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kees Cook <kees.cook@linux.dev>
Cc:     Steven Rostedt <rostedt@goodmis.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>
Subject: Re: [PATCH] ftrace,kcfi: Separate ftrace_stub() and
 ftrace_stub_graph()
Message-ID: <Y06/kaxqvcl/QZqj@hirez.programming.kicks-ass.net>
References: <Y06dg4e1xF6JTdQq@hirez.programming.kicks-ass.net>
 <Y06ntk9uY5re23WX@hirez.programming.kicks-ass.net>
 <A41EBE43-40FE-482A-A795-B4A4F63C345C@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A41EBE43-40FE-482A-A795-B4A4F63C345C@linux.dev>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 07:28:29AM -0700, Kees Cook wrote:

> Thanks for solving this! Just for future archeology, can you include
> the splat (I assume you hit a CFI splat) in the commit log, and/or how
> you triggered the problem? I usually find it helpful in trying to fix
> similar issues later, etc.

Unfortunately I didn't save it; it was a while ago (I sorta lost track
of this fix for a while since it was stuffed in my fineibt queue).

But Mark ran it today to confirm on arm64 and there it looks like
(harvested from IRC):

  [    3.153082] CFI failure at ftrace_return_to_handler+0xac/0x16c (target: ftrace_stub+0x0/0x14; expected type: 0x0a5d5347)

I think simply enabling the ftrace boot time tests is enough to trigger
this.
