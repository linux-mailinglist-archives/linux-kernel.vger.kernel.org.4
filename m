Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A10CE679730
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 13:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233144AbjAXMDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 07:03:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232988AbjAXMDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 07:03:30 -0500
Received: from egress-ip33a.ess.de.barracuda.com (egress-ip33a.ess.de.barracuda.com [18.185.115.192])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7CAF2333A
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 04:03:28 -0800 (PST)
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197]) by mx-outbound45-230.eu-central-1c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Tue, 24 Jan 2023 12:03:26 +0000
Received: by mail-pf1-f197.google.com with SMTP id f15-20020a62380f000000b0058db55a8d7aso6776419pfa.21
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 04:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mistralsolutions.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=osGu55JV1XvVNpbaCozCNDJ2gx1vrYcjWaXSfznex/w=;
        b=F2+FyxxKmtlrYf3ZC9aaQplyu1GxzEWVY924HDNCAllGj1Dg0ZvvFNbVrzZkcxmVJ3
         M/fdlE3Ja+VcDTLtBIXu1npFIGUyGqt0BSKpdFcXxAqWwTFXkHJEWcSEutwJjLkMiUI9
         RBP7m8Akzt2dqpNdvKlKN2ajBGf0qpk3uBxSM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=osGu55JV1XvVNpbaCozCNDJ2gx1vrYcjWaXSfznex/w=;
        b=JQf+IgAk7sC7N4jMYcEiBZBquMjc4DtNn4Wa2vqG24Ns5oDSoOzHV3P5/WlXoEaTSb
         qF8ChVUrxZO5ymHDPoq2a+Il+02E2jsTYGxotYAU9LCJFFd/Jw+wIUnql1Ig3LLqdjLd
         s24C1naK6TT2B5Z25vFjCRV5l8CW6GThfLEJueLXuch6HT7VdIVFWuZThfdPcPKj9OiR
         fQ6Vn/MjEJPXYURVDtIPCrJ+li6mua6nDCPUvf31GjeLLjo/m8KN4X5AAPymb1lH5kyD
         mNGzbUa6RdMrCBc93cqwooQlnCUTe1+9FiFJpcoysvL2oqQ1g21llMwx4kGd+fpuUwrP
         c12g==
X-Gm-Message-State: AFqh2kpETiBUjrd7QQFVGgldQEywRHI35cgg9SdQ5At3AJfimor8sisD
        fKTXE2bpdzjbeqRJd2n14B094pdd49PWmtA4W70A4di4WvaQuAgmipfBA4zMm6lwyuDQqMZYcrS
        ZdyrVTKcbBlE3YiQhd982rN/DoR56Ko4EDHZKKLhJFAHCeNrBjCu4L+ymgNTv
X-Received: by 2002:a05:6a00:3495:b0:58d:d7b6:cf58 with SMTP id cp21-20020a056a00349500b0058dd7b6cf58mr29872765pfb.7.1674561804894;
        Tue, 24 Jan 2023 04:03:24 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsucmBns/vx9fApBY53Y+ikT7NN4RMfqdW/THh2+A+fsOY8upHDKklY2XmD56JvFsii2WB9aQ==
X-Received: by 2002:a05:6a00:3495:b0:58d:d7b6:cf58 with SMTP id cp21-20020a056a00349500b0058dd7b6cf58mr29872746pfb.7.1674561804615;
        Tue, 24 Jan 2023 04:03:24 -0800 (PST)
Received: from LAP568U.mistral.in ([106.51.227.150])
        by smtp.gmail.com with ESMTPSA id j10-20020aa783ca000000b00581ad007a9fsm1414539pfn.153.2023.01.24.04.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 04:03:24 -0800 (PST)
From:   Sinthu Raja <sinthu.raja@mistralsolutions.com>
X-Google-Original-From: Sinthu Raja <sinthu.raja@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sinthu Raja <sinthu.raja@ti.com>
Subject: [PATCH V2 0/2] Fix WKUP domain IO PADCONFIG size issue and RPi header support 
Date:   Tue, 24 Jan 2023 17:33:09 +0530
Message-Id: <20230124120311.7323-1-sinthu.raja@ti.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BESS-ID: 1674561805-311750-5377-717-1
X-BESS-VER: 2019.1_20221214.2106
X-BESS-Apparent-Source-IP: 209.85.210.197
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.245676 [from 
        cloudscan23-101.eu-central-1b.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS91090 scores of KILL_LEVEL=7.0 tests=BSF_SC0_MISMATCH_TO, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sinthu Raja <sinthu.raja@ti.com>

Hi All,
This patch series fix the incorrect IO PADCONFIG offset size of the
wakeup domain for J721S2 SoC and add RPi expansion header support for
AM68 SK.

Changes in V2:
- Update commit description.
- Update the offset value to 0x194 as 0x190 is the last register of the
  IO PADCONFIG register set.

V1: https://lore.kernel.org/all/20230123135831.4184-1-sinthu.raja@ti.com/

Sinthu Raja (2):
  arm64: dts: ti: k3-j721s2-mcu-wakeup: Fix IO PADCONFIG size for wakeup
    domain
  arm64: dts: ti: k3-am68-sk-base-board: Add pinmux for RPi Header

 .../boot/dts/ti/k3-am68-sk-base-board.dts     | 70 ++++++++++++++++++-
 .../boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi     |  2 +-
 2 files changed, 70 insertions(+), 2 deletions(-)

-- 
2.36.1

