Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 810EB743DAC
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 16:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232697AbjF3Oke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 10:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232543AbjF3Ok3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 10:40:29 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F48335BC
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 07:40:26 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f86e6e4038so2424537e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 07:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1688136025; x=1690728025;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YvEx3RaTLGXPx4GzzRnbkgUJYYMtxml/54Bl1CcEZSU=;
        b=AGtbxnHKbXaWDDdI8S9Gfw2SSp6vXWkCQ2I3RuRmVEe4mDJpKStORqSIb/0DH9M7M7
         rbs2QjGqZYrzqC7KSBkomRkh2OfiqGFAMcsE/qUgf2HO1OtoAdJjLJxNwmMFJ6rr0oM4
         4FM+e1YIyT+MtwEewTmbS60Y0C528V8/fFeN9lMuRCo4/ycd6GoZayeG5GzzndHmrgG4
         si/NL6s1UxvF9Mnoy95Nsc7rpPyIZ6EKu1GL+JwdsXD9QE6IBG6gul0rb2gP2OVHJ22m
         /kS7kao9gf3Wc18SDr9c7sC75+xLDhuuCcJy73G0pcH9Y7cSB8xPgLKtab08OwvIbgcP
         qGvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688136025; x=1690728025;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YvEx3RaTLGXPx4GzzRnbkgUJYYMtxml/54Bl1CcEZSU=;
        b=ONMXnNXv7LwaGeb56VkdjETunodE8VO8U5mhimatVcqCgWLDe1dXfyUcQ45Iqpf+Ri
         HmUBVv5wBukKWyiZ0pWrHBK9AzM6NKeXOv/71UC4EForcChdqYiGJSEiX2ixdpdHludA
         pLOUqGQr/F4sh0XRYaTgE2Pk0glvkkmCDnzBChzCc0AKUQm7zjmiELSM/f5+aNt/5wlf
         yj7nyajkUsTL7qSb7eNlSbGSaOKzEQfjtlYbuMQkpzZOL1lBK7CvijBbjCTPY4WNBkat
         2VBWUQvvRzRRov1yL5S5IJNOjoY7iP/YrLDtIkWw+87ewzZaAe39WYJLpyN6trs7XMi2
         PMyA==
X-Gm-Message-State: AC+VfDz2oA8JioLfniWu3yVMB4UExCtzz1POzcyG58R/qpSRTak81nq1
        404IY9LyHplza6ZjErKXYpoTtg==
X-Google-Smtp-Source: ACHHUZ6ICKaLNAzs2Em4En8f9SO77xD+3Sm7yrZR8UCALUDwn9rHYUDGwTeKvmwSMroxzeXy90sagA==
X-Received: by 2002:a05:6512:1049:b0:4f6:1307:80b0 with SMTP id c9-20020a056512104900b004f6130780b0mr2606438lfb.12.1688136024576;
        Fri, 30 Jun 2023 07:40:24 -0700 (PDT)
Received: from panikiel.roam.corp.google.com (staticline-31-182-201-26.toya.net.pl. [31.182.201.26])
        by smtp.gmail.com with ESMTPSA id b7-20020a056512024700b004f85d80ca64sm2750402lfo.221.2023.06.30.07.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 07:40:24 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Anikiel?= <pan@semihalf.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Cc:     dinguyen@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        mchehab@kernel.org, upstream@semihalf.com, amstan@chromium.org,
        ribalda@chromium.org,
        =?UTF-8?q?Pawe=C5=82=20Anikiel?= <pan@semihalf.com>
Subject: [RFC PATCH 0/3] Google Chameleon v3 video driver
Date:   Fri, 30 Jun 2023 16:40:03 +0200
Message-ID: <20230630144006.1513270-1-pan@semihalf.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The Google Chameleon v3 is a testing device for external displays. It
is based on an Arria 10 SoCFPGA. This patch adds a V4L2 driver for the
video system. The video system consists of:
  * Six video interfaces (DMA ping pong buffers) in the FPGA, called
  "framebuffers".
  * Two Intel DisplayPort DPRX IP cores in the FPGA, one MST x4, one SST
  * IT68051 chip, handled by EC firmware

