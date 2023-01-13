Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 564A5669BB7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 16:16:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjAMPQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 10:16:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjAMPQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 10:16:07 -0500
Received: from egress-ip4b.ess.de.barracuda.com (egress-ip4b.ess.de.barracuda.com [18.185.115.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF40483E0F
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 07:07:05 -0800 (PST)
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198]) by mx-outbound40-153.eu-central-1c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Fri, 13 Jan 2023 15:07:03 +0000
Received: by mail-pl1-f198.google.com with SMTP id i5-20020a170902c94500b001946f55ea18so1468420pla.22
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 07:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mistralsolutions.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ITl3Ff1g4Vokba4zPtv+9Lr8JadVrsPfIWw8DVJ0Tmo=;
        b=O+CkNbuNNMU9MJjz94I5hXaXIOh2mta8hvBgc25UEGwo5IUb29L0q5bnDYwpIpsrW6
         0sSBfBBMV+tBFkXO51S3ej40727zkl/S++x4cyz8jxKYN0MUKST/OMGR+N3b1T4RMfZs
         rGRcZJeaB94JuiSpAM3I3iOKmbMKIXt/YN0d0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ITl3Ff1g4Vokba4zPtv+9Lr8JadVrsPfIWw8DVJ0Tmo=;
        b=DotlGPkfwvUoX6n5Gan9wu3/Ph6vY10QS15ROGiweqCFbDmpacKhcCV5GBI9VkUFRL
         bExeTbN+QrEnmoXdite4qYui2MK3Wl1Do+44E10Jx6tpCDZooPSfaYtfzQbBxdhaF94G
         y+qu8gEKVFHg9wx8uU3h4YLxjR3h6ncQLNCB/IXtHstRHtkc1KmDcwivFDFQbmsANXlW
         0enqqDOSdjDyG7V7f8iYbS1JqvYZSBLa/6y6H7nHlChYy6bkA+GqPZB5oPw/36m3yrAR
         yKgetOdZ8tYM9dNkxUFqH30eOu64OokEJcpHAMyJuavDMeWp9F/JPERlGlg1n9iatueZ
         ezHA==
X-Gm-Message-State: AFqh2krafXnaYNEVnGQVrV886AZ1QHVCXAnwE5969BoWYw9ZA4D0J2fu
        2GqsW0t8tIJTOO2P4gx95/FJohEekwS0eaBbdvkqjpnQEGPZDJpbw2GOqp8WlMSLmGtKvNS6TBX
        z0o9MCqFyOcUa39DaDoPk+/RoDLP5lPfW4QY9wakfDIF6TFJeB+8in0mtFyCV
X-Received: by 2002:a17:902:9a93:b0:192:9e13:a4ba with SMTP id w19-20020a1709029a9300b001929e13a4bamr52541828plp.34.1673622422092;
        Fri, 13 Jan 2023 07:07:02 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtwrIHP9dW0hF1a9tF5ZM09LhODKShZitSOnNk0gkOBZaWby8FrTww3ZqFTZXZ65yuuxu6HcQ==
X-Received: by 2002:a17:902:9a93:b0:192:9e13:a4ba with SMTP id w19-20020a1709029a9300b001929e13a4bamr52541789plp.34.1673622421582;
        Fri, 13 Jan 2023 07:07:01 -0800 (PST)
Received: from LAP568U.mistral.in ([106.51.227.150])
        by smtp.gmail.com with ESMTPSA id v11-20020a170902f0cb00b00180033438a0sm14325723pla.106.2023.01.13.07.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 07:07:00 -0800 (PST)
From:   Sinthu Raja <sinthu.raja@mistralsolutions.com>
X-Google-Original-From: Sinthu Raja <sinthu.raja@ti.com>
To:     Roger Quadros <rogerq@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Ravi Gunasekaran <r-gunasekaran@ti.com>,
        Siddharth Vadapalli <s-vadapalli@ti.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sinthu Raja <sinthu.raja@ti.com>
Subject: [PATCH V4 0/2] phy: ti: j721e-wiz: Add support to manage type-C swap on Lane2 and lane3 
Date:   Fri, 13 Jan 2023 20:36:13 +0530
Message-Id: <20230113150615.19375-1-sinthu.raja@ti.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BESS-ID: 1673622422-310393-5627-19235-1
X-BESS-VER: 2019.1_20221214.2106
X-BESS-Apparent-Source-IP: 209.85.214.198
X-BESS-Outbound-Spam-Score: 0.40
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.245440 [from 
        cloudscan19-2.eu-central-1b.ess.aws.cudaops.com]
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

Changes in V4:
=============
- Fixe checkpatch CHECK errors.
 * Remove unnecessary paranthesis.
 * Avoid logical continuations in multiple lines.

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
V3: https://lore.kernel.org/lkml/20230111111356.17392-1-sinthu.raja@ti.com/ 

Sinthu Raja (2):
  phy: ti: j721e-wiz: Manage TypeC lane swap if typec-dir-gpios not
    specified
  phy: ti: j721e-wiz: Add support to enable LN23 Type-C swap

 drivers/phy/ti/phy-j721e-wiz.c | 66 ++++++++++++++++++++++++++++------
 1 file changed, 56 insertions(+), 10 deletions(-)

-- 
2.36.1

