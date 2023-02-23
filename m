Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 132F06A0699
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 11:52:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233056AbjBWKwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 05:52:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233392AbjBWKwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 05:52:07 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3735A385
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 02:52:05 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id g17so545819lfv.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 02:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fad0B/rhNAjnOyEdJToKazkQgow6CPI+KmVYb5YkBn0=;
        b=G+pOktPZ3zofS03mq097ipPC1zgnPvchdrSSIaeK0m1/MIDlAi7psnfHpQdA4+soTF
         dfeCd691t6AM9sdo02sZH2Orbn3jNKrK0K/ty3TbDosSbMdzU+7MKcHNPpdhwE+a8FEw
         x89eg2nTERzd3v/H1rArc+PYKPh3+LGR774etyJD64Zl3lrOH7iy6YMLW3i0f5x2sS+p
         bdf8hoDhFAM9H0WcCw8brd8j4nbgLmj/Mh0csJZaXSKLi1HQCXxDOoyXE+Sfa2AzEOpU
         3bOK6qR7oHFxIz3+FfTENgXDsEdif7zTjWmKZWGnZ53CyoE12KKttd4hydoSFbZyVNRC
         t6ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fad0B/rhNAjnOyEdJToKazkQgow6CPI+KmVYb5YkBn0=;
        b=MkGGNs5JcEdwxMr2BCv3zdiwX45ZEtYhVizYctFEuXyY1SbPDEOqWNQGow3XNfOZ4A
         hiupMz8lXv8Newa7oCIbsaGncgAehEkF/XY2VyCwD2Qh1OwdIpEcbfG34LlyLB/8aYi+
         EtdRHxv/inSGdGqZBqpDnhB2arkfcchEiTS+D+XI5v6nYN5gCwcLa0Cav+Mm+YkelFdM
         k/v3UNMid6mI2PYuOB6mk1NYZxi6qvBxNRJBqyIdE8jsRDrXdBsdkxl9q7wrkQJixJoc
         qiCweU+tTpyWK4MR5+A16u3abdB51ZapSxqgKsSxrnr881QhE5TznQ6L+NA2U4D9tzqO
         D5Mg==
X-Gm-Message-State: AO0yUKX3AZHO0CsR8+AWYSGGtc/tjOWwdV9gTGDoIAJVjfJ9mdG4cVEG
        2A1i6L6xVvLp00SMUy4DWMWLZQ==
X-Google-Smtp-Source: AK7set9MrkjvA3PRtR+X++flPhHS8oJ3vWoTNNeAaB6kgOnBYe7J3pDG8j9GdeVhQgmYWEZ71490tQ==
X-Received: by 2002:a05:6512:682:b0:4dc:790c:9100 with SMTP id t2-20020a056512068200b004dc790c9100mr4779511lfe.12.1677149524057;
        Thu, 23 Feb 2023 02:52:04 -0800 (PST)
Received: from [192.168.1.101] (abxi151.neoplus.adsl.tpnet.pl. [83.9.2.151])
        by smtp.gmail.com with ESMTPSA id m25-20020ac24ad9000000b004cf07a0051csm262304lfp.228.2023.02.23.02.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 02:52:03 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v3 0/7] OPP and devfreq for all Adrenos
Date:   Thu, 23 Feb 2023 11:51:56 +0100
Message-Id: <20230223-topic-opp-v3-0-5f22163cd1df@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAExF92MC/22NTQ6CMBBGr0JmbU2ZohBX3sOwKO0Ik5C2mSLRE
 O5uZe3yvXw/G2QSpgy3agOhlTPHUMCcKnCTDSMp9oUBNRqNaNQSEzsVU1K6prauceiurYeSH2w
 mNYgNbiqN8JrnIpPQk9/HwaMvPHFeonyOvxV/9t/0ikorbMhj43xrLt195mAlnqOM0O/7/gUFU
 7K3uAAAAA==
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677149522; l=2895;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=1TrYwzypEOhtdRr9Ii2Om5YZnHZPr/HRHl6+KZECI8A=;
 b=RlXNdpwiG5uTIMPIsVD8Pi10qSkZDvcoBNOKno/DktqhHK7H907L54lQ6oxyQ2O4mvfEwDMSW/Q7
 33APj/7SC4bZOjTunDWqJlT3WyiBJZMJsp11sfkpC2jUNHmWwHIv
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2 -> v3:

