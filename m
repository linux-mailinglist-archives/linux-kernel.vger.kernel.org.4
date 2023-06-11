Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7ADF72B230
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 16:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233899AbjFKOFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 10:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233724AbjFKOE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 10:04:28 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC240173B
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 07:03:59 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f739ec88b2so24329335e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 07:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686492238; x=1689084238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rr9hRbhtZaRBUtrRcpiFIG9+NtiO1S0ZOMsMBmSECJw=;
        b=u7GYX1vpNQ9ffz1DcTwiFx4UzrOQwy/c1ndXFtnxEJoWlK6YXeXqyHq0S2JYcyx+Eu
         DkVxa36savku/3hxeUyd2Z/YhqbnXohpr6sdWV6mWM41IfodLbveUuBP+VADHCZU1/zS
         j5Nigjt4ivjtSlmT73PqDGO7pdUEBzWpHK3D8OcaJTP0L1zONKroJoMmyCDzWtN5xTaJ
         esCB4vVAX1xvxSv12kz4NxuHMBTmpK7hkvWnL3neD7Dbcd4DVIsfUWLdRpfAnxmo5Fc7
         2r/NlWIb5au6XLQ2pyJDQZ4Y1rqpRDdXyTTrJjj1rYMBI88/zvaYlXb7WfhSz6RS79Xj
         ZfiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686492238; x=1689084238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rr9hRbhtZaRBUtrRcpiFIG9+NtiO1S0ZOMsMBmSECJw=;
        b=dvOCQx6Wr6PZFJQSe3CgtdyVeG4lHLf4ABSPCXgojD7vyrXDY1oGV5Vsv03pHdgcBk
         5iCGzAGOuiWnd2G6TvH5+QYzjKulL/7VkD7fKVxFAJ1MujLocYs0QkQ2BxA3THHAQQyI
         +UaTGHLsAqZHmT8L0rs4LZ4RPgUL1IybZdC8PTKdOn7QpJwqgD89AlH0ck4OlSM9pBwh
         wC2i5kZm3WEi9b/fXWHC4b47jiZ+CMxZaYpq61sJjVFmD/YIAa5TU7dEzZlhfGt4OvQk
         N5wOvUhhjUih7zfgoD9d2mv6EKh6RqnBRILno14G7Eif8dp+pUMObEvhVVYRv3xkCYVm
         nfTA==
X-Gm-Message-State: AC+VfDxxgaxAvxt3tr3Wj7yMLq3QtbKUcQvcyhrybUk5DofVMLUmA/PZ
        n78PBbWzGodGL7vjcROa+f3GLR5tL3k2Hed6QbY=
X-Google-Smtp-Source: ACHHUZ57fBMjfyXxdeMd3qiTsIJUzdOIWSGyBy3AVn0lOz6SeAQiOHpI5hsFaWI69QQeJDI2/IHLSA==
X-Received: by 2002:a05:600c:3785:b0:3f4:2328:b5c2 with SMTP id o5-20020a05600c378500b003f42328b5c2mr4267361wmr.35.1686492238271;
        Sun, 11 Jun 2023 07:03:58 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id h17-20020a05600c28d100b003f080b2f9f4sm8567222wmd.27.2023.06.11.07.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 07:03:57 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Vincent Legoll <vincent.legoll@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 11/26] nvmem: rockchip-otp: Use devm_reset_control_array_get_exclusive()
Date:   Sun, 11 Jun 2023 15:03:15 +0100
Message-Id: <20230611140330.154222-12-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230611140330.154222-1-srinivas.kandagatla@linaro.org>
References: <20230611140330.154222-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

In preparation to support new Rockchip OTP memory devices having
specific reset configurations, switch devm_reset_control_get() to
devm_reset_control_array_get_exclusive().

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Tested-by: Vincent Legoll <vincent.legoll@gmail.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/rockchip-otp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/rockchip-otp.c b/drivers/nvmem/rockchip-otp.c
index b62e001f9116..439aea1f8874 100644
--- a/drivers/nvmem/rockchip-otp.c
+++ b/drivers/nvmem/rockchip-otp.c
@@ -263,7 +263,7 @@ static int rockchip_otp_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	otp->rst = devm_reset_control_get(dev, "phy");
+	otp->rst = devm_reset_control_array_get_exclusive(dev);
 	if (IS_ERR(otp->rst))
 		return PTR_ERR(otp->rst);
 
-- 
2.25.1

