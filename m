Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99C285B9B64
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 14:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiIOM4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 08:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiIOM4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 08:56:21 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705D99C1DC
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 05:56:19 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id l17so1255112wru.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 05:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=G2rHbxpP60TFR+zumNeCiSf5mCfJRZI93xLQZOWnmYY=;
        b=aVuw7Ao9bWSdWPOAkXlAvUrgWFm15T6IzL4j33izpIsPodrX+PYSvVVf/rqlm5EoE1
         mq5MEwJQK1Z6sbxzTRTLnSwp6EAI6ZM+5RnT7wjeGdoNJQpGo8RMsuRIntHhbL7NeD95
         JTGroguJ/fNT85NG9v2QXJb6FSJG/pZLnc/xmQAtqkmHHpIFaDMR50b2JQdp0z/atNzY
         QGLz3jEsnW9hc9Sl/JrPYus1AaPo1IU/GNDCB3Nb6gyU5jsrtkxwalvLaaqpy5S1UIj7
         BGt2TTRXaSws+aRn2IdFvkUkFQdRCWRtrnZ1roMj5XlABrefNzvccOPo87IJmjgVjoVx
         xE7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=G2rHbxpP60TFR+zumNeCiSf5mCfJRZI93xLQZOWnmYY=;
        b=aQcNVKMk8tY7MVCOAHUQsS/7wZkP5ArzwnX4V5zDVMPxGBBt/Oip2aUwwu3cyKkGY1
         EFdoVYGw5pDg2FIf/FFSnSK8zrAkN6LbT0dA2Qlqju8xht3ZFjBYiaeCssiEb2DoFXZc
         +9I6LOiSHn8cyvSCp+UrMEj42CdXB47SdDytM1NP8LUHHOVXYXqjnJUKmBK7Z9AoSIeH
         8cpndU3deRfjAvJe0XF6UU3XPBxsQljAZ3S1f/nAXah6vW96VN9tz2tRE6xQ1Zq308o3
         ETOqZM0D1iveHG1gQ3+9rzWQ1ZoegZcYY2hqs3A3Fs7P4hI1LD9ZcvgcnieTMm15RHDL
         7Y9A==
X-Gm-Message-State: ACrzQf33ND6ci8Z986ZTqz1H8kbGQHkLBFFVXj79wsbskn4YM0sL/+m4
        dcacwIuy/JFHs044u7nbJzS99g==
X-Google-Smtp-Source: AMsMyM76KrIHzxT8CDfHmA6sOIBVAkTVLDe0LL3YIWLSTze54PfuHSmOXH1+RYNH95t9DQIYTSbC3w==
X-Received: by 2002:adf:f509:0:b0:22a:cbe3:3da8 with SMTP id q9-20020adff509000000b0022acbe33da8mr4053421wro.532.1663246577950;
        Thu, 15 Sep 2022 05:56:17 -0700 (PDT)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id o11-20020a05600c510b00b003a845621c5bsm2764776wms.34.2022.09.15.05.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 05:56:17 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, bgoswami@quicinc.com,
        perex@perex.cz, tiwai@suse.com, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v4 0/4] ASoC: qcom: add support for sc8280xp machine
Date:   Thu, 15 Sep 2022 13:56:07 +0100
Message-Id: <20220915125611.22473-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
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

This patchset adds support for SC8280XP SoC machine driver.

First patch moves some of the commonly used code to common from sm8250 machine driver
and the follow on code adds minimal support for sc8280xp.

Currently this driver is only tested with SmartSpeakers and Headset
on Lenovo Thinkpad X13s.

Support for sm8450 is tested and I will post the patches soon.

Thanks,
Srini

Changes since v3:
	- fixed few spellings in commit log
	- removed build dependency with APR

Srinivas Kandagatla (4):
  ASoC: qcom: common: use EXPORT_SYMBOL_GPL instead of EXPORT_SYMBOL
  ASoC: dt-bindings: qcom,sm8250: add compatibles for sm8450 and sm8250
  ASoC: qcom: sm8250: move some code to common
  ASoC: qcom: add machine driver for sc8280xp

 .../bindings/sound/qcom,sm8250.yaml           |   2 +
 sound/soc/qcom/Kconfig                        |  12 ++
 sound/soc/qcom/Makefile                       |   2 +
 sound/soc/qcom/common.c                       | 173 +++++++++++++++++-
 sound/soc/qcom/common.h                       |  35 ++++
 sound/soc/qcom/sc8280xp.c                     | 157 ++++++++++++++++
 sound/soc/qcom/sm8250.c                       | 152 +--------------
 7 files changed, 387 insertions(+), 146 deletions(-)
 create mode 100644 sound/soc/qcom/sc8280xp.c

-- 
2.21.0

