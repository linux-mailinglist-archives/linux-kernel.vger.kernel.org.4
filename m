Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 791AA5E5E79
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 11:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbiIVJYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 05:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbiIVJYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 05:24:07 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 569765F9A8
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 02:24:05 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id j6-20020a17090a694600b00200bba67dadso1504968pjm.5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 02:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=9Z9yPSyc6+khx5jUdo6dOi29lzFmWOZWB0sb02RmgsQ=;
        b=kj6pJGO5Y/moxtWM7HndQV5eZSroGtOIl8X840LQrtBjfUpyrlIqIo3O9pYNAV+C50
         CRbItabzk9BTHzgj0RyXZ4TzjRNLwMaEHyx4v149IpN8wZeQSthIMFXVOX/OHD/li26Q
         zq19vpPl/AInUNH5anlKn2iXacx2hhIneCFkXWQD5cVnE12G0ZOGQ/si6ulY4NtFsT66
         ApBliiQZcu5B0CMjyLNFILuyF903JrB8eyVTpqQ0nseedSRh4gC1Xu9NxxZ+NGn9vvNW
         flW4rw9gF4d3DMYqp4Zw6+9kC9BkcWQEeXDg3WBHAgZUHAZAw196XGRgv075hThCggi+
         s+mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=9Z9yPSyc6+khx5jUdo6dOi29lzFmWOZWB0sb02RmgsQ=;
        b=h0HFEH0RTgY+lAO5gNIeS/iyA7gMhN1xLXngbjcL2rRIJezOio9lqGVycUoPzZY88Q
         oWF8RXY74zteTrlGfxbIFacOv8/n7DdUEGjZgqMK/yeBYXiBgp+o3Fc68eCj0IOisxe7
         xLMmUSdWsWELhVHNLhs/fcbMufay6/HNFxxPIuaRMJ2h40TXLDy8yQPOvaa2Zccq1pXz
         ycL3IkzrNr0jRnmCmSX4JiLx1cylj8e0i3WFDPY5ClhZTsgcCN6B9+uUlPoXGPJxr1oT
         zdkBDY9hBkebKPGPfykOCEWd+KoWpQbRrYxzLRAiatJS5fTUoxH7t9w+1Wz7skW6lFY7
         sCew==
X-Gm-Message-State: ACrzQf1LQD+s6k1GLtMSaU1vaSsbPn+BJ2Eq826uiIdSiCih3cC5IzSP
        10CsvH++j2xCn4GvpGzDqqt0Hlc5w1eVTwjp
X-Google-Smtp-Source: AMsMyM63x/ngMQSxKqooTncWKscwUzeMa9LoEy7hBxh6sONYbvEL/JdwiA2ruZ5pW1eceE0HPc8Dgg==
X-Received: by 2002:a17:903:4112:b0:178:29d8:6d56 with SMTP id r18-20020a170903411200b0017829d86d56mr2478509pld.143.1663838644615;
        Thu, 22 Sep 2022 02:24:04 -0700 (PDT)
Received: from tyrell.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id f135-20020a62388d000000b00555ba949f96sm28190pfa.157.2022.09.22.02.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 02:24:03 -0700 (PDT)
From:   Shunsuke Mie <mie@igel.co.jp>
To:     Jon Mason <jdmason@kudzu.us>
Cc:     Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, ntb@lists.linux.dev,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shunsuke Mie <mie@igel.co.jp>
Subject: [PATCH v2] PCI: endpoint: pci-epf-{,v}ntb: fix a check for no epc alignment constraint
Date:   Thu, 22 Sep 2022 18:23:57 +0900
Message-Id: <20220922092357.123732-1-mie@igel.co.jp>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some PCI endpoint controllers have no alignment constraints, and the
epc_features->align becomes 0. In this case, IS_ALIGNED() in
epf_ntb_config_spad_bar_alloc() doesn't work well. Check for this before
IS_ALIGNED().

Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
---
Changes in v2:
* Fix the commit message in phrasings and words.
---
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

