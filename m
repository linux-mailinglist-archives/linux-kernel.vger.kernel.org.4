Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F15BF60993A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 06:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiJXEjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 00:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiJXEjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 00:39:48 -0400
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9CD61006;
        Sun, 23 Oct 2022 21:39:42 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 921AC4248E;
        Mon, 24 Oct 2022 04:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1666586380; bh=PSIFBicjAsCmHU1aD6l6zkYxcFB0FGKPngGEO+mAWSQ=;
        h=From:To:Cc:Subject:Date;
        b=NDsLUNRMLS+soEDN1/NPuJdzeXmAp7lorII8SuaT5AHcEwFwKw2sX4goU/57qx05k
         taoKsGazNkms5aVzIiYXpPyvPFfcfiloUyWS0EgwMRavQPlsLuDyZm1YYwuoalJ5gI
         1LOZuEVhLHdRit8jOhSUMuJV1Dm0K5qs07I7gLx7yH24Mviz91FmXUV8oOTqtGUZ5i
         gx2krc7rsVPVABY97iw68tCd2PBoQEHSkc2ATqTKOxNalY/t+DEJhZxbskib+9Fz4y
         V8mkZvr62Or0qEbHVoikbCeUNkjQVh9uFgoUIf2ASfr+GmTRLfHrt+eeNjzVgSUdtK
         64f4v/1ZATT3g==
From:   Hector Martin <marcan@marcan.st>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/5] Apple SoC cpufreq driver
Date:   Mon, 24 Oct 2022 13:39:20 +0900
Message-Id: <20221024043925.25379-1-marcan@marcan.st>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

Third time's the charm? Here's v3 of the cpufreq driver for Apple SoCs.
This version takes a page from both v1 and v2, keeping the dedicated
cpufreq style (instead of pretending to be a clock controller) but using
dedicated DT nodes for each cluster, which accurately represents the
hardware. In particular, this makes supporting t6002 (M1 Ultra) a lot
more reasonable on the DT side.

This version also switches to the standard performance-domains binding,
so we don't need any more vendor-specific properties. In order to
support this, I had to make the performance-domains parsing code more
generic. This required a minor change to the only consumer
(mediatek-cpufreq-hw).

The Linux driver probes based on platform compatible, and then attempts
to locate the cluster nodes by following the performance-domains links
from CPU nodes (this will then fail for any incompatible nodes, e.g. if
a future SoC needs a new compatible and can't fall back). This approach
was suggested by robh as the right way to handle the impedance mismatch
between the hardware, which has separate controllers per cluster, and
the Linux model where there can only be one CPUFreq driver instance.

Functionality-wise, there are no significant changes from v2. The only
notable difference is support for t8112 (M2). This works largely the
same as the other SoCs, but they ran out of bits in the current PState
register, so that needs a SoC-specific quirk. Since that register is
not used by macOS (it was discovered experimentally) and is not critical
for functionality (it just allows accurately reporting the current
frequency to userspace, given boost clock limitations), I've decided to
only use it when a SoC-specific compatible is present. The default
fallback code will simply report the requested frequency as actual.
I expect this will work for future SoCs.

As usual, MAINTAINERS and DT changes are split. I expect patches #2~#4
to go through the cpufreq tree, and we'll take care of #1 and #5 via
the asahi-soc tree.

Hector Martin (5):
  MAINTAINERS: Add entries for Apple SoC cpufreq driver
  dt-bindings: cpufreq: apple,soc-cpufreq: Add binding for Apple SoC
    cpufreq
  cpufreq: Generalize of_perf_domain_get_sharing_cpumask phandle format
  cpufreq: apple-soc: Add new driver to control Apple SoC CPU P-states
  arm64: dts: apple: Add CPU topology & cpufreq nodes for t8103

 .../cpufreq/apple,cluster-cpufreq.yaml        | 119 ++++++
 MAINTAINERS                                   |   2 +
 arch/arm64/boot/dts/apple/t8103.dtsi          | 206 +++++++++-
 drivers/cpufreq/Kconfig.arm                   |   9 +
 drivers/cpufreq/Makefile                      |   1 +
 drivers/cpufreq/apple-soc-cpufreq.c           | 352 ++++++++++++++++++
 drivers/cpufreq/cpufreq-dt-platdev.c          |   2 +
 drivers/cpufreq/mediatek-cpufreq-hw.c         |  14 +-
 include/linux/cpufreq.h                       |  28 +-
 9 files changed, 706 insertions(+), 27 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/apple,cluster-cpufreq.yaml
 create mode 100644 drivers/cpufreq/apple-soc-cpufreq.c

-- 
2.35.1

