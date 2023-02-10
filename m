Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 765A4691D01
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 11:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbjBJKiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 05:38:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbjBJKis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 05:38:48 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A9BD30C4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 02:38:47 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id v3so3196957pfn.6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 02:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ufispace-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nq1A52HyPQ5ZJyvE3xyTJAITHc2QB2emFWUPFKG5KFI=;
        b=x98gOVnwRN1wtMLo1EqRtcRx6sR52zIeCiZR9RiVjTGlwUjK1suW/T//IdwqyaPuyG
         N0TvrmBv6ohghhZtULX1QdppYVCL8+nxq8EU1r4tIHz4kdSTaidlUTl2X8ZW5rQY8Jbw
         Uenng2M3rWKGxnNH6yfDiqOtu+MxRPOgrvaQ6+xQg9gRdZu/dd2TeJhiIViDYg3kJn/e
         sTWCxPsd2VbXIdHArvsvvqhAfoS4M0+SbWuJ7ldJw3qZv8FBPyj7mk9IZ0B2X+Jgndon
         Yo3quP6cZJ05Rvjylb657HdNFZa6Cr3x/PFtKO7j2oEWuRnPpIpqJ8oGN6oxCSBu+S1K
         lrkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nq1A52HyPQ5ZJyvE3xyTJAITHc2QB2emFWUPFKG5KFI=;
        b=g1AhFgJFDVIDzNUP02DnV9/+EkHwXh8VTRDU7htJ3QMnkmDNw3HGL/m1OiY6wJY7Ga
         xrrzUbenf7qdapFAxqP2Kaz4kBI0hwBxjz5Rv/CpX67WqRTsJ+HCc9sEPtctSObuSksb
         9u2ZgVWi4hXy8DPI1HXAYvsFadRL551sz/kA5HB3JYcLuO2QHmzdhvlZFBVNWKT9sVpE
         U9cGcK8Di5S0oPFY9yf6viJ1Bc3L+eXt2JvcDl/qFLEmYSWReKHGG+5oyntgReQ3Bx9i
         w5Ud3JMNS9stC9rBvrvngP4cK/ZHY0ElVKYCiIrfuoVEOQOslSNCNbSOQPTyYhLuglbd
         AINg==
X-Gm-Message-State: AO0yUKUuVIgVpeFSWMYzqumWNwMgje2jbKOPylH2dKvTZQX8b1Xqf8ip
        izA3fRDidgdME5m/VZsXBb8fvA==
X-Google-Smtp-Source: AK7set8zKiuI5dv/fykGPWJu0ufw/4kTODffMuzEHuFxyU4aQQNrPNULPBEq2EJ8Ts0U7t9+sW1Biw==
X-Received: by 2002:aa7:8685:0:b0:5a8:4de9:b797 with SMTP id d5-20020aa78685000000b005a84de9b797mr5337934pfo.14.1676025527036;
        Fri, 10 Feb 2023 02:38:47 -0800 (PST)
Received: from openbmc500G.LAB.ufispace (CH210-63-217-225.static.apol.com.tw. [210.63.217.225])
        by smtp.gmail.com with ESMTPSA id v25-20020a62a519000000b005809d382016sm2973950pfm.74.2023.02.10.02.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 02:38:46 -0800 (PST)
From:   Jordan Chang <jordan.chang@ufispace.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        joel@jms.id.au, andrew@aj.id.au, robh+dt@kernel.org
Cc:     jay.tc.lin@ufispace.com, eason.ys.huang@ufispace.com
Subject: [PATCH v4 0/1] Add Ufispace NCPLite platform device tree
Date:   Fri, 10 Feb 2023 18:38:28 +0800
Message-Id: <20230210103829.74470-1-jordan.chang@ufispace.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Ufispace NCPLite platform device tree, and add the compatible
string in dt-bindings files.

Changes for v4:
- revise the tags

Changes for v3:
- add "Acked-by: Krzysztof Kozlowski"

Changes for v2:
- modify node name to generic one and check with dtbs_check
- send-email without confidential mode

Jordan Chang (1):
  ARM: dts: aspeed: Add device tree for Ufispace NCPLite BMC

 arch/arm/boot/dts/Makefile                    |   1 +
 .../boot/dts/aspeed-bmc-ufispace-ncplite.dts  | 359 ++++++++++++++++++
 2 files changed, 360 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-ufispace-ncplite.dts

-- 
2.39.0

