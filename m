Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABA247504FC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 12:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232383AbjGLKmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 06:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjGLKmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 06:42:04 -0400
X-Greylist: delayed 411 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 12 Jul 2023 03:41:36 PDT
Received: from dnyon.com (dnyon.com [142.132.167.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12DB41BF1;
        Wed, 12 Jul 2023 03:41:35 -0700 (PDT)
From:   Alejandro Tafalla <atafalla@dnyon.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dnyon.com; s=mail;
        t=1689158081; bh=bGyo1wljSN6sMXsgG0TGkkh5oZD/nbfLTmlrLE9H9iM=;
        h=From:To:Cc:Subject;
        b=MmBN4nyDuViC+upACQkHqpQvdK+tGsRWr9JhuFC3NLbpkyG6dZjfuZGYrAFZJZdFi
         U3AtW6eu1t9pEsxEfm5UMYBrQJaDw6xZ/9NxtBf0L5963qjEYdL4pSu/uM45vAjEjM
         6a5eb3+wRyfjOg4D6nzw11AXtHFFKpVuoNObKiPk1p/czZNUiyu/7c5utLtnYsNZBZ
         BP7gGTMVUtDIcmyqy+JUynmV7DlDLkg7AEjXr4utaOrPMF75+1u5Uhb6KyK/+0e6WZ
         YAXiY+uNHVIiIL19cHDbzbrIcBXjOtngpCaYMckW7xtAETaIecJIL2SYZXrRFj7eXB
         vhC7i6+TNCjKY3N9HI4s8TmXon7U14NBIBpP0ElxM7uaLeqyuGfWnr4+T00J9mQGYw
         Yk/BcHheD9UAlhxP/zjp/lXmLmzEmuVeLEzlGUXfB77Le56wqvNkp7hDnD0zHdIZ64
         Mvho/PMdApQLYtHc5cISKA6eAxaKVVhgX30rD8be77BmG6Qhqo9y/71rSnUTuXAxw3
         ycnZIOfWZRG0z0ok1oQKUv/AyIjKulw5Y/0BOHIxiKhMdltpcrfTdOKlysoEKZ8UpY
         Wt6IF4G85fuqr2g63T/RsVUgaeCn5ndAMq6owD/VG666q+c+qjEe0ETLQIIcWnHN1Y
         Giul1YMyqUS8qj10JxUH0At8=
To:     lorenzo@kernel.org, jic23@kernel.org, lars@metafoo.de
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH] iio: imu: lsm6dsx: Fix mount matrix retrieval
Date:   Wed, 12 Jul 2023 12:32:42 +0200
Message-ID: <12960181.O9o76ZdvQC@alexpc>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function lsm6dsx_get_acpi_mount_matrix should return true when ACPI
support is not enabled to allow executing iio_read_mount_matrix in the
probe function.

Fixes: dc3d25f22b88 ("iio: imu: lsm6dsx: Add ACPI mount matrix retrieval")

Signed-off-by: Alejandro Tafalla <atafalla@dnyon.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/
st_lsm6dsx/st_lsm6dsx_core.c
index 6a18b363cf73..62bc3ee783fb 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -2687,7 +2687,7 @@ static int lsm6dsx_get_acpi_mount_matrix(struct device 
*dev,
 static int lsm6dsx_get_acpi_mount_matrix(struct device *dev,
 					  struct 
iio_mount_matrix *orientation)
 {
-	return false;
+	return true;
 }
 
 #endif
-- 
2.41.0




