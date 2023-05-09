Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 723FC6FCBC4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 18:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234694AbjEIQwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 12:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234567AbjEIQwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 12:52:44 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F5F5262;
        Tue,  9 May 2023 09:52:38 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-24df4ef05d4so5498548a91.2;
        Tue, 09 May 2023 09:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683651157; x=1686243157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eZGNkwcKrfK6pQ6D6N1O4LbckY0KJJq0dY3vsTxwcyE=;
        b=AGyY3WW2FBb4ew7iD+Ep/FDnd4nymRYk0dx7wapzvRvgYFE/mCxPhometBJIMToJp0
         XYUaM6mYNZDJdPc44pHh/juPGKoQAU19mgg6yTldNptpjoQzgKqeL1MVMCl71cT+t+0k
         RznVihQBSYOnj82r/NfR1n+7XRZ9LLXLCXSgxlv6dU2bezps+t48ksAGP1+7f1ohvKwe
         rbHFAR0s3hRKO4pBraKJ6nJN8vrtVSBzQbcgYtYuNh+LYyN3FYhPQoez7jv5oI8rAlFd
         vyiwLgS5kceagWtGi2XglIRrxeLEnJz8IACWpif+kPFRfbGGnLWzVg4wF4hc1TCL2yqr
         YW8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683651157; x=1686243157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eZGNkwcKrfK6pQ6D6N1O4LbckY0KJJq0dY3vsTxwcyE=;
        b=TQHPBg3n3S2WByGMg6EeMBVmYLqFPb87smeGVM1u7teVg0DcSUQDia0fwaWFGpPPJW
         ehgxQR16kItsusoUXAa0Da10y8/w8CWNOUTilZoGcPP6+ZykpkAESc1WkVk00Ttw+BPw
         SYntQciGzjRDEjo2c+GBa4GmHxGTqouTqJxlt84wC44zLnrlwzsQ31B5xmR8+LSQmtQ4
         qoa9tyWGfgfWCG3m8Ev+RSBb2udNXPN8Vzb6IcN3zZ740uTYGipJC3zVSk/m+Lqib3+a
         v8wL9D9fShOmfzW08MxgMNBrHmq/1SqeRGQ/h12gZ1sH6cymWiG8vzhtQX9wkLUGPmq3
         NuCQ==
X-Gm-Message-State: AC+VfDxAPJBUlVEnqwsSKha9CZNXUVZaA/wHZA1jkpyWdDgYGB9RYGsv
        y595t2qDD7+Iy1GTWnERuNlHjcMwiok=
X-Google-Smtp-Source: ACHHUZ6VFYARzED19gr6KhnH3Y0j9WNvGj1L9u8aYvUf37vsMdj1rHkYjVj2jlB8EBfb/B6n7ksk9g==
X-Received: by 2002:a17:90a:608f:b0:24e:3b69:a87f with SMTP id z15-20020a17090a608f00b0024e3b69a87fmr14040121pji.25.1683651157268;
        Tue, 09 May 2023 09:52:37 -0700 (PDT)
Received: from cxl-test.. ([103.181.222.211])
        by smtp.gmail.com with ESMTPSA id lw6-20020a17090b180600b002505f8b9c53sm5503986pjb.38.2023.05.09.09.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 09:52:36 -0700 (PDT)
From:   Raghu Halharvi <raghuhack78@gmail.com>
To:     linux-cxl@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        raghuhack78@gmail.com, ira.weiny@intel.com, bwidawsk@kernel.org,
        dan.j.williams@intel.com, vishal.l.verma@intel.com
Cc:     linux-kernel@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>
Subject: [PATCH v5 2/2] cxl/region: Remove else after return statement
Date:   Tue,  9 May 2023 16:52:17 +0000
Message-Id: <20230509165218.139568-3-raghuhack78@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230509165218.139568-1-raghuhack78@gmail.com>
References: <20230509165218.139568-1-raghuhack78@gmail.com>
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
Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>
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

