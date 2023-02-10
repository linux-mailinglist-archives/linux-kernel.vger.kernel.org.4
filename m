Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57694691EDA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 13:08:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbjBJMIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 07:08:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbjBJMIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 07:08:34 -0500
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63D557772
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 04:08:33 -0800 (PST)
Received: from fews2.riseup.net (fews2-pn.riseup.net [10.0.1.84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4PCsvj1QJ1zDqJ5;
        Fri, 10 Feb 2023 12:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1676030913; bh=006T42n5ayIRq96/1xRWWSnZfPhFc8SBxKW2hAn4L0Q=;
        h=Date:To:From:Subject:From;
        b=Ivu5tZa2XuBkk/CX5DfwpqbMIdepENBDpMnaRaUfpnoMOBou0NdzNELw/SZhk6cMC
         2IO7iptFtstJj9RtWpRQ5xHgmIzJ2AmRLFTHYO90nG3WnxaiTaFjrNWgBFaVrS0lX6
         bmg80ddng+QYRqdz2OPK90eMyVSxAMVis2C7Wh4E=
X-Riseup-User-ID: C971FB09AF76FF13C7B5EE703B0DF115B822322E6E6A097822E9006E73A5AF41
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews2.riseup.net (Postfix) with ESMTPSA id 4PCsvg2ymqz1yTd;
        Fri, 10 Feb 2023 12:08:31 +0000 (UTC)
Message-ID: <96afa026-e1a9-0ce5-d9ff-36f7e5c1a5b2@riseup.net>
Date:   Fri, 10 Feb 2023 15:08:29 +0300
MIME-Version: 1.0
Content-Language: en-US
To:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Ivan Rubinov <soltime@riseup.net>
Subject: [PATCH] Add quirk for ADATA SX6000PNP
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 From 5a8f4f54c85ccb8e06b41b27bcaf19ec4f4d7c85 Mon Sep 17 00:00:00 2001
From: Ivan Rubinov <linuxkernelpatch8234@riseup.net>
Date: Fri, 10 Feb 2023 14:59:41 +0300
Subject: [PATCH] Add quirk for ADATA SX6000PNP

Signed-off-by: Ivan Rubinov <linuxkernelpatch8234@riseup.net>
---
  drivers/nvme/host/pci.c | 2 ++
  1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c734934c407c..c63443d531b3 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3365,6 +3365,8 @@ static const struct pci_device_id nvme_id_table[] = {
      { PCI_VDEVICE(INTEL, 0x0953),    /* Intel 750/P3500/P3600/P3700 */
          .driver_data = NVME_QUIRK_STRIPE_SIZE |
                  NVME_QUIRK_DEALLOCATE_ZEROES, },
+    { PCI_DEVICE(0x10ec, 0x5763),   /* ADATA SX6000PNP */
+        .driver_data = NVME_QUIRK_IGNORE_DEV_SUBNQN | 
NVME_QUIRK_BOGUS_NID, },
      { PCI_VDEVICE(INTEL, 0x0a53),    /* Intel P3520 */
          .driver_data = NVME_QUIRK_STRIPE_SIZE |
                  NVME_QUIRK_DEALLOCATE_ZEROES, },
-- 
2.39.1

