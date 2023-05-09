Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80D946FBFA0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 08:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235103AbjEIGxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 02:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235070AbjEIGwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 02:52:49 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92ABD4C03;
        Mon,  8 May 2023 23:52:46 -0700 (PDT)
X-UUID: 16d5a80cee3611edb20a276fd37b9834-20230509
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=6zZhM6OjKFAMCL2ZrfNektKJnwU1fC+GI7+J+76jWEQ=;
        b=OpBD8AFMxgDrrGSbOtvGpkBbtNN5CJhhFF/3XoLmTdVlvPluHo325p7gDTf02c29zabb1Y6WfZZXghZ0LemBsJSSm3miBvmM35vZQPsy5THS1LhJqeQpO46vvLfZ/mwdw9K4w0s6DItiqnaHI4RGqNWMtBngiMMV7AzN9TpsqAY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.23,REQID:03fbfabb-c0eb-4eb5-900f-e5b5ae64c48d,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:697ab71,CLOUDID:59153dc0-e32c-4c97-918d-fbb3fc224d4e,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 16d5a80cee3611edb20a276fd37b9834-20230509
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <ed.tsai@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 988925971; Tue, 09 May 2023 14:52:39 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 9 May 2023 14:52:39 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 9 May 2023 14:52:39 +0800
From:   Ed Tsai <ed.tsai@mediatek.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <martin.petersen@oracle.com>,
        <bvanassche@acm.org>, <stanley.chu@mediatek.com>,
        <peter.wang@mediatek.com>, <chun-hung.wu@mediatek.com>,
        <alice.chao@mediatek.com>, <powen.kao@mediatek.com>,
        <naomi.chu@mediatek.com>, <wsd_upstream@mediatek.com>,
        Ed Tsai <ed.tsai@mediatek.com>
Subject: [PATCH 0/2] block: improve the share tag set performance
Date:   Tue, 9 May 2023 14:52:28 +0800
Message-ID: <20230509065230.32552-1-ed.tsai@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tag allocation is limited by the number of active queues and a
queue is marked as inactive by the queue timeout worker after up to 30Hz
by default.

UFS devices have multiple logical units, and they can limit the depth of
data LUNs by the fair tag sharing algorithm. Make the fair tag sharing
configurable and improve the performance for UFS devices.

See also https://lore.kernel.org/all/20230103195337.158625-1-bvanassche@acm.org

Ed Tsai (2):
  block: make the fair sharing of tag configurable
  ufs: don't use the fair tag sharings

 block/blk-mq-debugfs.c    | 1 +
 block/blk-mq-tag.c        | 1 +
 block/blk-mq.c            | 3 ++-
 drivers/ufs/core/ufshcd.c | 3 +++
 include/linux/blkdev.h    | 6 +++++-
 5 files changed, 12 insertions(+), 2 deletions(-)

-- 
2.18.0

