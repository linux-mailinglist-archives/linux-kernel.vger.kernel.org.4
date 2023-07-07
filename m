Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D39C574B272
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 16:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232900AbjGGOCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 10:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232570AbjGGOBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 10:01:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365722130
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 07:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688738455;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xp6rJXv98R80P+/7EHwV7cdYFXbRakzdmgAQwoPVD+8=;
        b=aPpOl3rgpFYjXvecHBDmebwHNGnxtbMauiJ3u32+0bus1Zpxao3TXLO2JDN4kyr+En1oud
        C2Rw/MxnXOActkuBN33EMHxzDHylxOq9pY/hHYDI8zo0MXIHuiO+MKZ84lb5M+wPTp8api
        giC2glbAha6wynSHMtsWSJgZOZBohkw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-357-nvdKaUNuNZK_NsivSrgL-g-1; Fri, 07 Jul 2023 10:00:52 -0400
X-MC-Unique: nvdKaUNuNZK_NsivSrgL-g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D30CF1C060CC;
        Fri,  7 Jul 2023 14:00:50 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-39.pek2.redhat.com [10.72.12.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D64122166B25;
        Fri,  7 Jul 2023 14:00:38 +0000 (UTC)
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
        kernel test robot <lkp@intel.com>, linux-clk@vger.kernel.org
Subject: [PATCH 7/8] clk: fixed-mmio: make COMMON_CLK_FIXED_MMIO depend on HAS_IOMEM
Date:   Fri,  7 Jul 2023 21:58:51 +0800
Message-Id: <20230707135852.24292-8-bhe@redhat.com>
In-Reply-To: <20230707135852.24292-1-bhe@redhat.com>
References: <20230707135852.24292-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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

Here let COMMON_CLK_FIXED_MMIO depend on HAS_IOMEM so that it won't
be built to cause below compiling error if PCI is unset:

------
ld: drivers/clk/clk-fixed-mmio.o: in function `fixed_mmio_clk_setup':
clk-fixed-mmio.c:(.text+0x5e): undefined reference to `of_iomap'
ld: clk-fixed-mmio.c:(.text+0xba): undefined reference to `iounmap'
------

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202306211329.ticOJCSv-lkp@intel.com/
Signed-off-by: Baoquan He <bhe@redhat.com>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org
---
 drivers/clk/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 93f38a8178ba..6b3b424addab 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -444,6 +444,7 @@ config COMMON_CLK_BD718XX
 config COMMON_CLK_FIXED_MMIO
 	bool "Clock driver for Memory Mapped Fixed values"
 	depends on COMMON_CLK && OF
+	depends on HAS_IOMEM
 	help
 	  Support for Memory Mapped IO Fixed clocks
 
-- 
2.34.1

