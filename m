Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4F0663547F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 10:08:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237067AbiKWJH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 04:07:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237155AbiKWJHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 04:07:01 -0500
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A85B1055AB
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 01:06:46 -0800 (PST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4NHFc36spTz4y0tt;
        Wed, 23 Nov 2022 17:06:27 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
        by mse-fl1.zte.com.cn with SMTP id 2AN96HLb057157;
        Wed, 23 Nov 2022 17:06:17 +0800 (+08)
        (envelope-from zhang.songyi@zte.com.cn)
Received: from mapi (xaxapp02[null])
        by mapi (Zmail) with MAPI id mid31;
        Wed, 23 Nov 2022 17:06:19 +0800 (CST)
Date:   Wed, 23 Nov 2022 17:06:19 +0800 (CST)
X-Zmail-TransId: 2afa637de28bffffffffb1842df1
X-Mailer: Zmail v1.0
Message-ID: <202211231706198927223@zte.com.cn>
Mime-Version: 1.0
From:   <zhang.songyi@zte.com.cn>
To:     <arnd@arndb.de>
Cc:     <mpe@ellerman.id.au>, <npiggin@gmail.com>,
        <christophe.leroy@csgroup.eu>, <linuxppc-dev@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>, <zhang.songyi@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIHBvd2VycGMvY2VsbC9heG9uX21zaTogcmVwbGFjZSBERUZJTkVfU0lNUExFX0FUVFJJQlVURSB3aXRoCiBERUZJTkVfREVCVUdGU19BVFRSSUJVVEU=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 2AN96HLb057157
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.251.13.novalocal with ID 637DE293.000 by FangMail milter!
X-FangMail-Envelope: 1669194387/4NHFc36spTz4y0tt/637DE293.000/10.5.228.132/[10.5.228.132]/mse-fl1.zte.com.cn/<zhang.songyi@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 637DE293.000/4NHFc36spTz4y0tt
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhang songyi <zhang.songyi@zte.com.cn>

Fix the following coccicheck warning:
/arch/powerpc/platforms/cell/axon_msi.c:457:0-23: WARNING:
fops_msic should be defined with DEFINE_DEBUGFS_ATTRIBUTE

Signed-off-by: zhang songyi <zhang.songyi@zte.com.cn>
---
 arch/powerpc/platforms/cell/axon_msi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/cell/axon_msi.c b/arch/powerpc/platforms/cell/axon_msi.c
index 5b012abca773..ab080b5022ff 100644
--- a/arch/powerpc/platforms/cell/axon_msi.c
+++ b/arch/powerpc/platforms/cell/axon_msi.c
@@ -454,7 +454,7 @@ static int msic_get(void *data, u64 *val)
        return 0;
 }

-DEFINE_SIMPLE_ATTRIBUTE(fops_msic, msic_get, msic_set, "%llu\n");
+DEFINE_DEBUGFS_ATTRIBUTE(fops_msic, msic_get, msic_set, "%llu\n");

 void axon_msi_debug_setup(struct device_node *dn, struct axon_msic *msic)
 {
@@ -475,6 +475,7 @@ void axon_msi_debug_setup(struct device_node *dn, struct axon_msic *msic)

        snprintf(name, sizeof(name), "msic_%d", of_node_to_nid(dn));

-       debugfs_create_file(name, 0600, arch_debugfs_dir, msic, &fops_msic);
+       debugfs_create_file_unsafe(name, 0600, arch_debugfs_dir,
+                                  msic, &fops_msic);
 }
 #endif /* DEBUG */
--
2.15.2
