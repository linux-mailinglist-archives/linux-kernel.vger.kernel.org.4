Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADCAD6F9175
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 13:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbjEFLRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 07:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232128AbjEFLRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 07:17:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31A111D
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 04:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683371804;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E1wEOHR70nwmDKawNxBjw3KFzdSZshnG7IqJ/M9Kp70=;
        b=e85u/vwKPJjoVf4bYY/vEx61U3bpBpsDTN7vn2FxHQ7V0vvEueTFujPoWWP8ArD7yJieDT
        6pYCiO7RxpWQH5YoaV2mhDixq9lMZyxdqMx4rd20xc3IQnAIZSni5SnoY8rmxPTG01PBRN
        aLdqQnLsdiOBeM8qbu1ZssPjJmFi7qM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-100-xJcKR7TDM7WPFsDhh4rPaA-1; Sat, 06 May 2023 07:16:41 -0400
X-MC-Unique: xJcKR7TDM7WPFsDhh4rPaA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E598B29A9CA4;
        Sat,  6 May 2023 11:16:40 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-46.pek2.redhat.com [10.72.12.46])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 48EA02166B31;
        Sat,  6 May 2023 11:16:34 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, schnelle@linux.ibm.com,
        linux-s390@vger.kernel.org, Baoquan He <bhe@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH RESEND 1/2] pcmcia : make PCMCIA depend on HAS_IOMEM
Date:   Sat,  6 May 2023 19:16:27 +0800
Message-Id: <20230506111628.712316-2-bhe@redhat.com>
In-Reply-To: <20230506111628.712316-1-bhe@redhat.com>
References: <20230506111628.712316-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
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

Here let depend PCMCIA on HAS_IOMEM so that it won't be built to
cause below compiling error if PCI is unset.

-------------------------------------------------------
ld: drivers/pcmcia/cistpl.o: in function `set_cis_map':
cistpl.c:(.text+0x1202): undefined reference to `ioremap'
ld: cistpl.c:(.text+0x13b0): undefined reference to `iounmap'
ld: cistpl.c:(.text+0x14a6): undefined reference to `iounmap'
ld: cistpl.c:(.text+0x1544): undefined reference to `ioremap'
ld: drivers/pcmcia/cistpl.o: in function `release_cis_mem':
cistpl.c:(.text+0x3f14): undefined reference to `iounmap'

Signed-off-by: Baoquan He <bhe@redhat.com>
Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---
 drivers/pcmcia/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pcmcia/Kconfig b/drivers/pcmcia/Kconfig
index 44c16508ef14..5681b610e954 100644
--- a/drivers/pcmcia/Kconfig
+++ b/drivers/pcmcia/Kconfig
@@ -20,6 +20,7 @@ if PCCARD
 
 config PCMCIA
 	tristate "16-bit PCMCIA support"
+	depends on HAS_IOMEM
 	select CRC32
 	default y
 	help
-- 
2.34.1

