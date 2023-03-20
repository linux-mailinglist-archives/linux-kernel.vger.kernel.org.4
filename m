Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5746C24AD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 23:20:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjCTWUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 18:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjCTWUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 18:20:16 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB3B1D937
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 15:18:31 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id om3-20020a17090b3a8300b0023efab0e3bfso17987509pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 15:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679350710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mPLmB3dzpBczm3qRE9s2V0X3S8uJO7/jVxWe+sb20rE=;
        b=VZXByqS8gHum2nUGLIN3iOP/iDUJ34c9r8a9Mm2c8bP2DU0bJMcb4l7vWherdXtZqv
         0Cx81BbLUunRRC50uVwkKjqcMCSvjwdPd+RQS3f5uNZQyFnwIV0zlT6f+M6/wqDAK4KE
         ZMq7MpX3CmWy/wW+7GZX3KR9NR2L9AG2XPpLcQ+0wfTLDchs92oD9mMmkumxD4Ktdzuh
         qiQRxVpo0tCBPTugl+oMPgO1IqmdhmZK4WpYVQqIEvGtTAyuc8QGoi61qMxwSKJPFKvf
         pq6iD/fs8VR9NYw6pbSR95vfLcju1ljWtDCYvl6rfd5tSTSxTZwp4pIB0UFbRv+622U8
         m4+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679350710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mPLmB3dzpBczm3qRE9s2V0X3S8uJO7/jVxWe+sb20rE=;
        b=SFPrIsPF//kiEYZQq1GxdViuVBQghqNt8wksW9Pe7dTZsrgeEM1DdngZDahu7wb7eT
         rwscNuW/+NIr/abMwj2QVvn/UdQG038dLK8YR0aGG5hMayt0asHzAznMb8Pl4iR/0qDC
         TeOrEvx5MDZTUk2Q6L0v1svZWh9wENGbow7kbHeeMGA+JT703PGH42FlRCOx253UM78+
         4rOCRbciQT6IT60/ckoLtEusqY/Q5/3noiaByYRgyOCfuRdB0vUoRB1KZgMrWTdVydMS
         OWfh9tkQJ/nWeVvte1PuFMEh5so4/pO3p6Lrjb5bb5kPEcaZJYUndxXWbFGYlYHxJDl5
         eUpw==
X-Gm-Message-State: AO0yUKV49/s+zmWFQvdaFX+9m3mV5miPuhYG8Ma9O1an9z5oSaMlE97p
        jn/skHjC91kBMz70514ufp2vvA==
X-Google-Smtp-Source: AK7set92de8kBYqLx5A0esQubvPjq2QNtxaJtiRr9ydQgC4/m0jxePjCzHFFNlbQqB9Lw07ypdHMsg==
X-Received: by 2002:a05:6a20:4f1f:b0:c2:fb92:3029 with SMTP id gi31-20020a056a204f1f00b000c2fb923029mr35523pzb.33.1679350710546;
        Mon, 20 Mar 2023 15:18:30 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:4ab5:5131:bafc:4428])
        by smtp.gmail.com with ESMTPSA id e15-20020a62aa0f000000b006259e883ee9sm4459196pff.189.2023.03.20.15.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 15:18:30 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     andersson@kernel.org
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, patrice.chotard@foss.st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        arnaud.pouliquen@st.com, hongxing.zhu@nxp.com, peng.fan@nxp.com,
        shengjiu.wang@nxp.com, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] remoteproc: stm32: Call of_node_put() on iteration error
Date:   Mon, 20 Mar 2023 16:18:22 -0600
Message-Id: <20230320221826.2728078-2-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230320221826.2728078-1-mathieu.poirier@linaro.org>
References: <20230320221826.2728078-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function of_phandle_iterator_next() calls of_node_put() on the last
device_node it iterated over, but when the loop exits prematurely it has
to be called explicitly.

Fixes: 13140de09cc2 ("remoteproc: stm32: add an ST stm32_rproc driver")
Cc: stable@vger.kernel.org
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/remoteproc/stm32_rproc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
index 7d782ed9e589..23c1690b8d73 100644
--- a/drivers/remoteproc/stm32_rproc.c
+++ b/drivers/remoteproc/stm32_rproc.c
@@ -223,11 +223,13 @@ static int stm32_rproc_prepare(struct rproc *rproc)
 	while (of_phandle_iterator_next(&it) == 0) {
 		rmem = of_reserved_mem_lookup(it.node);
 		if (!rmem) {
+			of_node_put(it.node);
 			dev_err(dev, "unable to acquire memory-region\n");
 			return -EINVAL;
 		}
 
 		if (stm32_rproc_pa_to_da(rproc, rmem->base, &da) < 0) {
+			of_node_put(it.node);
 			dev_err(dev, "memory region not valid %pa\n",
 				&rmem->base);
 			return -EINVAL;
@@ -254,8 +256,10 @@ static int stm32_rproc_prepare(struct rproc *rproc)
 							   it.node->name);
 		}
 
-		if (!mem)
+		if (!mem) {
+			of_node_put(it.node);
 			return -ENOMEM;
+		}
 
 		rproc_add_carveout(rproc, mem);
 		index++;
-- 
2.25.1

