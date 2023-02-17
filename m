Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2DC69A9E7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 12:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjBQLKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 06:10:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjBQLKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 06:10:23 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B96666CC8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 03:09:36 -0800 (PST)
Received: from cryzen.lan (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net [82.11.51.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: tanureal)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E28EC66021BF;
        Fri, 17 Feb 2023 11:09:34 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676632175;
        bh=BB0n+xkJc9Xy7B2lrptZGE8c8ONrpfeHbm8HJDJyX4Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Owx1Fal5qKGwyYicswEJSQOBMj7gxD9DDYR/igas+T58x5HIE0le86mCtQPe5Fnfe
         DtSQlulkS/1R9xEtRv9Hd/NPQZGGgxvzv3IkM69YFTNBRdm5NMfb/srQ+IY3Q/nLqG
         WwIz+iZN4LN530g4z0Fbbmz6Im4Eu/Qth3xFDT/g8d4PArOXoGoKyddCgQatr0/8Oj
         9VDXoIBJKd2fbTg8fUqdoOLsC4pBfLLtzDtxhy1tSCJhvfbZwpB9v3ncWGhPTZWYwV
         RYDcwwecJTX9Xw7j0M/a5SRNwsOTqSzHCPMg43lyjXgfLg2ffIB12gCk2ica1vurRu
         boQQ2O5mciIew==
From:   Lucas Tanure <lucas.tanure@collabora.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Lucas Tanure <lucas.tanure@collabora.com>, kernel@collabora.com
Subject: [PATCH v2 3/9] ASoC: amd: vangogh: use sizeof of variable instead of struct type
Date:   Fri, 17 Feb 2023 11:08:44 +0000
Message-Id: <20230217110850.1045250-4-lucas.tanure@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230217110850.1045250-1-lucas.tanure@collabora.com>
References: <20230217110850.1045250-1-lucas.tanure@collabora.com>
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

Use sizeof(*machine) instead of sizeof(struct acp5x_platform_info)

There is a possibility of bug when variable type has changed but
corresponding struct passed to the sizeof has not.

Signed-off-by: Lucas Tanure <lucas.tanure@collabora.com>
---
 sound/soc/amd/vangogh/acp5x-mach.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/amd/vangogh/acp5x-mach.c b/sound/soc/amd/vangogh/acp5x-mach.c
index f914f6327cda..43c80103d138 100644
--- a/sound/soc/amd/vangogh/acp5x-mach.c
+++ b/sound/soc/amd/vangogh/acp5x-mach.c
@@ -342,7 +342,7 @@ static int acp5x_probe(struct platform_device *pdev)
 	struct snd_soc_card *card;
 	int ret;
 
-	machine = devm_kzalloc(dev, sizeof(struct acp5x_platform_info), GFP_KERNEL);
+	machine = devm_kzalloc(dev, sizeof(*machine), GFP_KERNEL);
 	if (!machine)
 		return -ENOMEM;
 
-- 
2.39.2

