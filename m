Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8B4C712846
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 16:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243868AbjEZObN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 10:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243862AbjEZObH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 10:31:07 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4615E187;
        Fri, 26 May 2023 07:31:06 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-96ff9c0a103so115085466b.0;
        Fri, 26 May 2023 07:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685111464; x=1687703464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bR+n0r4xZA3l73V+FeeZfa6IV+HvrfUxq6BwqD6x6q0=;
        b=Kw55PJEypdtQz6vZ8Q/UJvVmm0DoUjDrSczqfSyImvq2WDIrGza0xXCKvNk0Am6ZZD
         y8efE2xA7ZiSCvLfdPe78SSInwCL64spuPe7kdwU0faHUAEb3noMNexXxvxq/JVr3yoi
         HFYfLy8H8FGPQBSGJyTvaTbAEHoDrhOcp91CD3X3yzY+wuVv6tGgUDvnkLOj0HBq+fs8
         zdR12Kx6EWqxCjlkqxJrXGbADHA84wxhYybO3Xebg5z2J5UFUD5oZdHJob91A1TT+hKW
         TYB6ye3mqGJcHYAkVe0uJeD3uSRrs/qHN9RCcBtSp6XOtxdSq43YYoS6Prgiu8mxrdb6
         crAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685111464; x=1687703464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bR+n0r4xZA3l73V+FeeZfa6IV+HvrfUxq6BwqD6x6q0=;
        b=fUSyIC4K0flr5AlRJ3uhzj/TsPvMzn9NeDQYUFPYSdLwkQdNZnto0H0K5BNyi0qIMw
         U0s/c9iu71/3HDyduSUsOsq1W1vsvNleyGUcbpsXWfA12/qNmdN4jS3RTFJM7ZnTF4LG
         Wia0gP2R+zAxK8MR3c9raxa2ZeLOAgakVvjCYpHPAwakkqRsmilUeCtEQAVcxijRUXvW
         NsPosI8EKKP4DruwhYKc3NiaI1c3wKJW1gntrQI+f9Re8TXO0SLr1iOrTztIJdEeA96y
         bGIMW54Vd7MjWLzyOIkId7X5Pr6IvHgKlfbsPkex8r0XpMnUq5M2JLAbN8UuBGsRcsdA
         rbAA==
X-Gm-Message-State: AC+VfDxGgo6kWR8DgsEDsfdXPySRYHGCZt7ibow61nuiBHoaxNOUC0qH
        HNxwUODepVLowqlTheZUsao=
X-Google-Smtp-Source: ACHHUZ4j63IgrgyG0HU2cITUsYD7CnCf8yM6wI/IZ9IxbbnmjlCFvktyHJa3V4icK54/0dmw8pbWzA==
X-Received: by 2002:a17:907:9445:b0:965:6cb9:b768 with SMTP id dl5-20020a170907944500b009656cb9b768mr1987558ejc.31.1685111464232;
        Fri, 26 May 2023 07:31:04 -0700 (PDT)
Received: from carbian.corp.quobyte.com ([2a02:8109:aa3f:ead8::d8a0])
        by smtp.gmail.com with ESMTPSA id r20-20020a170906365400b0094e7d196aa4sm2157023ejb.160.2023.05.26.07.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 07:31:03 -0700 (PDT)
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
To:     jic23@kernel.org, mazziesaccount@gmail.com
Cc:     krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Mehdi Djait <mehdi.djait.k@gmail.com>
Subject: [PATCH v4 3/7] iio: accel: kionix-kx022a: Warn on failed matches and assume compatibility
Date:   Fri, 26 May 2023 16:30:44 +0200
Message-Id: <18574aeeb9b66a9799972763ea6b8019fe7ffc35.1685109507.git.mehdi.djait.k@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1685109507.git.mehdi.djait.k@gmail.com>
References: <cover.1685109507.git.mehdi.djait.k@gmail.com>
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
v4:
- no changes

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

