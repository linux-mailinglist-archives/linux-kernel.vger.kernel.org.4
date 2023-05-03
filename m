Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0AB16F557C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 11:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjECJ62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 05:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjECJ6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 05:58:25 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA543C01
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 02:58:22 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2ac7707e34fso2443651fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 02:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1683107901; x=1685699901;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tBpbf4XISWJtBVaZwAOtHjLjUmCzvCogGOFBVPRRTeM=;
        b=eC+qsf6xglZKV7CIhF7hjQId46jGm5iibiBcAS5+hNCOFLrwCctuk9zhKSQhP11MG4
         FzzE7GtFUQPe3xg3H3NsE7+/BtBNwb9JiONgBSJXQxJM/ii3584RhveoKLDUc/ta991P
         FUPi3lYbvlSeajspGQTA+hsRtnQ4fGnu0QzRY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683107901; x=1685699901;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tBpbf4XISWJtBVaZwAOtHjLjUmCzvCogGOFBVPRRTeM=;
        b=bHiK7cPZ0qAJcPQ/QsVR0JRBjTLQ17VXeff5pPMbq94AiIMYHvk+MNYYAlyPn9FzTC
         2+hpw44tCo1QaFhu/c91lZgUC/Efp+BjKf9C/Av9/KGJpfmYCKH/tRDmTyzR6Tec6rAm
         aiT/mh1EzX6Ni1XSYXAxLUlZMgEV1Ogds+Mkp6F4/qgp/zxwztEU5jk92ieH1dJ80sYX
         TtdgfDL8NDcpU9FKQJ+HiuQWqhi/X9OgpWM83QCcD0yy54mO1d/3ZCTVJmhFkFRRbw69
         D+WtVQHCwVkL37BtX510sci4HZB967pO+VuUHUs1TU9BaQ5/KnLuKFIySdHPyQOm3gOZ
         aLjg==
X-Gm-Message-State: AC+VfDwTl+L3Nc+2azHj1mmSl2tQ86FEuY6D5/EhungfzLtxMoc9ewcF
        Ts7zRtXB+ob3/4WZ3JrFfRw6sQ==
X-Google-Smtp-Source: ACHHUZ55GS6xfViVrIMSKR3rL04uqNDXxkXbVQ848BwHSw2kedpGC8skunVtYg7im52sUoxJ3dvnaA==
X-Received: by 2002:a2e:b0eb:0:b0:2ac:767c:ae14 with SMTP id h11-20020a2eb0eb000000b002ac767cae14mr231428ljl.19.1683107900758;
        Wed, 03 May 2023 02:58:20 -0700 (PDT)
Received: from prevas-ravi.k200.local ([87.54.42.112])
        by smtp.gmail.com with ESMTPSA id b10-20020a2e988a000000b002ac77768608sm74050ljj.100.2023.05.03.02.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 02:58:20 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: addac: ad74413: fix resistance input processing
Date:   Wed,  3 May 2023 11:58:17 +0200
Message-Id: <20230503095817.452551-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On success, ad74413r_get_single_adc_result() returns IIO_VAL_INT aka
1. So currently, the IIO_CHAN_INFO_PROCESSED case is effectively
equivalent to the IIO_CHAN_INFO_RAW case, and we never call
ad74413r_adc_to_resistance_result() to convert the adc measurement to
ohms.

Check ret for being negative rather than non-zero.

Fixes: fea251b6a5dbd (iio: addac: add AD74413R driver)
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/iio/addac/ad74413r.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/addac/ad74413r.c b/drivers/iio/addac/ad74413r.c
index 07e9f6ae16a8..e3366cf5eb31 100644
--- a/drivers/iio/addac/ad74413r.c
+++ b/drivers/iio/addac/ad74413r.c
@@ -1007,7 +1007,7 @@ static int ad74413r_read_raw(struct iio_dev *indio_dev,
 
 		ret = ad74413r_get_single_adc_result(indio_dev, chan->channel,
 						     val);
-		if (ret)
+		if (ret < 0)
 			return ret;
 
 		ad74413r_adc_to_resistance_result(*val, val);
-- 
2.37.2

