Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9E8F62A45E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 22:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbiKOVmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 16:42:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbiKOVmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 16:42:00 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8B332BA9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 13:41:22 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id y6-20020a25b9c6000000b006c1c6161716so14201732ybj.8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 13:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=X2q2jXZbiR4aVk+j4cgzelsOGwbnws5+6EO0kS0q+IE=;
        b=bc8gszccDarK7qqwempMPNtbikI8jkIOiq/wh6VybGdCVg6NwG/Nx85IKREmkFRuKU
         wShAc4YefT81y8pFMR1rxelAe/RRgfpvpPmNlQEZEKpzo+c1M3/C7NJnGgjkinSTAxWr
         qVKQ3wauGSA/Lewwmgqvq9e006mGZVpXq682GvsurpiaXjeSpHA3QRJTFqPGwKqgTeOm
         YpeAyY7kri8DeFOmUx37xDNBusgu4XbtjicarUdIsq0DCAcH6Us3YD5wihN/jH4yP30k
         7W198pKVPpm5ebcBI9A8BeOfWYWFyoQiE5lu9Q9bZIYmQ82aQhzPy9WzzxM2O19DPRLm
         ZrRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X2q2jXZbiR4aVk+j4cgzelsOGwbnws5+6EO0kS0q+IE=;
        b=W5cQmDNLXypR/5wmplxHaoxmcj5M+zP3kPjOVZJ0esTlIUn5Lj+JCC7VTSYWf7ujJf
         bj7G3ScbkSi7uD7H0iJrm5vfNc0v1to6sD7BkthqkGdUy/HJqcmExQcWicmDDnY5Iu4m
         edLcUE6chq6jJou4G8RnGUgtuhb5ys0OswZe0EQhvyj3LXyaIOkUx6pg7YVTyp7hfdFO
         8QeP24njtDfqvy5cmDXETutTKQMQmQBVXjwUY68SDPCfYRF66vMrLmHUBxrgPcQ9EHsh
         hd8NphT9qm82fRPWNlKolZrDhEYL9xAOP1h9UE8xhtUthDwVQL2TbXuMvJgleXbXjvQ/
         WUmQ==
X-Gm-Message-State: ANoB5pnAb2sMfZsFquZUocqFIQ2lnEraIx6BlCfd8QovKw/g1kyUQAD/
        GKytQCHwa1MJ1a2+kprTOoKBWBXo9v2U
X-Google-Smtp-Source: AA0mqf7GgKCoXOCi2F46eSyK33OlF+GBC970TPtJzlizq2rWCFH+aPNwsJ8Zy7KnDh1jhzu4fIyuMGmvV68G
X-Received: from sammler.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:43cd])
 (user=sammler job=sendgmr) by 2002:a25:41d7:0:b0:6cb:8949:fdbb with SMTP id
 o206-20020a2541d7000000b006cb8949fdbbmr18613201yba.328.1668548481659; Tue, 15
 Nov 2022 13:41:21 -0800 (PST)
Date:   Tue, 15 Nov 2022 21:40:36 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221115214036.1571015-1-sammler@google.com>
Subject: [PATCH v2] virtio_pmem: populate numa information
From:   Michael Sammler <sammler@google.com>
To:     Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Mina Almasry <almasrymina@google.com>, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     Michael Sammler <sammler@google.com>,
        Pankaj Gupta <pankaj.gupta@amd.com>
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
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Pankaj Gupta <pankaj.gupta@amd.com>
Tested-by: Mina Almasry <almasrymina@google.com>
---
Changes from v1:
- added Reviewed-by and Tested-by
- synced with mainline

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
2.38.1.431.g37b22c650d-goog
