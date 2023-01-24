Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE9C6791A2
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 08:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233367AbjAXHMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 02:12:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232535AbjAXHMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 02:12:21 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 186C2193D0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 23:12:20 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id k18so13876303pll.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 23:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7v3vKH0OUQa3EkOREw3bJ+B1AKEzvWHCw7MB+vHd9t4=;
        b=ZJSVtuBM+BhRrNs+A16J+fidiLqSEIJPMS2kMxaVz2bmdHms1q36mXFxsQNLsoleJK
         O6iXXm00waWsaNuJYNPCn/UlhEcrzuT7lzfjNQ3XSjscM1VYmkbYhIcbSViY08bH6uDJ
         EFlEFyFUz6WTD+jM4FV5qsbIP/yeOpKqZbEbis5ukW/K5skZJi2E3eYtpJJ7fwqYgspd
         EGC7a/y2PzCSQygcfX3t3NvD6SjZvShZpko//uPvG/qA7olPKwoG1iDm4r8ZpdIlnbv5
         F+V0B0Sk8poONvMIWht3ogYwciMwpBNi1sGiCJU3k6NuKb1kGyjGef3P2CDomr8k5oTk
         j3oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7v3vKH0OUQa3EkOREw3bJ+B1AKEzvWHCw7MB+vHd9t4=;
        b=hQN6KS0VeNlGY6bA9m3BOOgHSg1dRZmNFFDfS9FKDVOVVr7CEPDHwWBRX4ZZln2wy+
         luGDXXwdbG5RyzCW2b+ZIa/A99YqUfPovTFDIoo8ZMgxpWlZpkzhrn8i1XVK6FIkQiL1
         yHolmuypsc4sfv0WGxnruquNWZki8yrY5IcfpLgnCLyYFr3gfgHLcKAvFF5LNoAe9xkq
         MErO13/g8VqiXfprTaLrafUKjL9GpnhRhkliru+rcadWvRhJjtsYTxRpuofjZCiavzPh
         F3opD7XLreTz01D1Tx1XEayB6UTOD9V/PpRfEaHUcKmPfY+QkLwKP9LxDP0gBuebxqL7
         QByg==
X-Gm-Message-State: AFqh2kqNXgIj/Duc03Mc6uZetT+LqzLVyv5F/YefcH8TVLLFc18CEfCm
        sHuMZM1qYZdMpr0NUPR8rg8W
X-Google-Smtp-Source: AMrXdXsW7QSNkm4uOigZ/myGZxmMqpOzvzzypL4fJeke5jbE8aqCHXJGUWDZeA4LkX4bcoYOSSQfsg==
X-Received: by 2002:a17:90b:35c9:b0:229:8e0c:68b0 with SMTP id nb9-20020a17090b35c900b002298e0c68b0mr29172185pjb.19.1674544339457;
        Mon, 23 Jan 2023 23:12:19 -0800 (PST)
Received: from localhost.localdomain ([117.193.209.165])
        by smtp.gmail.com with ESMTPSA id 7-20020a17090a174700b00219220edf0dsm736041pjm.48.2023.01.23.23.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 23:12:18 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     kishon@kernel.org, lpieralisi@kernel.org, bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, robh@kernel.org, vidyas@nvidia.com, vigneshr@ti.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v5 0/5] PCI: endpoint: Rework the EPC to EPF notification
Date:   Tue, 24 Jan 2023 12:41:53 +0530
Message-Id: <20230124071158.5503-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

During the review of the patch that fixes DBI access in PCI EP, Rob
suggested [1] using a fixed interface for passing the events from EPC to
EPF instead of the in-kernel notifiers.

This series introduces a simple callback based mechanism for passing the
events from EPC to EPF. This interface is chosen for satisfying the below
requirements:

1. The notification has to reach the EPF drivers without any additional
latency.
2. The context of the caller (EPC) needs to be preserved while passing the
notifications.

With the existing notifier mechanism, the 1st case can be satisfied since
notifiers aren't adding any huge overhead. But the 2nd case is clearly not
satisfied, because the current atomic notifiers forces the EPF
notification context to be atomic even though the caller (EPC) may not be
in atomic context. In the notification function, the EPF drivers are
required to call several EPC APIs that might sleep and this triggers a
sleeping in atomic bug during runtime.

The above issue could be fixed by using a blocking notifier instead of
atomic, but that proposal was not accepted either [2].

So instead of working around the issues within the notifiers, let's get rid
of it and use the callback mechanism.

NOTE: DRA7xx and TEGRA194 drivers are only compile tested. Testing this series
on the real platforms is greatly appreciated.

Thanks,
Mani

[1] https://lore.kernel.org/all/20220802072426.GA2494@thinkpad/T/#mfa3a5b3a9694798a562c36b228f595b6a571477d
[2] https://lore.kernel.org/all/20220228055240.24774-1-manivannan.sadhasivam@linaro.org

Changes in v5:

* Collected review tag from Vidya
* Fixed the issue reported by Kbot regarding missing declaration

Changes in v4:

* Added check for the presence of event_ops before involing the callbacks (Kishon)
* Added return with IRQ_WAKE_THREAD when link_up event is found in the hard irq
  handler of tegra194 driver (Vidya)
* Collected review tags

Changes in v3:

* As Kishon spotted, fixed the DRA7xx driver and also the TEGRA194 driver to
  call the LINK_UP callback in threaded IRQ handler.

Changes in v2:

* Introduced a new "list_lock" for protecting the epc->pci_epf list and
  used it in the callback mechanism.

Manivannan Sadhasivam (5):
  PCI: dra7xx: Use threaded IRQ handler for "dra7xx-pcie-main" IRQ
  PCI: tegra194: Move dw_pcie_ep_linkup() to threaded IRQ handler
  PCI: endpoint: Use a separate lock for protecting epc->pci_epf list
  PCI: endpoint: Use callback mechanism for passing events from EPC to
    EPF
  PCI: endpoint: Use link_up() callback in place of LINK_UP notifier

 drivers/pci/controller/dwc/pci-dra7xx.c       |  2 +-
 drivers/pci/controller/dwc/pcie-tegra194.c    |  9 ++++-
 drivers/pci/endpoint/functions/pci-epf-test.c | 38 ++++++-------------
 drivers/pci/endpoint/pci-epc-core.c           | 32 ++++++++++++----
 include/linux/pci-epc.h                       | 10 +----
 include/linux/pci-epf.h                       | 19 ++++++----
 6 files changed, 59 insertions(+), 51 deletions(-)

-- 
2.25.1

