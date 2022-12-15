Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93A9F64D843
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 10:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiLOJIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 04:08:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiLOJIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 04:08:14 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65EB846669
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 01:08:13 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id 4so6201758plj.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 01:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dTXgzkmzEXq9c8dhQy7zxMXflpU+wcLdDMcNDOUKRM8=;
        b=RwMVV82bIWIUmHi2nCdHz1a9mWsmpK00U8i3oe9gyq2kRW7BrQMaIilETHM/JtDgIq
         rcOTzGpdC73f6RlWf+9A5iLEOh4AlIMgQyIbDlu34OgP1pfqZ+5NUA4oq9SBkGq1zRAu
         pdNW+8JOj+HOKBw1+0Bbogn9pD0ZVtm7cDeZqJBDaRlFG+BijpcyUffxBZpmJuO54XIT
         Ze3PsyPDCo19S0m15yTmzNSVXU6Xz/Vq06TpTDj7Zw63PhTpmdw+/2KsunLSwRydGotm
         k50on83Onvytj9jb+xNwIW6X5JNIUw9qHGrMgC0tpeJ4g0tZW9SmvHyaGVWf+ygO1xzF
         SqdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dTXgzkmzEXq9c8dhQy7zxMXflpU+wcLdDMcNDOUKRM8=;
        b=OpW5+OYFfFL8BNjWK5UAf+wIg4NgqQEPC02MlDDO9uFypSG8PGbjJsqAnquUcmI7Pj
         dtQG82yhglo6+hvQT/vMBOzxdWpjU0bX+UkIppIYIZ8FL3nngTyknxcK2oDs6jcQstN0
         xP/ne4ybpvGkz1j+7cyDzxBOeCK49vsbc4dftkNMhaecwnrD2iF/7Fl6Vs+2R6zbguLd
         4ScnHazaLZGze8wMOW9BBkfPv7S/XJNgCcef9m892P6gNJ+wleDfRN2nlaOnai8diw0B
         /Nu8wTLZDPSI1eDPzMpcSRjfX0a3cqZIEH/gELdVmSBvEVWJ7zXgUvPVUTZA8sVr1NXQ
         3Ypg==
X-Gm-Message-State: ANoB5pngHuxCINKocfpsUuVPTjUObzbXk8n3urY0fHEnK4Lit6g2seAF
        Fm6clGX/XIH/ie7x+7Kh++6NC8bJDmnbbZk6
X-Google-Smtp-Source: AA0mqf7nKR/LEtPOIBC3s5kKLV/vzDID1nV5//xZuefrIhST6tx+MxWYXUjJ2fn83u83MVSfvm/Jxw==
X-Received: by 2002:a17:90a:a790:b0:20d:bd60:ada4 with SMTP id f16-20020a17090aa79000b0020dbd60ada4mr33651847pjq.32.1671095292939;
        Thu, 15 Dec 2022 01:08:12 -0800 (PST)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id i7-20020a17090a138700b0020b7de675a4sm2619869pja.41.2022.12.15.01.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 01:08:12 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tony Jones <tonyj@suse.de>, Kay Sievers <kay.sievers@vrfy.org>,
        linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] misc: enclosure: Fix doc for enclosure_find()
Date:   Thu, 15 Dec 2022 13:08:04 +0400
Message-Id: <20221215090804.473022-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
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

We should use put_device() to release the reference.

Fixes: ee959b00c335 ("SCSI: convert struct class_device to struct device")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/misc/enclosure.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/enclosure.c b/drivers/misc/enclosure.c
index 1b010d9267c9..4ba966529458 100644
--- a/drivers/misc/enclosure.c
+++ b/drivers/misc/enclosure.c
@@ -32,7 +32,7 @@ static struct class enclosure_class;
  * found. @start can be used as a starting point to obtain multiple
  * enclosures per parent (should begin with NULL and then be set to
  * each returned enclosure device). Obtains a reference to the
- * enclosure class device which must be released with device_put().
+ * enclosure class device which must be released with put_device().
  * If @start is not NULL, a reference must be taken on it which is
  * released before returning (this allows a loop through all
  * enclosures to exit with only the reference on the enclosure of
-- 
2.25.1

