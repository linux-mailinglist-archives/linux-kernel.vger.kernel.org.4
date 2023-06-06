Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFB90723FB5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 12:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236880AbjFFKfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 06:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237304AbjFFKfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 06:35:19 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B88210C7
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 03:35:00 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3565N8jI006095;
        Tue, 6 Jun 2023 05:34:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=hXdwTd2fuvfqZGo4qjG52aP1P7Vq04LCvv+OwS612IE=;
 b=fBMSNFtJUc9buHpvW7rUEdq2+dYBhDToUW7y7qtVlNkPi1GejLaJwV/oJZtYMHdw/e8O
 oGft8w9S16cRe1tOEBW4fxT3K9eXybKqTTUyYRfmSdIPls2mF18CtnIsqbtjWnIRGI8n
 C9S3PFrItTrNatYDSLHjp87GyACejKKZUrmue8mplzm/bu3mkIzOwtLCng7yHLD8zU00
 d6UbWfibOPiSSD+xLjyw5739yQUH6n8IynMMT14+5SnHq947A5gfn3O/Ej9cd2o7UXqI
 M2RoM2Y14calt7dAw9RIAZbW3lrSVqzhIkj0rlwPgnUhU2pejb8A6OY+CA2W2lhVFgGB Hw== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3r02x1asf3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Jun 2023 05:34:46 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Tue, 6 Jun
 2023 11:34:44 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 6 Jun 2023 11:34:44 +0100
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.90.238.36])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id B086A11AA;
        Tue,  6 Jun 2023 10:34:43 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v3 0/3] Fixes and cleanup for CS35L41 HDA
Date:   Tue, 6 Jun 2023 11:34:33 +0100
Message-ID: <20230606103436.455348-1-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: fmIDXws0Go9KkKXY2aB700fzg5SDoh1M
X-Proofpoint-GUID: fmIDXws0Go9KkKXY2aB700fzg5SDoh1M
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

CHANGES SINCE V2:
Patch 3:
- Add missing break

CHANGES SINCE V1:
Patch 2:
- Removed unnecessary cast

Stefan Binding (3):
  ALSA: hda: cs35l41: Clean up Firmware Load Controls
  ALSA: hda: cs35l41: Fix endian conversions
  ALSA: hda/realtek: Delete cs35l41 component master during free

 sound/pci/hda/cs35l41_hda.c   | 32 ++++++++++++++------------------
 sound/pci/hda/patch_realtek.c |  3 +++
 2 files changed, 17 insertions(+), 18 deletions(-)

-- 
2.34.1

