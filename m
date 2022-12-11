Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6FC1649222
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 03:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbiLKC5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 21:57:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiLKC5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 21:57:15 -0500
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83FC8A1A1;
        Sat, 10 Dec 2022 18:57:12 -0800 (PST)
Received: by codeconstruct.com.au (Postfix, from userid 10000)
        id DEB4B20240; Sun, 11 Dec 2022 10:57:10 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codeconstruct.com.au; s=2022a; t=1670727430;
        bh=B2bgi3mEW9G3IrDXy4oqFAsoYTVXakmyqNJRxS06qk8=;
        h=From:To:Cc:Subject:Date;
        b=XJ55m8zQFto4ChwS8Bh69mSTYjmYu2vJWCK4C9eiwks/TS8aXQqmyUSAPxgQS2Llx
         xgAYz4pIPbzTIv85QzOB+Q8tz/KQD6Rn1BamsmnEC+piVQjeaOc1BNuezRhEYg3i3q
         Pkw4yRWksoHU7Xl3+XiQButtzsXV2CVCcBMtLFNlbDIYKEWyIeJ3ZoU3RstTR8g69k
         XBYKufEeZUcb78Ubm9KagzTIV4rx8Da0iaUJSC6t3XwXybRXO3H16P1Rm7FypM0wnY
         V/O5A5DbgFApNxkQUcKfjeDSO+1RnBdBjkrWGNX+NVbWY9F6Kvz8iQkk4sxWRx2RTO
         29JaDwuq8gUTg==
From:   Jeremy Kerr <jk@codeconstruct.com.au>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Mark Brown <broonie@kernel.org>
Subject: [RFC PATCH v3 0/2] Add reset control for mfd syscon devices
Date:   Sun, 11 Dec 2022 10:56:58 +0800
Message-Id: <20221211025700.1180843-1-jk@codeconstruct.com.au>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This RFC series adds a facility for syscon devices to control a reset
line when probed; we have instances of simple register-only syscon
resources that need deassertion of a reset line for the register set to
be accessible.

Rather than requiring a specific driver to implement this, it'd be nice
to use the generic syscon device and the generic resets linkage to do
so.

Any comments/queries/etc are most welcome.

Cheers,


Jeremy
---
v2:
 - use direct syscon registration interface, rather than the (unused)
   syscon platform device code
 - consequently, add regmap infrastructure to attach a reset
   controller, in a similar way to attaching clocks
v3:
 - drop regmap reset attach and just do a direct deassert from the syscon
   driver

Jeremy Kerr (2):
  dt-bindings: mfd/syscon: Add resets property
  mfd: syscon: allow reset control for syscon devices

 .../devicetree/bindings/mfd/syscon.yaml       |  3 +++
 drivers/mfd/syscon.c                          | 27 ++++++++++++++-----
 2 files changed, 24 insertions(+), 6 deletions(-)

-- 
2.35.1

