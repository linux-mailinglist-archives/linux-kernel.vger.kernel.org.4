Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87E696C192D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 16:31:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233077AbjCTPb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 11:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232469AbjCTPbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 11:31:05 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C3D33469
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 08:23:27 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id y14so10733879wrq.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 08:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679325803;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G5r4xW0SFy5xnQUYRPg8Rn0IUjwAIHkZLfnsMjBMBlo=;
        b=NIsTRyaPLIG5ttPYu/Dx7qu6rDlCE1dZBPxp5a5HqLZR6/KE2nZQWEhmluEjq9uRBz
         z8u+45wdbyCv2MCwuzSjBaBwBLR22RpplzClcyRI7rs1imTCtRBxxhxR9ff6DAsbORSs
         2PPbG9gYPNf2kokzwRz7zjyCboOqw1F1Q2uMPei7UyHPbn9IvkNSuzwev9ftzqZbaCdx
         UKcj+97CdbAR48paSjN9yoGwt+gKFVSFXNFrKsYU3LXqA1njFJ0Y7suDLgygOGSJfi/1
         2TyHAO7ew1TNroa6/MX9RxgNUe7HMJIg57i5LgZYOkb7nY6ll8dXkuwflnTK9tz6l2c5
         ar+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679325803;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G5r4xW0SFy5xnQUYRPg8Rn0IUjwAIHkZLfnsMjBMBlo=;
        b=jMIArm0H9BBv9+Nu6gFsKukgEdDuvO5IcW+PpbVEZ0t5Hsd8ArPD4NDwQUNfXnl2DL
         dxTvocwwB6K3pJp9VmN36YozUSSTmSZS42yZFSaYyW++vstqhYLHUFPmMjsJyAvEcPmY
         KuMrhXI1chOD19s5LHjly8UVxDJQBMWnS9AZ3efYjeLdXWtG0ri9kPQuxnRLD9KL7bT9
         eCtjHffI9lo7G4bKQUz7fvqzWoqoHN1pTEX15i4fojOfAulZ+gTiUrMZUngrWDXc6YIs
         j1YratF28Cd/hLIZTOwWvFcRvsdcMUUc04+I0wbQxuPdbml+AJsOTTk6X7H5qARN1EWG
         cZBg==
X-Gm-Message-State: AO0yUKUcTjm7l5Metgqj1DhTYJ/IOsDHRXErg1xXouSA0k3ewswZxg5S
        QTYaWXffUyFwErOdduJBcQHNtg==
X-Google-Smtp-Source: AK7set9WlCjc9i93x8LyM/2+1cA8YLtOf/j6ptEkfLMnG05NrIuCLF4V024VoZHfR1v8Vzcsa8pJhg==
X-Received: by 2002:a5d:510f:0:b0:2ce:a74f:3249 with SMTP id s15-20020a5d510f000000b002cea74f3249mr13208228wrt.43.1679325802970;
        Mon, 20 Mar 2023 08:23:22 -0700 (PDT)
Received: from loic-ThinkPad-T470p.. ([2a01:e0a:82c:5f0:f775:fe58:f222:14c7])
        by smtp.gmail.com with ESMTPSA id b13-20020adff90d000000b002c54c92e125sm9156761wrr.46.2023.03.20.08.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 08:23:22 -0700 (PDT)
From:   Loic Poulain <loic.poulain@linaro.org>
To:     lee@kernel.org, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org,
        Loic Poulain <loic.poulain@linaro.org>
Subject: [PATCH] mfd: syscon: Use of_io_request_and_map() for IO mapping
Date:   Mon, 20 Mar 2023 16:23:19 +0100
Message-Id: <20230320152319.665592-1-loic.poulain@linaro.org>
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

Use of_io_request_and_map() instead of of_iomap() so that the
region is reserved and protected, i.e reported in /proc/iomem
and not accessible from user side (CONFIG_IO_STRICT_DEVMEM).

Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
---
 drivers/mfd/syscon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
index bdb2ce7ff03b..7e6d4edda118 100644
--- a/drivers/mfd/syscon.c
+++ b/drivers/mfd/syscon.c
@@ -60,7 +60,7 @@ static struct syscon *of_syscon_register(struct device_node *np, bool check_clk)
 		goto err_map;
 	}
 
-	base = of_iomap(np, 0);
+	base = of_io_request_and_map(np, 0, NULL);
 	if (!base) {
 		ret = -ENOMEM;
 		goto err_map;
-- 
2.34.1

