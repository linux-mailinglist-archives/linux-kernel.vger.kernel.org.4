Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB10C72422C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 14:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237397AbjFFMbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 08:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236845AbjFFMbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 08:31:38 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C4510C3
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 05:31:36 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1b02085bf8dso26482875ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 05:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686054696; x=1688646696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fKHi+1QT0DExDdBo5/MSIfvmq1jZp/v5cfToP5Zl7jI=;
        b=lz9bVSeQuZO2Dz65xSN4KzdfWWXvda+T+V6qFbNZzFvCaBqzsy98S+/UFK5RvyQXoX
         Jf1cMqD6sNktjlw3smrT7sJ7AKbTzIs2xCjdln7QewQD3jfjZx08Q91NiyWWMSyIW0Ng
         dm5oQfuB1DKioJ9dqY7LH0pL4vrF3yunupwGpG7h8xS6sel1wHyjqvPp+cHxQEtRbsF2
         sArh6I2pYgKY+K99eDGLU9oS0yNBOzOHv1hzEjYXjCv1mPo2kAkLVcEdmBf/Hjc+bKeU
         PdnSnCEpcNHFfBVtIseKybuqp2VWRHtx7uJOKJDa9dvO6SeCD1TYK7vqcWBRKcDx1gPy
         +oVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686054696; x=1688646696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fKHi+1QT0DExDdBo5/MSIfvmq1jZp/v5cfToP5Zl7jI=;
        b=VDdx0gDGE3K69d71uowg1G6a4SIhYrhRVRZXeMdWHyLydqayMwo0XUrM9RpAhxV+9i
         819axYCxbyErgxfOVIEv1camaQPGTy3j5wKy+R9YvdzCYUnl2vk1fdtcVNxcN/q9vvxA
         oa7F1AwbuP/iTHiZsyB9UyEPaLB3/9KqE8H2DcUQi8triYUwobYQA64ZpJR38SZTg9L6
         YnvF+v1085I0HkkS62WbVFDYorTwVDWTSiF3SPOhVfJ5DrtkKTvpt4Z3EQ1DP24MaWVt
         fu2tFPBPWr+z1rSRer0KfDxZZ4zIKVp/6SMJ0pQ+GtGjeOMD3gOgUPiyw6XaV+xuLfnx
         yz+A==
X-Gm-Message-State: AC+VfDxybOn4uEZEfjy0sOxPUNq1uOCt2Oc6N9jlUWX3ezgE1MUhlwnc
        Bd/sqx+JDRrwDqDIxLCDA42E
X-Google-Smtp-Source: ACHHUZ68eHLLHb7oc5WpJvUVNzBFwdaMF+eaEVHcDYHteg0CAVXrcrAC7ONGOGNx/9A38WXJjOT/Lg==
X-Received: by 2002:a17:902:e850:b0:1b2:436b:931c with SMTP id t16-20020a170902e85000b001b2436b931cmr244061plg.43.1686054696333;
        Tue, 06 Jun 2023 05:31:36 -0700 (PDT)
Received: from localhost.localdomain ([117.202.186.178])
        by smtp.gmail.com with ESMTPSA id q5-20020a170902c74500b001ae59169f05sm8446431plq.182.2023.06.06.05.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 05:31:36 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        loic.poulain@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 3/3] net: mhi: Increase the default MTU from 16K to 32K
Date:   Tue,  6 Jun 2023 18:01:19 +0530
Message-Id: <20230606123119.57499-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230606123119.57499-1-manivannan.sadhasivam@linaro.org>
References: <20230606123119.57499-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most of the Qualcomm endpoint devices are supporting 32K MTU for the
UL (Uplink) and DL (Downlink) channels. So let's use the same value
in the MHI NET driver also. This gives almost 2x increase in the throughput
for the UL channel.

Below is the comparision:

iperf on the UL channel with 16K MTU:

[ ID] Interval       Transfer     Bandwidth
[  3]  0.0-10.0 sec   353 MBytes   296 Mbits/sec

iperf on the UL channel with 32K MTU:

[ ID] Interval       Transfer     Bandwidth
[  3]  0.0-10.0 sec   695 MBytes   583 Mbits/sec

Cc: Loic Poulain <loic.poulain@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/net/mhi_net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/mhi_net.c b/drivers/net/mhi_net.c
index 3d322ac4f6a5..eddc2c701da4 100644
--- a/drivers/net/mhi_net.c
+++ b/drivers/net/mhi_net.c
@@ -14,7 +14,7 @@
 
 #define MHI_NET_MIN_MTU		ETH_MIN_MTU
 #define MHI_NET_MAX_MTU		0xffff
-#define MHI_NET_DEFAULT_MTU	0x4000
+#define MHI_NET_DEFAULT_MTU	0x8000
 
 struct mhi_net_stats {
 	u64_stats_t rx_packets;
-- 
2.25.1

