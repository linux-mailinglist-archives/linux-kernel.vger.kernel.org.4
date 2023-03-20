Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 732F16C24B3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 23:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbjCTWUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 18:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjCTWUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 18:20:24 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00B9193D2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 15:18:44 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id i15so3858749pfo.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 15:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679350716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=trrnan71ZHM7JKq0ql81PKKI2hb7rlyx27+ksKXBUrc=;
        b=f8qUTKDDglZJsgtv/KBhPEPSfsS/rDPVt7Q0ZvXfNE706If1SqJBI8NpCJq27Qo5gT
         DBGx99X/V+1V/tiTX54m6jRBxlszJZzogDlJCJTGTGIyxt6vbGwLhOM5KJqI9t04HNkL
         UQiy8VgJ1YxaLJ3QEbxjNGfDTUEzgR0koUy8jLa9VneY6PVluLfJvDPrLj+7E6CzK8OX
         MpFui5oS0O1cN+E/S3R2STlDyC4eSSr8INCk6CUcgeEVacgLh7uNNFy5QH/uMOp4VMzI
         m7UzrJVNthCu6l1D+R4JkUqPMcVo8xeHkhGJsyPEFhnBp5JUuQoLnCg4BemhWRypa75W
         GIHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679350716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=trrnan71ZHM7JKq0ql81PKKI2hb7rlyx27+ksKXBUrc=;
        b=gW3fWNJ3z2h7846DU+bQWUki+wg3Wr0UWSExWqZL7FmjH3+7/VGTcG8h/07u1RsKS0
         7PmuwTbNnScDSczBt49seaNmStCXSU348dRxMszE7UlbgWOlkZGP4hwNUOs5NYkonSLP
         aCr1etCFJ4nx+FQWzx+konCZcCjqAnJgyammEr2itNXA3Rl2uAKiLZB/EfYg3t/Y08aD
         4vplbZzc6eLBRNzBFtNztqGZeh9s8am35mxqWfHNq1w1kjo3bDhd9NKkHq4pImpK45t3
         A4MNT8eR24N6lV9jiiXcQYawypYIGlLC3Ul6pLvAYLqbCsW4gnnVxHnVwyI+OUrpT/Ol
         Nghg==
X-Gm-Message-State: AO0yUKVTjRZMzFGM6AImChuwm6lfTQ+KLTkTNfGUL0ZZupSyYv7BcYv5
        zlX/HZ/xaZ7QH3ztQPmzQbF/Ug==
X-Google-Smtp-Source: AK7set9+CAhMtLEgvAgzUcAfqrgmuEL7isu84NLQBw1S2LtfyWANSAlBjT/xveWdfYFLX4MYX/jmRQ==
X-Received: by 2002:aa7:9ae5:0:b0:627:fb1c:3af4 with SMTP id y5-20020aa79ae5000000b00627fb1c3af4mr342235pfp.21.1679350715864;
        Mon, 20 Mar 2023 15:18:35 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:4ab5:5131:bafc:4428])
        by smtp.gmail.com with ESMTPSA id e15-20020a62aa0f000000b006259e883ee9sm4459196pff.189.2023.03.20.15.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 15:18:35 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     andersson@kernel.org
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, patrice.chotard@foss.st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        arnaud.pouliquen@st.com, hongxing.zhu@nxp.com, peng.fan@nxp.com,
        shengjiu.wang@nxp.com, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] remoteproc: imx_rproc: Call of_node_put() on iteration error
Date:   Mon, 20 Mar 2023 16:18:25 -0600
Message-Id: <20230320221826.2728078-5-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230320221826.2728078-1-mathieu.poirier@linaro.org>
References: <20230320221826.2728078-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function of_phandle_iterator_next() calls of_node_put() on the last
device_node it iterated over, but when the loop exits prematurely it has
to be called explicitly.

Fixes: b29b4249f8f0 ("remoteproc: imx_rproc: add i.MX specific parse fw hook")
Cc: stable@vger.kernel.org
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/remoteproc/imx_rproc.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index 9fc978e0393c..0ab840dc7e97 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -541,6 +541,7 @@ static int imx_rproc_prepare(struct rproc *rproc)
 
 		rmem = of_reserved_mem_lookup(it.node);
 		if (!rmem) {
+			of_node_put(it.node);
 			dev_err(priv->dev, "unable to acquire memory-region\n");
 			return -EINVAL;
 		}
@@ -553,10 +554,12 @@ static int imx_rproc_prepare(struct rproc *rproc)
 					   imx_rproc_mem_alloc, imx_rproc_mem_release,
 					   it.node->name);
 
-		if (mem)
+		if (mem) {
 			rproc_coredump_add_segment(rproc, da, rmem->size);
-		else
+		} else {
+			of_node_put(it.node);
 			return -ENOMEM;
+		}
 
 		rproc_add_carveout(rproc, mem);
 	}
-- 
2.25.1

