Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BAF8723B49
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 10:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236238AbjFFIVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 04:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236165AbjFFIV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 04:21:29 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C93CE8
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 01:21:28 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f70fc4682aso50253695e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 01:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686039687; x=1688631687;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dkb7K4StnKyUjyVkKmBhJSVtp9R5+nxnmnxLzZaoi6w=;
        b=rhUgvkH5GQYV1LSKhWNnnqP5gDkgzCN0Uk7ZZu1BcKEJ0r8VW/+CMtHkEnScUr5r0w
         PHxBHuJZvNz4ebw+kqDIajqx820jmkb1x+sycocmoGs2S/qNdmThLgHver2tFCwsqkHi
         5ZgCb4s6IjYhM7YBM+nv8AkyZ5C0CdDNuozNkgqzVl98vx472j28SDngUtDiOB4gUTC9
         Fam2iP0hvtVHweUYpAbf2SvJr8bp29Pmp1eCSCNtzHTd0yNyt89T52Z9xuvZl59WOQ3o
         16kPqyFLDX9iDIlKTZEny/V9tTM2OQzbwblpAVzwijWltjW1O+uKZSEiQ/rcCPwKFE7t
         xSgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686039687; x=1688631687;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dkb7K4StnKyUjyVkKmBhJSVtp9R5+nxnmnxLzZaoi6w=;
        b=ayFEKklvAw/GtNjVOqM12drfoMZPLw6mZ/XCTjdWqJIoKO6eKgG8vMqfpPY8O3ZMxx
         MbkLBvuLYAKHYoy6vAjOIFBaTpylkidjm5IX8sXuomDEKUyExOk7l4xKoTpA2YMNsvlX
         hl8GC4CRRp8bJix9uAPCkIk4Wi669wgMoer3aLCXl+CbZ5prOSrHiCttg9MocLlWL3Qk
         MGJgcWb/mKm3N2MHMXpXdQCl80TDEIiVP7deRch8AhN2DkZ96ykkCx4gAPzLTUU4IHuY
         Jjyk/ZftBKMlMpExuqpcL7xCHUdaSPOtyrN+vku/YOtbF7TbIDhxd6HbLVuyg8uVJQQf
         YNJQ==
X-Gm-Message-State: AC+VfDxGBUc1Mi7v/uhCIJgoHb/vV9JXCBLqXy5lN+1Iysui9LuR9Jcg
        YG72kR7NXvYmSE/xvwIDMHhD5Q==
X-Google-Smtp-Source: ACHHUZ582VJN7tt1i9t/RVdnErvIR9E3CpAbm1nOMk9BRM+6GkV31FFnhRwclGusnapEapIej4vIYA==
X-Received: by 2002:adf:e5cf:0:b0:309:33c4:52e1 with SMTP id a15-20020adfe5cf000000b0030933c452e1mr1120986wrn.64.1686039687095;
        Tue, 06 Jun 2023 01:21:27 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id n2-20020a5d4c42000000b00306415ac69asm11781849wrt.15.2023.06.06.01.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 01:21:25 -0700 (PDT)
Date:   Tue, 6 Jun 2023 11:21:22 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] soc: qcom: Fix a IS_ERR() vs NULL bug in probe
Message-ID: <ZH7sgpLAN23bCz9v@moroto>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The devm_ioremap() function returns NULL on error, it never returns
error pointers.

Fixes: a77b2a0b1280 ("soc: qcom: Introduce RPM master stats driver")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/soc/qcom/rpm_master_stats.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/rpm_master_stats.c b/drivers/soc/qcom/rpm_master_stats.c
index 6dd98b9f7129..9ca13bcf67d3 100644
--- a/drivers/soc/qcom/rpm_master_stats.c
+++ b/drivers/soc/qcom/rpm_master_stats.c
@@ -105,7 +105,7 @@ static int master_stats_probe(struct platform_device *pdev)
 		}
 
 		data[i].base = devm_ioremap(dev, res.start, resource_size(&res));
-		if (IS_ERR(data[i].base)) {
+		if (!data[i].base) {
 			debugfs_remove_recursive(root);
 			return dev_err_probe(dev, -EINVAL,
 					     "Could not map the MSG RAM slice idx %d!\n", i);
-- 
2.30.2

