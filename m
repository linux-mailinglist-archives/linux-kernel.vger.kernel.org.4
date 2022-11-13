Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77A14626F45
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 12:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233929AbiKML1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 06:27:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiKML1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 06:27:01 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF67FD1B
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 03:27:00 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id c2so7735428plz.11
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 03:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bwYxIawp/7otyMar5l7yZGIbqO8r/RtWl5Ye19uVvS4=;
        b=JyLu7BvM/6eV4Tqy2q3bfcpXIhAMTSBFulu/vrPgsdHcDzblDK7GF7ZJzCZDNSE68G
         d7OW9epr5z9ua0muUSqyiUMbCKWrq5dTTgrLD7+Pfrs0vT58s5nmUck2FSDaUoJqs86I
         K0U5Lm+1RjIeUXcXky9TAQ/USYmb0KmKfP/D8Ve7y0CfEvpkKJmdYezsqNGdg2Oq2vef
         wevzBM8h+iv8qrRxqPQK3XsL/rTNFPNoUU0O3Yf7quKxr57gNpmXNpM1Lv9MEhLXcpqI
         UBrz53cy047Fxx1imloqdLNRoxfhdQ1CWq9ldFa43roYjd2DwZp8/JVYemagb9pptQ4H
         AJ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bwYxIawp/7otyMar5l7yZGIbqO8r/RtWl5Ye19uVvS4=;
        b=PQ1eGU+agB0ZlAFKglMIR4eyrk7+g2GgCZVbrEcebdSMgZl2+znJO4AIhmK6RZgOW/
         i/L+tJca4BN2EJ2knEToIaZ9Qe7ymlUingkA9ezIabceJ12D6MFxka/ia3Yfg+3FQ0f4
         t935haZIfzc2ERleq/CQ9iuC5pa5vrrycvEZin7TM+h4hDZkBeEBFvEEDsk/eEggr8hC
         1IQ9bedHyNIu8bsi2uEEbKGZDoSmYxCtrqr6lU+rY06gO/oUPg+v/lMspOQakmTUXb18
         /tHMi5UzC1WG/izO45x2bWf4tzUf1r4GOXDtqMSwvyav+JpvEXQ4xqMKLdmN4Isck/IO
         3HKQ==
X-Gm-Message-State: ANoB5pkqhG2IMGL/WAGLwRL91KP3N+EfFU+4x+GQttwaK4oQ+XZTqFTh
        iIoK9Q+zCrNIZhYex4qeK4U=
X-Google-Smtp-Source: AA0mqf7H+CJf5MvzFcQhoxypQ8iGjsmf5cz8eE4OZwgEgEQVLvG4bCntBtXERqKfwsxuiy1N++SOUA==
X-Received: by 2002:a17:903:483:b0:186:a7f1:8d2b with SMTP id jj3-20020a170903048300b00186a7f18d2bmr9345221plb.137.1668338819432;
        Sun, 13 Nov 2022 03:26:59 -0800 (PST)
Received: from localhost.localdomain ([14.5.161.132])
        by smtp.gmail.com with ESMTPSA id q8-20020a170902dac800b0018725c2fc46sm4973943plx.303.2022.11.13.03.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 03:26:58 -0800 (PST)
From:   Kang Minchul <tegongkang@gmail.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
Cc:     nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org,
        Kang Minchul <tegongkang@gmail.com>
Subject: [PATCH] ndtest: Remove redundant NULL check
Date:   Sun, 13 Nov 2022 20:26:53 +0900
Message-Id: <20221113112653.12304-1-tegongkang@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This addresses cocci warning as follows:
WARNING: NULL check before some freeing functions is not needed.

Signed-off-by: Kang Minchul <tegongkang@gmail.com>
---
 tools/testing/nvdimm/test/ndtest.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/nvdimm/test/ndtest.c b/tools/testing/nvdimm/test/ndtest.c
index 01ceb98c15a0..de4bc34bc47b 100644
--- a/tools/testing/nvdimm/test/ndtest.c
+++ b/tools/testing/nvdimm/test/ndtest.c
@@ -370,8 +370,7 @@ static void *ndtest_alloc_resource(struct ndtest_priv *p, size_t size,
 buf_err:
 	if (__dma && size >= DIMM_SIZE)
 		gen_pool_free(ndtest_pool, __dma, size);
-	if (buf)
-		vfree(buf);
+	vfree(buf);
 	kfree(res);
 
 	return NULL;
-- 
2.34.1

