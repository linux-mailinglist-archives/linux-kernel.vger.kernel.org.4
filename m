Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85DEB6010BC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 16:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbiJQOFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiJQOFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:05:44 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4231F642E5;
        Mon, 17 Oct 2022 07:05:41 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 63C8933E5B;
        Mon, 17 Oct 2022 14:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1666015539; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc;
        bh=4RoB3f0vV4gaiUdmvAQjE8R89ohmE3TBwvo8Cf6CUMw=;
        b=q55ootJXzdR2lPOdq1dB9ZSp7j6b15mg3Lw8s3RAZ+DwJxUIeS5YYR21u3+nnKVDgzw370
        +CTo0c7tGuamLaUM/O6/t/N4wVFUPh4c19XTlNupX99hIIGfAx9hJwnAb8MCJUXfC5A4RB
        RhvnXxt9rc2gjmxxMwhF/YAjgG6Zsc0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1666015539;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc;
        bh=4RoB3f0vV4gaiUdmvAQjE8R89ohmE3TBwvo8Cf6CUMw=;
        b=Pk4p2wYEQA+ZbvQ/zK2DQi5R3rbXOCC2ktHOsJKq17zGUDlBxj7ubmmF/+Z3rov/oQmS3g
        Po+DIOOg8qibVZCQ==
Received: from lion.mk-sys.cz (unknown [10.163.29.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 557A22C141;
        Mon, 17 Oct 2022 14:05:39 +0000 (UTC)
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
        id CC46F6043B; Mon, 17 Oct 2022 16:05:33 +0200 (CEST)
From:   Michal Kubecek <mkubecek@suse.cz>
Subject: [PATCH] scsi: mpi3mr: add explicit dependency on
 CONFIG_SCSI_SAS_ATTRS
To:     mpi3mr-linuxdrv.pdl@broadcom.com,
        Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <20221017140533.CC46F6043B@lion.mk-sys.cz>
Date:   Mon, 17 Oct 2022 16:05:33 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Starting with commit 42fc9fee116f ("scsi: mpi3mr: Add helper functions to
manage device's port"), kernel configured with CONFIG_SCSI_MPI3MR=m and
CONFIG_SCSI_SAS_ATTRS=n fails to build because modpost cannot find symbols
used in mpi3mr_transport.c:

  ERROR: modpost: "sas_port_alloc_num" [drivers/scsi/mpi3mr/mpi3mr.ko] undefined!
  ERROR: modpost: "sas_remove_host" [drivers/scsi/mpi3mr/mpi3mr.ko] undefined!
  ERROR: modpost: "sas_phy_alloc" [drivers/scsi/mpi3mr/mpi3mr.ko] undefined!
  ERROR: modpost: "sas_phy_free" [drivers/scsi/mpi3mr/mpi3mr.ko] undefined!
  ...

Add an explicit dependency of CONFIG_SCSI_MPI3MR on CONFIG_SCSI_SAS_ATTRS
to prevent inconsistent configs.

Fixes: 42fc9fee116f ("scsi: mpi3mr: Add helper functions to manage device's port")
Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
---
 drivers/scsi/mpi3mr/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/mpi3mr/Kconfig b/drivers/scsi/mpi3mr/Kconfig
index 8997531940c2..8ada8e8d25ac 100644
--- a/drivers/scsi/mpi3mr/Kconfig
+++ b/drivers/scsi/mpi3mr/Kconfig
@@ -2,7 +2,7 @@
 
 config SCSI_MPI3MR
 	tristate "Broadcom MPI3 Storage Controller Device Driver"
-	depends on PCI && SCSI
+	depends on PCI && SCSI && SCSI_SAS_ATTRS
 	select BLK_DEV_BSGLIB
 	help
 	MPI3 based Storage & RAID Controllers Driver.
-- 
2.38.0

