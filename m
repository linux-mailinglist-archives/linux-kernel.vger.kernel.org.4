Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7F4B673AFC
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 15:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbjASOB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 09:01:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbjASOBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 09:01:45 -0500
Received: from egress-ip4b.ess.de.barracuda.com (egress-ip4b.ess.de.barracuda.com [18.185.115.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F2D75705
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 06:01:43 -0800 (PST)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200]) by mx-outbound46-115.eu-central-1c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 19 Jan 2023 14:01:36 +0000
Received: by mail-il1-f200.google.com with SMTP id j11-20020a056e02218b00b0030f3e7a27a8so1245666ila.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 06:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mistralsolutions.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S5Dnbj8sisco/i4YFV1WcqmiOc2NEx4SCPfOz1HU9JA=;
        b=gWXXm17rHJSae0PBGHiKc0vl/GgtNgK7En+m/PrsQLeJHKl4CGg5PTJUXo4hXMUlMi
         oPYEMn52b+d8tRyNBhqjSFOsO0BIhLB9YbEwy7o4WxEPognJQKiACQmLcvbIpc9fzmx5
         NLm/hoTlT6QWutSi8nIfRYJNKUcD681mD3Lqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S5Dnbj8sisco/i4YFV1WcqmiOc2NEx4SCPfOz1HU9JA=;
        b=KYWZtRQJ64UnCpnkPHg+/npxxxGbX2SGUC1I3ZabUFewyKtrEwonYTxsy8MAGHLl4F
         AEbiZDxYhFNF1n1vkSsdOl7BEJgJNVKbo609TweAYJ+yX6ph6J/fvL+YB4YWOyJMaAGw
         mNbUCDJxeZ5vbILWfDbYETQP/oozITfjsqHucTH1gOu8BDJrWLsZgFsQcwwLt6iU/K/1
         iEpQuxip1/by2Fct7lrkOUHVg7OU3VfHptwCJI9ARu4hSuvZQOT5aWea0N8R016+583D
         Y79Vxg9tHqeOf9O5GHQEZB8fMfjALIK02ytO9ruTCFddiXSOLIMBwvT75YLrVaBR85tM
         jhsQ==
X-Gm-Message-State: AFqh2korj6fCT3C583xlun0iaBYlsmEUdZzmC3Xbwc3bFcf8lTKHcgp0
        +R5cpeu6dzN0SzG5DFWOEKmHlaGZF94rTASL7U/skMZmeZ2nra4eUf2qpkq8TP03p0X5Ih36IDZ
        xfWbX3vDkMge9wx7MnICIbWQuvKWbCqBD53LIyitu7RifQUrPszXxVkkixzFg
X-Received: by 2002:a05:6a00:2191:b0:581:19ed:78b9 with SMTP id h17-20020a056a00219100b0058119ed78b9mr14471492pfi.2.1674135056846;
        Thu, 19 Jan 2023 05:30:56 -0800 (PST)
X-Google-Smtp-Source: AMrXdXt6odXiYivIXadPlUiV9raajuBxV/XBFOtguIfDNs8MLkIVVyiXrglXRQCD9iItCg1BMDtXYA==
X-Received: by 2002:a05:6a00:2191:b0:581:19ed:78b9 with SMTP id h17-20020a056a00219100b0058119ed78b9mr14471468pfi.2.1674135056517;
        Thu, 19 Jan 2023 05:30:56 -0800 (PST)
Received: from LAP789U.mistral.in ([106.51.227.150])
        by smtp.gmail.com with ESMTPSA id l123-20020a622581000000b005818d429d98sm23949210pfl.136.2023.01.19.05.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 05:30:56 -0800 (PST)
From:   sabiya.d@mistralsolutions.com
X-Google-Original-From: sabiya.d@ti.com
To:     nm@ti.com, vigneshr@ti.com, kristo@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linus.walleij@linaro.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Dasnavis Sabiya <sabiya.d@ti.com>
Subject: [PATCH 0/2] Add initial support for AM69 Starter Kit
Date:   Thu, 19 Jan 2023 18:59:56 +0530
Message-Id: <20230119132958.124435-1-sabiya.d@ti.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BESS-ID: 1674136895-311891-5421-9688-1
X-BESS-VER: 2019.1_20221214.2106
X-BESS-Apparent-Source-IP: 209.85.166.200
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.245567 [from 
        cloudscan19-133.eu-central-1b.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        0.00 NO_REAL_NAME           HEADER: From: does not include a real name 
        0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS91090 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, NO_REAL_NAME, BSF_SC0_MISMATCH_TO
X-BESS-BRTS-Status: 1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dasnavis Sabiya <sabiya.d@ti.com>

AM69 Starter Kit is a single board designed based on TI's AM69 SOC
providing advanced system integration in automotive ADAS applications,
autonomous mobile robot and edge AI applications. The SOC comprises
of Cortex-A72s in dual clusters, lockstep capable dual Cortex-R5F MCUs,
Vision Processing Accelerators (VPAC) with Image Signal Processor (ISP)
and multiple vision assist accelerators, Depth and Motion Processing
Accelerators (DMPAC), Deep-learning Matrix Multiply Accelerator(MMA)
and C7x floating point vector DSP

Refer below link to AM69 Technical Reference Manual for further details:
https://www.ti.com/lit/zip/spruj52

AM69 SK supports the following interfaces:
       * 32 GB LPDDR4 RAM
       * x1 Gigabit Ethernet interface
       * x3 USB 3.0 Type-A ports
       * x1 USB 3.0 Type-C port
       * x1 UHS-1 capable micro-SD card slot
       * x4 MCAN instances
       * 32 GB eMMC Flash
       * 512 Mbit OSPI flash
       * x2 Display connectors
       * x1 PCIe M.2 M Key
       * x1 PCIe M.2 E Key
       * x1 4L PCIe Card Slot
       * x3 CSI2 Camera interface
       * 40-pin Raspberry Pi header

This patch series add initial support for AM69 Starter Kit.

Design Files can be referred from https://www.ti.com/lit/zip/SPRR466

bootlog: https://rentry.co/coyvw/raw

Dasnavis Sabiya (2):
  dt-bindings: arm: ti: Add binding for AM69 Starter Kit
  arch: arm64: dts: Add support for AM69 Starter Kit

 .../devicetree/bindings/arm/ti/k3.yaml        |   1 +
 arch/arm64/boot/dts/ti/Makefile               |   1 +
 arch/arm64/boot/dts/ti/k3-am69-sk.dts         | 180 ++++++++++++++++++
 3 files changed, 182 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am69-sk.dts

-- 
2.25.1

