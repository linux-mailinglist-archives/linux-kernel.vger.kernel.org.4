Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 771AC5BDCFD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 08:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbiITGRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 02:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiITGRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 02:17:02 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 280E55A809
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 23:17:02 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id e68so1818042pfe.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 23:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=B6hSOiP8g8zcB6u4AKVglZyJoOdoT3fhziHHZ2QNmtU=;
        b=es8BM0wHkkzQAHxB0FX0GkmJEUxTn7K2VBAKKB3V5Bk5RYldxiY1m/fyt7ORwTs7Sw
         csjSUYauRJ+zWLh+31MhKh1QzaG4X2QflkslS3Y/R6eq0RtQsDNF482Pvyx95yEB2h2v
         u++rZmqHdt9U4myFqAn+aqKWT6ORWPMZkRK4xisBADSw4nOutil1IZOlVAZ8JJ2hPGGD
         CBe2me9EEDC1VuuzhhUkCsuI6roiSSWN8m4N6roaRxJ+rRA3pFvXig9IFw5i5lpSPTIU
         HxTQn916nob2CMwjr6VmXfGxkOtfohiNsN3Aj2l0FtreW0PLFlZGuGLpoPpQC45mI56z
         H7QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=B6hSOiP8g8zcB6u4AKVglZyJoOdoT3fhziHHZ2QNmtU=;
        b=Oeyz/Ub4MZE8vZbLxQDSRQB4JU+c73n17h7DjCti3+LhCigFeYhOiWr8YTWEn+kxlm
         pgPygkU/kErhkkT1MphDSHBpJ6X5XgyIz8Jt1s8388EpSTUJ77+ReCMrs+68xd9zCzl4
         8ZWkekn3TYDp2bKKV7XR9p71EJABRcZy8ABea1RlfOh0gqzvDeDm/K3MdWs+mE4VTKes
         LifjpunS41FXPnxFR4b8mHjdNOufgeuqKp/sRahvgw7jwWkir30cAaYKv5N74w80HTsr
         FPUdWp+/X5qgcQSktwYtd43Ao067mKHBMbP3AIdXR0QSGGFqEWJveXUK1CmX7v1xvTI5
         /5FA==
X-Gm-Message-State: ACrzQf0PTp1M/mHbobnEf8nW5Ee9KxFeEo591fa4eDD91pvQiadXezXp
        GVnp9xIwtzZV3pMBl3Qr8MI=
X-Google-Smtp-Source: AMsMyM7otqRaKgalLurxjXjKVQ0peXA1t+7Kmgwpb0wvpEVxfKpohw0FQbPrQWluYT96xGyZzbbHcg==
X-Received: by 2002:a63:4918:0:b0:439:1802:dda3 with SMTP id w24-20020a634918000000b004391802dda3mr18537836pga.467.1663654621642;
        Mon, 19 Sep 2022 23:17:01 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id t17-20020a170902e1d100b001708c4ebbaesm461317pla.309.2022.09.19.23.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 23:17:00 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     andrzej.hajda@intel.com
Cc:     neil.armstrong@linaro.org, robert.foss@linaro.org,
        Laurent.pinchart@ideasonboard.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>
Subject: [PATCH V2] drm: bridge/dw-hdmi-ahb-audio: use strscpy() is more robust and safer
Date:   Tue, 20 Sep 2022 06:16:55 +0000
Message-Id: <20220920061655.214785-1-chi.minghao@zte.com.cn>
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

Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
v1->v2
using DRIVER_NAME instead of "DW-HDMI".
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-ahb-audio.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-ahb-audio.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-ahb-audio.c
index 7d2ed0ed2fe2..8cb6177f976d 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-ahb-audio.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-ahb-audio.c
@@ -542,8 +542,8 @@ static int snd_dw_hdmi_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
-	strlcpy(card->driver, DRIVER_NAME, sizeof(card->driver));
-	strlcpy(card->shortname, "DW-HDMI", sizeof(card->shortname));
+	strscpy(card->driver, DRIVER_NAME, sizeof(card->driver));
+	strscpy(card->shortname, DRIVER_NAME, sizeof(card->shortname));
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
