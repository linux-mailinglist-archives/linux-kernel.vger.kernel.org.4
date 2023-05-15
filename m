Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45EA170308E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 16:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239826AbjEOOtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 10:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234849AbjEOOtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 10:49:46 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C89410E7;
        Mon, 15 May 2023 07:49:42 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-52caed90d17so8196477a12.0;
        Mon, 15 May 2023 07:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684162182; x=1686754182;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=57VzcyPuA7BEKGnVhD0e6Z7x74rWRavME0frZ5YKs9Y=;
        b=VRt7+CVjEumhGywZRHZ0Ii6ISVXYXyq3As5d7B2vOCTGTtG/5HKprnIWtad1TXxzt2
         OG8IY9QmxYghmF/2RTF+ORBiF1HYXrjq7X/HIYlvvTs3xVegaH3jPFva/mUVbGYV4O9K
         Sp+xYSBmr29fk1F/B84Y77rAvHIc/5Wtm0NeXX5bZJFxUjE+RqniTnDeIDLJAWqdr6Yn
         w4dYOsdST7/WJX4BXbk0JRnHQwPT5gSkIc+/VI1sUTGB4lxxUtK4EHjZjUjJPtk3CqVc
         VdLaq3QyROHjo9fFctQW4sYdiYe5BIYm15o9n4dlaly0qHmQX6LAwjMS1lNMJEndtu1q
         gBwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684162182; x=1686754182;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=57VzcyPuA7BEKGnVhD0e6Z7x74rWRavME0frZ5YKs9Y=;
        b=Cu5wBWd1VcDPKG6FG+fK5HCQTm2VfU17wGp1/qinndNeekBHZID1Wylp7yRNa5EfHU
         kc65Ja+3aNcUmcwEHfuoY2CUORG44JQ2EvToNrZKJy/ALa9lvVFP5Nrp7MR2621PPUeO
         XGF0ph0vmZDiSi0bVS2OixwZ2Ywy8soMsy9mARfa8c71QNRBCe9Ygdwc43x0U1Btk7T5
         7vZymZEVk9MaP/HjF0ZWfCzbeCGLBwueaEqAjUcKjeSecaelM6ZK14O0/GIbhHIalmDN
         YPY9MBxs8zupXYHwbX+pVt8QSr+WqdSzJCMn6DkwnwbyIzcjOEXbAtaWRePe+bztIWQo
         vvIg==
X-Gm-Message-State: AC+VfDxYcugfOzRz3Iaqdyjvnq/aWTBj//cNtSRCoJULRNG4aRDzZla/
        ze31ecWy9uwAztYQPFEav9o=
X-Google-Smtp-Source: ACHHUZ5DEMRmMSpfNxApnb/08HztqIwNtkhEE5NDX/bKULOjvcovt2TsoSXkaF9iWZ0vFuLFACmcOw==
X-Received: by 2002:a05:6a20:a113:b0:104:45df:42d8 with SMTP id q19-20020a056a20a11300b0010445df42d8mr14295089pzk.10.1684162181947;
        Mon, 15 May 2023 07:49:41 -0700 (PDT)
Received: from localhost.localdomain ([103.194.71.110])
        by smtp.gmail.com with ESMTPSA id r19-20020a62e413000000b0062d859a33d1sm11854437pfh.84.2023.05.15.07.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 07:49:41 -0700 (PDT)
From:   llyyr <llyyr.public@gmail.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     llyyr <llyyr.public@gmail.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (nct6683) Add another customer ID for NCT6687D sensor chip on some MSI boards.
Date:   Mon, 15 May 2023 20:19:10 +0530
Message-Id: <20230515144910.13514-1-llyyr.public@gmail.com>
X-Mailer: git-send-email 2.40.1
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

This value was found on a MSI Z690-A PRO DDR5 with NCT6687D.

Signed-off-by: llyyr <llyyr.public@gmail.com>
---
 drivers/hwmon/nct6683.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hwmon/nct6683.c b/drivers/hwmon/nct6683.c
index a872f783e..f673f7d07 100644
--- a/drivers/hwmon/nct6683.c
+++ b/drivers/hwmon/nct6683.c
@@ -173,6 +173,7 @@ superio_exit(int ioreg)
 #define NCT6683_CUSTOMER_ID_INTEL	0x805
 #define NCT6683_CUSTOMER_ID_MITAC	0xa0e
 #define NCT6683_CUSTOMER_ID_MSI		0x201
+#define NCT6683_CUSTOMER_ID_MSI2	0x200
 #define NCT6683_CUSTOMER_ID_ASROCK		0xe2c
 #define NCT6683_CUSTOMER_ID_ASROCK2	0xe1b
 
@@ -1220,6 +1221,8 @@ static int nct6683_probe(struct platform_device *pdev)
 		break;
 	case NCT6683_CUSTOMER_ID_MSI:
 		break;
+	case NCT6683_CUSTOMER_ID_MSI2:
+		break;
 	case NCT6683_CUSTOMER_ID_ASROCK:
 		break;
 	case NCT6683_CUSTOMER_ID_ASROCK2:
-- 
2.40.1

