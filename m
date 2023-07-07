Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 371C774B274
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 16:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbjGGOCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 10:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232903AbjGGOCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 10:02:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91227210C
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 07:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688738471;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hsDLZOIaMsdutOawC63k62k7hxKuoez0tGZig9GdB48=;
        b=ORn4zhRb0jLa2A93NW/bhKRlAEMkfvB5lgoCFV8EAdqSIUp+OEYIs2I4zjhmVZGU80eTKi
        5XKK3KDuQ32t3aG9/pHElhRILVziC1GgKFHXKgxyhaLrtKHzATj159cIvBsnqNWZu+IX9s
        OvBDyvdf1j9HOMTMLmhMO8wAPAx2cDc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-621-_yX0V8PePHiNzeIA8hA2sA-1; Fri, 07 Jul 2023 10:01:05 -0400
X-MC-Unique: _yX0V8PePHiNzeIA8hA2sA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4B612100812B;
        Fri,  7 Jul 2023 14:01:04 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-39.pek2.redhat.com [10.72.12.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A18962166B25;
        Fri,  7 Jul 2023 14:00:51 +0000 (UTC)
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
        kernel test robot <lkp@intel.com>, devicetree@vger.kernel.org
Subject: [PATCH 8/8] of: make OF_EARLY_FLATTREE depend on HAS_IOMEM
Date:   Fri,  7 Jul 2023 21:58:52 +0800
Message-Id: <20230707135852.24292-9-bhe@redhat.com>
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

In LKP error report at below on s390:
------
ld: kernel/dma/coherent.o: in function `dma_init_coherent_memory':
coherent.c:(.text+0x102): undefined reference to `memremap'
ld: coherent.c:(.text+0x226): undefined reference to `memunmap'
ld: kernel/dma/coherent.o: in function `dma_declare_coherent_memory':
coherent.c:(.text+0x8b8): undefined reference to `memunmap'
ld: kernel/dma/coherent.o: in function `dma_release_coherent_memory':
coherent.c:(.text+0x9aa): undefined reference to `memunmap'
------

In the config file, several Kconfig options are:
------
'# CONFIG_PCI is not set'
CONFIG_OF_EARLY_FLATTREE=y
CONFIG_DMA_DECLARE_COHERENT=y
------

So, enabling OF_EARLY_FLATTREE will select DMA_DECLARE_COHERENT
and cause above building errors even though they are not needed
because CONFIG_PCI is disabled.

Here let OF_EARLY_FLATTREE depend on HAS_IOMEM so that it won't
be built to cause compiling error if PCI is unset.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202306211329.ticOJCSv-lkp@intel.com/
Signed-off-by: Baoquan He <bhe@redhat.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: devicetree@vger.kernel.org
---
 drivers/of/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
index e40f10bf2ba4..da9826accb1b 100644
--- a/drivers/of/Kconfig
+++ b/drivers/of/Kconfig
@@ -55,7 +55,7 @@ config OF_FLATTREE
 
 config OF_EARLY_FLATTREE
 	bool
-	select DMA_DECLARE_COHERENT if HAS_DMA
+	select DMA_DECLARE_COHERENT if HAS_DMA && HAS_IOMEM
 	select OF_FLATTREE
 
 config OF_PROMTREE
-- 
2.34.1

