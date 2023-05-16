Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EEBF705AAC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 00:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjEPWif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 18:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbjEPWiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 18:38:25 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438326199
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 15:38:10 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1ab032d9266so2329315ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 15:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684276690; x=1686868690;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vbJEV48J4NMFZNK/dI2UJhC6ykl0UhPDNLnBVnRsU/w=;
        b=YDivJEGLYVwP1jtDneM3aG9yzIVFsayF8eGOctNxhTXvUoqCcpjHyoAk4jJn6Ltznl
         JlN8qt0k9abFnf1qzJ7NaunmNxststR5Y0oaBCCwpU9RG+ZISekmSNsrvwuH71MXqL+A
         7aW+i7BQS6IwG2WVZJ1eAZaH2JmGAO367r6c3H7qBgHQqhiYhZ4Kxf06Fjc2JDQN8sjl
         73xHnK+QAK6KPCQ6ihEDPWEupcG2xzY/4TjNaQ64j41hoV/CN+FZ8sUrRMAOA9ND/DTO
         NX39ZOhVd0Lxf32oSRyc+rquKVXBO5nQgI/qIhGNGIdGC0pWdwaSb0Lds/80AIO/46Zx
         /UBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684276690; x=1686868690;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vbJEV48J4NMFZNK/dI2UJhC6ykl0UhPDNLnBVnRsU/w=;
        b=XJHJNw1eQscTJgQdg31J5CfH+Tdut6eoAz+e/byVS1ZUytNaicJET1V3xUDHBVI5HP
         3CViJl59U/JEiSptLA8Vdm0OUtjiuIqkXNub3xYKHBSOi9ogdglKFbAcafQf6nbhu4QU
         ra2D+0fPQc5XvUrpMSdv3+dUFsWSFVTN8n2IYJ6w7/mUkAcj7k5vC1gvoTYlr/MLVw9u
         v5N0kPbQ+lOdQopOL49KTZee6nvt+DCTsLEzGtgKS6m84tTph2zGVmH5WxROKxckRz1g
         1OV+M4NhoH2qofOFSXLHmyFhX6/00cImSLEB1mRFCM12sQPpBumNCiOlhQanboSzvHne
         JuOg==
X-Gm-Message-State: AC+VfDx4neXjkX6I+ZmNccMkTxwp+A+MnyLL589J4rTIhd5221AWb49r
        rKv3PQsFdxLA47IrXqlQn84=
X-Google-Smtp-Source: ACHHUZ5iTa5QxKGz1//jWtHL7A7T+K6xZL1AnrItvgmJyd/LtFNyVTWVse9MTf6JP4ubEdqQtoaViw==
X-Received: by 2002:a17:902:7b8f:b0:1ae:6a3:d058 with SMTP id w15-20020a1709027b8f00b001ae06a3d058mr10887119pll.36.1684276690111;
        Tue, 16 May 2023 15:38:10 -0700 (PDT)
Received: from ubuntu777.domain.name (36-228-97-28.dynamic-ip.hinet.net. [36.228.97.28])
        by smtp.gmail.com with ESMTPSA id ij22-20020a170902ab5600b001ae46ccd19esm1029787plb.63.2023.05.16.15.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 15:38:09 -0700 (PDT)
From:   Min-Hua Chen <minhuadotchen@gmail.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Min-Hua Chen <minhuadotchen@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: compat_ioctl: use correct snd_ctl_elem_type_t type
Date:   Wed, 17 May 2023 06:38:05 +0800
Message-Id: <20230516223806.185683-1-minhuadotchen@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SNDRV_CTL_ELEM_TYPE_* are type of snd_ctl_elem_type_t, we
have to __force cast them to int when comparing them with int
to fix the following sparse warnings.

sound/core/control_compat.c:203:14: sparse: warning: restricted snd_ctl_elem_type_t degrades to integer
sound/core/control_compat.c:205:14: sparse: warning: restricted snd_ctl_elem_type_t degrades to integer
sound/core/control_compat.c:207:14: sparse: warning: restricted snd_ctl_elem_type_t degrades to integer
sound/core/control_compat.c:209:14: sparse: warning: restricted snd_ctl_elem_type_t degrades to integer
sound/core/control_compat.c:237:21: sparse: warning: restricted snd_ctl_elem_type_t degrades to integer
sound/core/control_compat.c:238:21: sparse: warning: restricted snd_ctl_elem_type_t degrades to integer
sound/core/control_compat.c:270:21: sparse: warning: restricted snd_ctl_elem_type_t degrades to integer
sound/core/control_compat.c:271:21: sparse: warning: restricted snd_ctl_elem_type_t degrades to integer

Signed-off-by: Min-Hua Chen <minhuadotchen@gmail.com>
---
 sound/core/control_compat.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/core/control_compat.c b/sound/core/control_compat.c
index d8a86d1a99d6..9cae5d74335c 100644
--- a/sound/core/control_compat.c
+++ b/sound/core/control_compat.c
@@ -197,7 +197,7 @@ static int get_ctl_type(struct snd_card *card, struct snd_ctl_elem_id *id,
 	return err;
 }
 
-static int get_elem_size(int type, int count)
+static int get_elem_size(snd_ctl_elem_type_t type, int count)
 {
 	switch (type) {
 	case SNDRV_CTL_ELEM_TYPE_INTEGER64:
@@ -234,8 +234,8 @@ static int copy_ctl_value_from_user(struct snd_card *card,
 	if (type < 0)
 		return type;
 
-	if (type == SNDRV_CTL_ELEM_TYPE_BOOLEAN ||
-	    type == SNDRV_CTL_ELEM_TYPE_INTEGER) {
+	if (type == (__force int)SNDRV_CTL_ELEM_TYPE_BOOLEAN ||
+	    type == (__force int)SNDRV_CTL_ELEM_TYPE_INTEGER) {
 		for (i = 0; i < count; i++) {
 			s32 __user *intp = valuep;
 			int val;
@@ -244,7 +244,7 @@ static int copy_ctl_value_from_user(struct snd_card *card,
 			data->value.integer.value[i] = val;
 		}
 	} else {
-		size = get_elem_size(type, count);
+		size = get_elem_size((__force snd_ctl_elem_type_t)type, count);
 		if (size < 0) {
 			dev_err(card->dev, "snd_ioctl32_ctl_elem_value: unknown type %d\n", type);
 			return -EINVAL;
@@ -267,8 +267,8 @@ static int copy_ctl_value_to_user(void __user *userdata,
 	struct snd_ctl_elem_value32 __user *data32 = userdata;
 	int i, size;
 
-	if (type == SNDRV_CTL_ELEM_TYPE_BOOLEAN ||
-	    type == SNDRV_CTL_ELEM_TYPE_INTEGER) {
+	if (type == (__force int)SNDRV_CTL_ELEM_TYPE_BOOLEAN ||
+	    type == (__force int)SNDRV_CTL_ELEM_TYPE_INTEGER) {
 		for (i = 0; i < count; i++) {
 			s32 __user *intp = valuep;
 			int val;
@@ -277,7 +277,7 @@ static int copy_ctl_value_to_user(void __user *userdata,
 				return -EFAULT;
 		}
 	} else {
-		size = get_elem_size(type, count);
+		size = get_elem_size((__force snd_ctl_elem_type_t)type, count);
 		if (copy_to_user(valuep, data->value.bytes.data, size))
 			return -EFAULT;
 	}
-- 
2.34.1

