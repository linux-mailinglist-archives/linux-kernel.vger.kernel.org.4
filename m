Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F906E3562
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 08:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbjDPGU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 02:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjDPGUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 02:20:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6650D2125;
        Sat, 15 Apr 2023 23:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=a5HtuX5NCAwNZ2u+MVEk4FRtqRQnPUKDyUxgXoFpbhU=; b=Ml7115g/ona+dWfYlzju3J5h8J
        MVELE7TWv3Fq60RTVKkPsUzNurpxEGCNNnNtcYs9rLz9UpV3622U+7FKfvGlbsqyWzNorAaRXwSsG
        zfRZfFWDbUZg5g4eXLLiJvhar/wx4QrJyRmdYFFCQekmYZv1Z6WF5H7MVtVu+6v+vNYFWdHpLoq1W
        YTUf75AWPuIWE1RdzJ8t43NMUwyTgbqpnecR+aeX5FmQT+l/odFEHMJmNPivrdpq+7rt9LXjDuP5Q
        cjQ9WpVBqqDBJO+MCTMw2oZTSipYqfDqD5gZUyiii4TEENVYhzxx+pPLsccUUL6Omk2vFXnMezd71
        Li/MlRzA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pnvkI-00DDfz-2z;
        Sun, 16 Apr 2023 06:20:18 +0000
Date:   Sat, 15 Apr 2023 23:20:18 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org, linux-um@lists.infradead.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v3] UML: pata_cs5536: fix build for X86_32 UML with
 TRACEPOINTS
Message-ID: <ZDuTotxqsrysNaYu@infradead.org>
References: <20230410011325.26850-1-rdunlap@infradead.org>
 <099028386d683dcc585693d85b6b2739952fcdeb.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <099028386d683dcc585693d85b6b2739952fcdeb.camel@sipsolutions.net>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 14, 2023 at 03:55:07PM +0200, Johannes Berg wrote:
> On Sun, 2023-04-09 at 18:13 -0700, Randy Dunlap wrote:
> > Current build of pata_cs5536 for i386 UML fails with:
> > 
> > ERROR: modpost: "__tracepoint_write_msr" [drivers/ata/pata_cs5536.ko] undefined!
> > ERROR: modpost: "do_trace_write_msr" [drivers/ata/pata_cs5536.ko] undefined!
> > ERROR: modpost: "__tracepoint_read_msr" [drivers/ata/pata_cs5536.ko] undefined!
> > ERROR: modpost: "do_trace_read_msr" [drivers/ata/pata_cs5536.ko] undefined!
> > 
> > Add the arch/x86/lib/msr.o binary to resolve these undefined symbols.
> > 
> 
> Hm. Does this make sense? I can't see it'd work on UML to configure an
> IDE device through MSRs? Surely that can't work? IOW, that entire driver
> can't really work anyway can it?
> 
> OTOH, maybe theoretically it could work in PCI, just not with MSRs, and
> then this patch makes some sense?

I think it is is integrated into actual Geode SOCs.  That being
said something like the patch below seems as simple as it gets and
at least gives build coverage on uml

diff --git a/drivers/ata/pata_cs5536.c b/drivers/ata/pata_cs5536.c
index ab47aeb5587f55..4f5d9afd51c9d8 100644
--- a/drivers/ata/pata_cs5536.c
+++ b/drivers/ata/pata_cs5536.c
@@ -27,7 +27,7 @@
 #include <scsi/scsi_host.h>
 #include <linux/dmi.h>
 
-#ifdef CONFIG_X86_32
+#if defined(CONFIG_X86_32) && !defined(CONFIG_UML)
 #include <asm/msr.h>
 static int use_msr;
 module_param_named(msr, use_msr, int, 0644);
