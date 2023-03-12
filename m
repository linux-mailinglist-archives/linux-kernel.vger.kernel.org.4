Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4B56B6350
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 06:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjCLF0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 00:26:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjCLF0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 00:26:30 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9473BD8A;
        Sat, 11 Mar 2023 21:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=HTO0kFL/gXNY82LV1tHpGaf2bVH9yozHCg1ZS/+0oeI=; b=v/8mSm1wRqrfK74nfEGrwhkHXR
        KtCrGdm/ipvoyLcvdNTOEs39ZojotwJlKrM5KEIk5RW4TXWhoTjYClXsnsdMUHYOY/nvHcF1Ho/eu
        5ODdLvIR+2mSDPrFYJCq9CFSbgr+nyzIqMQGWLIBuO4jhmr4VKC6kDX7TnA9LorHNEkFKdO0HSTiY
        9bVrUw4GrEBTpKHAPlCZLPRsaENgTeGc3sODEDEnh0cTgpV3UVKhzUfq4C/MOSG2htvo8quJrt1Sj
        ZvhB1eF1HEKTHrJswoPJ8y1ulD77uuc7v35rheJrVAAvLTCbKdWy8DobAzX0LLNyYJLvdEgHlfWkU
        ZB7AWlXw==;
Received: from [2601:1c2:980:9ec0::df2f] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pbEDx-001onR-LW; Sun, 12 Mar 2023 05:26:25 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org, linux-um@lists.infradead.org
Subject: [PATCH] ata: pata_cs5536: don't build on UML
Date:   Sat, 11 Mar 2023 21:26:24 -0800
Message-Id: <20230312052624.8402-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.2
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

Similar to 22eebaa631c4 ("ata: pata_cs5535: Don't build on UML"),
prevent pata_cs5536 from building on UML since it references
symbols that are not present when building X86_32/i386 allmodconfig.

ERROR: modpost: "__tracepoint_write_msr" [drivers/ata/pata_cs5536.ko] undefined!
ERROR: modpost: "do_trace_write_msr" [drivers/ata/pata_cs5536.ko] undefined!
ERROR: modpost: "__tracepoint_read_msr" [drivers/ata/pata_cs5536.ko] undefined!
ERROR: modpost: "do_trace_read_msr" [drivers/ata/pata_cs5536.ko] undefined!

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: linux-ide@vger.kernel.org
Cc: linux-um@lists.infradead.org
---
 drivers/ata/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff -- a/drivers/ata/Kconfig b/drivers/ata/Kconfig
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -650,6 +650,7 @@ config PATA_CS5535
 config PATA_CS5536
 	tristate "CS5536 PATA support"
 	depends on PCI && (X86_32 || MIPS || COMPILE_TEST)
+	depends on !UML
 	help
 	  This option enables support for the AMD CS5536
 	  companion chip used with the Geode LX processor family.
