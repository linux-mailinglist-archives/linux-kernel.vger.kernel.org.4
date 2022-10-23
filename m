Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04A766091B3
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 09:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbiJWHqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 03:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiJWHqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 03:46:09 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954AA6CD3E
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 00:46:04 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id h2so88552pgp.4
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 00:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q+3XI07NIU0r0BcSpY4o4wAED1j8IMzL6p8JlqJ+P7M=;
        b=HNX7B3LX5uGls5yoQ/5rcdO3NyrtZTcsWkpJx9uEferAxFEMGahSk77KWsyjQqM081
         SmHGfTKBcsKNRcnCMtbYzC8/QpkdGVvCB+DcTyYY5nzGGJMYLyY63doCjtrtagYKSqbQ
         72KKKHZQvFXE3hErYtcA+0HNZoqNXtZfwFCWW3mzNxmOInHiyLd2jX9gK2eYWnHL56dY
         6wUHiYGv02nGQ49T5B5Y4MEdC1rshkasUy6h29VDsZOXdecYgPtscpg17YkBPeLmj77x
         qV/SwnwvnB8CgsNWcl7X6G2uhmBG0gSJF8EqEQmVyrv389h15pcTgy83XkMOCb0cnIB8
         DA+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q+3XI07NIU0r0BcSpY4o4wAED1j8IMzL6p8JlqJ+P7M=;
        b=gkfE+7b4KlqkCQRT/arxqCYtE6NuPvXVdpKrwWsFGgh36Bx4V7uu2E50JMbVq/KSUy
         Bk6z5zgFMZkd8QkvV6l9A5OD/4nx1uRYagQKX/cEHm3B9aLJhV1FESwDfziZv5VVT9r2
         2I0fvnq7DuI3NuN7XWT39KVwBjmgAMETasxbzRoH68vlsTMuB3Iw0v4a+CSv2iP9Zidh
         gc4vesynkumHU39b8sS8DGkgnBiMmwbXAcNX6aRJX5XTJrvAKhIWRu0gR3/lUna04Rtm
         hApIeY0fP09BxzRSh6Vw7BWfJNF9di/o1tQ0YHdFOHZVE1dvJOswxKFEa26AeGH8652/
         BEKw==
X-Gm-Message-State: ACrzQf1PvDQlJv1J2vRlY7hllHDbLdNa44dhMAmvIolHBQx/2VBLGUxh
        UzDWZTfyBLqWojivikPGUVOTfhbUF8zwoE2IEw==
X-Google-Smtp-Source: AMsMyM7hnbn4FtvSizf8k1Mr/Ab9tVqFbA04W4ZUETz4RdenA5XTA4G0THtH48QpRTXAq92reGBQTA==
X-Received: by 2002:a63:6505:0:b0:46e:d30b:8f9 with SMTP id z5-20020a636505000000b0046ed30b08f9mr6658694pgb.366.1666511164097;
        Sun, 23 Oct 2022 00:46:04 -0700 (PDT)
Received: from localhost.localdomain ([121.34.154.42])
        by smtp.gmail.com with ESMTPSA id ge12-20020a17090b0e0c00b0020aa1bd91e4sm4101976pjb.4.2022.10.23.00.46.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Oct 2022 00:46:03 -0700 (PDT)
From:   Ban Tao <fengzheng923@gmail.com>
To:     fengzheng923@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, wens@csie.org,
        jernej.skrabec@gmail.com, samuel@sholland.org
Cc:     alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2] ASoC: sun50i-dmic: avoid unused variable warning for sun50i_dmic_of_match
Date:   Sun, 23 Oct 2022 00:44:45 -0700
Message-Id: <1666511085-2748-1-git-send-email-fengzheng923@gmail.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In configurations with CONFIG_OF=n, we get a harmless build warning:

sound/soc/sunxi/sun50i-dmic.c:268:34: warning: unused variable
'sun50i_dmic_of_match' [-Wunused-const-variable]

Signed-off-by: Ban Tao <fengzheng923@gmail.com>
Reported-by: kernel test robot <lkp@intel.com>
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
v1->v2:Add "Acked-by" tag.
---
 sound/soc/sunxi/sun50i-dmic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sunxi/sun50i-dmic.c b/sound/soc/sunxi/sun50i-dmic.c
index 86cff5a..62509cb 100644
--- a/sound/soc/sunxi/sun50i-dmic.c
+++ b/sound/soc/sunxi/sun50i-dmic.c
@@ -391,7 +391,7 @@ static const struct dev_pm_ops sun50i_dmic_pm = {
 static struct platform_driver sun50i_dmic_driver = {
 	.driver         = {
 		.name   = "sun50i-dmic",
-		.of_match_table = of_match_ptr(sun50i_dmic_of_match),
+		.of_match_table = sun50i_dmic_of_match,
 		.pm     = &sun50i_dmic_pm,
 	},
 	.probe          = sun50i_dmic_probe,
-- 
2.7.4

