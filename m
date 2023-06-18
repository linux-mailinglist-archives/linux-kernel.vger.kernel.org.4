Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99D99734524
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 08:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbjFRGsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 02:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjFRGsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 02:48:19 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76AFE5E;
        Sat, 17 Jun 2023 23:48:18 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id 006d021491bc7-558cf19575dso1758107eaf.3;
        Sat, 17 Jun 2023 23:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687070898; x=1689662898;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LTo1KCmoI+3M46rfBk4X9GJE9+liBm16LyxJ6tR7Fxc=;
        b=oY3btrBjo/LfqdGWh6E6EVUrJi/7vM+uTKPjlDUnBvX2yE07x4jZct56Gnl8WB81WN
         QAzV0LxE5EC4KhkpeeCMC3juCYCBg4hUsuZrKS0R4yRB1l3Qb7Al5NntC1476q5LAF5V
         GBm+aG4BRUwH8cuaareS5WOGMRyU47aHPjbDZnWPQkoh9Ju0+VxZEojK8B6FH5Vuqevk
         bk6Pxl7fWmqFJphL7WoqHdVRsHQp4ooeAkKUYrA+7WLtxgObkQAzBkJLRNdFDhaq+JOA
         aEs8yLFH8FgSaiodu9tPI0E7nPX9zboJTts9lnQY9W+bRqW12qNweuDq5vsPfGYuasDS
         p9mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687070898; x=1689662898;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LTo1KCmoI+3M46rfBk4X9GJE9+liBm16LyxJ6tR7Fxc=;
        b=iMkkM4xD7W5J9RWlvCigTbRSwQb7cvc3zXPpS8LRP6JTtzjUeXiOtY+OeTbINrG07Y
         4jKtHVbz2oRaKxI1EiLi5tR+e27T1fb+5viFxpQ9QkpaK5UE72oL+PZvv/04nrO3wVlU
         ytwXgTiPVnKpFYOEh4+5wp2I3pYivNQ7I1klXVxPb5qBbqEdoMF1NDzHguLUeUdjBvw3
         d9rePR4hyzcoRr/MGiQdqXfxxBJc9OwaICcngl8Lbk52cn64StRoLs0KvMZOiF+4hEui
         NXLj9lhLkNYT70PhPt9QQG4EjjgpzJQLSrahptN0GzDqBwAdhZWkRqG0+plnebY6Cr62
         N0ug==
X-Gm-Message-State: AC+VfDzSjhVGLzNJ4g74ZAjygdsPegGKGZ+tYrff0yuv9T5MserEJuv6
        FhMehRdbFsEs0shInjIGrSM=
X-Google-Smtp-Source: ACHHUZ7VGsWXSPSZpioEsUzxOniWvUcGzZsx86ZogwaxQv95Qm4aWDEuaEYwcOcvyYSfsNbxe+o7iw==
X-Received: by 2002:a05:6808:300f:b0:39a:bd0e:43d with SMTP id ay15-20020a056808300f00b0039abd0e043dmr10012266oib.36.1687070897840;
        Sat, 17 Jun 2023 23:48:17 -0700 (PDT)
Received: from ubuntu777.domain.name (36-228-68-11.dynamic-ip.hinet.net. [36.228.68.11])
        by smtp.gmail.com with ESMTPSA id n6-20020a1709026a8600b001a0448731c2sm18217909plk.47.2023.06.17.23.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jun 2023 23:48:17 -0700 (PDT)
From:   Min-Hua Chen <minhuadotchen@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Min-Hua Chen <minhuadotchen@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] remoteproc: qcom_q6v5_pas: make adsp_segment_dump static
Date:   Sun, 18 Jun 2023 14:48:12 +0800
Message-Id: <20230618064812.230265-1-minhuadotchen@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following sparse warning:

drivers/remoteproc/qcom_q6v5_pas.c:108:6: sparse: warning: symbol
'adsp_segment_dump' was not declared. Should it be static?

No functional change intended.

Signed-off-by: Min-Hua Chen <minhuadotchen@gmail.com>
---
 drivers/remoteproc/qcom_q6v5_pas.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index e34d82b18a67..f77d11c91a75 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -105,7 +105,7 @@ struct qcom_adsp {
 	struct qcom_scm_pas_metadata dtb_pas_metadata;
 };
 
-void adsp_segment_dump(struct rproc *rproc, struct rproc_dump_segment *segment,
+static void adsp_segment_dump(struct rproc *rproc, struct rproc_dump_segment *segment,
 		       void *dest, size_t offset, size_t size)
 {
 	struct qcom_adsp *adsp = rproc->priv;
-- 
2.34.1

