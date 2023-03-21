Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5EE6C31AC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 13:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbjCUM00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 08:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbjCUM0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 08:26:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F8311150
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 05:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679401509;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=DvleXWzKo7owjdbsJ/ezqbFS/5grOQZp7Yc6+zUXHrg=;
        b=KGlBCa8OPgPzMHttZyOgfjt3mVZE7IjmQbGQjzA/R+ad3aqyeHd8P/cOjSN/vdT9UYrnHn
        BmpVQESFBV8Iaas9g7rur9/eH68zFdX2lpnVMjecXFkPAU+4BdjrGBqgFbV92BsQFy3rAs
        ImTWsacUtdY7oCBwWH6a9gzXNJWoK4E=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-Cg4aVCmXMQ2EbOY7l-Lk3g-1; Tue, 21 Mar 2023 08:25:08 -0400
X-MC-Unique: Cg4aVCmXMQ2EbOY7l-Lk3g-1
Received: by mail-qv1-f71.google.com with SMTP id g14-20020ad457ae000000b005aab630eb8eso7546783qvx.13
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 05:25:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679401508;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DvleXWzKo7owjdbsJ/ezqbFS/5grOQZp7Yc6+zUXHrg=;
        b=42+0AjQF1EWbG17e1wcxEiiTI8Sv1q6PhuPNJo4gTtrJzsXreE54XrMio+vo/UOi7T
         YiljGoF1aPa2cNHsi2aNp+MwQBk6JDV8tCtwJDJ6Fy3BxKAvygoXgJOcY2uRyc2XWq4b
         j86IvYPVxR9ivCN7iBeaMjKZZwIzy6oGKacUuvgNlCJ2HrZzXUFPiNdczUMH7i8xnB2r
         PDVDtpZ+AtnP8mEkFUFtcRfoNXcl0f0RJLM8imYrP7usckNOBLB0LJOk+5yMy9RyPBCo
         WIKPRXUrAIwQbtyXMgmSTB3GTIVf+S6f3TPpsTwOfS3V9n3eLrsubklfAxVHk/1rAtw3
         Kkww==
X-Gm-Message-State: AO0yUKUfPVOVRNQSOaMf4LLjpM2cRZuh3vq2YlFlyuAEil3msE4Wnq+J
        MpwF5DWAXeMaxtA+u1ZMKeYB4g9XZIGCd5ajp0mhZGoJLMZcBRra9TLTfsAwa8ZMM06/wsw55ok
        aktJtupEDkwjEV0+hT0y+j68a
X-Received: by 2002:ad4:5bc8:0:b0:5ad:45f2:4307 with SMTP id t8-20020ad45bc8000000b005ad45f24307mr4916131qvt.11.1679401507832;
        Tue, 21 Mar 2023 05:25:07 -0700 (PDT)
X-Google-Smtp-Source: AK7set8EmpoZ3TdzqMTm7C9Sgu5MCLSpoN63jx/YwhAb0d2bZ8QbqQ6cud+66aHksMRuFeiqkzW2AA==
X-Received: by 2002:ad4:5bc8:0:b0:5ad:45f2:4307 with SMTP id t8-20020ad45bc8000000b005ad45f24307mr4916111qvt.11.1679401507571;
        Tue, 21 Mar 2023 05:25:07 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id d185-20020a37b4c2000000b007425ef4cbc2sm9192747qkf.100.2023.03.21.05.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 05:25:07 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     vkoul@kernel.org, kishon@kernel.org, heiko@sntech.de,
        nathan@kernel.org, ndesaulniers@google.com
Cc:     linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH] phy: rockchip-pcie: remove unused phy_rd_cfg function
Date:   Tue, 21 Mar 2023 08:25:03 -0400
Message-Id: <20230321122503.1783311-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang with W=1 reports
drivers/phy/rockchip/phy-rockchip-pcie.c:122:19: error:
  unused function 'phy_rd_cfg' [-Werror,-Wunused-function]
static inline u32 phy_rd_cfg(struct rockchip_pcie_phy *rk_phy,
                  ^
This function is not used, so remove it.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/phy/rockchip/phy-rockchip-pcie.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-pcie.c b/drivers/phy/rockchip/phy-rockchip-pcie.c
index 75216091d901..8234b83fdd88 100644
--- a/drivers/phy/rockchip/phy-rockchip-pcie.c
+++ b/drivers/phy/rockchip/phy-rockchip-pcie.c
@@ -119,21 +119,6 @@ static inline void phy_wr_cfg(struct rockchip_pcie_phy *rk_phy,
 				   PHY_CFG_WR_SHIFT));
 }
 
-static inline u32 phy_rd_cfg(struct rockchip_pcie_phy *rk_phy,
-			     u32 addr)
-{
-	u32 val;
-
-	regmap_write(rk_phy->reg_base, rk_phy->phy_data->pcie_conf,
-		     HIWORD_UPDATE(addr,
-				   PHY_CFG_RD_MASK,
-				   PHY_CFG_ADDR_SHIFT));
-	regmap_read(rk_phy->reg_base,
-		    rk_phy->phy_data->pcie_status,
-		    &val);
-	return val;
-}
-
 static int rockchip_pcie_phy_power_off(struct phy *phy)
 {
 	struct phy_pcie_instance *inst = phy_get_drvdata(phy);
-- 
2.27.0

