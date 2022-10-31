Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D414613A3A
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 16:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbiJaPiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 11:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231517AbiJaPh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 11:37:58 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1DE64F0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 08:37:57 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id q9so30487068ejd.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 08:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F9yhgj+6ArvrtFVIbg6vtYy8oqEY7mQcPE3AQ+WlIQ0=;
        b=Pd2Xcu0rYuMekQASXdJfXt/Fh70vvgyBjR8Ldw4R2YCGnJqjEekehmKBrZDVztpF7R
         DQNEaCHuXHob1edwmp3v4NC7QoPdmnR2+anKHz+5euk2gY4ElIMOsQ7fXQ3Fo5zI0emq
         DZpniI0yfCo3fmlDQhYIzfnEm2OyHIkdn19Qz0KwzBWP6sfkG2ZZFE0pczeQhtKkeLzS
         LrDsrdtr65s4471Sswfd4P+7ioweFbZ46QQozUbtptZM3Cg/0kZR/Au8bA6LDiYMifYk
         KFY2h2F2vs4ziysMXSXrOGwusYXcfD1zmIFAdwFOe71kr+tqOv6jVlVVnVvJ5Q1YZIgK
         ac9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F9yhgj+6ArvrtFVIbg6vtYy8oqEY7mQcPE3AQ+WlIQ0=;
        b=ethTxZnMxR3wfATiNlFV29nxO8XnqyYxuDlcmKvOa4MnbGHcHEGYdHPwELcyG+u+ET
         bxJqCAXY2l6VJk46/ntzjiSYdNseXyaJVJBFM/pndDEf0GJaZZGy35YbVuwh3qyyEtUn
         vUa0vzcdXeHe/rrBCfciCTeWIx3LNgYjc49SkC7WIh53a4JdOiwhD+WaIjG89dnEhevc
         yBKjpifS2nczaKYz8sJB/hD8zfc/B6fXKFNvZzKcoFmTVAhytoCZC0fnz7Q75Tzjvf4d
         B/FoFtTF2zkiuQq9PxcUo7a97Kts/eDELYT0MmRcVQKapP+GWoDqf9ARk7rMelBM1VY2
         m48w==
X-Gm-Message-State: ACrzQf1z/dxJGQB9G/N/BU3WnHdKw5n8CE1A2Tl5PFpPy6J8agyie7Ut
        iT/avIWSmULSHY8xL9aTdkU=
X-Google-Smtp-Source: AMsMyM5LT3S8Sf3tClaiBHaGlWt/pMux0Iu1g5BlUWs9LQeW4TdAgV7usujoZgjhxPzpq0Z6Bd+biQ==
X-Received: by 2002:a17:906:66ce:b0:7ad:d178:c252 with SMTP id k14-20020a17090666ce00b007add178c252mr5800353ejp.158.1667230676190;
        Mon, 31 Oct 2022 08:37:56 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb7e.dynamic.kabel-deutschland.de. [95.90.187.126])
        by smtp.gmail.com with ESMTPSA id f24-20020a17090631d800b007ad98918743sm3072990ejf.1.2022.10.31.08.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 08:37:55 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: r8188eu: replace ternary operator with min, max, abs macros
Date:   Mon, 31 Oct 2022 16:37:43 +0100
Message-Id: <20221031153743.8801-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.38.0
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

Replace some ternary operators with the min(), max() or abs() macros
to improve readability.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_xmit.c      | 3 +--
 drivers/staging/r8188eu/hal/HalPhyRf_8188e.c | 2 +-
 drivers/staging/r8188eu/hal/odm_RTL8188E.c   | 4 ++--
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index 4f8220428328..bd6c1a401c59 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -476,8 +476,7 @@ static uint rtw_pktfile_read(struct pkt_file *pfile, u8 *rmem, uint rlen)
 {
 	uint len;
 
-	len = rtw_remainder_len(pfile);
-	len = (rlen > len) ? len : rlen;
+	len = min(rtw_remainder_len(pfile), rlen);
 
 	if (rmem)
 		skb_copy_bits(pfile->pkt, pfile->buf_len - pfile->pkt_len, rmem, len);
diff --git a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
index 60cdfcf80daa..622f95d3f2ed 100644
--- a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
+++ b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
@@ -583,7 +583,7 @@ static bool phy_SimularityCompare_8188E(
 			tmp2 = resulta[c2][i];
 		}
 
-		diff = (tmp1 > tmp2) ? (tmp1 - tmp2) : (tmp2 - tmp1);
+		diff = abs(tmp1 - tmp2);
 
 		if (diff > MAX_TOLERANCE) {
 			if ((i == 2 || i == 6) && !sim_bitmap) {
diff --git a/drivers/staging/r8188eu/hal/odm_RTL8188E.c b/drivers/staging/r8188eu/hal/odm_RTL8188E.c
index dd9c8291f025..f3f4074d4316 100644
--- a/drivers/staging/r8188eu/hal/odm_RTL8188E.c
+++ b/drivers/staging/r8188eu/hal/odm_RTL8188E.c
@@ -199,7 +199,7 @@ static void odm_HWAntDiv(struct odm_dm_struct *dm_odm)
 			Aux_RSSI = (dm_fat_tbl->AuxAnt_Cnt[i] != 0) ? (dm_fat_tbl->AuxAnt_Sum[i] / dm_fat_tbl->AuxAnt_Cnt[i]) : 0;
 			TargetAnt = (Main_RSSI >= Aux_RSSI) ? MAIN_ANT : AUX_ANT;
 			/* 2 Select MaxRSSI for DIG */
-			LocalMaxRSSI = (Main_RSSI > Aux_RSSI) ? Main_RSSI : Aux_RSSI;
+			LocalMaxRSSI = max(Main_RSSI, Aux_RSSI);
 			if ((LocalMaxRSSI > AntDivMaxRSSI) && (LocalMaxRSSI < 40))
 				AntDivMaxRSSI = LocalMaxRSSI;
 			if (LocalMaxRSSI > MaxRSSI)
@@ -211,7 +211,7 @@ static void odm_HWAntDiv(struct odm_dm_struct *dm_odm)
 			else if ((dm_fat_tbl->RxIdleAnt == AUX_ANT) && (Aux_RSSI == 0))
 				Aux_RSSI = Main_RSSI;
 
-			LocalMinRSSI = (Main_RSSI > Aux_RSSI) ? Aux_RSSI : Main_RSSI;
+			LocalMinRSSI = min(Main_RSSI, Aux_RSSI);
 			if (LocalMinRSSI < MinRSSI) {
 				MinRSSI = LocalMinRSSI;
 				RxIdleAnt = TargetAnt;
-- 
2.38.0

