Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C55FB6C4692
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 10:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbjCVJg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 05:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbjCVJgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 05:36:23 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7251E5F529;
        Wed, 22 Mar 2023 02:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1679476886;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=tmRlYhR2FZnlnQJCWKDJjWOgiCSSl9pc0u4cFJUJ650=;
        b=N+K9gfMWBsR4tD4u3Hl8NNLbTta8iPSN0ERcGscwa47kxMOGN0UFmiTqCEo0xcvmKjCd74
        5QKS+X1c2izruTxdi+aR2/bxOzM5vWFMvFs5pp/4TwXtEn6OYJKWv7KKZgoXYHILsy+BHa
        2AW0NIB2KkWH3t1e96o1srWamY7k2XM=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     michael.hennerich@analog.com, nuno.sa@analog.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 0/3] usb: gadget: functionfs: DMABUF import interface
Date:   Wed, 22 Mar 2023 10:21:15 +0100
Message-Id: <20230322092118.9213-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This small patchset adds three new IOCTLs that can be used to attach,
detach, or transfer from/to a DMABUF object.

Changes since v1:
- patch [2/3] is new. I had to reuse a piece of code that was already
  duplicated in the driver, so I factorized the code.
- Make ffs_dma_resv_lock() static
- Add MODULE_IMPORT_NS(DMA_BUF);
- The attach/detach functions are now performed without locking the
  eps_lock spinlock. The transfer function starts with the spinlock
  unlocked, then locks it before allocating and queueing the USB
  transfer.

Cheers,
-Paul

Paul Cercueil (3):
  usb: gadget: Support already-mapped DMA SGs
  usb: gadget: functionfs: Factorize wait-for-endpoint code
  usb: gadget: functionfs: Add DMABUF import interface

 drivers/usb/gadget/function/f_fs.c  | 467 ++++++++++++++++++++++++++--
 drivers/usb/gadget/udc/core.c       |   7 +-
 include/linux/usb/gadget.h          |   2 +
 include/uapi/linux/usb/functionfs.h |  14 +-
 4 files changed, 468 insertions(+), 22 deletions(-)

-- 
2.39.2

