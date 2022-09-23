Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 140505E83F2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 22:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233288AbiIWUiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 16:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiIWUhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 16:37:45 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B88BB
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 13:31:45 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 10so2007470lfy.5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 13:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=2Z/dQnQWNXMTnmw/L26Lh+jcV1lMl/cNMW0PDsjS/vA=;
        b=yDQbF8hk4sRgjyOXMU57XTj4qyCqct7EFFBVrIcD6jQtO3UIhIsW4fBpaz2sZapp8s
         UpFaHqqx4x3GoOLF21Zx/SyJzNCohyfBSkzAkvXkxJYy6R5J79ejgnHeCBJYY0vAnoag
         xh6mNw1XxbRfzUHjnVZECddXmnIx5mDDJhwbirJQCVuzkLqRKhg1ERJ05d4//uLjbPYg
         KdtZB0XaGfrLR4ez7sqG4KLLomzl2mf0Ju6EfbZNlrYzd/0mfefgC1nZa5zcgmL+fBkW
         PDYx7kZOWKfyJrq0mpa9ZZh+PsWVCugES9Ni9UokGHX2qxEebT2gJAOJBcPMVC0xwVRU
         xAng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=2Z/dQnQWNXMTnmw/L26Lh+jcV1lMl/cNMW0PDsjS/vA=;
        b=EekmLsdZN8RyMX0bnnBg5UXEAuTFqSthqEFdh1C2wkXxQdjyjG7hCCV3tqoRxTuqGx
         ucMGBGMTBvP0hsPvs00GIBsA3FwJToyfLcaCArtNY+9qcG9PqELWYa5a+7+da3MA69Le
         nVYVeE1w8RokvBSWsMOfVsLEh5EBGcJDf1zORFPi4h2cNRXNk0+sUBuabmLenUe0IVlt
         Bir/Ksu8mXRZgVbIohOk2vs2f96ggB+7uD38cMpRZI4E5kUdH6RSdq08tU0Cj5kUtbF6
         Zv/0lUnrI+CkjvmSpsaLiCsmEdY1r1pASOKsC+2QT19z524Avz0OZeYvq6dMwDrbbftf
         zDwg==
X-Gm-Message-State: ACrzQf12jiL0bNJ7xciZ2yejkUk1Azri9BrunTCmH6Uer3nq+MnwuDv1
        9qne+hyB0QYsfVANYpX/2wT6/Q==
X-Google-Smtp-Source: AMsMyM6WxykWu2Kvn6f7MIZxYNvYLdIHBZyxPBKcDMdzsSBDHBRhhK3vUfnFG2TFoghp8cGLlco+bg==
X-Received: by 2002:ac2:4ecd:0:b0:49b:ecd4:2d1a with SMTP id p13-20020ac24ecd000000b0049becd42d1amr3744887lfr.528.1663965104186;
        Fri, 23 Sep 2022 13:31:44 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id o18-20020a05651205d200b00497ad8e6d07sm1588164lfo.222.2022.09.23.13.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 13:31:43 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>
Subject: [PATCH RESEND] ASoC: MAINTAINERS: add bindings and APR to Qualcomm Audio entry
Date:   Fri, 23 Sep 2022 22:31:40 +0200
Message-Id: <20220923203140.514730-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Extend the Qualcomm Audio maintainer entry to include sound related
bindings and the Qualcomm APR/GPR (Asynchronous/Generic Packet Router)
IPC driver, which is tightly related to the Audio DSP.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Bjorn Andersson <andersson@kernel.org>

---

Resend because it seems I forget to Cc Mark.
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0350effebe8f..453dc6fd0b80 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16710,6 +16710,9 @@ M:	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
 M:	Banajit Goswami <bgoswami@quicinc.com>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 S:	Supported
+F:	Documentation/devicetree/bindings/soc/qcom/qcom,apr.yaml
+F:	Documentation/devicetree/bindings/sound/qcom,*
+F:	drivers/soc/qcom/apr.c
 F:	include/dt-bindings/sound/qcom,wcd9335.h
 F:	sound/soc/codecs/lpass-rx-macro.*
 F:	sound/soc/codecs/lpass-tx-macro.*
-- 
2.34.1

