Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF6B5BDD5C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 08:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbiITGfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 02:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbiITGfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 02:35:11 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B7F5F7E1;
        Mon, 19 Sep 2022 23:33:05 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id i15-20020a17090a4b8f00b0020073b4ac27so1463229pjh.3;
        Mon, 19 Sep 2022 23:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=vhbOwJSDUYuRzvxtE8zipskqo4rv7Uj75crKwV3e0iw=;
        b=UXNsBcooe9CV7oF34Ltcymj8wrpt64YjVyGls8ZzzmAq6pW4hY4v1shjUuZhMdDWcK
         z65/k6rHQ2FswK2Oa588ia0i6kLMZwBZWn3qk1u6OJabOEG2pAbKDbXh9Q0yuP6WHzHj
         g430DrdIt9uAmrfqbRqY83dOtMkp9Ur8EcMCsvSQFm2e+MPK0XCtWy7dly5g1zTqTXiA
         VYR3GHifndta3hLq2JWdrwdtOExd/O7WqbbYJb3jI4uHkTcJD/1s6Wg+9dclcNKe6cqi
         OLlat0iPpKeacXrlYwrAyf/4FarTQUSCVXOFxtDKmcuzkuOfrXoXLjbjTc/Njk9GyD0L
         qlVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=vhbOwJSDUYuRzvxtE8zipskqo4rv7Uj75crKwV3e0iw=;
        b=O7TSNWppcKAam8UZeUILSyXOsjb884Ku0vEA/tS65BVUgoPNsEMEv4LYxbAASPZcHC
         ffOY700kseXpHGnie0a+ULc8dvtkXjtX8Dt0bkSN0aVgbMgnJYjFACriGsXj47TR3Pgf
         RoQLUkOn9eEGdHl4aE7373fIufqG0EDogv7BX+uR0ERCuPRDqZTaJq0EbYMA4iKjChag
         GOdlQfDqcAKS1l89f5W+Jtx5U+AUvzS9n8dbye76Pry5U6EBMFvQrfmJwsdR/82ppVh8
         R+9tzHa2+HzUGchpaL73UDHM2o/ga3obWOQXJfi1dJeQuxeD2X/0FvXmGyJdAfy+ywuy
         zRZA==
X-Gm-Message-State: ACrzQf0sJgTgI7dPloy5oJV8AKdIhi7w/5vrFh+YQATBrCYayfj81FGl
        /eTVRkkZg0rVXksfJItgzkc=
X-Google-Smtp-Source: AMsMyM5FW/IgJJkZRsjpbESbS/BJ59tE4hfou5pqEJwqF8YLbivlqRjzLSMlIS2nrAhVmOdtFa6pyQ==
X-Received: by 2002:a17:90b:3147:b0:203:6eaa:4894 with SMTP id ip7-20020a17090b314700b002036eaa4894mr2253934pjb.230.1663655577955;
        Mon, 19 Sep 2022 23:32:57 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id s17-20020a170902ea1100b0016edd557412sm517557plg.201.2022.09.19.23.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 23:32:56 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     herbert@gondor.apana.org.au
Cc:     thomas.lendacky@amd.com, john.allen@amd.com, davem@davemloft.net,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] crypto: ccp: Remove the unneeded result variable
Date:   Tue, 20 Sep 2022 06:32:52 +0000
Message-Id: <20220920063252.215144-1-ye.xingchen@zte.com.cn>
X-Mailer: git-send-email 2.25.1
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

From: ye xingchen <ye.xingchen@zte.com.cn>

Return the value ccp_crypto_enqueue_request() directly instead of storing
it in another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/crypto/ccp/ccp-crypto-des3.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/crypto/ccp/ccp-crypto-des3.c b/drivers/crypto/ccp/ccp-crypto-des3.c
index ec97daf0fcb7..278636ed251a 100644
--- a/drivers/crypto/ccp/ccp-crypto-des3.c
+++ b/drivers/crypto/ccp/ccp-crypto-des3.c
@@ -64,7 +64,6 @@ static int ccp_des3_crypt(struct skcipher_request *req, bool encrypt)
 	struct ccp_des3_req_ctx *rctx = skcipher_request_ctx(req);
 	struct scatterlist *iv_sg = NULL;
 	unsigned int iv_len = 0;
-	int ret;
 
 	if (!ctx->u.des3.key_len)
 		return -EINVAL;
@@ -100,9 +99,7 @@ static int ccp_des3_crypt(struct skcipher_request *req, bool encrypt)
 	rctx->cmd.u.des3.src_len = req->cryptlen;
 	rctx->cmd.u.des3.dst = req->dst;
 
-	ret = ccp_crypto_enqueue_request(&req->base, &rctx->cmd);
-
-	return ret;
+	return ccp_crypto_enqueue_request(&req->base, &rctx->cmd);
 }
 
 static int ccp_des3_encrypt(struct skcipher_request *req)
-- 
2.25.1
