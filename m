Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3D4710DCA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 16:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241447AbjEYOAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 10:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241428AbjEYOAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 10:00:30 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF031E4C
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 07:00:19 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34PBPhU1006105;
        Thu, 25 May 2023 09:00:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=eCUB3/UAkA9+tomxghvik6imKdz8/+ICfTEkpKQI8uY=;
 b=eZxZiJcHrmr+vZMK/3sW3OqEVSBH7BJDsmS4mTaGmw7CsbkcFPDBz2pVwto92Vd7KS6Y
 OuuDADJWsyE5vC2e0y9bhoZY+WVPV58pJtsNklLv3fYBOBPfZmAUtvF5wusR/p+4zAgU
 UFITRSVKq4vPfI8g5GQj4gTLi5A6E7Pb0ZE0RNba9sy5KDGywPuCb4Z1Fv1I05/+uCiJ
 7mu78YzUYQuVlL68sEEmPLQu41s1kfkiv041kIZfJqV1ezvdknLJnflRhtAvl4rDI6vG
 xwPOvRN2pLW5MHYs5+l4etPuIDrH31qxLXB01BXUZH6WvCGow0qNlXlphBeN8feFN9lv aA== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3qptmm6wbf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 09:00:04 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Thu, 25 May
 2023 09:00:03 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 25 May 2023 09:00:03 -0500
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.90.238.43])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id DBC6311D4;
        Thu, 25 May 2023 14:00:02 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH RESEND v1 0/3] Fixes and cleanup for CS35L41 HDA
Date:   Thu, 25 May 2023 14:59:52 +0100
Message-ID: <20230525135955.2108140-1-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: VhJfL1LOPdClfRFRPp5aDzebKY6BtOK9
X-Proofpoint-GUID: VhJfL1LOPdClfRFRPp5aDzebKY6BtOK9
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

Several minor issues were found during additional testing and
static analysis. These patches fix these minor issues.

Stefan Binding (3):
  ALSA: hda: cs35l41: Clean up Firmware Load Controls
  ALSA: hda: cs35l41: Fix endian conversions
  ALSA: hda/realtek: Delete cs35l41 component master during free

 sound/pci/hda/cs35l41_hda.c   | 40 ++++++++++++++++-------------------
 sound/pci/hda/patch_realtek.c |  2 ++
 2 files changed, 20 insertions(+), 22 deletions(-)

-- 
2.34.1

