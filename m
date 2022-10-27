Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44DCC60F68C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 13:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235405AbiJ0Lws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 07:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234933AbiJ0Lwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 07:52:45 -0400
X-Greylist: delayed 61 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 27 Oct 2022 04:52:43 PDT
Received: from mailrelay1-1.pub.mailoutpod1-cph3.one.com (mailrelay1-1.pub.mailoutpod1-cph3.one.com [46.30.210.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1A0A3B54
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 04:52:43 -0700 (PDT)
Received: from mailrelay2.pub.mailoutpod2-cph3.one.com (mailrelay2.pub.mailoutpod2-cph3.one.com [104.37.34.7])
        by mailrelay1.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPS
        id b7a39daf-55ed-11ed-a6d5-d0431ea8a283;
        Thu, 27 Oct 2022 11:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=berginkonsult.se; s=rsa1;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
         from;
        bh=JC/HHWF4gaghp1JRdLxc59f6ipPtlD2CyXsBq4Sp1Sk=;
        b=FL7ERPP2jG+w/KDqVlq8iIsOMXYp5+kwuyX/Hy4PTBFQFqsMPBLjdz/JjcAJhAlIB9a2xo3CwJUxN
         +rZ6rKRUDIZrf1o6mS7OHL8pcGn/23WFSJqKYaN/gp4ppfXo51QuvBEgtmIepDtBbD54TFoBRa8dRp
         HtERZnucLABLL/BpO8igalzhBQ44nntPsY5Ss3hVAJBbVjggwbuTGUd2xSmEgOevimZfqBVbKq63Eb
         Gg06emRF9cgjsw9o2FnWxUWgCqGM0DE5FQ+qiWpaN1xgZQaXauzgQ/sN4FiLww0ONFTHxkLmDoKqKj
         l2xr0alXxA2OA2ldcEUxfvQQfKAd4Cg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=berginkonsult.se; s=ed1;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
         from;
        bh=JC/HHWF4gaghp1JRdLxc59f6ipPtlD2CyXsBq4Sp1Sk=;
        b=3VKMLIL+XpEr8iGvmz0W5KovJn1ZtaEUXk0s0Gz0lL4KcY9W57xEqlCrOOtV6uNk/C+ynDwQ3NLSh
         j1pe7nFBQ==
X-HalOne-ID: b46a7e99-55ed-11ed-9b66-335755252108
Received: from pbergin-7420.. (ua-213-113-159-147.bbcust.telenor.se [213.113.159.147])
        by mailrelay2 (Halon) with ESMTPSA
        id b46a7e99-55ed-11ed-9b66-335755252108;
        Thu, 27 Oct 2022 11:51:38 +0000 (UTC)
From:   Peter Bergin <peter@berginkonsult.se>
To:     james.schulman@cirrus.com, david.rhodes@cirrus.com,
        tanureal@opensource.cirrus.com, rf@opensource.cirrus.com
Cc:     Peter Bergin <peter@berginkonsult.se>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoc: cs42xx8-i2c.c: add module device table for of
Date:   Thu, 27 Oct 2022 13:50:56 +0200
Message-Id: <20221027115057.442925-1-peter@berginkonsult.se>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When trying to connect the device with the driver through of
it is not working. The of_device_id is defined in cs42xx8.c
but is not correctly included in cs42xx8-i2c.c. Also add the
matching table for of in the i2c file.

Signed-off-by: Peter Bergin <peter@berginkonsult.se>
---
 sound/soc/codecs/cs42xx8-i2c.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/codecs/cs42xx8-i2c.c b/sound/soc/codecs/cs42xx8-i2c.c
index cb06a06d48b0..6e8ee28d01f8 100644
--- a/sound/soc/codecs/cs42xx8-i2c.c
+++ b/sound/soc/codecs/cs42xx8-i2c.c
@@ -37,6 +37,13 @@ static int cs42xx8_i2c_remove(struct i2c_client *i2c)
 	return 0;
 }
 
+const struct of_device_id cs42xx8_of_match[] = {
+	{ .compatible = "cirrus,cs42448", .data = &cs42448_data, },
+	{ .compatible = "cirrus,cs42888", .data = &cs42888_data, },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, cs42xx8_of_match);
+
 static struct i2c_device_id cs42xx8_i2c_id[] = {
 	{"cs42448", (kernel_ulong_t)&cs42448_data},
 	{"cs42888", (kernel_ulong_t)&cs42888_data},
-- 
2.34.1

