Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 149985F74ED
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 09:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiJGHyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 03:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbiJGHyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 03:54:40 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A47CCBF48
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 00:54:38 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id x59so5910846ede.7
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 00:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6cKqRbn3P/xpE+S210j3qCazjn2THQLP9aoRkXcWPq0=;
        b=U1v64D8Pgvbtv8Bu+3/z8FJaBKXRWTkhG0G1+gFCeQUUI439wWIVU6UwLk4uOzeNd/
         lzWUdlQkq9h0b3q7C1/f5lwSoHC9GXDffAvlsniXtAfyWP+LQ11XsLkQKMYC9C1VYhFP
         Zq9beRSNbiAUZlI0kU3perWKQdGOUI7iqZI9G9EGSkSQCWLgMdtlbGZV+ayvdT5teB8Q
         2wHTdJiBOWNtboCTYS487fwIAcMHw4CTdMiSLWFxSX+/6R/7aEec7xjnKKkt6ywb5Pbx
         GVUzb94cwT3dL1PZTbtNarbLyNuQRHotslKMKWvrX54Db0wKquIEXI8F7U0BFPufySXS
         1mSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6cKqRbn3P/xpE+S210j3qCazjn2THQLP9aoRkXcWPq0=;
        b=OIXP5qw1pFc5P01S4pWL3uAKqKQCe/1EwVsfMMWpljWYY9xNUX6HrzGK8mp2r2eSnC
         +1YQjAl7dUqdgRoOU78pD+ukMyD/pN5hpU0jaEVzAO+xGa9HT/ptBsvJOTwGUQ36MEkY
         xhHM1H9izfNEi3f5AnS5x3cWqQs/3nopOUBFuXfc5yMt6LPN15ZpimyXGwWQuEkpzzhI
         Fjb8IO5jZrLdFaY98P2pGUDwVks8/fCffb5khvmlaWF1TZPdC47/tZKifemUpAFo018B
         Y4jeG4fl5mB6oNxH7dnlzwsRdwwBZHKwzXx2nTSapksx6zmwrm0eWv4I8Woyzl4U1sgj
         I0sw==
X-Gm-Message-State: ACrzQf1ROFkwWv0uquKsKmy79mXq0BVZy3+Ktdwm7TUYyhTv6Bd5Rze6
        UgUAtnVBPPn/pFNw+oxQdbMTtA==
X-Google-Smtp-Source: AMsMyM7bu31JSdsR1xEWCprr46ZUrKai1I+sprEaOiyxyGdQ9rMBFzsCxdkk9f9kNrpUpdVxpeJ5/Q==
X-Received: by 2002:a05:6402:548f:b0:457:ed40:5f58 with SMTP id fg15-20020a056402548f00b00457ed405f58mr3333425edb.408.1665129277211;
        Fri, 07 Oct 2022 00:54:37 -0700 (PDT)
Received: from fedora.sec.9e.network (ip-094-114-232-236.um31.pools.vodafone-ip.de. [94.114.232.236])
        by smtp.gmail.com with ESMTPSA id hv13-20020a17090760cd00b00741a0c3f4cdsm782281ejc.189.2022.10.07.00.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 00:54:36 -0700 (PDT)
From:   Patrick Rudolph <patrick.rudolph@9elements.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-i2c@vger.kernel.org
Cc:     robh@kernel.org, peda@axentia.se, wsa@kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v9 0/4] Add support for Maxim MAX735x/MAX736x variants
Date:   Fri,  7 Oct 2022 09:53:49 +0200
Message-Id: <20221007075354.568752-1-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v9:
- Fix 'then' not aligned with 'if' in dt-bindings
- Split enhanced mode configuration into separate patch
- Add MAX7357/MAX7358 register definitions
- Rename config register defines
- Update comments and explain non default config being applied on MAX7357
- Check for I2C_FUNC_SMBUS_WRITE_BYTE_DATA functionality

v8:
- Move allOf in dt-binding and use double negation

v7:
- Reworked the commit message, comments and renamed a struct
  field. No functional change.

v6:
- Fix typo in dt-bindings

v5:
- Remove optional and make vdd-supply mandatory

v4:
- Add missing maxitems dt-bindings property

v3:
- Merge dt-bindings into i2c-mux-pca954x.yaml

v2:
- Move dt-bindings to separate file
- Added support for MAX736x as they are very similar
- Fixed an issue found by kernel test robot
- Dropped max735x property and custom IRQ check
- Added MAX7357 config register defines instead of magic values
- Renamed vcc-supply to vdd-supply

Patrick Rudolph (4):
  dt-bindings: i2c: Add Maxim MAX735x/MAX736x variants
  i2c: muxes: pca954x: Add MAX735x/MAX736x support
  i2c: muxes: pca954x: Configure MAX7357 in enhanced mode
  i2c: muxes: pca954x: Add regulator support

 .../bindings/i2c/i2c-mux-pca954x.yaml         |  39 ++++-
 drivers/i2c/muxes/Kconfig                     |   6 +-
 drivers/i2c/muxes/i2c-mux-pca954x.c           | 140 +++++++++++++++++-
 3 files changed, 170 insertions(+), 15 deletions(-)

-- 
2.37.3

