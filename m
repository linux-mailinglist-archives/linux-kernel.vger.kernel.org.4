Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54770675117
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 10:29:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbjATJ3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 04:29:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjATJ3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 04:29:31 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1413A5A81A;
        Fri, 20 Jan 2023 01:29:07 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id f19-20020a1c6a13000000b003db0ef4dedcso5378938wmc.4;
        Fri, 20 Jan 2023 01:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=csxV7SBcRMOtyGwXXr6VYNEIrNsBq0mzq7uR5oLy8sw=;
        b=VYpnC/cOlpiHsNoVzbSFm5Pp66EorTVLht/M0vNOywX6Jw6WZGYBYlLa4V+WQGI2TX
         3lhve4nIMd91sJcMEMKN+7W0JPNrdfo1qYfCUktVTqjJuopusR3wrPB2pA4/HLpIIrEw
         FmFzPYhL7p23K2XPFxqOL8mgkV6g9jASqSe1WYwSguYIOnyYjoLDbytDLibSkJ+E1ahV
         CKYRL7mJ+4OTnR9e8cCaq4r60zv0UvR/ShCGhiTxmUC0Z3L1xmLCcNi3RnZyNqIeADHN
         EKVQYhkbOVNCm8kSkDfb5KLFu7dlM3yW4mu3jrcZ2D/mFR/HqAtrVUPfw2kksem9BmjX
         rIoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=csxV7SBcRMOtyGwXXr6VYNEIrNsBq0mzq7uR5oLy8sw=;
        b=f/R6dFvWZyG/H+QceGuGAMwlIG62jplOfUQl0YEhyoV3+2SrhlsJG8WLYP2hp7a5rU
         1HsrFpEX/UyhnfTegqyLITgEiiwEjuR0puqon/Q7inw1/tUWLp4/jbNNcBRweeOz2yjg
         mzU2DdDYBuDAWqdBiHNQf7X9MSfOHtSPBIkAnuh4BOwvn6NWn6v1C6r/yN7ZhOaMC0b+
         kEx294JmmdthYF/1oC+G6mp1DrxBnR5ptwNX/czX3aTsDKUq0VhK8sfkj57kZeBh1aBe
         ObYlsjN1iDHuxGJ1m8llVQ9ONibacoDUPYB1sCemLB7cML6Tl2j2Rn2H5T0I3TI4QRku
         bM9g==
X-Gm-Message-State: AFqh2kq2k9ccjvluUGLfETVEWWiEjVqkEk/i/KEUnW5Q9yzlpQvzeijE
        BngyoM5bteh91DJbvgmxMUgWaXZIBX+KyOyE
X-Google-Smtp-Source: AMrXdXtAnv1VnjoW886QL9Vu3rdysDqbLp9waCd/Qgh+W86DERrCHcfZk/wkz5cU7w1CwOKs5L0/Vw==
X-Received: by 2002:a05:600c:54eb:b0:3da:2090:d404 with SMTP id jb11-20020a05600c54eb00b003da2090d404mr13381883wmb.18.1674206923943;
        Fri, 20 Jan 2023 01:28:43 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id d19-20020a05600c34d300b003a6125562e1sm1675318wmq.46.2023.01.20.01.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 01:28:43 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] accel/ivpu: Fix spelling mistake "tansition" -> "transition"
Date:   Fri, 20 Jan 2023 09:28:42 +0000
Message-Id: <20230120092842.79238-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are spelling mistakes in two ivpu_err error messages. Fix them.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/accel/ivpu/ivpu_hw_mtl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/ivpu/ivpu_hw_mtl.c b/drivers/accel/ivpu/ivpu_hw_mtl.c
index b59b1f472b40..62bfaa9081c4 100644
--- a/drivers/accel/ivpu/ivpu_hw_mtl.c
+++ b/drivers/accel/ivpu/ivpu_hw_mtl.c
@@ -608,7 +608,7 @@ static int ivpu_boot_d0i3_drive(struct ivpu_device *vdev, bool enable)
 
 	ret = REGB_POLL_FLD(MTL_BUTTRESS_VPU_D0I3_CONTROL, INPROGRESS, 0, TIMEOUT_US);
 	if (ret) {
-		ivpu_err(vdev, "Failed to sync before D0i3 tansition: %d\n", ret);
+		ivpu_err(vdev, "Failed to sync before D0i3 transition: %d\n", ret);
 		return ret;
 	}
 
@@ -621,7 +621,7 @@ static int ivpu_boot_d0i3_drive(struct ivpu_device *vdev, bool enable)
 
 	ret = REGB_POLL_FLD(MTL_BUTTRESS_VPU_D0I3_CONTROL, INPROGRESS, 0, TIMEOUT_US);
 	if (ret)
-		ivpu_err(vdev, "Failed to sync after D0i3 tansition: %d\n", ret);
+		ivpu_err(vdev, "Failed to sync after D0i3 transition: %d\n", ret);
 
 	return ret;
 }
-- 
2.30.2

