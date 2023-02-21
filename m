Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0129069E955
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 22:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjBUVQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 16:16:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBUVPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 16:15:52 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E933E902C;
        Tue, 21 Feb 2023 13:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=fX7hqjeUd0YzfAq3xRrkecSpMHe7OU08C0EZ3+Rklzs=; b=XoTM0PsPJR2mQk4wVdx++GTVcr
        oJbaz1o/QiDf9cWsNNfTq9jw47lc5RkKzDvc+II3K8DFKVAR3Ulo5F1Z38khdoMIAd5yYtmUmAy/g
        Tx/wNs7dbVqPRA+/qd5cTPILlgU/Wr3/lyzhtaTzbqTFVG4CYsn9DHC7Ds6tb1YnGEsvqlVT00t+6
        6Mn3Jnj3LOrzhnryUm0wZFv5OSZPXrzjPQg3QuvdoGIjSKtCjy4PNgq+iLXyoRp0o6ePxoTxKTecS
        zz9Bz+j2x9VkYGxKDKVOZMfleWdJBI793CDISBu8EWRHqJiREAa1bsQhLqrYZVwg/GZMA6B/6ve0Y
        KiKfGEtQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pUZyj-009nHM-M5; Tue, 21 Feb 2023 21:15:13 +0000
Date:   Tue, 21 Feb 2023 13:15:13 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Song Liu <song@kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>,
        "kernel-team@meta.com" <kernel-team@meta.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] module: clean-up for module_memory
Message-ID: <Y/U0YfGH44dRpkXp@bombadil.infradead.org>
References: <20230209175653.2275559-1-song@kernel.org>
 <a89af714-b9ee-1efa-d21d-92ffc690a7e7@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a89af714-b9ee-1efa-d21d-92ffc690a7e7@csgroup.eu>
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

On Thu, Feb 09, 2023 at 07:43:23PM +0000, Christophe Leroy wrote:
> 
> 
> Le 09/02/2023 à 18:56, Song Liu a écrit :
> > Three changes here:
> > 
> > 1. Shorter variable names in arch/arc/kernel/unwind.c:unwind_add_table, to
> >     make it easier to read.
> > 2. Rewrite free_mod_mem() so it is more obvious that MOD_DATA need to be
> >     freed last.
> > 3. Clean up the use of CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC.
> > 
> > Cc: Luis Chamberlain <mcgrof@kernel.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Guenter Roeck <linux@roeck-us.net>
> > Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> > Signed-off-by: Song Liu <song@kernel.org>
> > 
> > ---
> > 
> > This is the follow up patch on top of [1]. I would recommend fold this
> > into [1].
> 
> With this patch folded into [1],
> 
> Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>

I've squashed this into the last patch from Song and added your
Reviewed-by tag, and pushed to modules-next. That'll sit there
for a full cycle for testing.

  Luis
