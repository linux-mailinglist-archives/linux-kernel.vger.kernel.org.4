Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01E9C6A0310
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 08:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233499AbjBWHBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 02:01:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233463AbjBWHBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 02:01:23 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977D24A1D2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 23:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=gOBRECxsXsY6lxgL+yYcrF7OI+VSzF/GHUkcveTa3Y4=; b=E0B4Od0+YUf0HMfrRW98qlx/Pm
        bb0bbRFi23gnlkWdNNS2iWUUGZDCUJmZihFuZAgTskDBIJs4+pbqICdR6W7CuIejiUX4LpfBs8ntm
        hnOQpJXi12b86slXUf3V4N6UpnD09KoKmzvmUYgN782NjTfa9wICrkCje6gA+Mwl+RCrJEPR3tcc0
        oJkqTZxrilBCEj5gVaoYksy2v8eBTJsWptkjvwAdrvUAvKZQXQOqQCsm3bLVrrC7qdhYS2l8iS8TC
        on0CPSFOJRJnB0jbO/oQ7+pnbX1nn1juZLlrhLV1Fw09wtcqBVzSmHn0Ihjxd7pDWcZDWdmMXvxr9
        47fFimUw==;
Received: from [2601:1c2:980:9ec0::df2f] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pV5bU-00FMG2-5G; Thu, 23 Feb 2023 07:01:20 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Roy Zang <tie-fei.zang@freescale.com>,
        Paul Mackerras <paulus@samba.org>,
        Alexandre Bounine <alexandreb@tundra.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 4/4] POWERPC: sysdev/tsi108: fix resource printk format warnings
Date:   Wed, 22 Feb 2023 23:01:16 -0800
Message-Id: <20230223070116.660-5-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230223070116.660-1-rdunlap@infradead.org>
References: <20230223070116.660-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use "%pa" format specifier for resource_size_t to avoid a compiler
printk format warning.

../arch/powerpc/sysdev/tsi108_pci.c: In function 'tsi108_setup_pci':
../include/linux/kern_levels.h:5:25: error: format '%x' expects argument of type 'unsigned int', but argument 2 has type 'resource_size_t' {aka 'long long unsigned int'} [-Werror=format=]

Fixes: c4342ff92bed ("[POWERPC] Update mpc7448hpc2 board irq support using device tree")
Fixes: 2b9d7467a6db ("[POWERPC] Add tsi108 pci and platform device data register function")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Roy Zang <tie-fei.zang@freescale.com>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Alexandre Bounine <alexandreb@tundra.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/sysdev/tsi108_pci.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -- a/arch/powerpc/sysdev/tsi108_pci.c b/arch/powerpc/sysdev/tsi108_pci.c
--- a/arch/powerpc/sysdev/tsi108_pci.c
+++ b/arch/powerpc/sysdev/tsi108_pci.c
@@ -217,9 +217,9 @@ int __init tsi108_setup_pci(struct devic
 
 	(hose)->ops = &tsi108_direct_pci_ops;
 
-	printk(KERN_INFO "Found tsi108 PCI host bridge at 0x%08x. "
+	printk(KERN_INFO "Found tsi108 PCI host bridge at 0x%pa. "
 	       "Firmware bus number: %d->%d\n",
-	       rsrc.start, hose->first_busno, hose->last_busno);
+	       &rsrc.start, hose->first_busno, hose->last_busno);
 
 	/* Interpret the "ranges" property */
 	/* This also maps the I/O region and sets isa_io/mem_base */
