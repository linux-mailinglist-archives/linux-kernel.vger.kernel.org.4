Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4AC6659D6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 12:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbjAKLQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 06:16:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233224AbjAKLPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 06:15:01 -0500
Received: from egress-ip33b.ess.de.barracuda.com (egress-ip33b.ess.de.barracuda.com [18.185.115.237])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8A16473
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 03:14:20 -0800 (PST)
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200]) by mx-outbound19-234.eu-central-1b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 11 Jan 2023 11:14:16 +0000
Received: by mail-pl1-f200.google.com with SMTP id a12-20020a170902eccc00b001927f1d6316so10416782plh.10
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 03:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mistralsolutions.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dg9LU0FiMyIDhs6KiWnxKST9zbz7gE2q7SHQqi7NsEY=;
        b=VShgQztP93823PClYtfvAhq2ipbX/4QI2D6HNTMAD7Ix+DSohKhFmg5w/lzuaH21os
         3xY58WaW28nqptNBgZEz9JvO9SKRYalFt16Wnfo9oxzHOR6fhABFslXqohwzw6sr/Ybm
         5Bp2UJRhdKmk+kzfNroAqZKchMypKOIbgkcgI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dg9LU0FiMyIDhs6KiWnxKST9zbz7gE2q7SHQqi7NsEY=;
        b=KjXuFi/sucqcgvtDgjHdgrPsbPebNAdKJ8Fr5kXzXTTOjgaFIVRe2Tg5hlNFw3yhRW
         BMogNgRUFCqkVgBDf6H1D1keIPFTADdYfOVCBuQABrVVI9RWr2QGswsIaDQ8vf3/o3mJ
         nPFxf1VYKGLbl8HKAbH9X7JcDBmgY138+lDY2+liigrA5TSbLoq/49e2SNnX9M+wwmGT
         SrF5o6C99Uh44JoEIAuszBGQ7Rw1Cn4yi6yJgCEpAxkerJAxbnHCtujB5J9VdDOWqk2W
         fO4ItNxQvFJGrCL4fixWm/5mfJtON3twrVK60Zo6dsd9i/v7X8QdvPMjz8cD4BI1POYw
         Hv0w==
X-Gm-Message-State: AFqh2kqT2xqQjTmh8jGFcMGlgylXFLWUT6SVyDVUCmeuA6BObR0gdxYl
        vkbH26CrhljDcCgz16Bccr8WjwlxZfvgZVK8HUfGj49T9uPgKezV+GAc60JHE/IWPJZ8fKx5zPS
        fQK16DtRi0OkHupA7WVruTT+2FVYZJNk/suMvKwtJptb/xjP0HIUWGoHMup6C
X-Received: by 2002:aa7:9156:0:b0:57e:f1a2:1981 with SMTP id 22-20020aa79156000000b0057ef1a21981mr76802713pfi.8.1673435655802;
        Wed, 11 Jan 2023 03:14:15 -0800 (PST)
X-Google-Smtp-Source: AMrXdXseZyUahNHhXIMnc/enn8Pfug8hpLtKh5Vm9jFmoUEBDpWUHdDyZBaDCtfp/cUlHbej9hQCIQ==
X-Received: by 2002:aa7:9156:0:b0:57e:f1a2:1981 with SMTP id 22-20020aa79156000000b0057ef1a21981mr76802701pfi.8.1673435655484;
        Wed, 11 Jan 2023 03:14:15 -0800 (PST)
Received: from LAP568U.mistral.in ([106.51.227.150])
        by smtp.gmail.com with ESMTPSA id d206-20020a621dd7000000b00589ed7ae132sm4235666pfd.13.2023.01.11.03.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 03:14:14 -0800 (PST)
From:   Sinthu Raja <sinthu.raja@mistralsolutions.com>
X-Google-Original-From: Sinthu Raja <sinthu.raja@ti.com>
To:     Roger Quadros <rogerq@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Ravi Gunasekaran <r-gunasekaran@ti.com>,
        Siddharth Vadapalli <s-vadapalli@ti.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sinthu Raja <sinthu.raja@ti.com>
Subject: [PATCH V3 0/2] phy: ti: j721e-wiz: Add support to manage type-C swap on Lane2 and lane3
Date:   Wed, 11 Jan 2023 16:43:54 +0530
Message-Id: <20230111111356.17392-1-sinthu.raja@ti.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BESS-ID: 1673435656-305098-5377-434-1
X-BESS-VER: 2019.1_20221214.2106
X-BESS-Apparent-Source-IP: 209.85.214.200
X-BESS-Outbound-Spam-Score: 0.40
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.245393 [from 
        cloudscan13-151.eu-central-1a.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        0.40 BSF_SC0_SA085b         META: Custom Rule SA085b 
        0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
X-BESS-Outbound-Spam-Status: SCORE=0.40 using account:ESS91090 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, BSF_SC0_SA085b, BSF_SC0_MISMATCH_TO
X-BESS-BRTS-Status: 1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sinthu Raja <sinthu.raja@ti.com>

Hi All,
This series of patch add support to enable lanes 2 and 3 swap by
configuring the LN23 bit of the SerDes WIZ control register. Also,
it's possible that the Type-C plug orientation on the DIR line will
be implemented through hardware design. In that situation, there
won't be an external GPIO line available, but the driver still needs
to address this since the DT won't use the typec-dir-gpios property.
Update code to handle if typec-dir-gpios property is not specified in DT.

Changes in V3:
=============
Address review comments:
- Update comment to mention the LN23 SWAP along with the LN10

Changes in V2:
=============
Address review comments:
- Update commit description as per review comments.
- Restore code to check only debounce delay only if typec-dir-gpios property is specified in DT.
- Rename enum variable name from wiz_lane_typec_swap_mode to wiz_typec_master_lane.
- Rename lane_phy_reg variable as master_lane_num.
- Update inline comments.

V1: https://lore.kernel.org/lkml/20221213124854.3779-2-sinthu.raja@ti.com/T/
V2: https://lore.kernel.org/lkml/20230106071714.30562-1-sinthu.raja@ti.com/

Sinthu Raja (2):
  phy: ti: j721e-wiz: Manage TypeC lane swap if typec-dir-gpios not
    specified
  phy: ti: j721e-wiz: Add support to enable LN23 Type-C swap

 drivers/phy/ti/phy-j721e-wiz.c | 66 ++++++++++++++++++++++++++++------
 1 file changed, 56 insertions(+), 10 deletions(-)

-- 
2.36.1