- Add [2/7], x-ref with https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/21484
- De-magic-ify the remaining BIT(6) in a2xx_busy (thanks Dmitry)
- Drop unnecessary else{} level in [3/7]
- Pick up tags

v2: https://lore.kernel.org/linux-arm-msm/20230223-topic-opp-v2-0-24ed24cd7358@linaro.org/

v1 -> v2:

- Move a2xx #defines to XML
- Use dev_pm_opp_find_freq_floor in the common path in [2/6]
- Clarify a comment in [2/6]
- Move voting from a5xx to Adreno-wide [6/6]
- Pick up tags

v1: https://lore.kernel.org/linux-arm-msm/20230222-konrad-longbois-next-v1-0-01021425781b@linaro.org

This series is a combination of [1] and a subset of [2] and some new
stuff.

With it, devfreq is used on all a2xx-a6xx (including gmu and
gmu-wrapper) and all clk_set_rate(core clock) calls are dropped in
favour of dev_pm_opp_set_rate, which - drumroll - lets us scale
the voltage domain. DT patches making use of that will be sent
separately.

On top of that, a5xx gets a call to enable icc scaling from the OPP
tables. No SoCs implementing a2xx have icc support yet and a3/4xx
SoCs have separate logic for that, which will be updated at a later
time.

Getting this in for 6.4 early would be appreciated, as that would
allow for getting GMU wrapper GPUs up (without VDD&icc scaling they
can only run at lower freqs, which is.. ehhh..)

Changes:
- a3xx busy: use the _1 counter as per msm-3.x instead of _0
- a6xx-series-opp: basically rewrite, ensure compat with all gens
- a2/4xx busy: new patch
- a5xx icc: new patch

[1] https://lore.kernel.org/linux-arm-msm/20230130093809.2079314-1-konrad.dybcio@linaro.org/
[2] https://lore.kernel.org/linux-arm-msm/20230214173145.2482651-1-konrad.dybcio@linaro.org/

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (7):
      drm/msm/a2xx: Include perf counter reg values in XML
      drm/msm/a2xx: Add REG_A2XX_RBBM_PM_OVERRIDE2 to XML
      drm/msm/adreno: Use OPP for every GPU generation
      drm/msm/a2xx: Implement .gpu_busy
      drm/msm/a3xx: Implement .gpu_busy
      drm/msm/a4xx: Implement .gpu_busy
      drm/msm/adreno: Enable optional icc voting from OPP tables

 drivers/gpu/drm/msm/adreno/a2xx.xml.h      | 18 ++++++
 drivers/gpu/drm/msm/adreno/a2xx_gpu.c      | 26 ++++++++
 drivers/gpu/drm/msm/adreno/a3xx_gpu.c      | 11 ++++
 drivers/gpu/drm/msm/adreno/a4xx_gpu.c      | 11 ++++
 drivers/gpu/drm/msm/adreno/adreno_device.c |  4 ++
 drivers/gpu/drm/msm/adreno/adreno_gpu.c    | 99 +++++++++++++-----------------
 drivers/gpu/drm/msm/msm_gpu.c              |  4 +-
 drivers/gpu/drm/msm/msm_gpu_devfreq.c      |  2 +-
 8 files changed, 117 insertions(+), 58 deletions(-)
---
base-commit: aaf70d5ad5e2b06a8050c51e278b0c3a14fabef5
change-id: 20230223-topic-opp-01e7112b867d

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

