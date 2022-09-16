Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1199B5BA7A3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 09:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbiIPH52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 03:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbiIPH5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 03:57:25 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC006AA1A
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 00:57:24 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id y11so3336957pjv.4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 00:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=YuvBuqEBRJCl7zorVVAVVlmcoiWTc8c8OVPLn4Ys5UE=;
        b=P6dmFhRycQyiwrMOwJkNsZ/BBg8kqPR9AYtgGpqG0fCqzoY37IK1RLuYdcNjzUZ1mS
         maZaszqH8MsEkW3jg90SoSs73SkpUEg+y3d4NSnzq7lQCueWN2urDuMwAVA7bGzWLhYT
         PqzvuNNlUFQ+SDGFk1PcrLvcMeaBug8oOl71yI4aU/VWrW1dQ3CvRFWYz4E759KusM4H
         WMwJO2pJg7ZvEnclA/1addscjrgWNb1Vllmh5/yzQ8XnhG99etnim1ZPgJEHNSgu5dQt
         rzke/AU2JFdSkBOLUm2YBUtky6Ipj44Iv/QhlikY0SDtDwUosMBbhndm0lJl2T26sx4s
         54Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=YuvBuqEBRJCl7zorVVAVVlmcoiWTc8c8OVPLn4Ys5UE=;
        b=C5CwCS1mqu0IssSr3ckIyWWQ/5OZxTfmPWf5kI8XgyxXJBi6BL0qRDzdF/1Jha0s7r
         1jL+ZrSqp9Kg4b2IbiH01/Xhh4nHsJPXZJhJaAe9TDiP/1Swe4AP/2NQpKLDHpIhFB9w
         KN6gea3l/rOkGsVs5vMvonddTcE3ruw0v5WRGt669ovx7evSiUYuM9FyjiuRIYhr+/+4
         WErEAI+hez9PFxxmEyeKCDKaSDa1i1y5c3BK9cxQpRvXDIJPMiDn9P6yW9WASz8wG5f5
         DEaa6eI1z9uxH1lSxvKGFe1tPS6ctm34qDiCE1V2x8WKwreNRO5a47l8QE/OwUpMY9wi
         gBEQ==
X-Gm-Message-State: ACrzQf0dw/v6ceuR8z1hWIzx7igzR3pHZ7ZeOfh18MutKzP/1Aj8U0aA
        wdAWr3+SloGKO07b9OT7NrheIw==
X-Google-Smtp-Source: AMsMyM6luTj24P0sD683SpaOotadfC+IV3ZQEMuBb4fBCtTB5Ow6HhSJK2rfhpdTg/TKXxasRvWXFA==
X-Received: by 2002:a17:902:f612:b0:172:cbb0:9b4f with SMTP id n18-20020a170902f61200b00172cbb09b4fmr3449108plg.142.1663315043503;
        Fri, 16 Sep 2022 00:57:23 -0700 (PDT)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id y28-20020aa79e1c000000b00543236e83e6sm11319867pfq.22.2022.09.16.00.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 00:57:22 -0700 (PDT)
From:   Shunsuke Mie <mie@igel.co.jp>
To:     Jon Mason <jdmason@kudzu.us>
Cc:     Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, ntb@lists.linux.dev,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shunsuke Mie <mie@igel.co.jp>
Subject: [PATCH] PCI: endpoint: pci-epf-{,v}ntb: fix a check for no epc alignment constraint
Date:   Fri, 16 Sep 2022 16:56:51 +0900
Message-Id: <20220916075651.64957-1-mie@igel.co.jp>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some pci endpoint controllers has not alignment constraint, and the
epc_features->align becomes 0. In this case, IS_ALIGNED() in
epf_ntb_config_spad_bar_alloc() doesn't work well. So this patch adds the 0
checking before the IS_ALIGNED().

Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
---
 drivers/pci/endpoint/functions/pci-epf-ntb.c  | 2 +-
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-ntb.c b/drivers/pci/endpoint/functions/pci-epf-ntb.c
index 9a00448c7e61..f74155ee8d72 100644
--- a/drivers/pci/endpoint/functions/pci-epf-ntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-ntb.c
@@ -1021,7 +1021,7 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb,
 	peer_size = peer_epc_features->bar_fixed_size[peer_barno];
 
 	/* Check if epc_features is populated incorrectly */
-	if ((!IS_ALIGNED(size, align)))
+	if (align && (!IS_ALIGNED(size, align)))
 		return -EINVAL;
 
 	spad_count = ntb->spad_count;
diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 0ea85e1d292e..5e346c0a0f05 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -418,7 +418,7 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
 	size = epc_features->bar_fixed_size[barno];
 	align = epc_features->align;
 
-	if ((!IS_ALIGNED(size, align)))
+	if (align && !IS_ALIGNED(size, align))
 		return -EINVAL;
 
 	spad_count = ntb->spad_count;
-- 
2.17.1

