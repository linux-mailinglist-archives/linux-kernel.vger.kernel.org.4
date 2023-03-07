Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 466BA6AF6A6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 21:24:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbjCGUYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 15:24:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbjCGUXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 15:23:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A687389F
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 12:23:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2CD84B81A31
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 20:23:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D9B4C433EF;
        Tue,  7 Mar 2023 20:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678220612;
        bh=zr/RXQEP9kEo+EnwwW4EkZXzcH8/Cm+sddrH4zbpuOU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C2kReW2u9cd8hgfPUoK1mj5efaFk+oe+RpaNULZCMGcXQaXB8pAT2R0JGpv7ybRSh
         shh8tERapttCn/eBkpt7KrPwQACDKAuXbbb1WwBhbmmQMXQwYgQ7Pl9pdsZKG+oyiJ
         utdctq3VAWgEuEf0oyuHHsAAxW/oUIR3Tdz0+dYT79CDUKJQkg8S8VYn3OaOmZa8Dm
         AwZl9dvRI+1X87y5D/vQTvbSoW8qqIOjXmb9wphwdaTPW2DZSHYj7565oLl7UsBYu6
         Q4TKNJKLoiWHsZUbva1Bk13dhHLVbyhDU755sGz70xQ6LnbOqQoxi5ASnsCMI9WkzQ
         hQ+gj5XGk5fzg==
From:   Conor Dooley <conor@kernel.org>
To:     linux-riscv@lists.infradead.org
Cc:     conor@kernel.org, Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/8] soc: microchip: mpfs: fix some horrible alignment
Date:   Tue,  7 Mar 2023 20:22:55 +0000
Message-Id: <20230307202257.1762151-6-conor@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307202257.1762151-1-conor@kernel.org>
References: <20230307202257.1762151-1-conor@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1038; i=conor.dooley@microchip.com; h=from:subject; bh=MwKJyVjv8Jbuiia0A7TcpOXo3jezcv525pOH2lez0W8=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDCnsc4XYHMSvishN+y87ZUlG/srobd+OFpfOUS+fEKEsP kn97q+jHaUsDGIcDLJiiiyJt/tapNb/cdnh3PMWZg4rE8gQBi5OAZjI6n6Gf+a6tm1cCZtzF2/Z X/tDcaVIYGaJzdcAj39HonZl8R0ULWH4n2i66/HXZzYnlpW5ikszPrp8SkmV8dHxhVlNOu6HI4v zOAA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

mpfs_sys_controller_delete() has some horrible alignment that upsets my
OCD... Move the RHS of the assignment to a new line for greater
satifaction.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/soc/microchip/mpfs-sys-controller.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/microchip/mpfs-sys-controller.c b/drivers/soc/microchip/mpfs-sys-controller.c
index 6e20207b5756..12039cb38b33 100644
--- a/drivers/soc/microchip/mpfs-sys-controller.c
+++ b/drivers/soc/microchip/mpfs-sys-controller.c
@@ -66,8 +66,8 @@ static void rx_callback(struct mbox_client *client, void *msg)
 
 static void mpfs_sys_controller_delete(struct kref *kref)
 {
-	struct mpfs_sys_controller *sys_controller = container_of(kref, struct mpfs_sys_controller,
-					       consumers);
+	struct mpfs_sys_controller *sys_controller =
+		container_of(kref, struct mpfs_sys_controller, consumers);
 
 	mbox_free_channel(sys_controller->chan);
 	kfree(sys_controller);
-- 
2.39.2

