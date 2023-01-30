Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13AFE680D4C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 13:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235963AbjA3MNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 07:13:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236259AbjA3MNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 07:13:37 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967C65FE8
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 04:12:53 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id v10so10717368edi.8
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 04:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fsypYKaGRF+jJzYTBvdHGCa2eKmDzFXH8HWwIO/XXww=;
        b=Zd+HCvUeLb0uufTNY7QD32aA6Xlaqh2+63lss+TEJ8P+o+Cc1R4nP4tuwSxRXd5a+J
         J5KfYmty6aZW8HT95P9ND/UjdNVNfQ5e10QexuuF3eGCMRQjZtXSIUxM2BexYG/OWsYy
         fPEgICBqbUx/YVUMkfV7Tc7RHA7drcFLCDoDGDENmrySPWFAiIVOgxMzL51r5LfaoryW
         9eB2trET3AtOL+YKb/YZ3geqZDvl8ZQ80WaCPr2urs0oa8Vu1dIIfPhdxH86+UXuMmzN
         LZCSiNW9FBtAMWMgMqoZrGBz03SDnXEMqMkuScFG3sy5ka1ubCgdSRETDCjThhzxD1uq
         VESA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fsypYKaGRF+jJzYTBvdHGCa2eKmDzFXH8HWwIO/XXww=;
        b=BsYsF3cV6X3lniH4pIBPvE9igy4O0Zf32njNCtFiMIyn9x1BgeW/WojGTbPaS5pvET
         +IkMYKFEvc4z0qvARPfuRK2MD5X2h/RZSaI5LI3Em6DVgwJwOsWAzqA7QxRiR8x00tbu
         mxDeFVuBfXz9PqjrZ3euLFiQYiIyMZ8xbyHOfykqyBJPAISChC2OhuSAKtg3xv3d76Fw
         6e88TIbgxOrUC9MQPx8n1403Z+BqFjuEl1CwTIFrMVxwtzOs32SPbsJFyssqKTM5JJ5d
         ofzsMcQD0GxZ7q97zvyMjvhlTjDbWutiJTm7K2OA4WOvIcO1V+E+Fz3uveibb4PK/vEa
         K92A==
X-Gm-Message-State: AFqh2koR/lij4joo4275+cGjzVNoOhspA48SYv6YGBWEei6rySAL6PgC
        HIHCdaQ+CHR7CKjd0iVSUr+8gQ==
X-Google-Smtp-Source: AMrXdXstzBqpjcYLIuri+fSWHmV0RZtWThMjtd4dxKCsOjuWHYEyS+lDQ9ZLf2bl1nhAysRSN9Q3uA==
X-Received: by 2002:a05:6402:548f:b0:49c:1fe4:9efc with SMTP id fg15-20020a056402548f00b0049c1fe49efcmr53143801edb.40.1675080766511;
        Mon, 30 Jan 2023 04:12:46 -0800 (PST)
Received: from uffe-XPS13.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id ee36-20020a056402292400b004a21c9facd5sm4215283edb.67.2023.01.30.04.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 04:12:45 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] block: Default to use cgroup support for BFQ
Date:   Mon, 30 Jan 2023 13:12:40 +0100
Message-Id: <20230130121240.159456-1-ulf.hansson@linaro.org>
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

Assuming that both Kconfig options, BLK_CGROUP and IOSCHED_BFQ are set, we
most likely want cgroup support for BFQ too (BFQ_GROUP_IOSCHED), so let's
make it default y.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 block/Kconfig.iosched | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/Kconfig.iosched b/block/Kconfig.iosched
index 615516146086..27f11320b8d1 100644
--- a/block/Kconfig.iosched
+++ b/block/Kconfig.iosched
@@ -30,6 +30,7 @@ config IOSCHED_BFQ
 config BFQ_GROUP_IOSCHED
        bool "BFQ hierarchical scheduling support"
        depends on IOSCHED_BFQ && BLK_CGROUP
+       default y
        select BLK_CGROUP_RWSTAT
 	help
 
-- 
2.34.1

