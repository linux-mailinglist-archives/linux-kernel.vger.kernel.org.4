Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD7B674B255
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 16:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbjGGOAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 10:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232258AbjGGOAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 10:00:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311CB1FEF
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 06:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688738356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=sC4UZ5LhNpjOJFleo9uAvg01y2IfXa2wUDSaFXs4svI=;
        b=cSsm37C88ztInlH8+iOktJ3MNl6882QsbcbtEOgXhfLLDbr/ZZDlGaMgvRAHSPUm9Tlyji
        Jvy2ulr+wS7Aw4Gxg9LL/IIh4veg1fUwPq1NGpzw/xxlBSV/s8e6npOA7DMgKXhu2akRNC
        KaC5iVZXlgjhpH3bE2+irjc6TdHLF3E=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-282-rz09Yx07OJ2J9x61qdPxAw-1; Fri, 07 Jul 2023 09:59:12 -0400
X-MC-Unique: rz09Yx07OJ2J9x61qdPxAw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6643B3C0DDC1;
        Fri,  7 Jul 2023 13:59:10 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-39.pek2.redhat.com [10.72.12.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 33AC12166B25;
        Fri,  7 Jul 2023 13:58:55 +0000 (UTC)
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
Subject: [PATCH 0/8] Make several Kconfig options depend on HAS_IOMEM
Date:   Fri,  7 Jul 2023 21:58:44 +0800
Message-Id: <20230707135852.24292-1-bhe@redhat.com>
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

In thread of one patch posting, LKP test robot reported some compiling
errors, paste the LKP report link here: 

https://lore.kernel.org/all/202306211329.ticOJCSv-lkp@intel.com/T/#u

In the config file, several Kconfig options are like below:
------
'# CONFIG_PCI is not set'
CONFIG_OF_EARLY_FLATTREE=y
CONFIG_DMA_DECLARE_COHERENT=y
------

The reason is (words arranged from Niklas):
===
On s390 systems (aka mainframes), it has classic channel devices for
networking and permanent storage that are currently even more common
than PCI devices. Hence it could have a fully functional s390 kernel
with CONFIG_PCI=n, then the relevant iomem mapping functions
[including ioremap(), devm_ioremap(), etc.] are not available.

So make several Kconfig options depend on HAS_IOMEM so that it won't
build in those driver code if PCI is unset.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202306211329.ticOJCSv-lkp@intel.com/

Baoquan He (8):
  idmaengine: make FSL_EDMA and INTEL_IDMA64 depends on HAS_IOMEM
  char: xillybus: make XILLYBUS_OF depend on HAS_IOMEM
  misc: open-dice: make OPEN_DICE depend on HAS_IOMEM
  pcmcia : make PCMCIA depend on HAS_IOMEM
  net: altera-tse: make ALTERA_TSE depend on HAS_IOMEM
  irqchip/al-fic: make AL_FIC depend on HAS_IOMEM
  clk: fixed-mmio: make COMMON_CLK_FIXED_MMIO depend on HAS_IOMEM
  of: make OF_EARLY_FLATTREE depend on HAS_IOMEM

 drivers/char/xillybus/Kconfig       | 2 +-
 drivers/clk/Kconfig                 | 1 +
 drivers/dma/Kconfig                 | 2 ++
 drivers/irqchip/Kconfig             | 1 +
 drivers/misc/Kconfig                | 1 +
 drivers/net/ethernet/altera/Kconfig | 1 +
 drivers/of/Kconfig                  | 2 +-
 drivers/pcmcia/Kconfig              | 1 +
 8 files changed, 9 insertions(+), 2 deletions(-)

-- 
2.34.1

