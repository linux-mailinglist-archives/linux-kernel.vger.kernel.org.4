Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D952D67A3B2
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 21:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjAXUPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 15:15:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjAXUOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 15:14:53 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B8221967;
        Tue, 24 Jan 2023 12:14:50 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id o13so16266027pjg.2;
        Tue, 24 Jan 2023 12:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C5m32FiMKqXgrZPIOI8wdtUKGLB4QIDnS37F9FnvXXw=;
        b=emoiTIhY0FSD928012exLT6mCVErO1zRatzTHxSx6mzkBx8K5JEC23e1PHEDe8IyfK
         Ens8RhvdraodZJVRsXXaRG0uQkYtyKR5BsM4AO09LRhQP9IrS38qTCCG2CZETFa6gfcq
         l1ch8AIBbUbjYEgf5mK+ccOIs+YP4MUmSMWq4ya+2N4fYZHcifTZ9vRopToCQEqnaoL7
         HJURR7f7UeQ75RI+F/d50HlFEnF2XT9aRqapekU3zaynvfyZz3d6NxezZ2S6dsOpFCcC
         Qjr/Ns+r2l1qtA66HXf3vR9VVlt7QDUByL/BB5nIX3JEGaVbuThy+SaDe00F1KRqckvd
         fhqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C5m32FiMKqXgrZPIOI8wdtUKGLB4QIDnS37F9FnvXXw=;
        b=tB6XtMNlFiFh1xhd7/UJtmq443NGgCc9z5tJ+1gzfM7eYnlkFJDZbq9Oob3qLFfwmS
         gDX5GvVyK55B7SRRqrcTSb8xSWUuBTOacFMkzrwoWOSRQ/5Dxaernn56oDDBE9oE+0wV
         1MUWyHmWJP7T1bjZkE0j7UeGna0dgWvYCRaX8XxT/Fw93QwMFYQaTRejRKYGRAoVWp7i
         BBU7k3vbFMokCw6MKLMHA5rXqinILcA9PGwRzwjLejvI8K8wvaXXK/xRzyhxmrI4rQxl
         pgdisfqonKdKJFPG9sIg5mopohcQHsv4aGxDHtqSg02G3sIEhJRXklefmmY+djQZMfvG
         qW1A==
X-Gm-Message-State: AFqh2kpFYsinsoFp1vWikc6DLiP5bmP9xP/YtpcdtfO1X6Vj8GbS88w3
        FhdclIQFTq+1OlG3mC0+IyA=
X-Google-Smtp-Source: AMrXdXsNjG5/QwjlMPDVD2ZxE/odHTNO/N9Li057a3kIE7Pft4N2cloLCNONh19BMoOkIT1MoFqfug==
X-Received: by 2002:a17:902:f789:b0:192:9550:339a with SMTP id q9-20020a170902f78900b001929550339amr32208745pln.52.1674591289938;
        Tue, 24 Jan 2023 12:14:49 -0800 (PST)
Received: from stbirv-lnx-3.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d13-20020a170902728d00b00174f61a7d09sm2057824pll.247.2023.01.24.12.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 12:14:49 -0800 (PST)
From:   Doug Berger <opendmb@gmail.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Brian Norris <computersforpeace@gmail.com>,
        Markus Mayer <mmayer@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Doug Berger <opendmb@gmail.com>
Subject: [PATCH v2 0/2] rtc: brcmstb-waketimer: add RTC alarm irq
Date:   Tue, 24 Jan 2023 12:14:28 -0800
Message-Id: <20230124201430.2502371-1-opendmb@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support is added for an interrupt that can be triggered from the
brcmstb-waketimer hardware while the system is awake.

This interrupt allows the driver to pass the rtctest selftest.

Changes in v2:
  - Squashed examples in the bindings document.
  - Added Ack from Florian

Doug Berger (2):
  dt-bindings: rtc: brcm,brcmstb-waketimer: add alarm interrupt
  rtc: brcmstb-waketimer: allow use as non-wake alarm

 .../bindings/rtc/brcm,brcmstb-waketimer.yaml  | 21 ++++---
 drivers/rtc/rtc-brcmstb-waketimer.c           | 55 ++++++++++++++++++-
 2 files changed, 66 insertions(+), 10 deletions(-)

-- 
2.25.1

