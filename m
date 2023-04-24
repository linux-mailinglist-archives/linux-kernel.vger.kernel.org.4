Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B98C96ED7C2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 00:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233304AbjDXWWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 18:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233267AbjDXWWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 18:22:43 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E0393E6;
        Mon, 24 Apr 2023 15:22:42 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-958bb7731a9so466163366b.0;
        Mon, 24 Apr 2023 15:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682374960; x=1684966960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yh9lumEkpeARra20zUI3XX4mAupJvGL3brx+659+U9U=;
        b=RuNCYqi6q3aeCvyZ8WU2zbiE3qdLNgDElaAhTMpOjPkMobuIs0jEHJG7Hxzo0EsI65
         8saTwqXqQ5JJdGTYcnn1cw4wxN8Ssvu6b+FdgidA34lF/cmJhG1tqjocKglmgcp0/4EG
         VOg9ppRA/EiJkha0DvcIZVyr0Y3x4/AD1wQ05ooIV0qsmBGZKWUiFmLOgCX0A4U6ebGP
         CHRE2O3023ZjjNJVytlTEtKLaCh1kjmUILK2HfE5xcB6SdSDb7ynFh6dVspFn3ucEHsO
         7pCqEZvaTv0IsvRHkPB31b4621gqF98jJvsufHqnkgLLlCV85VHDS0R0SdBlvHWKRgQc
         IVFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682374960; x=1684966960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yh9lumEkpeARra20zUI3XX4mAupJvGL3brx+659+U9U=;
        b=JKJk0ksqBWDGLDxRsAMqEocvj4omZtFfwq7f7OWqKBBxRBdKuJosJUPt4V8SnFvB9C
         Hh4Qb73dlvBkLYk8jX1oNjORm5LCT6F6NkCTyzAwBPwkgvnDkGgtAV1vAcpKuHm4+d/b
         qGr4jGJHOtblP0X19mpWL03vQVH7aYZGquzWmQOuWirhEa2q1Ou2BvdULSrD0B+d0ODW
         +TsAMclv3weM+RtcfcYNMeNNgYKcLptMqZs7iP8ra0RcI/bHLS7JSyqqCehTtmsPLlWu
         VfOXkiiF+lrTDsthB+ptADM1QsVHfpEd1Jzi0BPr+RdnxhyoA+gJgGazFvjmubSRFkZG
         hcQQ==
X-Gm-Message-State: AAQBX9fVQGodvrG2lOJVgrailIZsbHzhn5X8jVTkgzxLzT6niJEPoyLL
        9alJblxGX5JbEd7JSMPj1MQ=
X-Google-Smtp-Source: AKy350bdLRQwscQK5//RqC7GwSunB2eEKmb2a1Uy11DEWW10dmKmEeGh9FJHbbQqbWtpC1QDOhYJkQ==
X-Received: by 2002:a17:906:c41a:b0:94f:21cf:86c6 with SMTP id u26-20020a170906c41a00b0094f21cf86c6mr11129160ejz.51.1682374960798;
        Mon, 24 Apr 2023 15:22:40 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8109:aa3f:ead8::2fd0])
        by smtp.gmail.com with ESMTPSA id g21-20020a170906539500b0094efdfe60dcsm5870886ejo.206.2023.04.24.15.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 15:22:40 -0700 (PDT)
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
To:     jic23@kernel.org, mazziesaccount@gmail.com
Cc:     krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Mehdi Djait <mehdi.djait.k@gmail.com>
Subject: [PATCH v3 3/7] iio: accel: kionix-kx022a: Warn on failed matches and assume compatibility
Date:   Tue, 25 Apr 2023 00:22:23 +0200
Message-Id: <18574aeeb9b66a9799972763ea6b8019fe7ffc35.1682373451.git.mehdi.djait.k@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1682373451.git.mehdi.djait.k@gmail.com>
References: <cover.1682373451.git.mehdi.djait.k@gmail.com>
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

Avoid error returns on a failure to match and instead just warn with
assumption that we have a correct dt-binding telling us that
some new device with a different ID is backwards compatible.

Acked-by: Matti Vaittinen <mazziesaccount@gmail.com>
Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>
---
v3:
- changed from 'unsupported' to 'unknown'
- removed the opening bracket

v2:
- no changes, this patch is introduced in the v2

 drivers/iio/accel/kionix-kx022a.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-kx022a.c
index ff8aa7b9568e..494e81ba1da9 100644
--- a/drivers/iio/accel/kionix-kx022a.c
+++ b/drivers/iio/accel/kionix-kx022a.c
@@ -1036,10 +1036,8 @@ int kx022a_probe_internal(struct device *dev)
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to access sensor\n");
 
-	if (chip_id != KX022A_ID) {
-		dev_err(dev, "unsupported device 0x%x\n", chip_id);
-		return -EINVAL;
-	}
+	if (chip_id != KX022A_ID)
+		dev_warn(dev, "unknown device 0x%x\n", chip_id);
 
 	irq = fwnode_irq_get_byname(fwnode, "INT1");
 	if (irq > 0) {
-- 
2.30.2

