Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16F63642ACB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 15:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbiLEO6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 09:58:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbiLEO6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 09:58:01 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4665363D4
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 06:57:59 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B54uh1Z015435;
        Mon, 5 Dec 2022 08:57:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=c7x/qQVbB5y+L+elrUKFfYzMACzD6HbBUpL317TwXgQ=;
 b=MSnMzBqCbWx1sWMn05rAdoeNlhDXqpHquTzf3bLr+aPvqjwcSCH8Z5Pg4k4Ojve/wiiu
 tFNE8bLvP1wu5aXmvFxb0Y1fqBEaINtoDnyMdPip5/nM+ljvNKHRKfBnx4ODdqSO4kBg
 kAcCg8cgydPzhS8EOZ0ZP4pFPaAKD4hKUmuauB4aOL1DhZzHHA5HCEzveC4qASi7u/nD
 QbKVFsT7+AY6YpOJ+QOgWSbM0mH2footCrcuZuYhfEqXnmGRAq2fpp3tBYnlR0DtSq6l
 UV49Ns5Nv03kFeOLZ5vVDURnDsLHibl11mXuidBNu8hd+QaA+Sg75XChQCRZSzb3VQsP CA== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3m83rt9vr9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Dec 2022 08:57:15 -0600
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.20; Mon, 5 Dec
 2022 08:57:14 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.20 via Frontend
 Transport; Mon, 5 Dec 2022 08:57:14 -0600
Received: from legion.ad.cirrus.com (londmb751293.ad.cirrus.com [198.90.238.109])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id CCF48B12;
        Mon,  5 Dec 2022 14:57:13 +0000 (UTC)
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] ALSA: hda/cirrus: Add extra 10 ms delay to allow PLL settle and lock.
Date:   Mon, 5 Dec 2022 14:57:13 +0000
Message-ID: <20221205145713.23852-1-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: fyBzRj7SDDWKls60G-AfQoMavE1CEUKO
X-Proofpoint-GUID: fyBzRj7SDDWKls60G-AfQoMavE1CEUKO
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

New HW platforms with multiple CS42L42 parts, faster CPU and i2c
requre some extra delay to allow PLL to settle and lock. Adding
extra 10ms delay.

Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 sound/pci/hda/patch_cs8409.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_cs8409.c b/sound/pci/hda/patch_cs8409.c
index 754aa8ddd2e4..0ba1fbcbb21e 100644
--- a/sound/pci/hda/patch_cs8409.c
+++ b/sound/pci/hda/patch_cs8409.c
@@ -888,7 +888,7 @@ static void cs42l42_resume(struct sub_codec *cs42l42)
 
 	/* Initialize CS42L42 companion codec */
 	cs8409_i2c_bulk_write(cs42l42, cs42l42->init_seq, cs42l42->init_seq_num);
-	usleep_range(20000, 25000);
+	usleep_range(30000, 35000);
 
 	/* Clear interrupts, by reading interrupt status registers */
 	cs8409_i2c_bulk_read(cs42l42, irq_regs, ARRAY_SIZE(irq_regs));
-- 
2.34.1

