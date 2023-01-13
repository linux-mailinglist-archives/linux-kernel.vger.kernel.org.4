Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC0266A6C6
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 00:13:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbjAMXNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 18:13:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbjAMXN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 18:13:29 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA4460859
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 15:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jUziRo06S+js26H0jEpikXECL+w+QlE/tWgpvgKsJA8=; b=WK7iL3YGO+YC4BSfnnwIJipBHy
        L/yPKa4Wr0ZWL0FxqZ4DMXCmcSA834QgpGSqZtyLNYRZA8jivE9DJxUqyBuG9l4FM5zI6xtv2K3SI
        rGHWNJJ33ufC97ZdHQKV2ujRZncan0nEeksdy/S5mv3orNTlVOFAy9t/FgGEdlKFFU3n+Xvk28Toq
        rzD/lU9k8vnuHybnkfompq2/ms5KQwcWJCKfQfj0ee/TlfJUWgTWTUP5s8QRS+KVgKhCr7ZL/ArAx
        qLjUSsDiJljaYfakgu8WFdxQapJOQdKNQgK2pP/4Vygvmp6gN/lrfIXRIgEwqfL7KWC84G9cAFvPK
        9EArjXew==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pGTEN-004nM8-VM; Fri, 13 Jan 2023 23:13:03 +0000
Date:   Fri, 13 Jan 2023 15:13:03 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, "Erhard F ." <erhard_f@mailbox.org>,
        kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH] kallsyms: Fix scheduling with interrupts disabled in
 self-test
Message-ID: <Y8Hlf68u51j6uLeS@bombadil.infradead.org>
References: <20230112105426.1037325-1-npiggin@gmail.com>
 <Y8BQaw5tVzDjZ9Sz@bombadil.infradead.org>
 <Y8EZ8+MgMqzu4/7H@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8EZ8+MgMqzu4/7H@alley>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 09:44:35AM +0100, Petr Mladek wrote:
> On Thu 2023-01-12 10:24:43, Luis Chamberlain wrote:
> > On Thu, Jan 12, 2023 at 08:54:26PM +1000, Nicholas Piggin wrote:
> > > kallsyms_on_each* may schedule so must not be called with interrupts
> > > disabled. The iteration function could disable interrupts, but this
> > > also changes lookup_symbol() to match the change to the other timing
> > > code.
> > > 
> > > Reported-by: Erhard F. <erhard_f@mailbox.org>
> > > Link: https://lore.kernel.org/all/bug-216902-206035@https.bugzilla.kernel.org%2F/
> > > Reported-by: kernel test robot <oliver.sang@intel.com>
> > > Link: https://lore.kernel.org/oe-lkp/202212251728.8d0872ff-oliver.sang@intel.com
> > > Fixes: 30f3bb09778d ("kallsyms: Add self-test facility")
> > > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > > ---
> > 
> > Thanks Nicholas!
> > 
> > Petr had just suggested removing this aspect of the selftests, the performance
> > test as its specific to the config, it doesn't run many times to get an
> > average and odd things on a system can create different metrics. Zhen Lei
> > had given up on fixing it and has a patch to instead remove this part of
> > the selftest.
> > 
> > I still find value in keeping it, but Petr, would like your opinion on
> > this fix, if we were to keep it.
> 
> I am fine with this fix.

Merged the fix. I'll push to Linus for 6.2-rc4

  Luis
