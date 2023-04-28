Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F000F6F0FFA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 03:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344770AbjD1BXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 21:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344775AbjD1BW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 21:22:58 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8162230C2;
        Thu, 27 Apr 2023 18:22:57 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-63b57c49c4cso7446444b3a.3;
        Thu, 27 Apr 2023 18:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682644977; x=1685236977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5zPo3vtMu8f9pRkpyZdDPdmJ7m3I5ZhBmFy8wrhejWA=;
        b=bloWPNWL2WYYT2JbzizlqbN2m6Qvtd0Ke1HlojmBG42JOMdRggtOs/uAkC93xGNJ5o
         qVc4Ty1luIrjldDAWk4cvbKeENcv2V7iRuQ0YFgITNFGxRk1JsVdbUOwKLlnjrmTcfC+
         NZyPDO7iciTiUDyVcX2/1lobGLIw3tYTeNsIxnBWPUsIcFBgNctZwJjFKA1hKwfBYalR
         OKEMEEPZ4i91Xd99Sa6pMnVpwCnTNpNwUzC8XiEyiDA6CnBVFplC/0aNtgpDxWx1U/uQ
         iv3zrthDC+3SUaypUzRUoXmIgNxuujzy64d6llsdGBJH/ZvpzALIbBqNl+Eh0KExbxjH
         NHBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682644977; x=1685236977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5zPo3vtMu8f9pRkpyZdDPdmJ7m3I5ZhBmFy8wrhejWA=;
        b=ZBeyA0rke8E8j8EueiJfIh5G7PhZPrRRuaE7OtkyLbRX5x9Ku2j5BY4wTbhNnwaABj
         4Du8gNQJEm7Y3r0LfKjSSQ737az+pEHxVt4UQxPAFcyetmbKQ7DFMnN3IWXviIIYNWq2
         0pj0yCNy1vGGMqL4DrxOek+nkvhHZXPr6Ygw8H7IMKKHzj0gLwbtOT0iHwefAR8qJvVi
         VCDdIR8tKpzJ+BHDih7CI7Jx1tFmE21T5TsbSq9COMsES05mVpODkrYLlkOXbGRwNQgH
         t5hZ93P7qh5fKm7J1wpb4Q+RUoz9GmM8sPM+e3ddfEGIFLFw+BtB0dqIvlS3rCsXbERf
         zFaQ==
X-Gm-Message-State: AC+VfDwN/7PzwE9ZVHbNE7bs+GZlAMMClh2yLkShSgESeOyvqg3upeyt
        KLs7RORW571iOyKqW/EysgLxksT89Z8=
X-Google-Smtp-Source: ACHHUZ58YMBqiiH9YEm20upJJ+JKT83z4JlmEmoYdJdm7NvC/CEYfKav8pqaX6JoB5RL+IShe7f0Hg==
X-Received: by 2002:a05:6a00:cd3:b0:63b:6d60:9a02 with SMTP id b19-20020a056a000cd300b0063b6d609a02mr5108437pfv.34.1682644976806;
        Thu, 27 Apr 2023 18:22:56 -0700 (PDT)
Received: from cxl-test.. ([103.181.222.211])
        by smtp.gmail.com with ESMTPSA id t65-20020a628144000000b0063b8b8580a7sm13691356pfd.29.2023.04.27.18.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 18:22:56 -0700 (PDT)
From:   Raghu H <raghuhack78@gmail.com>
To:     linux-cxl@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        raghuhack78@gmail.com, ira.weiny@intel.com, bwidawsk@kernel.org,
        dan.j.williams@intel.com, vishal.l.verma@intel.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] cxl/region: Remove else after return statement
Date:   Fri, 28 Apr 2023 01:22:35 +0000
Message-Id: <20230428012235.119333-3-raghuhack78@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230428012235.119333-1-raghuhack78@gmail.com>
References: <20230428012235.119333-1-raghuhack78@gmail.com>
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

Issue found with checkpatch

The else section here is redundant after return statement, removing it.
Sanity and correctness is not affected due to this fix.

Signed-off-by: Raghu H <raghuhack78@gmail.com>
---
 drivers/cxl/core/region.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index f29028148806..a46d6ad9ef0a 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2666,11 +2666,11 @@ static int cxl_region_invalidate_memregion(struct cxl_region *cxlr)
 				"Bypassing cpu_cache_invalidate_memregion() for testing!\n");
 			clear_bit(CXL_REGION_F_INCOHERENT, &cxlr->flags);
 			return 0;
-		} else {
-			dev_err(&cxlr->dev,
-				"Failed to synchronize CPU cache state\n");
-			return -ENXIO;
 		}
+
+		dev_err(&cxlr->dev,
+			"Failed to synchronize CPU cache state\n");
+		return -ENXIO;
 	}
 
 	cpu_cache_invalidate_memregion(IORES_DESC_CXL);
-- 
2.39.2

