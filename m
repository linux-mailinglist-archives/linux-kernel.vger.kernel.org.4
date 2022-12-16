Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F90D64E64A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 04:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbiLPDQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 22:16:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbiLPDPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 22:15:15 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C706C70C
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 19:14:14 -0800 (PST)
X-UUID: fc73e221f67c4dc3a45f384dffe76cdf-20221216
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=F+2XiVV/hxebtLq5aHTxlzUZ5HkY+iv5QheRMxy1dWI=;
        b=aqce60Wp1yYtaA3hJsAn/RbepSC0FC0Pf2dopxilP2Dl5dIZ8MtLvlM/RXEohI0EzEVcsEOmu4NcnaS1yOQoLuX+LOzOyeC+4ZfwL1/de3MZkiDce5wImyn1Z9EXhEoQj12IpKnpEsyegh2Q7TrYTk2iYzzO9NTTew7OIF8LYFY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:908eb929-55b0-43b1-8b0a-5e91248137da,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:dcaaed0,CLOUDID:4c40cbaf-9f02-4d44-9c44-6e4bb4e4f412,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:1,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: fc73e221f67c4dc3a45f384dffe76cdf-20221216
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <alice.chao@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1576592472; Fri, 16 Dec 2022 11:14:06 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Fri, 16 Dec 2022 11:14:05 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Fri, 16 Dec 2022 11:14:05 +0800
From:   Alice Chao <alice.chao@mediatek.com>
To:     <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <matthias.bgg@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
CC:     <stanley.chu@mediatek.com>, <peter.wang@mediatek.com>,
        <chun-hung.wu@mediatek.com>, <alice.chao@mediatek.com>,
        <powen.kao@mediatek.com>, <naomi.chu@mediatek.com>,
        <cc.chou@mediatek.com>, <chaotian.jing@mediatek.com>,
        <jiajie.hao@mediatek.com>, <qilin.tan@mediatek.com>,
        <lin.gui@mediatek.com>, <yanxu.wei@mediatek.com>,
        <tun-yu.yu@mediatek.com>, <eddie.huang@mediatek.com>,
        <wsd_upstream@mediatek.com>
Subject: [PATCH 1/1] scsi: Add length check to prevent invalid memory access
Date:   Fri, 16 Dec 2022 11:13:22 +0800
Message-ID: <20221216031320.2634-1-alice.chao@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Device reset thread uses kobject_uevent_env() to get kobj.parent(kobj.p)
, and it races with device init thread which calls device_add() to add
kobj.parent before kobject_uevent_env().

Device init call:           Device reset call:
scsi_probe_and_add_lun()    scsi_evt_thread()
  scsi_add_lun()             scsi_evt_emit()
   scsi_sysfs_add_sdev()      kobject_uevent_env() //get kobj.parent
    scsi_target_add()           kobject_get_path()
                                 len = get_kobj_path_length ()
                                 //len=1 because parent hasn't created yet
    device_add() // add kobj.parent
      kobject_uevent_env()
       kobject_get_path()         path = kzalloc()
        fill_kobj_path()           fill_kobj_path()
                            // --length; length -= cur is a negative value
                         memcpy(path + length, kobject_name(parent), cur);
                         // slab OOB!

Above backtrace describes the problem, device reset thread will get wrong
kobj.parent when device init thread didn't add kobj/parent yet. When this
racing happened, it triggers the a KASAN dump on the final iteration:

BUG: KASAN: slab-out-of-bounds in kobject_get_path+0xf8/0x1b8
Write of size 11 at addr ffffff80d6bb94f5 by task kworker/3:1/58
<snip>

Call trace:
 __kasan_report+0x124/0x1c8
 kasan_report+0x54/0x84
 kasan_check_range+0x200/0x208
 memcpy+0xb8/0xf0
 kobject_get_path+0xf8/0x1b8
 kobject_uevent_env+0x228/0xa88
 scsi_evt_thread+0x2d0/0x5b0
 process_one_work+0x570/0xf94
 worker_thread+0x7cc/0xf80
 kthread+0x2c4/0x388

These two jobs are scheduled asynchronously, we can't guaranteed that
kobj.parent will be created in device init thread before device reset
thread calls kobject_get_path().

To prevent length -= cur from being a negative value, we add length
check in fill_kobj_path() to prevent invalid memory access.

Signed-off-by: Alice Chao <alice.chao@mediatek.com>
---
 lib/kobject.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/kobject.c b/lib/kobject.c
index af1f5f2954d4..3cccb8e88d4e 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -121,6 +121,10 @@ static void fill_kobj_path(struct kobject *kobj, char *path, int length)
 		int cur = strlen(kobject_name(parent));
 		/* back up enough to print this name with '/' */
 		length -= cur;
+
+		if (length <= 0)
+			break;
+
 		memcpy(path + length, kobject_name(parent), cur);
 		*(path + --length) = '/';
 	}
-- 
2.18.0

