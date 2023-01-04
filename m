Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1FA65CC94
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 06:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbjADFZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 00:25:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbjADFZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 00:25:24 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 273A3165B3
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 21:25:23 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id g7so26505226qts.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 21:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sparkcharge.io; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7Jhq/pw2LIewMUPxNIRMdD3RgjN1rXiHjc6S0VQdYuE=;
        b=OkrN5EnZ/2jBeyPq7SPG/utg+QQtvciEVRQq/aRCvQC+o7M6Ms5UNAcOKwqsOnA7/i
         3ItJyx3nI6HlzJF3XjCf+cFV/TGjqomaaYIjro7kcfYjQnZ1nI798v7d+NNC+RJKnwlZ
         INspYOxfoGCm+nUnyS/mJc0/IhfSJ7BINaJpaptw9iENqaDgGiRpD4I/LuUdmyuTcSma
         tyYJ7Q2I8TvXXygQwiVhEolYCfc4ZjaF8hpPK9U8UWU/zwpDgn7tax6yzY1WVbkLUdHj
         2Bb6y8DjzE184dq/qzsOI157bcdYtkjQgCeljDL2/qg2OlGkSOyDg+MUoE7GTE2NaXeO
         fbNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7Jhq/pw2LIewMUPxNIRMdD3RgjN1rXiHjc6S0VQdYuE=;
        b=WG1oLUPnfxhYFaZwzyebZFYRtYfbcWaPLufSLE8iKuG4VS4rZgUNerokecNFPQMT1P
         rPOegZPxl/RpZfQMZI8Un6iIx+lOlFAtK/6OaY2cwlkcNkWkQsW07onmk+RzGgyYRBu0
         JqwvDN/0Diqp/E8OmOgDp3BvoMN4dDR/6gc0oyXJbFlz/frtfdEuYxP4GcITKS9o+ozW
         1wlJTuTqdXcFa/eypKObIsz7SlMN5xFZYsm9z4rGyKgT5xnysu+lUjga8KokD9ujz7zN
         XCQgpCLkbSYQ0CSXdZF9kZB2uZI37UnpmlYux/fe/rqp+7v6tDkTeR2X4SzYPRVcDzg1
         NBfg==
X-Gm-Message-State: AFqh2kr+MtIVW6/23q+MtAGV+Cb1Q72ExIRmtARwVen5h2C6tm6vYucK
        ttvdrctIiq5EHYPEOg4Vv1YUu5kn/zxlVlLl7dc=
X-Google-Smtp-Source: AMrXdXtoZ66bE2K4ikfRccXOKBfpo6VPDZiECNNNR5ExuvMgcwoDpHF933S4rrJP9GcANPv2Xv/ATQ==
X-Received: by 2002:ac8:4542:0:b0:3a5:467b:c1d0 with SMTP id z2-20020ac84542000000b003a5467bc1d0mr51674485qtn.18.1672809922236;
        Tue, 03 Jan 2023 21:25:22 -0800 (PST)
Received: from localhost.localdomain (c-66-31-16-167.hsd1.ma.comcast.net. [66.31.16.167])
        by smtp.gmail.com with ESMTPSA id t1-20020ac865c1000000b003a7e4129f83sm19425602qto.85.2023.01.03.21.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 21:25:21 -0800 (PST)
From:   Dennis Lambe Jr <dennis@sparkcharge.io>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Atsushi Nemoto <anemo@mba.ocn.ne.jp>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        Dennis Lambe Jr <dennis@sparkcharge.io>
Subject: [PATCH v2 0/3] rtc: Set M41T82 & M41T83 xtal load capacitance from DT
Date:   Wed,  4 Jan 2023 05:25:03 +0000
Message-Id: <20230104052506.575619-1-dennis@sparkcharge.io>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I haven't heard any feedback on this series aside from the dt-bindings,
but with the holidays I'm not assuming that means they're perfect. I
don't want to sit on the fixes I've already incorporated any longer
though, so here's v2.

Changes in v2:
* dt-bindings: remove accidental wakeup-sources line
    suggested by Krzysztof Kozlowski
* spelling fixes in changelogs

The m41t82 and m41t83 have an adjustable internal capacitance that
defaults to 25 pF per xtal pin. This patch series adds the ability to
configure it via the devicetree.

Patch 1 just changes `#ifdef CONFIG_OF` to `if (IS_ENABLED(CONFIG_OF))`
in m41t80_probe() so that I don't need to use __maybe_unused on my new
functions and variables.

Patch 2 is the dt-bindings.

Patch 3 is the actual feature implementation.

The desired capacitance comes from the quartz-load-femtofarads property,
following the example of two other RTC ICs that have adjustable internal
load capacitance, the NXP pcf85063 and pcf8523. The m41t82 and m41t83
support much finer-grained control over the capacitance than those
chips, and ST calls the feature "analog calibration", but it looks to me
like it's essentially the same kind of thing.

My use case for this is:

ST specifies not to add any additional external load capacitance[1], but
the MikroElektronika RTC 9 Click board[2] has a 22 pF cap on each xtal
pin[3]. The resulting combined capacitance appears to be outside of the
operating range of the xtal, because when power is removed from the
boards I'm testing with, the RTC reports an Oscillator-Fail flag on the
next power on.

I found I could work around the problem by reducing the internal load
capacitance as low as it will go.

References:
[1] https://www.st.com/resource/en/application_note/an3060-applications-guide-for-serial-realtime-clocks-rtcs-stmicroelectronics.pdf
[2] https://www.mikroe.com/rtc-9-click
[3] https://download.mikroe.com/documents/add-on-boards/click/rtc-9/rtc-9-click-schematic-v100.pdf

Previous versions:
v1: https://lore.kernel.org/linux-rtc/20221219190915.3912384-1-dennis@sparkcharge.io/T/

Dennis Lambe Jr (3):
  rtc: m41t80: probe: use IS_ENABLED for CONFIG_OF
  dt-bindings: m41t80: add xtal load capacitance
  rtc: m41t80: set xtal load capacitance from DT

 .../devicetree/bindings/rtc/st,m41t80.yaml    | 16 ++++
 drivers/rtc/rtc-m41t80.c                      | 84 +++++++++++++++++--
 2 files changed, 92 insertions(+), 8 deletions(-)

-- 
2.25.1

