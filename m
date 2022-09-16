Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB93C5BA6C2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 08:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbiIPGZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 02:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiIPGZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 02:25:17 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45FA5005C
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 23:25:16 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id q9-20020a17090a178900b0020265d92ae3so24639666pja.5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 23:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=u8dZyZyEmYUHpM71+E3HiKXQlujdNpXoeQ0z9HInFJk=;
        b=SrgEuNZj1nSfxDq9JNMMV0CaoibvzZ28f0cinyXqmTqWeR6VHPzjxperY1OEPBAhN6
         fU6jUc59dz7YPrx46bEInYvS0Ih/nNKz++1oVyNFZ2VeNpwzBD6UIHfBK3zMCZcf5jeb
         uQtdIy8HBTggun7p6zf6ABgXxOHxK6oGpuW2kLN3yuAsuLxWpFg9PrmE8s0xtUorqvzY
         +HIa9n9W0nXt3qpuVrQq292xWxCqghCe83PBC5GvJ91tw/oSZrik57MbRXwFAheKCI+J
         kNYSDNekqaggTU8pqZZcGAomtonI88DZ1b1VyxwtHRHh4aW8yV3Sq6AGxnp324NltkkZ
         vANg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=u8dZyZyEmYUHpM71+E3HiKXQlujdNpXoeQ0z9HInFJk=;
        b=IxDOQUHwWJkokpUEEZ3cqKv22cmBenRIB54opbZRTlmBVbIGG63T7HKFc/1u0qI2TI
         r6nc4ciTQ4+4JYPArHA79ftmgejaeW7puUXwkn482CXoELyfluKerJYczN+BdOwxXgOi
         PhZXotd+UREjfuHyesTHQLRf9Jl0CdlmeE+y/fJeGQiF6HqyQtF0+JL0GGrQl5gLJCWL
         eEAWpW+pbiwEzt4aamPw+Ut/rylPfuZpEvKtLb0SOWtzbGh38oTf7xLmNgwVEfhw4/+b
         t5fbg24deRPVqRNSctDCL04xtOQcj0n4BzOSAI4iRYoc6IDTXIdID2+sRwahEeg62Vvs
         0DJA==
X-Gm-Message-State: ACrzQf2pj28ltBMiDpWfCjtAHD9otFWe7hl6sScxHsUFJ/CZ+vuHo3Nf
        gbiHSh2ChOIYN5Aa5MVgQC0=
X-Google-Smtp-Source: AMsMyM5A4+NSIkir6I5l0vbKkK7GUlWOx3OaaTI2tlDfie1myNdNjNeJJd+g7m353IdR2pZD5AZSJg==
X-Received: by 2002:a17:902:8d8a:b0:16f:21fb:b97a with SMTP id v10-20020a1709028d8a00b0016f21fbb97amr3208205plo.160.1663309516326;
        Thu, 15 Sep 2022 23:25:16 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id g3-20020aa79f03000000b005465ffaa89dsm7341967pfr.184.2022.09.15.23.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 23:25:16 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     broonie@kernel.org
Cc:     pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com,
        peter.ujfalusi@linux.intel.com, yung-chuan.liao@linux.intel.com,
        ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
        daniel.baluta@nxp.com, perex@perex.cz, tiwai@suse.com,
        sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] ASOC: SOF: use devm_kcalloc() instead of devm_kzalloc()
Date:   Fri, 16 Sep 2022 06:25:11 +0000
Message-Id: <20220916062511.153962-1-ye.xingchen@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

Use 2-factor multiplication argument form devm_kcalloc() instead
of devm_kzalloc().

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 sound/soc/sof/nocodec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/nocodec.c b/sound/soc/sof/nocodec.c
index 356497fe4f4c..3537805070ad 100644
--- a/sound/soc/sof/nocodec.c
+++ b/sound/soc/sof/nocodec.c
@@ -32,7 +32,7 @@ static int sof_nocodec_bes_setup(struct device *dev,
 
 	/* set up BE dai_links */
 	for (i = 0; i < link_num; i++) {
-		dlc = devm_kzalloc(dev, 3 * sizeof(*dlc), GFP_KERNEL);
+		dlc = devm_kcalloc(dev, 3, sizeof(*dlc), GFP_KERNEL);
 		if (!dlc)
 			return -ENOMEM;
 
@@ -78,7 +78,7 @@ static int sof_nocodec_setup(struct device *dev,
 	struct snd_soc_dai_link *links;
 
 	/* create dummy BE dai_links */
-	links = devm_kzalloc(dev, sizeof(struct snd_soc_dai_link) * num_dai_drivers, GFP_KERNEL);
+	links = devm_kcalloc(dev, num_dai_drivers, sizeof(struct snd_soc_dai_link), GFP_KERNEL);
 	if (!links)
 		return -ENOMEM;
 
-- 
2.25.1
