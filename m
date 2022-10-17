Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC9F60145E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 19:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbiJQRLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 13:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiJQRLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 13:11:42 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82CD2A428
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 10:11:41 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-33dc888dc62so116087387b3.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 10:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZZNYuYnYhhKKqBDOIhr6XrGGyufP89bX5HYBhar9JwY=;
        b=YbUppmjpRzqgtYxWUA5/kXQe7wLwR7bCxLD/Ud087xEgKvIJshznwYZ4ZySrPfiZqn
         NxPSZ7EowQM/sHlFZOX2x2lSL6MGX0S70RowSh9F/i25a8yimUcordRjJY13eKpkNL7I
         ZtpHVvEmKqv8c5yrrNFcuSnEls5TW5Y9H7zyF+A94n6o14llTh5SS9JFL70+NiikDYco
         jwXio2ChZpCZWGy1nESgUyuRIgIj8CICzFRbEgGs/ELtb7VLKL75je0H0VGQQaCoCvSI
         DYoah7Nm+WhHOWcY6X4AYZLkRLr3VhJTY0M92KhuyYW0+3/mptpvWZfVLX5MCDD95XUz
         GJjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZZNYuYnYhhKKqBDOIhr6XrGGyufP89bX5HYBhar9JwY=;
        b=RFQnols8QPLkdo/FGG5fPtiqIGgy2YWBah00oEBmTbjAKxxMSu0/lUL8+hd2xTU1v0
         16IAGhTw7ZAlfrUp0Ol4msP4M8azrx9YDMGDCqeyFatCrvU/NYNMdlTuqb1JBawuEuw9
         CIADzaYxK+yV2wfKLR/Ss7yXTldpwH1Ujzp9tcIecLHQ/n2riBO6rDzQD44ZjOyYyllf
         0oaRsuk7imZ9f7wPEn3XJt4kNfQVRJG/Tv0oU3meKy2O8+zx4PspB2Z/p1U79R29WZm2
         4XTgyFsl0eEKtAyFzPDmx5JlHGnt5CzTHXKe88kl8+ppYDTKOAZmEuMPMTyY+Jdxz7qy
         4/cQ==
X-Gm-Message-State: ACrzQf3rqVdV7KW898afyBRKAAfhlA5RIODewqtUTrZ2VkYDYoCtSGpy
        zmfkUjbyfffHSdp7BgGVmGXwLdwyJrrc
X-Google-Smtp-Source: AMsMyM7YOldNijFyOMuXUwg2kVVAvEcwSoCVIPvkBVzy61RYTe1Jweys9WJQUIGmaqzg2pJsVOINFZyKfCXP
X-Received: from sammler.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:43cd])
 (user=sammler job=sendgmr) by 2002:a05:6902:1022:b0:6bf:eda0:f746 with SMTP
 id x2-20020a056902102200b006bfeda0f746mr9381400ybt.368.1666026700542; Mon, 17
 Oct 2022 10:11:40 -0700 (PDT)
Date:   Mon, 17 Oct 2022 17:11:18 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
Message-ID: <20221017171118.1588820-1-sammler@google.com>
Subject: [PATCH v1] virtio_pmem: populate numa information
From:   Michael Sammler <sammler@google.com>
To:     Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Michael Sammler <sammler@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compute the numa information for a virtio_pmem device from the memory
range of the device. Previously, the target_node was always 0 since
the ndr_desc.target_node field was never explicitly set. The code for
computing the numa node is taken from cxl_pmem_region_probe in
drivers/cxl/pmem.c.

Signed-off-by: Michael Sammler <sammler@google.com>
---
 drivers/nvdimm/virtio_pmem.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/nvdimm/virtio_pmem.c b/drivers/nvdimm/virtio_pmem.c
index 20da455d2ef6..a92eb172f0e7 100644
--- a/drivers/nvdimm/virtio_pmem.c
+++ b/drivers/nvdimm/virtio_pmem.c
@@ -32,7 +32,6 @@ static int init_vq(struct virtio_pmem *vpmem)
 static int virtio_pmem_probe(struct virtio_device *vdev)
 {
 	struct nd_region_desc ndr_desc = {};
-	int nid = dev_to_node(&vdev->dev);
 	struct nd_region *nd_region;
 	struct virtio_pmem *vpmem;
 	struct resource res;
@@ -79,7 +78,15 @@ static int virtio_pmem_probe(struct virtio_device *vdev)
 	dev_set_drvdata(&vdev->dev, vpmem->nvdimm_bus);

 	ndr_desc.res = &res;
-	ndr_desc.numa_node = nid;
+
+	ndr_desc.numa_node = memory_add_physaddr_to_nid(res.start);
+	ndr_desc.target_node = phys_to_target_node(res.start);
+	if (ndr_desc.target_node == NUMA_NO_NODE) {
+		ndr_desc.target_node = ndr_desc.numa_node;
+		dev_dbg(&vdev->dev, "changing target node from %d to %d",
+			NUMA_NO_NODE, ndr_desc.target_node);
+	}
+
 	ndr_desc.flush = async_pmem_flush;
 	ndr_desc.provider_data = vdev;
 	set_bit(ND_REGION_PAGEMAP, &ndr_desc.flags);
--
2.38.0.413.g74048e4d9e-goog
