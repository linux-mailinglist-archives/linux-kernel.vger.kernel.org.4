Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2541B6DB9ED
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 11:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjDHJru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 05:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjDHJrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 05:47:48 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F9ACCC2C;
        Sat,  8 Apr 2023 02:47:47 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-50489a2bc4dso208389a12.0;
        Sat, 08 Apr 2023 02:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680947265; x=1683539265;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0V+79f1G4EAx5wqA50mN9ZgwAmoB9D1BTsUKh1syJbQ=;
        b=Lg5qgz6geHqN2+2ckjZRVy55WQ+OScakxL3RdFKWObkihkC1OoB7qyJsweOcRsXKXm
         J7J30IGbxio4s0O2uc2DnoB3QsIFfcafpI0IaQnYHl2DwVBVKHlmiCWM/OsMkHDHzvTZ
         bgvgik6N/BR7PMYmTcd/yT5Qimb92ppB97DN3+Zcu3KlzKAKDDGSsO0ecBIw589+wA2u
         LuNCyfVtljT5VFWcLhnTqv0cXR63Y3lZpTuYL/x0B1Q1h42c3B+TZCrKAIe9Yx0rNIxp
         4nOU8OQVOy1j1PqJAwyDyHSf0Boj4f565P5H+SCYJ+lb+Adh7eBmhCwdRnAQH+GStS9S
         IG4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680947265; x=1683539265;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0V+79f1G4EAx5wqA50mN9ZgwAmoB9D1BTsUKh1syJbQ=;
        b=KnU9pDFF2fzsxfSRPMaYtmR5h2fC+Rkyelc85SKQSJnRZF/draeaDlGzW+wWIV6OoI
         tk96YUoiLngYk76F450TC7ZvwxqIRgP2rX6USyVuEbxms94+JtqcHVOHeQWk5FurHiIz
         96kcdIlA35PFn1YLSFaUMNpaatZLLUBtpXA2d0f1ty9FDlwDLIQYn7srijTYMxfqFpiR
         H6PeRKYBR+mxbpBQ6gCnhVpXfP5GAu9vGj59pVrnkR3FK6oNHyolYlNgd8utfKzzC82x
         Vi0ahTvEcD9BN6caS6Y8TdD4tXdPV4nVM0p11qKoEuRPs7Gme3jD7SinfdrHNMoLwXqa
         Tk9Q==
X-Gm-Message-State: AAQBX9cB7fYFERvDc9h7v8QvCT9cPPAAS9YwxIPXPzW4foPDjOyIdIgT
        NxcNUAEIUPphel34ErfGQc0=
X-Google-Smtp-Source: AKy350aO6nEUzOn+aw43GnZc6FMfCEr85RtCi/zar/Ozjicrn6tG3oe1Vw38FFJncCsIk7dgVE1utA==
X-Received: by 2002:a05:6402:32c:b0:501:d43e:d1e3 with SMTP id q12-20020a056402032c00b00501d43ed1e3mr4418282edw.8.1680947265509;
        Sat, 08 Apr 2023 02:47:45 -0700 (PDT)
Received: from xeon.. ([188.163.112.79])
        by smtp.gmail.com with ESMTPSA id a21-20020a50c315000000b0050481736f0csm982297edb.12.2023.04.08.02.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Apr 2023 02:47:45 -0700 (PDT)
From:   Svyatoslav Ryhel <clamor95@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v1 0/2] Support bridge/connector by Tegra HDMI
Date:   Sat,  8 Apr 2023 12:47:21 +0300
Message-Id: <20230408094723.12733-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
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

Maxim Schwalm (1):
  drm/tegra: output: hdmi: Support bridge/connector

Svyatoslav Ryhel (1):
  ARM: tegra: transformers: add connector node

 arch/arm/boot/dts/tegra20-asus-tf101.dts      | 22 ++++++++--
 .../dts/tegra30-asus-transformer-common.dtsi  | 21 ++++++++-
 drivers/gpu/drm/tegra/hdmi.c                  | 44 ++++++++++++++-----
 3 files changed, 71 insertions(+), 16 deletions(-)

-- 
2.37.2

