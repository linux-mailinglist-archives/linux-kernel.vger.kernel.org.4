Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59C91729D68
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 16:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241613AbjFIOyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 10:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241606AbjFIOyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 10:54:19 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA16C30F7
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 07:54:15 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f61d79b0f2so2450693e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 07:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686322454; x=1688914454;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QeftDeyvvysATSitJ+hgLelm68R1NmQyMnxNP/qXI28=;
        b=KSOkzUtKrwVPxWpFH7oNQ7Fv+3X39paXhtnpEsPt+jAqXuCsDV9K4ANu1Hzlg03d1o
         jVYB5dJdyl1nlnrZSu4WyJ2RnAl9gMmKFIZ469cV3tSOiCHeIRMjVrOHLafx5Wkq4oJM
         xMoymFNVcUtkE+b1mnEiecCGzP7l8yCRVHeGq5lncuHOfaxXK+K77AdDU+jAwflnMobM
         1Trb+ckh94xZwnPpyKHvplw/j+U0OGLIuj5rPfKvldMNHhUTN7N/zD7b541UB3nkaoOU
         Jl9vIVpslY/2GcIGa2s3k6Ce60foTnSPlqsDR8r5KSYOPNr4pMwKUkdU3WcsAjcHJyL3
         2Yug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686322454; x=1688914454;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QeftDeyvvysATSitJ+hgLelm68R1NmQyMnxNP/qXI28=;
        b=HNDXqVQdnK4FB2lOahrj5oVh2Xd+uciAH6ZfOHesJdLDI735USxJn3QU+mBrRgBBGh
         nAp6aLdVnxWZJS7O4m3GkHMrcd0bzjsn/zieOye1+JYbc5uVpbE6QF7jZOqNIkgmKM1i
         7cO2/ZZTy2DNlV5v/0bWGiMObRsrh1XrJzjOWOOai7ecMAJNloyIFwn7HMRR94kWCVW4
         pI0OUjYCWSqu9vrQ89ZpgRb07tKmP33/Oc0nVrTQ5fQLMXs8FRJF/OkyX9gzytwiHras
         KoYwqFTmISyG1ROHs/Gk1d3xIBR2QLisUcu9f/GZMADjaCoRP8TtwFJv2mw+QehjHqSt
         il2w==
X-Gm-Message-State: AC+VfDy40VezhxyGV6s6AFdXGiLpB68wlXi++3el6dlXEX71onkvaSBu
        VQijy2lzUIBwdqcHbQUTJGCI6w==
X-Google-Smtp-Source: ACHHUZ7jY1rwqaF8movy77QYmPcO580cVoSBABEAOaV3TJjxtZk5cpIC4Dy6acTqJyBocb1nRz7Hjw==
X-Received: by 2002:a19:5f16:0:b0:4f6:25a3:95ab with SMTP id t22-20020a195f16000000b004f625a395abmr1044393lfb.25.1686322453936;
        Fri, 09 Jun 2023 07:54:13 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id c21-20020a05600c0ad500b003f7310a3ffasm2946632wmr.2.2023.06.09.07.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 07:54:13 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
        ckeepax@opensource.cirrus.com, kuninori.morimoto.gx@renesas.com,
        linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
        alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 00/11] ASoC: qcom: audioreach: add compress offload support
Date:   Fri,  9 Jun 2023 15:53:56 +0100
Message-Id: <20230609145407.18774-1-srinivas.kandagatla@linaro.org>
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

This patchset adds compressed offload support to Qualcomm audioreach drivers.
Currently it supports AAC, MP3 and FALC along with gapless.

Tested this on SM8450 and sc7280.

thanks,
srini

Changes since v1:
	- removed lots of code duplication
	- moved ALSA patch out of this series.

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

 sound/soc/qcom/qdsp6/audioreach.c | 248 ++++++++++-------
 sound/soc/qcom/qdsp6/audioreach.h |  51 ++++
 sound/soc/qcom/qdsp6/q6apm-dai.c  | 445 ++++++++++++++++++++++++++++++
 sound/soc/qcom/qdsp6/q6apm.c      |  68 +++++
 sound/soc/qcom/qdsp6/q6apm.h      |   6 +
 sound/soc/qcom/sc7280.c           |  23 +-
 6 files changed, 745 insertions(+), 96 deletions(-)

-- 
2.21.0

