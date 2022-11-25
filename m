Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64FBA638498
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 08:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbiKYHmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 02:42:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiKYHlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 02:41:55 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D21D2ED7B
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 23:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Zzis5UDN8h+gESMdOCDNsOfc88INeSbXZd8ZdksPHl4=; b=q7ffsw9iM8P2p/4R635QzCu6YT
        CUXr3A6rd3jOtQsDiV+uSbn0bn8ox8+bjM7AsIhMQ4rtTAdXvpcQ3Q3n5EttAR60hL+814loVpMUc
        awUmp0ecx4ZErpDd+A36UDjRFEmbb1NdwloFpJpQeJ1gxQtZ5ZSOnhuy7vSEJZKCMn2XTcrPjKLAr
        J9sM2LDshIqIKVdj5lWNfE79a5F7bsSOCxVNZXy9boIIRjmLWbFfehJviefQEQZBN9MQSflGy/Zfc
        vDn9aYrECg6pAAKDFvw+0vFXzMFC/Zs7kv83F2bWi8ePZf43iOkwmEACmD+olu92fGAO1uqFmKUhX
        7+ANvH3g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oyTKs-004SG7-AR; Fri, 25 Nov 2022 07:41:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F1B8030041D;
        Fri, 25 Nov 2022 08:41:19 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CEC222029F897; Fri, 25 Nov 2022 08:41:19 +0100 (CET)
Date:   Fri, 25 Nov 2022 08:41:19 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Jinyang He <hejinyang@loongson.cn>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>
Subject: Re: [PATCH -tip] x86/kprobes: Handle removed INT3 in do_int3()
Message-ID: <Y4Bxnw1xev8r7gJY@hirez.programming.kicks-ass.net>
References: <166933854220.2683864.10006153553442313230.stgit@devnote3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166933854220.2683864.10006153553442313230.stgit@devnote3>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 25, 2022 at 10:09:02AM +0900, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Since x86 doesn't use stop_machine() to patch the kernel text,
> there is a small chance that the another CPU removes the INT3
> during do_int3(). In this case, if no INT3 notifier callbacks
> handled that, the kernel calls die() because of a stray INT3.

Please clarify; how would that happen? Should not everybody modifying
text take text_mutex ?
