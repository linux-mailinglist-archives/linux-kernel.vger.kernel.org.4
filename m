Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FEAA740C5C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 11:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234651AbjF1JFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 05:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234469AbjF1IyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 04:54:21 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB8630E8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 01:54:20 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id 46e09a7af769-6b2f0a140b7so5132173a34.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 01:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=saviah-com.20221208.gappssmtp.com; s=20221208; t=1687942459; x=1690534459;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FzpucOKusMK2wTNYrtP4LhYMpmeXTJSQi3XxzYtYylI=;
        b=OezRWM4mqIadoFOGYoBQtU3PEBAP23iDGdweFBuyxq324SK6/sX7pdAM0pMwYrjaYX
         yAMQQvLPFW3jGyXSwpCEwcvgf9mlyBulGiSQ3CbYDkid66ek7um20AumyRjsPciFSUNe
         zgMj7WEhNv7cEiHRKCm3651OQNj2ARgTtWAG8yHrX/VeOpENSUT4kEOrBMfSe4PYw2zB
         xIf25noPxXxlCA2oSEnwHpS++cG0+OVySrd/a+Oy/CNkNtvvXGAunqYSBY1gbuXZPjbj
         B6SPjVvQZVBOS4M6pOJ4r2zkuY1tFA6ikQ3pYZWqOgXVJBWLPMRK1JsACVcl3CkOIuko
         k9dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687942459; x=1690534459;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FzpucOKusMK2wTNYrtP4LhYMpmeXTJSQi3XxzYtYylI=;
        b=CLe4BDuJcMnsRG+I3wW4BWcQqXvtdLHjaJnjQ52XDg964pPt6nQEzq0yk/N38dMryW
         L7oMKzaMZ+xSE9QfwLgcz+iZMhWqgvVY5uio4dtbLM/RNUlahC2/iuEx2ni5XOrdiDwR
         DOYpgDo2FtZvmwZd03Y1CScrFHfm0/CxOgA7VVflXvPw9xNXnQA0QnmlkRMqPlaZRl3X
         SKzu7fWGiubXB79vBgp1Zipx2VhWxRK1PA8Mj1evT/FwgxLj32XZ2weBulb2T17Bidym
         siH2WPZe/PTIa3KmSMDh9+3GnM+gH8eFmyT2zOnvUiSDg0WF4Oli87d57QjehymzeniI
         PiKg==
X-Gm-Message-State: AC+VfDzRJZXJnNwKre2l8vNSugtUf9KrZWrz3cgrrl+ulq6bl8fijca2
        Dpm59mSNK84XgG5sbuKAdjfiSA==
X-Google-Smtp-Source: ACHHUZ6iQ8wx97tAv9h9KoxBd8wmNDPP8jmvHzDqdq4y8g+/TEi84IqBehsy/FzhEBxuoCgRi7VZGA==
X-Received: by 2002:a05:6830:1d66:b0:6b7:378d:7daa with SMTP id l6-20020a0568301d6600b006b7378d7daamr12244531oti.4.1687942459633;
        Wed, 28 Jun 2023 01:54:19 -0700 (PDT)
Received: from localhost.localdomain (NCTU-Wireless-NAT220.nctu.edu.tw. [140.113.136.220])
        by smtp.gmail.com with ESMTPSA id s11-20020a63dc0b000000b0053031f7a367sm7022025pgg.85.2023.06.28.01.54.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Jun 2023 01:54:19 -0700 (PDT)
From:   Ian Chen <yi.chen@saviah.com>
To:     davem@davemloft.net
Cc:     edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        corbet@lwn.net, netdev@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ian Chen <yi.chen@saviah.com>
Subject: [PATCH] Documentation: networking: add UPF (User Plane Function in 5GC) description
Date:   Wed, 28 Jun 2023 16:53:51 +0800
Message-Id: <20230628085351.84016-1-yi.chen@saviah.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the content of User Plane Function (UPF),
which was defined in 3GPP specifications since release 15.

Signed-off-by: Ian Chen <yi.chen@saviah.com>
---
 Documentation/networking/gtp.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/networking/gtp.rst b/Documentation/networking/gtp.rst
index 9a7835cc1..c02aa34c4 100644
--- a/Documentation/networking/gtp.rst
+++ b/Documentation/networking/gtp.rst
@@ -31,12 +31,12 @@ payload, such as LLC/SNDCP/RLC/MAC.
 
 At some network element inside the cellular operator infrastructure
 (SGSN in case of GPRS/EGPRS or classic UMTS, hNodeB in case of a 3G
-femtocell, eNodeB in case of 4G/LTE), the cellular protocol stacking
+femtocell, eNodeB in case of 4G/LTE, gNobeB in case of 5G), the cellular protocol stacking
 is translated into GTP *without breaking the end-to-end tunnel*.  So
 intermediate nodes just perform some specific relay function.
 
-At some point the GTP packet ends up on the so-called GGSN (GSM/UMTS)
-or P-GW (LTE), which terminates the tunnel, decapsulates the packet
+At some point the GTP packet ends up on the so-called GGSN (GSM/UMTS),
+P-GW (LTE), or UPF (5G), which terminates the tunnel, decapsulates the packet
 and forwards it onto an external packet data network.  This can be
 public internet, but can also be any private IP network (or even
 theoretically some non-IP network like X.25).
@@ -60,7 +60,7 @@ payload, called GTP-U.  It does not implement the 'control plane',
 which is a signaling protocol used for establishment and teardown of
 GTP tunnels (GTP-C).
 
-So in order to have a working GGSN/P-GW setup, you will need a
+So in order to have a working GGSN/P-GW/UPF setup, you will need a
 userspace program that implements the GTP-C protocol and which then
 uses the netlink interface provided by the GTP-U module in the kernel
 to configure the kernel module.
@@ -162,7 +162,7 @@ Local GTP-U entity and tunnel identification
 GTP-U uses UDP for transporting PDU's. The receiving UDP port is 2152
 for GTPv1-U and 3386 for GTPv0-U.
 
-There is only one GTP-U entity (and therefore SGSN/GGSN/S-GW/PDN-GW
+There is only one GTP-U entity (and therefore SGSN/GGSN/S-GW/PDN-GW/UPF
 instance) per IP address. Tunnel Endpoint Identifier (TEID) are unique
 per GTP-U entity.
 
-- 
2.38.1

