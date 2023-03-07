Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B63ED6AE639
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 17:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjCGQVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 11:21:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbjCGQUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 11:20:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC43590789;
        Tue,  7 Mar 2023 08:20:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F818614A0;
        Tue,  7 Mar 2023 16:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9841CC433D2;
        Tue,  7 Mar 2023 16:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678206024;
        bh=pg76cuXog+TE4GEzbHcXsItKi5PKb6+RWQ0zGaGHaU0=;
        h=From:To:Cc:Subject:Date:From;
        b=I9pj6z9pXrfP2M22HGDuYlnksbX/jVEX+G4QgBj1C3Q8fmgKmyGfxIIjWbDxnvDI1
         azPQy4/svhoq5cyBCFII8Hts9o+m+FwqjgVQ/u3ItcT5rt68bDvs+OXXDldFU4GH0y
         sKuqNtpjIZEY+LLtiMRJydsesccGl/SKHlA3G6TOmQ7LVlOUG8L4NX7SV+tGsDBbGe
         o1SSx7oWjeKR1OuSWQ1MoGvCmTYZ9t+Y+SE7LdXuMYnDR1akZKafxYctVIbds/35BD
         D1tQrcFSuxLxOEzuum2lglWFKcxii2Od6qaRwUV/HP4sIsiA3YkaLBl0U82T/nnSiH
         st543hSyab7Gw==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Yang Shen <shenyang39@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Nick Terrell <terrelln@fb.com>, Kai Ye <yekai13@huawei.com>,
        Longfang Liu <liulongfang@huawei.com>,
        Weili Qian <qianweili@huawei.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        qat-linux@intel.com
Subject: [PATCH 0/6] crypto: remove unnecessary PCI error handling
Date:   Tue,  7 Mar 2023 10:19:41 -0600
Message-Id: <20230307161947.857491-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Since f26e58bf6f54 ("PCI/AER: Enable error reporting when AER is native"),
which appeared in v6.0, the PCI core has enabled PCIe error reporting for
all devices during enumeration.

Remove driver code to do this (qat_4xxx) and remove unnecessary includes of
<linux/aer.h> from several other drivers.

Bjorn Helgaas (6):
  crypto: qat - drop redundant adf_enable_aer()
  crypto: cavium/nitrox - remove unnecessary aer.h include
  crypto: hisilicon/hpre - remove unnecessary aer.h include
  crypto: hisilicon/qm - remove unnecessary aer.h include
  crypto: hisilicon/sec - remove unnecessary aer.h include
  crypto: hisilicon/zip - remove unnecessary aer.h include

 drivers/crypto/cavium/nitrox/nitrox_main.c    |  1 -
 drivers/crypto/hisilicon/hpre/hpre_main.c     |  1 -
 drivers/crypto/hisilicon/qm.c                 |  1 -
 drivers/crypto/hisilicon/sec2/sec_main.c      |  1 -
 drivers/crypto/hisilicon/zip/zip_main.c       |  1 -
 drivers/crypto/qat/qat_4xxx/adf_drv.c         | 11 ++----
 drivers/crypto/qat/qat_c3xxx/adf_drv.c        |  9 ++---
 drivers/crypto/qat/qat_c62x/adf_drv.c         |  9 ++---
 drivers/crypto/qat/qat_common/adf_aer.c       | 35 -------------------
 .../crypto/qat/qat_common/adf_common_drv.h    |  2 --
 drivers/crypto/qat/qat_dh895xcc/adf_drv.c     |  9 ++---
 11 files changed, 9 insertions(+), 71 deletions(-)

-- 
2.25.1

