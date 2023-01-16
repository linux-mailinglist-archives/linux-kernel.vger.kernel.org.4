Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9FA66CA50
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 18:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjAPRCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 12:02:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232146AbjAPRBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 12:01:22 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 022585AB44;
        Mon, 16 Jan 2023 08:43:34 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so19199800wma.1;
        Mon, 16 Jan 2023 08:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hdMES01EPPPE0n9D0ujpLqB92A4Ph7O7jAl0KOo2U5E=;
        b=omy54DRAvSUB7i6EYvsO3YHFs/r5BjAXmaWpPrFeifZmPB0W93qQe71EzR3PVvZbsm
         nzco5MkDgfKynzNzqYMJif02+0nYqNkuTYoR4KCcXFmlEh6siWcd7A1SbpcCpeOdlTdI
         JWT5UL9xJBDxjY/Cef+FdjlMRZtG4AmLZ4YE3tXbnMefW1x4h7tw9IoIs79DCFniTq7g
         GEhOU4ES2IWRtidNvii0gCcRLsbEZ4fsRHrCURqhpMrqrA17xmFYsaDKHFk6p42CWl5g
         D/cJAdxM/VPPsZuqqDZqcuhJjKsSLu3WLxB+aFAucJ587yNGcZ5cgYmnpZDj9vWdkEtA
         cFkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hdMES01EPPPE0n9D0ujpLqB92A4Ph7O7jAl0KOo2U5E=;
        b=eOXiDlVLU7xnULfZ2bM7Xosy5TFTYpCr5oUTMFTfe7A3hGfyIS0E9GaXIHLlWtmIDG
         QDx/tD1E1kSE+d9CAbES1VRQxDMrnIQsURuJMl5WSrSJA4MNVwDFoK41wFXvUO39MFa1
         INe9GOCgZo2B+wC/3UgMb8ktwZQJ3lJCTaLhMdpYCBc7S8XAnYkbPGERXEjFYReypRt7
         ojJrxj1thO+zlkGSo0yT3tdIQNuyFC7dIuolqnd87Jllog8R7pTAktvtvvvMaL9qaUoW
         rWKU36x5+xsM16HBTSZsFrCBGsuj8oOjwIqiMojlIbCr6G9OUrXv6JzofZKgK2TQSus3
         rWzA==
X-Gm-Message-State: AFqh2krR+2uXTujuxhTVHvSJh45U7h52lruL0t6jEQtcr/18mATCEY6e
        BrfKgoSMGFmVg5/QEAvy4xpBf17ZRF8rcr7t
X-Google-Smtp-Source: AMrXdXu9vFGQR99Y245eOAWzlFecq6Ah7aU8g1JRMshkROR6DtVyxdV2Hhit9yRaF4npesCKsttOnA==
X-Received: by 2002:a05:600c:5d1:b0:3d0:761b:f86 with SMTP id p17-20020a05600c05d100b003d0761b0f86mr98565wmd.28.1673887413230;
        Mon, 16 Jan 2023 08:43:33 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id p13-20020a05600c1d8d00b003d9fb04f658sm8007889wms.4.2023.01.16.08.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 08:43:32 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] mm/secretmem: remove redundant initiialization of pointer file
Date:   Mon, 16 Jan 2023 16:43:32 +0000
Message-Id: <20230116164332.79500-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pointer file is being initialized with a value that is never read, it
is being re-assigned later on. Clean up code by removing the redundant
initialization.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 mm/secretmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/secretmem.c b/mm/secretmem.c
index 04c3ac9448a1..be3fff86ba00 100644
--- a/mm/secretmem.c
+++ b/mm/secretmem.c
@@ -190,7 +190,7 @@ static struct vfsmount *secretmem_mnt;
 
 static struct file *secretmem_file_create(unsigned long flags)
 {
-	struct file *file = ERR_PTR(-ENOMEM);
+	struct file *file;
 	struct inode *inode;
 	const char *anon_name = "[secretmem]";
 	const struct qstr qname = QSTR_INIT(anon_name, strlen(anon_name));
-- 
2.30.2

