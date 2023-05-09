Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFE1B6FC336
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 11:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235159AbjEIJvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 05:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234780AbjEIJug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 05:50:36 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA544D9;
        Tue,  9 May 2023 02:50:35 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6436dfa15b3so3772139b3a.1;
        Tue, 09 May 2023 02:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683625835; x=1686217835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pQOFmGNOwj6qlXQnaRhNhaPnJjx7MtjWUWXhuM4qz4I=;
        b=E1mzCGTRMVxTwNPmgje1222qGThQPLUc8wt60W7/obDBf2XLscPCZTQu5/8ZnQHe9p
         BXyHm5TB/Pg2beV6MHgcJseWn07R6/9bP84XOPzXE9B9+Z5agbbt/D0KoPMiXBf2sE+2
         NgE+RBz14b9uJ1zo/T7BflCWR8Dlbv+LJRTF/ScvHyIqR94w6pwTEoT1UE2fDEH6pU9j
         8c13pWE9gzQB8FvLLdRfKzIFHghHmnMpaqNoVsnq3hudznysmkvbMebqVGtVL9ad8u04
         Qnanja1EMvzJb3wPCxQB/jxkLHj9Pebnmbmx4JgDC0wO1OJXfyNWf3GeYjoU98USBrTi
         /QDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683625835; x=1686217835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pQOFmGNOwj6qlXQnaRhNhaPnJjx7MtjWUWXhuM4qz4I=;
        b=UtW0nu9Ut+TwEmeN2NfLlkuyGeG9I434indKgXssxvJ15RY7ADUOEMwnFXy5+TSVtH
         QpXJeAEEnBXwg7slBuMUJqxwymlXaM+Y+E5Br6R0W2TMecaYViEpHxVzlpJzj8I2gQx7
         Qi01qA9PkR+rQQ0xU04b5n6PfH4d5VB0vSBbcXNeW4mE0yVj2wC/PfUIcVAyFV01TiJL
         0nFOm9rXzk5BjmPpefSFOqH+Fj+rjP+dLTD2BinpZfyhwwigdGVbS+7UqxAt0dGD99PX
         SNQjS7h0TgGq+PY/4Sc0rBT5UXtS/uZYBLaOrTTAFr00uVDVaEsm2UbSOaAvMX2UEni8
         5/Dw==
X-Gm-Message-State: AC+VfDwzvUHjc6aeirhxEVe4lxzl1E64FNJpp5zbSX9iPAzozoaUFYgW
        YQa8X2hkj+S8O4hQrvYb98+viw4NwME=
X-Google-Smtp-Source: ACHHUZ78mXCVVuuK8tVLTmbV25MCcp5IB90hLZDf02tSlpe4aJw1+rcHUn6iQQdMGWDMCGGPvhvmEw==
X-Received: by 2002:a05:6a00:1696:b0:633:c311:c70d with SMTP id k22-20020a056a00169600b00633c311c70dmr17434581pfc.14.1683625835096;
        Tue, 09 May 2023 02:50:35 -0700 (PDT)
Received: from cxl-test.. ([103.181.222.211])
        by smtp.gmail.com with ESMTPSA id j11-20020a62e90b000000b00571cdbd0771sm1361998pfh.102.2023.05.09.02.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 02:50:34 -0700 (PDT)
From:   Raghu Halharvi <raghuhack78@gmail.com>
To:     linux-cxl@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        raghuhack78@gmail.com, ira.weiny@intel.com, bwidawsk@kernel.org,
        dan.j.williams@intel.com, vishal.l.verma@intel.com
Cc:     linux-kernel@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>
Subject: [PATCH v4 2/2] cxl/region: Remove else after return statement
Date:   Tue,  9 May 2023 09:50:16 +0000
Message-Id: <20230509095016.138890-3-raghuhack78@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230509095016.138890-1-raghuhack78@gmail.com>
References: <20230509095016.138890-1-raghuhack78@gmail.com>
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

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Raghu Halharvi <raghuhack78@gmail.com>
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

