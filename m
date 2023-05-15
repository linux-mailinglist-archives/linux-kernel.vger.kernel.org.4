Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8410D7027A0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 10:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238386AbjEOIxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 04:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238353AbjEOIxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 04:53:33 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB5D1999;
        Mon, 15 May 2023 01:53:24 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-24e24b0193fso9164279a91.2;
        Mon, 15 May 2023 01:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684140804; x=1686732804;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=90pB5A/EQuvWbtw/9XpRxtR12GPJwYDdwY3t8pMrqK4=;
        b=rrjJSu5dEN+5HyCOyI72T+Gvgn5XjTJ0mqt7hEQCkH4j5JM/zpR3yQIRDOTckAojYe
         b1Mah5ub5/eI+Jrvzsc6BjDyGMqG4WheHyiy1AsKHuwrQjnefAHcDhA1pQyUbxxoQ4OR
         7EnNI6u1vYdMk79npzgEDljrsbZ0OBqUr1RPSkagqVrbi6R6BHDpuMfnlBuvl2x1EgSb
         YHm4ahgcOe459nrY7OUuXZ82APwIP51HAae3zuVzpJWVxlQ6Hm2bhNCA8DlRs6tI9UWx
         LeC/rWcXd9vVtbDH/o+zAZ4NLeQ/xChbAkr/zIp6EsVyv1BXnoDpyPAf3c75Yxo6hI3K
         VXaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684140804; x=1686732804;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=90pB5A/EQuvWbtw/9XpRxtR12GPJwYDdwY3t8pMrqK4=;
        b=GTbkhW/ttOQ0KjemRNotClc2rTD4rrXUyXYnvDjnUwZEduMyNHHytqDMSUSRRVX+6p
         fmp7MfSKkIuiCK+FXBmgc30G0ta8Bui/ll62bjkHsshI7NhXYcP40SAuFBa99m4mOU7Y
         mbbOkJbP1S41bfWYN53mRrExitrYLJkLest+snBPmRDFjchzbpMYCDKLLfC4kp3/1Enn
         cQmwepPXhm7NBasSqWElm1pLpg4Q1Q0WTjdvZqKzhKeauxwOvmFsuR43nNds2UBhwUTo
         BpgiJXMAvvHg77zV8RZ/S+0v+Uvf5TzP792MTWYONes4CEcVmboxYs4TeVP70BZfBn2S
         S3CQ==
X-Gm-Message-State: AC+VfDy3MIdi4T5BdMDWGgwqcklryI16BSEAtZ4SRVZ8DQWRd9SzvYsV
        7qAo9um2LIFdRxWpCcXrT7A=
X-Google-Smtp-Source: ACHHUZ67t9VbnVUKOhfMbNA+fprqTYg2pcVWFNpKNYW8x4+/JhVaWlSW4u4tEeQp+3L0nw6ccNDXhQ==
X-Received: by 2002:a17:90b:3004:b0:246:b6f9:148a with SMTP id hg4-20020a17090b300400b00246b6f9148amr33835665pjb.21.1684140804210;
        Mon, 15 May 2023 01:53:24 -0700 (PDT)
Received: from localhost.localdomain ([103.194.71.110])
        by smtp.gmail.com with ESMTPSA id t3-20020a17090a024300b0024499d4b72esm22078370pje.51.2023.05.15.01.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 01:53:23 -0700 (PDT)
From:   llyyr <llyyr.public@gmail.com>
Cc:     llyyr.public@gmail.com, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (nct6683) Add another chip ID for NCT6687D sensor chip found on some MSI boards.
Date:   Mon, 15 May 2023 14:23:07 +0530
Message-Id: <20230515085307.18868-1-llyyr.public@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This value was found on MSI Z690-A PRO DDR5, with a NCT6687D chip.

Signed-off-by: llyyr <llyyr.public@gmail.com>
---
 drivers/hwmon/nct6683.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hwmon/nct6683.c b/drivers/hwmon/nct6683.c
index a872f783e..5df9b9ce7 100644
--- a/drivers/hwmon/nct6683.c
+++ b/drivers/hwmon/nct6683.c
@@ -14,6 +14,7 @@
  * nct6683d     21(1)   16      8       32(1) 0xc730
  * nct6686d     21(1)   16      8       32(1) 0xd440
  * nct6687d     21(1)   16      8       32(1) 0xd590
+ *                                           (0xd592)
  *
  * Notes:
  *	(1) Total number of vin and temp inputs is 32.
@@ -71,6 +72,7 @@ static const char * const nct6683_chip_names[] = {
 #define SIO_NCT6683_ID		0xc730
 #define SIO_NCT6686_ID		0xd440
 #define SIO_NCT6687_ID		0xd590
+#define SIO_NCT6687_ID2		0xd592
 #define SIO_ID_MASK		0xFFF0
 
 static inline void
@@ -1362,6 +1364,7 @@ static int __init nct6683_find(int sioaddr, struct nct6683_sio_data *sio_data)
 		sio_data->kind = nct6686;
 		break;
 	case SIO_NCT6687_ID:
+	case SIO_NCT6687_ID2:
 		sio_data->kind = nct6687;
 		break;
 	default:
-- 
2.40.1

