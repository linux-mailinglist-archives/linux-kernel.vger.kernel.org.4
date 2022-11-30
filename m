Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 172EE63D05C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 09:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234648AbiK3IXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 03:23:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234768AbiK3IXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 03:23:13 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6C4E04
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 00:23:11 -0800 (PST)
X-UUID: 8e3436dd24714848a86fc3ecd72f2dfc-20221130
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=MUWs0peHeFh8I8V0mHaov2V5/9takFBfLQgSzUIxJn0=;
        b=JUgDJersQILyGgks6V+jTGR4BNCqTeBDlr7wVwFoPiNTcaXa2F77UVDQvw9HsEZw22R5+kW20stFeJNQ0iRMYesii4tlQmIgIQFxd0Ej9sBj4Dk0MCkWkPm+edPiwalDKJUlZC7jnBi7zrurHNEqt+swkl37eNjnw7YwzDHCJ2I=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:5e55e971-5f05-4353-90ea-9fd3211dfef7,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.14,REQID:5e55e971-5f05-4353-90ea-9fd3211dfef7,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:dcaaed0,CLOUDID:f62c216c-41fe-47b6-8eb4-ec192dedaf7d,B
        ulkID:221130162307VUMOZIKQ,BulkQuantity:1,Recheck:0,SF:28|17|19|48,TC:nil,
        Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:43,QS:nil,BEC:nil,COL:0
X-UUID: 8e3436dd24714848a86fc3ecd72f2dfc-20221130
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <andrew.yang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 487435394; Wed, 30 Nov 2022 16:23:07 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 30 Nov 2022 16:23:06 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 30 Nov 2022 16:23:06 +0800
From:   Andrew Yang <andrew.yang@mediatek.com>
To:     <rostedt@goodmis.org>
CC:     <andrew.yang@mediatek.com>, <casper.li@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <mhiramat@kernel.org>
Subject: [PATCH v2] mm/writeback: fix dereferencing NULL mapping->host
Date:   Wed, 30 Nov 2022 16:23:02 +0800
Message-ID: <20221130082303.30859-1-andrew.yang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20221129095620.4c1a8056@gandalf.local.home>
References: <20221129095620.4c1a8056@gandalf.local.home>
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

From: "andrew.yang" <andrew.yang@mediatek.com>

Check before dereferencing mapping->host

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: andrew.yang <andrew.yang@mediatek.com>
---
v2: add parenthesis
---
 include/trace/events/writeback.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
index 86b2a82da546..54e353c9f919 100644
--- a/include/trace/events/writeback.h
+++ b/include/trace/events/writeback.h
@@ -68,7 +68,7 @@ DECLARE_EVENT_CLASS(writeback_folio_template,
 		strscpy_pad(__entry->name,
 			    bdi_dev_name(mapping ? inode_to_bdi(mapping->host) :
 					 NULL), 32);
-		__entry->ino = mapping ? mapping->host->i_ino : 0;
+		__entry->ino = (mapping && mapping->host) ? mapping->host->i_ino : 0;
 		__entry->index = folio->index;
 	),
 
-- 
2.18.0

