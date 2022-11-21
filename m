Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80E4D632CDE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 20:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbiKUTTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 14:19:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbiKUTSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 14:18:54 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 625D9E0BC;
        Mon, 21 Nov 2022 11:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IDAgf8lbbVFqJgU6JDXwJ+JnvJXOpPzVGT7LvHAItiU=; b=abvqVpdQR0wHO7xvGAqrNSuGfr
        3M/2TCKr8LfeRENw2g03/rbmixDR2SO7+Z1HTFX1SLp3oRct5m5ea6wh8s1BmjWB1GQ4XnBuhurhp
        jZiLKyXUFrpetDsIK9XOCDTTV3M67LCgf4tyytZ/4dq0rFrZsJnTz4uuGk0mu6YXfVEFJDKA7vk6L
        zDGURJYoIo00DpACVjbrUr0XdQ/nzIM8VJtQYXOnQaEBwyI3wpYsyr4chgNLZYNdahkugxz9nUAD1
        JvQrgDEdQ/DxvonOQ2ECj0+cQS4p0GOhsGrA0MRG+FAfgdWaGDjqxvcYHdJYQCdyfJJEiVpXzssBh
        7RCWKr0w==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oxCJc-00HDXP-73; Mon, 21 Nov 2022 19:18:48 +0000
Date:   Mon, 21 Nov 2022 11:18:48 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Nick Alcock <nick.alcock@oracle.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, akpm@linux-foundation.org, eugene.loh@oracle.com,
        kris.van.hees@oracle.com, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v9 2/8] kbuild: add modules_thick.builtin
Message-ID: <Y3vPGDmKVx3UWbwJ@bombadil.infradead.org>
References: <20221109134132.9052-1-nick.alcock@oracle.com>
 <20221109134132.9052-3-nick.alcock@oracle.com>
 <Y2x22mKtaZvC7ZSk@bombadil.infradead.org>
 <87h6z5wqlk.fsf@esperi.org.uk>
 <Y25mXAGty35I5lQx@bombadil.infradead.org>
 <87iljhv321.fsf@esperi.org.uk>
 <Y3QC0OIbZgSmvAxT@bombadil.infradead.org>
 <87sfics595.fsf@esperi.org.uk>
 <Y3vNs41m9I51Eu7x@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3vNs41m9I51Eu7x@bombadil.infradead.org>
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

On Mon, Nov 21, 2022 at 11:12:52AM -0800, Luis Chamberlain wrote:
> On Mon, Nov 21, 2022 at 03:21:10PM +0000, Nick Alcock wrote:
> > One question: do you think it's worthwhile me submitting patches to
> > de-MODULE_* things that need it?
> 
> 100% yes.
> 
> Yes please remove all that module declration helpers for things that are
> not modules, and after you add your helper which will nag at build time
> when it finds new ones.
> 
> For justification just mention in the commit log that after commit
> 8b41fc4454e ("kbuild: create modules.builtin without Makefile.modbuiltin or
> tristate.conf") we rely on the module license tag to generate the
> modules.builtin file and so built-in code which uses module helpers
> just need to be removed.

You should also mention what modules.builtin is used for as per our
Documentation/kbuild/kbuild.rst, and that it is only used for
modprobe to *not* fail when trying to load a module which is
built-in.

And so, the removing these tags doesn't fix anything critical
in particular, but it does fix false positive uses of userspace
modprobe use against built-in symbols.

That would *complete* the commit log with a clear justification and
evaluation of impact.

How many of these are we talking about? I'm happy to take them
via modules-next. I'd hope to not run accross many conflicts against
other trees.

  Luis
