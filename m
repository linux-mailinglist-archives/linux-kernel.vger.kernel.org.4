Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11CF26F390A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 22:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232613AbjEAUOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 16:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjEAUOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 16:14:17 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17FF2122
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 13:14:15 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f11d267d8bso1887325e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 13:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682972054; x=1685564054;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mE2szBYezWZJnqwmUnpT8UTjyXUukwjUaTrr8EHK1lU=;
        b=bQH9HYPHNgcXWjvzo+JOtC4li7jb81ep0Jvhfok3QZTgcmArtWHA3Ocrh6zuNfD94Y
         mwwFYoPiJEir6haIPiRGIQm+9DJ/7TXM3k1Z8oaK4Fz7EXF+ftpq0xfA/8egXw0Pfa+U
         aVA3Xpr3QyEwFObF9ZB7LDCBCgDTZjKkjhMKmlDNp1/qWAqgMZZG1Hjdddqy5OkvcAlL
         CDpGkKLF3G93F0g2JpO59bqsSIZeJIMNTPixVdFDfpKSl2uU6T7WRIwbsgp0WyId9vTX
         a54aAeJNNoUh959zpiRNcNSv4R6etOqHKVTslmbpnL4Dp0Vf48NaL6vnxy3g9QKqeQOp
         8vjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682972054; x=1685564054;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mE2szBYezWZJnqwmUnpT8UTjyXUukwjUaTrr8EHK1lU=;
        b=OLmDGWJDL+2zhEtCeXv0PAlqfeYg4j5YQjX5WlT65+PhrdK05+Cg5+sKELamMyiTWx
         0ILN+WNhg3ars2ZkIWInE20OXRgvjF86MVO3KHcYHqSJGlBuRyRKkhgTF/ihzG2mpPMn
         fsOReqVJcK0otvHm67OimTJ6Ir2G3HmtTiGSMemSkDJdNZ9g1+hkejSLkCYVPaNXnMSl
         nu/C1XDhOrQEh0Lh75nwlRJGh024uI+MWHzRHOwmI1yNWJVCMBGeutJ+sxaqjIvkFhQ6
         F4hfO3DUIQmWK4YT9tW8d0oLsXuSI0pC/VHI5TFEgQgQ4aixLR3Z4jbDkN2b8uQuQiCr
         kSrQ==
X-Gm-Message-State: AC+VfDzvjPP8u+YgKTQv2LxLzIDuj8y73IIvmdozayeVf+GZj3iDN+/2
        quXe9eFDQjZ+I+8X692aNYqSX/xHpplXf9im
X-Google-Smtp-Source: ACHHUZ7BI79YRtSo0GMy9ajMtZJoELc8kfvezGSttDBV/qmgaZpbbALqGaAhNAwQ82H53++qvbUzvw==
X-Received: by 2002:ac2:5fd1:0:b0:4de:e802:b7e3 with SMTP id q17-20020ac25fd1000000b004dee802b7e3mr4713414lfg.19.1682972053528;
        Mon, 01 May 2023 13:14:13 -0700 (PDT)
Received: from localhost.localdomain ([165.231.178.21])
        by smtp.gmail.com with ESMTPSA id o20-20020ac24354000000b004e843d6244csm4924132lfl.99.2023.05.01.13.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 13:14:12 -0700 (PDT)
From:   Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     shawn.lin@rock-chips.com, lpieralisi@kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
Subject: [PATCH v1 0/1] Add configurable sleep for pcie-rockchip-host
Date:   Mon,  1 May 2023 22:13:53 +0200
Message-Id: <20230501201353.1213963-1-vincenzopalazzodev@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
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

I am submitting a patch to add a configurable sleep for the 
Rockchip PCIe driver in the hope of resolving a persistent 
issue with old ARM platforms.

It has been observed that the driver requires an extra 
sleep before probing the device, particularly on some older ARM 
devices like Pine64 RockPro64. While an original patch was deployed 
in Manjaro ARM, the issue still persists with the upstream kernel.

This patch introduces a module parameter "bus_scan_delay" which allows users 
to configure the delay before probing the device. I have tested this patch 
on several platforms and it has proven to be effective.

I hope that by starting this discussion, we can collaborate and 
find a more robust upstream solution for this issue.

Cheers!

Vincent.
-------
Vincenzo Palazzo (1):
  drivers: pci: introduce configurable delay for Rockchip PCIe bus scan

 .../admin-guide/kernel-parameters.txt         |  8 +++++
 .../boot/dts/rockchip/rk3399-rockpro64.dtsi   |  3 +-
 drivers/pci/controller/pcie-rockchip-host.c   | 29 +++++++++++++++++++
 drivers/pci/controller/pcie-rockchip.c        |  5 ++++
 drivers/pci/controller/pcie-rockchip.h        |  9 ++++++
 5 files changed, 53 insertions(+), 1 deletion(-)

-- 
2.40.1

