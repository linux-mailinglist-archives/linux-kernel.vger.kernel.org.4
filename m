Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F8B5FB4A7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 16:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbiJKOhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 10:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbiJKOg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 10:36:56 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF28752E59
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 07:36:54 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29B6p4J3008726;
        Tue, 11 Oct 2022 09:36:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=SQd/6TNFJXgCF7iuTtvqQxp6HqvqcwwIrNOxCz6sD/U=;
 b=JUdnWoNT8/P3ufBp9bDUoORUrAL9yUQL6XOk9Paf6EBhasRyCOT5xKbKff7MLF+BnKZ9
 y0blw6ZifDbZq/jNfyGom8vzxWWi6V5AvmmNtKpCTtY8pmmUEsS9HFizuFZ0Aa2ZA+H1
 kxZNfjwC28lgPHK69uEG4BQaN97Oj7I+tmFNBJ7zFo1b2NWhJZKifX8yeHje81PvDcOO
 5aEouzOGBCUEkSYlQwHyfB8pLIswOIe8aAw1S76ojOUwlnxIz5IIB8m+ggZJyhG34nZG
 Gbuthus2cLDexA/Mm//czaS4aTFsQtyOeoJ+U42+3xHE6aa8/NvdN5KzkxnegogMJ0qx aQ== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3k35mpuhdu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Oct 2022 09:36:14 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.12; Tue, 11 Oct
 2022 09:36:13 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.12 via Frontend Transport; Tue, 11 Oct 2022 09:36:13 -0500
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.90.202.160])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id D14B411DC;
        Tue, 11 Oct 2022 14:36:12 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v1 0/5] Support System Suspend and Resume for CS35L41 HDA
Date:   Tue, 11 Oct 2022 15:35:47 +0100
Message-ID: <20221011143552.621792-1-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: kxzeKo8pBJXMTwn-o6m8EAC2pH01l1mv
X-Proofpoint-GUID: kxzeKo8pBJXMTwn-o6m8EAC2pH01l1mv
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CS35L41 HDA driver currently only supports runtime suspend and resume.
Add support for system suspend and resume into the CS35L41 HDA driver.
The driver will put the parts into a state where they can be powered down
during suspend, and on system resume, it will restore the part.
If firmware was previously loaded, during system suspend, the firmware will
be unloaded, and during system resume, it will be loaded again.

Note: System suspend is only supported for models which use Internal Boost,
or models which use External Boost with a Boost Enable GPIO.

The chain also contains minor bug fixes for the CS35L41 HDA driver, and
associated hda_cs_dsp_ctl driver.

Richard Fitzgerald (1):
  ALSA: hda/cs_dsp_ctl: Fix mutex inversion when creating controls

Stefan Binding (4):
  ALSA: hda: hda_cs_dsp_ctl: Minor clean and redundant code removal
  ALSA: hda: hda_cs_dsp_ctl: Ensure pwr_lock is held before
    reading/writing controls
  ALSA: hda: cs35l41: Remove suspend/resume hda hooks
  ALSA: hda: cs35l41: Support System Suspend

 sound/pci/hda/cs35l41_hda.c    | 197 +++++++++++++++++++++++++--------
 sound/pci/hda/hda_component.h  |   2 -
 sound/pci/hda/hda_cs_dsp_ctl.c |  79 +++++++------
 sound/pci/hda/hda_cs_dsp_ctl.h |   2 +-
 sound/pci/hda/patch_realtek.c  |  19 +---
 5 files changed, 198 insertions(+), 101 deletions(-)

-- 
2.34.1

