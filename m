Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BEAC7113C8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 20:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241155AbjEYSc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 14:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235668AbjEYScp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 14:32:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEEC519C;
        Thu, 25 May 2023 11:32:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E84364893;
        Thu, 25 May 2023 18:32:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B52FC433D2;
        Thu, 25 May 2023 18:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685039547;
        bh=TgTl3mDlQ6yoJSSu128ki5gVsp6gBpM9OvTuxcF6Iv8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ofZys6+L+lBn9KS9gk2zkf9TYO7ObFm3sOqQBsU5uVmRINW1HealMBoAkIaKc1Tfq
         MtSVvmqcqP+wtp0fOyGHRgfQXOSBLr24UZR0wf9NN/1SRC9gi2yWpAUr1Fl0UOXE+/
         MVX9lXxFQ8h7QCOqfpGIuG7cNUL4M/QNkgsyrEMhCrGvTZ+22r2jqdPqWgnUOmFBrz
         r7wLNFY9qqmaCwZg1rWSWH2VAQr9Dnun2frAaesNcus0kF3nYRr46UUfRwUpfM9gAX
         MDcCHNn+X8Z4ZoAks/KWXQ8RraRf1h3XXsn9Y1VPF9ML3NyQEZnMPxcEQV6Xd502KO
         wxyFCW9ukGv0A==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
        Sasha Levin <sashal@kernel.org>,
        pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com,
        peter.ujfalusi@linux.intel.com, yung-chuan.liao@linux.intel.com,
        ranjani.sridharan@linux.intel.com, daniel.baluta@nxp.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        AjitKumar.Pandey@amd.com, sound-open-firmware@alsa-project.org,
        alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 6.3 08/67] ASoC: SOF: amd: Fix NULL pointer crash in acp_sof_ipc_msg_data function
Date:   Thu, 25 May 2023 14:30:45 -0400
Message-Id: <20230525183144.1717540-8-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230525183144.1717540-1-sashal@kernel.org>
References: <20230525183144.1717540-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>

[ Upstream commit 051d71e073614a72ad423d6dacba37a7eeff274d ]

Check substream and runtime variables before assigning.

Signed-off-by: V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com
Link: https://lore.kernel.org/r/20230508070510.6100-1-Vsujithkumar.Reddy@amd.com
Signed-off-by: Mark Brown <broonie@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/amd/acp-ipc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/amd/acp-ipc.c b/sound/soc/sof/amd/acp-ipc.c
index 4e0c48a361599..749e856dc6011 100644
--- a/sound/soc/sof/amd/acp-ipc.c
+++ b/sound/soc/sof/amd/acp-ipc.c
@@ -209,7 +209,12 @@ int acp_sof_ipc_msg_data(struct snd_sof_dev *sdev, struct snd_sof_pcm_stream *sp
 		acp_mailbox_read(sdev, offset, p, sz);
 	} else {
 		struct snd_pcm_substream *substream = sps->substream;
-		struct acp_dsp_stream *stream = substream->runtime->private_data;
+		struct acp_dsp_stream *stream;
+
+		if (!substream || !substream->runtime)
+			return -ESTRPIPE;
+
+		stream = substream->runtime->private_data;
 
 		if (!stream)
 			return -ESTRPIPE;
-- 
2.39.2

