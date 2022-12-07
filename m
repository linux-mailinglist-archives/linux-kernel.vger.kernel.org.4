Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B013A64588D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 12:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbiLGLF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 06:05:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiLGLEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 06:04:33 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76DF66310;
        Wed,  7 Dec 2022 03:04:32 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2B7B4Omv037969;
        Wed, 7 Dec 2022 05:04:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1670411064;
        bh=moSwcrtdc2VcL4UbDo5DFCfc4fFaFAeMJQwGjXExzgA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=QjP3xLc5E4SA1wHRXyhFPc8RmAUxGtADTemWmW5oDn9aK6oHmQI4cy84KNF7LfjaE
         ft8jUHigr7fQbgq/zMcjYoowkpbs98vxmR0pIjcSnfmCttvc1OGl3kkktnz21szT65
         dVV1gcbkI/TWFu6khoFAwjh8MFO0dAgRo1og8/ys=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2B7B4O3o106704
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 7 Dec 2022 05:04:24 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 7
 Dec 2022 05:04:23 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 7 Dec 2022 05:04:23 -0600
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2B7B4NWB019065;
        Wed, 7 Dec 2022 05:04:23 -0600
Received: from localhost (a0501179-pc.dhcp.ti.com [10.24.69.114])
        by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 2B7B4M3x004506;
        Wed, 7 Dec 2022 05:04:23 -0600
From:   MD Danish Anwar <danishanwar@ti.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Suman Anna <s-anna@ti.com>, Roger Quadros <rogerq@kernel.org>,
        "Andrew F . Davis" <afd@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <srk@ti.com>, <linux-remoteproc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        MD Danish Anwar <danishanwar@ti.com>
Subject: [PATCH v11 4/6] remoteproc: pru: Make sysfs entries read-only for PRU client driven boots
Date:   Wed, 7 Dec 2022 16:34:09 +0530
Message-ID: <20221207110411.441692-5-danishanwar@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221207110411.441692-1-danishanwar@ti.com>
References: <20221207110411.441692-1-danishanwar@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suman Anna <s-anna@ti.com>

The PRU remoteproc driver is not configured for 'auto-boot' by default,
and allows to be booted either by in-kernel PRU client drivers or by
userspace using the generic remoteproc sysfs interfaces. The sysfs
interfaces should not be permitted to change the remoteproc firmwares
or states when a PRU is being managed by an in-kernel client driver.
Use the newly introduced remoteproc generic 'sysfs_read_only' flag to
provide these restrictions by setting and clearing it appropriately
during the PRU acquire and release steps.

Signed-off-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
Reviewed-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/remoteproc/pru_rproc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/remoteproc/pru_rproc.c b/drivers/remoteproc/pru_rproc.c
index 7d4ed39b3772..bca7550d79d2 100644
--- a/drivers/remoteproc/pru_rproc.c
+++ b/drivers/remoteproc/pru_rproc.c
@@ -228,6 +228,7 @@ struct rproc *pru_rproc_get(struct device_node *np, int index,
 	}
 
 	pru->client_np = np;
+	rproc->sysfs_read_only = true;
 
 	mutex_unlock(&pru->lock);
 
@@ -266,6 +267,7 @@ void pru_rproc_put(struct rproc *rproc)
 	}
 
 	pru->client_np = NULL;
+	rproc->sysfs_read_only = false;
 	mutex_unlock(&pru->lock);
 
 	rproc_put(rproc);
-- 
2.25.1

