Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C498690D35
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 16:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbjBIPlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 10:41:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbjBIPlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 10:41:18 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4A1213C
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 07:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7qd1w0TKhX+M0Vk+PQMBw6PVR4qHpk3EAM/2nlF2W+c=; b=j3YBH65Zb2rw9p8LQAoGgUpDmm
        07KOcLDK5Gsf31ROn7jSyZTdAdNeeyBEzmLgf17owYL6+bqgj9Qk53r8akDZ76mtZNuD/tTxLzJ9p
        EGiZx5pvIDKCges5DZl0tfzIsySGUBuhqvrUTIdT2+PsUFZlSa2KToQ6+pbjpUO1f/+eDstSg1kUX
        ivNo3CKbydEBm9klZ0/+JCxxCHe0eDtt8jJqqc7KjAEY3yqZVYAPx+e27rEY2sl5elAtOQxdayOVN
        hiBLlZM4psxd+mPRkK19bEa1idQU9uS5pYTeOTG0YBhXqCdOs164hF3fc0g9Tf+Ge4imzDbxzq2lI
        qrbc7XNg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pQ928-007x99-2I;
        Thu, 09 Feb 2023 15:40:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8F8AD30030B;
        Thu,  9 Feb 2023 16:41:02 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 78B9E2010F0F0; Thu,  9 Feb 2023 16:41:02 +0100 (CET)
Date:   Thu, 9 Feb 2023 16:41:02 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     x86@kernel.org, Nadav Amit <nadav.amit@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -tip] kprobes/x86: Remove unneeded casting from immediate
 value
Message-ID: <Y+UUDv33FAZz2KPz@hirez.programming.kicks-ass.net>
References: <167595699689.1303232.13460109151246012198.stgit@mhiramat.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167595699689.1303232.13460109151246012198.stgit@mhiramat.roam.corp.google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2023 at 12:36:36AM +0900, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Remove unneeded casting from immediate value assignments for relative
> jump offset. Since the immediate values in the 'insn' data structure are
> assigned from immediate bytes as a signed value to insn.immediate.value
> by insn_field_set(). Thus, if we need to access that value as a signed
> value (in this kprobe's case), we don't need to cast it.
> This is a kind of clean up (should not change behavior) follows Nadav's
> bugfix.
> 
> Link: https://lore.kernel.org/all/20230208071708.4048-1-namit@vmware.com/
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
