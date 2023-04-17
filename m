Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06C4F6E5129
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 21:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbjDQTur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 15:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbjDQTup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 15:50:45 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB974224;
        Mon, 17 Apr 2023 12:50:43 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4ec816d64afso7885497e87.1;
        Mon, 17 Apr 2023 12:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681761042; x=1684353042;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xmTAefnrkJJwhbxgaXaqi9Y6GqFc0zYnwZAZbshHD/8=;
        b=JFK28mWoki10heM23/ZLjso0gjyA2DOgOKQ0DSKwROwtAKBK3ZR+z1EGVEvub91jiL
         +BPP35l18LlHRRGdNjw1hzvZm7eGrODuQ0wsZaZg0d8qtcSMx92Wwm7r2pr4BpwRP39K
         88rskyfeG24N9Rs0cAN9nK3/adZ1THawlcsn0+xzBvBzsuIL+6YVlfNz+vkojbAduiIw
         exGBVYS5/GmG9n1VEpw2pFs+cXwIREJ/LPbMHoZOz8VMfzY6W3pApu9asFdrn4we3hYd
         cJ4HtMzZMuNu3Gv0Xu7aLRwu2vmzdn6LrsogELaqPhIM/yd9QHukDUl5pLbFnCh/Ezih
         5F8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681761042; x=1684353042;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xmTAefnrkJJwhbxgaXaqi9Y6GqFc0zYnwZAZbshHD/8=;
        b=Rgzh4L+EnIVtEGFrGaGACe96oTyU5SGig+BaLDeLPimEgNPiN0Erb4KN1zv4KThywD
         /H4bz0gBA7cYutuzgSIc4fwpFbieQZFSyPW4bpgyLPclP0WZZnI8HVx5OYArTeIR7Q0y
         91O/gR0Yz5xX1r4Mwdf9a8CSczotPBj4QsDm7Zt4DlXXJTEBlT0ehgRrumXc5QVgBpWv
         3hTbFwysOHDR72SdKBATqHGm9O/CZV2WdkQnjVXA58gkpem3HKBNo5HYhctZk2daU1q5
         OoDQJIDCbqijGxT1ouaXaBmj2q/HWbUl0nlzXH69tIDAmSwol/bmU4VoLu/YXl6UPt2D
         vk0A==
X-Gm-Message-State: AAQBX9dAjVDMyevj3/H5cBS9KAoyICWbLIuCiUQcA8j0DWTrdsB5PxXH
        TQp0V5Rb5IFzX/6hlvO4y/M=
X-Google-Smtp-Source: AKy350ZJZKuI6qvz2aeUHt+Tlj30SiXRPuVZtIwznLEmrM3i6Xip3k9wdJlSNGMWEcb6kAGplYMGqw==
X-Received: by 2002:a05:6512:3d07:b0:4ed:b86b:9cc9 with SMTP id d7-20020a0565123d0700b004edb86b9cc9mr2219540lfv.28.1681761041646;
        Mon, 17 Apr 2023 12:50:41 -0700 (PDT)
Received: from mkor.. (89-109-50-74.dynamic.mts-nn.ru. [89.109.50.74])
        by smtp.gmail.com with ESMTPSA id v6-20020a2e9246000000b0029ee7bc0114sm2248537ljg.64.2023.04.17.12.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 12:50:41 -0700 (PDT)
From:   Maxim Korotkov <korotkov.maxim.s@gmail.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Maxim Korotkov <korotkov.maxim.s@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: [PATCH] usb: typec: fix potential NULL dereference
Date:   Mon, 17 Apr 2023 22:50:03 +0300
Message-Id: <20230417195003.19504-1-korotkov.maxim.s@gmail.com>
X-Mailer: git-send-email 2.37.2
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

The pointer 'adev' was being dereferenced before being checked for NULL
in the 'type_alt mode_enter()' and 'type_alt mode_exit()' functions.
Although this is a hypothetical issue, it's better to move the pointer
assignment after the NULL check to avoid any potential problems.

Found by Linux Verification Center with Svace static analyzer.

Fixes: 8a37d87d72f0 ("usb: typec: Bus type for alternate modes")
Signed-off-by: Maxim Korotkov <korotkov.maxim.s@gmail.com>
---
 drivers/usb/typec/bus.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/typec/bus.c b/drivers/usb/typec/bus.c
index 098f0efaa58d..ae0aca8f33db 100644
--- a/drivers/usb/typec/bus.c
+++ b/drivers/usb/typec/bus.c
@@ -125,13 +125,16 @@ EXPORT_SYMBOL_GPL(typec_altmode_notify);
  */
 int typec_altmode_enter(struct typec_altmode *adev, u32 *vdo)
 {
-	struct altmode *partner = to_altmode(adev)->partner;
-	struct typec_altmode *pdev = &partner->adev;
+	struct altmode *partner;
+	struct typec_altmode *pdev;
 	int ret;
 
 	if (!adev || adev->active)
 		return 0;
 
+	partner = to_altmode(adev)->partner;
+	pdev = &partner->adev;
+
 	if (!pdev->ops || !pdev->ops->enter)
 		return -EOPNOTSUPP;
 
@@ -156,13 +159,15 @@ EXPORT_SYMBOL_GPL(typec_altmode_enter);
  */
 int typec_altmode_exit(struct typec_altmode *adev)
 {
-	struct altmode *partner = to_altmode(adev)->partner;
-	struct typec_altmode *pdev = &partner->adev;
+	struct altmode *partner;
+	struct typec_altmode *pdev;
 	int ret;
 
 	if (!adev || !adev->active)
 		return 0;
 
+	partner = to_altmode(adev)->partner;
+	pdev = &partner->adev;
 	if (!pdev->ops || !pdev->ops->exit)
 		return -EOPNOTSUPP;
 
-- 
2.37.2

