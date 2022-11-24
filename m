Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69F91637A30
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 14:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiKXNqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 08:46:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbiKXNqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 08:46:12 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E792A100B3E
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 05:46:10 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AO7cYHh023037;
        Thu, 24 Nov 2022 07:45:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=57+ehutbpROj7wl3AtYb+dFSd1DaJ5oQytngLLo4Ycw=;
 b=oBwKMkGFKzD1etx9Q+s9F7ScR7NLiX5n9rnu6oaqy4erSdqnagUA739FJtiCaOAkTT/8
 aQme57K5CXuoPs1tmnr8P2/tMtFSDJRR0oGTJCPFluID8XpoUg1KfPXNFtKs904smFhz
 +1z3EKDWw4bZ2IuQaUD/9HfWzAbX5yV/+rNMpQEuGWbRQuoJ6DeH1E5wdfEvi1HQcdgc
 bD39H3UMJckIjyagr6ejKNNuxqTlmCLOPR8CqqnT4gio8ov6SyErTFFawurr+yQfHB6M
 Bh5MADGBfMn+QV3phuVYEyFgTsCszg/xZstHEi/u3HjRkZsN+IFCC5j12kY1KoW1YK1c gA== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3kxvet664v-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Nov 2022 07:45:58 -0600
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.20; Thu, 24 Nov
 2022 07:45:56 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.20 via Frontend Transport; Thu, 24 Nov 2022 07:45:56 -0600
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.111])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 6A5EA2BA;
        Thu, 24 Nov 2022 13:45:56 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>, <tiwai@suse.com>
CC:     <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>,
        <alsa-devel@alsa-project.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 0/2] firmware: cs_dsp: Switch to using namespaced exports
Date:   Thu, 24 Nov 2022 13:45:54 +0000
Message-ID: <20221124134556.3343784-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ucKswuTozDWhhd_I6aW6w-1Wu9AtQh6C
X-Proofpoint-GUID: ucKswuTozDWhhd_I6aW6w-1Wu9AtQh6C
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use EXPORT_SYMBOL_NS_GPL() instead of EXPORT_SYMBOL_GPL() and patch the
three drivers that use cs_dsp to add the MODULE_IMPORT_NS().

To make the namespace more specific the KConfig symbol for cs_dsp is
changed from CS_DSP to FW_CS_DSP.

Richard Fitzgerald (2):
  firmware: cs_dsp: Rename KConfig symbol CS_DSP -> FW_CS_DSP
  firmware: cs_dsp: Make the exports namespaced

 drivers/firmware/cirrus/Kconfig  |  2 +-
 drivers/firmware/cirrus/Makefile |  2 +-
 drivers/firmware/cirrus/cs_dsp.c | 62 ++++++++++++++++----------------
 sound/pci/hda/Kconfig            |  2 +-
 sound/pci/hda/cs35l41_hda.c      |  1 +
 sound/pci/hda/hda_cs_dsp_ctl.c   |  1 +
 sound/soc/codecs/Kconfig         |  2 +-
 sound/soc/codecs/wm_adsp.c       |  1 +
 8 files changed, 38 insertions(+), 35 deletions(-)

-- 
2.30.2

