Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A47096C0EE5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 11:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjCTKd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 06:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjCTKdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 06:33:18 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C1321963
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 03:33:08 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id ek18so44698816edb.6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 03:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679308386;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Mr0fy3RU+wSUMXeuF88E6gyhPRRcPTFwOnXTbRWfaXo=;
        b=aCbA4RP1J5CoTUmpfEbynhhut9tzNMcG1jV0v1aCiBlHxJoqmSwqGn5qoA6DG654LB
         gQkyfVnAqahye2fSKuADUHvifZDvLyyTao+8fhX57via0XTw2G7/t/OCjVcAbf1RRKiu
         aL7+aQN9hjf5gpY6yZS0l9SGhuQPUiDxBWXgHj7fC5dhOc/lvCVGdePlnMM0QTYObuVL
         1Vjr7o8k+mBGJ0GjL4mtecZXFUfpKEPKU7QxOryCh+cP8LaWkT6KLN24GMWPigvagDnw
         NmLeeGCDivqZAOTuved8X252Up+g/+r8NqRBQOi79l2XRAYO20Lg5UYkyKZPV4x22MbV
         s/IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679308386;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mr0fy3RU+wSUMXeuF88E6gyhPRRcPTFwOnXTbRWfaXo=;
        b=x6dIwCnsP7lsbp6dshDZd1hUUmQ7hnCUpebxbm/bJjKdjiaaMPIEREn/XPDnPbHW+N
         +M4QwlHdP/3GTJKLxDSCeSE9dS1OuacQqJzlKtzA6TRUmL975Bad1ThMHyxC9nLUdTJc
         Y1M9xVTuprCHy0/S/bU8iUMOz8+Vt6LDAahmvSihQ7gvxhjP6D6Q68rDnOd9/RUZJLx7
         jNiPlzKGKi90VG7dsJPOiA6BOaNvSJ3i5IxsjuA2E/UTcWY98chdVdR7Zy8oioNUCPER
         pPHJg5+4yG43XKpADRf/lFrsS02a9HhwdIo55DsbD78d/K9cVfp1VxczqDK1pv7pfEks
         Ctyg==
X-Gm-Message-State: AO0yUKUqC8sG7E7I8rP82aILemProRF4K0+KvjQf+QnluCLT74PxQZQM
        qunCZAzke4dJ/G0tOMP68MU=
X-Google-Smtp-Source: AK7set94Y+qlvBrb1DY+OByQKGaeiXGowIIS7OMRkV92BxPpjenE3RFLtDEtAplqeRG1ZWGY34sBng==
X-Received: by 2002:a17:907:2be4:b0:930:fe49:5383 with SMTP id gv36-20020a1709072be400b00930fe495383mr7062637ejc.76.1679308386562;
        Mon, 20 Mar 2023 03:33:06 -0700 (PDT)
Received: from alaa-emad.. ([41.42.177.251])
        by smtp.gmail.com with ESMTPSA id k6-20020a17090632c600b00924d38bbdc0sm4199621ejk.105.2023.03.20.03.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 03:33:06 -0700 (PDT)
From:   Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     outreachy@lists.linux.dev, johan@kernel.org, elder@kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        eng.mennamahmoud.mm@gmail.com, Julia Lawall <julia.lawall@inria.fr>
Subject: [PATCH v3] staging: greybus: use inline function for macros
Date:   Mon, 20 Mar 2023 12:32:58 +0200
Message-Id: <20230320103258.6461-1-eng.mennamahmoud.mm@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
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

Convert `to_gbphy_dev` and `to_gbphy_driver` macros into a
static inline function.

it is not great to have macro that use `container_of` macro,
because from looking at the definition one cannot tell what type
it applies to.

One can get the same benefit from an efficiency point of view
by making an inline function.

Suggested-by: Julia Lawall <julia.lawall@inria.fr>
Signed-off-by: Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
---
change in v2:
	remove newlines added in previous patch.

change in v3:
	fix the patch to be against Greg's tree.
---
 drivers/staging/greybus/gbphy.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/greybus/gbphy.h b/drivers/staging/greybus/gbphy.h
index d4a225b76338..03a977056637 100644
--- a/drivers/staging/greybus/gbphy.h
+++ b/drivers/staging/greybus/gbphy.h
@@ -15,7 +15,10 @@ struct gbphy_device {
 	struct list_head list;
 	struct device dev;
 };
-#define to_gbphy_dev(d) container_of(d, struct gbphy_device, dev)
+static inline struct gbphy_device *to_gbphy_dev(const struct device *d)
+{
+	return container_of(d, struct gbphy_device, dev);
+}
 
 static inline void *gb_gbphy_get_data(struct gbphy_device *gdev)
 {
@@ -43,7 +46,10 @@ struct gbphy_driver {
 
 	struct device_driver driver;
 };
-#define to_gbphy_driver(d) container_of(d, struct gbphy_driver, driver)
+static inline struct gbphy_driver *to_gbphy_driver(struct device_driver *d)
+{
+	return container_of(d, struct gbphy_driver, driver);
+}
 
 int gb_gbphy_register_driver(struct gbphy_driver *driver,
 			     struct module *owner, const char *mod_name);
-- 
2.34.1

