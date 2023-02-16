Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9521269915C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 11:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjBPKdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 05:33:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjBPKdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 05:33:47 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20AB98A60
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 02:33:18 -0800 (PST)
Received: from cryzen.lan (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net [82.11.51.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: tanureal)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B6BC466021A6;
        Thu, 16 Feb 2023 10:33:16 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676543596;
        bh=VHRkSn0YnTcjuOlw01AI/fSVRsUsk4QbQgU+wC4C4Ok=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HX5faCVUvtrcauQ3nDoj32lCNd93NRVHloTDZFIXMRHzW9sIiN3w/FyqCiDYO4my0
         czZKEE7fy3flR3vqU1OuV6Y2B0EAnkGZE/CllbSOZ1xQbVXHVwhgP6mgZp+AXvUU0e
         qE307I0nUk5kVFD18U8Idqv6HbOntnoKPKaWXggFY96ZgGurP3DRoPi+2vckH5dTt5
         fE4cFcU03z8g8E96o29+IieU66Z8J5w9prrTHfoWcScZDivm4Fau74TfgQObQ9oEIz
         xXk8eL+m4AcI5ReKjrXOWb/SkxVWgbCUJAovKqRp13MhQ0RnVZAcPiheIYrb9KKLv2
         uaNSFbDXM5stA==
From:   Lucas Tanure <lucas.tanure@collabora.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Lucas Tanure <lucas.tanure@collabora.com>, kernel@collabora.com
Subject: [PATCH 3/9] ASoC: amd: vangogh: use sizeof of variable instead of struct type
Date:   Thu, 16 Feb 2023 10:32:54 +0000
Message-Id: <20230216103300.360016-4-lucas.tanure@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230216103300.360016-1-lucas.tanure@collabora.com>
References: <20230216103300.360016-1-lucas.tanure@collabora.com>
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
index 2675fbff9f6f..ec67345bcda4 100644
--- a/sound/soc/amd/vangogh/acp5x-mach.c
+++ b/sound/soc/amd/vangogh/acp5x-mach.c
@@ -329,7 +329,7 @@ static int acp5x_probe(struct platform_device *pdev)
 	struct snd_soc_card *card;
 	int ret;
 
-	machine = devm_kzalloc(&pdev->dev, sizeof(struct acp5x_platform_info), GFP_KERNEL);
+	machine = devm_kzalloc(&pdev->dev, sizeof(*machine), GFP_KERNEL);
 	if (!machine)
 		return -ENOMEM;
 
-- 
2.39.2

