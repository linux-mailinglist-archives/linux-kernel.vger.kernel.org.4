Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAE6460F4FD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 12:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235296AbiJ0K1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 06:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233264AbiJ0K1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 06:27:41 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE25A3ECC7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 03:27:40 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id i5-20020a1c3b05000000b003cf47dcd316so3797092wma.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 03:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c10Qe+zVZwwhBmGpXr4d44up0IldqesvWFfpeof/vkk=;
        b=fVIZxf6ldVYp8IBSoyM4y0u487MzBl4hyvzk2dmHbQ6cAjTw/gb3hGHq/fNXIAIknO
         wUkpKa9NXUqqXGvKs6y5a8aP8ah7+k+Rb+Fvm6NiM4U8TfDVENUquvVTE3jaiCy3hY5b
         PyEu71SuL7hVubSIhG1CUe5OAhkqivw5IieTuSkvBgKBZyQ2LASo4CAZrhvbf6HwsxmX
         YceOtRHXKz8Uos6/HkcbfK/Z7fEruPIQTFalW53j55EMLMzkkGWeVx+CpYvAPT2Oj++D
         D0Y3hoD5NuErKKUQoZ345ja+k0N3bPc3JTmNUfacDfh/JEqMEvIXu2mYNShWqmRm7ojv
         zR3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c10Qe+zVZwwhBmGpXr4d44up0IldqesvWFfpeof/vkk=;
        b=wG5YrOWlRwmzf41RnXu9NOu13jDeYer1L0KRnfKvmR78P9eq493hl/7WrXWV53M7Nx
         GCgWt114VshGwrwTjvz2Ob2qafIObA40fcXRx8Z5aI3vClM+p71I8XWuTEg19RyV4c31
         XUcncAJGBPBcmH54199GrQQbKGERWCCo7qbei4bd7fLLwr0Z9Iwm+xJLpmncblJXaKJK
         zL/TGYUOJlWxpWaRNm1mOvWyqsPZOCs9Rz+nGTIYecxJXfJ9AeTldbj7jfVi8xZckzKg
         V1KyT+bWAsxfsThUClPhdPzTGby2WJoDtbaDmhety0H1SCmgswlQlLlFAftHUscKa09I
         uaLA==
X-Gm-Message-State: ACrzQf2BdIo2RSkyZRI0fo0CUMsJKWVroan6a5wKO6fxL3vQZCeGFHo6
        kbH6sEMYpyoy4tyy4HR8zwBNbA==
X-Google-Smtp-Source: AMsMyM5XkM9qBJkZHViwAVqTaVREs+du9SVmS5VfkwGNbmlgN1NNuWvkGYxmgCXT5+ZG1v56r31oVA==
X-Received: by 2002:a1c:7405:0:b0:3cf:55ea:6520 with SMTP id p5-20020a1c7405000000b003cf55ea6520mr436038wmc.46.1666866459346;
        Thu, 27 Oct 2022 03:27:39 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id fc7-20020a05600c524700b003b505d26776sm5088674wmb.5.2022.10.27.03.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 03:27:38 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, bgoswami@quicinc.com, perex@perex.cz,
        tiwai@suse.com, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 0/9] ASoC: qdsp6: audioreach: add multi-port, SAL and MFC support
Date:   Thu, 27 Oct 2022 11:27:01 +0100
Message-Id: <20221027102710.21407-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
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

This patchset adds support to multi-port connections between AudioReach Modules
which is required for sophisticated graphs like ECNS or Speaker Protection.
Also as part of ECNS testing new module support for SAL and MFC are added.


Tested on SM8450 with ECNS.

Thanks,
Srini

Changes since v2:
	Fixed two spelling mistakes in commit message
	No code changes.

Srinivas Kandagatla (9):
  ASoC: qdsp6: audioreach: topology use idr_alloc_u32
  ASoC: qdsp6: audioreach: remove unused connection_list
  ASoC: qdsp6: audioreach: update dapm kcontrol private data
  ASoC: qdsp6: audioreach: Simplify handing FE and BE graph connections
  ASoC: qdsp6: audioreach: simplify module_list sz calculation
  ASoC: qdsp6: audioreach: add support for more port connections
  ASoC: qdsp6: audioreach: add support to enable SAL Module
  ASoC: qdsp6: audioreach: add support for MFC Module
  ASoC: qdsp6: audioreach: add support to enable module command

 include/uapi/sound/snd_ar_tokens.h |  27 +++
 sound/soc/qcom/qdsp6/audioreach.c  | 310 ++++++++++++++++++++---------
 sound/soc/qcom/qdsp6/audioreach.h  |  47 +++--
 sound/soc/qcom/qdsp6/q6apm.c       |  84 +-------
 sound/soc/qcom/qdsp6/q6apm.h       |   6 +-
 sound/soc/qcom/qdsp6/topology.c    | 243 +++++++++++++++++++---
 6 files changed, 489 insertions(+), 228 deletions(-)

-- 
2.21.0

