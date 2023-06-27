Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9A1973FFDF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 17:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbjF0Phr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 11:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjF0Phm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 11:37:42 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8800810D5;
        Tue, 27 Jun 2023 08:37:41 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-313df030ccaso4416543f8f.1;
        Tue, 27 Jun 2023 08:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687880260; x=1690472260;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=05iaNFO9lF/8ux6dacOd00yFXxHKqE9KRL91PmH4iR8=;
        b=HDiL5kKJ++QF2ciUWwq5MHxKmUazYLWtD6TMmVxJP8G6PhkCBcqJ+IZRvi5Cj7cROX
         R/RYu6m5U2AfCbcxn82t0MW2AWEKIPCPTCNM9+E2barnHVmwmRgk2ATKAwXDeONfdwQr
         77Yl6C4fmJlVWhsgxn+PX3o4Xg+likPCVE5dEbfXvDiM/KVXYk9ZkaM1VLLGiLUZeAW+
         UwvuSQEWw+vsLeOZH/aDLzSV0DfMHiMpOHTtv1G2A9mwKybKU/aImvNNWxV9Orj1DNs3
         9gvqzjSq1g9OvDQVmJeJwPhwXWdhLpsGvFw3Kpuhj/VVBBz6iVn2eKXiiH0f/5DTSMvh
         kVQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687880260; x=1690472260;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=05iaNFO9lF/8ux6dacOd00yFXxHKqE9KRL91PmH4iR8=;
        b=DSl0PF4B0yzoLUb+M/fh/a7aQdT84uGuQ6AA/5/mtPPibndsWDVx76BAtBtW1C2cqL
         1eGdPOgAlzSFfYMVNbw23zQaKc4OZ3X0+hLzQSCBckkSFEyDylobBbZ/+h0Q0PUGipFe
         zH0PNkYjnf8c/98kkrwciXiC++TH2eQPm+hIJ/Bs3zxKMrFI93QudSMtcByJMpZ4lIUU
         wzGO/H6xtpZmgyZUiXB4EsNlTMTPJeN/AxIitA2oqLGEpmN8bjPBThxpn2PTULaPArbF
         Pb9GvYYTOxCPyfGoAvIi6RAPVn4kgKnDZ8LDLlp7HPiucZY5kCMCzZk8DevtPqF1seRj
         m9YQ==
X-Gm-Message-State: AC+VfDzcIUJcqB0Fh7MzIS7GyB2a3Ohd6rPgwj6RXsjFy64RSUdUehPB
        a8S2NREfqUVQSwsPjPdXxKM=
X-Google-Smtp-Source: ACHHUZ4xuhPVqi/+8MF/Jjb+zsL9pz37GeZY7l0b2Z51yIpe/o3441sUxo3rEz+abIWpiSEvl1C2Uw==
X-Received: by 2002:a5d:4e8f:0:b0:30f:c703:8be3 with SMTP id e15-20020a5d4e8f000000b0030fc7038be3mr24263683wru.42.1687880259519;
        Tue, 27 Jun 2023 08:37:39 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id v10-20020a5d590a000000b0030631a599a0sm10707214wrd.24.2023.06.27.08.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 08:37:38 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next][V2] media: bt8xx: make read-only arrays static
Date:   Tue, 27 Jun 2023 16:37:38 +0100
Message-Id: <20230627153738.736026-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

Don't populate the arrays on the stack, instead make them static const.
Also add spaces between values to clean up checkpatch style warnings.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---

V2: actually fix up the spaces correctly

---
 drivers/media/pci/bt8xx/dvb-bt8xx.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/media/pci/bt8xx/dvb-bt8xx.c b/drivers/media/pci/bt8xx/dvb-bt8xx.c
index 4cb890b949c3..390cbba6c065 100644
--- a/drivers/media/pci/bt8xx/dvb-bt8xx.c
+++ b/drivers/media/pci/bt8xx/dvb-bt8xx.c
@@ -190,11 +190,15 @@ static int cx24108_tuner_set_params(struct dvb_frontend *fe)
 	u32 freq = c->frequency;
 	int i, a, n, pump;
 	u32 band, pll;
-	u32 osci[]={950000,1019000,1075000,1178000,1296000,1432000,
-		1576000,1718000,1856000,2036000,2150000};
-	u32 bandsel[]={0,0x00020000,0x00040000,0x00100800,0x00101000,
-		0x00102000,0x00104000,0x00108000,0x00110000,
-		0x00120000,0x00140000};
+	static const u32 osci[] = {
+		950000, 1019000, 1075000, 1178000, 1296000, 1432000,
+		1576000, 1718000, 1856000, 2036000, 2150000
+	};
+	static const u32 bandsel[] = {
+		0, 0x00020000, 0x00040000, 0x00100800, 0x00101000,
+		0x00102000, 0x00104000, 0x00108000, 0x00110000,
+		0x00120000, 0x00140000
+	};
 
 	#define XTAL 1011100 /* Hz, really 1.0111 MHz and a /10 prescaler */
 	dprintk("cx24108 debug: entering SetTunerFreq, freq=%d\n", freq);
-- 
2.39.2

