Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8B3F665A83
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 12:42:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236329AbjAKLmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 06:42:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233509AbjAKLmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 06:42:18 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111D81A226
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 03:41:11 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id c8-20020a17090a4d0800b00225c3614161so19699816pjg.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 03:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WGn0PbiFymHKMcNjUGWXoioOm7PfQt5MHEJvVchVE4s=;
        b=vQORdR6YtP3qXos2Sq8ad45eAuhZXsCz27JZRFq3fTkPUXkp5Yuamn7iSF5xo0dKGc
         t90Ik+2YovehtVfbbRiqAIdxkSlRwTBkv92uP04k+6eP3C9gcOT6KWXx1rqlyXXBqzyJ
         qg8VPMI1OoyEEiZ6WFsH8Mbm5Wg/KqmcxVXAsJZHcIfxOYG+vyjnDYHmUESLV2OmRu5w
         ikS762lJND84NQ7iuWObM/GJcxkIUARS69OiB2vl9WSqx8xelhQyYHLmjndn3feuyGYo
         FeANEJ6vdh6JQDoqWCasmnsG495/yALGi2GJY3CgJONvLwpLvfc6iVPin0b0eUrraybV
         GBcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WGn0PbiFymHKMcNjUGWXoioOm7PfQt5MHEJvVchVE4s=;
        b=12S145LtWKQtT93ObtpG9j9pgveEZ48TPacWAq2ZlikPLFhaaz8LS4iXbktFWp5XE1
         kSeGVdykGYnLu5Eh0/wt0NeLVPbuGBam+qcLxwF30jq8i7N2FcKXlwTitg8blsCr2Xqr
         SuwO81Lu+WMDIdB+8bABf/i+ma9hI20EhvkAA49odnJsfnDrSQR5YkiCAW8AOoUlxwF/
         iSd7KlY1EID1NP72Q5Z+jf1vrvDqKbfdZUzNzZ8GWGy1DrFqIoVKqCN/7FFAirvOOFOa
         OzlXr8e1i8TbyHWOC6Y6glSf197w50QxrWd2vTZZuF4PuPpFuAlCG5bPOwC1LZ/KM7gA
         1yoQ==
X-Gm-Message-State: AFqh2kreQ5iR/lYsCJ6HG992FZCPRQE2qaWpibVukvlUGh1Fq+WxVWpB
        kDItPcTEZ3BS6dXotgRr/P7h
X-Google-Smtp-Source: AMrXdXuBl2ZhAZQRvCvILyuORpqz/vseZxHZTIPCgKgEyfzzOBe1BUnhX7xv1+dj9b0WEizfhn4REA==
X-Received: by 2002:a17:902:e805:b0:192:4b3e:9f8e with SMTP id u5-20020a170902e80500b001924b3e9f8emr87640938plg.36.1673437270953;
        Wed, 11 Jan 2023 03:41:10 -0800 (PST)
Received: from localhost.localdomain ([117.217.177.1])
        by smtp.gmail.com with ESMTPSA id u14-20020a170902e5ce00b0018958a913a2sm9942688plf.223.2023.01.11.03.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 03:41:10 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     kishon@kernel.org, lpieralisi@kernel.org, bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, robh@kernel.org, vidyas@nvidia.com, vigneshr@ti.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [RESEND v4 0/5] PCI: endpoint: Rework the EPC to EPF notification
Date:   Wed, 11 Jan 2023 17:10:54 +0530
Message-Id: <20230111114059.6553-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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

