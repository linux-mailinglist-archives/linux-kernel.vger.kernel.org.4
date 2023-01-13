Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE6DD66916A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 09:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240388AbjAMIo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 03:44:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239679AbjAMIok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 03:44:40 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5486B7D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 00:44:37 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 55A695FEF1;
        Fri, 13 Jan 2023 08:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1673599476; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t+Dhoicyzz2oSGw52Ch3AcQ9AMccyEhYs3mWOWg6nDQ=;
        b=kbN54ZF8hfI37eBqJvuqMwtgiFgB6MgRjswFus9R2GLCGrN7a/vICdUHtJjgDzGorIFsrQ
        leuiZDg/hguwIPALzLC+aYn19fNRBrxgE1HAf8fubfQ4HeItUae9gsTxoxK1UoyWuUe40X
        8BDKFZqjyc97z4LSmiGUuyzYRO2Kpag=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 25A122C141;
        Fri, 13 Jan 2023 08:44:36 +0000 (UTC)
Date:   Fri, 13 Jan 2023 09:44:35 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, "Erhard F ." <erhard_f@mailbox.org>,
        kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH] kallsyms: Fix scheduling with interrupts disabled in
 self-test
Message-ID: <Y8EZ8+MgMqzu4/7H@alley>
References: <20230112105426.1037325-1-npiggin@gmail.com>
 <Y8BQaw5tVzDjZ9Sz@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8BQaw5tVzDjZ9Sz@bombadil.infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2023-01-12 10:24:43, Luis Chamberlain wrote:
> On Thu, Jan 12, 2023 at 08:54:26PM +1000, Nicholas Piggin wrote:
> > kallsyms_on_each* may schedule so must not be called with interrupts
> > disabled. The iteration function could disable interrupts, but this
> > also changes lookup_symbol() to match the change to the other timing
> > code.
> > 
> > Reported-by: Erhard F. <erhard_f@mailbox.org>
> > Link: https://lore.kernel.org/all/bug-216902-206035@https.bugzilla.kernel.org%2F/
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > Link: https://lore.kernel.org/oe-lkp/202212251728.8d0872ff-oliver.sang@intel.com
> > Fixes: 30f3bb09778d ("kallsyms: Add self-test facility")
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> 
> Thanks Nicholas!
> 
> Petr had just suggested removing this aspect of the selftests, the performance
> test as its specific to the config, it doesn't run many times to get an
> average and odd things on a system can create different metrics. Zhen Lei
> had given up on fixing it and has a patch to instead remove this part of
> the selftest.
> 
> I still find value in keeping it, but Petr, would like your opinion on
> this fix, if we were to keep it.

I am fine with this fix.

It increases a risk of possible inaccuracy of the measured time.
It would count also time spent on unrelated interrupts and eventual
rescheduling.

Anyway, it is safe at least. I was against the previous attempts to
fix this problem because they might have caused problems for
the rest of the system.

Best Regards,
Petr
