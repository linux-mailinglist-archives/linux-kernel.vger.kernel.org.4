Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77B88607007
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 08:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbiJUG1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 02:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiJUG1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 02:27:40 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A51239233
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 23:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666333659; x=1697869659;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NnQlu/b7OKYqJy4jWUYIP9NkO/n7jpwIEwYD7R17ODQ=;
  b=O2h8Ti+yg7CKhiRR23xmdrxk8/bVvUMaWKVow+tagvKINjw742Jw9GQQ
   2X2Vlqb3af3qbamNtFSgw6LOej93w2BeNy0Bk5X8QR5TQhmZJ+UrkEGlw
   XKeC+2Bf9csL14kIYeEb0wndose20xK5qkQgwgXU1hcarU6Xhv6m3yQ2Y
   AU65duowtVHwjNhr8/HzPtvvhg/u9kterGFVzyffzYpupJdA3PH315FxN
   ZwWRFdRoVfeo2bwPhs2l4CoUa8P//AC1RUY53T8cOGGKY14Ti8hHNaq1p
   rwotS02j27MzNV2oNTAxtx8xD22g/Jg+Au/IYvRRFqVJb919DkAjHbBwb
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="286642400"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="286642400"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 23:27:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="735358030"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="735358030"
Received: from d8bbc18b98c6.jf.intel.com ([10.54.241.152])
  by fmsmga002.fm.intel.com with ESMTP; 20 Oct 2022 23:27:39 -0700
From:   shaoqin.huang@intel.com
To:     mst@redhat.com, jasowang@redhat.com
Cc:     Shaoqin Huang <shaoqin.huang@intel.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] virtio_pci: use helper function is_power_of_2()
Date:   Thu, 20 Oct 2022 23:27:33 -0700
Message-Id: <20221021062734.228881-2-shaoqin.huang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221021062734.228881-1-shaoqin.huang@intel.com>
References: <20221021062734.228881-1-shaoqin.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shaoqin Huang <shaoqin.huang@intel.com>

Use helper function is_power_of_2() to check if num is power of two.
Minor readability improvement.

Signed-off-by: Shaoqin Huang <shaoqin.huang@intel.com>
---
 drivers/virtio/virtio_pci_modern.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index c3b9f2761849..207294bd7b9d 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -310,7 +310,7 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 	if (!num || vp_modern_get_queue_enable(mdev, index))
 		return ERR_PTR(-ENOENT);
 
-	if (num & (num - 1)) {
+	if (!is_power_of_2(num)) {
 		dev_warn(&vp_dev->pci_dev->dev, "bad queue size %u", num);
 		return ERR_PTR(-EINVAL);
 	}
-- 
2.34.1

