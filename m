Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA105BC19A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 05:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbiISDEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 23:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiISDEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 23:04:07 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A1019C20
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 20:04:06 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 78so25523351pgb.13
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 20:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=1Z7zLLagXME9kaIkwwz+RZoWIKsBtX6ruY4efxOuNA0=;
        b=fAuikC+SbpMF2sZ/NgiATXG2kQiWQvNOVV0IxiSG8cLCO2Hqrtxt7oRn9wYoE+WzyH
         aZvZypqQHz5xr57iUs52oSyECqaC2CGtlH2iJ3ejedCDIj7kmz7+aDo9ywV6XtbaBCoi
         LB6fLWi6Bj6LDQ2QSC2pi2ZyvpfGQlpES6NCXZTHu6dU3Dt+srv5/Outu+l83nrPNmzn
         h3JoZtzlKOH0EgUtgv3WJ4BbDX6pELCwwaYWXqGnHVna3FlXD9kPdWdT3/U4ZJJUdk6b
         C75dbBNWzsxV0lj013tpvUiCiL5Fu+3c5qTUOhVGj9fJrgAqX9gNgoXZAaykKlj/fBmG
         unWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=1Z7zLLagXME9kaIkwwz+RZoWIKsBtX6ruY4efxOuNA0=;
        b=kucf8HLXVcwprJkr6qqOxjnoHOJ4evQHa5vj8DcpXNKkz3iw4Fbz5n1u47aaO9Ltrr
         2DFtrz7t4mzhyFaoGIdgp4u8je+dbg/iHhv8WQkY8OPQfPDSQWCbIyhtCeYAem2YPwVM
         rZZtFUBzVnq0tb4X2A+/sgAFBaHRBqpcwUQSGp3w+3xo41gegetdE4/Tn1nQsEccR7ZR
         XnUnDPemPf8dnY22f+nYiRXg9L2jJHq2vcI9N6Iuycg41hGAZjSI+NCW3PIJv+QxTVd/
         l1pi11kdsAyFJXSE4aQte+mI4ru6SHBXXWdilx4+cAlmbsmJTeA9s1ImRPPbL1BUZ17e
         curw==
X-Gm-Message-State: ACrzQf3LoOIhQaLHkSxFXgDHSj/nwzR+7VjJU0DUW0JvgBwgEl0YLUun
        uwsZzdLH+IBC7rEKZDub3qoy+5lrqWA=
X-Google-Smtp-Source: AMsMyM6Yjm4ugY5K6oMa3IYSw2JddiCz7Pq1BHaiEU7A6XTyq0MULpLn+QLfMfiZFhhhgZ4ZDLbdoA==
X-Received: by 2002:a05:6a00:8cc:b0:52c:7ab5:2ce7 with SMTP id s12-20020a056a0008cc00b0052c7ab52ce7mr15998116pfu.28.1663556646421;
        Sun, 18 Sep 2022 20:04:06 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id y6-20020aa793c6000000b00540d75197e5sm19052339pff.47.2022.09.18.20.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Sep 2022 20:04:05 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     andrzej.hajda@intel.com
Cc:     neil.armstrong@linaro.org, robert.foss@linaro.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] drm: bridge/dw-hdmi-ahb-audio: use strscpy() is more robust and safer
Date:   Mon, 19 Sep 2022 03:04:01 +0000
Message-Id: <20220919030401.211331-1-chi.minghao@zte.com.cn>
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

From: Minghao Chi <chi.minghao@zte.com.cn>

The implementation of strscpy() is more robust and safer.

That's now the recommended way to copy NUL terminated strings.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-ahb-audio.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-ahb-audio.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-ahb-audio.c
index 7d2ed0ed2fe2..4efb62bcdb63 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-ahb-audio.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-ahb-audio.c
@@ -542,8 +542,8 @@ static int snd_dw_hdmi_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
-	strlcpy(card->driver, DRIVER_NAME, sizeof(card->driver));
-	strlcpy(card->shortname, "DW-HDMI", sizeof(card->shortname));
+	strscpy(card->driver, DRIVER_NAME, sizeof(card->driver));
+	strscpy(card->shortname, "DW-HDMI", sizeof(card->shortname));
 	snprintf(card->longname, sizeof(card->longname),
 		 "%s rev 0x%02x, irq %d", card->shortname, revision,
 		 data->irq);
@@ -561,7 +561,7 @@ static int snd_dw_hdmi_probe(struct platform_device *pdev)
 
 	dw->pcm = pcm;
 	pcm->private_data = dw;
-	strlcpy(pcm->name, DRIVER_NAME, sizeof(pcm->name));
+	strscpy(pcm->name, DRIVER_NAME, sizeof(pcm->name));
 	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &snd_dw_hdmi_ops);
 
 	/*
-- 
2.25.1
