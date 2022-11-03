Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C426182E2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 16:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbiKCPaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 11:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232151AbiKCPac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 11:30:32 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E4E1C433;
        Thu,  3 Nov 2022 08:30:01 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id w14so3301491wru.8;
        Thu, 03 Nov 2022 08:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jTNF+TBMvTriQtS+AA9+C2dKsWuCfeavpCHVTcjD0eY=;
        b=out7CxP4vZ5XMhp9mDv7Ofatpr7fpv6fDwjoCTilq7jVigf/gyDt96koz/LT1/kL8z
         0sU0E8IpYZ1guwovwiHfWsmY/RGkWdo9Q0nQw6D++1ZG4TTQAewqH/KWERHkVVuVt2Go
         0Tmz4Ta4jr3ClB52+puwbKMbwf+BEMtcBJuT+5D6PjwHTvFfQTFrj7JqiEYd06mvVlY3
         5hmHnxZ39oGNAvJbrAv3R8b9r5xc7pln7zH1imayfH9EPrV4IYqMjdkjTEyZlBxFIXdm
         in7k8+PIcRU3EQ3Q4ubgyvX0wNX22hKkxllEhdPR3vqQUGV3d7o0UZzp9bm0b9+TEmML
         wBPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jTNF+TBMvTriQtS+AA9+C2dKsWuCfeavpCHVTcjD0eY=;
        b=x+aLrXlbszX8Zhqt6EqfxknaP+g1y8Tzd8yNP0zD52G4QBt3LDST8GJhEJqfNnVasz
         yuYH/fPCyglAPdgiodSvCQh61iCST696u8oHf0tAwuldcNnH7YxsVuMhq1rslZH1n6Io
         Yy23fH//mjiUWc2463TUcLMLe66amLCdxzNZh6Vo3eCVIAjjbB3eKzeIL8tj81Cs1kBk
         zKqDfvNyvK9aC0QBsQl780MHRt3TRjxXaAeOgwCB74ognDlohH7sk9wmRXHR/kv4C5tJ
         Nb9zH4d0DwGN+GOyk+WqTnf+sfEOsuptzgK2W2H1onrzpqXu0KNWCsGC+Xw10dChqvEv
         ra0A==
X-Gm-Message-State: ACrzQf1bQO4hY6JIW1GZ3KMRsU2XpGeNjp59s+VQ46gga+7q6c9olYi8
        V6JDSJpnAP64lwIdQgKS9qU416CAVwuhebvx
X-Google-Smtp-Source: AMsMyM5Nyyy/q4Kn3ydmHt5dCYT4Mg7RkCP01fJ7CYK5rm31bepO9+UNSqvjytTa3KpN6DC4tX4HTA==
X-Received: by 2002:adf:d4d2:0:b0:236:594f:4a2c with SMTP id w18-20020adfd4d2000000b00236594f4a2cmr18912381wrk.705.1667489399525;
        Thu, 03 Nov 2022 08:29:59 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id q12-20020a05600c46cc00b003b4ac05a8a4sm183699wmo.27.2022.11.03.08.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 08:29:58 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Alain Volmat <alain.volmat@foss.st.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm: sti: Make array en_di static const
Date:   Thu,  3 Nov 2022 15:29:58 +0000
Message-Id: <20221103152958.89865-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

Don't populate the read-only array en_di on the stack but instead
make it static. Also makes the object code a little smaller.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/gpu/drm/sti/sti_hdmi.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/sti/sti_hdmi.c b/drivers/gpu/drm/sti/sti_hdmi.c
index cb82622877d2..9de8cd171c25 100644
--- a/drivers/gpu/drm/sti/sti_hdmi.c
+++ b/drivers/gpu/drm/sti/sti_hdmi.c
@@ -641,10 +641,12 @@ static void hdmi_dbg_sta(struct seq_file *s, int val)
 static void hdmi_dbg_sw_di_cfg(struct seq_file *s, int val)
 {
 	int tmp;
-	char *const en_di[] = {"no transmission",
-			       "single transmission",
-			       "once every field",
-			       "once every frame"};
+	static const char * const en_di[] = {
+		"no transmission",
+		"single transmission",
+		"once every field",
+		"once every frame"
+	};
 
 	seq_putc(s, '\t');
 	tmp = (val & HDMI_IFRAME_CFG_DI_N(HDMI_IFRAME_MASK, 1));
-- 
2.38.1

