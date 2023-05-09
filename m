Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49FDA6FBDE6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 05:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234596AbjEID4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 23:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234637AbjEID4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 23:56:05 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78FE0D2C9;
        Mon,  8 May 2023 20:55:35 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1ab0c697c84so40647485ad.3;
        Mon, 08 May 2023 20:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683604531; x=1686196531;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/LScAQLvLy2KJzZIX1XiMv58IwV2dMEiIzwcsMUn1A4=;
        b=TpEG5YCu4WuU4Td8kK/b8hkh408J24waDjpTj9REXrzkvXVOo5lts6nwF7SE3r2TFA
         XkbNYgYFxLtp2jcmPQov7SyiXF599dJT6TvL1SNB7bLlrR6pSaUgsDK0jE+cRU2dznWp
         XjBsCI/i6IBp/KD0EBs4nPL/YzYKopkxqBmr1E+tGGhRvTx+f6EKEfVaL3ftmKsG66kV
         +wXgHgvBoenQU7mOAmCERvQRJXcfV3gs5Zw7HsCMJASD8tv+sedGBKg/F9RIlSms2cMI
         42wjEE6kSjJIazH7MDFdSFoeJTEnM9fl8chwVqjJW3IwwyyEuCxhOqG+r695lxnpy4gM
         IetA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683604531; x=1686196531;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/LScAQLvLy2KJzZIX1XiMv58IwV2dMEiIzwcsMUn1A4=;
        b=P1YE745rPC89vhf66BAYjCqmoOYKKU3I1+s5tFaD8Hjo+aXvzbcTGlrZdKWNzrbK/5
         wf0eS66TUl+pxHXe8UY9NVnAaHhxOoFFOr4BZ52AloU5XSYfqObF9v/qplIyucSJkSJa
         KFNHILGaAsofGaJ+SNuimk7nQv5zetqT1Zicly5SjHbXIm4j5CIn0vfbr4ibJCU8j68Q
         Vhcr003wOjLxGz2qe0dtwcP7wUOL4YvukaEWye37Mlrl9R1gI47k8otTEuYrLzk1SyHW
         tnBqQp6sWv0sawVXdwCKbPB+qkgdV7bU0PgXy59laC8zf5R72pGW7MJHo1FiL38nFQRA
         5mwQ==
X-Gm-Message-State: AC+VfDzg+MBjSHlA8crtUfHpk3XqIoUE5v5xgr87QMJSnFsYTjfZKNnL
        HcPx6fRbZDP6TUspuZ7Rn+4ngMslyDs=
X-Google-Smtp-Source: ACHHUZ6gyVdwymP9pMNCfo73/YvExpRL6tps3rAPkxcaQd7AmxbpXJ1MU02ACUKY+OXHIEEvdq7Hxw==
X-Received: by 2002:a17:902:e748:b0:1a9:a478:66c5 with SMTP id p8-20020a170902e74800b001a9a47866c5mr16689358plf.63.1683604530927;
        Mon, 08 May 2023 20:55:30 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:d72f:84b8:c441:6a95])
        by smtp.gmail.com with ESMTPSA id p17-20020a170902ead100b001a1faed8707sm306760pld.63.2023.05.08.20.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 20:55:30 -0700 (PDT)
Date:   Mon, 8 May 2023 20:55:27 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jondaniel879@gmail.com
Subject: [PATCH] Input: psmouse - fix OOB access in Elantech protocol
Message-ID: <ZFnEL91nrT789dbG@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel only allocate 5 MT slots; check that transmitted slot ID
falls within the acceptable range.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=217417
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/mouse/elantech.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index ece97f8c6a3e..2118b2075f43 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -674,10 +674,11 @@ static void process_packet_head_v4(struct psmouse *psmouse)
 	struct input_dev *dev = psmouse->dev;
 	struct elantech_data *etd = psmouse->private;
 	unsigned char *packet = psmouse->packet;
-	int id = ((packet[3] & 0xe0) >> 5) - 1;
+	int id;
 	int pres, traces;
 
-	if (id < 0)
+	id = ((packet[3] & 0xe0) >> 5) - 1;
+	if (id < 0 || id >= ETP_MAX_FINGERS)
 		return;
 
 	etd->mt[id].x = ((packet[1] & 0x0f) << 8) | packet[2];
@@ -707,7 +708,7 @@ static void process_packet_motion_v4(struct psmouse *psmouse)
 	int id, sid;
 
 	id = ((packet[0] & 0xe0) >> 5) - 1;
-	if (id < 0)
+	if (id < 0 || id >= ETP_MAX_FINGERS)
 		return;
 
 	sid = ((packet[3] & 0xe0) >> 5) - 1;
@@ -728,7 +729,7 @@ static void process_packet_motion_v4(struct psmouse *psmouse)
 	input_report_abs(dev, ABS_MT_POSITION_X, etd->mt[id].x);
 	input_report_abs(dev, ABS_MT_POSITION_Y, etd->mt[id].y);
 
-	if (sid >= 0) {
+	if (sid >= 0 && sid < ETP_MAX_FINGERS) {
 		etd->mt[sid].x += delta_x2 * weight;
 		etd->mt[sid].y -= delta_y2 * weight;
 		input_mt_slot(dev, sid);
-- 
2.40.1.521.gf1e218fcd8-goog


-- 
Dmitry
