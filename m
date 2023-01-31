Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34DEF683242
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 17:08:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbjAaQIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 11:08:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjAaQIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 11:08:40 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3553F2AE;
        Tue, 31 Jan 2023 08:08:39 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id k16so10710525wms.2;
        Tue, 31 Jan 2023 08:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1vIstjQmt2YAgqtPX4b9HdNOSKY8Ewx+pBvmKBYLirE=;
        b=Aatx73Y+I7DIm+vBlI2K2iI5Pkf5nt8ZpOW8eN37JJc8aa6RjrRAN56T7TUFZ3wdaD
         Kk93XUUmCcLuIcKUVjYy+xoeb4X4gONQanbn44UqG8OhWmujsMYASoY5ARnnzP65JAE0
         M71Dsodx1dvR+czkcEH5KxvFK7JtLgfZCBQsfYsibHHQDNcmXpLM8Fyes2UIj9qUOkxu
         JgxLYX2ZvUACKLF69sGKLEipqmT1YGl38Rv3tt2Re+0/sabdSdSiTThBQ1NMnZEAASCT
         p6krMbVYFCxDLoyMxPTI+9KQaAewuuaR2PjXGTAxnReZstxSAOGpv3zNPJRQZaFQnS/O
         HfZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1vIstjQmt2YAgqtPX4b9HdNOSKY8Ewx+pBvmKBYLirE=;
        b=Pqzbqa5tn7GB7dpgJ14v7EJo2UxovSSOl/8aao3jgAgzCEbWS3hD2kNeh9klA6UZSJ
         /2RODc7bjwDdbzYld3Kg8Lg2TE4E+iWX5Tx+JqWYb0mbkIfTQPKJEyiH504aaK/hGijN
         GYxYRUdSUqj7/7KiN7d1kdq9VxJ/GeFJKaXULHRyq/3VV4JND0qgyYrzc+lC+46YAQwK
         kQ0u65k/cyFehz3Xw9Og2Xht82VcxS66Q8owl8LUQ2GfyCpbliXFjKIKwVNuOv8iJkO1
         vPIWz+aQel/ud2gn16ttan5QNxTT01yEs2BDjH9sj+2aEqpN4DuO+pHsHo+Wg/rM+tJa
         EXmw==
X-Gm-Message-State: AFqh2kqTOTYdVoOsrPyCSEyx+ZvTQQCuF+Z5/AtU7mXO5606euAvdIyQ
        fnsMU/lnJVvGzQDE+Z14yOc=
X-Google-Smtp-Source: AMrXdXstLQzi/ypGtybtR9QaG9M+MlNHq65pstbxE9rPDe2ueHr0V5WWuCWPQH8j/XGdudYBD3M/+w==
X-Received: by 2002:a05:600c:35c1:b0:3db:1424:e781 with SMTP id r1-20020a05600c35c100b003db1424e781mr48888549wmq.23.1675181317796;
        Tue, 31 Jan 2023 08:08:37 -0800 (PST)
Received: from localhost.localdomain (93-34-88-241.ip49.fastwebnet.it. [93.34.88.241])
        by smtp.googlemail.com with ESMTPSA id ip7-20020a05600ca68700b003dc433bb5e1sm12622794wmb.9.2023.01.31.08.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 08:08:37 -0800 (PST)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>,
        kernel test robot <oliver.sang@intel.com>
Subject: [PATCH v2 2/2] clk: gate: Add missing fw_name for clk_gate_register_test_parent_data_legacy
Date:   Tue, 31 Jan 2023 17:08:29 +0100
Message-Id: <20230131160829.23369-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230131160829.23369-1-ansuelsmth@gmail.com>
References: <20230131160829.23369-1-ansuelsmth@gmail.com>
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

Fix warning for missing .fw_name in parent_data based on names.
It's wrong to define only .name since clk core expect always .fw_name to
be defined.

Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/clk-gate_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/clk-gate_test.c b/drivers/clk/clk-gate_test.c
index e136aaad48bf..a0a63cd4ce0b 100644
--- a/drivers/clk/clk-gate_test.c
+++ b/drivers/clk/clk-gate_test.c
@@ -74,6 +74,7 @@ static void clk_gate_register_test_parent_data_legacy(struct kunit *test)
 					    1000000);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, parent);
 	pdata.name = "test_parent";
+	pdata.fw_name = "test_parent";
 
 	ret = clk_hw_register_gate_parent_data(NULL, "test_gate", &pdata, 0,
 					       NULL, 0, 0, NULL);
-- 
2.38.1

