Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22512675F32
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 21:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjATU7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 15:59:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjATU7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 15:59:32 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428869DCB3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 12:59:32 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id lp10so3302461pjb.4
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 12:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G/NayfWzq9vrN64+FXlyicb+sQzGrHgAlMcsBqy5/Cs=;
        b=l/q7MlA/inIGoQ3K/SDK8UD8cG2LVoYnoWkGGQ+EDbGa2+VR4ctg3/rVLdL417Tx+P
         ChQqo9uxD7mPTcP9lqnLSIMqk6pN88gSpocAfXKF5/2aGaNH9pKI2j2awNxizDvbJS4i
         AhX1uH6z9QhCZDYBmc7ZI7MYGNkoXRvs6aEU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G/NayfWzq9vrN64+FXlyicb+sQzGrHgAlMcsBqy5/Cs=;
        b=sCvaBKcq8SpkPgplet7dNoXvUUpCRyUCwcseiXZ+wdYGjgy8KkftCb5v1SwUIoujlw
         HFhx9pB+54TXlRu8QIM8YlLs5DmQdLDtPf6g6vJvto0OYSq4qN070guGG77SJ2fHI4mm
         yEPbryq/tViZ59QEL3S8TH7cbIttj3YRp7Tr7C1oFOYLhW9mLA+N+e2zVVNTS3Q5b46l
         obzS+dpZvqZ5MD36p6WK4So5uKLObMwqE1RVCpnrc/YAAFo2vb3F/exbJ0AfCDJ6+19M
         YlJYW6UZic+iyeHBWbQlQr9qeeTCF2OXuXGrHAweAuuugoWEM1fIcKnl1PX93Lq2luVn
         lsow==
X-Gm-Message-State: AFqh2kpI1tKfmIybI2jWII3t2rHEYMnUrXeXb5ZOt48angIHypki8bXX
        9Tafj5oIHuZVntEZGGXUNvfu5AJYP/TfNMCZ
X-Google-Smtp-Source: AMrXdXtRw3yvvXA4LlvC6kbgh+AR6TQ+FwpcadiJL93OfITw2aiV8BncTKrpas5qfHVx8jmP5GGejg==
X-Received: by 2002:a17:902:7b98:b0:189:9031:6761 with SMTP id w24-20020a1709027b9800b0018990316761mr15758402pll.22.1674248371579;
        Fri, 20 Jan 2023 12:59:31 -0800 (PST)
Received: from pmalani.c.googlers.com.com (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id n11-20020a170902e54b00b0018c7a5e052asm27248336plf.225.2023.01.20.12.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 12:59:31 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     bleung@chromium.org, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org, Prashant Malani <pmalani@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 1/2] usb: typec: altmodes/displayport: Update active state
Date:   Fri, 20 Jan 2023 20:58:26 +0000
Message-Id: <20230120205827.740900-1-pmalani@chromium.org>
X-Mailer: git-send-email 2.39.0.246.g2a6d74b583-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the altmode "active" state when we receive Acks for Enter and
Exit Mode commands. Having the right state is necessary to change Pin
Assignments using the 'pin_assignment" sysfs file.

Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Benson Leung <bleung@chromium.org>
Signed-off-by: Prashant Malani <pmalani@chromium.org>
---

Changes since v1:
- Dropped the Fixes and Cc: stable tags; given the discussion in [1]
  I no longer think this constitutes a fix.
- Added Reviewed-by tag from Benson.

[1] https://lore.kernel.org/linux-usb/20230118031514.1278139-1-pmalani@chromium.org/

 drivers/usb/typec/altmodes/displayport.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/typec/altmodes/displayport.c b/drivers/usb/typec/altmodes/displayport.c
index 06fb4732f8cd..bc1c556944d6 100644
--- a/drivers/usb/typec/altmodes/displayport.c
+++ b/drivers/usb/typec/altmodes/displayport.c
@@ -277,9 +277,11 @@ static int dp_altmode_vdm(struct typec_altmode *alt,
 	case CMDT_RSP_ACK:
 		switch (cmd) {
 		case CMD_ENTER_MODE:
+			typec_altmode_update_active(alt, true);
 			dp->state = DP_STATE_UPDATE;
 			break;
 		case CMD_EXIT_MODE:
+			typec_altmode_update_active(alt, false);
 			dp->data.status = 0;
 			dp->data.conf = 0;
 			break;
-- 
2.39.0.246.g2a6d74b583-goog

