Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A37F2747ADD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 03:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbjGEBP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 21:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjGEBP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 21:15:27 -0400
Received: from mx5.ucr.edu (mx5.ucr.edu [138.23.62.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11A510EA
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 18:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1688519725; x=1720055725;
  h=mime-version:from:date:message-id:subject:to;
  bh=q0HvZFnTXa9fgE+7yflwyqzGdoGApfl9T11jQdopfW8=;
  b=gx+rmd1aSNLNINuxAuzzXkuODe/KLcXyqm4w7reNJAq4zX1CXxtfKEdO
   asVcTnv99r0K9dD/CHYvNtCi2AZEns87mAezhM0XQaVr1I57S/ws2y3qk
   4quouSfvrxj5CkMFDvEvNGIx48EdXCk/Rcml1qrYYYuoPvWiR/5+jRLXh
   MeCl1c9rJUDUdS4Wafaq5AXcrq9GhYXAvXOBg5ZuZTPwrn7LVcpjPd5JM
   QUua49rV4TkMskDbMkzizy2xY43gdmNVSKFrs0eZhiYbk4+G+B6XBE3ic
   eVzIddFCnPbESpMiwA/bD6sLhZGwXCrkyVtz6Vg7lFeMJ5CHvuTyf6HCH
   A==;
Received: from mail-wr1-f70.google.com ([209.85.221.70])
  by smtpmx5.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Jul 2023 18:15:24 -0700
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-2f2981b8364so3505231f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 18:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1688519723; x=1691111723;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NIYq5ovgGYYcT2mwLIe/7Pwf4A8ZFgLTV67vPU1luuE=;
        b=OpDKa6aazYkYIruwvWLbwnWXzbvxhbV2XYMfpy978GxqtOHauKAOZYoLYn0DnSzCp9
         ZkBo2uz0ECn3yqxrbocDTgsrjomb0U1WSJGLsYJ8mT+MjEJyEfvRZ/JN275xRjGDN8si
         Ntv3h3tZAfU13NivPqTFkFQuidIgK+7sldNv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688519723; x=1691111723;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NIYq5ovgGYYcT2mwLIe/7Pwf4A8ZFgLTV67vPU1luuE=;
        b=TVsnL1hNYJOUsWoJvqP0hqf1154AwJrHCx2x7OURI+FPnVjQteDdN0+oyfQ8iNzK/m
         ziAu6J+bL9joA5+lVtWG3jJf4RoshN9fVUzYn+bAlNzUV/mGkC3XI/JDmpN+br3mKx2n
         aD6khGpjpDN9oKaN3jDx5RWfijRLeAcxEKYkV108064jLjkhNaDewSeEjwOBETYfi8vF
         7vMnVMEQZWmmRtW8RGzaaRA1viJTyzdnDv3eZS6FW7Vsye5rB3GCnuo/We2B+Jh9UyKA
         79Z8jfEB+F4IzqZvJbpsqm09t6UT8PzyMsW6sSm6uRgbis7Wby3VVK+KVPyJkWCxF8yM
         xaXQ==
X-Gm-Message-State: ABy/qLagEYSQJiH10qW1vKVNtgA4EHqqVsFm7rotB3WEvtdrT9B8zsZK
        Fp+neZH0wY7z16kDyD1PzfBVjlf/c+eRGADl6Qtt9HsYSbapU0ye1XcMtpn6c5kmnn95+DuU2KB
        a1z4TZRkY0KPCzDAGiCeIUcuOA6uU5unP9L7tkC1fnDLNPxSal3jd6Aw=
X-Received: by 2002:adf:f147:0:b0:314:38e4:2596 with SMTP id y7-20020adff147000000b0031438e42596mr5849442wro.49.1688519723014;
        Tue, 04 Jul 2023 18:15:23 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH0U4jLD27P3ah3ysuNk9sOys6goAlAbsY6dgFCEoGMpWROGB9rEd61YoyrMeyUAeyYjUe3bb9IYzKcnOuphfk=
X-Received: by 2002:adf:f147:0:b0:314:38e4:2596 with SMTP id
 y7-20020adff147000000b0031438e42596mr5849436wro.49.1688519722754; Tue, 04 Jul
 2023 18:15:22 -0700 (PDT)
MIME-Version: 1.0
From:   Yu Hao <yhao016@ucr.edu>
Date:   Tue, 4 Jul 2023 18:15:09 -0700
Message-ID: <CA+UBctD1E5ZLnBxkrXh3uxiKiKXphnLKiB=5whYtH73SCTESWw@mail.gmail.com>
Subject: [PATCH] net: lan78xx: Fix possible uninit bug
To:     woojung.huh@microchip.com, UNGLinuxDriver@microchip.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-usb@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable buf should be initialized in the function lan78xx_read_reg.
However, there is no return value check, which means the variable buf
could still be uninit. But there is a read later.

Signed-off-by: Yu Hao <yhao016@ucr.edu>
---
 drivers/net/usb/lan78xx.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index c458c030fadf..4c9318c92fe6 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -1091,8 +1091,11 @@ static int lan78xx_write_raw_otp(struct
lan78xx_net *dev, u32 offset,
    int i;
    u32 buf;
    unsigned long timeout;
+   int ret;

-   lan78xx_read_reg(dev, OTP_PWR_DN, &buf);
+   ret = lan78xx_read_reg(dev, OTP_PWR_DN, &buf);
+   if (ret < 0)
+       return ret;

    if (buf & OTP_PWR_DN_PWRDN_N_) {
        /* clear it and wait to be cleared */
-- 
2.34.1
