Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C930723FB6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 12:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236949AbjFFKft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 06:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237311AbjFFKfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 06:35:19 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948BB10F3
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 03:35:01 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3565OZKp029668;
        Tue, 6 Jun 2023 05:34:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=AyhWPP1kgYcDXpfUImk0iDeFfbb+pb4A3CvCDnU8C2g=;
 b=K/jiTA2CBi2wOKTjOSv7HS0TE6h7sEgf3FNeKuNdKnDqt49DJj1VnubDc1mfTnLRBMFS
 FG0oZs7nF3QEFg/zO1SFg7aUeQ6gMpUXlVRL/LWHFgV9UrMM6TQe4fjD++Y6orQiKLLb
 3HLgrCsYIGmKH+UGc5Av6rIVqpqSCntU/o7uIsMJS68OpWnylMwCr8LJzKWc4tuHSAjy
 SFZl0qJ0lZt+pUM0XpBBrnvLnHbViiMTfk4pM/NComyrcfvhIlzivLV2xW4eI4vTsAMM
 KE+uNYn0/q9RkIBQRa+yZkjmynW3bgktFnhjzPcZCRN5EJOWUI9nj7Bdy0JwoYccgYyp aw== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3r01xnaxj3-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Jun 2023 05:34:46 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Tue, 6 Jun
 2023 11:34:44 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 6 Jun 2023 11:34:44 +0100
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.90.238.36])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 6A65415A4;
        Tue,  6 Jun 2023 10:34:44 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v3 3/3] ALSA: hda/realtek: Delete cs35l41 component master during free
Date:   Tue, 6 Jun 2023 11:34:36 +0100
Message-ID: <20230606103436.455348-4-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230606103436.455348-1-sbinding@opensource.cirrus.com>
References: <20230606103436.455348-1-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: VI5rgjUz7OKTiLaTImVqJ-67K0d56j5K
X-Proofpoint-GUID: VI5rgjUz7OKTiLaTImVqJ-67K0d56j5K
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This ensures that the driver is properly cleaned up when freed.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 sound/pci/hda/patch_realtek.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index f10790ace5c1d..a0e88fd17aa42 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6757,6 +6757,9 @@ static void cs35l41_generic_fixup(struct hda_codec *cdc, int action, const char
 		else
 			spec->gen.pcm_playback_hook = comp_generic_playback_hook;
 		break;
+	case HDA_FIXUP_ACT_FREE:
+		component_master_del(dev, &comp_master_ops);
+		break;
 	}
 }
 
-- 
2.34.1

