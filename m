Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 778B66C24AF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 23:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbjCTWUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 18:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjCTWUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 18:20:20 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73184FF0D
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 15:18:36 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id y35so6359575pgl.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 15:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679350712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lFdP+n8hU6K/nm3EJ5X3exiUwV1teDwsbi7RZq6Ti4k=;
        b=mKWIQ1ued3KEIaaBhwWod6mpPzfwB+wmMWyZoPsGGBMeDOGU7TYzTm2o3cJ9dnwAv/
         H9jxCA8OWqVyyYcl7cNSERbaSFiEFFfkCV1+RQoO0RJvzpf5q+5YzEjgMUopmX1iOPzX
         qAVeRnj6/xRg/tbaW6zpvDe7UqWeBIaOZYNCqw+rCytUeuLzYCPbVGL60OEXvmUNOwZb
         GY7ePqkHVmh3woTxGbb7effv4zNLlp7OA1fy43QmdhgDI8lhZqZGh+tcUJnCGBg066d9
         YjDKm+OMB90mEFr0Kyhj55ciUpTOFSbSoclC063Lw4ZNDDP7qRLOH3ZYTuyxGkxtpOhE
         FGRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679350712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lFdP+n8hU6K/nm3EJ5X3exiUwV1teDwsbi7RZq6Ti4k=;
        b=gyF2v+Nk5c44ZRbFaNUAOkfk7yvJlrIsQjEK3GaH7/JNWL/n23cUgD7MTHBMIln0Rp
         aEmVEhF/qjmh0uSFE+SnG7WUcFTgmtuEHktepJXc4+vIW3fbFjqYkIIoA+FsmD79Wqc7
         2CZRly6446+z3+sBfDjmFYJHzFiDwFQ7T1mbiJnMBzm8S/UnM5f/MnK/tcrm3S+kgkNA
         iSlYuk4OeaEipgJokP+ADjECo9WF3TC0B/sEY6KhnNbseFL0AKnQ/6snvqzmOGDw5K/G
         Xtj9/2vfOEB4YSDr6nBnU56NnnmG53rTfIQnvQiIrW2PaAMmHARsNlkCF3HyleLFKzSs
         O1hA==
X-Gm-Message-State: AO0yUKWAX3bhMALvGkk+TxLh+c4EOPX2KCeQHhWeozR3EWWLcDmcHC2b
        8lbmU00VomsNNS4wRVHfwRW93A==
X-Google-Smtp-Source: AK7set/MHng4ARlnTcxmx0ng1ZTOghx6afNW4lDFSbwHaS2XdaezdegyKPn0y+K3PxUIqlhmhyc4+Q==
X-Received: by 2002:aa7:9539:0:b0:627:e69c:8488 with SMTP id c25-20020aa79539000000b00627e69c8488mr340538pfp.14.1679350712244;
        Mon, 20 Mar 2023 15:18:32 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:4ab5:5131:bafc:4428])
        by smtp.gmail.com with ESMTPSA id e15-20020a62aa0f000000b006259e883ee9sm4459196pff.189.2023.03.20.15.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 15:18:31 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     andersson@kernel.org
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, patrice.chotard@foss.st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        arnaud.pouliquen@st.com, hongxing.zhu@nxp.com, peng.fan@nxp.com,
        shengjiu.wang@nxp.com, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] remoteproc: st: Call of_node_put() on iteration error
Date:   Mon, 20 Mar 2023 16:18:23 -0600
Message-Id: <20230320221826.2728078-3-mathieu.poirier@linaro.org>
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

Fixes: 3df52ed7f269 ("remoteproc: st: add reserved memory support")
Cc: stable@vger.kernel.org
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/remoteproc/st_remoteproc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/st_remoteproc.c b/drivers/remoteproc/st_remoteproc.c
index a3268d95a50e..e6bd3c7a950a 100644
--- a/drivers/remoteproc/st_remoteproc.c
+++ b/drivers/remoteproc/st_remoteproc.c
@@ -129,6 +129,7 @@ static int st_rproc_parse_fw(struct rproc *rproc, const struct firmware *fw)
 	while (of_phandle_iterator_next(&it) == 0) {
 		rmem = of_reserved_mem_lookup(it.node);
 		if (!rmem) {
+			of_node_put(it.node);
 			dev_err(dev, "unable to acquire memory-region\n");
 			return -EINVAL;
 		}
@@ -150,8 +151,10 @@ static int st_rproc_parse_fw(struct rproc *rproc, const struct firmware *fw)
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

