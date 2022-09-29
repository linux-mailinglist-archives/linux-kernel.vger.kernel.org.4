Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72AC95EEDE6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 08:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234784AbiI2G3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 02:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234737AbiI2G3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 02:29:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21AA023BC7;
        Wed, 28 Sep 2022 23:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=QlBqQ64wnLSOtZ6WaJVazq9vcYmGSriwpedjzHHAGU0=; b=UMIzTycAQc+4Cl3qGTM7QcB/V4
        lhW8GfjhHz50dZhgK2JpdkoAqNkFVy7xd7hATnJzt1ZlfocBpfYBTxxWndo4W0Wl1WEc38M0cU2qU
        HVe2UxTNVaKHXkkO81dSkp+LsS3eEc73b/Bm+ikqvQr6VKktyi7WmQOAH/PpBXD0e44DuDCCFqOMr
        0tALHCRYTu5i5ImCEX4nbGA+PdlQ1M3XmhE2q+RV+saXN680Dkv4+rCmqiJ2DF7hWlpISGjXdbM77
        B6PoPFAOQxmfyjxAoWEIHJ5P4jHdn56petQ1nqSvEKLwoMQ0jYbdGUQHlfczC6cFdQQ4cQ+Okm9gK
        ZjDtsd2Q==;
Received: from [2601:1c2:d80:3110::a2e7] (helo=casper.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1odn3L-00D2jY-5r; Thu, 29 Sep 2022 06:29:47 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        linux-pm@vger.kernel.org
Subject: [PATCH] power: supply: mt6370: uses IIO interfaces, depends on IIO
Date:   Wed, 28 Sep 2022 23:29:40 -0700
Message-Id: <20220929062940.27538-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.37.3
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

The mt6370-charger driver uses IIO interfaces and produces build
errors when CONFIG_IIO is not set, so it should depend on IIO.

ERROR: modpost: "iio_read_channel_processed" [drivers/power/supply/mt6370-charger.ko] undefined!
ERROR: modpost: "devm_iio_channel_get_all" [drivers/power/supply/mt6370-charger.ko] undefined!

Fixes: 233cb8a47d65 ("power: supply: mt6370: Add MediaTek MT6370 charger driver")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: ChiaEn Wu <chiaen_wu@richtek.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: linux-pm@vger.kernel.org
---
 drivers/power/supply/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -623,6 +623,7 @@ config CHARGER_MT6370
 	tristate "MediaTek MT6370 Charger Driver"
 	depends on MFD_MT6370
 	depends on REGULATOR
+	depends on IIO
 	select LINEAR_RANGES
 	help
 	  Say Y here to enable MT6370 Charger Part.
