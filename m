Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B24857351C5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 12:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbjFSKRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 06:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjFSKQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 06:16:59 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0697599
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 03:16:58 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-307d20548adso2339752f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 03:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687169816; x=1689761816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gSYLEp+YdUxldV8igLt5BFNVK72bviFN+/4CDtA3Mh8=;
        b=dLj1MVLXyF0FrCD8KYvoc9fQGbRxY6I7GSzXo3cjom6O7tGC188XsxGeJIc7XT63Jb
         3yPOs8Hqypd9Bi6B8IQxGCjq3U1MFE/SUsMK4UG0jLtgbCGqNRc4dwBiVksSyNUqY3Ne
         gEx+DKEqXiDIG7o/hH1cl9pZBFcRKhdNWatv9gpj4zE2evMz2XkxdT5xB76oRAcXIDC0
         AzHJc1lgC26H1gRvizZGMT8orYL8aFcvrL89DaOxa0AHS7lxy2aWyvftE6HInU/SPe6t
         XLhiyyGpeqwm7p4GAFj0wemaS81PXkEyRH5tkTEDqm9gdJfo2EdYWH5z3UBHqFLwqC2j
         8aXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687169816; x=1689761816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gSYLEp+YdUxldV8igLt5BFNVK72bviFN+/4CDtA3Mh8=;
        b=d939uXQrMofUYhvB5oWhKwTDvQi1ASwqnB3J73M144ws4tF4T9TgVPID++ee6gDhKv
         cmile1EK7sKr5SboUjcSuDRlqZSKUfxEJpNqqcQQa7lSeE5qi8GJuqZMudqlYN90bEqf
         24y/rYR+ZBwfj7N1oMXUjWv5jBSqCCmO6KSUX01jvzL+ONxjkwq+ixPvbLkmb3mi8w9w
         Xpat0krdPGobL8atyCAT4VRAf4X3C5G66/24DoubcwE8yz7JZSA9li1vEfbhP450YqxK
         jehbXlmqc+GoAC1DJNY4Idu7fIyoGLKPtqj5OlQAB0KLPG0MjISZpoFPAlRG1ahAfnKV
         3O0w==
X-Gm-Message-State: AC+VfDyG4yGoX/VrVfO3jPFR+hEPaBgN6GdGgsq/jYNsmB8+SO5QiSPV
        fYARP89tYuuWObKMSe69O5eJNg==
X-Google-Smtp-Source: ACHHUZ4B9JQC1lZJ8vlWh4TNeD8qz6y9HFsakUA3OeGPoGiIknnJ1wgidU3nd85ZRFDQcLB8DrwBzA==
X-Received: by 2002:adf:e849:0:b0:311:27bf:f9ec with SMTP id d9-20020adfe849000000b0031127bff9ecmr4601602wrn.21.1687169816492;
        Mon, 19 Jun 2023 03:16:56 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id c2-20020a5d5282000000b002fae7408544sm31146922wrv.108.2023.06.19.03.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 03:16:55 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
        ckeepax@opensource.cirrus.com, kuninori.morimoto.gx@renesas.com,
        linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
        alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 00/11] ASoC: qcom: audioreach: add compress offload support
Date:   Mon, 19 Jun 2023 11:16:42 +0100
Message-Id: <20230619101653.9750-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
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

This patchset adds compressed offload support to Qualcomm audioreach drivers.
Currently it supports AAC, MP3 and FALC along with gapless.

Tested this on SM8450 and sc7280.

thanks,
srini

Changes since v2:
	- fixed order of sign-off
	- added placeholder decoder and encoder to audioreach_set_media_format

Mohammad Rafi Shaik (4):
  ASoC: qcom: SC7280: audioreach: Add sc7280 hardware param fixup
    callback
  ASoC: q6dsp: q6apm: add end of stream events
  ASoC: q6dsp: audioreach: Add support to set compress format params
  ASoC: q6dsp: audioreach: Add gapless feature support

Srinivas Kandagatla (7):
  ASoC: q6dsp: audioreach: add helper function to set u32 param
  ASoC: q6dsp: audioreach: Add placeholder decoder for compress playback
  ASoC: q6dsp: q6apm-dai: Add open/free compress DAI callbacks
  ASoC: q6dsp: q6apm-dai: Add compress DAI and codec caps get callbacks
  ASoC: q6dsp: q6apm-dai: Add trigger/pointer compress DAI callbacks
  ASoC: q6dsp: q6apm-dai: Add compress set params and metadata DAI
    callbacks
  ASoC: q6dsp: q6apm-dai: Add mmap and copy compress DAI callbacks

 sound/soc/qcom/qdsp6/audioreach.c | 250 ++++++++++-------
 sound/soc/qcom/qdsp6/audioreach.h |  51 ++++
 sound/soc/qcom/qdsp6/q6apm-dai.c  | 445 ++++++++++++++++++++++++++++++
 sound/soc/qcom/qdsp6/q6apm.c      |  68 +++++
 sound/soc/qcom/qdsp6/q6apm.h      |   6 +
 sound/soc/qcom/sc7280.c           |  23 +-
 6 files changed, 747 insertions(+), 96 deletions(-)

-- 
2.21.0

