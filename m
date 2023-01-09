Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE33E66339C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 22:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237789AbjAIV7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 16:59:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237709AbjAIV7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 16:59:21 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4395582
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 13:59:20 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673301558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lJsii4i71+hR/Zow3BBmUJvSKWIMnBCHJnVycxvMCzM=;
        b=xIQj6zSVzeqQxUTaQvalDfoNTQ453GHzjvIEJnNxiVZf0JtoTLmLxUj8M1e3A5RJhSUB9s
        C5Chc2nqMfxqqaje5+6s2bV6JvWq3SyhJFe6jYLoAL5cvSkM6TsVcun3zvSr0TRokvlVAy
        cTPQjneadv5SVL6Oxdjjzu+YLcq4d6NcTTpbMa8swohYbK6X84rZVpwdWlaAXqFlCmU3DS
        5cyqb2eKJMZfGbJjQx/w+qiBeYnwNAFlOt335DaN6HTIUPhKOqOGhXAXqxjhX8HjmGzNaW
        OiiEialLAL8ACh7/M0q9x/ODwG3+7WIKHYIZ4EFKB3GSndvukqekstQtgzNkgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673301558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lJsii4i71+hR/Zow3BBmUJvSKWIMnBCHJnVycxvMCzM=;
        b=MKTZ/bzP0Jfe2h+PAPjit+oxHv+LtBpRpU0Cs91Uel3zTGEWUnQt+tafNRIckgmGwf0ZxS
        CN5YNRNrn4x2E1DQ==
To:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCH] Revert "x86/apic/x2apic: Implement IPI shorthands support"
In-Reply-To: <Y6FJgh3fOYoF0wSV@MiWiFi-R3L-srv>
References: <Y6FJgh3fOYoF0wSV@MiWiFi-R3L-srv>
Date:   Mon, 09 Jan 2023 22:59:18 +0100
Message-ID: <87k01vjrnt.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20 2022 at 13:34, Baoquan He wrote:
> This reverts commit 43931d350f30c6cd8c2f498d54ef7d65750abc92.
>
> On kvm guest with 4 cpus deployed, when adding 'nr_cpus=2' to normal
> kernel's cmdline, and triggering crash to jump to kdump kernel, kdump
> kernel will stably hang. Reverting commit 43931d350f30 ("x86/apic/x2apic:
> Implement IPI shorthands support") can fix it.

Is there any output on the early console or hangs it silently?

If the latter, can you attach GDB to the guest and figure out where it
is stuck?

Thanks,

        tglx
