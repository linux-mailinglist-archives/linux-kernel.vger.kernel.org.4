Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81657611BF2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 22:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiJ1U4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 16:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbiJ1U4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 16:56:03 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCC522D59C
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 13:56:00 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CD1676602943;
        Fri, 28 Oct 2022 21:55:57 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666990559;
        bh=k0ciXJ9TnsI96EclJ+3I0qJrPTH22yg0wvdKWox0Yts=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dr/5K/hxbGJrVT4XPuyjGzz/3Uum/9Fd9mrf8EQhK/6ZcWFGej3jAAgOHmJK//bUU
         TQ5J3NxsnHW67K1TKUI6HCXxr6VYdZNYNkXy6U3Mi7Q2Or18yPfN+v1v5XDd6c5lt1
         QwaBjBwtRR4uwm9gcArc0HucMg1BUNbGteR9UQEtJzbgGpk1P+dMokd3vbreQuEZ6u
         ceUiW+a+fnsAAT+As/738oHDRssJPvywt3jXdgwz+vNUYCQkAdrUG9p49oIXFdM8MR
         P++AX6xwtUG1mvI5Ro4y/msZiEOpqecj3RnAKuER9ICKw2cU0wjSEbrRiXLioin/47
         3BIwOoyt9X33g==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Mark Brown <broonie@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] ASoC: rt5682: Support dbvdd and ldo1-in supplies
Date:   Fri, 28 Oct 2022 16:55:38 -0400
Message-Id: <20221028205540.3197304-7-nfraprado@collabora.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221028205540.3197304-1-nfraprado@collabora.com>
References: <20221028205540.3197304-1-nfraprado@collabora.com>
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

Add support for the dbvdd and ldo1-in supplies.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---

 sound/soc/codecs/rt5682.c | 2 ++
 sound/soc/codecs/rt5682.h | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5682.c b/sound/soc/codecs/rt5682.c
index 2df95e792900..f0a400285dcf 100644
--- a/sound/soc/codecs/rt5682.c
+++ b/sound/soc/codecs/rt5682.c
@@ -35,6 +35,8 @@ const char *rt5682_supply_names[RT5682_NUM_SUPPLIES] = {
 	"AVDD",
 	"MICVDD",
 	"VBAT",
+	"dbvdd",
+	"ldo1-in",
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

