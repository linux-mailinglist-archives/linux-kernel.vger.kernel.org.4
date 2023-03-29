Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCF926CDA05
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 15:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbjC2NF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 09:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbjC2NFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 09:05:39 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7874C3E;
        Wed, 29 Mar 2023 06:05:34 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id z18so9193043pgj.13;
        Wed, 29 Mar 2023 06:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680095134;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jsSpCWEsDfnGoaRyyeTFl4Yy+RKBES/VujFMn4D6v78=;
        b=kKA3vi+Sbovo5u5+fyCFosu5eQC2C3KVSABeLsujBVqtX/x+zMpbybujpO2IuBQOIT
         DwJezqf2BIOT+pceWSbiFODF3jKmQxDorL/UKHXwkWd6522a+jrQzsPUwJJqFmnR22Uq
         X+F7pPYDbnQcZXz30N3YxO2pYYf+YyoLBYU2RCKW+/f/WFkJ0+dLbFryTcGOkakK6aJ3
         mYwSN4LjEzbHIJhEe6LBCj8jltVwVrHjEoaaktandxKKUk6gWoPnBSP0W0yMU5nzeFHb
         hJdUEgAiVWG8V0nKMEgQ7to2Y7eEZRGxd04WpQn034AmPcee4Rpy7G3Fu+XuzmP+QP6m
         S2IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680095134;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jsSpCWEsDfnGoaRyyeTFl4Yy+RKBES/VujFMn4D6v78=;
        b=nRCsyBWvW3/HDgc1RwckBM+ZapP8dWGUwflggmgFdH/DfOC9YcYbhpY2YkgaE9PlvL
         ABSGP159AuKEEdOX93d2COmwpMoNoH8cGjHAyU2S3cn+/SHGNANHqouELLEuUuXPWnYG
         M/mm/vv1Cbscg3ylrozXlg40iss2TxUphgGrpLRgFWsNpzfmw83akpk7Suot9DhJu2e2
         X1/DCgSC3mYfLhTFgHfjTQAAyzl6rxadM/2IH8okRJ60RM2Se21Id6HUgTL66P3gitIy
         huyIHj3U7GlDJVKXYYVRNziKyrkn+p+Vl7VwMt5YHsWbF7aIGOZQ//OEnpor8zpgXk0e
         s/Ow==
X-Gm-Message-State: AAQBX9fbc5kPv+riS1f8lP96WZ8Jdez38W1dEh778eJHedW8GW0vNEap
        0zv97zkz82r0wYzIhoHEzdY=
X-Google-Smtp-Source: AKy350YHQ81/8HFFe4IFQNlTZHAgL9aVJ2OJjYSUJfpDcFXzmy0V7n5+Ir+YF95SPcnj0RdBdqvElg==
X-Received: by 2002:a62:84c4:0:b0:628:134b:6b1c with SMTP id k187-20020a6284c4000000b00628134b6b1cmr21327044pfd.2.1680095134256;
        Wed, 29 Mar 2023 06:05:34 -0700 (PDT)
Received: from localhost.localdomain (n220246252084.netvigator.com. [220.246.252.84])
        by smtp.gmail.com with ESMTPSA id n6-20020aa79046000000b005ae02dc5b94sm22790452pfo.219.2023.03.29.06.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 06:05:33 -0700 (PDT)
From:   Jianhua Lu <lujianhua000@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Simon Trimmer <simont@opensource.cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc:     patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Jianhua Lu <lujianhua000@gmail.com>
Subject: [PATCH] Asoc: wm_adsp: Add support for loading firmware with prefix name
Date:   Wed, 29 Mar 2023 21:05:25 +0800
Message-Id: <20230329130525.15830-1-lujianhua000@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For platform using fdt, system_name is NULL, it doesn't provide
a way to load firmware with prefix name, so add it.

Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
---
 sound/soc/codecs/wm_adsp.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 216120b68b64..17481e42d440 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -760,6 +760,10 @@ static int wm_adsp_request_firmware_file(struct wm_adsp *dsp,
 		*filename = kasprintf(GFP_KERNEL, "%s%s-%s-%s-%s.%s", dir, dsp->part,
 				      dsp->fwf_name, wm_adsp_fw[dsp->fw].file, system_name,
 				      filetype);
+	else if (asoc_component_prefix)
+		*filename = kasprintf(GFP_KERNEL, "%s%s-%s-%s-%s.%s", dir, dsp->part,
+				      dsp->fwf_name, wm_adsp_fw[dsp->fw].file, asoc_component_prefix,
+				      filetype);
 	else
 		*filename = kasprintf(GFP_KERNEL, "%s%s-%s-%s.%s", dir, dsp->part, dsp->fwf_name,
 				      wm_adsp_fw[dsp->fw].file, filetype);
@@ -831,6 +835,16 @@ static int wm_adsp_request_firmware_files(struct wm_adsp *dsp,
 							      NULL, "bin");
 			return 0;
 		}
+	} else if (asoc_component_prefix) {
+		if (!wm_adsp_request_firmware_file(dsp, wmfw_firmware, wmfw_filename,
+						   cirrus_dir, NULL,
+						   asoc_component_prefix, "wmfw")) {
+			adsp_dbg(dsp, "Found '%s'\n", *wmfw_filename);
+			wm_adsp_request_firmware_file(dsp, coeff_firmware, coeff_filename,
+							      cirrus_dir, NULL,
+							      asoc_component_prefix, "bin");
+			return 0;
+		}
 	}
 
 	if (!wm_adsp_request_firmware_file(dsp, wmfw_firmware, wmfw_filename,
-- 
2.39.2

