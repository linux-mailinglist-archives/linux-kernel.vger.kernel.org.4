Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0465B704775
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 10:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbjEPIL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 04:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbjEPILY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 04:11:24 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95AE540C1
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 01:11:23 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R561e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0VinPRLs_1684224678;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VinPRLs_1684224678)
          by smtp.aliyun-inc.com;
          Tue, 16 May 2023 16:11:19 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     perex@perex.cz
Cc:     tiwai@suse.com, pierre-louis.bossart@linux.intel.com,
        lgirdwood@gmail.com, peter.ujfalusi@linux.intel.com,
        yung-chuan.liao@linux.intel.com, ranjani.sridharan@linux.intel.com,
        daniel.baluta@nxp.com, kai.vehmanen@linux.intel.com,
        broonie@kernel.org, sound-open-firmware@alsa-project.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] ASoC: SOF: ipc4-topology: Fix an unsigned comparison which can never be negative
Date:   Tue, 16 May 2023 16:11:16 +0800
Message-Id: <20230516081116.71370-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        URIBL_BLOCKED,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return value from the call to sof_ipc4_get_valid_bits() is int.
However, the return value is being assigned to an unsigned
int variable 'out_ref_valid_bits', so making it an int.

Eliminate the following warning:
./sound/soc/sof/ipc4-topology.c:1537:6-24: WARNING: Unsigned expression compared with zero: out_ref_valid_bits < 0

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=4985
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 sound/soc/sof/ipc4-topology.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/ipc4-topology.c b/sound/soc/sof/ipc4-topology.c
index dce2f8f7f518..d82ac5701eb2 100644
--- a/sound/soc/sof/ipc4-topology.c
+++ b/sound/soc/sof/ipc4-topology.c
@@ -1381,8 +1381,8 @@ sof_ipc4_prepare_copier_module(struct snd_sof_widget *swidget,
 	void **ipc_config_data;
 	int *ipc_config_size;
 	u32 **data;
-	int ipc_size, ret;
-	u32 out_ref_rate, out_ref_channels, out_ref_valid_bits;
+	int ipc_size, ret, out_ref_valid_bits;
+	u32 out_ref_rate, out_ref_channels;
 	u32 deep_buffer_dma_ms = 0;
 	int output_fmt_index;
 
-- 
2.20.1.7.g153144c

