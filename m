Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B36256B54B0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 23:42:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbjCJWmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 17:42:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231879AbjCJWmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 17:42:08 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5029214FE05
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 14:41:44 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1palQh-0002dE-9u; Fri, 10 Mar 2023 23:41:39 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1palQf-003GqY-Fa; Fri, 10 Mar 2023 23:41:37 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1palQe-003uEi-NF; Fri, 10 Mar 2023 23:41:36 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Roy Pledge <Roy.Pledge@nxp.com>, Li Yang <leoyang.li@nxp.com>
Cc:     kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 5/6] soc: fsl: dpio: Suppress duplicated error reporting on device remove
Date:   Fri, 10 Mar 2023 23:41:27 +0100
Message-Id: <20230310224128.2638078-6-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230310224128.2638078-1-u.kleine-koenig@pengutronix.de>
References: <20230310224128.2638078-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1085; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=jrvcriG6LY6cgmfGJKCy0SYPFV25hxPQL+k/hItVWeg=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkC7IP8/ceFmpLmvUa+JsfOgJYo497N77Opym3s j+VaP7QeOGJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAuyDwAKCRDB/BR4rcrs CVd8B/0VPto9yl5L2YKsfnTkyeyixLFuoF5giyuRmEzixWQLgAOxwFlkNcvGPkZ90qZb21QU1mo Kpbs8F6zt3hXiJVvZkdaUt6uMVRB+lQaRELXDQuwrKi8hYbMGkumj0DA0FakSoQQrn1ouqd/T1S Ww8QCmU/aAl5ncKRoJZVQq20saEPSV0TPAj2QcjhHvOnjXRxt9QPjOt3UWJd5cezIJn5fEongop 0mVDsnqLmNQnn94Dw47gAAU1Zb9l94LVWyzPl8Qoxt6GxIZhT4uFBg0Hq5CT4RCSIX2J/eNV+dP 6bCsDwjxVFhZvC+ebQoPTnRGNS1ibo9X9qG7BsdO5O0B5J8g
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Returning an error code from a fsl_mc_driver's remove callback results
in a generic error message, otherwise the value is ignored and the device
gets unbound.

As the only error path in dpaa2_dpio_remove() already emits an error
message, return zero unconditionally to suppress another (less helpful)
error report.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/soc/fsl/dpio/dpio-driver.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/soc/fsl/dpio/dpio-driver.c b/drivers/soc/fsl/dpio/dpio-driver.c
index 74eace3109a1..09df5302d255 100644
--- a/drivers/soc/fsl/dpio/dpio-driver.c
+++ b/drivers/soc/fsl/dpio/dpio-driver.c
@@ -297,14 +297,10 @@ static int dpaa2_dpio_remove(struct fsl_mc_device *dpio_dev)
 
 	dpio_close(dpio_dev->mc_io, 0, dpio_dev->mc_handle);
 
-	fsl_mc_portal_free(dpio_dev->mc_io);
-
-	return 0;
-
 err_open:
 	fsl_mc_portal_free(dpio_dev->mc_io);
 
-	return err;
+	return 0;
 }
 
 static const struct fsl_mc_device_id dpaa2_dpio_match_id_table[] = {
-- 
2.39.1

