Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C178702E10
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 15:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241850AbjEON1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 09:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242106AbjEON1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 09:27:01 -0400
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0BA1B7;
        Mon, 15 May 2023 06:26:58 -0700 (PDT)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1pyYDQ-0003Bx-34;
        Mon, 15 May 2023 13:26:18 +0000
Date:   Mon, 15 May 2023 15:23:27 +0200
From:   Daniel Golle <daniel@makrotopia.org>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Peter Chiu <chui-hao.chiu@mediatek.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Frank Wunderlich <frank-w@public-files.de>,
        Alexander Couzens <lynxis@fe80.eu>,
        Sujuan Chen <sujuan.chen@mediatek.com>,
        Bo Jiao <bo.jiao@mediatek.com>,
        Nicolas Cavallari <nicolas.cavallari@green-communications.fr>,
        Howard Hsu <howard-yh.hsu@mediatek.com>,
        MeiChia Chiu <MeiChia.Chiu@mediatek.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Wang Yufen <wangyufen@huawei.com>,
        Lorenz Brun <lorenz@brun.one>, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 0/2] wifi: mt76: mt7915: add support for MT7981
Message-ID: <cover.1684155848.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the MediaTek MT7981 SoC which is similar to the MT7986
but with a newer IP cores and only 2x ARM Cortex-A53 instead of 4x.
Unlike MT7986 the MT7981 can only connect a single wireless frontend,
usually MT7976 is used for DBDC.
To distinguish the MT7981 Wi-Fi MAC, add new device tree compatible
'mediatek,mt7981-wmac'.

Changes since v1:
 * rename mt7986_* to mt798x_* where appropriate
 * WARN_ON(1) if neither is_mt7981() nor is_mt7986() returns true
 * add device tree bindings for mediatek,mt7981-wmac

Alexander Couzens (1):
  wifi: mt76: mt7915: add support for MT7981

Daniel Golle (1):
  dt-bindings: net: wireless: mt76: add bindings for MT7981

 .../bindings/net/wireless/mediatek,mt76.yaml  |   1 +
 .../net/wireless/mediatek/mt76/mt76_connac.h  |  10 ++
 .../net/wireless/mediatek/mt76/mt7915/Kconfig |   6 +-
 .../wireless/mediatek/mt76/mt7915/Makefile    |   2 +-
 .../wireless/mediatek/mt76/mt7915/coredump.c  |   7 +-
 .../net/wireless/mediatek/mt76/mt7915/dma.c   |   6 +-
 .../wireless/mediatek/mt76/mt7915/eeprom.c    |   7 +-
 .../net/wireless/mediatek/mt76/mt7915/init.c  |   6 +-
 .../net/wireless/mediatek/mt76/mt7915/mac.c   |   2 +-
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   |   3 +
 .../net/wireless/mediatek/mt76/mt7915/mmio.c  |  17 +-
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  14 +-
 .../net/wireless/mediatek/mt76/mt7915/regs.h  |  13 +-
 .../net/wireless/mediatek/mt76/mt7915/soc.c   | 162 ++++++++++++------
 14 files changed, 180 insertions(+), 76 deletions(-)


base-commit: 0d9b41daa5907756a31772d8af8ac5ff25cf17c1
-- 
2.40.1

