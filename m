Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 580336CF4E1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 22:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbjC2U4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 16:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjC2U4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 16:56:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CBD210FA
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 13:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680123350;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Nte51xjXiIM8Lvgz0EuSk0mf1Y4mOMuFslnvcEmaPvU=;
        b=gdnmDalkEm8C8unwHbT7UEs1M7JvGfYcOqoZftcYXutX9KUJ+x3AHM+XeXNyza3pKjvvVV
        nhVadv23DdAuGUyW2qsvYIHM0/wtKhIhnV/3R/ZaPr0rZ3+u5+8hCdhTYYSQwjPmGx6LIr
        dfoSC6+/hFuPC9m3ru0iWgdQR4qmmhc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-158-WRpWoYE3NUiF0AduRmvItQ-1; Wed, 29 Mar 2023 16:55:46 -0400
X-MC-Unique: WRpWoYE3NUiF0AduRmvItQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0975485A588;
        Wed, 29 Mar 2023 20:55:46 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6584A40BC797;
        Wed, 29 Mar 2023 20:55:45 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Lee Jones <lee@kernel.org>, Chen-Yu Tsai <wens@csie.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] mfd: axp20x: Fix axp288 writable-ranges
Date:   Wed, 29 Mar 2023 22:55:44 +0200
Message-Id: <20230329205544.1051393-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register AXP288_POWER_REASON is writable and needs to be written
to reset the reset- / power-on-reason bits.

Add it to the axp288 writable-ranges so that the extcon-axp288
driver can properly clear the reset- / power-on-reason bits.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/mfd/axp20x.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index 01a6bbb6d266..7720ac15c7d4 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -119,6 +119,7 @@ static const struct regmap_access_table axp22x_volatile_table = {
 
 /* AXP288 ranges are shared with the AXP803, as they cover the same range */
 static const struct regmap_range axp288_writeable_ranges[] = {
+	regmap_reg_range(AXP288_POWER_REASON, AXP288_POWER_REASON),
 	regmap_reg_range(AXP20X_DATACACHE(0), AXP20X_IRQ6_STATE),
 	regmap_reg_range(AXP20X_DCDC_MODE, AXP288_FG_TUNE5),
 };
-- 
2.39.1

