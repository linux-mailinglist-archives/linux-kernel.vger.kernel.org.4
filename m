Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20C3B74B26F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 16:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232815AbjGGOBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 10:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232781AbjGGOBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 10:01:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D98212B
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 07:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688738441;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CWfLRI5TOebRN6fQYNsjbIhOePrgTeydAOSGhfAOwjI=;
        b=iLG0Gn4WRZzU9/i6tvoMnwrpqmieepE1FLKegqYTSZUcIDzwZjoEq969ne7fZCUIZlXmHz
        Ei6LoJqhB4k1J8kgK0xPxlCr2byekdNWJXE/O1oSerdMUYQK4U97kizoyWwEycZjn0fu+e
        RsBOT+1T1zwnboHWEab8+hFZBmVkHZ8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-464-zGZQbIWXMSycsrfTt_BANg-1; Fri, 07 Jul 2023 10:00:38 -0400
X-MC-Unique: zGZQbIWXMSycsrfTt_BANg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0AE34104458F;
        Fri,  7 Jul 2023 14:00:37 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-39.pek2.redhat.com [10.72.12.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0FAD52166B25;
        Fri,  7 Jul 2023 14:00:23 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        schnelle@linux.ibm.com, vkoul@kernel.org, eli.billauer@gmail.com,
        arnd@arndb.de, gregkh@linuxfoundation.org, derek.kiernan@amd.com,
        dragan.cvetic@amd.com, linux@dominikbrodowski.net,
        Jonathan.Cameron@huawei.com, linus.walleij@linaro.org,
        tsbogend@alpha.franken.de, joyce.ooi@intel.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, tglx@linutronix.de, maz@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        frowand.list@gmail.com, Baoquan He <bhe@redhat.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 6/8] irqchip/al-fic: make AL_FIC depend on HAS_IOMEM
Date:   Fri,  7 Jul 2023 21:58:50 +0800
Message-Id: <20230707135852.24292-7-bhe@redhat.com>
In-Reply-To: <20230707135852.24292-1-bhe@redhat.com>
References: <20230707135852.24292-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On s390 systems (aka mainframes), it has classic channel devices for
networking and permanent storage that are currently even more common
than PCI devices. Hence it could have a fully functional s390 kernel
with CONFIG_PCI=n, then the relevant iomem mapping functions
[including ioremap(), devm_ioremap(), etc.] are not available.

Here let AL_FIC depend on HAS_IOMEM so that it won't be built
to cause below compiling error if PCI is unset:

------
ld: drivers/irqchip/irq-al-fic.o: in function `al_fic_init_dt':
irq-al-fic.c:(.init.text+0x76): undefined reference to `of_iomap'
ld: irq-al-fic.c:(.init.text+0x4ce): undefined reference to `iounmap'
------

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202306211329.ticOJCSv-lkp@intel.com/
Signed-off-by: Baoquan He <bhe@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 09e422da482f..4b9036c6d45b 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -89,6 +89,7 @@ config ALPINE_MSI
 config AL_FIC
 	bool "Amazon's Annapurna Labs Fabric Interrupt Controller"
 	depends on OF
+	depends on HAS_IOMEM
 	select GENERIC_IRQ_CHIP
 	select IRQ_DOMAIN
 	help
-- 
2.34.1

