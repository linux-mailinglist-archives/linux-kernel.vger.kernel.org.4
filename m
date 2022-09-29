Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA0915F169B
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 01:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbiI3XY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 19:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232164AbiI3XYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 19:24:18 -0400
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7406C14594C;
        Fri, 30 Sep 2022 16:24:12 -0700 (PDT)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 8504BE0EB2;
        Fri, 30 Sep 2022 01:46:54 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:from:from:message-id
        :mime-version:reply-to:subject:subject:to:to; s=post; bh=0F0pMI2
        9a3JYWPRwZUHOw05fHrRq2BuL98mhBC2wW+8=; b=hhryUWcjZ17wdbk7YFSJ8Jg
        jsSzixbGL/YYeGw4TlYj2IqJxyPCW8eHrd+m0za4eFNCjzlpwlc301DwxCiWb4XU
        uWynJqgYQU+MToyfXTtkSAkU17ZyRwuemdku2j2PppEHjko1u/imOUnTg53sloxd
        nV5apMT/1XzM6RYuNHS0=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 6A7A4E0E6B;
        Fri, 30 Sep 2022 01:46:54 +0300 (MSK)
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 30 Sep 2022 01:46:55 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/3] block/nvme: Fix DMA-noncoherent platforms support
Date:   Fri, 30 Sep 2022 01:46:45 +0300
Message-ID: <20220929224648.8997-1-Sergey.Semin@baikalelectronics.ru>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [192.168.168.10]
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Our SoC doesn't have the CPU caches coherent on DMA's. After getting the
kernel updated to the 6.0-rcX version we've discovered a problem with the
NVME hwmon probe. It turned out that the root cause of it was connected
with the cache-line-unaligned buffer passed to the DMA-engine. Due to the
cache-invalidation performed on the buffer mapping stage a part of the
structure the buffer was embedded to was lost. Here we suggest to fix the
problem just by aligning the buffer accordingly as the
Documentation/core-api/dma-api.rst document requires. (See the
corresponding patch log for more details.)

A potential root of a similar problem has been detected in the sed-opal
driver too. Even though we have not got any difficulties connected with
that part we still suggest to fix that in the same way as it is done for
the NVME hwmon driver.

Link: https://lore.kernel.org/linux-nvme/20220909191916.16013-1-Sergey.Semin@baikalelectronics.ru
Changelog v2:
- Drop Jonathan Derrick and Revanth Rajashekar from Cc-list due to
  the email messages being bounced back.
- Add a new preparation patch:
[PATCH v2 1/3] nvme-hwmon: Return error on kzalloc failure
- Convert to allocating the nvme_smart_log structure instance instead of
  cache-aligning it. (@Christoph)

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-nvme@lists.infradead.org
Cc: linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Serge Semin (3):
  nvme-hwmon: Return error on kzalloc failure
  nvme-hwmon: Kmalloc the NVME SMART log buffer
  block: sed-opal: Cache-line-align the cmd/resp buffers

 block/sed-opal.c          |  5 +++--
 drivers/nvme/host/hwmon.c | 34 ++++++++++++++++++++++++----------
 2 files changed, 27 insertions(+), 12 deletions(-)

-- 
2.37.3


