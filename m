Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3665B65E212
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 01:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjAEAzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 19:55:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbjAEAyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 19:54:37 -0500
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7C24D706;
        Wed,  4 Jan 2023 16:51:16 -0800 (PST)
Received: by codeconstruct.com.au (Postfix, from userid 10000)
        id B6D7420037; Thu,  5 Jan 2023 08:51:12 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codeconstruct.com.au; s=2022a; t=1672879872;
        bh=R0NvDAP0rtAXxa8uBvbH2nz4jKtixzyYqetiSej3vqY=;
        h=From:To:Cc:Subject:Date;
        b=Enc9Iaf5AQk/ELDViqdFDl2Xbr84Mg000zPd/6FFczECSHj+TYnHlOR3tvVrt+Ry0
         kCyzdNpi1388MgU8Q1xj49A0q1wSZWQ9uRrWbBWBK7cZl+rFJlXhKijBhe33vU9eIf
         gudFfbfdJ4esRvGjmdtweh/U7AtqAqtWorGgREiLIO2ka7wlevsspJvtjFIVLkisM0
         jeA5jSzjyqUR0XQ8WPgKvEw20vnmlD0MNYgyiSRDvkZ5SK2+Eiz3ssRztGRC0Id5iS
         3tZKjgxwlewhpJfxzmIv6yRJOZheNAwVcrmSF5woY25wgM1DuwPXQ3nAyIZKLJklfZ
         xfTp5hWWEQNrw==
From:   Jeremy Kerr <jk@codeconstruct.com.au>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Mark Brown <broonie@kernel.org>
Subject: [PATCH v4 0/2] Add reset control for mfd syscon devices
Date:   Thu,  5 Jan 2023 08:50:08 +0800
Message-Id: <20230105005010.124948-1-jk@codeconstruct.com.au>
X-Mailer: git-send-email 2.38.1
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
 - drop regmap reset control and just do a direct deassert from the syscon
   driver
v4:
 - collapse unnecessary else block in syscon driver reset control

---
Jeremy Kerr (2):
  dt-bindings: mfd/syscon: Add resets property
  mfd: syscon: allow reset control for syscon devices

 .../devicetree/bindings/mfd/syscon.yaml       |  3 +++
 drivers/mfd/syscon.c                          | 27 ++++++++++++++-----
 2 files changed, 24 insertions(+), 6 deletions(-)

-- 
2.38.1

