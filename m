Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DEB4669549
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 12:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233016AbjAMLPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 06:15:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233190AbjAMLMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 06:12:40 -0500
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B31459F80;
        Fri, 13 Jan 2023 03:07:45 -0800 (PST)
Received: by mail-ej1-f49.google.com with SMTP id qk9so51517872ejc.3;
        Fri, 13 Jan 2023 03:07:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F+15vxFiiY5tc6WQ1LMLTgERRMIi2n7Ag2eOZR93TU8=;
        b=4fZU9R2F4YPUFvbVUitIxbKfKCx6JJrIIrFXnlyM4OHEERBlk5hzqVyMXLhIEzjT88
         v1dkVKgHQKUWZQyMGuXYK0sibxyWQuKdExP2h1qkYcuw+GR2FKYT6wmT+57dtKIfGp6p
         KyYCPtlx3sp7iRPuNMS/qPdcSDfkdVak584Ueqk2FEejMbTLjlDF2he9DTxOp5OSAwn8
         KMWlEJ0AXWHWvB22gAIhpUUw1cNuvkLBkDVAfZIZVCcIpXykcqk1IsjZL4pniFNIO/RE
         yutib39SSBomYwL7eNK6zpVyQMSX7rd62hYBpZ5Q2CyBlzoQs6VxHutptS7P9zIwZipv
         ukdQ==
X-Gm-Message-State: AFqh2kop4qii3RksgTfmVyYFjvhaUXB3Sc5zD1GSV65ImkeJdjGge6Xt
        lzI7DsOWoK9LKk3cEowYjZ5DJKBz3sH47QI8NZI=
X-Google-Smtp-Source: AMrXdXsNUG7ZcKtvUx+1MZrCroVfzUimHibXQrtcFoPQgH3BtYcxwyMClbpIbkNqDFmGktutIDxXDT6i3cjRWk+8xtY=
X-Received: by 2002:a17:907:c203:b0:867:77a9:db77 with SMTP id
 ti3-20020a170907c20300b0086777a9db77mr563438ejc.209.1673608064011; Fri, 13
 Jan 2023 03:07:44 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 13 Jan 2023 12:07:33 +0100
Message-ID: <CAJZ5v0j117rbXsLW5P7hGm4=YL-KM1uY7E-B3kmkt_gRaEicXQ@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for v6.2-rc4
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-6.2-rc4

with top-most commit 4f3085f87b51a551a0647f218d4f324796ecb703

 cpufreq: amd-pstate: fix kernel hang issue while amd-pstate unregistering

on top of commit b7bfaa761d760e72a969d116517eaa12e404c262

 Linux 6.2-rc3

to receive power management fixes for 6.2-rc4.

These fix assorted issues in the ARM cpufreq drivers and in the
AMD P-state driver.

Specifics:

 - Fix cpufreq policy reference counting in amd-pstate to prevent it
   from crashing on removal (Perry Yuan).

 - Fix double initialization and set suspend-freq for Apple's cpufreq
   driver (Arnd Bergmann, Hector Martin).

 - Fix reading of "reg" property, update cpufreq-dt's blocklist and
   update DT documentation for Qualcomm's cpufreq driver (Konrad Dybcio,
   Krzysztof Kozlowski).

 - Replace 0 with NULL in the Armada cpufreq driver (Miles Chen).

 - Fix potential overflows in the CPPC cpufreq driver (Pierre Gondois).

 - Update blocklist for the Tegra234 Soc cpufreq driver (Sumit Gupta).

Thanks!


---------------

Arnd Bergmann (1):
      cpufreq: apple: remove duplicate intializer

Hector Martin (1):
      cpufreq: apple-soc: Switch to the lowest frequency on suspend

Konrad Dybcio (2):
      cpufreq: qcom-hw: Fix reading "reg" with address/size-cells != 2
      cpufreq: Add SM6375 to cpufreq-dt-platdev blocklist

Krzysztof Kozlowski (1):
      dt-bindings: cpufreq: cpufreq-qcom-hw: document interrupts

Miles Chen (1):
      cpufreq: armada-37xx: stop using 0 as NULL pointer

Perry Yuan (1):
      cpufreq: amd-pstate: fix kernel hang issue while amd-pstate unregistering

Pierre Gondois (1):
      cpufreq: CPPC: Add u64 casts to avoid overflowing

Sumit Gupta (1):
      cpufreq: Add Tegra234 to cpufreq-dt-platdev blocklist

---------------

 .../bindings/cpufreq/cpufreq-qcom-hw.yaml          | 11 +++++++++++
 drivers/cpufreq/amd-pstate.c                       |  1 +
 drivers/cpufreq/apple-soc-cpufreq.c                |  3 ++-
 drivers/cpufreq/armada-37xx-cpufreq.c              |  2 +-
 drivers/cpufreq/cppc_cpufreq.c                     | 11 ++++++-----
 drivers/cpufreq/cpufreq-dt-platdev.c               |  2 ++
 drivers/cpufreq/qcom-cpufreq-hw.c                  | 22 ++++++++++++++++++++--
 7 files changed, 43 insertions(+), 9 deletions(-)
