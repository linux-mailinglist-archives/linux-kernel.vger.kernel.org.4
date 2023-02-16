Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97D10699197
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 11:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbjBPKhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 05:37:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbjBPKhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 05:37:02 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A1F460A3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 02:36:45 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id oa11-20020a17090b1bcb00b002341a2656e5so1722103pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 02:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dehvFsN/oQxRP7kvlw0fqQwAKQjez3uQqjF/59ORbl4=;
        b=lgF0FfKxqho3//7JsLS7WJ3E3Sqd+i836bjeXgjdRRssOE0dlvKQtmAPiMq+hsbLRP
         axK6NE+ewD1NxTLIW/nja3vxOSozERFr81HeoFAtXYfu83p+0jsykr5p54QoxEu9fC9G
         QPn3AcrwH50yV1JiOlZUWye7jz9zM6aZ6fZDaWrYUTzrr/UdMM+EpdHY2DmHo+o8Ncg/
         rUot3Y1947U5t4YNXABclbQwUhKrBn135xDvUgNm2l0aC34Bmhj803InqDHaIPrFlB+0
         gj7k1Fx9e1KqFujM/ETYgmPHjvhden7FLp8tDqMQgEKCXDbpFatKNI1TeSs611kHZWKI
         uziA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dehvFsN/oQxRP7kvlw0fqQwAKQjez3uQqjF/59ORbl4=;
        b=JhG9ul2rNFfmDMBTfSMn2Ob9obAqhnjWV5xtmiGWQNlI1pLKkA22XPhZb1EgnVj+Wa
         cjX/Sb4nO6Mu/6RETHUlQM3TNjXTvGm9HRF8d3zOe3/zgeqXFwup7brYdyS96eC4N4tr
         cW0kvi3ibj+Ksow0+sSAPmG8iZ0eujOUk/duJeO+UYzEfBPzOHiGVBa4w52S/22kCF7V
         6awyK/rDpdLbtGEXhk4k9xnFdN9XdchINdI9MzhQGs7yw7lBpjEN0rItx0twx+LG51Xz
         BH+xVeSHhnh0YXusVQTjT+sT6GPj7r6cSemTyIv7Hck1huw9OYlN8mOfEU1pvzLLBZrW
         nYoQ==
X-Gm-Message-State: AO0yUKWUyf48bmjjXEYp9gfJjTg6vM0GketthWfA7M7QKjX1QsAQENWw
        S7ZyZNviz7Urr2wbZ8UGm4k=
X-Google-Smtp-Source: AK7set/ngPMAQ3tYexF8aGEns4clZ+Ez4ftXZTHe9+juQLLYrTknhPH+iaIRpUR+23rWc5WyU1GXPQ==
X-Received: by 2002:a05:6a20:12ca:b0:b8:66d3:30aa with SMTP id v10-20020a056a2012ca00b000b866d330aamr6208582pzg.50.1676543800805;
        Thu, 16 Feb 2023 02:36:40 -0800 (PST)
Received: from localhost.localdomain ([202.53.32.211])
        by smtp.gmail.com with ESMTPSA id x52-20020a056a000bf400b00592591d1634sm1012380pfu.97.2023.02.16.02.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 02:36:40 -0800 (PST)
From:   Orlando Chamberlain <orlandoch.dev@gmail.com>
To:     alsa-devel@alsa-project.org
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        linux-kernel@vger.kernel.org, Aditya Garg <gargaditya08@live.com>,
        Aun-Ali Zaidi <admin@kodeit.net>,
        Kerem Karabay <kekrby@gmail.com>,
        Orlando Chamberlain <orlandoch.dev@gmail.com>
Subject: [PATCHv2] hda/hdmi: Register with vga_switcheroo on Dual GPU Macbooks
Date:   Thu, 16 Feb 2023 21:34:51 +1100
Message-Id: <20230216103450.12925-1-orlandoch.dev@gmail.com>
X-Mailer: git-send-email 2.39.1
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

Commit 586bc4aab878 ("ALSA: hda/hdmi - fix vgaswitcheroo detection for
AMD") caused only AMD gpu's with PX to have their audio component register
with vga_switcheroo. This meant that Apple Macbooks with apple-gmux as the
gpu switcher no longer had the audio client registering, so when the gpu is
powered off by vga_switcheroo snd_hda_intel is unaware that it should have
suspended the device:

amdgpu: switched off
snd_hda_intel 0000:03:00.1:
    Unable to change power state from D3hot to D0, device inaccessible
snd_hda_intel 0000:03:00.1: CORB reset timeout#2, CORBRP = 65535

To resolve this, we use apple_gmux_detect() and register a
vga_switcheroo audio client when apple-gmux is detected.

Fixes: 586bc4aab878 ("ALSA: hda/hdmi - fix vgaswitcheroo detection for AMD")
Link: https://lore.kernel.org/all/20230210044826.9834-9-orlandoch.dev@gmail.com/
Signed-off-by: Orlando Chamberlain <orlandoch.dev@gmail.com>
---
v1->v2: Use apple_gmux_detect(), split this patch out of the patch
series
 sound/pci/hda/hda_intel.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 87002670c0c9..cfd2ddfde112 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -50,6 +50,7 @@
 #include <sound/intel-dsp-config.h>
 #include <linux/vgaarb.h>
 #include <linux/vga_switcheroo.h>
+#include <linux/apple-gmux.h>
 #include <linux/firmware.h>
 #include <sound/hda_codec.h>
 #include "hda_controller.h"
@@ -1463,7 +1464,7 @@ static struct pci_dev *get_bound_vga(struct pci_dev *pci)
 				 * vgaswitcheroo.
 				 */
 				if (((p->class >> 16) == PCI_BASE_CLASS_DISPLAY) &&
-				    atpx_present())
+				    (atpx_present() || apple_gmux_detect(NULL, NULL)))
 					return p;
 				pci_dev_put(p);
 			}
-- 
2.39.1

