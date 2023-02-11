Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F561692C54
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 01:56:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjBKA4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 19:56:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjBKA4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 19:56:52 -0500
Received: from out-44.mta1.migadu.com (out-44.mta1.migadu.com [95.215.58.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02931AD25
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 16:56:49 -0800 (PST)
Date:   Sat, 11 Feb 2023 00:56:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1676077007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CrZl5vUkAt4FS0BIHrg6dSLC9PKKZUVgtPkff++aKKU=;
        b=M1D3ha5CpjqEi4ic9S6kXv9kvH72O9KzzXQJ8BAclbXVM2fDAcqmCAbQQqwNH6Jj5Q49Uw
        m5guz0uEjl6e11QaufMuPnfdnybi7Mw43vV+cqZgSjuMEurSuF5xzYdx0ObOdogNKfMD0X
        c/NPsYkeY17ZQurvX9sBlCysJ7JcXPQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Oliver Upton <oliver.upton@linux.dev>
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: Circular lockdep in kvm_reset_vcpu() ?
Message-ID: <Y+bnybGEkMpZzm/y@linux.dev>
References: <f6452cdd-65ff-34b8-bab0-5c06416da5f6@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6452cdd-65ff-34b8-bab0-5c06416da5f6@arm.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeremy,

On Fri, Feb 10, 2023 at 11:46:36AM -0600, Jeremy Linton wrote:
> Hi,
> 
> I saw this pop yesterday:

You and me both actually! Shame on me, I spoke off-list about this with
Marc in passing. Thanks for sending along the report.

> [   78.333360] ======================================================
> [   78.339541] WARNING: possible circular locking dependency detected
> [   78.345721] 6.2.0-rc7+ #19 Not tainted
> [   78.349470] ------------------------------------------------------
> [   78.355647] qemu-system-aar/859 is trying to acquire lock:
> [   78.361130] ffff5aa69269eba0 (&host_kvm->lock){+.+.}-{3:3}, at:
> kvm_reset_vcpu+0x34/0x274
> [   78.369344]
> [   78.369344] but task is already holding lock:
> [   78.375182] ffff5aa68768c0b8 (&vcpu->mutex){+.+.}-{3:3}, at:
> kvm_vcpu_ioctl+0x8c/0xba0

[...]

> It appears to be triggered by the new commit 42a90008f890a ('KVM: Ensure
> lockdep knows about kvm->lock vs. vcpu->mutex ordering rule') which is
> detecting the vcpu lock grabbed by kvm_vcpu_ioctl() and then the kvm mutext
> grabbed by kvm_reset_vcpu().

Right, this commit gave lockdep what it needed to smack us on the head
for getting the locking wrong in the arm64 side.

As gross as it might be, the right direction is likely to have our own
lock in kvm_arch that we can acquire while holding the vcpu mutex. I'll
throw a patch at the list once I get done testing it.

-- 
Thanks,
Oliver
