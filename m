Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA39B5FDC0B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 16:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbiJMOHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 10:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbiJMOHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 10:07:17 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42972E4E73;
        Thu, 13 Oct 2022 07:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1665670026; x=1697206026;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=M95794CvE0b+k1MQoKB2cxEU+pt2sTYB/NtVXxB7JIE=;
  b=fbL9NKqukNzEQ4juH6m6qUEXcLLC6Qwpt4candjqF7Hhso4ufhO81j+5
   8QZd/K2ogQtDXIKchQjCL77P7O33YN4P4N+G5E1W3gGq/uHIK9xopQJA2
   gieEHakOynWSPdvBAUm7YyKCyuYhUq3HjFx4OLDMdiH1pFNWERqe/x/49
   DK0fKtUNGlOhBwBsJI+HjEJLzHcZNkGQQI33YsHHR4WiJFzM+4tsKXdsE
   TIBKWJOHVWRGFYHSNRb7A/0CyKiwi8q4Ui6tVL8KJgesJpADjlgHXknFW
   IZn9qJC5VtQLXUpxBD035kyjSbPpb8tLE83gpXivmtgSFQurceDW3WeQq
   w==;
X-IronPort-AV: E=Sophos;i="5.95,180,1661810400"; 
   d="scan'208";a="26738230"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 13 Oct 2022 16:00:09 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Thu, 13 Oct 2022 16:00:09 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Thu, 13 Oct 2022 16:00:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1665669609; x=1697205609;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=M95794CvE0b+k1MQoKB2cxEU+pt2sTYB/NtVXxB7JIE=;
  b=eWJDtf4LXUvuHRXqn0WpqHpCXI5iTy4ztzHxblPHrAxAzEXlqpjh+c4J
   XvI/+AIOLfjV3oK2c2Ot/fr8lUlG0UbfOmGPy8+H5HXdtBaSACBqBoHCB
   ePJrPooWJuybbnuZBQQz5b3E1eE4xA3iZ24q+/M8qWDx5QKUw5J+q4BsM
   dvXGE3EozER90zuqCeSDszeXv89hZjKHkZwPJZdpGH+L89fY3cOL7qW4Z
   ZKKUgZBdtOAVsx7NT11XLB0f2paHelhfCKR7rt6vhlIzmb6PobxnENcN4
   JML6gQk7Rx/K3XYuDLQRi72I1QDU3cVML//LpLeDxw9UAAeQ1HNTbeTgj
   g==;
X-IronPort-AV: E=Sophos;i="5.95,180,1661810400"; 
   d="scan'208";a="26738229"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 13 Oct 2022 16:00:09 +0200
Received: from localhost.localdomain (SCHIFFERM-M2.tq-net.de [10.121.49.14])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 8D6F1280056;
        Thu, 13 Oct 2022 16:00:09 +0200 (CEST)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH] hwmon: (pwm-fan) Explicitly switch off fan power when setting pwm1_enable to 0
Date:   Thu, 13 Oct 2022 15:59:51 +0200
Message-Id: <20221013135951.4902-1-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When pwm1_enable is changed from 1 to 0 while pwm1 == 0, the regulator
is not switched off as expected. The reason is that when the fan is
already off, ctx->enabled is false, so pwm_fan_power_off() will be a
no-op.

Handle this case explicitly in pwm_fan_update_enable() by calling
pwm_fan_switch_power() directly.

Fixes: b99152d4f04b ("hwmon: (pwm-fan) Switch regulator dynamically")
Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 drivers/hwmon/pwm-fan.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
index dc3d9a22d917..83a347ca35da 100644
--- a/drivers/hwmon/pwm-fan.c
+++ b/drivers/hwmon/pwm-fan.c
@@ -257,7 +257,10 @@ static int pwm_fan_update_enable(struct pwm_fan_ctx *ctx, long val)
 
 	if (val == 0) {
 		/* Disable pwm-fan unconditionally */
-		ret = __set_pwm(ctx, 0);
+		if (ctx->enabled)
+			ret = __set_pwm(ctx, 0);
+		else
+			ret = pwm_fan_switch_power(ctx, false);
 		if (ret)
 			ctx->enable_mode = old_val;
 		pwm_fan_update_state(ctx, 0);
-- 
2.25.1

