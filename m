Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7F56669401
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 11:24:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240887AbjAMKX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 05:23:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241096AbjAMKXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 05:23:33 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55A560EB;
        Fri, 13 Jan 2023 02:23:31 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sendonly@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id ECE8341A42;
        Fri, 13 Jan 2023 10:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1673605409; bh=Qk0SZhUSDcUli3ukUepHX62c899A3JbfgCFO6jDV0xw=;
        h=From:To:Cc:Subject:Date;
        b=l/RI4vKRdxtkr1dgBIidcWG5huYub+Hd8IQ4/8AQ9V+BjXniGnGiU7aIFRlbq/vxE
         dK8mHJeu6jhqseny7hhgTLMcPfw+YXb154e8BipO9gRGyOO2RcT8qZtqsPak13kkLh
         IGgXh82uSQGygDRIJQn6rNEdRI8f1YGPhIix1NOMGljo9TSMplT3v3/x1zyAw4UZh4
         9jJxba6lyvTo2g+bEa5jpYzUAFq7WnLQdwVdRVaQN/hAqns+goLBeSRMCn6sHaEDlP
         QhugQLLKCicRknkAnVE25f2+/4BS/2Zn8wyKIJOzBFBk5G6F5alMKkPUA6iw8L8dyn
         gEGvHEbkbAXWA==
From:   Hector Martin <marcan@marcan.st>
To:     Mark Brown <broonie@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        Janne Grunau <j@jannau.net>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        asahi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>
Subject: [PATCH v2 0/3] SPI core CS delay fixes and additions
Date:   Fri, 13 Jan 2023 19:23:07 +0900
Message-Id: <20230113102309.18308-1-marcan@marcan.st>
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

Commits f6c911f3308c ("spi: dt-bindings: Introduce
spi-cs-setup-ns property") and 33a2fde5f77b ("spi: Introduce
spi-cs-setup-ns property") introduced a new property to represent the
CS setup delay in the device tree, but they have some issues:

- The property is only parsed as a 16-bit integer number of nanoseconds,
  which limits the maximum value to ~65us. This is not a reasonable
  upper limit, as some devices might need a lot more.
- The property name is inconsistent with other delay properties, which
  use a "*-delay-ns" naming scheme.
- Only the setup delay is introduced, but not the related hold and
  inactive delay times.

This series fixes the issues and adds support for the two missing
properties. Please pull in the first 3 patches as fixes for 6.2, to
avoid introducing a problematic DT API in this release. The last two
patches can wait until 6.3, though are probably harmless to throw in
as fixes too, since they're trivial.

v2: Removed a stray variable declaration that was triggering a warning,
and dropped the first two patches which have already been applied.

Janne Grunau (3):
  spi: Use a 32-bit DT property for spi-cs-setup-delay-ns
  spi: dt-bindings: Add hold/inactive CS delay peripheral properties
  spi: Parse hold/inactive CS delay values from the DT

 .../bindings/spi/spi-peripheral-props.yaml    | 10 ++++++++
 drivers/spi/spi.c                             | 25 +++++++++++++++----
 2 files changed, 30 insertions(+), 5 deletions(-)

--
2.35.1

