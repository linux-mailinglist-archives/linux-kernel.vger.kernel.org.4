Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D68F63664E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 17:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239190AbiKWQ61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 11:58:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238244AbiKWQ6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 11:58:20 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2280613EB2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 08:58:18 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ANFXqhG006843;
        Wed, 23 Nov 2022 10:58:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=6rkTGpmifl/SCSO2FYjDVcYnfqkoh88KIkFWSJRpPYM=;
 b=ApFt1awoIstLm/WRXRGZ0RJEMaMnBsl46RzOmgKV3vO9FzSKJsjtteMaaFZtZxZWsJx0
 jb4JycaQpOs74yfQF7DACSi26qQnvws0N6RvHPed5N05QOBkaFvfpHgk/9wc3fNZrsJf
 VaG2f97oWHZefLprmYBL02HEu5BaSrbTnuybBXPc9IPXv6nn9Da/0C61vNLR935gRcjF
 78bpwjOsnfQ3Ud9VtXV0hucJA2p2KHrwN8XtKsuVNS5gfuAZpdm6GDYgdon8t5mTlVhz
 BteCyap7l4EXOzqJBuZE8Kono7v2O/vbs2OOJLFVowg3wnNyoW5gOOFb+P9IYPMdV4Jj FA== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3kxwe6w535-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Nov 2022 10:58:13 -0600
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.20; Wed, 23 Nov
 2022 10:58:11 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.20 via Frontend Transport; Wed, 23 Nov 2022 10:58:11 -0600
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.111])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 5F3F12BA;
        Wed, 23 Nov 2022 16:58:11 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <patches@opensource.cirrus.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH v2 0/2] ASoC: wm_adsp: Report when a control write changes the value
Date:   Wed, 23 Nov 2022 16:58:09 +0000
Message-ID: <20221123165811.3014472-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: x8XpFbHj4BGwbdArUhYqFIJpwJ9Itmul
X-Proofpoint-GUID: x8XpFbHj4BGwbdArUhYqFIJpwJ9Itmul
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Writing a firmware control should be returning 1 if the control value
changed, so these two patches add that.

Though this is an ALSA requirement it is also useful for non-ALSA clients
of cs_dsp to know if the control value changed, so the main handling is
implemented in cs_dsp. TLV controls are specifically an ALSA thing so they
are handled specially in wm_adsp.

Simon Trimmer (2):
  firmware: cs_dsp: cs_dsp_coeff_write_ctrl() should report changed
  ASoC: wm_adsp: Return whether changed when writing controls

 drivers/firmware/cirrus/cs_dsp.c | 17 ++++++++++++-----
 sound/soc/codecs/wm_adsp.c       | 27 ++++++++++++++++++---------
 2 files changed, 30 insertions(+), 14 deletions(-)

-- 
2.30.2

