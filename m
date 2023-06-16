Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41E06732B00
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 11:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244687AbjFPJFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 05:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241161AbjFPJEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 05:04:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4204846AC
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 02:02:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF85B60EA6
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 09:02:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55DC8C433C0;
        Fri, 16 Jun 2023 09:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686906137;
        bh=UOnPoFg43i3UesyhFVozRmIc8vnbB70GQh4IzFCjtN0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q/nhG7AOdYsI3nv+QMHa1sa79lU32ytFCuAbdWYzzYuo0eZvAqQqwJjHiYUk0p+x6
         lJbLILzZUk+zlak4Hv/XANuqsfyEkHsj3WMQObqLLLFsRUiadkD63bjp0TRVslmGQ/
         AhYVR87FEhBmKcXkTwLtddA+M8gGyIHtTFUGIlO/QiGJQ+Bj/gaDku/tSb6MKz2mao
         5Yk3FQeLdKKMxKVGPv0o4CfrP3/U1lh/NPjRyzAvgO+GcO5uazcdgJaJRpuX0Mpzwj
         MZvk4kxH4F5HRJREvI71UF7RixnpxI8z8cURMJhlJ7U0sfhgzyUc/UGPvCfhOikrTS
         /syyNBHkwic9g==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Yingkun Meng <mengyingkun@loongson.cn>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] ASoC: loongson: fix unused PM function warning
Date:   Fri, 16 Jun 2023 11:00:38 +0200
Message-Id: <20230616090156.2347850-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230616090156.2347850-1-arnd@kernel.org>
References: <20230616090156.2347850-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Build testing without CONFIG_PM_SLEEP causes a warning:

sound/soc/loongson/loongson_i2s.c:246:12: error: unused function 'i2s_suspend' [-Werror,-Wunused-function]
sound/soc/loongson/loongson_i2s.c:255:12: error: unused function 'i2s_resume' [-Werror,-Wunused-function]

Use the modern SYSTEM_SLEEP_PM_OPS() instead of the old one to avoid this.

Fixes: d24028606e764 ("ASoC: loongson: Add Loongson ASoC Sound Card Support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/loongson/loongson_i2s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/loongson/loongson_i2s.c b/sound/soc/loongson/loongson_i2s.c
index 35d34568be79e..f73b6d6f16c23 100644
--- a/sound/soc/loongson/loongson_i2s.c
+++ b/sound/soc/loongson/loongson_i2s.c
@@ -265,5 +265,5 @@ static int i2s_resume(struct device *dev)
 }
 
 const struct dev_pm_ops loongson_i2s_pm = {
-	SET_SYSTEM_SLEEP_PM_OPS(i2s_suspend, i2s_resume)
+	SYSTEM_SLEEP_PM_OPS(i2s_suspend, i2s_resume)
 };
-- 
2.39.2

