Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9D464FC93
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 23:13:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiLQWNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 17:13:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiLQWNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 17:13:41 -0500
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1707DF5BF;
        Sat, 17 Dec 2022 14:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=VXdDjaKjNgqzgz5N9G89jtZt4Zpl7V9U1dIBQVr4Qfs=; b=Fz6ggJX6gJBiW/Dws/3FR1gu5N
        Ne7LxDyxOEsqcniNGPvLW2TJHn9JiX821s6vX2vBr12EuMUBHJzm4SW93LvmWeFPm7KyHZgCOg4+b
        yDbs0H2b/fEOarQkKWtJffpGhl3Z7SuN1Uu/SWtSp4f2oZlMxJaX5hT8gHEPJAo9nmAu1HIeieraK
        wnF9pu/ss6koQxUnEEL7Izc468bP2N7z94A8ApcNa4zaJEw8cE6VToUjLeoc5GymO9BfJUuXF5SmC
        VO9RUyoXjqVozyW6jMVXocysf0Cfg/1Yrzq8b9ZcLHY1ezqTN7RrMGA/mu8t7MPj1DlSdUFL2JJKZ
        9O08/5GA==;
Received: from p200300ccff28b2001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff28:b200:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1p6fQk-0001Pw-6c; Sat, 17 Dec 2022 23:13:18 +0100
Received: from andi by aktux with local (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1p6fQj-002obI-Ec; Sat, 17 Dec 2022 23:13:17 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     jic23@kernel.org, lars@metafoo.de, andreas@kemnade.info,
        paul@crapouillou.net, jiasheng@iscas.ac.cn,
        oleksandr.kozaruk@ti.com, gg@slimlogic.co.uk, balajitk@ti.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>,
        Julia Lawall <julia.lawall@lip6.fr>
Subject: [PATCH] iio:adc:twl6030: Enable measurement of VAC
Date:   Sat, 17 Dec 2022 23:13:05 +0100
Message-Id: <20221217221305.671117-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0 (-)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VAC needs to be wired up to produce proper measurements,
without this change only near zero values are reported.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Julia Lawall <julia.lawall@lip6.fr>
Fixes: 1696f36482e7 ("iio: twl6030-gpadc: TWL6030, TWL6032 GPADC driver")
Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/iio/adc/twl6030-gpadc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/twl6030-gpadc.c b/drivers/iio/adc/twl6030-gpadc.c
index 40438e5b4970..32873fb5f367 100644
--- a/drivers/iio/adc/twl6030-gpadc.c
+++ b/drivers/iio/adc/twl6030-gpadc.c
@@ -952,7 +952,7 @@ static int twl6030_gpadc_probe(struct platform_device *pdev)
 	}
 
 	ret = twl_i2c_write_u8(TWL6030_MODULE_ID0,
-				VBAT_MEAS | BB_MEAS | BB_MEAS,
+				VBAT_MEAS | BB_MEAS | VAC_MEAS,
 				TWL6030_MISC1);
 	if (ret < 0) {
 		dev_err(dev, "failed to wire up inputs\n");
-- 
2.30.2