The driver is implemented as a single device driver, because the video
interface devices need to talk to the DisplayPort IP core devices
(e.g. to configure the EDID). This has the effect of the DPRX driver
being in the chameleonv3 directory even though it's an Intel IP.

The DPRX code handles all the AUX communication (DPCD, sideband messages,
message transfers). There is similarity to what's already present in
the DRM subsystem, but I found it hard to reuse that code effectively.

My main concern is with the overall structure of the driver - how it's
divided into parts, the interfaces and APIs used, etc. Any feedback is
greately appreciated.

Paweł Anikiel (3):
  media: Add 10, 12, and 16 bit RGB formats
  media: Add Google Chameleon v3 video driver
  ARM: dts: Add Chameleon v3 video node

 .../socfpga/socfpga_arria10_chameleonv3.dts   |  54 ++
 drivers/media/platform/Kconfig                |   1 +
 drivers/media/platform/Makefile               |   1 +
 drivers/media/platform/google/Kconfig         |   4 +
 drivers/media/platform/google/Makefile        |   2 +
 .../media/platform/google/chameleonv3/Kconfig |   9 +
 .../platform/google/chameleonv3/Makefile      |  15 +
 .../platform/google/chameleonv3/chv3-core.c   | 292 ++++++++++
 .../platform/google/chameleonv3/chv3-core.h   |  17 +
 .../platform/google/chameleonv3/chv3-fb.c     | 539 ++++++++++++++++++
 .../platform/google/chameleonv3/chv3-fb.h     |  34 ++
 .../platform/google/chameleonv3/dprx-aux.c    |  77 +++
 .../platform/google/chameleonv3/dprx-dp.c     |  82 +++
 .../platform/google/chameleonv3/dprx-dpcd.c   | 424 ++++++++++++++
 .../platform/google/chameleonv3/dprx-dprx.c   | 262 +++++++++
 .../platform/google/chameleonv3/dprx-edid.c   |  39 ++
 .../platform/google/chameleonv3/dprx-i2c.c    |  41 ++
 .../platform/google/chameleonv3/dprx-mt.c     | 184 ++++++
 .../platform/google/chameleonv3/dprx-sbmsg.c  | 162 ++++++
 .../media/platform/google/chameleonv3/dprx.h  | 128 +++++
 drivers/media/v4l2-core/v4l2-ioctl.c          |   5 +
 include/uapi/linux/videodev2.h                |   5 +
 22 files changed, 2377 insertions(+)
 create mode 100644 drivers/media/platform/google/Kconfig
 create mode 100644 drivers/media/platform/google/Makefile
 create mode 100644 drivers/media/platform/google/chameleonv3/Kconfig
 create mode 100644 drivers/media/platform/google/chameleonv3/Makefile
 create mode 100644 drivers/media/platform/google/chameleonv3/chv3-core.c
 create mode 100644 drivers/media/platform/google/chameleonv3/chv3-core.h
 create mode 100644 drivers/media/platform/google/chameleonv3/chv3-fb.c
 create mode 100644 drivers/media/platform/google/chameleonv3/chv3-fb.h
 create mode 100644 drivers/media/platform/google/chameleonv3/dprx-aux.c
 create mode 100644 drivers/media/platform/google/chameleonv3/dprx-dp.c
 create mode 100644 drivers/media/platform/google/chameleonv3/dprx-dpcd.c
 create mode 100644 drivers/media/platform/google/chameleonv3/dprx-dprx.c
 create mode 100644 drivers/media/platform/google/chameleonv3/dprx-edid.c
 create mode 100644 drivers/media/platform/google/chameleonv3/dprx-i2c.c
 create mode 100644 drivers/media/platform/google/chameleonv3/dprx-mt.c
 create mode 100644 drivers/media/platform/google/chameleonv3/dprx-sbmsg.c
 create mode 100644 drivers/media/platform/google/chameleonv3/dprx.h

-- 
2.41.0.255.g8b1d071c50-goog

