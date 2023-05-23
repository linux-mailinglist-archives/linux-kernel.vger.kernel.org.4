Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B882470E001
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 17:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237253AbjEWPMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 11:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237458AbjEWPMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 11:12:46 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49DA139;
        Tue, 23 May 2023 08:12:43 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id C2404C000C;
        Tue, 23 May 2023 15:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1684854762;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iaB/0wDo6caLF16LcGUil+N2SlVgAqTWL0MVlJHk1e0=;
        b=SHHtcMfh8AILZzywUiY+JuAsqPsBNtIXcI99+1kFaoQx5tj45NNugTxMOGHKc9hsTpwRQt
        rekNusNg0UOA9IZBQjhpH6EnJljUKPtYlMsujlxrj9Pdi8NLBEzE5+3kImsVnYjIwY8hwH
        tFx7JS/y8wGDFj3ki1R0Gg3gk8tqZ1KTbXxxm6netGuSSOd1LxYP/puO8boVlj/KFEbNEQ
        tTcDj0Xb17GTmOJX/tWtfSzWYp1vX4LV6zx3Vs64lntAwgGStP3ZRyP489WiO7pyKuVLbV
        /rnhF87CmiYy8fNos+Ria3POWqavMpiBPD1d7l1w4hcgPh9m46SMxDrE/jy1vg==
From:   Herve Codina <herve.codina@bootlin.com>
To:     Herve Codina <herve.codina@bootlin.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v2 3/9] iio: inkern: Check error explicitly in iio_channel_read_max()
Date:   Tue, 23 May 2023 17:12:17 +0200
Message-Id: <20230523151223.109551-4-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230523151223.109551-1-herve.codina@bootlin.com>
References: <20230523151223.109551-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current implementation returns the error code as part of the
default switch case.
This can lead to returning an incorrect positive value in case of
iio_avail_type enum entries evolution.

In order to avoid this case, be more strict in error checking.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/iio/inkern.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index 872fd5c24147..f738db9a0c04 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -858,6 +858,9 @@ static int iio_channel_read_max(struct iio_channel *chan,
 		val2 = &unused;
 
 	ret = iio_channel_read_avail(chan, &vals, type, &length, info);
+	if (ret < 0)
+		return ret;
+
 	switch (ret) {
 	case IIO_AVAIL_RANGE:
 		switch (*type) {
@@ -888,7 +891,7 @@ static int iio_channel_read_max(struct iio_channel *chan,
 		return 0;
 
 	default:
-		return ret;
+		return -EINVAL;
 	}
 }
 
-- 
2.40.1

