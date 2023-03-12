Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB136B6B21
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 21:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbjCLUk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 16:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjCLUk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 16:40:26 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF8C2ED4B
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 13:40:25 -0700 (PDT)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 006811EC04DA;
        Sun, 12 Mar 2023 21:40:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1678653624;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=1Lrqu4LRvKP7UFQjIdn9jCcw9clEWFV3ZS/ersQxOTo=;
        b=EE1/GH1Ft+WR75tY116V3VDZlwhiQrJehE9Mqmqdb8/WHmpRHACcMJkOcp4PbtGP0Cwptt
        6GXwlHIMav1vg3LETk+PZs+3VjwqeH+zi3vRmEw3Z2u+58/fyyHkH0XHS+WU3ReVNidZd2
        28NxIBJ2Iw9h2+pPe+2ZPzksI0rwRDM=
Date:   Sun, 12 Mar 2023 21:40:19 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Saurabh Sengar <ssengar@linux.microsoft.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, johan+linaro@kernel.org,
        isaku.yamahata@intel.com, mikelley@microsoft.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/ioapic: Don't return 0 as valid virq
Message-ID: <20230312204019.GBZA44s28AOAfAcRuy@fat_crate.local>
References: <1677785686-2152-1-git-send-email-ssengar@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1677785686-2152-1-git-send-email-ssengar@linux.microsoft.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2023 at 11:34:46AM -0800, Saurabh Sengar wrote:
> Zero is invalid virq and should't be returned as a valid value for
> lower irq bound. If IO-APIC and gsi_top are not initialized return

Why isn't gsi_top initialized?

What is this fixing?

Don't be afraid to do

git annotate arch/x86/kernel/apic/io_apic.c

and see which commit added this. This one:

3e5bedc2c258 ("x86/apic: Fix arch_dynirq_lower_bound() bug for DT enabled machines")

Now add the folks from this commit to Cc and tell them why in your case
gsi_top is not initialized and what they're breaking by doing that.

The more your commit message explains *why* you're fixing something, the
better it is for the maintainers/reviewers to actually know what to do.

Right now I'm reading this and I'm thinking, random, unjustified change.
Ignore.

Ok?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
