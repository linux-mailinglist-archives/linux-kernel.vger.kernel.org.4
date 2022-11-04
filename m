Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C528F619418
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 11:04:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbiKDKED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 06:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiKDKD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 06:03:59 -0400
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5B1FFF
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 03:03:57 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed10:c5ee:bf27:9df:5172])
        by laurent.telenet-ops.be with bizsmtp
        id gA3t2800G2kjr6L01A3t1H; Fri, 04 Nov 2022 11:03:54 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1oqtYG-002m7b-Cx; Fri, 04 Nov 2022 11:03:52 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1oqtVy-00HVU8-Vt; Fri, 04 Nov 2022 11:01:31 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Mark Brown <broonie@kernel.org>,
        Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] spi: Merge spi_controller.{slave,target}_abort()
Date:   Fri,  4 Nov 2022 11:01:27 +0100
Message-Id: <809c82d54b85dd87ef7ee69fc93016085be85cec.1667555967.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mixing SPI slave/target handlers and SPI slave/target controllers using
legacy and modern naming does not work well: there are now two different
callbacks for aborting a slave/target operation, of which only one is
populated, while spi_{slave,target}_abort() check and use only one,
which may be the unpopulated one.

Fix this by merging the slave/target abort callbacks into a single
callback using a union, like is already done for the slave/target flags.

Fixes: b8d3b056a78dcc94 ("spi: introduce new helpers with using modern naming")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Compile-tested only.
---
 include/linux/spi/spi.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 27680bf02c6a221c..78c35ac1ef2f2b7e 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -655,8 +655,10 @@ struct spi_controller {
 			       struct spi_message *message);
 	int (*unprepare_message)(struct spi_controller *ctlr,
 				 struct spi_message *message);
-	int (*slave_abort)(struct spi_controller *ctlr);
-	int (*target_abort)(struct spi_controller *ctlr);
+	union {
+		int (*slave_abort)(struct spi_controller *ctlr);
+		int (*target_abort)(struct spi_controller *ctlr);
+	};
 
 	/*
 	 * These hooks are for drivers that use a generic implementation
-- 
2.25.1

