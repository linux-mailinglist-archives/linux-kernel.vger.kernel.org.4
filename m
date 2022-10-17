Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB0B5600A5F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 11:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbiJQJWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 05:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbiJQJVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 05:21:47 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3933112AC8;
        Mon, 17 Oct 2022 02:21:39 -0700 (PDT)
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by gandalf.ozlabs.org (Postfix) with ESMTP id 4MrWZr12rvz4xGl;
        Mon, 17 Oct 2022 20:16:36 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MrWZh54s8z4wgv;
        Mon, 17 Oct 2022 20:16:28 +1100 (AEDT)
From:   =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To:     linux-spi@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        openbmc@lists.ozlabs.org, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH linux v2 0/3] spi: aspeed: Add a "ranges" property
Date:   Mon, 17 Oct 2022 11:16:21 +0200
Message-Id: <20221017091624.130227-1-clg@kaod.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Currently, the Linux Aspeed SMC driver computes the decoding ranges of
each CS (AHB memory window on which the flash contents are mapped)
from the size of the detected flash device. It seems that some chips
have issues with the computed ranges and for these, it would be nice
to be able to define custom decoding ranges in the DT.

Here is a little series doing that. 

Thanks,

C. 

Changes in v2 :

 - Tested by Naresh Solanki
 - sent preliminary fix independently
   https://patchwork.kernel.org/project/linux-arm-kernel/patch/20221016155722.3520802-1-clg@kaod.org/
 - changed the sysfs file exposing the register values to debugfs.
 - refresh on 6.1-rc1

Cédric Le Goater (3):
  spi: dt-bindings: aspeed: Add a ranges property
  spi: aspeed: Handle custom decoding ranges
  spi: aspeed: Introduce a "ranges" debugfs file

 drivers/spi/spi-aspeed-smc.c                  | 131 +++++++++++++++++-
 .../bindings/spi/aspeed,ast2600-fmc.yaml      |   9 ++
 2 files changed, 138 insertions(+), 2 deletions(-)

-- 
2.37.3

