Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C83156B81FB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 21:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjCMUAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 16:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjCMUAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 16:00:10 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B7F64AA7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 13:00:06 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id i28so17253900lfv.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 13:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678737605;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bHnSJ1e/E/f4xbQ+Ey0bVRUJ3n2W/AmMQUXTjmDhfmk=;
        b=CjJJVUkHZ4/LmfhMExespLnoHTad7lvD7XMvltzogwm46cZVuD8jxH4fVlb654Z0I2
         kQjimhF6cdq9qvP9pCCxT8JqDW2236P0jqECowlY2NAm5LTCSpA0uFsHTeBHh8zItEop
         7k3PL18vUSRW60NTdYtq+D7JK43lZ2Ok95j5+QhDZvxFFhpQ0Z1ZWles17pIbPBxMUEk
         wTAsNuL34fW6WHFqD93O7is4kOx0SwhUHAyUbgBb2NUwcWxuVC1gEXuZHE1ti9rbQvNT
         uo8nH+wXGu+oUsX7A7vY9WIUVZVKV4aOciCvBtkhKmjI+t5BssnuebMycp6tMs9o48S0
         fdRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678737605;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bHnSJ1e/E/f4xbQ+Ey0bVRUJ3n2W/AmMQUXTjmDhfmk=;
        b=opuOkEDL7djwKi9NQxAxEsuSqMWTJqCIjakDn+1wajJCPeGDLX+FyR6vsvEhQNsapU
         YexjV2JtDBJFGut6ohNZ9h2C3Nc+s7HrXKWgmIhHjf4hpy+zJA/biD6ppNqnqeDWBacL
         YaOrHPtRhUc762v9lP5l/EoKPWFSxg3aL/amDcEJ5q0wqYJTzNX9NXzlJrSFkUEVKGyN
         JiXBg9aIY6LsQ+lrPRrhrbWeex6BsPxRDvq/muZmqM9VaTzHI1fwOEvlP6Ok48zxtVKo
         mtvqklM8Zfcjifk1Ign5UnPM+VYUFGETL6LXhwPI6tyLSm/pGNfAQoh8+jjBrHLlM7d2
         vvGw==
X-Gm-Message-State: AO0yUKX8XXD+4hE/yn/OJuxoAFhCy3p/IqUnE8bttvch+uMH7M0bMsFB
        Xyhnuu9Lpp34Rxy2nSqRE8iGMJ4bIYJvAeLJLLE=
X-Google-Smtp-Source: AK7set/6NIzv1wkDTpJexVpifIhx+PE3YBEjtG35kLxj6FmyPlKZRDqbi0kj3G5eeqNgCCqxD9PiHQ==
X-Received: by 2002:a05:6512:6f:b0:4e0:979d:56e8 with SMTP id i15-20020a056512006f00b004e0979d56e8mr10753094lfo.22.1678737604941;
        Mon, 13 Mar 2023 13:00:04 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id w3-20020ac254a3000000b004cc800b1f2csm75431lfk.238.2023.03.13.13.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 13:00:04 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v3 00/10] RPMPD cleanup + parent PD
Date:   Mon, 13 Mar 2023 20:59:58 +0100
Message-Id: <20230313-topic-rpmpd-v3-0-06a4f448ff90@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL6AD2QC/x2N0QrCMAwAf2Xk2UC7QBF/RXzI2ugCsyupjsHYv
 xt8vIPjDuhiKh1uwwEmm3ZdqwNdBsgz15egFmcYw0iBIuFnbZrR2rsVTBKJrymHyAm8mLgLTsY
 1z97U77K4bCZP3f+L++M8f2GDhT1yAAAA
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678737603; l=1263;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=gDR4PT1bA1uwqlfLZK1b3R+KYlvXlXj6DApjAqWby6I=;
 b=edhHbIiyPVNN6aiqCf6DwNkQvHmeBZ1CgQJ/PhQsSyyQmhQ/13Zu2kQC6KVkdMtLDzBAFcSbKlme
 V2GQNphfD5IZMVLltKnbD8ExTv4bCvT8OofLDj6MzXGa9L5RgD6L
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2 -> v3:
- Correctly include the missing first patch (this is very embarassing)
- Fix the _ao parent for SM6375_VDDGX
- Use b4, hopefully everybody gets all the patches now..

v2: https://lore.kernel.org/lkml/16950676-fef9-a3a0-0855-e4e6637711dd@linaro.org/T/#m829f7bfcf911f5e16d9f83aefe810e5dedc7453d

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (10):
      soc: qcom: rpmpd: Remove SoC names from RPMPD definitions
      soc: qcom: rpmpd: Bring all definitions to the top
      soc: qcom: rpmpd: Unify Low Power Island definitions
      soc: qcom: rpmpd: Remove vdd* from struct names
      soc: qcom: rpmpd: Expand struct definition macros
      soc: qcom: rpmpd: Improve the naming
      soc: qcom: rpmpd: Make bindings assignments consistent
      soc: qcom: rpmpd: Add parent PD support
      soc: qcom: rpmpd: Hook up VDDMX as parent of SM6375 VDDGX
      soc: qcom: rpmpd: Remove useless comments

 drivers/soc/qcom/rpmpd.c | 833 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 565 insertions(+), 268 deletions(-)
---
base-commit: 24469a0e5052ba01a35a15f104717a82b7a4798b
change-id: 20230313-topic-rpmpd-6e13a86c01a6

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

