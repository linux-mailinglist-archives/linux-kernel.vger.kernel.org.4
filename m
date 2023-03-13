Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73EA46B80A0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 19:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbjCMSbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 14:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbjCMSap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 14:30:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E393082AA5;
        Mon, 13 Mar 2023 11:30:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 297DDB811E6;
        Mon, 13 Mar 2023 18:29:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83239C433D2;
        Mon, 13 Mar 2023 18:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678732188;
        bh=1DImE4SDw/1U8fDi71hM95w/aAv4T4ec0I8H7KQ+MbI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mpqn37CO3YnID2JlgyqjnunDr7UPdRDoBHmebeu4XLs9TCKocPpNK3ykSj1/C27Bk
         O+C4nYshpQQlU4bsLzariiO9LboIVoXxQdCb/cSK4HO3ip751vaOz5yBy2pINfpLwH
         UttPAgR7r2mLoyW/dIQz4CNSV3GCkS8RNCngtI7w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     rafael@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: [PATCH 18/36] s390/topology: move to use bus_get_dev_root()
Date:   Mon, 13 Mar 2023 19:29:00 +0100
Message-Id: <20230313182918.1312597-18-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230313182918.1312597-1-gregkh@linuxfoundation.org>
References: <20230313182918.1312597-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1819; i=gregkh@linuxfoundation.org; h=from:subject; bh=1DImE4SDw/1U8fDi71hM95w/aAv4T4ec0I8H7KQ+MbI=; b=owGbwMvMwCRo6H6F97bub03G02pJDCn82ZVMSdq3W9W5kyctXRij3/9064LDm+Qf//qiu4nNK Eef3/tyRywLgyATg6yYIsuXbTxH91ccUvQytD0NM4eVCWQIAxenAFxkJ8P8mKg/F1xqY269Wzut XCDGZoPWHKvXDPMsk9e97pmdVD/589pFKrvSdzjMOLwEAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Direct access to the struct bus_type dev_root pointer is going away soon
so replace that with a call to bus_get_dev_root() instead, which is what
it is there for.

Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
Note, this is a patch that is a prepatory cleanup as part of a larger
series of patches that is working on resolving some old driver core
design mistakes.  It will build and apply cleanly on top of 6.3-rc2 on
its own, but I'd prefer if I could take it through my driver-core tree
so that the driver core changes can be taken through there for 6.4-rc1.

 arch/s390/kernel/topology.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kernel/topology.c b/arch/s390/kernel/topology.c
index c6eecd4a5302..72af753d1bba 100644
--- a/arch/s390/kernel/topology.c
+++ b/arch/s390/kernel/topology.c
@@ -649,12 +649,21 @@ static struct ctl_table topology_dir_table[] = {
 
 static int __init topology_init(void)
 {
+	struct device *dev_root;
+	int rc = 0;
+
 	timer_setup(&topology_timer, topology_timer_fn, TIMER_DEFERRABLE);
 	if (MACHINE_HAS_TOPOLOGY)
 		set_topology_timer();
 	else
 		topology_update_polarization_simple();
 	register_sysctl_table(topology_dir_table);
-	return device_create_file(cpu_subsys.dev_root, &dev_attr_dispatching);
+
+	dev_root = bus_get_dev_root(&cpu_subsys);
+	if (dev_root) {
+		rc = device_create_file(dev_root, &dev_attr_dispatching);
+		put_device(dev_root);
+	}
+	return rc;
 }
 device_initcall(topology_init);
-- 
2.39.2

