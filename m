Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE8A6DDF91
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 17:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjDKPZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 11:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230412AbjDKPZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 11:25:39 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F4E44A3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 08:25:36 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33B5cuXF012801;
        Tue, 11 Apr 2023 10:25:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=IDUE8aPv5+jxNFKCCJKdWOof/bnjaMMvSIaTlA9bNcU=;
 b=oWNqFWyO+uHb5+jQtp/n51xZtSQ2V3Je/g3OXvXK0dMOTdOaCnDHXnQP7UKfV2T4tIsP
 nzY40WUDpoLJmqjXYE6BMHUEWYCtHgHVsgi7VqUyo/ib/nnwhfUuooVnuTgshoLI2NoF
 ptNwGulsTqjgUqmON11SP1eFWegZQId8QXS8knX1FB2wyCOgMW0l8Ff7WJI8wZqz103E
 wC4s1W4Sc6qeMeN9EgCw0vUiHtsutCarA9kRsue42CDDZTzxQLwMY5QdT7vev24DlsnD
 g5QgvmG1DjjmYj1OpqnkeSfhz+L0f7K8QjXAHeVasawOsmdxVCfQ5xvFFpk8m+XiIXZ5 oQ== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3pu4pq54a3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Apr 2023 10:25:29 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Tue, 11 Apr
 2023 10:25:28 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Tue, 11 Apr 2023 10:25:28 -0500
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.127])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 40C7445;
        Tue, 11 Apr 2023 15:25:28 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 0/6] ASoC: cs35l56: Add system suspend handling
Date:   Tue, 11 Apr 2023 16:25:22 +0100
Message-ID: <20230411152528.329803-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 2QEWHzQlQzCpdtrnPdzQNRGUS7cRrJee
X-Proofpoint-ORIG-GUID: 2QEWHzQlQzCpdtrnPdzQNRGUS7cRrJee
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set of patches adds handling for system suspend.
Patches 1..4 make some code changes that simplify the
suspend implementation, mainly to avoid race conditions.

There are two seperate aspects to suspend, and these have
been done as two patches:
- the main suspend-resume handling,
- re-loading the firmware if necessary after resume.

Richard Fitzgerald (6):
  ASoC: cs35l56: Remove quick-cancelling of dsp_work()
  ASoC: cs35l56: Use DAPM widget for firmware PLAY/PAUSE
  ASoC: cs35l56: Skip first init_completion wait in dsp_work if
    init_done
  ASoC: cs35l56: Always wait for firmware boot in runtime-resume
  ASoC: cs35l56: Add basic system suspend handling
  ASoC: cs35l56: Re-patch firmware after system suspend

 include/sound/cs35l56.h        |   4 +
 sound/soc/codecs/cs35l56-sdw.c |  36 ++++
 sound/soc/codecs/cs35l56.c     | 335 ++++++++++++++++++++++++++-------
 sound/soc/codecs/cs35l56.h     |   7 +-
 4 files changed, 308 insertions(+), 74 deletions(-)

-- 
2.30.2

