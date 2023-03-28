Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6FC96CCB40
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 22:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjC1UQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 16:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjC1UQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 16:16:13 -0400
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B217A3C22;
        Tue, 28 Mar 2023 13:16:12 -0700 (PDT)
Received: by mail-ot1-f49.google.com with SMTP id f19-20020a9d5f13000000b00693ce5a2f3eso7058745oti.8;
        Tue, 28 Mar 2023 13:16:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680034572;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LJY6pOPdDa4oqX5OXa+Badi5ySmgsIj2CbDDOIk/1F8=;
        b=WiJTrU2iskz/zd2OuLc0a5V3v/lk457P47G6oCK1uFAbpjnyX6a4AIOZimGhmjCAr0
         NV7dO3+gsicKGzwOMtLLYhAidt4jX8wZp8MaXv4bA0ndHhF66M/5gIA1eL1pCp6I3ba0
         SZ46ZmfzuWpFA39mdcvKM0noS6l5Idr1vlwzj6lbA8aZcEbsJv3fd7YPqJIiiQ960M28
         iusXNCCGR5LrXPSR1Az8lk+3Co4ICaCQTr4j/T+DC3nQ6eA4LvtK3XpSgRtVl1+jJcle
         qgNsHu2xdlY5JmLkONkcr0VeoXT52Rsuw/FRSHU+25vGwQS3p36+X1FRbJoLeOM7hLAw
         8dMQ==
X-Gm-Message-State: AO0yUKXK1GuHeJbGz/NFWLmEmhbuht6EY54QLQ/dkoPld2haf693iJF0
        +IRz2a59K3/raN3ZnLTCRg==
X-Google-Smtp-Source: AK7set9GAgC93luzWNZuofJauP57z3vXyLI4sRAP80NLLCHRI4Txb9cd8obWGvd6gSVOAMPakodRgQ==
X-Received: by 2002:a9d:6d82:0:b0:69f:8da7:5463 with SMTP id x2-20020a9d6d82000000b0069f8da75463mr8887322otp.31.1680034571938;
        Tue, 28 Mar 2023 13:16:11 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l26-20020a0568301d7a00b0069fa776d3c2sm6931170oti.18.2023.03.28.13.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 13:16:11 -0700 (PDT)
Received: (nullmailer pid 3993665 invoked by uid 1000);
        Tue, 28 Mar 2023 20:16:10 -0000
From:   Rob Herring <robh@kernel.org>
Subject: [PATCH 0/5] of: More address parsing helpers
Date:   Tue, 28 Mar 2023 15:15:55 -0500
Message-Id: <20230328-dt-address-helpers-v1-0-e2456c3e77ab@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPxKI2QC/x2N0QrCMAwAf2Xk2UDXTRB/RXxI28wGSh2JDmHs3
 w17vIPjdjBWYYP7sIPyJibv7jBeBsiV+otRijPEEKcwxRuWD1IpymZYua2shnEJIV/zyIlm8DC
 RMSalnqun/duay1V5kd95ejyP4w80lXgveQAAAA==
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
X-Mailer: b4 0.13-dev
X-Spam-Status: No, score=0.7 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is part of some clean-ups to reduce the open coded parsing 
of "reg" and "ranges" in the kernel. As those are standard properties, 
the common DT code should be able to handle parsing them. However, there 
are a few gaps in the API for what some drivers need which this series 
addresses (pun intended).

I intend to add these helpers for v6.4 and then convert the users in 
v6.5 to avoid any dependency issues. This series and the WIP conversions 
are on this branch[1].

[1] git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git dt/address-helpers

Signed-off-by: Rob Herring <robh@kernel.org>
---
Rob Herring (5):
      of: unittest: Add bus address range parsing tests
      of/address: Add of_range_to_resource() helper
      of/address: Add support for 3 address cell bus
      of/address: Add of_range_count() helper
      of/address: Add of_property_read_reg() helper

 drivers/of/address.c                        |  76 +++++++++++++-
 drivers/of/unittest-data/tests-address.dtsi |   9 +-
 drivers/of/unittest.c                       | 150 ++++++++++++++++++++++++++++
 include/linux/of_address.h                  |  31 ++++++
 4 files changed, 262 insertions(+), 4 deletions(-)
---
base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
change-id: 20230328-dt-address-helpers-2f00c5c1eba4

Best regards,
-- 
Rob Herring <robh@kernel.org>

