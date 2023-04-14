Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D41A36E245E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 15:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjDNNiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 09:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjDNNiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 09:38:10 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09CAB93D1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 06:38:08 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33EDVEAM030487;
        Fri, 14 Apr 2023 08:37:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=AAlFGQAOpcc0LwsD9Spsit9e4j2SMFa9NMT3Q4ZJ9oE=;
 b=VfxbVc4DptepOS+DmwhmH6eLOgzxXWcSKSLwA4GIzXmh+J41Axwtj6u47AgyoXXD+KtN
 vJqx8LPWlhMaQ3iSHemmFhfbNbiGVwCNlmjyXfCvlMGb1UtglHdkL82lVTSwHUQC+fel
 gUADJmRq0tHVPME11DwsHdxBVJdU2+C/MOkrY275YIKCuS+avt/j0ZIsEU93yhaE1V6D
 kuCX/atRGnyY56Zg7QGqkjZ9x+Vxqwjx9MuxvrZjIyv+LOOJHtFcVHoYlDHQNuDP6oSH
 EYKO6ApVxVEPOdeG6q669yVo3qeRbv7clR/JLf0VbEaIsE6TGJRe+B0+6VZVIaP3wzvt YA== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3pu5p3sexy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Apr 2023 08:37:56 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Fri, 14 Apr
 2023 08:37:54 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 14 Apr 2023 08:37:54 -0500
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.127])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id E682311D3;
        Fri, 14 Apr 2023 13:37:53 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 0/5] ASoC: cs35l56: Code improvements
Date:   Fri, 14 Apr 2023 14:37:48 +0100
Message-ID: <20230414133753.653139-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 3PhiBjqEB1ZEDelYIFJzJYCmBME5LQUt
X-Proofpoint-GUID: 3PhiBjqEB1ZEDelYIFJzJYCmBME5LQUt
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Various code improvements. These remove redundant code and
clean up less-than-optimal original implementations.

Simon Trimmer (5):
  ASoC: cs35l56: Rework IRQ allocation
  ASoC: cs35l56: Allow a wider range for reset pulse width
  ASoC: cs35l56: Wait for init_complete in cs35l56_component_probe()
  ASoC: cs35l56: Remove redundant dsp_ready_completion
  ASoC: cs35l56: Don't return a value from cs35l56_remove()

 sound/soc/codecs/cs35l56-i2c.c |  3 +-
 sound/soc/codecs/cs35l56-sdw.c |  4 +-
 sound/soc/codecs/cs35l56-spi.c |  3 +-
 sound/soc/codecs/cs35l56.c     | 83 +++++++++++++---------------------
 sound/soc/codecs/cs35l56.h     |  5 +-
 5 files changed, 38 insertions(+), 60 deletions(-)

-- 
2.30.2

