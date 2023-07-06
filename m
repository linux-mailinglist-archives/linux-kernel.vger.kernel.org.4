Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF867749FDA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 16:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232977AbjGFOwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 10:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233421AbjGFOwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 10:52:24 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4ED1FE1
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 07:52:10 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-7659924cd9bso87796585a.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 07:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1688655129; x=1691247129;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=fyfUbQSETzEWvemqOE851lvgUnh/NkXs0bSTrstNyr8=;
        b=i2Un2fu71+vZBbntcXyVTNvEdBIziZ1L1uzjczm6qGVJ0CcOsqnSyQlN1MIb5HRjl/
         blyyG7I4BbHEFeKIY7zcCUXcy3fvaNpk6nm48dG9XlvMphfL1yAOussSZ87hQ1B4qUJt
         9KxljrOCEWESkbhuCN4agXIrZhw9jsey0wGD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688655129; x=1691247129;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fyfUbQSETzEWvemqOE851lvgUnh/NkXs0bSTrstNyr8=;
        b=bRw/t2rWSJr0WffOZY73Vxkm5OBgLPVWU4p4WqhajyNh0C/nnQX2vUwbgEjQG/v7np
         lr2ZowbTS6iVPn729wkUeC6+vGEWoTKiZYJummFpcCC83YBVDKh6swVey9TiPK9tZFcS
         DhDGQBYslXmS4dgRHHn2iLwRhOb23X/R9X3xxt0E8I98k7S6JOPGsbkn9ZP3ijJKycaK
         xTmkKuB3nWG+S66XCh+MqpH7SknVKW2VwlEHXFJJIdhAmvQtrFUe5CY4douU78wvUWDU
         7cKuvUstdQZMe55ejUbO+MgF2QD/aOREmWi8+38Yx6SFmpuRMU/o0ASuNB+oH5J40wqf
         VvTA==
X-Gm-Message-State: ABy/qLZapt1Bsmg3xuBx1OVxU8Wj9brQPpoSpiWE81bwdSWRzLD1rgw5
        y9br7M/6To0pWahjhm3zY2k0IQ==
X-Google-Smtp-Source: APBJJlFT1vALIK6K0rOyw2waZxmnCl6+oNCTAyz6E25Ih5OW5YyHLA3Lb1ef3b6AIXboa4N85r+RfQ==
X-Received: by 2002:a05:620a:44d3:b0:765:6556:1113 with SMTP id y19-20020a05620a44d300b0076565561113mr3065592qkp.46.1688655129166;
        Thu, 06 Jul 2023 07:52:09 -0700 (PDT)
Received: from fedora64.linuxtx.org ([99.47.93.78])
        by smtp.gmail.com with ESMTPSA id ou23-20020a05620a621700b00767303dc070sm836984qkn.8.2023.07.06.07.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 07:52:08 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
From:   "Justin M. Forbes" <jforbes@fedoraproject.org>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        "Justin M. Forbes" <jforbes@fedoraproject.org>,
        Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     jmforbes@linuxtx.org
Subject: [PATCH] Move rmnet out of NET_VENDOR_QUALCOMM dependency
Date:   Thu,  6 Jul 2023 09:51:52 -0500
Message-Id: <20230706145154.2517870-1-jforbes@fedoraproject.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rmnet driver is useful for chipsets that are not hidden behind
NET_VENDOR_QUALCOMM.  Move sourcing the rmnet Kconfig outside of the if
NET_VENDOR_QUALCOMM as there is no dependency here.

Signed-off-by: Justin M. Forbes <jforbes@fedoraproject.org>
---
 drivers/net/ethernet/qualcomm/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/Kconfig b/drivers/net/ethernet/qualcomm/Kconfig
index 9210ff360fdc..5beebe6b486e 100644
--- a/drivers/net/ethernet/qualcomm/Kconfig
+++ b/drivers/net/ethernet/qualcomm/Kconfig
@@ -61,6 +61,6 @@ config QCOM_EMAC
 	  low power, Receive-Side Scaling (RSS), and IEEE 1588-2008
 	  Precision Clock Synchronization Protocol.

-source "drivers/net/ethernet/qualcomm/rmnet/Kconfig"
-
 endif # NET_VENDOR_QUALCOMM
+
+source "drivers/net/ethernet/qualcomm/rmnet/Kconfig"
-- 
2.40.1

