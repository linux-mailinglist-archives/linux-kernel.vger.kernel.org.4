Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2523060C1D7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 04:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbiJYCnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 22:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbiJYCnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 22:43:09 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8F13AE55;
        Mon, 24 Oct 2022 19:43:08 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id u8-20020a17090a5e4800b002106dcdd4a0so14873324pji.1;
        Mon, 24 Oct 2022 19:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mV+GmkM5T+Z4YGFSVgtClSbjpVnm7tENAQZ0qymGquE=;
        b=o/rfZHK9lBRIPYU0h9n8rn/cmxibbkidswYdgOYctV33CCbkpjR45aK58E9qHNDVTZ
         YXqKjXynSwKH81l7CyztTBx1+7b6aLnyWZJVaiSsshXznCRBK7xvKzKZpf2pTM5s0KIQ
         OWhqsKHpTs5OU64XRIVEP6bVCHok0ZBRg0yI11+84VW9EbqQQ8BoFRXmNN8Ok3TQrpZ2
         RuEvslDRrRcA7d+MH9qGQ5EnKEjht++ylGJxuGrpKRTiLta8e99xboE4oMWHLAeG5JOS
         +SkC+ekpU8SqAnztMFUH4x4Ex5n0+pErx/bCLh1IAU31rE6ai4To3Wu7bsG/4ufj51Zh
         PqVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mV+GmkM5T+Z4YGFSVgtClSbjpVnm7tENAQZ0qymGquE=;
        b=yYmokNHSjWlmHFqMfpLwIdn6EikcAM0bWCle47p8QOi6+W323VxtXbE0K7B9hTFgOI
         4EicYXRw44PTRRkcjN1iVJtPZXy/VXuEBBj08xGhGPOBaiEyDjm1UCNw5kJK6DRVb+4s
         32OQGjay5jxi3BL4HF4ttqAhsw3qy+/6O0Y1u6xj80Rye1lhVfh8TOnMnyR9JST69JBk
         BaRp6PixnlgwtBYPJWfWpn1DCLVBQVY/60fkjQOV5Z83vI09QeZIA+7ZZwMqliY6zr50
         eYpSxZATleJOnfY56HtRQmutF2rV4XrtjRm1afAOWqrHy3YZBwhyvY//66KGwXpgcnaA
         Bw5w==
X-Gm-Message-State: ACrzQf0wh9Tw6ve0B3eiIMW2h6aqeIgYWIBgi1AsJAzK8388trfgOBJQ
        1FseuB6hTmtk51rCuao6Y2Q=
X-Google-Smtp-Source: AMsMyM6Gn9mitFHKGNaBOVjMemkrZDCwBoVXWp3zLOWC+8DpJz3H3JZkZk3J8nbXfblaGsgUI2XRww==
X-Received: by 2002:a17:902:e742:b0:17f:6a44:ee4a with SMTP id p2-20020a170902e74200b0017f6a44ee4amr37219795plf.103.1666665788091;
        Mon, 24 Oct 2022 19:43:08 -0700 (PDT)
Received: from localhost.localdomain.dhcpserver.bu9bmc.local (125-228-123-29.hinet-ip.hinet.net. [125.228.123.29])
        by smtp.gmail.com with ESMTPSA id p12-20020aa79e8c000000b0056befcd7958sm458516pfq.84.2022.10.24.19.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 19:43:07 -0700 (PDT)
From:   Potin Lai <potin.lai.pt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Patrick Williams <patrick@stwcx.xyz>,
        Potin Lai <potin.lai@quantatw.com>,
        Potin Lai <potin.lai.pt@gmail.com>
Subject: [PATCH 1/1] ARM: dts: aspeed: bletchley: add aliases for mdio0 and mdio3
Date:   Tue, 25 Oct 2022 10:41:45 +0800
Message-Id: <20221025024145.1561047-1-potin.lai.pt@gmail.com>
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

Add aliases for mdio0 and mdio3 so that we can use name to lookup the
address of Aspeed SOC.

For example:
root@bletchley:~# cat /sys/firmware/devicetree/base/aliases/mdio0
/ahb/mdio@1e650000
root@bletchley:~# cat /sys/firmware/devicetree/base/aliases/mdio3
/ahb/mdio@1e650018

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
index c02c15f15465..2825d5f3f78b 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
@@ -15,6 +15,8 @@ / {
 
 	aliases {
 		serial4 = &uart5;
+		mdio0 = &mdio0;
+		mdio3 = &mdio3;
 	};
 
 	chosen {
-- 
2.31.1

