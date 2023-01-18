Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A48AD671480
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 07:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbjARGq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 01:46:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjARG3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 01:29:18 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5761DB9F;
        Tue, 17 Jan 2023 22:20:44 -0800 (PST)
X-UUID: 3ab82f6e96f811eda06fc9ecc4dadd91-20230118
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=ssiHBlg9ViK4cAVSgimSmbQQJThFkTp/ayRhvOH0KqM=;
        b=qB38iEgssuub0qP7ZKdb9UscZ6XjbVmZxbWvfdS8lurobkDogPePTafZeYZ8VHITg4tCMVtGPJzz0+oYNjr3qOVtPMUnrlzvGVdpKvgK7JPB5YuSWgC76XxLOqGJB2e36V0tx5tZZbGEYdUQHSqtbr2Ubwfx6hshmsTBgqeNmlY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.18,REQID:de6120d4-8f0b-484f-a3b0-2b9ad0720a7d,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:3ca2d6b,CLOUDID:3be3fa54-dd49-462e-a4be-2143a3ddc739,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
X-CID-BVR: 0
X-UUID: 3ab82f6e96f811eda06fc9ecc4dadd91-20230118
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <guodong.liu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 623970952; Wed, 18 Jan 2023 14:20:39 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 18 Jan 2023 14:20:38 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 18 Jan 2023 14:20:37 +0800
From:   Guodong Liu <Guodong.Liu@mediatek.com>
To:     Sean Wang <sean.wang@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Light Hsieh <light.hsieh@mediatek.com>,
        Rob Herring <robh@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
CC:     <linux-mediatek@lists.infradead.org>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Guodong Liu <Guodong.Liu@mediatek.com>
Subject: [PATCH 0/2] MediaTek pinctrl cleanups and improvements
Date:   Wed, 18 Jan 2023 14:20:34 +0800
Message-ID: <20230118062036.26258-1-Guodong.Liu@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,MAY_BE_FORGED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 1. Fix coverity by initializing pullen and pullup as zero.
Coverity error message:
	This issue is detected by 
		Checker: UNINIT
		Type: Uninitialized scalar variable
	Defect is in:
		File: drivers/pinctrl/mediatek/pinctrl-paris.c
		Function and lines: 
				mtk_pctrl_show_one_pin:627
	CID 10350517 (#1 of 2): Uninitialized scalar variable (UNINIT)
	(7) uninit_use: Using uninitialized value pullen.
	                rsel = pullen;
	                pullen = 1;
	        } else {
	CID 10350553 (#1 of 1): Uninitialized scalar variable (UNINIT)
	(8) uninit_use_in_call: Using uninitialized value pullup when
	    calling scnprintf.
        len += scnprintf(buf + len, buf_len - len,
                        "%03d: %1d%1d%1d%1d%02d%1d%1d%1d%1d",
                        gpio,
                        pinmux,
                        mtk_pctrl_get_direction(hw, gpio),
                        mtk_pctrl_get_out(hw, gpio),
                        mtk_pctrl_get_in(hw, gpio),
                        mtk_pctrl_get_driving(hw, gpio),
                        mtk_pctrl_get_smt(hw, gpio),
                        mtk_pctrl_get_ies(hw, gpio),
                        pullen,
                        pullup);

Patch 2. Fix coverity by initializing *buf as zero.
Coverity error message:
	This issue is detected by 
		Checker: UNINIT
		Type: Uninitialized scalar variable
	Defect is in:
		File: drivers/pinctrl/mediatek/pinctrl-paris.c
		Function and lines: 
				mtk_pctrl_dbg_show
	static void mtk_pctrl_dbg_show(struct pinctrl_dev *pctldev,
				       struct seq_file *s,
				       unsigned int gpio)
	{
	        struct mtk_pinctrl *hw = pinctrl_dev_get_drvdata(pctldev);
        	(1) var_decl: Declaring variable buf without initializer.
	        char buf[PIN_DBG_BUF_SZ];

        	(void)mtk_pctrl_show_one_pin(hw, gpio, buf, PIN_DBG_BUF_SZ);

	CID 10801732 (#1 of 1): Uninitialized scalar variable (UNINIT)
	(2) uninit_use_in_call: Using uninitialized value *buf as argument to %s
	    when calling seq_printf.
	seq_printf(s, "%s", buf);

Guodong Liu (2):
  pinctrl: mediatek: Initialize variable pullen and pullup to zero
  pinctrl: mediatek: Initialize variable *buf to zero

 drivers/pinctrl/mediatek/pinctrl-paris.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.25.1

