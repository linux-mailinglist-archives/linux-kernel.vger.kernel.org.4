Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 423076E0368
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 02:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjDMAxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 20:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjDMAxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 20:53:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640962D66
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 17:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=96Io3kHhPRZFLb64v4GRm5wz/k2ztuhR/59YTAmjOGg=; b=ZmOtKjTdvvcrtbSFQ5qm6xAzz/
        q3FPe22PEuSCd453TOwHycyDNtnpKMURcem1gaRqcRTB6pPnfPX4h7bYSadxl3aaeUziQSoOy6dmf
        mPe+UNnGVjGQVgCCRC1rSpLobbnLLNt39QCdc2ZlKVQuhYpGvkzJKO+0doKLr1SUhDGlSkcaRv1bP
        9+b4uhUioxr24IUQTPSBkQ0Dq9xc8vTp5vh1BpDHZ52WlrpQGauMT7+USN73IAmeVgUoG6Gkz0yy7
        d/OHOf7g+64cKNmo/IDrqpEQp6tVN8uc5eVVvs7PpIgL308w4CmOjsFVB4IFoiaDVpEbpNlDPC0Ix
        lzEinwdA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pmlD5-004j9X-2f;
        Thu, 13 Apr 2023 00:53:11 +0000
Date:   Wed, 12 Apr 2023 17:53:11 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     jan.kiszka@siemens.com, kbingham@kernel.org, gost.dev@samsung.com,
        linux-kernel@vger.kernel.org, song@kernel.org
Subject: Re: [PATCH v2] scripts/gdb: use mem instead of core_layout to get
 the module address
Message-ID: <ZDdSd8iB2n6r/ccB@bombadil.infradead.org>
References: <CGME20230412203420eucas1p2efd38df12efde2ca05c6b3a26f5a753b@eucas1p2.samsung.com>
 <20230412202516.1027149-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412202516.1027149-1-p.raghav@samsung.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 10:25:18PM +0200, Pankaj Raghav wrote:
> commit ac3b43283923 ("module: replace module_layout with module_memory")
> changed the struct module data structure from module_layout to
> module_memory. The core_layout member which is used while loading
> modules are not available anymore leading to the following error while
> running gdb:
> 
> (gdb) lx-symbols
> loading vmlinux
> Python Exception <class 'gdb.error'>: There is no member named core_layout.
> Error occurred in Python: There is no member named core_layout.
> 
> Replace core_layout with its new counterpart mem[MOD_TEXT].
> 
> Fixes: ac3b43283923 ("module: replace module_layout with module_memory")
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  scripts/gdb/linux/constants.py.in | 3 +++
>  scripts/gdb/linux/modules.py      | 4 ++--
>  scripts/gdb/linux/symbols.py      | 4 ++--
>  3 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/scripts/gdb/linux/constants.py.in b/scripts/gdb/linux/constants.py.in
> index 36fd2b145853..471300ba176c 100644
> --- a/scripts/gdb/linux/constants.py.in
> +++ b/scripts/gdb/linux/constants.py.in
> @@ -62,6 +62,9 @@ LX_GDBPARSED(hrtimer_resolution)
>  LX_GDBPARSED(IRQD_LEVEL)
>  LX_GDBPARSED(IRQ_HIDDEN)
>  
> +/* linux/module.h */
> +LX_GDBPARSED(MOD_TEXT)

Should we just fill in the rest of the other sections too while at it?

  Luis
