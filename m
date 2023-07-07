Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61D3874B25A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 16:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjGGOAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 10:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232560AbjGGOAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 10:00:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87578210C
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 06:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688738385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CxwA3DJ3ViKIdzagr2m8kE8L4GOotWrmViZBn3jHWi4=;
        b=E9ceHwCtwY9o96nGyBIRReCvNqol+0Okh2ul7hfLtrvb1B405HPNCXBCRdJkV8udr1wgY+
        xIZWxE47i1SUA6ZcUFhcC5vgb6811iN3uV0BM8b2VNgPvLj9RmiIH6s14k408hsYBqP/EB
        GJSCnlpXCuqQs6IFwM6KQB0EB/HZx9E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-660-K_nqMDSSN4WPFTDThD3jNA-1; Fri, 07 Jul 2023 09:59:40 -0400
X-MC-Unique: K_nqMDSSN4WPFTDThD3jNA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 60093856F66;
        Fri,  7 Jul 2023 13:59:39 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-39.pek2.redhat.com [10.72.12.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4677C2166B25;
        Fri,  7 Jul 2023 13:59:26 +0000 (UTC)
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
Subject: [PATCH 2/8] char: xillybus: make XILLYBUS_OF depend on HAS_IOMEM
Date:   Fri,  7 Jul 2023 21:58:46 +0800
Message-Id: <20230707135852.24292-3-bhe@redhat.com>
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

Here let XILLYBUS_OF depend on HAS_IOMEM so that it won't be built
to cause below compiling error if PCI is unset:

------
ERROR: modpost: "devm_platform_ioremap_resource" [drivers/char/xillybus/xillybus_of.ko] undefined!
------

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202306211329.ticOJCSv-lkp@intel.com/
Signed-off-by: Baoquan He <bhe@redhat.com>
Cc: Eli Billauer <eli.billauer@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/char/xillybus/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/xillybus/Kconfig b/drivers/char/xillybus/Kconfig
index a8036dad437e..f51d533390a9 100644
--- a/drivers/char/xillybus/Kconfig
+++ b/drivers/char/xillybus/Kconfig
@@ -29,7 +29,7 @@ config XILLYBUS_PCIE
 
 config XILLYBUS_OF
 	tristate "Xillybus over Device Tree"
-	depends on OF && HAS_DMA
+	depends on OF && HAS_DMA && HAS_IOMEM
 	help
 	  Set to M if you want Xillybus to find its resources from the
 	  Open Firmware Flattened Device Tree. If the target is an embedded
-- 
2.34.1

