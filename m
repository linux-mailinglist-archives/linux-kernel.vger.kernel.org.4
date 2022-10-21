Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA4D607506
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 12:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbiJUKeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 06:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbiJUKeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 06:34:12 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188F525E088
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 03:34:10 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id b1so4345727lfs.7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 03:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0vK0LqI42j1feZQYGTo54nlQs1yB+CHMNY80qJ318mw=;
        b=S7F2cpHrcxjbXzstbQBwT79Kaeiw/BkOKqB5Z8Aj+Cn8xbti7DOXrBPve27zsiv4sw
         IUyOhUFP+mSEVM6aPwW/a0E/vxlKDTNXJPuifAfSkzm6Sc8VqwT7GO4si/GRbHPv6rOm
         8Z6Jq+Yjw8w7PFznjbjjn6n0k+4NyvKeMhStwCxCpC2iQHlFh/YrRRWMRF2iZ5+PDpwT
         Pt8DEdCNrdyE8ak4HGwepb000qwYiXbFoWh/i94JjfUk7pf+C4EcrgQJVHbztHhxN9f0
         yLjc4uaj+/WxAqoa2dlPuYlgtDFFUQFX2wj05e5wQAmdRPMlJhA35UEzJJ0eDXpq/4lA
         6alg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0vK0LqI42j1feZQYGTo54nlQs1yB+CHMNY80qJ318mw=;
        b=h9MHwrlJtiqIWicG3GGPqxwCEN0HVLfAcu55FpnNosJMzn0Nj0pLlCbF6hWuuB+g3F
         f6Epz4lDWk/UsSigBCPTsHXmMDdUHkoGXh26FZVY2YhN9GGgEyXoP/a/evrcxWLjlWj/
         b/I4v2MHowaX8zhbgybNudLSdxHFpsYT2JAMqEDSySfhxqeYTalIvrUsNsbL9IgiUuE0
         dl4uiJ7fluiL5kK+CzHAmQV5Kft6mu3p2JbMHbAxFvmowvYhetxy3SCX4f/mIm+ILJZN
         8ouuQ1LLyNvo/sOFagoTagBbNV1nDApkWF57t/wKSpBNLEJRNpb04OFoTPz0Wxmlqh3t
         88hA==
X-Gm-Message-State: ACrzQf27REyh+MS+92sBlokxTHcxuZZPIkZ/NF3AiKKl8q8W7yZY0i9t
        pyDlAEDFNZOLMoBFfG9p1hY=
X-Google-Smtp-Source: AMsMyM5Q7Ytf+rmjOz+uX6kWKTdtNKjE3/h1sCVx2br18wSsySQoDoc/CeZWYXBAm99U4gk4c3xyfA==
X-Received: by 2002:ac2:551c:0:b0:4a2:3c32:aff5 with SMTP id j28-20020ac2551c000000b004a23c32aff5mr7080829lfk.31.1666348447862;
        Fri, 21 Oct 2022 03:34:07 -0700 (PDT)
Received: from elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net ([20.240.130.248])
        by smtp.googlemail.com with ESMTPSA id u12-20020ac258cc000000b00492d7a7b4e3sm3119775lfo.4.2022.10.21.03.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 03:34:07 -0700 (PDT)
From:   Tanjuate Brunostar <tanjubrunostar0@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev,
        Tanjuate Brunostar <tanjubrunostar0@gmail.com>
Subject: [PATCH v2 3/6] staging: vt6655: refactor long lines of code in s_uFillDataHead
Date:   Fri, 21 Oct 2022 10:33:07 +0000
Message-Id: <efea04994141bd98abee42ad552544ba9f5dab74.1666347511.git.tanjubrunostar0@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1666347511.git.tanjubrunostar0@gmail.com>
References: <cover.1666347511.git.tanjubrunostar0@gmail.com>
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

fix checkpatch errors by refactoring long lines of code in the function: s_uFillDataHead

Signed-off-by: Tanjuate Brunostar <tanjubrunostar0@gmail.com>
---
 drivers/staging/vt6655/rxtx.c | 97 ++++++++++++++++++++++++-----------
 1 file changed, 67 insertions(+), 30 deletions(-)

diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
index 01e72999831b..dc853b83459b 100644
--- a/drivers/staging/vt6655/rxtx.c
+++ b/drivers/staging/vt6655/rxtx.c
@@ -484,19 +484,28 @@ static __le16 s_uFillDataHead(struct vnt_private *pDevice,
 			} else {
 				/* Get Duration and TimeStamp */
 				buf->duration_a =
-					cpu_to_le16((u16)s_uGetDataDuration(pDevice, DATADUR_A, cbFrameLength,
-									    byPktType, wCurrentRate, bNeedAck, uFragIdx,
-									    cbLastFragmentSize, uMACfragNum,
+					cpu_to_le16((u16)s_uGetDataDuration(pDevice, DATADUR_A,
+									    cbFrameLength,
+									    byPktType,
+									    wCurrentRate, bNeedAck,
+									    uFragIdx,
+									    cbLastFragmentSize,
+									    uMACfragNum,
 									    byFBOption));
 				buf->duration_b =
-					cpu_to_le16((u16)s_uGetDataDuration(pDevice, DATADUR_B, cbFrameLength,
-									    PK_TYPE_11B, pDevice->byTopCCKBasicRate,
-									    bNeedAck, uFragIdx, cbLastFragmentSize,
-									    uMACfragNum, byFBOption));
+					cpu_to_le16((u16)s_uGetDataDuration(pDevice, DATADUR_B,
+									    cbFrameLength,
+									    PK_TYPE_11B,
+									    pDevice->byTopCCKBasicRate,
+									    bNeedAck, uFragIdx,
+									    cbLastFragmentSize,
+									    uMACfragNum,
+									    byFBOption));
 			}
 
 			buf->time_stamp_off_a = vnt_time_stamp_off(pDevice, wCurrentRate);
-			buf->time_stamp_off_b = vnt_time_stamp_off(pDevice, pDevice->byTopCCKBasicRate);
+			buf->time_stamp_off_b = vnt_time_stamp_off(pDevice,
+								   pDevice->byTopCCKBasicRate);
 
 			return buf->duration_a;
 		}
@@ -509,14 +518,29 @@ static __le16 s_uFillDataHead(struct vnt_private *pDevice,
 				  pDevice->byTopCCKBasicRate,
 				  PK_TYPE_11B, &buf->b);
 		/* Get Duration and TimeStamp */
-		buf->duration_a = cpu_to_le16((u16)s_uGetDataDuration(pDevice, DATADUR_A, cbFrameLength, byPktType,
-								      wCurrentRate, bNeedAck, uFragIdx, cbLastFragmentSize, uMACfragNum, byFBOption));
-		buf->duration_b = cpu_to_le16((u16)s_uGetDataDuration(pDevice, DATADUR_B, cbFrameLength, PK_TYPE_11B,
-								       pDevice->byTopCCKBasicRate, bNeedAck, uFragIdx, cbLastFragmentSize, uMACfragNum, byFBOption));
-		buf->duration_a_f0 = cpu_to_le16((u16)s_uGetDataDuration(pDevice, DATADUR_A_F0, cbFrameLength, byPktType,
-									  wCurrentRate, bNeedAck, uFragIdx, cbLastFragmentSize, uMACfragNum, byFBOption));
-		buf->duration_a_f1 = cpu_to_le16((u16)s_uGetDataDuration(pDevice, DATADUR_A_F1, cbFrameLength, byPktType,
-									 wCurrentRate, bNeedAck, uFragIdx, cbLastFragmentSize, uMACfragNum, byFBOption));
+		buf->duration_a = cpu_to_le16((u16)s_uGetDataDuration(pDevice, DATADUR_A,
+								      cbFrameLength, byPktType,
+								      wCurrentRate, bNeedAck,
+								      uFragIdx, cbLastFragmentSize,
+								      uMACfragNum, byFBOption));
+		buf->duration_b = cpu_to_le16((u16)s_uGetDataDuration(pDevice, DATADUR_B,
+								      cbFrameLength, PK_TYPE_11B,
+								      pDevice->byTopCCKBasicRate,
+								      bNeedAck, uFragIdx,
+								      cbLastFragmentSize,
+								      uMACfragNum, byFBOption));
+		buf->duration_a_f0 = cpu_to_le16((u16)s_uGetDataDuration(pDevice, DATADUR_A_F0,
+									 cbFrameLength, byPktType,
+									 wCurrentRate, bNeedAck,
+									 uFragIdx,
+									 cbLastFragmentSize,
+									 uMACfragNum, byFBOption));
+		buf->duration_a_f1 = cpu_to_le16((u16)s_uGetDataDuration(pDevice, DATADUR_A_F1,
+									 cbFrameLength, byPktType,
+									 wCurrentRate, bNeedAck,
+									 uFragIdx,
+									 cbLastFragmentSize,
+									 uMACfragNum, byFBOption));
 
 		buf->time_stamp_off_a = vnt_time_stamp_off(pDevice, wCurrentRate);
 		buf->time_stamp_off_b = vnt_time_stamp_off(pDevice, pDevice->byTopCCKBasicRate);
@@ -534,12 +558,24 @@ static __le16 s_uFillDataHead(struct vnt_private *pDevice,
 					  byPktType, &buf->a);
 
 			/* Get Duration and TimeStampOff */
-			buf->duration = cpu_to_le16((u16)s_uGetDataDuration(pDevice, DATADUR_A, cbFrameLength, byPktType,
-									    wCurrentRate, bNeedAck, uFragIdx, cbLastFragmentSize, uMACfragNum, byFBOption));
-			buf->duration_f0 = cpu_to_le16((u16)s_uGetDataDuration(pDevice, DATADUR_A_F0, cbFrameLength, byPktType,
-									       wCurrentRate, bNeedAck, uFragIdx, cbLastFragmentSize, uMACfragNum, byFBOption));
-			buf->duration_f1 = cpu_to_le16((u16)s_uGetDataDuration(pDevice, DATADUR_A_F1, cbFrameLength, byPktType,
-										wCurrentRate, bNeedAck, uFragIdx, cbLastFragmentSize, uMACfragNum, byFBOption));
+			buf->duration =
+				cpu_to_le16((u16)s_uGetDataDuration(pDevice, DATADUR_A,
+								    cbFrameLength, byPktType,
+								    wCurrentRate, bNeedAck,
+								    uFragIdx, cbLastFragmentSize,
+								    uMACfragNum, byFBOption));
+			buf->duration_f0 =
+				cpu_to_le16((u16)s_uGetDataDuration(pDevice, DATADUR_A_F0,
+								    cbFrameLength, byPktType,
+								    wCurrentRate, bNeedAck,
+								    uFragIdx, cbLastFragmentSize,
+								    uMACfragNum, byFBOption));
+			buf->duration_f1 =
+				cpu_to_le16((u16)s_uGetDataDuration(pDevice, DATADUR_A_F1,
+								    cbFrameLength, byPktType,
+								    wCurrentRate, bNeedAck,
+								    uFragIdx, cbLastFragmentSize,
+								    uMACfragNum, byFBOption));
 			buf->time_stamp_off = vnt_time_stamp_off(pDevice, wCurrentRate);
 			return buf->duration;
 		}
