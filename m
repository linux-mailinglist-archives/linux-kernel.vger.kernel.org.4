Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC89678D6E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 02:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232319AbjAXBaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 20:30:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbjAXBaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 20:30:18 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206D312869;
        Mon, 23 Jan 2023 17:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=nSp19ujQ+ktxCD6Dze1xGnN3rj3fGXlTk3QIIyKXR7Q=; b=RKmQLDt+q2mx7+HZ2KoFnjklUW
        uiYSwBVvbxB9kllH9g46k8r3ryyb7gIDxzK5XqU9xan0Fpog1a8yc+YHqBw/2yeXD+jgKxUAQAwGA
        6zSVJQh7syc6nN0q0FoK6d5I7A7Lk4OYe32BRvosylNjP0v0KzH9uwroW4V4nFkQPyHhbXL4oOvAv
        6ai0v/4W/7Wiirl68/E5FJ6d/X+Ezekwtjka2ZtsBCsGCYDaotELoBqUzjYJYIJZkTcRi4vSu6WiG
        CeJN++U+0RH5HMC3y+hoCm4Racd2ONn1BNVQkZNeopViJ7sC0o7PBfpi3JNPSH+8fyk11Hy2Y3nKv
        QAgDymaA==;
Received: from [2601:1c2:d80:3110::9307] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pK88d-00223C-T5; Tue, 24 Jan 2023 01:30:15 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-media@vger.kernel.org
Subject: [PATCH] media: atomisp: fix build error, use vb2 interfaces
Date:   Mon, 23 Jan 2023 17:30:14 -0800
Message-Id: <20230124013014.23578-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The atomisp driver uses functions that are provided by VIDEOBUF2_VMALLOC
instead of VIDEOBUF_VMALLOC, so change the 'select' so that the correct
interfaces are built.

ld: drivers/staging/media/atomisp/pci/atomisp_fops.o: in function `atomisp_init_pipe':
drivers/staging/media/atomisp/pci/atomisp_fops.c:649: undefined reference to `vb2_vmalloc_memops'

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 9d4fa1a16b28 ("media: atomisp: cleanup directory hierarchy")
Fixes: ad85094b293e ("Revert "media: staging: atomisp: Remove driver"")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-media@vger.kernel.org
---
 drivers/staging/media/atomisp/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/drivers/staging/media/atomisp/Kconfig b/drivers/staging/media/atomisp/Kconfig
--- a/drivers/staging/media/atomisp/Kconfig
+++ b/drivers/staging/media/atomisp/Kconfig
@@ -14,7 +14,7 @@ config VIDEO_ATOMISP
 	depends on VIDEO_DEV && INTEL_ATOMISP
 	depends on PMIC_OPREGION
 	select IOSF_MBI
-	select VIDEOBUF_VMALLOC
+	select VIDEOBUF2_VMALLOC
 	select VIDEO_V4L2_SUBDEV_API
 	help
 	  Say Y here if your platform supports Intel Atom SoC
