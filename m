Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2FA371692B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 18:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbjE3QXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 12:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbjE3QXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 12:23:33 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B0EF7;
        Tue, 30 May 2023 09:23:25 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id e9e14a558f8ab-33b4b70693eso17436965ab.1;
        Tue, 30 May 2023 09:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685463804; x=1688055804;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wf5Jl4L5iGKB9g9WAO3hQ5Kz/WXc65qEj717gqBRX5w=;
        b=Y/SSeuwGjQLmJUJ5gIwpqYpNQd/DUr3WtF6p5Hpw3kIQwybP15kZPjc2ETUBT5v+a8
         4/2m1vdkTwVVQ7e1EB0lfCe2XhvEK2ni7wJeycQNNzi6exdBczX+ZyAqYhnIo+QnsZ8E
         97/fCeYXUU0YwV/BuOwkhrhiefKf/7lEQDH8EevvROg6sLz1J+iOyVh5OqFhyqjh2wrN
         Tdk62TWzACH2C5UR3QXyOIvU2PZnkc3DeLmdfK9qy/cuc7XCEURca4xvh6ZBuxBimTrY
         LMQfuglWAYtDDz7gSBATFalJN5HiJYPjjHDsoY+x3fcrl+2iXNT/QsX6zavC0aCKO7Ji
         Sx0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685463804; x=1688055804;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wf5Jl4L5iGKB9g9WAO3hQ5Kz/WXc65qEj717gqBRX5w=;
        b=j4Hv4KGLGneR0N/l2cGmewIiRK7e1Wg64EiZj22om6jhiWUEzAh354N/FVS3EyMNTa
         z/YsJ1cNgO0eD9J/ehiLCbMcSa166taTyFX2fwUUmqLjKN14GqOVhYVsFiCt19hVitDv
         ryLf6NJvjFtvfDSB0iLnvkPDLRIv7aFVG3HIxz93paWpWiHIPP7MspZELMlTn0No8xI0
         TWWhaCDSdMFinQcGAO0mnh/HEPYSVFsvXwzom2NyG9+kcN1LtPT6aG728g6c64t0Vu1a
         DzVbJf13eZiH7Kzkk3J5Sa8wzYo8SV26Gtl+baXGxEfqhP/mIdQBlIHgC7sVVcfypf6O
         RD6w==
X-Gm-Message-State: AC+VfDxNDzMXyrf8htWVtLo44ALpGokvgoh8+wa6d0PQxbH63bFxQ4lx
        7wXWESLJKo/vf0Uaj6alpp8=
X-Google-Smtp-Source: ACHHUZ4iEManahS8tA9CcIeVxg11T95mCOr54VBbEadoPhb/eCpsS52imW/5Ihe7AeMVPxt8Mee3gw==
X-Received: by 2002:a92:d34a:0:b0:33b:4c71:a245 with SMTP id a10-20020a92d34a000000b0033b4c71a245mr95983ilh.8.1685463804245;
        Tue, 30 May 2023 09:23:24 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (54.70.188.35.bc.googleusercontent.com. [35.188.70.54])
        by smtp.gmail.com with ESMTPSA id v15-20020a92d24f000000b0033568b32890sm2558996ilg.24.2023.05.30.09.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 09:23:23 -0700 (PDT)
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
To:     Don Brace <don.brace@microchip.com>
Cc:     linux-hardening@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        storagedev@microchip.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH] scsi: smartpqi: Replace all non-returning strlcpy with strscpy
Date:   Tue, 30 May 2023 16:23:21 +0000
Message-ID: <20230530162321.984035-1-azeemshaikh38@gmail.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strlcpy() reads the entire source buffer first.
This read may exceed the destination size limit.
This is both inefficient and can lead to linear read
overflows if a source string is not NUL-terminated [1].
In an effort to remove strlcpy() completely [2], replace
strlcpy() here with strscpy().
No return values were used, so direct replacement is safe.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
[2] https://github.com/KSPP/linux/issues/89

Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
---
 drivers/scsi/smartpqi/smartpqi_init.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/smartpqi/smartpqi_init.c b/drivers/scsi/smartpqi/smartpqi_init.c
index 03de97cd72c2..74f608b9fc9d 100644
--- a/drivers/scsi/smartpqi/smartpqi_init.c
+++ b/drivers/scsi/smartpqi/smartpqi_init.c
@@ -6903,7 +6903,7 @@ static ssize_t pqi_lockup_action_store(struct device *dev,
 	char *action_name;
 	char action_name_buffer[32];
 
-	strlcpy(action_name_buffer, buffer, sizeof(action_name_buffer));
+	strscpy(action_name_buffer, buffer, sizeof(action_name_buffer));
 	action_name = strstrip(action_name_buffer);
 
 	for (i = 0; i < ARRAY_SIZE(pqi_lockup_actions); i++) {

