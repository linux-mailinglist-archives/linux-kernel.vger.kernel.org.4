Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8AC16E5222
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 22:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbjDQUw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 16:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjDQUwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 16:52:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B735260;
        Mon, 17 Apr 2023 13:52:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A6EEF629F8;
        Mon, 17 Apr 2023 20:52:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7531C433D2;
        Mon, 17 Apr 2023 20:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681764733;
        bh=wES3KCkjDWiJ2Tu0lVpCxkEgcdzlN0+bM4mS0DRx1FA=;
        h=From:To:Cc:Subject:Date:From;
        b=H9y9/yAs5Lnu835nVUXjlPPF+X182pJ27rBSTlI6Axh7iyXkK+9mqUeL1nz7y+hkI
         wAG/2Bm3EE1hl1xfrvtwPYvo/7muvDoIrFI7VQHmMrUQxLRUyxkH+gyEzut7O9Homc
         ibCcBnUobSN/yUG23L5O9jSc9R+94/H370w7dqsShY1QJZyvXltEBzu7Wlf5W021MG
         l4qPDiAe7v5z1D5e9fEEAIVNhzLBsQL0zmH/rkoc/a2tmhRD1nhWalmgjrdi/++gua
         sjImY2xeYS7t1mD7b8vawITeqkiZBsd1jIiIf1JuZvy75FVv3j9m2T5AOaMpaP4jdw
         GzLSPXvcZBHlg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: advansys: disallow ISA-only build
Date:   Mon, 17 Apr 2023 22:51:53 +0200
Message-Id: <20230417205207.1592134-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The ISA support for this driver was removed a while ago,
but the Kconfig dependencies still need an update to require
EISA or PCI.

Fixes: 9b4c8eaa68d0 ("advansys: remove ISA support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/scsi/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
index 03e71e3d5e5b..5956d2bfc9d9 100644
--- a/drivers/scsi/Kconfig
+++ b/drivers/scsi/Kconfig
@@ -462,8 +462,7 @@ config SCSI_MVUMI
 config SCSI_ADVANSYS
 	tristate "AdvanSys SCSI support"
 	depends on SCSI
-	depends on ISA || EISA || PCI
-	depends on ISA_DMA_API || !ISA
+	depends on EISA || PCI
 	help
 	  This is a driver for all SCSI host adapters manufactured by
 	  AdvanSys. It is documented in the kernel source in
-- 
2.39.2

