Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA53D6A26CF
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 03:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjBYC1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 21:27:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjBYC07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 21:26:59 -0500
Received: from mail.nfschina.com (unknown [42.101.60.237])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B111D703B5;
        Fri, 24 Feb 2023 18:26:49 -0800 (PST)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 4D51F1A00AB6;
        Sat, 25 Feb 2023 10:27:29 +0800 (CST)
X-Virus-Scanned: amavisd-new at nfschina.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (localhost.localdomain [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id f2tf31PPdTLl; Sat, 25 Feb 2023 10:27:28 +0800 (CST)
Received: from localhost.localdomain (unknown [111.193.131.207])
        (Authenticated sender: kunyu@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 3BD691A00AB3;
        Sat, 25 Feb 2023 10:27:28 +0800 (CST)
From:   Li kunyu <kunyu@nfschina.com>
To:     linus.walleij@linaro.org
Cc:     davem@davemloft.net, herbert@gondor.apana.org.au,
        kunyu@nfschina.com, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        lionel.debieve@foss.st.com, mcoquelin.stm32@gmail.com
Subject: Re: [v2 PATCH] crypto: stm32 - Save and restore between each request
Date:   Sat, 25 Feb 2023 10:26:26 +0800
Message-Id: <20230225022627.8275-1-kunyu@nfschina.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <CACRpkdZe3cMMxJesD0mpqHTwvuWHjSGVHsiFUQQyuA+VWknMTQ@mail.gmail.com>
References: <CACRpkdZe3cMMxJesD0mpqHTwvuWHjSGVHsiFUQQyuA+VWknMTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


hello senior:
    I understand the new patch and probably know where to add these two functions.
 
> +static int stm32_hash_one_request(struct crypto_engine *engine, void *areq)

+	if (rctx->flags & HASH_FLAGS_INIT) {
+		u32 *preg = rctx->hw_context;
+		u32 reg;
+		int i;
+
+		if (!hdev->pdata->ux500)
+			stm32_hash_write(hdev, HASH_IMR, *preg++);
+		stm32_hash_write(hdev, HASH_STR, *preg++);
+		stm32_hash_write(hdev, HASH_CR, *preg);
+		reg = *preg++ | HASH_CR_INIT;
+		stm32_hash_write(hdev, HASH_CR, reg);
+
+		for (i = 0; i < HASH_CSR_REGISTER_NUMBER; i++)
+			stm32_hash_write(hdev, HASH_CSR(i), *preg++);
+
+		hdev->flags |= HASH_FLAGS_INIT;
-------------------------------------------------------------
Add functions:
		pm_runtime_mark_last_busy(hdev->dev);
        	pm_runtime_put_autosuspend(hdev->dev);
-------------------------------------------------------------
+	}
+

There is another place:

> @@ -442,6 +441,18 @@ static int stm32_hash_update_cpu(struct stm32_hash_dev *hdev)
 			hdev->flags |= HASH_FLAGS_OUTPUT_READY;
 			err = 0;
 		}
+	} else {
+		u32 *preg = rctx->hw_context;
+		int i;
+
+		if (!hdev->pdata->ux500)
+			*preg++ = stm32_hash_read(hdev, HASH_IMR);
+		*preg++ = stm32_hash_read(hdev, HASH_STR);
+		*preg++ = stm32_hash_read(hdev, HASH_CR);
+		for (i = 0; i < HASH_CSR_REGISTER_NUMBER; i++)
+			*preg++ = stm32_hash_read(hdev, HASH_CSR(i));
+
+		rctx->flags |= HASH_FLAGS_INIT;
-------------------------------------------------------------
Add functions:
		pm_runtime_mark_last_busy(hdev->dev);
        	pm_runtime_put_autosuspend(hdev->dev);
-------------------------------------------------------------
 	}

