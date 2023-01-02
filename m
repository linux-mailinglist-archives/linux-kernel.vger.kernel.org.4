Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5149A65B76F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 22:39:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbjABVjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 16:39:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbjABVjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 16:39:13 -0500
X-Greylist: delayed 589 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 02 Jan 2023 13:39:12 PST
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [71.19.156.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155E2B1C2;
        Mon,  2 Jan 2023 13:39:11 -0800 (PST)
Received: from hatter.bewilderbeest.net (97-113-250-99.tukw.qwest.net [97.113.250.99])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 406C59E;
        Mon,  2 Jan 2023 13:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1672694962;
        bh=GXgDixVN2v8Oc04bdIaziXMcEz5MIwaiT/ZeCIbmMqg=;
        h=From:To:Cc:Subject:Date:From;
        b=LTo8r23kLZD/9lLzLaWNLTP/6Dg6z3BRlTzUrenvQhgu9oicIvVfsabH7qgFq+C3s
         m6qVzEDjDUmwS2LBtrI6pSntjkJLMLc3muR5/dQYvwEelvUZcYfz74LQvrKmjEPowr
         2JbR13BmxyPDwtwgPI98k84CaSFBMPkuakdW/B9o=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org
Cc:     Zev Weiss <zev@bewilderbeest.net>, Joel Stanley <joel@jms.id.au>,
        Denis Pauk <pauk.denis@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-kernel@vger.kernel.org, stable@kernel.org
Subject: [PATCH] hwmon: (nct6775) Fix incorrect parenthesization in nct6775_write_fan_div()
Date:   Mon,  2 Jan 2023 13:28:57 -0800
Message-Id: <20230102212857.5670-1-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 4ef2774511dc ("hwmon: (nct6775) Convert register access to
regmap API") fumbled the shifting & masking of the fan_div values such
that odd-numbered fan divisors would always be set to zero.  Fix it so
that we actually OR in the bits we meant to.

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
Fixes: 4ef2774511dc ("hwmon: (nct6775) Convert register access to regmap API")
Cc: stable@kernel.org # v5.19+
---

This bug got noticed during review [0] and the fix was incorporated
into v3 of the patch series [1], but then I somehow managed to
accidentally revert the fix in v4 [2] that actually got applied.

I'm fairly confident this is correct, but I don't have any nct6775
hardware to test on (this code path is only used on that specific
chip, not others in the family).  If any one who does can try it out
and report back that would of course be welcome.

[0] https://lore.kernel.org/linux-hwmon/YiiMfJV3bjUmoUcV@hatter.bewilderbeest.net/
[1] https://lore.kernel.org/linux-hwmon/20220426071848.11619-3-zev@bewilderbeest.net/
[2] https://lore.kernel.org/linux-hwmon/20220427010154.29749-3-zev@bewilderbeest.net/

 drivers/hwmon/nct6775-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/nct6775-core.c b/drivers/hwmon/nct6775-core.c
index da9ec6983e13..c54233f0369b 100644
--- a/drivers/hwmon/nct6775-core.c
+++ b/drivers/hwmon/nct6775-core.c
@@ -1150,7 +1150,7 @@ static int nct6775_write_fan_div(struct nct6775_data *data, int nr)
 	if (err)
 		return err;
 	reg &= 0x70 >> oddshift;
-	reg |= data->fan_div[nr] & (0x7 << oddshift);
+	reg |= (data->fan_div[nr] & 0x7) << oddshift;
 	return nct6775_write_value(data, fandiv_reg, reg);
 }
 
-- 
2.39.0

