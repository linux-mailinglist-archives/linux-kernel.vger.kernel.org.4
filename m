Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2D1660855D
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 09:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiJVHHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 03:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbiJVHHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 03:07:25 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4756D2AF661
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 00:07:14 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id by36so6492070ljb.4
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 00:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z/Jixh+fpGeoRUrSiUP31EewhYoOg//pK7EUFnRWzmw=;
        b=E6LyThuoqqIGcCzOD9uvSNSj5QJPyHrtjO57xPt6jnTjmAgIq0ve1Q0XQfOPLmaYrJ
         +nS9WeAGgmx9KViD7Daa0/n0+Xt4CXYA/nA9X8r1L/R3buraKv3TQ9tLrc+TQTJ3Ojdb
         O4xJ++ENTE7vKhA01/OG0Fh8pEuarrMqQlu4HG1BUK8tSw2dMKwy5q8jqrjJBSWwfkNM
         TX47sf0KYRDqY9cR8BMjy6WKPS/z71nw2d1dx8OGwyboLQSMCKtyOStdCd/0i4kxjEtp
         7eYQ6Ep6/IukjawdlW3L7Lj4FfarTrux4ln3oZudfQeowX+oO+kSNRpraQqAk/MDSbg/
         5pZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z/Jixh+fpGeoRUrSiUP31EewhYoOg//pK7EUFnRWzmw=;
        b=iEhf7ehmdv1mbIIqdCXs5ubDnjUkDI8M8gcrKVfCglapuigd/zuQi7wniy2uyAr7Hc
         1jBoZq4sU+NWPTW06b+wFnfjNLRzGIdeJ26oYLhQd9BY0o8v4RaFDSzNJNx7I5sUGFkc
         zZQjceiyLcl8WbH/DoaX9pHfuAs9ytvwupB/uq70HN1Je1N7uGbEP+dZ7t2d5mlWe0rA
         snzyNfoIv6EIfGeRq2Lu++YZ29YbevXdxfkbjTme0nPS0uFaGKvVktip1cOtk+2lxOMc
         YVsI7ZNKFAbFdezphDj6S6lz81Jq37mb1ZQmdyeeQqUpOdBw1Ww/4IQXTFF9tym+2RLs
         Ygyg==
X-Gm-Message-State: ACrzQf1lGKdaLr0/rpUF5o2Rc52ouZH0ukaNEXIc0ch4NV9+DY/4/gw3
        OJnF6fxp+zHc0CvTyUZ4XAE=
X-Google-Smtp-Source: AMsMyM4UrJa0//aaoXODXbD3IQteFe712Wz8Xa9AwhO/1oUJkca2RkUyFNUI2aDB8uVB1h3+YLL3FA==
X-Received: by 2002:a2e:8514:0:b0:274:7384:fc5 with SMTP id j20-20020a2e8514000000b0027473840fc5mr4402354lji.52.1666422432197;
        Sat, 22 Oct 2022 00:07:12 -0700 (PDT)
Received: from elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net ([20.240.130.248])
        by smtp.googlemail.com with ESMTPSA id s5-20020a2e1505000000b00276d2537921sm390404ljd.59.2022.10.22.00.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Oct 2022 00:07:11 -0700 (PDT)
From:   Tanjuate Brunostar <tanjubrunostar0@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev,
        Tanjuate Brunostar <tanjubrunostar0@gmail.com>
Subject: [PATCH v3 6/6] staging: vt6655: refactor code to avoid a line ending in '('
Date:   Sat, 22 Oct 2022 07:06:12 +0000
Message-Id: <20221022070612.13009-7-tanjubrunostar0@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221022070612.13009-1-tanjubrunostar0@gmail.com>
References: <20221022070612.13009-1-tanjubrunostar0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

join unnecessary split lines to avoid them ending in '('

Signed-off-by: Tanjuate Brunostar <tanjubrunostar0@gmail.com>
---
 drivers/staging/vt6655/rxtx.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
index 572be45cdbeb..c991619763da 100644
--- a/drivers/staging/vt6655/rxtx.c
+++ b/drivers/staging/vt6655/rxtx.c
@@ -1300,10 +1300,8 @@ static void vnt_fill_txkey(struct ieee80211_hdr *hdr, u8 *key_buffer,
 		ether_addr_copy(mic_hdr->addr2, hdr->addr2);
 		ether_addr_copy(mic_hdr->addr3, hdr->addr3);
 
-		mic_hdr->frame_control = cpu_to_le16(
-			le16_to_cpu(hdr->frame_control) & 0xc78f);
-		mic_hdr->seq_ctrl = cpu_to_le16(
-				le16_to_cpu(hdr->seq_ctrl) & 0xf);
+		mic_hdr->frame_control = cpu_to_le16(le16_to_cpu(hdr->frame_control) & 0xc78f);
+		mic_hdr->seq_ctrl = cpu_to_le16(le16_to_cpu(hdr->seq_ctrl) & 0xf);
 
 		if (ieee80211_has_a4(hdr->frame_control))
 			ether_addr_copy(mic_hdr->addr4, hdr->addr4);
-- 
2.34.1

