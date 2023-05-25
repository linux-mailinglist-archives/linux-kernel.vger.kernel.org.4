Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9A20710F17
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 17:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241460AbjEYPHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 11:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241425AbjEYPH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 11:07:29 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2E7198
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 08:07:28 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34PEE1Bv025343;
        Thu, 25 May 2023 10:07:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=KBIQkBTpPs9dMkt+aC+6iuTHRtDG89mSTGRvAWzKXRU=;
 b=L4ImnF6j3P+RjrPTNwSsBAO8KZnux+JrtF990BsFFTFcWShKDNiMFo5zacvFLMrcoUCr
 J4M5+581U905r0MqkUBOu08EPTvaHq3A7+jS1ZyYwFr9T/ODxvgP6D86WSaLkG8GWf65
 iVeD4wjEnNIctr1AmKlRRBRnM4gWEf0ViBSpSQOiAFHrWRikCQsYLfHj9LFKPUsUZ4sW
 m/WskQryjvSJ4LScRfUCkB6vbncz0YgaY4UBiggFcwPr4nM2EgdLR4whEGoawz/qVlV0
 iIXpAJjMxuawRa483NFhiNaTBTwr8dcOmf/Vd4C19AOsXb3aROzVNU4JuhEA16gbbbk0 yg== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3qptmm70m4-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 10:07:08 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Thu, 25 May
 2023 10:07:05 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Thu, 25 May 2023 10:07:05 -0500
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.65.166])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 86FA515B7;
        Thu, 25 May 2023 15:07:05 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <tiwai@suse.com>, <broonie@kernel.org>, <perex@perex.cz>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 11/13] ALSA: hda: Fix missing header dependencies
Date:   Thu, 25 May 2023 16:06:57 +0100
Message-ID: <20230525150659.25409-12-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230525150659.25409-1-rf@opensource.cirrus.com>
References: <20230525150659.25409-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: DSk6jIDbkwD673WbeKhFJ6el818P3339
X-Proofpoint-GUID: DSk6jIDbkwD673WbeKhFJ6el818P3339
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

Add #includes of dependencies into hda_auto_parser.h and hda_generic.h

hda_auto_parser.h uses definitions in hda_local.h.

hda_generic.h uses definitions in hda_local.h and hda_auto_parser.h.
It also references struct hda_jack_callback, but only as a pointer.
This has been forward-declared so hda_jack.h only needs to be
included in source that actually uses it.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/pci/hda/hda_auto_parser.h | 2 ++
 sound/pci/hda/hda_generic.h     | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/sound/pci/hda/hda_auto_parser.h b/sound/pci/hda/hda_auto_parser.h
index df63d66af1ab..579b11beac71 100644
--- a/sound/pci/hda/hda_auto_parser.h
+++ b/sound/pci/hda/hda_auto_parser.h
@@ -8,6 +8,8 @@
 #ifndef __SOUND_HDA_AUTO_PARSER_H
 #define __SOUND_HDA_AUTO_PARSER_H
 
+#include "hda_local.h"
+
 /*
  * Helper for automatic pin configuration
  */
diff --git a/sound/pci/hda/hda_generic.h b/sound/pci/hda/hda_generic.h
index 34eba40cc6e6..a8eea8367629 100644
--- a/sound/pci/hda/hda_generic.h
+++ b/sound/pci/hda/hda_generic.h
@@ -9,6 +9,9 @@
 #define __SOUND_HDA_GENERIC_H
 
 #include <linux/leds.h>
+#include "hda_auto_parser.h"
+
+struct hda_jack_callback;
 
 /* table entry for multi-io paths */
 struct hda_multi_io {
-- 
2.30.2

