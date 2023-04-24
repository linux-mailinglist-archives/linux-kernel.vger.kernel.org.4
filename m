Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBDD76ED7BC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 00:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233273AbjDXWWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 18:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233259AbjDXWWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 18:22:37 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F06F6A5D;
        Mon, 24 Apr 2023 15:22:35 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-95369921f8eso780580366b.0;
        Mon, 24 Apr 2023 15:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682374954; x=1684966954;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WdIxTGlNkELsd0a+ecLFTr6r/fmHxxFhLmJKv81MFtc=;
        b=nOuTjlE6vdWeIha3ahnLnmhMgU7P4PX9EuYIXH0BiJs1uMV6BvtzLbO+KyPjlGRqng
         OqGSrQem9cYWentZ4991bLBKUM1I9ucl4w/0rYfU+66tZlU88GBJNRJmg4Gf43G5w3QE
         O7+p9vegqZXFd2NxLz0mPxZoDpeUrCKZrQkUFBJG+vS5K+8VmhACYe/3f2gPIRstwTfP
         Xac3kDypVtly+fmUrwRVvVByl23xyCwY9f0dkTq13cylLumcHTZ6dSN4Wa2X0qpZWu1f
         l9XpNNinxdV8lpWh+aG81eYmlRnZhSayuOXIwbEY+ghrm7hLZe/suzNPLfzKijqVSZ79
         zjTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682374954; x=1684966954;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WdIxTGlNkELsd0a+ecLFTr6r/fmHxxFhLmJKv81MFtc=;
        b=Nm6ejWG7ni8puGfoXSlhEXYVAFr4mS+5z4w0Kd6WRepp7GdXfBtLETVR4jKlAgd2Hy
         TdDj5PeE7QVCbG8dHb2B1zLvOkSb6PNDxryBrwZWwrPkDgj91+XVOzjm3jiJBD6YIgDD
         sKYSLWiAcyEAOKpdmHdrtianyeBtIdw+6zLMPIZgZkGcHIlcBRvwCurnjqMeQamzBJK9
         Ey06DxJyZGunl82W+qEb9SWiUKUxv5Sc31aVPbJ+kBDwgnq0XgZJ7F8TXZlXbjs1vh9t
         ZH/auE//BYBbi6UKPQ1wooOlqaNYeQn1GSMs1ZkchVOX8pw/enSgXcPehKgFNRxCrYiA
         emTw==
X-Gm-Message-State: AAQBX9dpYCWMLSZTcD0+vpPzODh1S7ZCULCqIm8Z4b2qpCFES3GbhsJR
        uXIbgnnQ0C6rUrC4sEcXwMmKmT4KxCE=
X-Google-Smtp-Source: AKy350YsnxESjLcykbMnFsU9QdNPIsc39gixC+0mVxzHDRveEViN4a+PBZCoEIgpzC86vf2mCO80bA==
X-Received: by 2002:a17:906:6009:b0:94d:69e0:6098 with SMTP id o9-20020a170906600900b0094d69e06098mr12580900ejj.45.1682374953831;
        Mon, 24 Apr 2023 15:22:33 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8109:aa3f:ead8::2fd0])
        by smtp.gmail.com with ESMTPSA id g21-20020a170906539500b0094efdfe60dcsm5870886ejo.206.2023.04.24.15.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 15:22:33 -0700 (PDT)
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
To:     jic23@kernel.org, mazziesaccount@gmail.com
Cc:     krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Mehdi Djait <mehdi.djait.k@gmail.com>
Subject: [PATCH v3 0/7] iio: accel: Add support for Kionix/ROHM KX132-1211 accelerometer
Date:   Tue, 25 Apr 2023 00:22:20 +0200
Message-Id: <cover.1682373451.git.mehdi.djait.k@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

Version 3 for adding support for the kx132-1211 accelerometer

KX132 accelerometer is a sensor which:
	- supports G-ranges of (+/-) 2, 4, 8, and 16G
	- can be connected to I2C or SPI
	- has internal HW FIFO buffer
	- supports various ODRs (output data rates)

The KX132 accelerometer is very similair to the KX022A. 
One key difference is number of bits to report the number of data bytes that 
have been stored in the buffer: 8 bits for KX022A vs 10 bits for
KX132-1211.

Changes in v3:
- added two new patches by separating the addition of the 
  i2c_device_id table and the removal of blank lines from other
  unrelated changes
- fixes a warning detected by the kernel test robot
- made all the changes related the chip_info in one patch

Changes in v2:
- added a new patch for warning when the device_id match fails in the
  probe function
- added a new patch for the function that retrieves the number of bytes
  in the buffer
- added a change to the Kconfig file in the patch adding the support
  for the kx132-1211
- various fixes and modifications listed under each patch


Mehdi Djait (7):
  dt-bindings: iio: Add KX132-1211 accelerometer
  iio: accel: kionix-kx022a: Remove blank lines
  iio: accel: kionix-kx022a: Warn on failed matches and assume
    compatibility
  iio: accel: kionix-kx022a: Add an i2c_device_id table
  iio: accel: kionix-kx022a: Refactor driver and add chip_info structure
  iio: accel: kionix-kx022a: Add a function to retrieve number of bytes
    in buffer
  iio: accel: Add support for Kionix/ROHM KX132-1211 accelerometer

 .../bindings/iio/accel/kionix,kx022a.yaml     |  12 +-
 drivers/iio/accel/Kconfig                     |   8 +-
 drivers/iio/accel/kionix-kx022a-i2c.c         |  22 +-
 drivers/iio/accel/kionix-kx022a-spi.c         |  17 +-
 drivers/iio/accel/kionix-kx022a.c             | 295 ++++++++++++++----
 drivers/iio/accel/kionix-kx022a.h             | 110 ++++++-
 6 files changed, 391 insertions(+), 73 deletions(-)

-- 
2.30.2

