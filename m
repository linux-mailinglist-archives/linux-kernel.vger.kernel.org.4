Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A78EA63AAEC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 15:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232544AbiK1O3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 09:29:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232524AbiK1O3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 09:29:25 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24FCB22291;
        Mon, 28 Nov 2022 06:29:23 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sendonly@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 6E7CA41A42;
        Mon, 28 Nov 2022 14:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1669645760; bh=r56d4PU2Z6JM/OvZ//Bewks010h3jvwvcNPfumIUlyc=;
        h=From:To:Cc:Subject:Date;
        b=zAHKHc++geBjgd0H31hst6+LMrycaXOXIpWW2+rGX0yZYxN7c/FXOcVnnmd3YvQe9
         UEuXJHeSX7QixANaRGR9amL+5ZSSx+Oo9stKID2cE46zENK6s2SiOs/xa3SwzgdYm4
         +UVp32w8Lny5sggUz1xqC83tZ18bNEzucayXDIHeLotDDxkKMgcMbvYqupUjX6sXPx
         WNe4dQvdBskVgdy7kDVm35BgUk3yYIH85VuMDr/4KveaQBzDsW0LS2n2DZt7McvMUj
         ngtKpRGPaUWiwDbKioFXSoSwEolTrZbowN3IalxGSLXdbVLAmW9637aLha9vQopQon
         CCQyMp1jhbPng==
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
Subject: [PATCH v5 0/4] Apple SoC cpufreq driver
Date:   Mon, 28 Nov 2022 23:29:08 +0900
Message-Id: <20221128142912.16022-1-marcan@marcan.st>
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

Here's v5 of the cpufreq driver for Apple SoCs. v5 just incorporates
minor review feedback changes from v3, and no functional changes. v4
had a DT schema SNAFU; this supersedes it.

Once reviewed, please merge #3 via the cpufreq tree, and we'll take
care of #1,#2,#4 via the asahi-soc tree. This lets us merge the DT
changes in the same cycle without blocking on the binding coming in
via the cpufreq tree first.

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

Hector Martin (4):
  MAINTAINERS: Add entries for Apple SoC cpufreq driver
  dt-bindings: cpufreq: apple,soc-cpufreq: Add binding for Apple SoC
    cpufreq
  cpufreq: apple-soc: Add new driver to control Apple SoC CPU P-states
  arm64: dts: apple: Add CPU topology & cpufreq nodes for t8103

 .../cpufreq/apple,cluster-cpufreq.yaml        | 117 ++++++
 MAINTAINERS                                   |   2 +
 arch/arm64/boot/dts/apple/t8103.dtsi          | 204 +++++++++-
 drivers/cpufreq/Kconfig.arm                   |   9 +
 drivers/cpufreq/Makefile                      |   1 +
 drivers/cpufreq/apple-soc-cpufreq.c           | 352 ++++++++++++++++++
 drivers/cpufreq/cpufreq-dt-platdev.c          |   2 +
 7 files changed, 677 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/apple,cluster-cpufreq.yaml
 create mode 100644 drivers/cpufreq/apple-soc-cpufreq.c

-- 
2.35.1

