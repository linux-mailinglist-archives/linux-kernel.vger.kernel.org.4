Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD5A26FC4DF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 13:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235428AbjEILWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 07:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235506AbjEILWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 07:22:10 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3112649D4
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 04:22:07 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f315712406so204144465e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 04:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683631325; x=1686223325;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HBudP5rOnhhCpY0h9bYPkm1GnbG8k9OEtCT5GE3EdaA=;
        b=DfaG1T1l1KlgdSKSXZ+X8UZyF1EVB0cHBhcl9jQ1yMe7AuEU9aDjZTa2OXJ6cY8aWN
         I/bKKUYlItLBeIV6oJ9e+JaSnJjNBFSkkU5qx4Rum8OZwBq19RPJvACxf2Xi7/UFHdhS
         Q2SsQl7Cov4jQKcI6l7fZwB0BKSQvymiVhK/AhcgAZR/8TM87rDpYfa3FquYtaDOAsNR
         9+DY/pS18VzuS6DKhAMpH7cuw4CgxddqheaTaw8VJhVNqJS93j8PZSw/LJQGDcA8AQa0
         E7dgA9XWeMqBXy+SvFWW2PUbFoRKW0v7oKH0tQLQnoq93nSS92ikD024ZQOgWuCXdDkP
         2v5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683631325; x=1686223325;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HBudP5rOnhhCpY0h9bYPkm1GnbG8k9OEtCT5GE3EdaA=;
        b=QPMY67RvmqOA45VGZkOj98dJOA5rWSlhXoNQsFQ7mebyhnsx17xRLVYalZQQAE/dW7
         1QqzzlGO7mMRe9IqJAvJfocs5kN+fijZb5y6hgObGIgOLwzjL6diD+Fpdcy1kwe0KtdR
         beQJS/1gvIjo+pefrOLO3+NqZEzp4aEuYSYnz1Sxlgjzg/zSeGBFy6UTCmfDZIA8t25n
         7z4YP7+HIGLcA3aU0ns/pZHACI3XbsKfALKohJRrvsLo04yDQS1fvd/xfWvAbDaa2ebL
         JCu3TFPX7SmH96trXsJ36yMIVXirbOKdfRA+UsAiM1ifb5QDD3tqkpd0rU+rNaPCwhLb
         7czQ==
X-Gm-Message-State: AC+VfDy9g79ITxmcv7vNZHzquIh43/i+sCZGQEOCJl6yhuMxu6TxxHs7
        nx5TrOo7hJ//g2G3JW9RVluJTA==
X-Google-Smtp-Source: ACHHUZ6GJkuQOpZ4Scsd3KJQ8/sS4Dwz1/NaJ7x0NlTyo+IDsaWquvuB0OflggMDFFKFispYEvIpOQ==
X-Received: by 2002:a05:600c:4444:b0:3f3:284d:8cec with SMTP id v4-20020a05600c444400b003f3284d8cecmr9792623wmn.2.1683631325626;
        Tue, 09 May 2023 04:22:05 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id n2-20020a05600c294200b003f17eded97bsm19531072wmd.19.2023.05.09.04.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 04:22:05 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
        ckeepax@opensource.cirrus.com, kuninori.morimoto.gx@renesas.com,
        linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
        alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/4] ASoC: qcom: add display port module support.
Date:   Tue,  9 May 2023 12:21:58 +0100
Message-Id: <20230509112202.21471-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
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

This patchset adds support to displayport on AudioReach.
Patches are tested on X13s with two display ports.

Srinivas Kandagatla (4):
  ASoC: qcom: q6dsp-common: move channel allocation to common
  ASoC: qcom: audioreach: add support for DISPLAY PORT SINK module
  ASoC: qcom: q6dsp: add support to more display ports
  ASoC: qcom: q6apm: add support to display ports in lpass dais

 .../sound/qcom,q6dsp-lpass-ports.h            |  8 ++
 sound/soc/qcom/qdsp6/audioreach.c             | 75 +++++++++++++++++++
 sound/soc/qcom/qdsp6/audioreach.h             | 12 +++
 sound/soc/qcom/qdsp6/q6afe-dai.c              | 34 ++-------
 sound/soc/qcom/qdsp6/q6apm-lpass-dais.c       | 39 ++++++++++
 sound/soc/qcom/qdsp6/q6dsp-common.c           | 35 +++++++++
 sound/soc/qcom/qdsp6/q6dsp-common.h           |  1 +
 sound/soc/qcom/qdsp6/q6dsp-lpass-ports.c      | 43 +++++++----
 8 files changed, 204 insertions(+), 43 deletions(-)

-- 
2.21.0

