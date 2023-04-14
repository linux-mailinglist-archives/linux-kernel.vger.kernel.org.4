Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8FAE6E1BFA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 07:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjDNFxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 01:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjDNFxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 01:53:53 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC3A2729;
        Thu, 13 Apr 2023 22:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=QtfyVYYjax5xM4kYhUQxS8FTdCBduseuTRb90/0OO/0=; b=KHrc87H9g++u0Wwwa+3LEGROQW
        dS9fJCMG3eGJCXJtGlOLdcnIVQeLX3hv/VGkFwNaYkWb5gsdU0eTf2AwuxWetf7bbbxlkvQiJsrFO
        ZYz6VRWOh0Hhati3mDqJlbzK56YNn2dbF0SXPuKNW+MAQHEWr/L07wP2CB6PwOOucWEJdpXSC215v
        XLgnB/Pymv2LHqXztgIppeCX6LHv0TwrIf6Ncmus84DgeZDc0yfoXja1IPc9C4S9Ftw1whd20UnRw
        2VR+am/OjQDbXe3jASEovD1o77Va0V3uIkUJkdgJSbQWUgX9y0vLrGOZs3TCOo41LbehNpEO19b9u
        ztLEiTEQ==;
Received: from p200300ccff0c0d001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff0c:d00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1pnCNV-0005Md-AT; Fri, 14 Apr 2023 07:53:45 +0200
Received: from andi by aktux with local (Exim 4.96)
        (envelope-from <andreas@kemnade.info>)
        id 1pnCNU-001PGv-2X;
        Fri, 14 Apr 2023 07:53:44 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     pavel@ucw.cz, lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, andreas@kemnade.info,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Matti Vaittinen <mazziesaccount@gmail.com>
Subject: [PATCH v4 0/2] leds: Add a driver for the BD2606MVV
Date:   Fri, 14 Apr 2023 07:53:39 +0200
Message-Id: <20230414055341.335456-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0 (-)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the binding description and the corresponding driver for
the BD2606.

Changes in V4:
- minor tuning of description in bindings
 
Changes in V3:
- binding cleanup
- move active variable from long-living struct onto stack

Changes in V2:
- Add Datasheet link
- use fwnode api
- remove childnode count check, that will bail out
  anyways later.
- add enable-gpios to binding but not to driver due to lack of
  testing ability

Andreas Kemnade (2):
  dt-bindings: leds: Add ROHM BD2606MVV LED driver
  leds: bd2606mvv: Driver for the Rohm 6 Channel i2c LED driver

 .../bindings/leds/rohm,bd2606mvv.yaml         |  81 ++++++++++
 drivers/leds/Kconfig                          |  11 ++
 drivers/leds/Makefile                         |   1 +
 drivers/leds/leds-bd2606mvv.c                 | 143 ++++++++++++++++++
 4 files changed, 236 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/rohm,bd2606mvv.yaml
 create mode 100644 drivers/leds/leds-bd2606mvv.c

-- 
2.39.2

