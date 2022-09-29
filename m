Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3775EF792
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 16:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235319AbiI2OcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 10:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235165AbiI2OcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 10:32:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01F0109743;
        Thu, 29 Sep 2022 07:32:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AC49FB824B7;
        Thu, 29 Sep 2022 14:32:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F5FBC433D6;
        Thu, 29 Sep 2022 14:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664461929;
        bh=+CMzqfKQBFDlTPBluCEbkfHV9J5CITs8KfGeq6Svh0U=;
        h=From:To:Cc:Subject:Date:From;
        b=r1GVqZuHnBHPflK7bfh++hH6TdU0WxVd/vXT7zjr7kDdH6LQBw1yROjrgUnm+4lna
         rFlbxCyDpRbBdqGxe0tPGq5C3MwE+n8MQGI4HxfzHEYL2IFds9vITX4nJiHkeTOyyf
         7vXgK8swzz4AgbzXtQrPFcnIrv73yD3D2RO+lrhyYnuQU2Sgqwcufv6X1a93c46H7C
         m4NTbwMfe0EYnp4IrfPTKPjUlHQN6amjuZLFc9kcyJBkfe1OTXoeVdArU4W2jpcA5M
         SAnhgdtDxrYL66Afb3WDDdwgWHyEfvtCAu1nQ9s/6z/lKyD8KHYywFBAgoeNCjHmuc
         l5hW+ZBnahCbQ==
From:   broonie@kernel.org
To:     Marc Zyngier <maz@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <jroedel@suse.de>, Frank Li <Frank.Li@nxp.com>,
        Will Deacon <will@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
Subject: linux-next: build failure after merge of the irqchip tree
Date:   Thu, 29 Sep 2022 15:31:48 +0100
Message-Id: <20220929143149.126145-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

After merging the irqchip tree, today's linux-next build (arm64
defconfig) failed like this:

/tmp/next/build/drivers/irqchip/irq-imx-mu-msi.c:14:10: fatal error: linux/dma-iommu.h: No such file or directory
   14 | #include <linux/dma-iommu.h>
      |          ^~~~~~~~~~~~~~~~~~~

Caused by commit

  841e6e9f2bc95baff ("irqchip: Add IMX MU MSI controller driver")

interacting with

  f2042ed21da7f8886 ("iommu/dma: Make header private")

I have reverted the driver for today.