@@ -555,10 +591,11 @@ static __le16 s_uFillDataHead(struct vnt_private *pDevice,
 		} else {
 			/* Get Duration and TimeStampOff */
 			buf->duration =
-				cpu_to_le16((u16)s_uGetDataDuration(pDevice, DATADUR_A, cbFrameLength, byPktType,
-								    wCurrentRate, bNeedAck, uFragIdx,
-								    cbLastFragmentSize, uMACfragNum,
-								    byFBOption));
+				cpu_to_le16((u16)s_uGetDataDuration(pDevice, DATADUR_A,
+								    cbFrameLength, byPktType,
+								    wCurrentRate, bNeedAck,
+								    uFragIdx, cbLastFragmentSize,
+								    uMACfragNum, byFBOption));
 		}
 
 		buf->time_stamp_off = vnt_time_stamp_off(pDevice, wCurrentRate);
@@ -576,10 +613,10 @@ static __le16 s_uFillDataHead(struct vnt_private *pDevice,
 	} else {
 		/* Get Duration and TimeStampOff */
 		buf->duration =
-			cpu_to_le16((u16)s_uGetDataDuration(pDevice, DATADUR_B, cbFrameLength, byPktType,
-							    wCurrentRate, bNeedAck, uFragIdx,
-							    cbLastFragmentSize, uMACfragNum,
-							    byFBOption));
+			cpu_to_le16((u16)s_uGetDataDuration(pDevice, DATADUR_B, cbFrameLength,
+							    byPktType, wCurrentRate, bNeedAck,
+							    uFragIdx, cbLastFragmentSize,
+							    uMACfragNum, byFBOption));
 	}
 
 	buf->time_stamp_off = vnt_time_stamp_off(pDevice, wCurrentRate);
-- 
2.34.1

