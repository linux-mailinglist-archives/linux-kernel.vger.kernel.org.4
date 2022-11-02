Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA08616BF4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 19:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbiKBSUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 14:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiKBSUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 14:20:20 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB9E2F395
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 11:20:19 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (unknown [IPv6:2600:4041:5b1a:cd00:524d:e95d:1a9c:492a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8E717660294A;
        Wed,  2 Nov 2022 18:20:16 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667413217;
        bh=XepAn8pB00cuXojd4bCKRy311k713d3dutRJPgty0oM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FXJbnowpj5fivK9/7RYMlEUHYX3i70/CGppSC/K753X5zCcVnZIVSNe5eQzrbpUGK
         o6MQKi59CXaw7joeYP7u9foYRYffcqjpO076/MIWUY3U3TLJDxB4knOsD2/WnjUqLn
         703LFdCLHYCGp+Lg4yfaFjoKytN3Lk4kYeAqgpvcD9AxjviRW68Q3mn324xqCmX2vS
         nObwWqX4yLwAQtlcgK0GJ5UFUgjVDQ6V8cOz0Bz9AaGR0Jx5VpN74vO70aZUgfyLV4
         tXqyONUQ66Po4vvYuVZFWZZVcKmBOc1R3eEA+MVAwGDHsDdLxaFDKFNUw2tYCG4PYB
         zg9xSGElm4ILg==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Mark Brown <broonie@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/8] ASoC: rt5682: Support DBVDD and LDO1-IN supplies
Date:   Wed,  2 Nov 2022 14:20:00 -0400
Message-Id: <20221102182002.255282-7-nfraprado@collabora.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221102182002.255282-1-nfraprado@collabora.com>
References: <20221102182002.255282-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the DBVDD and LDO1-IN supplies.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

Changes in v2:
- Made names uppercase

 sound/soc/codecs/rt5682.c | 2 ++
 sound/soc/codecs/rt5682.h | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5682.c b/sound/soc/codecs/rt5682.c
index 2df95e792900..7e3eb65afe16 100644
--- a/sound/soc/codecs/rt5682.c
+++ b/sound/soc/codecs/rt5682.c
@@ -35,6 +35,8 @@ const char *rt5682_supply_names[RT5682_NUM_SUPPLIES] = {
 	"AVDD",
 	"MICVDD",
 	"VBAT",
+	"DBVDD",
+	"LDO1-IN",
 };
 EXPORT_SYMBOL_GPL(rt5682_supply_names);
 
diff --git a/sound/soc/codecs/rt5682.h b/sound/soc/codecs/rt5682.h
index 52ff0d9c36c5..d568c6993c33 100644
--- a/sound/soc/codecs/rt5682.h
+++ b/sound/soc/codecs/rt5682.h
@@ -1424,7 +1424,7 @@ enum {
 	RT5682_CLK_SEL_I2S2_ASRC,
 };
 
-#define RT5682_NUM_SUPPLIES 3
+#define RT5682_NUM_SUPPLIES 5
 
 struct rt5682_priv {
 	struct snd_soc_component *component;
-- 
2.38.1

