Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A907A6BD9F8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 21:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjCPUPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 16:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjCPUPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 16:15:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9390DE20C9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 13:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uumsoE6D078n3Znb9lWlQ23wdndeL/MyNVNgOHTci4k=; b=UCErDsgcv7bKm/5iSSe5MimD6y
        b9BkntdBeNrc8Mc/5IZJXQmszCddZBvuYVzu4SKjicMbUA+NNk1RRLBP4Gdr2SnNrKNHAPkJkY01l
        pH4n90Alv8BmD4xRvnUo6MS0wM/fMR2nYDQvH7YqkmZyt+l8cui10VDNGXcyIw1q2buP4ugFN1LVj
        zx3mmof/zWL30x14FQRo7AESd4BYxJdCuo1ZluPDY1QCELsXbakI5jsniUIdHP8JsEIuG7YeEF7kz
        SEP2Fm0eYexrICINiYJpG88qZFHsE7jeeavZh2M/htZrjZ76qvMq1xcvRizHsVGPLacF5cCZJrEnd
        OJwQZaEQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pctzU-00F9Gl-4M; Thu, 16 Mar 2023 20:14:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C6DC8300328;
        Thu, 16 Mar 2023 21:14:21 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9C754212FCF5C; Thu, 16 Mar 2023 21:14:21 +0100 (CET)
Date:   Thu, 16 Mar 2023 21:14:21 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        virtualization@lists.linux-foundation.org,
        "Srivatsa S. Bhat (VMware)" <srivatsa@csail.mit.edu>,
        Alexey Makhalov <amakhalov@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86/paravirt: convert simple paravirt functions to asm
Message-ID: <20230316201421.GA2060174@hirez.programming.kicks-ass.net>
References: <20230308154210.18454-1-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230308154210.18454-1-jgross@suse.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2023 at 04:42:10PM +0100, Juergen Gross wrote:

> +DEFINE_PARAVIRT_ASM(pv_native_irq_disable, "cli", .text);
> +DEFINE_PARAVIRT_ASM(pv_native_irq_enable, "sti", .text);
> +DEFINE_PARAVIRT_ASM(pv_native_read_cr2, "mov %cr2, %rax", .text);

per these v, the above ^ should be in .noinstr.text

> -static noinstr unsigned long pv_native_read_cr2(void)
> -static noinstr void pv_native_irq_enable(void)
> -static noinstr void pv_native_irq_disable(void)


