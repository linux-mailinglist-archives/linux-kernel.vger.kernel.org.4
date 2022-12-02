Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC567640808
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 14:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233048AbiLBNzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 08:55:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbiLBNzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 08:55:46 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA7AB957C
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 05:55:44 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id i12so3439890qvs.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 05:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/ma98Ber9LAvBhmxU5rmkvA56b+DHyODh9Y9db65vmQ=;
        b=xEETpZa+sTCbLrOSSHNMPt5XlCGaj7z5rd2NeowjZW+RKxeSwIcOuP0qsfS3nbUFi5
         jZzbP+wYwlK7x03cEBfAe0tDaqQ8HEIOghjpAG9pHzIuRbwNX8VMJycPGmZvj+hFaB6a
         Z1T4fdX7FdJlPMMeZdhPs3MLpMiljriJbYgU9Dw/y62xKvKvCjm/BYEG8qHPRXqML1QY
         FrNzbqAGg6EHkatnf+nXwN6Q9zX9PPeUrXbXU6BUGSlcbq3L+xkDtSm0nyNk7PeO9pG9
         GT8jCEYIw1QJ3gFHDMRBG0z/qxlhaRKNgXY0uwzUWY4DSbh4hJ2EMqTu54uXQ2XyTLhx
         zqlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/ma98Ber9LAvBhmxU5rmkvA56b+DHyODh9Y9db65vmQ=;
        b=l+/U4tcKBqW73mAhCTvTz3JuvqIHG48vzU/l1fbFjQ2paNyJrdsJZCg/NQ1ESxheaz
         tIt9CthAoUPQBAaJcBn9Bp6KY22fTyxpgXRx6Q2DgxwGfiyQb+r4awzemKDTGNOvg9Zq
         0AgQJIyZhPxj4CuEj/biQEnBwNsmAgbG1BZFXuTZy+xGS8M2dJrOl0GLrNdsKDBh2Idm
         GjXPvY5g/nuu/ctpOnifv069Mpni8U3Oxk+/5qRZLO176lNPOId+xkPjSXjJzqnZhkoD
         mUGMQVo771i+TGbXHweNG5rf/SXxbjaAU2remCjM3zuznmvzNNk4+hpVYV5yZ0Sj8+SI
         GQeg==
X-Gm-Message-State: ANoB5plxSiguh+rZTmBBHWqlsmCE5S5MWrsS7xFBHvrQSucTcJ2VH/Pn
        4x60SB/MRf+f948BDaRAZJfTR2de2RxzxZGg5N4=
X-Google-Smtp-Source: AA0mqf5rI3PAXd/bmA2UbF5U56MLOIeiWt+rsTVpCAU88xX1n7KPrJA7nVQcysc3/NCelGB8rAvOsA==
X-Received: by 2002:ad4:4d49:0:b0:4c7:2804:d69b with SMTP id m9-20020ad44d49000000b004c72804d69bmr8069489qvm.5.1669989343655;
        Fri, 02 Dec 2022 05:55:43 -0800 (PST)
Received: from nathan-ideapad.. (d-75-76-18-234.oh.cpe.breezeline.net. [75.76.18.234])
        by smtp.gmail.com with ESMTPSA id x1-20020ac84d41000000b0039a610a04b1sm4122237qtv.37.2022.12.02.05.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 05:55:43 -0800 (PST)
From:   Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Cc:     nathan.morrison@timesys.com, greg.malysa@timesys.com,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org (open list:SPI NOR SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 0/3] mtd: spi-nor: Extend SFDP to support additional octal modes as per latest JEDEC standard
Date:   Fri,  2 Dec 2022 08:55:36 -0500
Message-Id: <20221202135539.271936-1-nathan.morrison@timesys.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the latest JEDEC standard (JESD216F), there are now bitfields in the
4 byte address instruction table for 1S-1S-8S and 1S-8S-8S modes.

This patchset adds support for checking the 4BAIT for these modes.

v2: Move page program commands into sfdp.c instead of core.c,
as this appears to conform more closely with spi-nor paradigm.
Page program buswidth appears to be automatically determined, so let's
follow suit and do the same.

v3:
 - Added missing SPI_NOR_OCTAL_READ_1_8_8 to spi_nor_sfdp check in
   spi_nor_init_params_deprecated()
 - Convert IS25LX256 to 1S-8S-8S instead of 1S-1S-8S
 - Tested and confirmed both 1S-1S-8S and 1S-8S-8S work on IS25LX256

v4:
 - Remove SPI_NOR_OCTAL_READ_1_8_8, this was following a defunct path
 - Correct the IS25LX256's missing BFPT info via a fixup instead

Nathan Barrett-Morrison (3):
  mtd: spi-nor: Extend SFDP 4byte address instruction lookup table with
    new octal modes as per JEDEC JESD216F
  mtd: spi-nor: Add additional octal-mode page program flags to be
    checked during SFDP 4BAIT parsing
  mtd: spi-nor: Add support for IS25LX256 operating in 1S-8S-8S octal
    read mode

 drivers/mtd/spi-nor/issi.c | 32 ++++++++++++++++++++++++++++++++
 drivers/mtd/spi-nor/sfdp.c | 13 +++++++++++++
 2 files changed, 45 insertions(+)

-- 
2.30.2

