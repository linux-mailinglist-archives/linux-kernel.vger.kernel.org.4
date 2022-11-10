Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75D0062411C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 12:12:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbiKJLMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 06:12:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbiKJLMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 06:12:03 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970E06DCD6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 03:12:02 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id p21so1145520plr.7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 03:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Yaq+SFAP5kTf9oPrYPpMvzkjalgNUTHY8MYqzihNGbY=;
        b=W1ZC/0/jOj62exU1NlwqP2F21YthQH/vEaLHLYXraLCvXwC+bo1E8ztCFTZSqVUMLi
         teaoHcLCkiHS1We6wJTp7SRCvPogWQwMqUIdF/ea6ipIvDfWSIxPr19PSuVpammjU9D4
         VKI0tHLgSTEZSP5uWlz3VHI0wyzs3Ax0wz38L0nGoJt/Ar2V2RXtM62VhHepMJ6iHIo1
         cwPW383kcyvjkZUZrJ6GAd+oihi1xiGQLrL8LrgTxU2nS7Ty80AN5mm1xPbqO+8wZfxD
         BW9v/m/wl5WwFeL4TAEiSuI9r3B37Sx9TR40gqlzSVIZfdAPdENEHC4IVmHdxPUD/YfM
         M4qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yaq+SFAP5kTf9oPrYPpMvzkjalgNUTHY8MYqzihNGbY=;
        b=dlvHUVKBTS3uW0pYywSaau5NpfIXMwxTB4LfrI9/EOU7ApMYm9K4iWdQQ4TIOi0As1
         PKkSjj8fR8/GY8fjqjRX/aHgzUI/XvqdzpjXRfOoeTF2Vw7vk6MRgSFQ5xUVTcBOHApw
         wAZayId1wFZtxKt26K1wv0ZKd0u1fNNd3aeYhcUtSwEPdSIrkZ7/fg4uJq07C7XzE35F
         /AvU175u5FDXG8tAcyY4mAufTPSI1P2cReUBFiu6GORNtTEhso2ZjXvXOEa1ZCgSTcWV
         t/nzKpjpVVZguuOu70C6QfjdMyrRTybPKsVjst4mz6GN+wkhHOSNNPL//qGTfAfWb13k
         28NA==
X-Gm-Message-State: ACrzQf2rA17jIt9sVTMEYZkn2Dg4/Z/mDYckXQH3pgMzsJhVzWnw/zH4
        rFbgq+Sndlh/7CL5m9cAwfAG+A==
X-Google-Smtp-Source: AMsMyM4ofpvuMY+7nXoyvVA9/VE8N84lCP9lqiryxNbGE3ShZFhtkHDbxVs+jGAa+XPX1Osm81MDGQ==
X-Received: by 2002:a17:90a:1097:b0:213:d7d3:ab8 with SMTP id c23-20020a17090a109700b00213d7d30ab8mr58405678pja.91.1668078722103;
        Thu, 10 Nov 2022 03:12:02 -0800 (PST)
Received: from sumit-X1.. ([223.178.212.236])
        by smtp.gmail.com with ESMTPSA id 68-20020a621647000000b0056bd1bf4243sm9903435pfw.53.2022.11.10.03.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 03:12:01 -0800 (PST)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     keyrings@vger.kernel.org
Cc:     jejb@linux.ibm.com, zohar@linux.ibm.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@linaro.org>,
        Jerome Forissier <jerome.forissier@linaro.org>
Subject: [PATCH] KEYS: trusted: tee: Make registered shm dependency explicit
Date:   Thu, 10 Nov 2022 16:41:40 +0530
Message-Id: <20221110111140.1999538-1-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TEE trusted keys support depends on registered shared memory support
since the key buffers are needed to be registered with OP-TEE. So make
that dependency explicit to not register trusted keys support if
underlying implementation doesn't support registered shared memory.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
Tested-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 security/keys/trusted-keys/trusted_tee.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/keys/trusted-keys/trusted_tee.c b/security/keys/trusted-keys/trusted_tee.c
index c8626686ee1b..ac3e270ade69 100644
--- a/security/keys/trusted-keys/trusted_tee.c
+++ b/security/keys/trusted-keys/trusted_tee.c
@@ -219,7 +219,8 @@ static int trusted_tee_get_random(unsigned char *key, size_t key_len)
 
 static int optee_ctx_match(struct tee_ioctl_version_data *ver, const void *data)
 {
-	if (ver->impl_id == TEE_IMPL_ID_OPTEE)
+	if (ver->impl_id == TEE_IMPL_ID_OPTEE &&
+	    ver->gen_caps & TEE_GEN_CAP_REG_MEM)
 		return 1;
 	else
 		return 0;
-- 
2.34.1

