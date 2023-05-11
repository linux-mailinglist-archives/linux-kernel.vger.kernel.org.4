Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 542636FF99E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 20:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238381AbjEKSxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 14:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238964AbjEKSxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 14:53:04 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3BDC72A4;
        Thu, 11 May 2023 11:53:03 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-51b4ef5378bso7988424a12.1;
        Thu, 11 May 2023 11:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683831182; x=1686423182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i3ptun2f4y66KVFb6kOCBJTEK7iEiDfMyju3agHSIDU=;
        b=m8bqGYoPywm+QbP1vtb894kCXei4JcogvpUZrKHVPNU2EywkY4I3ID3QHncecPB4z1
         yoTNAUdBaf7DeOkGUnKGS8rXrE8oEyAXAUQKJJo/TIEeO7jVcVNffO1lFxnV6zXV4/+5
         n2XvuQGq/S2vtdlFE3ScYbFVDc63nCur3gFQZKiR9w6RULUhQWKKkf3VYH5Eer9T8uoN
         6daUCS9SK93Bc8rYd8VayLTNZA8uwMTWytPzvlzc4WIWZHqsE3+go2ov8xqUJNAZPZml
         glGvQ11IHUaB/9JztRLHRkaY1syT80uEiYIKjaS1lnQKnZvu2YWedzMtrvtKLTcanCDK
         um2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683831182; x=1686423182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i3ptun2f4y66KVFb6kOCBJTEK7iEiDfMyju3agHSIDU=;
        b=U7uPI+RL1dw99e+TA2f76qjcWEv9hitzhoCo/m+pAp56vTuGRKK0tadB9/UydYesEQ
         TrmBJp5b8Z//tuRVp55MtWFzI9aHZ0AmahjcN2Z4rwgdW0tSzbT/ywPS9M+bqyM2aRrW
         F5EbJ2hSFZ13naE8YQb1EOV+yI09gevOtCNauSRATZsbhTpZoqBAF9Ek3ATVmCJRgN/1
         zOh2dr3IRSE4Xv6N6UNUyLc9+zIGZ5NBpc6zwZRB38JaQPsfYPywOgZyabRNFM3XbyZZ
         o8mwtYTT3pLw0ATY8RJQtgHHJX0n0InVLDZH49p+sd/yRFWrmO4SbclYlbXvDQnqqLZZ
         516w==
X-Gm-Message-State: AC+VfDwp9KemX1x8XJC+zXhXzLwwFHp80CHW3wLIuuwlRiegC9joUQIC
        RinqIxiXWXb7kQUYIWJj9tMCRqltiC0=
X-Google-Smtp-Source: ACHHUZ4zWpMmX3jPa8NHHY21Rf1rPbKb3X7P+tVNICK0kzA4XG2YbkcmM1fvY6ZB13gNboOQV2G7/Q==
X-Received: by 2002:a17:902:7402:b0:1a9:7a7c:2086 with SMTP id g2-20020a170902740200b001a97a7c2086mr22678782pll.27.1683831182415;
        Thu, 11 May 2023 11:53:02 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:84a:ed9c:4024:c347])
        by smtp.gmail.com with ESMTPSA id q5-20020a170902788500b001a980a23804sm6288995pll.4.2023.05.11.11.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 11:53:01 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     Raul E Rangel <rrangel@chromium.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] Input: libps2 - fix NAK handling
Date:   Thu, 11 May 2023 11:52:44 -0700
Message-ID: <20230511185252.386941-5-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
In-Reply-To: <20230511185252.386941-1-dmitry.torokhov@gmail.com>
References: <20230511185252.386941-1-dmitry.torokhov@gmail.com>
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

Do not try to process "resend" or "reject" responses from the device
as normal response data for a command.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/serio/libps2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/serio/libps2.c b/drivers/input/serio/libps2.c
index d09450eca9a7..14b70a78875d 100644
--- a/drivers/input/serio/libps2.c
+++ b/drivers/input/serio/libps2.c
@@ -445,7 +445,7 @@ bool ps2_handle_ack(struct ps2dev *ps2dev, u8 data)
 	ps2dev->flags &= ~PS2_FLAG_ACK;
 	wake_up(&ps2dev->wait);
 
-	if (data != PS2_RET_ACK)
+	if (!ps2dev->nak && data != PS2_RET_ACK)
 		ps2_handle_response(ps2dev, data);
 
 	return true;
-- 
2.40.1.606.ga4b1b128d6-goog

