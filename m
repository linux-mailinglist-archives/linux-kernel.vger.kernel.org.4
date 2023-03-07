Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22CA86AE21E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 15:22:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjCGOWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 09:22:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbjCGOWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 09:22:17 -0500
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95E58E3CA;
        Tue,  7 Mar 2023 06:17:44 -0800 (PST)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 6D13110000C;
        Tue,  7 Mar 2023 14:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1678198546;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tebCh8O5AMYYSpkVrb+eHWhJxKEZvKSu3HtDndY/Qyc=;
        b=LJYUoewXDQBs6tICfbNh9lgrLeF62H5WYhjteP5kSPSvsvKne24IBbid3CAfdmgWLAz+AL
        4lKh9D2sJnyyVrtpxqyrg1/iyySC0EDpC84+GOgqfiOQpPl4Z6KcFYIGZSZODJEtVJ5xm6
        /K1SwrCfns/bfGN0zg42AOThla9oZuqtHa0D9Drl/zEgYmAzkI4Sem6xgJte77NHt4Ylgu
        5yb9Im7yOIY4wga+tj1QI1KS3RP8p1KZ8tyW4piC3OoSSTE5zZqBw4sBiww3Q4tHfPBuUi
        7a3r4umW1aiqDPRFzDnqL2xlWE+bCwsAXgwMI+1H6e9jVD0Cnrn7SRth3+Bhxg==
From:   Herve Codina <herve.codina@bootlin.com>
To:     Herve Codina <herve.codina@bootlin.com>,
        Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Qiang Zhao <qiang.zhao@nxp.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH 3/3] soc: fsl: cpm1: qmc: Fix assigned timeslot masks
Date:   Tue,  7 Mar 2023 15:15:03 +0100
Message-Id: <20230307141503.159766-4-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307141503.159766-1-herve.codina@bootlin.com>
References: <20230307141503.159766-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The assigned timeslot masks are 64bit values.
In case of 64 timeslots the code uses (1 << 64) which is undefined on a
64bit value. On the PowerPC architecture, this lead to an incorrect
result as (1 << 64) produces the same result as (1 << 0).

Fix the masks values taking care of the 64 timeslots case.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/soc/fsl/qe/qmc.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/fsl/qe/qmc.c b/drivers/soc/fsl/qe/qmc.c
index cfa7207353e0..b3c292c9a14e 100644
--- a/drivers/soc/fsl/qe/qmc.c
+++ b/drivers/soc/fsl/qe/qmc.c
@@ -754,6 +754,11 @@ static int qmc_check_chans(struct qmc *qmc)
 	if (ret)
 		return ret;
 
+	if ((info.nb_tx_ts > 64) || (info.nb_rx_ts > 64)) {
+		dev_err(qmc->dev, "Number of TSA Tx/Rx TS assigned not supported\n");
+		return -EINVAL;
+	}
+
 	/*
 	 * If more than 32 TS are assigned to this serial, one common table is
 	 * used for Tx and Rx and so masks must be equal for all channels.
@@ -766,9 +771,8 @@ static int qmc_check_chans(struct qmc *qmc)
 		is_one_table = true;
 	}
 
-
-	tx_ts_assigned_mask = (((u64)1) << info.nb_tx_ts) - 1;
-	rx_ts_assigned_mask = (((u64)1) << info.nb_rx_ts) - 1;
+	tx_ts_assigned_mask = info.nb_tx_ts == 64 ? U64_MAX : (((u64)1) << info.nb_tx_ts) - 1;
+	rx_ts_assigned_mask = info.nb_rx_ts == 64 ? U64_MAX : (((u64)1) << info.nb_rx_ts) - 1;
 
 	list_for_each_entry(chan, &qmc->chan_head, list) {
 		if (chan->tx_ts_mask > tx_ts_assigned_mask) {
-- 
2.39.2

