Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15A5705EA9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 06:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbjEQEUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 00:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjEQEUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 00:20:38 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1D5AF;
        Tue, 16 May 2023 21:20:37 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1ae54b623c2so1048725ad.3;
        Tue, 16 May 2023 21:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684297237; x=1686889237;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2aoFAuuRJ+3/FgXJuVSbqFP12TbWQw7U72znx29l5uc=;
        b=heQMvSQ1dyrAsZJ8zQwEYDR/zCov6s8Sp52fRrdVadWJzdV6EQ9TIREO/His8NtXRP
         qnDLa7s8qV/15DeIp0TYXdXgLmgFrPOmR/Ss1nEVIe9ayA1ng+j5r6xeN8v7lpQyIW1d
         e4m06tVViNy2S8jVSYlkm/9IynBoeCQ64mkspHEgZ38vmp3D67su1UQm3Tlx4ckwesAy
         QS55fBbLIqReCbnKT750tgoxaA6GWaeUPui0Fqw+a4TFzqF2OugY2bFJNIbnGnTrNp/W
         Xix/1E7uYgMCpNkGwArB8bxypCrIaAyibcB/U8+IMnbA62qJqALBhJ8mE/MrUmxM630m
         H2mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684297237; x=1686889237;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2aoFAuuRJ+3/FgXJuVSbqFP12TbWQw7U72znx29l5uc=;
        b=RcHm0eJQ/hWg8RAHdnByLZke9U5rIxIIky75kQVCDCXO3qok3K989qm494JorMrM37
         DRCR836impswol88dLqT29uPq3xErYpXz6bRMG47ldeljbSkE9pazjRyzSrkAd3rK5Oq
         HEihd2uf2+Zz4v1okG2IyMkw4HI9VJ6qsBaQKISal/0nzYkID9j/RHWjlfoXTHM3ywG/
         Vcozzlw6O8fQzNVz+5qcljqSXUebSex2WvfNjlUzjhYDSOAm8x+dKYb5fXD4GQhIJZYz
         PrrTUrHWv8VX0CbuX4kOzwf3Ag7W696dMrcQOX5+gcsdFfhVIDW8ocC8Q05AC5Sk4/sj
         AKag==
X-Gm-Message-State: AC+VfDwEBomSjrF/8Y1xvaqlbcbki+yoP/KWFFkIZC+CYD4KXjKd8pD5
        RVnt8Dfz6V00XPgIv2EH9ak=
X-Google-Smtp-Source: ACHHUZ4vp2o4Yf3m9Fq/OZYBym9MUmCXdpyllWFF9srlJYzjkK/oJLc8OL+jdDtdZp6qJmNQFQHJiQ==
X-Received: by 2002:a17:903:230e:b0:1ab:1b45:7972 with SMTP id d14-20020a170903230e00b001ab1b457972mr47914643plh.0.1684297236766;
        Tue, 16 May 2023 21:20:36 -0700 (PDT)
Received: from localhost.localdomain ([103.194.71.110])
        by smtp.gmail.com with ESMTPSA id r15-20020a170903020f00b001aae625e422sm16383057plh.37.2023.05.16.21.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 21:20:36 -0700 (PDT)
From:   Gopal Prasad <llyyr.public@gmail.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     llyyr <llyyr.public@gmail.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (nct6683) Add another customer ID for NCT6687D sensor chip on some MSI boards.
Date:   Wed, 17 May 2023 09:50:25 +0530
Message-Id: <20230517042025.16942-1-llyyr.public@gmail.com>
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

From: llyyr <llyyr.public@gmail.com>

This value was found on a MSI Z690-A PRO DDR5 with NCT6687D.

Signed-off-by: Gopal Prasad <llyyr.public@gmail.com>
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

