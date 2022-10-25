Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0340660C380
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 07:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbiJYFwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 01:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbiJYFwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 01:52:04 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6036DBB062;
        Mon, 24 Oct 2022 22:52:03 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id f140so10937131pfa.1;
        Mon, 24 Oct 2022 22:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hIosgv5purvdOHjHB0Bdm/xsYrKIRMZ14fsco2UYxnk=;
        b=Gi0LqGujeeIHDVQVa56iRgjW+CI3P/VaODt++d1WhDW+E0Ql+uw8P7QiLdb5EKVxtU
         /buJsSr4XGFfPVSn7bFH4r0seo1W1Y3V0D+O2p+hV4jFqX+NUK2d5zkFrFD+r0KKH0SC
         lAz8b3loolLsYJC277CGRf6khkO3AF9WYUoQPdv8JCpvx+PAGSa0YQ3hAaefocawFLIX
         h08NMopijzftxPlUZzLBC1fZmGjdZmsPmFOHFiiTWLPDmIjWAtOe8Y5ZvHap0MxIb7Zu
         KFG6TOPr5uyTE4Et8IeR4w/dbHdTx+foft5trYjehD0l5FSZBrGfAU+QzyfLNwOY64Dm
         rgMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hIosgv5purvdOHjHB0Bdm/xsYrKIRMZ14fsco2UYxnk=;
        b=3XyLW5cJaJV56xfhHhWzIUqjmiX2pcCiJHNc9XV/7oYDlWwxjPn3jARlBV4onZvo0O
         nmC5uq5qJfq/VBQVCWgdhEORasfzpuFbcQOXajxvyutoxBR+wfCijoYkZzQUr9Pq39I2
         3n3wxMePGcshsO2SKCUDMB5lcscGXqr0SyiLA10JZhaOP3GSSX1Z/icCjOURPNfrXQG6
         jCMgrwarGk2x8r73YOiFtXMMBOsTe7bYGl9RCw1Gbfv3LeT/upoHhGPOX30u1/ajsB8h
         6bWO6L4DnjFlCPLIE9D+e3nDqU8aKEpkQOuoiaH8U56FV6G6qpSUC0/Xs4dA/A+Kzi4I
         eH2Q==
X-Gm-Message-State: ACrzQf0PBo5XUbB9JTbZob4IuX/Ews95QgmjTlKkNaDhrYicl0vJMh7a
        Xd0l4v2AFs1ERrIW4f7LeiM=
X-Google-Smtp-Source: AMsMyM5Yrz5n05HNZztnB0pQdKPHsHmLKVkt2d8mYs8HXJ1l2cDamvLiDiMe7LXO+RQoeZk++Djq0Q==
X-Received: by 2002:aa7:810a:0:b0:55b:674d:d123 with SMTP id b10-20020aa7810a000000b0055b674dd123mr38050507pfi.52.1666677122845;
        Mon, 24 Oct 2022 22:52:02 -0700 (PDT)
Received: from localhost.localdomain.dhcpserver.bu9bmc.local (125-228-123-29.hinet-ip.hinet.net. [125.228.123.29])
        by smtp.gmail.com with ESMTPSA id e126-20020a621e84000000b0056ba6952e40sm675644pfe.181.2022.10.24.22.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 22:52:02 -0700 (PDT)
From:   Potin Lai <potin.lai.pt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Patrick Williams <patrick@stwcx.xyz>,
        Potin Lai <potin.lai@quantatw.com>,
        Potin Lai <potin.lai.pt@gmail.com>
Subject: [PATCH v2 1/1] ARM: dts: aspeed-g6: add aliases for mdio nodes
Date:   Tue, 25 Oct 2022 13:50:46 +0800
Message-Id: <20221025055046.1704920-1-potin.lai.pt@gmail.com>
X-Mailer: git-send-email 2.31.1
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

Add aliases for mdio nodes so that we can use name to lookup the
bus address of Aspeed SOC.

For example:
root@bletchley:~# cat /sys/firmware/devicetree/base/aliases/mdio0
/ahb/mdio@1e650000
root@bletchley:~# cat /sys/firmware/devicetree/base/aliases/mdio1
/ahb/mdio@1e650008
root@bletchley:~# cat /sys/firmware/devicetree/base/aliases/mdio2
/ahb/mdio@1e650010
root@bletchley:~# cat /sys/firmware/devicetree/base/aliases/mdio3
/ahb/mdio@1e650018

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
LINK: [v1] https://lore.kernel.org/all/20221025024145.1561047-1-potin.lai.pt@gmail.com/

change v1 --> v2:
* move mdio aliases to aspeed-g6.dtsi
---
 arch/arm/boot/dts/aspeed-g6.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
index 0cc92874caa8..6f159ef1efbc 100644
--- a/arch/arm/boot/dts/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed-g6.dtsi
@@ -36,6 +36,10 @@ aliases {
 		serial4 = &uart5;
 		serial5 = &vuart1;
 		serial6 = &vuart2;
+		mdio0 = &mdio0;
+		mdio1 = &mdio1;
+		mdio2 = &mdio2;
+		mdio3 = &mdio3;
 	};
 
 
-- 
2.31.1

