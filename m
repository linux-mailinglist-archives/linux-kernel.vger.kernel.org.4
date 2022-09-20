Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C305BE8E8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 16:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbiITO2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 10:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbiITO2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 10:28:04 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 118C6226;
        Tue, 20 Sep 2022 07:28:04 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-127d10b4f19so4415748fac.9;
        Tue, 20 Sep 2022 07:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=eIBCdRZ91e6B9az9bnty9SmfU59aOEZQ/+8nwcyHTOw=;
        b=IyOmUaPi8ehKws+AiyBpdlKelCC9fvz2Voejsb65/WgZLtv10tIaPF8EveAV8DdBgx
         xHlwwmd/mwufZtvPfcy+aLzer76SvgdASR27mRr9X+BXDsI+j4Eec4NmT4KWaZK4mhYu
         a+BmtSO+lqioiXkOcQWiogrx0rhNq3p1WtBiiafa/iO+9CQiGaIVbvoHnTB1ejGGK6M3
         IlTLKEPfGWi8qzTeBIr3J4QgeHj5gBmYjRyqAhIlFrve2HEyORNsaKVJAb35VOHpR87Y
         F4W2KCMijl+K7/OqhcdkKRkqRg0ej/mFwbaKc/0MmIsSxMswFcoBdyKCzljLkpOvRJNi
         G6VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=eIBCdRZ91e6B9az9bnty9SmfU59aOEZQ/+8nwcyHTOw=;
        b=eQ/dyWUPTOY3KfRuQkwWANXCz3IwrW+I4V20UwDD6ojyugvhWRvukAbIN9GSnVTLiD
         NY+7mPQW5WaeXKtfU98FU2aQLCoHiCAqOPClj/RKX/izBWF0rXsj6LdGIDCPzmmradBr
         OYQVb3R/q0IyQJ/clZL26UgxgEIl+fSg8RO+X9mh2WKSgLVNwcpCCe9t7KQwpNOAdfZl
         0Sj6hmc2MlIuvr9D4IDxxi+dVYPkY0UfnB0A77FMv6WQ1lyy4smt7yvCBVT8eVzmRrg2
         EB4XfS+h/2aZ/i8aQxLbDpAI/OE3jRLL0L7y2qxqmiHRYEydYhmyms6xRBz7t0tDdK9q
         WK+A==
X-Gm-Message-State: ACrzQf2A1GwO2yRaAbcDjTuUCFPeUtRAD+OhB1F93X9sCsR15GfRq2eM
        Y0zZHZ/IT6G9KoKJS5lvo2qLnTeaAEQ2Vg==
X-Google-Smtp-Source: AMsMyM7BPX3OjSWMrCTfcCxF36VS5tVznjT+tOzXDN85FdBggDWFZNPUtVIE0Ifev7tysBfxJ0bOPw==
X-Received: by 2002:a05:6870:b508:b0:12d:1c59:90d9 with SMTP id v8-20020a056870b50800b0012d1c5990d9mr2256678oap.199.1663684083277;
        Tue, 20 Sep 2022 07:28:03 -0700 (PDT)
Received: from macondo.. ([2804:431:e7cc:3499:63b7:66da:c087:3355])
        by smtp.gmail.com with ESMTPSA id l7-20020a056830268700b0065a193c08absm42860otu.34.2022.09.20.07.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 07:28:02 -0700 (PDT)
From:   Rafael Mendonca <rafaelmendsr@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Rafael Mendonca <rafaelmendsr@gmail.com>,
        Tommaso Merciai <tommaso.merciai@amarulasolutions.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] media: i2c: ov5648: Free V4L2 fwnode data on unbind
Date:   Tue, 20 Sep 2022 11:27:48 -0300
Message-Id: <20220920142749.738715-1-rafaelmendsr@gmail.com>
X-Mailer: git-send-email 2.34.1
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

The V4L2 fwnode data structure doesn't get freed on unbind, which leads to
a memleak.

Fixes: e43ccb0a045f ("media: i2c: Add support for the OV5648 image sensor")
Signed-off-by: Rafael Mendonca <rafaelmendsr@gmail.com>
Reviewed-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
Reviewed-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
v1->v2
- Remove empty line before call to free
---
 drivers/media/i2c/ov5648.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/i2c/ov5648.c b/drivers/media/i2c/ov5648.c
index dfcd33e9ee13..220c53565b0a 100644
--- a/drivers/media/i2c/ov5648.c
+++ b/drivers/media/i2c/ov5648.c
@@ -2597,6 +2597,7 @@ static int ov5648_remove(struct i2c_client *client)
 	v4l2_ctrl_handler_free(&sensor->ctrls.handler);
 	mutex_destroy(&sensor->mutex);
 	media_entity_cleanup(&subdev->entity);
+	v4l2_fwnode_endpoint_free(&sensor->endpoint);
 
 	return 0;
 }
-- 
2.34.1

