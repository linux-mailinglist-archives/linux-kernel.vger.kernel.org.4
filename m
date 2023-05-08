Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFA026FB406
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 17:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234116AbjEHPnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 11:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234310AbjEHPmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 11:42:45 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A9408A43
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 08:42:42 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f14ec8d72aso3241063e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 08:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683560560; x=1686152560;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1nrim1zdDFQGC8ucuVD6kdQKx65cnjU9kvIcHKJk3bs=;
        b=rGZ5zhtzAbKteLvucWXGxvVFURj5Zw0i1inuECygKNPfCPIxZmobqmxHOmLB49jMBg
         CKc5PnMw2RMkXiO0QChNhfTaVDfbQmHDYE6eWf1dP+GsFVr0y+g0i1FHzZxO/h4MMSEc
         2NzJDvsm2CZ4aSBvVSLB9rykycg+GHZb0BZaqgdw6YotfR8J2g/4PJOCGcwJ1vERcj3r
         g3qKW6edrYi97lgV+DMopOU9Gsc3QB3+I6n4UNG7URVN2jZxhuPAvf6LJ5qRg86DUbWc
         w/4WYvsLI6CHNL+97mgsFTybO9Pj5KNne0ot39Huw2hVrlUaIaAIlbx1CbyUoJB48Hc7
         w2RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683560560; x=1686152560;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1nrim1zdDFQGC8ucuVD6kdQKx65cnjU9kvIcHKJk3bs=;
        b=DlGCVZAO9gorVKPzSbLZaWQJD0MyG2m/XndN1RWp/zcgualSWPDhL8leDmNMM3qdxI
         Qmq1Ujxcs8lddMWsKP7kKCFkzfM4SVqF27rIN9C/mTb+qxW1oTw9m7F7oomAU8AhNJ64
         Nj9gex6es5wNyBfO0C7BDEsGu7jGaj9CBYBoAn3hKj3Md1NuPcGn2VnP+msZty5xmC3Q
         K2Am1lA6l0VdEuSZBywgwWhsMsnTYPjjKHoPJOppYeP74VCKTzNWbnUtCd+vpQEO+H9h
         QV8k8cynuNeobR6dbG2J441gLw3mT/fhBO5U/dlC2JgFjNWK8XFeUogJwe0alYvZStw1
         C7iw==
X-Gm-Message-State: AC+VfDwh6E2docBXlOzejMYTpdb8GZmRS9JmEXlwsshTw+lT+ZPWfmcz
        QrL5ZicGZGMj3uXVuILsGQsquw==
X-Google-Smtp-Source: ACHHUZ5/Ui+nUjGEebamLnyNX3oMp1mH8IBeJRxonyA/xSJNajver9SOel/kQ9W2YN+d2fPkvo2oVA==
X-Received: by 2002:a2e:2e06:0:b0:2a8:e73c:8405 with SMTP id u6-20020a2e2e06000000b002a8e73c8405mr3316677lju.42.1683560560428;
        Mon, 08 May 2023 08:42:40 -0700 (PDT)
Received: from ta1.c.googlers.com.com (61.215.228.35.bc.googleusercontent.com. [35.228.215.61])
        by smtp.gmail.com with ESMTPSA id a21-20020a2e9815000000b002ad9b741959sm17720ljj.76.2023.05.08.08.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 08:42:39 -0700 (PDT)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     tytso@mit.edu
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, joneslee@google.com,
        Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [RESEND PATCH v2 5/5] ext4: fsmap: Remove duplicated initialization
Date:   Mon,  8 May 2023 15:42:30 +0000
Message-ID: <20230508154230.159654-6-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
In-Reply-To: <20230508154230.159654-1-tudor.ambarus@linaro.org>
References: <20230508154230.159654-1-tudor.ambarus@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All members of struct ext4_fsmap_head were already initialized with zero
in the caller, ext4_ioc_getfsmap(), remove duplicated initialization.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 fs/ext4/fsmap.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/ext4/fsmap.c b/fs/ext4/fsmap.c
index 655379c96fcf..d19d85be3404 100644
--- a/fs/ext4/fsmap.c
+++ b/fs/ext4/fsmap.c
@@ -666,8 +666,6 @@ int ext4_getfsmap(struct super_block *sb, struct ext4_fsmap_head *head,
 	int i;
 	int error = 0;
 
-	head->fmh_entries = 0;
-
 	/* Set up our device handlers. */
 	memset(handlers, 0, sizeof(handlers));
 	handlers[0].gfd_dev = new_encode_dev(sb->s_bdev->bd_dev);
-- 
2.40.1.521.gf1e218fcd8-goog

