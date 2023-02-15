Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7945B69821A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 18:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjBORcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 12:32:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjBORc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 12:32:28 -0500
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58CFD3B0C0;
        Wed, 15 Feb 2023 09:32:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1676482320; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=lWVu/79ca+93h6jMeSMlnFeeBVM7mvnPj8rL1DQE2H0erZKkUZQkJFj8TD7PR/UQtc
    AME7VGWtS7sS7cnAkq8hn6XjQ6zRcc2Vp2lBvfPqddyhF7l+yPpYNsZj5vr+PpDdSDiy
    hHxDiqja4ghxfsyc1DcxzCYiSMHd87XyQZ9PK0YFriWzXZHPszP6AMZe6ntHhIOzrRcr
    /6I6syrvGT2aFMuvLjdZjdf8jai7rdGYt50JoiF11YLqGrdBqXwG+ATaS9UJDV3g4zJM
    yakbIiKbk15hTizbw0zp0NElvlcv5iZvyQN9Wq53uiHdAzM/T1YVtaAC2va0HhTuduaE
    nGTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1676482320;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=bbHmsUjBPSu5l9/TxHE+oHyJRc0agWyhyIiPL5eQgSs=;
    b=D4a+GO0n0EYgIDcjiFWfce2rARO8keGb7eVzogKNh83Z+18Wv6wWqVsd1WAqec/Kf+
    bsUslEj752Zo3BCxBq9+FIpRo1rIMw7JF+uJeKh+17Z1RDLr2OQBf8KVaYoWiUD//7KA
    8eTvC8nT6SoJKY/qVjj28/W1zpyzqOIHGCNXvWNAFGp3zzggmcRt3LZG3FQaAtnvSYi+
    wVMyAizGTkGOwBdhiR+XbhwkoNeZ/Xqrd89jJwHtTFCfSHzxRBY2uOELRxrN3WOPtALN
    GGUcBIUWGqsdUkMj5mq6prB8ux+1vNa5Adg8+i5QTMOg0trlJAWcPyixWk9YFRXTJ+Ex
    b2Qg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1676482320;
    s=strato-dkim-0002; d=goldelico.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=bbHmsUjBPSu5l9/TxHE+oHyJRc0agWyhyIiPL5eQgSs=;
    b=qZUkv5MmC6X6qSsnaKNKmqBmFYozWJvR0TJJRr0pgBCjmQB66sBKXA86TrgvHnuugJ
    H15eaqaGNpy+IBm2s8j7ncI31iHXycT2psq49YNkkgHtfkFnF+vLkTB/w9fA3R3QdpUK
    jdGJ9JZozuRRZUMtb6u+Zw6x3Ick1iQCkwiYerXKpLNpxd7p54EZFixNQoFLFGYL35c5
    LfDlVYdqh1SEFuriz9bV++ZWuzSwN0by9NSSzNgwIOKXiauhyR5T5d6pJbOHX2fIrbiU
    P0g/nztd3C2tTSTlWsc7BhZxWfTL869uYnCnP0gCACvoFGatpy6AhT55L8cXbSSVkJIT
    7oqA==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1iTDUhfN4hi3qVZrWLJ"
Received: from iMac.fritz.box
    by smtp.strato.de (RZmta 49.3.0 DYNA|AUTH)
    with ESMTPSA id 326d57z1FHVxZCO
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 15 Feb 2023 18:31:59 +0100 (CET)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     Paul Cercueil <paul@crapouillou.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     riccardo Mottola <riccardo.mottola@libero.it>, paul@boddie.org.uk,
        linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
        kernel@pyra-handheld.com,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [RFC 0/3] Make WLAN and Bluetooth basically work for CI20
Date:   Wed, 15 Feb 2023 18:31:55 +0100
Message-Id: <cover.1676482318.git.hns@goldelico.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RFC V1 2023-02-15 18:31:58:
With the applied patch

rtc: jz4740: Register clock provider for the CLK32K pin

by Paul Cercueil <paul@crapouillou.net> it is now possible to make the
CI20 WiFi and Bluetooth setup do something reasonable.

This series adds #clock-cells to the jz4780 and fixes the device tree for
the CI20. It contains two ugly workarounds since BL_WAKE and WL_WAKE can not
be controlled as shutdown-gpios or device-wakeup-gpios by the drivers.
We also update the power setup and sequencing and add a clock chain for
the 32 kHz clock.
Finally, we enable some required CONFIGs for the CI20.

Tested on CI20 with v6.2-rc6.

H. Nikolaus Schaller (3):
  MIPS: DTS: jz4780: add #clock-cells to rtc_dev
  MIPS: DTS: CI20: fixes for WiFi/Bluetooth
  MIPS: configs: ci20: enable drivers we need for WiFi/Bluetooth

 arch/mips/boot/dts/ingenic/ci20.dts    | 77 ++++++++++++++++++++++----
 arch/mips/boot/dts/ingenic/jz4780.dtsi |  2 +
 arch/mips/configs/ci20_defconfig       | 18 +++++-
 3 files changed, 84 insertions(+), 13 deletions(-)

-- 
2.38.1

