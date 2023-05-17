Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61554706B16
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 16:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbjEQOaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 10:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjEQOaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 10:30:21 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A6C69C;
        Wed, 17 May 2023 07:30:20 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id e9e14a558f8ab-3361b08a564so5657245ab.3;
        Wed, 17 May 2023 07:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684333820; x=1686925820;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yNUMQ1PEW/q33xRaa3QEUyTPfbVsUmYNJm0BWOVeXO4=;
        b=WvGb/E9JOdG7FSmn8zE2q48KwNsDlB+LL/p9y2AqxtlKYYfLzI+ptQKMjtVgA2AyTR
         7Qbj1enSn4b/no9DOQziR3ihlN30R6f22k6Aqb20hMPEduBgJWB5W8tb2RbjkdG6Z0n1
         OtFAuYTgwNrAUy9DHLaA3aX1VygCPtb8MkoxmLwytPLZXwiPhsxAhJVdUk82dTLD8wjS
         ppOgSs1dQQ9W2kRnW7f68XW8YMNGgtXorFTpfJNzwBIKMJJbqoxWa4pv33uF4MAvgp87
         ufK0C9nM68+F4ZsK3sgDb6BrjV/PkAONiUnEcnDyJrstlJDrALt35E10GjsZ6wpWlMZz
         C5pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684333820; x=1686925820;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yNUMQ1PEW/q33xRaa3QEUyTPfbVsUmYNJm0BWOVeXO4=;
        b=N/lyGgaqf3VERBUrQYoHpX98+SOUhyXwWhjgA72nYLuvkt4dE5QjNI84sibI13D0uA
         0//gzjPkk8EYugXiMEpN4pEZ61xBBLdlaHEQK+CZ66OwJIMpLtYaQ0RpiHy73xT9aroT
         evYuh8rI838A/sgykqamA/mLwcEgaCpnX2iSflRToN9VN3Qvqelirl94qF8l8dEo7Iqy
         c8gDbuuFMo715rRalbpsKaBTXrzjfwDjHcL5S67irXzw01EHNs4uoF+3GR3SacOZoyzO
         Qb3X1ghnEOVANRv3MWwCvr82+SEPfDBGWBG7NDAoFcjRs5UhP+xcDYq+3+hFKSkSdlXR
         kQNQ==
X-Gm-Message-State: AC+VfDyR6ktK4x7gaYfFAVn3wKBMvi5SuZ7bGW+zwhQhI/YWjBgivur0
        lZGtA6rnn/Yp47vcVQUO1EQzeZnwpTXyag==
X-Google-Smtp-Source: ACHHUZ6/3uRbfAeIuIA2STlk3/JDq8+dYaVfVPym/azA03JYjDzYn7elAXf/5OV0s0wqu3dVjbTyTw==
X-Received: by 2002:a92:de50:0:b0:338:1e73:ca0 with SMTP id e16-20020a92de50000000b003381e730ca0mr2354891ilr.11.1684333819595;
        Wed, 17 May 2023 07:30:19 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (54.70.188.35.bc.googleusercontent.com. [35.188.70.54])
        by smtp.gmail.com with ESMTPSA id a2-20020a927f02000000b003312915e615sm8153185ild.28.2023.05.17.07.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 07:30:19 -0700 (PDT)
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
To:     Adam Radford <aradford@gmail.com>
Cc:     linux-hardening@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH] scsi: 3w-9xxx: Replace all non-returning strlcpy with strscpy
Date:   Wed, 17 May 2023 14:29:55 +0000
Message-ID: <20230517142955.1519572-1-azeemshaikh38@gmail.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
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
 drivers/scsi/3w-9xxx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/3w-9xxx.c b/drivers/scsi/3w-9xxx.c
index 38d20a69ee12..f925f8664c2c 100644
--- a/drivers/scsi/3w-9xxx.c
+++ b/drivers/scsi/3w-9xxx.c
@@ -617,7 +617,7 @@ static int twa_check_srl(TW_Device_Extension *tw_dev, int *flashed)
 	}
 
 	/* Load rest of compatibility struct */
-	strlcpy(tw_dev->tw_compat_info.driver_version, TW_DRIVER_VERSION,
+	strscpy(tw_dev->tw_compat_info.driver_version, TW_DRIVER_VERSION,
 		sizeof(tw_dev->tw_compat_info.driver_version));
 	tw_dev->tw_compat_info.driver_srl_high = TW_CURRENT_DRIVER_SRL;
 	tw_dev->tw_compat_info.driver_branch_high = TW_CURRENT_DRIVER_BRANCH;

