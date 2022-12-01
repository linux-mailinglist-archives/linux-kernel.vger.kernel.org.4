Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B990163F9C8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 22:28:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiLAV2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 16:28:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiLAV14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 16:27:56 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB38124F15
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 13:27:54 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id l15so2669446qtv.4
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 13:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y7EfQP5c4Tp15RvKyJNK3BoLF6L+XplDDM23u5kp4g0=;
        b=71+lGGNZhYeneb21fGOTHJ+8CFElHHEHz0o4clpPLBalxLbUYKKwQPpAPVLi8ufX2t
         AxVgczUCgm9hK6L5Mt7R3acGsYaHKwErKYKPJDqSG47Vnr0Iz/ixpMXiwbyP1umjOBNV
         WYwGSKWijoStMkEqUuorEn+iI23tPTfM7HgRWpIKQh/mlXWEdjv19J4/dOC7Bwrt7/xJ
         dtacUsmg/mABojRS3/Bnn0rnC6ZA+iy3e2ZYX3IE7CbOO0CyN9U1pN5C78tltgnI5MCI
         pFMd/4T0FbvB/qHvCab+nDuQUHyioBrxK+2T6Q91jnHTK53nDe+kmvtAFpk89mng+NGM
         IwPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y7EfQP5c4Tp15RvKyJNK3BoLF6L+XplDDM23u5kp4g0=;
        b=ri8qyfGAuFBNXRPSmZwEi2XFLJwh8zvAj0X7Tq4Aas1xtwdp5a8quJrPqO1CfU43Fa
         u989SabvpDtebxfWfRB8Dcr923lFOII8hqwynNKuWlLiwJwMV/VpQnZ4RpdjyMyxEFlh
         VXEK711doXnSbVO6G+Hwy9/NHuD+CbgqoWQ0Oka+btlFGqZ9GpUd/FuECuzSJ1RdYD3d
         pMMZfevsm+rI2e/UtREQh4lpo1eDDhyvrFCrvHfIVGBlTB8lJx9Z2MWqcYdaE+ulRnMd
         FdsyyM+WJ1A6y7LNB0hpx3gKfPVUVxmdD78dz6rNvIGcBhu9nohRq73BLKv12sP/sG4k
         991g==
X-Gm-Message-State: ANoB5pmGasKijGQZLOCh8wYoINlE6/Be2/r6muHK2AyVr4GhLbthc3Zp
        seAkVAVFHXRccVTi0G0ziyB9Xg==
X-Google-Smtp-Source: AA0mqf75PHhBw3iWbz9uAP/z0xnYmQkvcE0cxiSj329MzHDOvgMt9OzNhDI9vMUqr6SIBChmV4Kp1g==
X-Received: by 2002:a05:620a:46a2:b0:6fa:d9c:3a61 with SMTP id bq34-20020a05620a46a200b006fa0d9c3a61mr44222688qkb.26.1669930073374;
        Thu, 01 Dec 2022 13:27:53 -0800 (PST)
Received: from nathan-ideapad.. (d-75-76-18-234.oh.cpe.breezeline.net. [75.76.18.234])
        by smtp.gmail.com with ESMTPSA id l15-20020a37f90f000000b006fc447eebe5sm4071321qkj.27.2022.12.01.13.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 13:27:52 -0800 (PST)
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
Subject: [PATCH v3 0/3] mtd: spi-nor: Extend SFDP to support additional octal modes as per latest JEDEC standard
Date:   Thu,  1 Dec 2022 16:27:47 -0500
Message-Id: <20221201212750.267721-1-nathan.morrison@timesys.com>
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
4 byte address instruction table for 1S-1S-8S and 1S-8S-8S modes

This patchset adds support for checking the 4BAIT for these modes,
along with additional NO_SFDP_FLAGS to support enabling these new modes

v2: Move page program commands into sfdp.c instead of core.c,
as this appears to conform more closely with spi-nor paradigm.
Page program buswidth appears to be automatically determined, so let's
follow suit and do the same.

v3:
 - Added missing SPI_NOR_OCTAL_READ_1_8_8 to spi_nor_sfdp check in
   spi_nor_init_params_deprecated()
 - Convert IS25LX256 to 1S-8S-8S instead of 1S-1S-8S
 - Tested and confirmed both 1S-1S-8S and 1S-8S-8S work on IS25LX256

Nathan Barrett-Morrison (3):
  mtd: spi-nor: Extend SFDP 4byte address instruction lookup table with
    new octal modes as per JEDEC JESD216F
  mtd: spi-nor: Add additional octal-mode flags to be checked during
    SFDP
  mtd: spi-nor: Add support for IS25LX256 operating in 1S-8S-8S octal
    read mode

 drivers/mtd/spi-nor/core.c |  8 ++++++++
 drivers/mtd/spi-nor/core.h |  5 +++--
 drivers/mtd/spi-nor/issi.c |  3 +++
 drivers/mtd/spi-nor/sfdp.c | 13 +++++++++++++
 4 files changed, 27 insertions(+), 2 deletions(-)

-- 
2.30.2

