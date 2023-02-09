Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AEFC690DDF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 17:05:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbjBIQFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 11:05:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbjBIQF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 11:05:26 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A9B65672
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 08:04:37 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 319EbGUx024199;
        Thu, 9 Feb 2023 10:04:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=NZ7xBDBXQMgPcMlUjfpxYnKxvMVKqHABd3ZIXatEoA4=;
 b=U4a/nNj4bpRQ0pwcA/2JHt71b7rAcHlbE7NrAn6QQU7vxc+RY1qXAtsaBTTXs0IGCIG6
 41/jxBlvHsssQKenJkYJoFr9Fy4Cr6T+43Sx3hDGj66BJVUWRBJiByryOfNEgJrPvQ/M
 Fs2FKBlYPblOQ/ybs58Y1DWmFP+frSC26/1wsC2ghvPMLl2LSXnIxsSyR371w5FpRLDo
 l08+TEIAmIquILRuB6rg6ncXouNsA/4jZw1gQeTqw35Zk9nsQr60HmXPAcONyMIpwszm
 9d/rbIO+nP7lCbBYse7HJx7zCEzIziyI9AEM+qq8QpNh0IRQyyJlwiXw5eoG/viPI9Kh sw== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3nhmnv02nc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Feb 2023 10:04:14 -0600
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.21; Thu, 9 Feb
 2023 10:04:13 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.21 via Frontend
 Transport; Thu, 9 Feb 2023 10:04:13 -0600
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.90.202.160])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id D358D45;
        Thu,  9 Feb 2023 16:04:12 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v1 0/3] Various Fixes/Improvements for CS35L41 HDA
Date:   Thu, 9 Feb 2023 16:04:00 +0000
Message-ID: <20230209160403.838326-1-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: _wHsKOHLrv6YF-8VMDhYu3XtDC86CVDy
X-Proofpoint-ORIG-GUID: _wHsKOHLrv6YF-8VMDhYu3XtDC86CVDy
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes issue in calibration, where return codes were misinterpreted.
Enable High Pass filter to reduce pops and clicks.
Add improvement to ensure firmware and tuning files are always loaded
together.

Stefan Binding (2):
  ALSA: hda: cs35l41: Ensure firmware/tuning pairs are always loaded
  ALSA: hda: cs35l41: Enable Amp High Pass Filter

Vitaly Rodionov (1):
  ALSA: hda/cs35l41: Fix error condition check

 sound/pci/hda/cs35l41_hda.c | 117 ++++++++++++++++++------------------
 1 file changed, 58 insertions(+), 59 deletions(-)

-- 
2.34.1

