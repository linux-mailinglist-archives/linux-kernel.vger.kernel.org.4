Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D2D734092
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 13:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234769AbjFQLjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 07:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234346AbjFQLj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 07:39:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF161BD1
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 04:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687001923;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=e4oaFvu+oLj9clZTX2+t/9r2R/dvlWv5GxKJkZqu9ZE=;
        b=fzcx5UiN6Gt9YSWLG7K8CU//PFGhBgEvvwL9E6OGpKq/A1szHHlPr7fJVdhAr7iBJPiJqf
        e2MbhMnxcBPANV9qXjVdnHvi23h3xWRXrqFJQe3KkatLXpgzBKd/7ajmdFSMeCSctxnL65
        AWBxtZmThUf/8xzfIqBJlBVt7i381BA=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-6-oB5WbZM-CT0hZX8tIHlA-1; Sat, 17 Jun 2023 07:38:41 -0400
X-MC-Unique: 6-oB5WbZM-CT0hZX8tIHlA-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6300c2a972cso5138306d6.1
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 04:38:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687001921; x=1689593921;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e4oaFvu+oLj9clZTX2+t/9r2R/dvlWv5GxKJkZqu9ZE=;
        b=H7yj2+H/Ue+POVsrE6JJ/UTQEvS/bMgJ4uCHwLyA6pDy2R8FUyLph1OqFWY/oEZIGQ
         cJBvHRHAwz8nmr3RSwH6gvEoJNik1MSLVuIAR4LUvWq7z1O6/SWB7hcwVKV/V0bvmd5P
         L9azBn1XWtoMuAn2pOXBuzlDzH7UGHWSjVyMBSrgd7AaCKtNCn0eFgNdUgAIfz+HHEv7
         C/fyTiXLuwNdQPud9x4KyqA6UMT3xjKmBlZhIqGTozvbQ6hFFm6XAhCO+Jpz8KUtpjYW
         0dCig0NEG9VVF2xIna4BJJ0BpWT6TNXgAYzsHEQWxwqnAFn0oJ/JKOILNmLtWPh3m+2V
         ACFQ==
X-Gm-Message-State: AC+VfDweq+4VY/XyauLY3ZcaNbxSrHGFFvRZu+wosUO0THNX4V7VJNIc
        BkIRtiQ21ELm5ROKF6dwLYMXw/sZqzI8hVcWygB2QAxIkfUCADZpAqbQ7bR67t15mxUsQ3lMM6L
        DAEhZq9qVk2m17uiHXnvBaT4d
X-Received: by 2002:a05:6214:2484:b0:62f:ff5c:6b3e with SMTP id gi4-20020a056214248400b0062fff5c6b3emr5080941qvb.34.1687001921412;
        Sat, 17 Jun 2023 04:38:41 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7kAPxY0P/+pHsf5eYAttHB/VT0n+7jpgTnH2PyzRpW3fTXbo/JyZj81xki2cMCorIp/25kfQ==
X-Received: by 2002:a05:6214:2484:b0:62f:ff5c:6b3e with SMTP id gi4-20020a056214248400b0062fff5c6b3emr5080918qvb.34.1687001921169;
        Sat, 17 Jun 2023 04:38:41 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id s15-20020a0cdc0f000000b006300e1db3ecsm363670qvk.141.2023.06.17.04.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jun 2023 04:38:40 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        amitk@kernel.org, thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] thermal/drivers/tsens: remove unused variable ops_v0_1
Date:   Sat, 17 Jun 2023 07:38:37 -0400
Message-Id: <20230617113837.3224912-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc with W=1 reports
drivers/thermal/qcom/tsens-v0_1.c:328:31: error:
  ‘ops_v0_1’ defined but not used [-Werror=unused-const-variable=]
  328 | static const struct tsens_ops ops_v0_1 = {
      |                               ^~~~~~~~

This variable is not used, so remove it.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/thermal/qcom/tsens-v0_1.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
index a941b4241b0a..0caf4628582c 100644
--- a/drivers/thermal/qcom/tsens-v0_1.c
+++ b/drivers/thermal/qcom/tsens-v0_1.c
@@ -325,12 +325,6 @@ static const struct reg_field tsens_v0_1_regfields[MAX_REGFIELDS] = {
 	[TRDY] = REG_FIELD(TM_TRDY_OFF, 0, 0),
 };
 
-static const struct tsens_ops ops_v0_1 = {
-	.init		= init_common,
-	.calibrate	= tsens_calibrate_common,
-	.get_temp	= get_temp_common,
-};
-
 static const struct tsens_ops ops_8226 = {
 	.init		= init_8226,
 	.calibrate	= tsens_calibrate_common,
-- 
2.27.0

