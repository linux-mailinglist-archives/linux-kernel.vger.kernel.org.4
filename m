Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11C6D6E7857
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 13:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232558AbjDSLRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 07:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232724AbjDSLRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 07:17:14 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FA149EDD;
        Wed, 19 Apr 2023 04:16:42 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-63b4960b015so2634433b3a.3;
        Wed, 19 Apr 2023 04:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681902942; x=1684494942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ct0EwfRf0voCrFEqbmxJCbJeLzfDoba7OgIp+FO1WjY=;
        b=XCsKKkyEYFFRkMk6HScjJojoSQQEp5iESfLRH2ZjobzOGjvG/Dmf55Eyqyr3JVrgRM
         rrP15EnxnJZgXFvdlGkrhI9G2DztJJc8z70z9S295rqktadJfhphtbC3Nvhcssnn4qDG
         rcWVCswFtLWH6IO27BA2SUXRboa1Zg2z+D3PS/3lmxHdn6UK6q8+fmNeYI3TAo9JnDWg
         8JpVzrlsFNrfMgbiOvHXEpKGWYBqEsQV0ykxjFuLoIfz2VIQr6kr3aUTkcJAfH1txX5S
         Km9NvX0ZNSHphN2AFJ7M9Bg2cV5RwJ9K1fPExougi/oikeO6CAR+zACnSJYZndiVRENA
         hASg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681902942; x=1684494942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ct0EwfRf0voCrFEqbmxJCbJeLzfDoba7OgIp+FO1WjY=;
        b=d1jmJAl0X2EkbiiwrMfR385BkK7yrysGe10e4vCvqX+ba1FoEvyRI7RDjEyX2+kcfV
         awBk/hMaLLjMorNUoTHq/hxoo6Nd3GrU04NS/RuZkIaUMpn0XQf/N4wgTKjIcSJC/kvL
         HezfW23JNxnriGhvy3SBe3X+RVLUNkklysY/YZgofHmAUVVpv6ihFpO7ooBLzS8rDNPp
         tDVSR9b2Ikwb25028WA1m8qLP05gdy+tjqw0fy6Vx/VqlXAS2axy7cNb0aogMKaRL++3
         FOGOcOuy3ZQz2tb9Oa2C5uB5mwiyCSom9ZRmjJOwUr16M0Co0uoTG18LSGxhtPM27JFT
         /mGA==
X-Gm-Message-State: AAQBX9ckpT0eLrKrb+5l/Y+RGtmiKwVsb4GlHfBqlnBUvkC+n+p/+I6/
        JDG679LEC5OXFEpP2Bsirr00rM7LzLU=
X-Google-Smtp-Source: AKy350bVvj2NnO8cX9NptQ/pkC8mSvzPt8syY4FJbeCsWaTMb7WNJ3VI5MkkLFqG8iX8zN/aLw4jow==
X-Received: by 2002:a17:902:f945:b0:1a2:9dd8:d646 with SMTP id kx5-20020a170902f94500b001a29dd8d646mr4866313plb.54.1681902942569;
        Wed, 19 Apr 2023 04:15:42 -0700 (PDT)
Received: from cxl-test.. ([103.181.222.211])
        by smtp.gmail.com with ESMTPSA id o4-20020a170902bcc400b001a6566045ccsm11194914pls.192.2023.04.19.04.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 04:15:42 -0700 (PDT)
From:   Raghu H <raghuhack78@gmail.com>
To:     linux-cxl@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        raghuhack78@gmail.com, Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [STYLE v1 3/3] cxl/core/region:Remove else after return statement
Date:   Wed, 19 Apr 2023 11:14:43 +0000
Message-Id: <20230419111443.231151-4-raghuhack78@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230419111443.231151-1-raghuhack78@gmail.com>
References: <20230419111443.231151-1-raghuhack78@gmail.com>
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

The else section here is redundant after return statement, removing it.
Sanity and correctness is not affected due to this fix.

Signed-off-by: Raghu H <raghuhack78@gmail.com>
---
 drivers/cxl/core/region.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index f29028148806..1d695107b4a7 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2666,11 +2666,10 @@ static int cxl_region_invalidate_memregion(struct cxl_region *cxlr)
 				"Bypassing cpu_cache_invalidate_memregion() for testing!\n");
 			clear_bit(CXL_REGION_F_INCOHERENT, &cxlr->flags);
 			return 0;
-		} else {
-			dev_err(&cxlr->dev,
-				"Failed to synchronize CPU cache state\n");
-			return -ENXIO;
 		}
+		dev_err(&cxlr->dev,
+			"Failed to synchronize CPU cache state\n");
+		return -ENXIO;
 	}
 
 	cpu_cache_invalidate_memregion(IORES_DESC_CXL);
-- 
2.39.2

