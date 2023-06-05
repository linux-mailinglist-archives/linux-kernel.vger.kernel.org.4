Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD900723337
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 00:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232454AbjFEWdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 18:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbjFEWdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 18:33:38 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45BA3F3;
        Mon,  5 Jun 2023 15:33:37 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-19f45faedfbso4632378fac.0;
        Mon, 05 Jun 2023 15:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686004416; x=1688596416;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vQxa/fmka7J7RPQ2CV1GXa6rhxIe+rvJQHJ44oqnYx8=;
        b=RgIQL4S9TN+7yVQuGo/j2RqLl4rGO9cYiZwKDZQaDXoieg3tYObGLk2qJmZbmZFDkt
         BOOJ6e8q9jDZXtYGyp0CwoC4VRbJZCCDyoXkA/gqNCKZD0Fco0GzMppY3qNPtQQV8hEf
         c/fk6CjGopQo34Y1+dI0fb9o1lvrnIF84VM5M4aNk/56yriGwUchUPkH1Dqnai3EoBNw
         8w0tBk3tdjoI9fZ7ktVda5qyQdPtvF5B2k+M9Yth644fLKQAM9CxP3tEpxFJti/KT54l
         GyP9VrwUhlTverNxRHCktiRaMZSiyi2iUziszxq/MxOXh9JY9JqpiqjUCse25HqXiA0x
         vJOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686004416; x=1688596416;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vQxa/fmka7J7RPQ2CV1GXa6rhxIe+rvJQHJ44oqnYx8=;
        b=EZevgP1P2lT58Uwf7sSq3fhEybqRDBp4FK3usZ9QqBrvVyrItJSh2cb/dnhNr5KZsG
         pEUxAunf7WEuEjob4GBCZnyoTXMkiXwXf8WSnnWtJVn5Y2N74GFez7PhMGJbLfIKCrTk
         2NxaxMAECz5Wuu2sv6QG7h0PwOoBzD+KaRxi28L2DELwfbmjHjtKJds37VQkh+8cSLFR
         Rts2PWNBtyQ4lxxFdFstXrrTp7M8fhASjysAKa6yEIkkEFod6Bsz8Mlr9hTPdbqARWx6
         l8otOYkHpaHggeALhCVj4rzG7017V0K3x3wqdSs8TAcW+oaEaym0qeZJIBPgVHQdlaHM
         u/ZA==
X-Gm-Message-State: AC+VfDzRCPI3K6xO2EJT7XTSfbvejJtENqdvJg2FtuPpnGjCnBA+VH/T
        9j1VSVe2cK7ZlrjMR3JHPZg=
X-Google-Smtp-Source: ACHHUZ7g4V0U+36yVPM9bdXetRioOM+IdNC3lNRdt6ZyvQxf5S6ZEO7mPz4U/Ie66MjtgjxH9UbI8A==
X-Received: by 2002:a05:6870:628b:b0:19f:8798:3da5 with SMTP id s11-20020a056870628b00b0019f87983da5mr362445oan.11.1686004416062;
        Mon, 05 Jun 2023 15:33:36 -0700 (PDT)
Received: from aford-B741.lan ([2601:447:d001:897f:f45b:1201:1374:ebd2])
        by smtp.gmail.com with ESMTPSA id j13-20020a02a68d000000b004035b26b6d8sm2477068jam.2.2023.06.05.15.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 15:33:35 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 0/2]  arm64: dts: imx8mn/imx8mm-beacon:  Add HDMI
Date:   Mon,  5 Jun 2023 17:33:21 -0500
Message-Id: <20230605223323.578198-1-aford173@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DSI updates are in the DRM tree and Linux next with some updates
that now allow the DSI to connect to an HDMI bridge and successfully
sync displays at various resolutions and refresh rates with audio
and hot-plug detection.

Adam Ford (2):
  arm64: dts: imx8mn-beacon: Add HDMI video with sound
  arm64: dts: imx8mm-beacon: Add HDMI video with sound

 .../boot/dts/freescale/imx8mm-beacon-kit.dts  | 132 +++++++++++++++++
 .../boot/dts/freescale/imx8mn-beacon-kit.dts  | 134 ++++++++++++++++++
 2 files changed, 266 insertions(+)


---
V2:  Make 'compatible' the first thing in the new nodes.
-- 
2.39.2

