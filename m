Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24FBE6625AE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 13:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233562AbjAIMd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 07:33:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237286AbjAIMcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 07:32:35 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C5F1789F;
        Mon,  9 Jan 2023 04:32:25 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id bj3so5356551pjb.0;
        Mon, 09 Jan 2023 04:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8kJNw0tI78VKEk8giaqn7hQZMx/hePZ8gBUzDu+yW+0=;
        b=gqahu2rsRXtJQvHmv5itTvGs02lPf2ptjB3OzBJPgELA5plaTOYe9KWSVgZdSua0AS
         XGw4pLklWleE0p27WzfgT3lUOgeufyyudSWcJT+L0IjQKyFgPGzdMDTcXOL4yGDgmtGx
         /AQkK6C/Ej2hyN0DlNu/0zno80Ka5alkCRPuqcURvsPQ0KcaLR8UBs7xdOMiv8EzzykH
         m+0flcQ1r/Qg60MAFS2sMuAScxyYRmuJUyCq4jtzJvwz7vcD3bA8oEToWrDaNth+p2E3
         TAH49xrqFdcAVMDqmAgGI+D9XBQRyS0uOyCoyOJF/4oPQHIOHIbjQZ6qsxx7KCJ+/RBB
         gKdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8kJNw0tI78VKEk8giaqn7hQZMx/hePZ8gBUzDu+yW+0=;
        b=LCizTIpLrFKMOcfGdCGrDYAK03qGxhvXqP9ZsT1PmViK9433RYP2e5aqRRM5UY2UFb
         DEqeVfBHtW53GTsXCYAr66Za4t32YKfjXAZNWYFa16GrCz6i6apNXAP3EyN7SvEm6sQz
         XKZmDH3kWzHcbVy+U88rkh5HRx0I8zCBhIyOzyZSlsHO4H66hpETiU6UggI6+9Vd5HBS
         NvNYKGJclaxWMLIzZEMSp6DyODcWQlJXU/LVsaZQH3ZsOKW9SFiEizv3HgFIQ4SKZveu
         h4KjuWls5FLYPVuxh3JJ6NpjpVpBKVZADkFEOeecwcUlp8iO3Jq9eWk5M0ezOj7hVLil
         YyKA==
X-Gm-Message-State: AFqh2krx3xzRZInq7E8rlJq2tBMOTIVtPhssS2+7vUHDpCHsZPcAxg6w
        LMdSS0EV15kFm3jvyuYdRqI=
X-Google-Smtp-Source: AMrXdXsafOOb6uEDFeKl5sAy36Uu+Bx7S6fwTB4V2LmFOxMLO6f1fLjebOC9ZYWuprEQhKctEtglNQ==
X-Received: by 2002:a05:6a20:3945:b0:b3:5196:9505 with SMTP id r5-20020a056a20394500b000b351969505mr67929557pzg.30.1673267545270;
        Mon, 09 Jan 2023 04:32:25 -0800 (PST)
Received: from mi-OptiPlex-7080.mioffice.cn ([2408:8607:1b00:8:b27b:25ff:fe2c:5c4])
        by smtp.gmail.com with ESMTPSA id h9-20020a63f909000000b00439c6a4e1ccsm4992733pgi.62.2023.01.09.04.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 04:32:24 -0800 (PST)
From:   Qi Feng <fengqi706@gmail.com>
To:     jikos@kernel.org
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        fengqi <fengqi@xiaomi.com>
Subject: [PATCH] HID: add KEY_CAMERA_FOCUS event in HID
Date:   Mon,  9 Jan 2023 20:32:16 +0800
Message-Id: <20230109123216.4974-1-fengqi706@gmail.com>
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
event is non-existent in current HID driver.
So we add this event in hid-input.c

Signed-off-by: fengqi <fengqi@xiaomi.com>
---
 drivers/hid/hid-input.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 9b59e436df0a..22cca3406b5c 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -1105,6 +1105,7 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 		case 0x0e5: map_key_clear(KEY_BASSBOOST);	break;
 		case 0x0e9: map_key_clear(KEY_VOLUMEUP);	break;
 		case 0x0ea: map_key_clear(KEY_VOLUMEDOWN);	break;
+		case 0x0ee: map_key_clear(KEY_CAMERA_FOCUS);	break;
 		case 0x0f5: map_key_clear(KEY_SLOW);		break;
 
 		case 0x181: map_key_clear(KEY_BUTTONCONFIG);	break;
-- 
2.39.0

