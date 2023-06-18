Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE784734592
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 10:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjFRIvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 04:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjFRIvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 04:51:07 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A7BC10E5;
        Sun, 18 Jun 2023 01:51:06 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-31121494630so2487436f8f.3;
        Sun, 18 Jun 2023 01:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687078265; x=1689670265;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hmc9IwyZl6aMz+KHuXZhLsJGDOxYITeiAy/9M75qrxE=;
        b=VArv5XEhbOMuRXTW55GI+jRO4qe5OYFVNPVGTpFHwWDLn8S0VUKNbJeCMXjvg7w+sc
         P/Ec7YXrTzM53w9WOG9vAxSxIcFgOIh4NlzTjM0FZNFaRtXuiDGxnhpFAxKnDCvfgEes
         k6tTxRvnhXCBTSBdJX7KZB658yHm99szm/nabNM9QrUvl6V5pb6JbjhGfqbgadF4KTEQ
         W6ye1FLWjzYGKVRL/c+oaNHaJBcyOrFjpcMwcajZ7dYc3WD3ssLQpFwqrmvU8nGzk47X
         x4hZN+FGUxIAjhbjngndMs3HmG/MaXQuhR9y5OWrt/fzBZrEcuW8/IiwwAD6g2jkpEnO
         9CaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687078265; x=1689670265;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hmc9IwyZl6aMz+KHuXZhLsJGDOxYITeiAy/9M75qrxE=;
        b=DzYUR9qW1Wjqzpm/90A+8Y4ybKJ6z4p013fTwObKmETpVTN8dcDMwUEMEAJoXkCwLl
         q3NeBPvnQzR8Yj8dEGrEF5fq3jEs1KBVgzk8eg4Iadwj6pLLYAQraVjssn134VrcZPb0
         zrgJUei51KhKlRwDinr3i0EuG4gAX45LzSZlvsY1XmaxNVoBap04oRO9Uus85cdQc5qw
         Na3hFyeva1Vf4aBusXCYzcK/OT/NlKMKKPoqeMYum8BTxKoBdAKZ6/sLnew7VXchnKVP
         +rnqhrYiAPVVi2eb6o1lqXrkpX+vjZJpO/FaLzy9DijVwz+Xn1D+3YAMhg9Carry5fyi
         bBzg==
X-Gm-Message-State: AC+VfDxXga9luVwzcg84q4CRodGcw9uGuaO4ZN/dfz4e0vp9MWx7KuZS
        XCho24/oGD42iqK6pz4x0hw=
X-Google-Smtp-Source: ACHHUZ7ZV2jv1bt3JkvDFrYiAOcgGWw3QfOIOC2rnUu8s56kb/wlRP2xNkdJNi1qE4j6UrSMHWReLg==
X-Received: by 2002:a5d:534f:0:b0:30f:d86b:ccab with SMTP id t15-20020a5d534f000000b0030fd86bccabmr6034312wrv.1.1687078264482;
        Sun, 18 Jun 2023 01:51:04 -0700 (PDT)
Received: from xeon.. ([188.163.112.79])
        by smtp.gmail.com with ESMTPSA id i17-20020adfded1000000b00301a351a8d6sm6953550wrn.84.2023.06.18.01.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jun 2023 01:51:04 -0700 (PDT)
From:   Svyatoslav Ryhel <clamor95@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v2 0/2] Support bridge/connector by Tegra HDMI
Date:   Sun, 18 Jun 2023 11:50:44 +0300
Message-Id: <20230618085046.10081-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for the bridge/connector attached to the
HDMI output, allowing to model the hardware properly. It keeps
backwards compatibility with existing bindings and is required
by devices which have a simple or MHL bridge connected to HDMI
output like ASUS P1801-T or LG P880/P895 or HTC One X.

Tested on ASUS Transformers which have no dedicated bridge but
have type d HDMI connector directly available. Tests went smoothly.

---

Chandes from v1:
- no changes, re-sending

---

Maxim Schwalm (1):
  drm/tegra: output: hdmi: Support bridge/connector

Svyatoslav Ryhel (1):
  ARM: tegra: transformers: add connector node

 arch/arm/boot/dts/tegra20-asus-tf101.dts      | 22 ++++++++--
 .../dts/tegra30-asus-transformer-common.dtsi  | 21 ++++++++-
 drivers/gpu/drm/tegra/hdmi.c                  | 44 ++++++++++++++-----
 3 files changed, 71 insertions(+), 16 deletions(-)

-- 
2.39.2

