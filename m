Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF3E2666A74
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 05:42:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239405AbjALElU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 23:41:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239078AbjALEk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 23:40:29 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944C7496D5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 20:39:34 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id k19so12939933pfg.11
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 20:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nCtsRB96tDB6ymydz+7uG9f0tEsazRT+tKtFE7IAYuA=;
        b=EKBQtrRqzsJpW4Uup0IpMJ6SWOaFDOmYKFSXSlY+tV6r4uGbSkPHtKifX2aL/CxmNM
         OK0xV+ZlW4gY0M8KFuTFSZVzOwlbw89QJtr+tC4xen9yI61kMXUKdzXr++cRgY4YRmZT
         Dn1fTHQEHNAl4WHkEfPgNPvnHlZSEY228FJow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nCtsRB96tDB6ymydz+7uG9f0tEsazRT+tKtFE7IAYuA=;
        b=OofII9lWxNwxePPkPWyCYLX2//KCnz61K8G/SMASHdqULHOm+KQ6p9uJt0cEOmpP+U
         Dde0u6JZyBomDDRyOymhe04O1k+1LmWhpw6JD9nqxvB6wxx4Im65Am8BAqHieC2WYXNr
         gLZME0inqoMYIY+XgEL2okqvEX4VWNYov6Dq2k3UW3npkJe5Fdtuw2wdVNU/+GZW0V8T
         rcBYdFVlma3XECTr61P/Sbubxwnep6l/37+jlJ7II2UOZULIs/0JMr03nY6bOLQucb8A
         vej49up6r0YDsm+z9MMjI2W56pQebuJym0+FIL5RDvS9mqrwc7eUpcsZBGOUU6NPj/5x
         56ug==
X-Gm-Message-State: AFqh2krYCUrfVb2e5xRrZXp6SzTKaqX9ZrADyZ1wj8XkZ2QbZmUwfQwq
        4vCc+ac3uETAWMcUSrItMfnEkg==
X-Google-Smtp-Source: AMrXdXuIlD5zuHSehZeKpZmn+86D6vouPFiM/lBPSTKR4qKGRvavgfrKlSD8pL2/UYqSatb1Goiu0w==
X-Received: by 2002:a62:1791:0:b0:578:8533:9573 with SMTP id 139-20020a621791000000b0057885339573mr65335894pfx.22.1673498374112;
        Wed, 11 Jan 2023 20:39:34 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:8720:bd4c:a7f7:4e33])
        by smtp.gmail.com with ESMTPSA id h10-20020a056a00000a00b00573eb4a9a66sm213725pfk.2.2023.01.11.20.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 20:39:33 -0800 (PST)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, chrome-platform@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] platform/chrome: cros_ec: Initialize panic notifier block
Date:   Thu, 12 Jan 2023 12:39:08 +0800
Message-Id: <20230112043908.2938964-1-wenst@chromium.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit d90fa2c64d59 ("platform/chrome: cros_ec: Poll EC log on EC panic")
added a new notifier block, but failed to initialize it properly,
resulting in a warning and stack trace (omitted):

	INFO: trying to register non-static key.
	The code is fine but needs lockdep annotation, or maybe
	you didn't initialize this object before use?
	turning off the locking correctness validator.

Initialize the notifier block properly.

Fixes: d90fa2c64d59 ("platform/chrome: cros_ec: Poll EC log on EC panic")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/platform/chrome/cros_ec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
index 4ae57820afd5..b895c8130bba 100644
--- a/drivers/platform/chrome/cros_ec.c
+++ b/drivers/platform/chrome/cros_ec.c
@@ -182,6 +182,7 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
 	int err = 0;
 
 	BLOCKING_INIT_NOTIFIER_HEAD(&ec_dev->event_notifier);
+	BLOCKING_INIT_NOTIFIER_HEAD(&ec_dev->panic_notifier);
 
 	ec_dev->max_request = sizeof(struct ec_params_hello);
 	ec_dev->max_response = sizeof(struct ec_response_get_protocol_info);
-- 
2.39.0.314.g84b9a713c41-goog

