Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06025702879
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 11:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbjEOJ1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 05:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239176AbjEOJ1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 05:27:04 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392231BD;
        Mon, 15 May 2023 02:26:51 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1aafa41116fso84709345ad.1;
        Mon, 15 May 2023 02:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684142810; x=1686734810;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=90pB5A/EQuvWbtw/9XpRxtR12GPJwYDdwY3t8pMrqK4=;
        b=R/z7crlS/lPhV3h3BFgkiLR/iJZliaUKgbrxk1eP748n7dGAtbCTPRVputyxufSEV+
         9kJ3TK/qNPlrWi2p7duVwYOwUEGwba/ZScDo2KIlmRpCJv8TEOo5Ngwu67yJIDTdgurO
         YBmY5p/gD6m5rDc7BtdXnt5PXFyCe78Z09QxmVGUWKiLyaNiGBtRU4PaJ05OSwm0YVba
         wfYWjkL2Xlfp6wIuS4lJ2DTEICs0iFtbpaPW3aLasQPuYl5wqgB/Vtw5jFGZkgwZNTDc
         MFjxVTQhiSZAN3rGvDILlQUOXiYnwk5ANFMi1eWRRekFKY9NGXpQeSZ2tViByDnc/g1h
         3COQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684142810; x=1686734810;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=90pB5A/EQuvWbtw/9XpRxtR12GPJwYDdwY3t8pMrqK4=;
        b=BQLSdREsBOaPJWDV3ysCAItNei+6UCyu7qdnsdmyH/1v16gLZYEQtzSC3cYUNPTRuK
         VDDT73Je6b3Wbe645WC5T7hCvVjPmhDry5nPf810s+4svrzr9e9ANd1mLhTznwLdnANK
         ikI1L+46OL0pBQsCWrsMY5sOXpiRhFkaHcjk46JfSwbk09cSzr6V9Y1oIUzUc/MJVS96
         OtyhCEf8nCO95GbVRofZDB6qUPE5fyc2w0xVn5B9zMQMjccHKCactLIBblLfE+qJ/pBF
         o7CNTUPA7ResoxVM1DNjCuM8DgVRWTkqKQUn31AGbpL/HLnuMsYdiC9prpaRV/53b0BM
         9njg==
X-Gm-Message-State: AC+VfDxre5lJ83pkfeeEWLSvwG5X1AM1ujAp2wmYfgQvFRU6bY+pBcGR
        hwUCxPfNQ96UG2qFSpnhEAyLXzYqHe4X0g==
X-Google-Smtp-Source: ACHHUZ63EuXr6T3H06Ba3BCMy3sIZXN0pFAkJlCz7cVT3s+tR6hJ5mXHiII/P8Nw2wIrMgseyTGSsg==
X-Received: by 2002:a17:902:d2c6:b0:1ab:16e0:ef49 with SMTP id n6-20020a170902d2c600b001ab16e0ef49mr43599590plc.24.1684142810639;
        Mon, 15 May 2023 02:26:50 -0700 (PDT)
Received: from localhost.localdomain ([103.194.71.110])
        by smtp.gmail.com with ESMTPSA id bd1-20020a170902830100b001aaecc0b6ffsm13015605plb.160.2023.05.15.02.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 02:26:50 -0700 (PDT)
From:   llyyr <llyyr.public@gmail.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     llyyr <llyyr.public@gmail.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (nct6683) Add another chip ID for NCT6687D sensor chip found on some MSI boards.
Date:   Mon, 15 May 2023 14:55:46 +0530
Message-Id: <20230515092546.21154-1-llyyr.public@gmail.com>
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

