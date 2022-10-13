Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3E005FE14B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 20:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbiJMScw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 14:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbiJMScd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 14:32:33 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F73B15CB1B
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 11:28:29 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id e18so3809568edj.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 11:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t5o4hmrTo+a4A6KCBunzs3GYyFuyFvq3xuPa8kZR43M=;
        b=DU//SwH+JfMDyVMKNcHeLU136bnf9QlAcBT+KWFVH1q8TwC873dRzVkVcKr2u+9nNy
         s4WnYSjekVglH1Dqi8Q5bz1KKUstGlkGyZICaJIhtnSxPx9i4eWPCG4iyWXTFMOu80Yj
         JuXKwqbN5s/MaQedvEbm5oL0MF5SwXqsOSAYwgO+wM1nu4MxZk5JEX47YxnmZKq5HFWM
         iOQKeimAZfXCEBU0wVC/OmlYE4XV5R7pbnkFQFzZelR3uIldMiOvA3dP4qKmlcR5MWv6
         vPAd8nW9lYSA7dr6TxoqTJEsvKy18NpG7B3jvYfTGmiaad+Tq72HVbY90tsQmCyC0nEC
         p6rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t5o4hmrTo+a4A6KCBunzs3GYyFuyFvq3xuPa8kZR43M=;
        b=D1j1edG2qYJ5CLD6eqWP9SrcQpxDuZSgxfRUZ+w5QS4LO9yIowkCMi37MJ9ERzysTG
         V7GxA8jmOR7/CoGZHXfPUEnnn46nZxFMK22T4zd4tTWu9oPDI0AGHiUeRkG3tgr6pbAB
         yQB/zv5EqG0SNuO97XQ+VYkoyj52FcWgUxbNzQIDSE3U7cK+q+Cv8MXFUUKa5pEQx5sK
         PWWYMGMD8SanTO4Ofss/UwOSLrtQ1r898QcfhUIfHnXtmbCNUPpxkZfs22qJe1lqxU3f
         MeRSUG7sMQ7i4os5KNhR3gVkwsbRj8onxtZFAUghri38NJhcMJ4D98vO7gfMTQLUBKHd
         vMrw==
X-Gm-Message-State: ACrzQf0hsn1AY8LRoLj+Fllk/3MXOmKJ8P2B1SMI5Keia+6Ccwh8vNeT
        p54Zm5/SF343AXRbhSEKWSA1uIAkzOOQLkiW
X-Google-Smtp-Source: AMsMyM779LnzMOJRUaV+d5Mya+59vT9EDrXNtlqV4dqAf2i/G2SCcwlVYTXuJQeHdR3GU8JloRYY6Q==
X-Received: by 2002:a05:6402:350d:b0:45c:f5a2:348e with SMTP id b13-20020a056402350d00b0045cf5a2348emr895071edd.398.1665684768460;
        Thu, 13 Oct 2022 11:12:48 -0700 (PDT)
Received: from kista.localdomain (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id ku15-20020a170907788f00b0078b551d2fa3sm211109ejc.103.2022.10.13.11.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 11:12:47 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     maxime@cerno.tech, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, wens@csie.org, samuel@sholland.org
Cc:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 3/5] iommu/sun50i: Fix R/W permission check
Date:   Thu, 13 Oct 2022 20:12:18 +0200
Message-Id: <20221013181221.3247429-4-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221013181221.3247429-1-jernej.skrabec@gmail.com>
References: <20221013181221.3247429-1-jernej.skrabec@gmail.com>
MIME-Version: 1.0
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

Because driver has enum type permissions and iommu subsystem has bitmap
type, we have to be careful how check for combined read and write
permissions is done. In such case, we have to mask both permissions and
check that both are set at the same time.

Current code just masks both flags but doesn't check that both are set.
In short, it always sets R/W permission, regardles if requested
permissions were RO, WO or RW. Fix that.

Fixes: 4100b8c229b3 ("iommu: Add Allwinner H6 IOMMU driver")
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/iommu/sun50i-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
index 38d1069cf383..135df6934a9e 100644
--- a/drivers/iommu/sun50i-iommu.c
+++ b/drivers/iommu/sun50i-iommu.c
@@ -271,7 +271,7 @@ static u32 sun50i_mk_pte(phys_addr_t page, int prot)
 	enum sun50i_iommu_aci aci;
 	u32 flags = 0;
 
-	if (prot & (IOMMU_READ | IOMMU_WRITE))
+	if ((prot & (IOMMU_READ | IOMMU_WRITE)) == (IOMMU_READ | IOMMU_WRITE))
 		aci = SUN50I_IOMMU_ACI_RD_WR;
 	else if (prot & IOMMU_READ)
 		aci = SUN50I_IOMMU_ACI_RD;
-- 
2.38.0

