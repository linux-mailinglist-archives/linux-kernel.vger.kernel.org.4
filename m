Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2F7B5FA27F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 19:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbiJJRM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 13:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiJJRMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 13:12:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877B058DC1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 10:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665421943;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=NQfJCIP1SalvtcFCK3pdAaYE1SnNGgH0a1J3wHjmhUg=;
        b=cVOG64Hvz2isSJ/OlHmWpgeIU+4c3nwJ/9LIkhPZlMCPLFlSvHnQRY634rC1+qnIKpEO8N
        4rXLy6/HzYbObwr27rqkULPjHJ/Hh1yz5qpNyy24CgB+z/i7NI75p13kgpN5PSq68Ge2gu
        cGvfpMCw79GrPjHMwZnxMFkA4gNY1Jc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-576-jYEjp7N7MuSDLR3-VgEF7Q-1; Mon, 10 Oct 2022 13:12:22 -0400
X-MC-Unique: jYEjp7N7MuSDLR3-VgEF7Q-1
Received: by mail-wm1-f71.google.com with SMTP id n19-20020a7bcbd3000000b003c4a72334e7so1416584wmi.8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 10:12:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NQfJCIP1SalvtcFCK3pdAaYE1SnNGgH0a1J3wHjmhUg=;
        b=TOB6LJYbdLCirTMoMoKIH4BIhe2b59vwgOyWWHClP5UCSuWF83rrPLDwarsmQNPP7v
         X+eRx44O+Ys0bKLLmt4ABvYZofAwzzTQidtAbvKR6dhq1yR7ImMZMH6zbVEhkq8XlmvG
         zgx/U0PL1OjhUcAbzTn3L9s0nJ7zf1UIdAP9jqCPshuI7xUfo0aXIHzKFCXcXnkmtDo4
         FLZ6IIsoq+Fv0swjpnESTtbWqRF96hcoM3VUeTwRqssvbzGJGFcxPg7MNo0u80GbmG4B
         h5Rv01ee0EGroB9ZlaTHBQS3W3ik2mVNu7RMR7De2podNVeaXVST6AX1cym8Wd9I7DZg
         UmtQ==
X-Gm-Message-State: ACrzQf0Qpi8xH73vJ8J/f5y551kb10w0FIH2fc/88N01Jrw8fCDTI+nv
        j4P+Bchpw62Fmydt/DHT445pHNJhqVkjPFDSFMpRWsKxKYuSM5CRbeBcO74EF8J3BGKmi7mZzF7
        zX+6YAVkw5omYOefGbacEwdO0loVqZD26A/rje6vFqLy7PJ0mzNhfAuJr+saJI/lLmIK4sQ==
X-Received: by 2002:a05:600c:3845:b0:3b4:b187:3d09 with SMTP id s5-20020a05600c384500b003b4b1873d09mr20540164wmr.96.1665421941114;
        Mon, 10 Oct 2022 10:12:21 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM63cjhz7XzZhJCporbzOGCOCeEtLMeJPQcnHObTdg8t2i7mRm/yvHLdG4jtj6Aj67AJhVchlg==
X-Received: by 2002:a05:600c:3845:b0:3b4:b187:3d09 with SMTP id s5-20020a05600c384500b003b4b1873d09mr20540132wmr.96.1665421940794;
        Mon, 10 Oct 2022 10:12:20 -0700 (PDT)
Received: from redhat.com ([2.55.183.131])
        by smtp.gmail.com with ESMTPSA id a13-20020adff7cd000000b0022a403954c3sm9339737wrq.42.2022.10.10.10.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 10:12:20 -0700 (PDT)
Date:   Mon, 10 Oct 2022 13:12:15 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH RFC] pci: fix device presence detection for VFs
Message-ID: <20221009191835.4036-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

virtio uses the same driver for VFs and PFs.  Accordingly,
pci_device_is_present is used to detect device presence. This function
isn't currently working properly for VFs since it attempts reading
device and vendor ID. Result is device marked broken incorrectly.  As
VFs are present if and only if PF is present, just return the value for
that device.

Reported-by: gongwei <gongwei833x@gmail.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

---

Warning - compile tested only. gongwei could you help test and report
please?

 drivers/pci/pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 95bc329e74c0..ba29b8e2f3c1 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6462,6 +6462,9 @@ bool pci_device_is_present(struct pci_dev *pdev)
 {
 	u32 v;
 
+	if (pdev->is_virtfn)
+		return pci_device_is_present(pdev->physfn);
+
 	if (pci_dev_is_disconnected(pdev))
 		return false;
 	return pci_bus_read_dev_vendor_id(pdev->bus, pdev->devfn, &v, 0);
-- 
MST

