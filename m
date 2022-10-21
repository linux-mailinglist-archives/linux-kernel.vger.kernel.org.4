Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC23607907
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 15:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbiJUN7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 09:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbiJUN7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 09:59:16 -0400
Received: from dhl.lxnav.com (dhl.lxnav.com [IPv6:2a01:4f8:c010:2f07::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A511F248CC;
        Fri, 21 Oct 2022 06:59:15 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 468B54068A;
        Fri, 21 Oct 2022 15:59:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lxnav.com; s=dhl;
        t=1666360753; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding; bh=E0chd1q6hzKQGh6t8MfjA2PP7ck8kcunC61vNoOu1bQ=;
        b=YFjNbhV1o9JsIHr6QTAw+g9a+TnJBlBfioe5XsuKZTh1iQwO7xZNuE9v+qywSchp0VALOZ
        MsyZ1QdMyiRSBnHkLRuJXTYR86R8tfL0qsI197dHbsAYkXCQtTcV3T4OAffCekVlONb3M7
        XmXKs2jgJXVaiMOEekeIsw0KOdlhk02S3G9NWg9Y45ovLsc7JWziRMP4WXhy0mIGD8xarE
        WykfK5Z89MI6sT/Hq6vjbs7i57s+BZwHrRyOamWDa+y75a0JhrNi8PCvizrDzL+mNjovNk
        0NqZ/n69Tl5bGMREgq9Dma0zdcxe0K6kDUH3FXRDAGhjBPodiqq415jDDV/nvw==
From:   Mitja Spes <mitja@lxnav.com>
Cc:     Mitja Spes <mitja@lxnav.com>, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Tomasz Duszynski <tduszyns@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] ms5611 sensor value bug fix; dt-binding fix
Date:   Fri, 21 Oct 2022 15:58:19 +0200
Message-Id: <20221021135827.1444793-1-mitja@lxnav.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [PATCH 0/3] ms5611 sensor value bug fix; dt-binding fix

The first patch fixes a bug in ms5611 iio driver where PROM value
compensation table was overwritten by the last initialized sensor.
This in turn produced wrong values when multiple sensors were used.

Second patch removes the hardcoded SPI frequency and uses the setting
from dt-bindings.

Third patch outlines the change from the second patch in the bindings
example.

v2:

[PATCH 1-2]
* no change

[PATCH 3]
* corrected patch subject

Mitja Spes (3):
  iio: pressure: ms5611: fixed value compensation bug
  iio: pressure: ms5611: changed hardcoded SPI speed to value limited
  dt-bindings: iio: pressure: meas,ms5611: add max SPI frequency to the
    example

 .../bindings/iio/pressure/meas,ms5611.yaml    |  1 +
 drivers/iio/pressure/ms5611.h                 | 12 ++---
 drivers/iio/pressure/ms5611_core.c            | 51 ++++++++++---------
 drivers/iio/pressure/ms5611_spi.c             |  2 +-
 4 files changed, 33 insertions(+), 33 deletions(-)

-- 
2.34.1

