Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1C41706658
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 13:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbjEQLO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 07:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbjEQLOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 07:14:42 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8434626AA
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 04:14:40 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-965f7bdab6bso111872466b.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 04:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684322079; x=1686914079;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8f/Ov+L9lgAMMtQvsESvWR48vQlBSC6eGHRApShSvK4=;
        b=sIfEiJbFesnboqrvDwg/JbxitCUki5aOESmQeTg6BQTaFmpQel55ARJNOzBd8Mm4FZ
         fL+tqM9jp+I4U1fmvk7eAQehUtyk/TO+AAf9RFsKbKkkeNL6LvaF4LYZf9tyVKUlhdHG
         i/DH2lMxWzJ7WPE4l4CfVfUWeP2GrHWEytoP6jrQX7Zkda97O0tWivR4CwTB9QHVEG1K
         rBrCq0Y2omMSb5Z4kuCIJMQcJtoef5ryB9wcSy0/JXqX6taG1+ccb7qg58us2ne/Zb0p
         7V10XrAmSJFkQZ4ZLTGvktUpzOfMUh1Q3cz8HYSdwZJS0JiMw8iiZs2Yq8MuIiFD1/N1
         tN3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684322079; x=1686914079;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8f/Ov+L9lgAMMtQvsESvWR48vQlBSC6eGHRApShSvK4=;
        b=USG+B8m8dFBtOuwW1VlAu7vVzzRGDDTWrpReOjqyg5GXQ2w/pbZyOb9txGN4elu/nJ
         6yLxBu0n1qtPjNZnpQFxUQebk033Oaaudk2FvpsVFUtpneyYgbv5a0ra2KAr7UniQPJ2
         GjhxuBkTe8NyHRsSke2yW8HoNTb24FX/IUCtZFRtDLAKYeqbeAGoFeq2CJjSaFNgpEzZ
         MaJpdNwFZ3z4ZqrPAZEeC3Ph/GeLgfFvdT/jHo8LQFZYTb+4Yx7dXI5kEVUaVwTtfZ+s
         RZzMAgDWY+Q0MaWqe8EReVBvRNO8nTms7PaJRoJ5ra7Co4/XBilu55i7Eokl7cYi3gKy
         /4qg==
X-Gm-Message-State: AC+VfDwhgfWiF3m4OwbuJLe+chvfdaIKtu5Kr1TS7umhTidl/9s4JfoL
        YsKlchlb2P/Wm0jNwNKdOx6Db52ndYFZmVFhe4s=
X-Google-Smtp-Source: ACHHUZ4W3Tqy+kmA5/CrSkwq+i+Z6QU84MiGKQFNv45sP/3v7DwL6mlpqoPP47j1FG0KjZyNBcEakA==
X-Received: by 2002:a17:906:9c83:b0:95f:4889:412a with SMTP id fj3-20020a1709069c8300b0095f4889412amr39964429ejc.33.1684322078958;
        Wed, 17 May 2023 04:14:38 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:c9ff:4c84:dd21:568d])
        by smtp.gmail.com with ESMTPSA id ml18-20020a170906cc1200b0094f124a37c4sm12326880ejb.18.2023.05.17.04.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 04:14:38 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 01/12] ASoC: codecs: rt1308: do not store status in state container
Date:   Wed, 17 May 2023 13:14:05 +0200
Message-Id: <20230517111416.424420-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Driver in its update status callback stores Soundwire device status in
state container but it never uses it later.  Simplify the code a bit.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/rt1308-sdw.c | 5 +----
 sound/soc/codecs/rt1308-sdw.h | 1 -
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/sound/soc/codecs/rt1308-sdw.c b/sound/soc/codecs/rt1308-sdw.c
index 1797af824f60..313e97c94532 100644
--- a/sound/soc/codecs/rt1308-sdw.c
+++ b/sound/soc/codecs/rt1308-sdw.c
@@ -304,9 +304,6 @@ static int rt1308_update_status(struct sdw_slave *slave,
 {
 	struct  rt1308_sdw_priv *rt1308 = dev_get_drvdata(&slave->dev);
 
-	/* Update the status */
-	rt1308->status = status;
-
 	if (status == SDW_SLAVE_UNATTACHED)
 		rt1308->hw_init = false;
 
@@ -314,7 +311,7 @@ static int rt1308_update_status(struct sdw_slave *slave,
 	 * Perform initialization only if slave status is present and
 	 * hw_init flag is false
 	 */
-	if (rt1308->hw_init || rt1308->status != SDW_SLAVE_ATTACHED)
+	if (rt1308->hw_init || status != SDW_SLAVE_ATTACHED)
 		return 0;
 
 	/* perform I/O transfers required for Slave initialization */
diff --git a/sound/soc/codecs/rt1308-sdw.h b/sound/soc/codecs/rt1308-sdw.h
index 04ff18fa18e2..f816c73e247e 100644
--- a/sound/soc/codecs/rt1308-sdw.h
+++ b/sound/soc/codecs/rt1308-sdw.h
@@ -159,7 +159,6 @@ struct rt1308_sdw_priv {
 	struct snd_soc_component *component;
 	struct regmap *regmap;
 	struct sdw_slave *sdw_slave;
-	enum sdw_slave_status status;
 	struct sdw_bus_params params;
 	bool hw_init;
 	bool first_hw_init;
-- 
2.34.1

