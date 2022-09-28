Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 873265EDAEC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 13:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234101AbiI1LB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 07:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233974AbiI1LAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 07:00:50 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0BED12AB9
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 04:00:14 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id x1-20020a17090ab00100b001fda21bbc90so1734468pjq.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 04:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=hqHsGeDKe0t7ifwT22YFmx420oJcPi+zdGlDsAhLUb0=;
        b=m+h1aSlRyOmyWLPEegkC4UTOP5mPnZb/u7MDJuDqO7L0oSlCnQoyJhUm3SWgCH00mF
         +4ujgBYFq2vlJ2WRylNv/WHQ5qJlHSfvxyY9LrO5aufZZS9Sc1omuaJhkAHcj0qBr8y6
         39gHedQoOOfGN/PofAoqNRkBKCo0PSVhB4/blu7M03tzfCb5REYVvITZevtJbJ8KQYbQ
         eRcN4dzRCZRBWc/f5UZFCe2JWbhiFs+jqRa7UzCLfrvuit8SQUOZVv6lzNOvsW7qAllk
         n1heNKwq4tOo4KNg/bito9QLe9QeNk63Rbrab/wZsmr9npT0K5U+1EVIP96nrXfB2KmT
         0FYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=hqHsGeDKe0t7ifwT22YFmx420oJcPi+zdGlDsAhLUb0=;
        b=b4z6q4NZbVIRHbpBfvfa4GEzjfL3ck4flhKKyStD0ISQL/+hehEUOlCWNdxfqgibBJ
         GC5PEHC1EuGQGzvjjh/BXMtlMb1GTC1zoEF+JQDuSfxeLp9fBk2wN6MS9VcRsj+7Ifvv
         gj37uIjdi3wHn6x0jO2efoWjaBf4PguBCmZpaub72SoyCGFY77MplF50/udFVSkzGRSl
         HUmT6knoy9w+ImnunQr8PTz8ooOXsW8lwJZL1LtlZCRrBrxAX2SSJiml3YrH6fhI61A0
         BvK2NQmcTlsZFco5fVdjkOs0S1K3CWmhDFffl+gWTyiTUMysTPMRlZ//b3pb5l3FwSvO
         eClQ==
X-Gm-Message-State: ACrzQf0SRQiOlFs6nKqqGFoUJTt6LCgioYQFfaXsdJSUY9ESYgC+mEgm
        IPvuBpWytXkMkvZXBehku0mu+Q==
X-Google-Smtp-Source: AMsMyM5C26cGEuhYulr7S2jFc6VQqD+oKgKzpNLlpxnRs14brLWhNpxe/xWjjleGrOws83qXpNbKMw==
X-Received: by 2002:a17:903:24e:b0:179:b755:b82f with SMTP id j14-20020a170903024e00b00179b755b82fmr29636731plh.34.1664362814279;
        Wed, 28 Sep 2022 04:00:14 -0700 (PDT)
Received: from C02F63J9MD6R.bytedance.net ([61.120.150.77])
        by smtp.gmail.com with ESMTPSA id b13-20020a170902d50d00b00177efb56475sm1539524plg.85.2022.09.28.04.00.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Sep 2022 04:00:14 -0700 (PDT)
From:   Zhuo Chen <chenzhuo.1@bytedance.com>
To:     sathyanarayanan.kuppuswamy@linux.intel.com, bhelgaas@google.com,
        ruscur@russell.cc, oohall@gmail.com, fancer.lancer@gmail.com,
        jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
        james.smart@broadcom.com, dick.kennedy@broadcom.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     chenzhuo.1@bytedance.com, linuxppc-dev@lists.ozlabs.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ntb@lists.linux.dev, linux-scsi@vger.kernel.org
Subject: [PATCH v3 2/9] PCI/DPC: Use pci_aer_clear_uncorrect_error_status() to clear uncorrectable error status
Date:   Wed, 28 Sep 2022 18:59:39 +0800
Message-Id: <20220928105946.12469-3-chenzhuo.1@bytedance.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20220928105946.12469-1-chenzhuo.1@bytedance.com>
References: <20220928105946.12469-1-chenzhuo.1@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pci_aer_clear_uncorrect_error_status() clears both fatal and non-fatal
errors. So use it in place of pci_aer_clear_nonfatal_status()
and pci_aer_clear_fatal_status().

Signed-off-by: Zhuo Chen <chenzhuo.1@bytedance.com>
---
 drivers/pci/pcie/dpc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 3e9afee02e8d..7942073fbb34 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -288,8 +288,7 @@ void dpc_process_error(struct pci_dev *pdev)
 		 dpc_get_aer_uncorrect_severity(pdev, &info) &&
 		 aer_get_device_error_info(pdev, &info)) {
 		aer_print_error(pdev, &info);
-		pci_aer_clear_nonfatal_status(pdev);
-		pci_aer_clear_fatal_status(pdev);
+		pci_aer_clear_uncorrect_error_status(pdev);
 	}
 }
 
-- 
2.30.1 (Apple Git-130)

