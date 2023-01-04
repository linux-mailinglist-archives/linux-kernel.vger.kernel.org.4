Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8069465D11A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 12:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234834AbjADLCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 06:02:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234940AbjADLCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 06:02:13 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD78013CFC;
        Wed,  4 Jan 2023 03:01:43 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sendonly@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 4365941DF4;
        Wed,  4 Jan 2023 11:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1672830102; bh=g7nUA2ypvc1Zay8J+5szjWXvFzadUoopE1ZxgZRaixY=;
        h=From:To:Cc:Subject:Date;
        b=SUbRwVaI8Jj/dp61tMcU9Dj4JGwB7DpZjsOmKST3J0lgzG3eIYsoEBY81cev6g5Rw
         XCerjQyyAe0KMZujuXypSvG7OHY2o+6GuJ4xbFWliOuNMFJ3typMuWvwDUmlCpvlDR
         RYN7quLsVUBH7kXSerrDxYwY3JoymyBmV3TjY6MWeYbQ9LZxymbIwMwA3ULJTNEyMl
         M8AiEchCWD47JB9CAqJYb+0j3xKgX5y7FdW4NvD7G7TnBNZG6oKJgj1KMpb6u/lXHN
         4GcOKk3NuUitTuOW6TwmUazPvA3MFKBgjyoB2XjCQ5QwfOzNCQ9Hm56mD9+c/Vsgeg
         vFLPLYqxeShyA==
From:   Hector Martin <marcan@marcan.st>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Janne Grunau <j@jannau.net>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, iommu@lists.linux.dev,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Hector Martin <marcan@marcan.st>
Subject: [PATCH 0/7] iommu: dart: Apple t8110 DART support
Date:   Wed,  4 Jan 2023 20:00:06 +0900
Message-Id: <20230104110013.24738-1-marcan@marcan.st>
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

Hi all,

This series adds support for the T8110 DARTs used for the Thunderbolt
controllers on T600x SoCs and everywhere on T8112 SoCs.

This new DART revision shuffles the registers around and removes
support for multiple TTBR registers per SID (which never made sense on
16K configurations), but otherwise works much like the existing DART
hardware. The pagetable format is the same as t600x, so no changes are
needed there.

Once reviewed, I'd like to merge patch #1 through the Asahi-SoC tree so
we can start using it in device trees right away, instead of waiting for
one release cycle. Patches #2 onwards should go through the IOMMU tree.

Hector Martin (7):
  dt-bindings: iommu: dart: add t8110 compatible
  iommu: dart: Add suspend/resume support
  iommu: dart: Support >64 stream IDs
  iommu: dart: Support a variable number of TTBRs per stream
  iommu: dart: Fix DART_PARAMS1/2 bit define names
  iommu: dart: Support different variants with different registers
  iommu: dart: Add t8110 DART support

 .../devicetree/bindings/iommu/apple,dart.yaml |   1 +
 drivers/iommu/apple-dart.c                    | 559 ++++++++++++++----
 2 files changed, 450 insertions(+), 110 deletions(-)

-- 
2.35.1

