Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFB196E7C99
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 16:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232891AbjDSO1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 10:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232125AbjDSO1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 10:27:40 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3778310CB
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 07:27:11 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f086770a50so23475125e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 07:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681914427; x=1684506427;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pMc7fQBWe3Bi35jcVdXtRtvRDvXrcOa0szVfpwPrY64=;
        b=BcWZUFJCqODc0M0FT5cCKCyz2EiZMOm0KE0JFo7V1mXSKSXmBpLF70JtQmsutdDLCD
         WvDnVzkzICHEhVq+O4+XmnKQbybPAs+A89umGecQ8Dy1Qc1bF/skddnE3qR189uDM1JA
         7WaAshMHtFUv13tmKlFDN35bcRXO4cGbyht4e0WJ+BIalvWUyZwYkdynviGD25781O+C
         AxhW2dTfMcwhMfpcnEFc7qs4KdaStHRdFmRxyExj/0jM1y4QMKDNWTVS2yrERaTPucdl
         RJ8udrHkxvWBqGzZzw9Q12isHHIDPbdz9DAd+Wt4mZfJnpwftKRCAZ2TR8B8M66WH71z
         BTWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681914427; x=1684506427;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pMc7fQBWe3Bi35jcVdXtRtvRDvXrcOa0szVfpwPrY64=;
        b=Rxk9dzbNFzyPfliCXFJzI5raqWA5NH1k/VccKpaglDl+jXni0gfEEzlhru0PL7E8ew
         tSYYEvFnPIy08SDq+V6uFGSX2vIgkQ5ZkgCr/v8p2rpn2I7HTV/3s9jd58WAFekehHxH
         zrY4cZI+gUCbEjj6B605zytsCZeduZcgThtJxu4wDWpZgV8+i4pfejpJ2FljTNseCzq0
         PVmAKRzwQ0+2WE8zjR6IIHCZLixMtleqkbDGVNYQECELi23um/ej1ag22BOCCtMLUehP
         7B6WcIzIZjuYqmOwp9FxB+x5nHxOERcSz5L+1Kv2FhN7TQegnWzGgR8mXdMDCpIrbrN5
         kHjg==
X-Gm-Message-State: AAQBX9fae8BqU00f8O6fl531lZQ1TbqLlVYUetUFCBfsSt5bxqZhsVaS
        clso0dgd/mA8uhyZY+wfWgzlUw==
X-Google-Smtp-Source: AKy350btsIWsdW3cryVOdG6OR9UGS2MvnHBvrrbxUcJhqkZzqkyawjYBfWu10M6GgYZN7A6x7c0yUA==
X-Received: by 2002:a5d:66ca:0:b0:2fa:6e37:3d97 with SMTP id k10-20020a5d66ca000000b002fa6e373d97mr4382802wrw.54.1681914426881;
        Wed, 19 Apr 2023 07:27:06 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id h16-20020a05600c351000b003eddc6aa5fasm2392223wmq.39.2023.04.19.07.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 07:27:06 -0700 (PDT)
Date:   Wed, 19 Apr 2023 17:27:03 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Richard Gong <richard.gong@intel.com>
Cc:     Dinh Nguyen <dinguyen@kernel.org>, Alan Tull <atull@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Richard Gong <richard.gong@intel.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] firmware: stratix10-svc: Fix an NULL vs IS_ERR() bug in probe
Message-ID: <5f9a8cb4-5a4f-460b-9cdc-2fae6c5b7922@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The svc_create_memory_pool() function returns error pointers.  It never
returns NULL.  Fix the check.

Fixes: 7ca5ce896524 ("firmware: add Intel Stratix10 service layer driver")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/firmware/stratix10-svc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index bde1f543f529..80f4e2d14e04 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -1133,8 +1133,8 @@ static int stratix10_svc_drv_probe(struct platform_device *pdev)
 		return ret;
 
 	genpool = svc_create_memory_pool(pdev, sh_memory);
-	if (!genpool)
-		return -ENOMEM;
+	if (IS_ERR(genpool))
+		return PTR_ERR(genpool);
 
 	/* allocate service controller and supporting channel */
 	controller = devm_kzalloc(dev, sizeof(*controller), GFP_KERNEL);
-- 
2.39.2

