Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B891265FBCD
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 08:18:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbjAFHSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 02:18:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjAFHR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 02:17:58 -0500
Received: from egress-ip4b.ess.de.barracuda.com (egress-ip4b.ess.de.barracuda.com [18.185.115.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982436B184
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 23:17:55 -0800 (PST)
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198]) by mx-outbound18-167.eu-central-1b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Fri, 06 Jan 2023 07:17:52 +0000
Received: by mail-pf1-f198.google.com with SMTP id ca10-20020a056a00418a00b00581dff62bb7so474369pfb.13
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 23:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mistralsolutions.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z0A84FGRepsnpr8CikPqo0ZM3qEjlQHpqMQUxyOxzp4=;
        b=lm+whdNFnv08c4xaISy7wKXP/lGpLk0d8GdxBb9eIY3FQ+cNiDssPRuIXM5rQema7R
         VqMXDz++O1FIU054r6i7rRUpIOyvLVec9Z/V4/jjVoVxP+VtijoRshopfeaLv5A+Fc7B
         XJP15ABLzHczCuWVW9GKb21OIH1IfGqz8NmJ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z0A84FGRepsnpr8CikPqo0ZM3qEjlQHpqMQUxyOxzp4=;
        b=X7qkJEBw9JEaSFfkuULHjsq+3S7/HsWhJWODfbqievK0g1Dlk9uUylQ+DrecJoPQiS
         I758JXmfkFD39LgQWKjOkysH/oS/WF5lTyvFoIMJTylPpvBhDjFROZHAd9k0BZjyMPSs
         IZ2U/AGG+jEMDXvlUu2KaPcaQJjaCrM83d08cD1OYdSHLzmu2ukDginTDlwHgBCf6k3R
         GbKKSB1L9EU7lMZth3CTV2CvlflSI+L7kSrAZAj2O5hNo610nU6nwioA77MY/sMtrSjx
         5LwXZT5hDEUQVfW5vqeaFbZApTVXiPPSvmNw9KPXFWcdwHmIu3zv1sAJjjjjMceOjwHi
         Toxw==
X-Gm-Message-State: AFqh2kpLALQ/cmkfFVWM4XP3YsbkL943O2GJerWm/5MyMNDGWzYBTVju
        B+2jull+LT2lpt9ZGCmKeJUppbmDFmyb3BOIo4OpZ8noCDnrZ3S7zif9PihO2oH0aciuoGrclw8
        YtXc4CK5JeHkKphUpxAEbtwacMve/c4vtwuAhzUlY6K5SpqgWsDk9eWZEP5n8
X-Received: by 2002:a17:903:28d:b0:192:85f3:5b1 with SMTP id j13-20020a170903028d00b0019285f305b1mr40401636plr.59.1672989471440;
        Thu, 05 Jan 2023 23:17:51 -0800 (PST)
X-Google-Smtp-Source: AMrXdXt4fjNGn4RhXSTCkrWYdQrsIeyYep30bkrbAKiaLpVu+zNcWs/SwuAn9j2YnS0jUWd90VijOA==
X-Received: by 2002:a17:903:28d:b0:192:85f3:5b1 with SMTP id j13-20020a170903028d00b0019285f305b1mr40401620plr.59.1672989471086;
        Thu, 05 Jan 2023 23:17:51 -0800 (PST)
Received: from LAP568U.mistral.in ([106.51.227.150])
        by smtp.gmail.com with ESMTPSA id h5-20020a170902680500b00189348ab156sm138845plk.283.2023.01.05.23.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 23:17:50 -0800 (PST)
From:   Sinthu Raja <sinthu.raja@mistralsolutions.com>
X-Google-Original-From: Sinthu Raja <sinthu.raja@ti.com>
To:     Roger Quadros <rogerq@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Ravi Gunasekaran <r-gunasekaran@ti.com>,
        Siddharth Vadapalli <s-vadapalli@ti.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sinthu Raja <sinthu.raja@ti.com>
Subject: [PATCH V2 0/2] phy: ti: j721e-wiz: Add support to manage type-C swap on Lane2 and lane3
Date:   Fri,  6 Jan 2023 12:47:12 +0530
Message-Id: <20230106071714.30562-1-sinthu.raja@ti.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BESS-ID: 1672989472-304775-5385-49260-1
X-BESS-VER: 2019.1_20221214.2106
X-BESS-Apparent-Source-IP: 209.85.210.198
X-BESS-Outbound-Spam-Score: 0.40
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.245283 [from 
        cloudscan11-138.eu-central-1a.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        0.40 BSF_SC0_SA085b         META: Custom Rule SA085b 
X-BESS-Outbound-Spam-Status: SCORE=0.40 using account:ESS91090 scores of KILL_LEVEL=7.0 tests=BSF_SC0_MISMATCH_TO, BSF_BESS_OUTBOUND, BSF_SC0_SA085b
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

Changes in V2:
=============
Address review comments:
- Update commit description as per review comments.
- Restore code to check only debounce delay only if typec-dir-gpios property is specified in DT.
- Rename enum variable name from wiz_lane_typec_swap_mode to wiz_typec_master_lane.
- Rename lane_phy_reg variable as master_lane_num.
- Update inline comments.

V1: https://lore.kernel.org/lkml/20221213124854.3779-2-sinthu.raja@ti.com/T/

Sinthu Raja (2):
  phy: ti: j721e-wiz: Manage TypeC lane swap if typec-dir-gpios not
    specified
  phy: ti: j721e-wiz: Add support to enable LN23 Type-C swap

 drivers/phy/ti/phy-j721e-wiz.c | 66 ++++++++++++++++++++++++++++------
 1 file changed, 56 insertions(+), 10 deletions(-)

-- 
2.36.1

