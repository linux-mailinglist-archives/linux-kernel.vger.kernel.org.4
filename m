Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A16D86B90AE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 11:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjCNKxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 06:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbjCNKxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 06:53:35 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A263E625;
        Tue, 14 Mar 2023 03:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1678791191;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=lWG+KFc/Ei6/o+9Wu4zuAiJ8/qhoZmSrQx365/6Oshk=;
        b=fUjwl/GTGcJeOfWYXXFY58YwTQ3Vq4QMsk3coead00trx0lcSAqYvNHlYUHM1jjAik9aEC
        e41Tc9t2VdvlK6F3/9913vt7NWs9yRmfxb9QXk+Ap583R8pZEVWs7vkah6OnQY1EIdjzFM
        hnjvZbaZk1hiQncj6By5PKHHSAkrNaE=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     michael.hennerich@analog.com, nuno.sa@analog.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 0/2] usb: gadget: functionfs: DMABUF import interface
Date:   Tue, 14 Mar 2023 11:52:55 +0100
Message-Id: <20230314105257.17345-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This small patchset adds three new IOCTLs that can be used to attach,
detach, or transfer from/to a DMABUF object.

This was surprisingly easy to add, as the functionfs code only uses
scatterlists for transfers and allows specifying the number of bytes to
transfer. The bulk of the code is then for general DMABUF accounting.

The patchset isn't tagged RFC but comments are very welcome, there are
some things I am not 100% sure about: ffs_dma_resv_lock (with no
ww_acquire_ctx), and I'm using pr_debug which feels wrong. Also, I
should probably add documentation? The current IOCTLs for functionfs
were not documented, as far as I can tell.

We use it with DMABUFs created with udmabuf, that we attach to the
functionfs interface and to IIO devices (with a DMABUF interface for
IIO, on its way to upstream too), to transfer samples from high-speed
transceivers to USB in a zero-copy fashion.

Cheers,
-Paul


Paul Cercueil (2):
  usb: gadget: Support already-mapped DMA SGs
  usb: gadget: functionfs: Add DMABUF import interface

 drivers/usb/gadget/function/f_fs.c  | 398 ++++++++++++++++++++++++++++
 drivers/usb/gadget/udc/core.c       |   7 +-
 include/linux/usb/gadget.h          |   2 +
 include/uapi/linux/usb/functionfs.h |  14 +-
 4 files changed, 419 insertions(+), 2 deletions(-)

-- 
2.39.2

