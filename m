Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 558D05BAE0C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 15:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbiIPNYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 09:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiIPNYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 09:24:41 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57748186DA
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 06:24:40 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id n40-20020a05600c3ba800b003b49aefc35fso6599142wms.5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 06:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=3jErXpZmn2N6mgsVfkwQqr3XmZwaGr9W2eUR2s6Rv7k=;
        b=HwBbWSmt3GXvafXwR7pCNFr0HqraLlcS0XmTtDtLz+70EXcCn72WtK/x540wb8FBqt
         cOJVl/qw5CoAVbAHOG/D0+4rYF6mhnurrtR55hTi53//PDTvoqCOy1xlucfJTnfpn5cU
         ZdetRcsQfw9xWd8MBy9iNzP2JF3ZJnEmX0H4hfeF7Hwx4Qd+khqzMWWxBlCrBhiKP9mo
         CMRQgmVnu70C0Di5zDGxyhDg8XXU3twmnHsfZZuDqQuI/j2L+d3izFin5X/N+QSp7dzU
         irlJsC0p3O0rFiLRcJg4Dc1iC7iwVfNuu0Q7p3IxOah2f1aNrHLR6C4Gb0MvF9upRwoS
         8N1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=3jErXpZmn2N6mgsVfkwQqr3XmZwaGr9W2eUR2s6Rv7k=;
        b=GIcP3J3XkiZfzcsfUaDXFKiR4mMiX2QC++UqCKOlUo5p968vUfwOKFmoQVRWJfNg6W
         iRhwj3ZNEvJK9dy503eq2vAD1tqEf1DoqODzFJhUFImZ6P/GlJ8fHyfVC1BuDpPrDfzs
         Hr5S8NpxTRqDbWms5G+CxrX3/3FEQ3xw2PfqXHdwIVVP0NToLAvJEvxohITOI8witfHY
         ifsJ2xA/kpCD8qXAZQyI8mHkz+KrDNuZ1OOgWMPjY2O1EvkPbPeYdl5cSBPhG+jCTvVN
         iY2qVQItt5BeBE6CnFWAJUqNnFTcpGRe5HGCKo6YuOrRwkrIqddgez2dPrvupSgTsIUV
         jEgQ==
X-Gm-Message-State: ACrzQf2yfnmvS/X/93azPeXbcfJrpqJI5+ztfA4o+KWFz4PHni6xUef8
        CKFFF29bTqyz1jbuvQbpb8dJyA==
X-Google-Smtp-Source: AMsMyM5a4Z1zj9PjOs0QfWwmr5LxZH9v0dgNZRsQyAohxrH0EEAKzAuWxjG1ePB5MEPEHUOb6lsunA==
X-Received: by 2002:a05:600c:34d2:b0:3b4:a617:f3b9 with SMTP id d18-20020a05600c34d200b003b4a617f3b9mr3258246wmq.204.1663334678887;
        Fri, 16 Sep 2022 06:24:38 -0700 (PDT)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id p5-20020a05600c358500b003a608d69a64sm2387061wmq.21.2022.09.16.06.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 06:24:38 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, bgoswami@quicinc.com,
        perex@perex.cz, tiwai@suse.com, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v5 0/5] ASoC: qcom: add support for sc8280xp machine
Date:   Fri, 16 Sep 2022 14:24:22 +0100
Message-Id: <20220916132427.1845-1-srinivas.kandagatla@linaro.org>
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

Changes since v4:
	- fixed typo in commit log
	- sorted compatible strings before adding new ones.

Srinivas Kandagatla (5):
  ASoC: qcom: common: use EXPORT_SYMBOL_GPL instead of EXPORT_SYMBOL
  ASoC: dt-bindings: qcom: sort compatible strings
  ASoC: dt-bindings: qcom,sm8250: add compatibles for sm8450 and sm8250
  ASoC: qcom: sm8250: move some code to common
  ASoC: qcom: add machine driver for sc8280xp

 .../bindings/sound/qcom,sm8250.yaml           |   4 +-
 sound/soc/qcom/Kconfig                        |  12 ++
 sound/soc/qcom/Makefile                       |   2 +
 sound/soc/qcom/common.c                       | 173 +++++++++++++++++-
 sound/soc/qcom/common.h                       |  35 ++++
 sound/soc/qcom/sc8280xp.c                     | 157 ++++++++++++++++
 sound/soc/qcom/sm8250.c                       | 152 +--------------
 7 files changed, 388 insertions(+), 147 deletions(-)
 create mode 100644 sound/soc/qcom/sc8280xp.c

-- 
2.21.0

