Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA516B5BCA
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 13:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjCKMfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 07:35:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbjCKMe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 07:34:59 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7467C13552C;
        Sat, 11 Mar 2023 04:34:44 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id c18so5075131wmr.3;
        Sat, 11 Mar 2023 04:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678538083;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=manwNb7+2j+rOZl7hExhu3IXnUZMurmRVTmeoMoFl/A=;
        b=ZhLtbjcrRv6VCPTl1aXxHgylwCTdeY9SM+oyN+UFdEJeukGsg+I1dDYweQvd/q5mlj
         rk++oDfANVpoprulonNmefwFH2j6zmvgaFXQ8vYDrz+E0/h06uhyDC3jD5LvnQWE1HWy
         CLVLGozUXBc8WxnfAacgNQckAwcXf6n/cnB5A8tYYd+eDbk26tU2tg7FrgOp4r93WwFX
         9A2JZZRfXHs+XEWtkcWJdeMYnDrSKEY4mWWUfRZgMq2QWW7gccFDI3o70eAuEz4gHAPr
         bKFoHPVIhEYcQO+0b+RiVyhjbNOOzhtnkLGs5nizaIWK7rsz8WoJg1To6p2llT7oiR9e
         Q4LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678538083;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=manwNb7+2j+rOZl7hExhu3IXnUZMurmRVTmeoMoFl/A=;
        b=FrCSG+/0uWpyGs4/MIXyZOyEvpfdGnbxi5Rh6WuQhT2Ujzb57qhbrv0JRQTT52Kx6b
         Ti+ryy19OW026Ij28VvFZBErlOpiIFbUYpYVheiLYpyYEKCI3WPbMGnsBYKu3rgrbdV1
         klY9o+4W1pJOkYveiQ5ay0wBi/3N3k2Te05JGWEBL+fAgvMKKoYlTTN1000CHifz+1O6
         yYEP8suD3Et4UJVz1B0e6V/FJJRBr+Nauag69tuH88mVK+TYeXcIQ0TvVeeuIBL7OT5j
         e0rtsJZE//aPcYkIMIVusenWPJ/iQuqT+xZmAq4EnSfIg8oC2TzLS+SiA8QLATy7oCo/
         rjUQ==
X-Gm-Message-State: AO0yUKWKFQ7R5xDkfWqpLlqPdnnwxzrh1RTtYW8WOnRH9WapeKg/Qk3j
        rxzu2ndlFbraJ3G8pTyywak=
X-Google-Smtp-Source: AK7set/hUt7B0yJDdtsrQwyTHET9GWDilh5xfTrf9/ZHYXFpc7iv8VfXQhwXxAyyOa7qor2tWjK39Q==
X-Received: by 2002:a05:600c:1d8d:b0:3ec:3abe:934d with SMTP id p13-20020a05600c1d8d00b003ec3abe934dmr1379018wms.4.1678538082979;
        Sat, 11 Mar 2023 04:34:42 -0800 (PST)
Received: from localhost.localdomain ([84.32.202.14])
        by smtp.gmail.com with ESMTPSA id k7-20020a7bc407000000b003eafc47eb09sm1651094wmi.43.2023.03.11.04.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 04:34:42 -0800 (PST)
From:   Yaroslav Furman <yaro330@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     yaro330@gmail.com, Alan Stern <stern@rowland.harvard.edu>,
        linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH] uas: Add US_FL_NO_REPORT_OPCODES for JMicron JMS583Gen 2
Date:   Sat, 11 Mar 2023 14:34:18 +0200
Message-Id: <20230311123418.16272-1-yaro330@gmail.com>
X-Mailer: git-send-email 2.39.2
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

Just like other JMicron JMS5xx enclosures, it chokes on report-opcodes,
let's avoid them.

Tested-and-reported-by: Yaroslav Furman <yaro330@gmail.com>
Signed-off-by: Yaroslav Furman <yaro330@gmail.com>
---
 drivers/usb/storage/unusual_uas.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/usb/storage/unusual_uas.h b/drivers/usb/storage/unusual_uas.h
index c7b763d6d102..e4ff28ba93e5 100644
--- a/drivers/usb/storage/unusual_uas.h
+++ b/drivers/usb/storage/unusual_uas.h
@@ -97,6 +97,13 @@ UNUSUAL_DEV(0x152d, 0x0539, 0x0000, 0x9999,
 		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
 		US_FL_NO_REPORT_OPCODES),
 
+/* Reported by: Yaroslav Furman <yaro330@gmail.com> */
+UNUSUAL_DEV(0x152d, 0x0583, 0x0000, 0x9999,
+		"JMicron",
+		"JMS583Gen 2",
+		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
+		US_FL_NO_REPORT_OPCODES),
+
 /* Reported-by: Claudio Bizzarri <claudio.bizzarri@gmail.com> */
 UNUSUAL_DEV(0x152d, 0x0567, 0x0000, 0x9999,
 		"JMicron",
-- 
2.39.2

