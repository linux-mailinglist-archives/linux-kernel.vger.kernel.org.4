Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 575AF74C0BF
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 05:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjGIDsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 23:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjGIDsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 23:48:12 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0026AE4A
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jul 2023 20:48:10 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b702319893so50571381fa.3
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jul 2023 20:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688874489; x=1691466489;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lHMHHcNuRvKs17O5H9Ea+cH4a86VTRSbAhgkLKrkiBM=;
        b=vp32x5VTHQHEMvKnz68U6vXivWdMI6qh1B3mkwEWZO+uI4ak8cCtUuP/XpJ+iC1Nfp
         ++Aa1ry13ZwNVGM0fWqZTwtLYGxfJ6wk7+ctjP18PA9E59UYzK3mhm8rygS1aR3Fc2Y3
         eUCvcFaRaWZy6RNgDx9aLU7qxRM7I89SjFtGlke45GhPtFHVu2mZC6XsBgdKv2CEuC9P
         zfeoF2t8uAmgB4ABvIofkkEh9n1xw9NE1Dhga2MQkE/Ikjx15lAC9qF7fojUKc/+l3vR
         t+baHeTQpMY3S27fAOACVBZPG5BY+foLLygVw2wKOPnxvcG4lW9omjltYZ8sFO9dotuj
         g6EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688874489; x=1691466489;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lHMHHcNuRvKs17O5H9Ea+cH4a86VTRSbAhgkLKrkiBM=;
        b=hfa/Be5DPzFRuFP86vRA9yIGR8tm3D2KPzf1PA0Xq9/Uv9+BkHIvejjG0NJLoQMRgU
         6C3mUdnZj3oXRJzKL2BdtfyFIWpLTN7epBLl79GM3CyarkEq9vlk6JRSI+uLxEfu1Zoy
         6jUyGco78omTTdksCw3m3EUOHRcKSRPryGYkw5iXbP6ednUgnJn3EhiCHXWTBirIH+Hl
         X72zZlWFyWmP8npnORaPTw3j3vnCbTSG1uBZ+TgsNgx5nwZxdbevaEJrLee8/sx6UfKl
         sJlxWzgs5WiRtd2O3Gp0O2OL1rmjFQ/FRn0Cx299S54IdB52rcjmNG/l7xCcCQz4DQhQ
         6J3A==
X-Gm-Message-State: ABy/qLbaeT3CztUJXO7aZhuqFNOLO1VVKBBssgfLV+kvm0U59K8+sHTP
        bL9+R2wlx5aO7vbgmw3ICctTlA==
X-Google-Smtp-Source: APBJJlErrQQeAWc9qzYKimAILyOV7ytsRAPqBiJVXTpxGOXdF2oRl7XwOeQycxATBQcYP6Fjlcus6w==
X-Received: by 2002:a2e:94c3:0:b0:2b6:dc84:b93e with SMTP id r3-20020a2e94c3000000b002b6dc84b93emr6513320ljh.21.1688874489036;
        Sat, 08 Jul 2023 20:48:09 -0700 (PDT)
Received: from lothlorien.lan (dzdqv0yyyyyyyyyyybm5y-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::ab2])
        by smtp.gmail.com with ESMTPSA id u23-20020a2e9b17000000b002b70206cd45sm1398633lji.90.2023.07.08.20.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jul 2023 20:48:08 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH 0/2] usb: typec: qcom-pmic-typec: enable DP support
Date:   Sun,  9 Jul 2023 06:48:06 +0300
Message-Id: <20230709034808.4049383-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To enable DisplayPort on the platforms supported by qcom-pmic-typec
driver, we need to register a corresponding drm_bridge for this device
and also be able to send the OOB hotplug event to the corresponding DRM
connector. All this is implemented by [1], but there is no direct
dependency on that patchset.

[1] https://patchwork.freedesktop.org/series/120393/

Dmitry Baryshkov (2):
  usb: typec: altmodes/displayport: add support for embedded DP cases
  usb: typec: qcom-pmic-typec: register drm_bridge

 drivers/usb/typec/altmodes/displayport.c      |  5 +++-
 drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c | 25 +++++++++++++++++++
 2 files changed, 29 insertions(+), 1 deletion(-)

-- 
2.39.2

