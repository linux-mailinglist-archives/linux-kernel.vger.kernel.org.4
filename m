Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA066E9B06
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 19:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbjDTRmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 13:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbjDTRme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 13:42:34 -0400
X-Greylist: delayed 599 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 20 Apr 2023 10:42:32 PDT
Received: from office2.cesnet.cz (office2.cesnet.cz [195.113.144.244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F721B5;
        Thu, 20 Apr 2023 10:42:32 -0700 (PDT)
Received: from enterprise-D.prg (unknown [94.142.238.97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by office2.cesnet.cz (Postfix) with ESMTPSA id 33E9640007C;
        Thu, 20 Apr 2023 19:22:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
        s=office2-2020; t=1682011356;
        bh=SUXILnLNP9xhXmVLWIYgxWv+q4S958kHVGoCjkMxmDY=;
        h=From:To:Cc:Subject:Date;
        b=KgGw4/57FBReT+WhPxv3gYxQw8vlYFEIjuBMBMJwgriskhiFKHs6LevlIzmT1k1I0
         mm2Zlsza9K1Tlpf99HQm6WSqf7Ox8PLX9aJVHvVkcB/NwunBAuoj5hSh9JHLq4FFfV
         12/A0w9LU6c3Ga7vZ3XBpDvrFOrJP3iiTfmFRP5SpLRHLyBgoO4w3fOMFdAO5I5wfh
         MkLG+IlOjHrKiCYGYSoEclAfXGxT++RwfEIQoTgZGwbZ2eTGkW41LrxvpfD6a6I921
         H/mZNBo7uwXz9d0VYzS3gZ89GM7siGbqPo+DqizrE9rvnrAjaa/ygwZEhtKBmgFlY9
         sznIdDio1fW1g==
From:   =?UTF-8?q?Tom=C3=A1=C5=A1=20Pecka?= <tomas.pecka@cesnet.cz>
To:     linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Tom=C3=A1=C5=A1=20Pecka?= <tomas.pecka@cesnet.cz>,
        =?UTF-8?q?Jan=20Kundr=C3=A1t?= <jan.kundrat@cesnet.cz>
Subject: [PATCH 1/1] hwmon: (pmbus/fsp-3y) Fix functionality bitmask in FSP-3Y YM-2151E
Date:   Thu, 20 Apr 2023 19:19:39 +0200
Message-Id: <20230420171939.212040-1-tomas.pecka@cesnet.cz>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bit flags in pmbus_driver_info functionality for YM-2151E chip were
joined with a comma operator instead of a bitwise OR. This means that
the last constant PMBUS_HAVE_IIN was not OR-ed with the other
PM_BUS_HAVE_* constants for this page but it initialized the next element
of the func array (which was not accessed from anywhere because of the
number of pages).

However, there is no need for setting PMBUS_HAVE_IIN in the 5Vsb page
because this command does not seem to be paged. Obviously, the device
only has one IIN sensor, so it doesn't make sense to query it again from
the second page.

Fixes: 1734b4135a62 ("hwmon: Add driver for fsp-3y PSUs and PDUs")
Co-developed-by: Jan Kundrát <jan.kundrat@cesnet.cz>
Signed-off-by: Jan Kundrát <jan.kundrat@cesnet.cz>
Signed-off-by: Tomáš Pecka <tomas.pecka@cesnet.cz>
---
 drivers/hwmon/pmbus/fsp-3y.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/hwmon/pmbus/fsp-3y.c b/drivers/hwmon/pmbus/fsp-3y.c
index aec294cc72d1..c7469d2cdedc 100644
--- a/drivers/hwmon/pmbus/fsp-3y.c
+++ b/drivers/hwmon/pmbus/fsp-3y.c
@@ -180,7 +180,6 @@ static struct pmbus_driver_info fsp3y_info[] = {
 			PMBUS_HAVE_FAN12,
 		.func[YM2151_PAGE_5VSB_LOG] =
 			PMBUS_HAVE_VOUT | PMBUS_HAVE_IOUT,
-			PMBUS_HAVE_IIN,
 		.read_word_data = fsp3y_read_word_data,
 		.read_byte_data = fsp3y_read_byte_data,
 	},
-- 
2.40.0

