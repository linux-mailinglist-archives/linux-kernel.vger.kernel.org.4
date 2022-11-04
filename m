Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38C9C6193B3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 10:39:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbiKDJjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 05:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbiKDJjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 05:39:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB2A2250B;
        Fri,  4 Nov 2022 02:39:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF15C62113;
        Fri,  4 Nov 2022 09:39:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36916C433D6;
        Fri,  4 Nov 2022 09:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667554780;
        bh=vBRE2zaNk9N2+qpe0TEUqPTS+nFtRWARCQHJUnRfQFQ=;
        h=From:To:Cc:Subject:Date:From;
        b=TQMFVP0DnwjC5bCpvwoumZ69nBPt7Pwp8dEuwdxMjH31qncebTLneyvwX/QPwfpBK
         Z4EIpr949jgEpHSYhOgZmN3DwhMwJYikFIQAc+jeHyi+3K7omux6QAeI4bpq62gQry
         ZzKAOWazoY0Sn0OZHR1GRyPBFDFZzE7YqQxTcIwv4NadBE1D4o2FsqCmLGIkRhUHOm
         vM27Yx8QI2fhcghxjQgNPWbvU9PJeZLBBFfgV8VDNn2u8oqfeNPkOgWr+KVNo8Qj1E
         1ZIksIdBveqqnZ0eQjQT0qM5BqWTCwcI9GIk5n7ipSE4UMnDb9U0hZADsBSg4U6heZ
         LoD8/2TSRTr4w==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oqtAX-00064k-QT; Fri, 04 Nov 2022 10:39:22 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Manivannan Sadhasivam <mani@kernel.org>
Cc:     Hemant Kumar <quic_hemantk@quicinc.com>, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v2] mhi: pci_generic: add support for sc8280xp-crd SDX55 variant
Date:   Fri,  4 Nov 2022 10:39:13 +0100
Message-Id: <20221104093913.23347-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SC8280XP Compute Reference Design (CRD) has an on-PCB SDX55 modem
which uses MBIM.

The exact channel configuration is not known but the Foxconn SDX55
configuration allows the modem to be used so reuse that one for now.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---

Changes in v2
 - drop comment describing this variant (Mani)


 drivers/bus/mhi/host/pci_generic.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
index caa4ce28cf9e..7dcd0ef3184a 100644
--- a/drivers/bus/mhi/host/pci_generic.c
+++ b/drivers/bus/mhi/host/pci_generic.c
@@ -542,6 +542,8 @@ static const struct mhi_pci_dev_info mhi_telit_fn990_info = {
 static const struct pci_device_id mhi_pci_id_table[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x0304),
 		.driver_data = (kernel_ulong_t) &mhi_qcom_sdx24_info },
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x0306, PCI_VENDOR_ID_QCOM, 0x010c),
+		.driver_data = (kernel_ulong_t) &mhi_foxconn_sdx55_info },
 	/* EM919x (sdx55), use the same vid:pid as qcom-sdx55m */
 	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x0306, 0x18d7, 0x0200),
 		.driver_data = (kernel_ulong_t) &mhi_sierra_em919x_info },
-- 
2.37.3

