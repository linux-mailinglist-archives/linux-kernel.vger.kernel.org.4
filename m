Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE1D173DADA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 11:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjFZJJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 05:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjFZJIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 05:08:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B04A2136;
        Mon, 26 Jun 2023 02:06:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C56760D2C;
        Mon, 26 Jun 2023 09:06:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 896C3C433C0;
        Mon, 26 Jun 2023 09:06:17 +0000 (UTC)
Date:   Mon, 26 Jun 2023 11:06:14 +0200
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Ivan Orlov <ivan.orlov0322@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the char-misc tree
Message-ID: <2023062628-stimulate-versus-50f5@gregkh>
References: <20230626142537.755ec782@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230626142537.755ec782@canb.auug.org.au>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 02:25:37PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the char-misc tree, today's linux-next build (powerpc
> ppc64_defconfig) failed like this:
> 
> drivers/char/bsr.c: In function 'bsr_init':
> drivers/char/bsr.c:301:13: error: 'err' undeclared (first use in this function)
>   301 |         if (err)
>       |             ^~~
> drivers/char/bsr.c:301:13: note: each undeclared identifier is reported only once for each function it appears in
> 
> Caused by commit
> 
>   e55ce9fd3d8f ("bsr: make bsr_class a static const structure")
> 
> I have reverted that commit for today.

Ick, I wonder what is up with the 0-day bot these days, I'm not getting
any reports and it should have caught this...

Anyway, I've applied the patch below to fix this up, thanks for the
report!

greg k-h

--------------

From adfdaf81f9d48d8618a4d8296567248170fe7bcc Mon Sep 17 00:00:00 2001
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Mon, 26 Jun 2023 11:03:21 +0200
Subject: [PATCH] bsr: fix build problem with bsr_class static cleanup

In commit e55ce9fd3d8f ("bsr: make bsr_class a static const structure"),
the bsr_init function was converted to handle a static class structure,
but the conversion got a variable name wrong, which caused build errors
so fix that up.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Ivan Orlov <ivan.orlov0322@gmail.com>
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Link: https://lore.kernel.org/r/20230626142537.755ec782@canb.auug.org.au
Fixes: e55ce9fd3d8f ("bsr: make bsr_class a static const structure")
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/char/bsr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/bsr.c b/drivers/char/bsr.c
index 0654f0e6b320..12143854aeac 100644
--- a/drivers/char/bsr.c
+++ b/drivers/char/bsr.c
@@ -298,7 +298,7 @@ static int __init bsr_init(void)
 		goto out_err;
 
 	ret = class_register(&bsr_class);
-	if (err)
+	if (ret)
 		goto out_err_1;
 
 	ret = alloc_chrdev_region(&bsr_dev, 0, BSR_MAX_DEVS, "bsr");
-- 
2.41.0

