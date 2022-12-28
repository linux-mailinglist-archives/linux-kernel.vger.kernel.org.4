Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E58D6580B8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 17:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234661AbiL1QTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 11:19:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234439AbiL1QSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 11:18:43 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE2619C0C
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 08:17:23 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id o1-20020a17090a678100b00219cf69e5f0so20455600pjj.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 08:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cTBEJ8Yt1F+qFY4dSzBFOLsJDCyD/sILn8NSazfFNCk=;
        b=dj/Ub+3kYN0/agt2gS0Famnp0N3dkHl3+FQoEtgK8tVZZmkz0cvmZhpxMoXa1eohso
         W/q7ffJ3CL2rdK75bB9J1pelQS2Gl7fVyTt/u6b0c2MzkYmsDpSLTJ+n5S/PkQMVpxpg
         W3tx3uGeOsiW3kipxMk+3R6nTT0sfKA0ROiAjB2bdYkF6U4xG1RWl8CKDDbnBLmgQu/n
         ACSEHvnEFfsHMdlRyJjvYR5Q2ywytVYCohuJfc9xu46q4Lyb2vvy+gNZ4T48sjPzEgg/
         ayNGNThqpMWVae/tFgumbIJFspGofWHAyjI7Q3rCIajcGJPV2nFAxsQnkr1zhMyVlz8H
         8Gyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cTBEJ8Yt1F+qFY4dSzBFOLsJDCyD/sILn8NSazfFNCk=;
        b=BQY+RNsVhWZ1XTW/ynN+Yl1/upJi1NKbJyo3Zsb877a2FoddJW9ZKOWPTQwcRTI6b0
         xl7DiiR3AewZ17j86VSbWnaHOpfpUMv1c/2G1STvSfF7GKd8VNr/vKbwlcjd/9ZkoBum
         6K+IDFYxnpYvAZ3vAeT6sRwKBPnYuF2gm+fT8NXspif5XG3I+Ds7svkPztp8cfPMztpH
         KFVYbFEdMqlgQgxigG3UGEFVNaOz0yOKfiLDH5siKfgkx9S22LRflRPl93j5E79nOb8g
         y63u/+QWp+Yl+whXfMz1GFJGQJspjRCrkPPy1ctF4nEEChes+nyiDAXoIriPwokHFECu
         Nd6g==
X-Gm-Message-State: AFqh2kqb0mk7ty63r4CbjHstYhqxkQEqNWDsmoMDbbrLMnJFKDBjwcrc
        PHIdC1gYRIbiiclmB5Wp0ZeW
X-Google-Smtp-Source: AMrXdXur43RoXjvFIHa8mRXlYHujGDsIAt+jiccMI+o4799ciQu1Uvcdm1daRBtNgm7mnMYbOUdXaw==
X-Received: by 2002:a17:902:cecf:b0:191:191f:e7a7 with SMTP id d15-20020a170902cecf00b00191191fe7a7mr36963609plg.69.1672244242997;
        Wed, 28 Dec 2022 08:17:22 -0800 (PST)
Received: from localhost.localdomain ([117.217.178.100])
        by smtp.gmail.com with ESMTPSA id s3-20020a170902c64300b00186abb95bfdsm11256798pls.25.2022.12.28.08.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 08:17:21 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mhi@lists.linux.dev
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 2/6] bus: mhi: ep: Check if the channel is supported by the controller
Date:   Wed, 28 Dec 2022 21:47:00 +0530
Message-Id: <20221228161704.255268-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221228161704.255268-1-manivannan.sadhasivam@linaro.org>
References: <20221228161704.255268-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before processing the command ring for the channel, check if the channel is
supported by the controller or not.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/ep/main.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
index 55209d42a995..8b065a3cc848 100644
--- a/drivers/bus/mhi/ep/main.c
+++ b/drivers/bus/mhi/ep/main.c
@@ -123,6 +123,13 @@ static int mhi_ep_process_cmd_ring(struct mhi_ep_ring *ring, struct mhi_ring_ele
 	int ret;
 
 	ch_id = MHI_TRE_GET_CMD_CHID(el);
+
+	/* Check if the channel is supported by the controller */
+	if ((ch_id > mhi_cntrl->max_chan) || !mhi_cntrl->mhi_chan[ch_id].name) {
+		dev_err(dev, "Channel (%u) not supported!\n", ch_id);
+		return -ENODEV;
+	}
+
 	mhi_chan = &mhi_cntrl->mhi_chan[ch_id];
 	ch_ring = &mhi_cntrl->mhi_chan[ch_id].ring;
 
-- 
2.25.1

