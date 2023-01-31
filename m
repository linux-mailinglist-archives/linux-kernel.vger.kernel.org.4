Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8C2682BC1
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 12:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbjAaLqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 06:46:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjAaLqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 06:46:42 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408FA76BE;
        Tue, 31 Jan 2023 03:46:41 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id 88so13962392pjo.3;
        Tue, 31 Jan 2023 03:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PjISyEvLSM8zNJJjTBgmgABoeEzkNDKERerzF3+fUns=;
        b=W+3kkLZ3OJOvOZJMq3AqcUMsgM1DjLW8c/8MWurN4pUdu+7VCF1F6euYBbpc6nUTen
         0pXKe9RYOS5T+NjdyJjGslyB7H9AdJBocI7gczukXFUz323/A/I3gac3ETHN7UqAN/ZH
         l4BxDq5vQUqWm41iDK6LvTEXVeGPFBONoa+pbkg52rleFc4FDypin3eSYDkI5s0nVkz7
         ixWS6qyZ/lqAaq0zkKYfTlDIGkL+lniLs3HoZrUIscZMnC2i+HBQV3XoJDoF0L5trrjg
         slBdOd/NKQOmGtrfwDJcN++xbDEm24wxv93FqSeSWAC2C+2lyCQ6mRww2vbSWc/suOaD
         GmVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PjISyEvLSM8zNJJjTBgmgABoeEzkNDKERerzF3+fUns=;
        b=VP7ElmvOB9ustH0msJlUMHN1Vb3E1ZrTS/y3OqtOqMhaEvD0rBU+dJJfPhGhhud3N5
         LLuuM8ATO95qSbjPvKK6w6NmFQr6uClaKvEPlCExGFnz9BHuI9IAWBXJ9oJ7VROqWTHe
         WR+CcsVy9JQFOinw8nJ5LZQgB0lRGyUm5hKTh0SJm4jF3zX6EO19I3rGTQmv7UcjfRCS
         EpNm55Mi55IVARbgGms3dvdMs+eRoEpLTI6e6nl/oTdmtnDmvG1t+CtABUcf68+W6jnv
         Wd+ONiuK/PX3RP6vUN3dP+saYlQxYCLPYOCcDGKyJOvBEvY+toPAyGjqpvphBtHXSp7g
         S9Hw==
X-Gm-Message-State: AO0yUKXXe5XXc8uT71j88bUxPghlLlb/h8jkc6TCwLG6JGXejd5jiiup
        Y9B1vPH9ZqoCxT8nKqvcc+0=
X-Google-Smtp-Source: AK7set8cePzSDFzGxj8lSNAPD8RQwY0vEZvoe/uOCUx4XLui27O2hMm8YcbVMhdsO5Hx2g+9mz3bLw==
X-Received: by 2002:a05:6a20:8f1c:b0:bc:5f20:1409 with SMTP id b28-20020a056a208f1c00b000bc5f201409mr16325856pzk.17.1675165600610;
        Tue, 31 Jan 2023 03:46:40 -0800 (PST)
Received: from mi-OptiPlex-7080.mioffice.cn ([2408:8607:1b00:8:b27b:25ff:fe2c:5c4])
        by smtp.gmail.com with ESMTPSA id t12-20020a170902a5cc00b0019667318941sm6167932plq.176.2023.01.31.03.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 03:46:40 -0800 (PST)
From:   Qi Feng <fengqi706@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, rydberg@bitmath.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        fengqi <fengqi@xiaomi.com>
Subject: [PATCH v2] HID: add KEY_CAMERA_FOCUS event in HID
Date:   Tue, 31 Jan 2023 19:46:32 +0800
Message-Id: <20230131114632.14078-1-fengqi706@gmail.com>
X-Mailer: git-send-email 2.39.0
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

From: fengqi <fengqi@xiaomi.com>

Our HID device need KEY_CAMERA_FOCUS event to control camera, but this
event is non-existent in current HID driver.we add this event in hid-input.c
We committed this v2 version following your previous suggestion

Signed-off-by: fengqi <fengqi@xiaomi.com>
---
 drivers/hid/hid-input.c | 7 +++++++
 include/linux/hid.h     | 1 +
 2 files changed, 8 insertions(+)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 9b59e436df0a..05fa3e191574 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -1221,6 +1221,13 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 			return;
 		}
 		goto unknown;
+	case HID_UP_CAMERA:
+		switch (usage->hid & HID_USAGE){
+		case 0x020: map_key_clear(KEY_CAMERA_FOCUS);	break;
+		case 0x021: map_key_clear(KEY_CAMERA);		break;
+		default: 	goto ignore;
+		}
+		break;		
 
 	case HID_UP_HPVENDOR:	/* Reported on a Dutch layout HP5308 */
 		set_bit(EV_REP, input->evbit);
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 8677ae38599e..e3daf2c7739c 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -155,6 +155,7 @@ struct hid_item {
 #define HID_UP_DIGITIZER	0x000d0000
 #define HID_UP_PID		0x000f0000
 #define HID_UP_BATTERY		0x00850000
+#define HID_UP_CAMERA 		0x00900000
 #define HID_UP_HPVENDOR         0xff7f0000
 #define HID_UP_HPVENDOR2        0xff010000
 #define HID_UP_MSVENDOR		0xff000000
-- 
2.39.0

