Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3CA72291C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 16:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234529AbjFEOpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 10:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232533AbjFEOp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 10:45:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA00310A;
        Mon,  5 Jun 2023 07:45:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64639625F7;
        Mon,  5 Jun 2023 14:45:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D32C2C433AE;
        Mon,  5 Jun 2023 14:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685976325;
        bh=ua1Afonw01rPeQNE3BPvhZ+/s+M84W2XPIeCqh6o1dM=;
        h=From:To:Cc:Subject:Date:From;
        b=QLgpQSKVsI7VXmAWGBYC0EcbFO9HZyDDgMGXWx4oDk0QxPfpnfJLmft8/z87ZPMJU
         kPAdbXxqNgqdFbMdlFCmdCU5nQbNGY0sn7dggJnSGYOEkoczjSxKQqubLJEshneRvu
         d45VXxB8vIrtRdVUqP/nMQO0sPDQazVjJNfV9diQ1a8xsJvEyUDD3YtExhjPDyWRCJ
         Q4AJ3k4m8HlITY4j02f0k0s/8x5Y6zvSlZMaVUv3BamBchkfivSWhlg1Ch72JSjUGb
         bZyEAsFxBgNq1BoLl7n8CJIuv8Xs2DwFdY3yx7azzdbLBnxdc7F4YrkLAkFteC89G9
         PVgm0mdJ7bt1Q==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Damian Muszynski <damian.muszynski@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, qat-linux@intel.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: qat - fix adf_dbgfs_exit() typo
Date:   Mon,  5 Jun 2023 16:45:02 +0200
Message-Id: <20230605144519.1225211-1-arnd@kernel.org>
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

The stub function uses a different name from the normal one:

drivers/crypto/intel/qat/qat_c3xxx/adf_drv.c:69:9: error: implicit declaration of function 'adf_dbgfs_exit'; did you mean 'adf_dbgfs_init'? [-Werror=implicit-function-declaration]
drivers/crypto/intel/qat/qat_dh895xcc/adf_drv.c:69:9: error: implicit declaration of function 'adf_dbgfs_exit'; did you mean 'adf_dbgfs_init'? [-Werror=implicit-function-declaration]
drivers/crypto/intel/qat/qat_c62xvf/adf_drv.c:68:9: error: implicit declaration of function 'adf_dbgfs_exit'; did you mean 'adf_dbgfs_init'? [-Werror=implicit-function-declaration]
drivers/crypto/intel/qat/qat_c62x/adf_drv.c:69:9: error: implicit declaration of function 'adf_dbgfs_exit'; did you mean 'adf_dbgfs_init'? [-Werror=implicit-function-declaration]

Rename the function to match the normal one.

Fixes: 9260db6640a61 ("crypto: qat - move dbgfs init to separate file")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/crypto/intel/qat/qat_common/adf_dbgfs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/intel/qat/qat_common/adf_dbgfs.h b/drivers/crypto/intel/qat/qat_common/adf_dbgfs.h
index 1d64ad1a00374..e0cb2c2a2ed0b 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_dbgfs.h
+++ b/drivers/crypto/intel/qat/qat_common/adf_dbgfs.h
@@ -22,7 +22,7 @@ static inline void adf_dbgfs_rm(struct adf_accel_dev *accel_dev)
 {
 }
 
-static inline void adf_dbgfs_cleanup(struct adf_accel_dev *accel_dev)
+static inline void adf_dbgfs_exit(struct adf_accel_dev *accel_dev)
 {
 }
 #endif
-- 
2.39.2

