Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C21606990FA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 11:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjBPKUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 05:20:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjBPKUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 05:20:35 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F41492D5F;
        Thu, 16 Feb 2023 02:20:33 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id g28so2232412lfv.0;
        Thu, 16 Feb 2023 02:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h1Fu9KGbMLX1F3RRo0mzeQNrN2b2dHrXh4LUtTqpTTI=;
        b=XzMipX6KkjZk/mpdCPtw5elYpuV/4m/4WVSjdgLMI3UM2xRECeJ7sVxcawx7LdcDTK
         5LvQikWrsOv9XxeZKV3Oz/T6/dsDzn5rDqZwlsNE5SZULMpJr9adSSBmlP5b23pKWn7J
         2pSIZAj2VyP/pJUECvsIOV/0/J6lsQXf/kP954qu5IgDOp1Cbx8IAbbZB4gNz3O/xB5G
         0x2d0V7wcRAJINfi1iW16tm5nQEEAdf7jAR8lFLp5MfuepqDW7/VypAri6pTLeNTrAhG
         JWVzVo1syvjuZTEUyUQDN9i2KCEe+Evat2VE+UJjJqAbDX6sQXeR0IfdwQ14QIbP6Hbw
         3EyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h1Fu9KGbMLX1F3RRo0mzeQNrN2b2dHrXh4LUtTqpTTI=;
        b=imQ9NwTYwxOTudpDMehsBUlrvBEbOn0OQ3lBJ1Y24uuXeLo4DMEIAMYDsuM7D9brsY
         wKGYXVyBDz/qJY7iVurVEf4KZUVSRCgp1kDzaaNk16dxrT8VRnCyaC6oft0hCqeXTjlK
         zAX6lxrImeVYgbaVX4sgVQdIaOBkwn3wFtEoavyFhktCkzrVvxPhqh9YOldHgQLcNj5X
         zqs0rGpr7JWipQe2Eb06hGHRwv9+gPqjowKvPmlrFY5hj9z+FaWHXnMkOkwGnxmgNEy6
         O30Ee79Mst5WJVOgcVBmOBfwbIP4aVpDDx7Q1NoPZoLQjAyUamqE7tkOkpCcMoYd6BwE
         Zxnw==
X-Gm-Message-State: AO0yUKXPnr7Htf/d3JqqtRb0fvunMUXsBB0d/Hx5Sj2F35e0U/YEEu7/
        2pt9nXrdCEMRRMw9j+HtuqQ=
X-Google-Smtp-Source: AK7set/TL3cEmnwGPjVTAJh9QOUU2fLjV/K+jgAhBgMq57WjCt8Xag1WKzFGl5pXr9LytZbe/au4kQ==
X-Received: by 2002:a05:6512:73:b0:4b5:5f2b:ddf8 with SMTP id i19-20020a056512007300b004b55f2bddf8mr1513210lfo.7.1676542832202;
        Thu, 16 Feb 2023 02:20:32 -0800 (PST)
Received: from alsp.securitycode.ru ([2a02:2168:8a04:5600:ecbf:de16:f87d:956])
        by smtp.googlemail.com with ESMTPSA id s1-20020a19ad41000000b004db4f2f08f7sm242438lfd.28.2023.02.16.02.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 02:20:31 -0800 (PST)
From:   Alexander Sapozhnikov <alsp705@gmail.com>
To:     Adam Radford <aradford@gmail.com>
Cc:     Alexandr Sapozhnikov <alsp705@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: [PATCH] scsi-3w-9xxx: NULL check in twa_scsiop_execute_scsi()
Date:   Thu, 16 Feb 2023 13:20:21 +0300
Message-Id: <20230216102023.30-1-alsp705@gmail.com>
X-Mailer: git-send-email 2.34.1
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

From: Alexandr Sapozhnikov <alsp705@gmail.com>

After having been compared to NULL value at 3w-9xxx.c:1829,
pointer 'srb' is passed as 1st parameter in call to function 
'scsi_sg_count' at 3w-9xxx.c:1844, where it is dereferenced.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Alexandr Sapozhnikov <alsp705@gmail.com>
---
 drivers/scsi/3w-9xxx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/3w-9xxx.c b/drivers/scsi/3w-9xxx.c
index 6cb9cca..5a99294 100644
--- a/drivers/scsi/3w-9xxx.c
+++ b/drivers/scsi/3w-9xxx.c
@@ -1841,7 +1841,7 @@ static int twa_scsiop_execute_scsi(TW_Device_Extension *tw_dev, int request_id,
 	if (!sglistarg) {
 		/* Map sglist from scsi layer to cmd packet */
 
-		if (scsi_sg_count(srb)) {
+		if (srb && scsi_sg_count(srb)) {
 			if (!twa_command_mapped(srb)) {
 				if (srb->sc_data_direction == DMA_TO_DEVICE ||
 				    srb->sc_data_direction == DMA_BIDIRECTIONAL)
-- 
2.5.3

