Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25E586BE835
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 12:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjCQLeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 07:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjCQLeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 07:34:12 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3665EA8EAA
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 04:33:36 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id qe8-20020a17090b4f8800b0023f07253a2cso4871852pjb.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 04:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112; t=1679052805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UBJ3jXvxXCld7rCbYIUA76P7q/tR6ahC8o8afEyFSeg=;
        b=SSqnByrqrr+3VcUDTYBw+VNwigK0LKtbr3MEmUWTApLPk2vh3j2tzaOsn1hq0KcVR6
         6aivcKsqqMiMH9mvfQuEqYm0O3UlMzJZljBHtbwxrnu6mnC1tGsnMLZbXPpgxD9p+Ffp
         nYOXAWx+D3hwVjMftozRbucnIv5txD2FWVxIdqrst32Fi0o9zO5GKthRuetbfB/fVbgo
         WBNH7cRghUYZPLtkP27Cl7zlIJ9zANuuY6QLfMq/5gAdWra9LpfVDIrVEMATdFii7LhJ
         U4BrqaJR9u41RGSTvx7+bF/VSMvwLLvXVgrLa2caxXfPMckKLRNMsZmAoOWbBPH8pAeW
         mvtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679052805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UBJ3jXvxXCld7rCbYIUA76P7q/tR6ahC8o8afEyFSeg=;
        b=t1dOx9O8+Ih0xoylHgvXQULVPhBe01CICr2vSAopnzYEt6A1g5xbC0aonH9O8+3Rb4
         P29wxlZnE+tLp70oxd37MvnRnzUSWdTymEity0UdsWy/H2dnDPCatKHL0y4S5YHB8ino
         GgtHyWOtaEoLOXvNA7i4TTAo4nuDAs/7BrfYi2qF/1j5Re3lTIDLW4tN/w6fu6dpgBYJ
         A9Et99sEPiPEAah8DU3PnlNyOxogX71LMCyQoefnq/5DpME3WFIufPxcSlEtrzb1QsVO
         LhEwpScinVIzQYygjJoENeIS9ejeHhXxGbla2mV3auY0ar/9xQgLiKgEGvcyNI6yhwJr
         k4MA==
X-Gm-Message-State: AO0yUKUe6j0pUbAtncE6NdwYIcO8UNTcCPwFH8NPZM4CWPdOvE7Hzaq9
        HwEJ/wkUFF8YTJMu+RxvaVdcdA==
X-Google-Smtp-Source: AK7set8mw4eu8SWp80RS17+P5NFx2EppFu4x7YobwRde2GI2yhM4sarU4Jk2ey0NmwtFezyvF659YQ==
X-Received: by 2002:a17:90b:1b07:b0:23f:5247:3334 with SMTP id nu7-20020a17090b1b0700b0023f52473334mr3353989pjb.19.1679052804978;
        Fri, 17 Mar 2023 04:33:24 -0700 (PDT)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id e3-20020a17090a818300b00233aacab89esm1182904pjn.48.2023.03.17.04.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 04:33:24 -0700 (PDT)
From:   Shunsuke Mie <mie@igel.co.jp>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shunsuke Mie <mie@igel.co.jp>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Frank Li <Frank.Li@nxp.com>, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [RFC PATCH 11/11] dmaengine: dw-edma: Fix to enable to issue dma request on DMA processing
Date:   Fri, 17 Mar 2023 20:32:38 +0900
Message-Id: <20230317113238.142970-12-mie@igel.co.jp>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230317113238.142970-1-mie@igel.co.jp>
References: <20230317113238.142970-1-mie@igel.co.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The issue_pending request is ignored while driver is processing a DMA
request. Fix to issue the pending requests on any dma channel status.

Fixes: e63d79d1ffcd ("dmaengine: Add Synopsys eDMA IP core driver")
Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
---
 drivers/dma/dw-edma/dw-edma-core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index c527af00ff4e..430f9ee0d9e8 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -308,9 +308,12 @@ static void dw_edma_device_issue_pending(struct dma_chan *dchan)
 	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
 	unsigned long flags;
 
+	if (!chan->configured)
+		return;
+
 	spin_lock_irqsave(&chan->vc.lock, flags);
-	if (chan->configured && chan->request == EDMA_REQ_NONE &&
-	    chan->status == EDMA_ST_IDLE && vchan_issue_pending(&chan->vc)) {
+	if (vchan_issue_pending(&chan->vc) && chan->request == EDMA_REQ_NONE &&
+	    chan->status == EDMA_ST_IDLE) {
 		chan->status = EDMA_ST_BUSY;
 		dw_edma_start_transfer(chan);
 	}
-- 
2.25.1

