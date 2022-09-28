Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32C875ED2D4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 03:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbiI1BzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 21:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232084AbiI1BzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 21:55:17 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71BF012A498;
        Tue, 27 Sep 2022 18:55:13 -0700 (PDT)
X-UUID: 56581198f8804c66ad9867f9bce5d267-20220928
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Q+fSEED8koFMBB0jhsQvQ1pjxAX/BH3bjI3pxMvhkOY=;
        b=kvqbjCwTZkhD8fLHDJ89Tpy1GezdmvKZ0bsJr8r5aZVfWFaPWsSOHsX5g6Uzs905e8Z2HgSoICMeaGdOjqXOSU8qVDBOGfPXSR5Caf9DdrxTCH//LiJqvnnLxxhutySTL3WnVVWAAb/lRnrkynBwxVqhGLsx3S3hAvt/vhYgd4o=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:4f0ea6a4-0693-47ab-8eb9-f31fe0b748e8,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:45
X-CID-INFO: VERSION:1.1.11,REQID:4f0ea6a4-0693-47ab-8eb9-f31fe0b748e8,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:45
X-CID-META: VersionHash:39a5ff1,CLOUDID:ab253d07-1cee-4c38-b21b-a45f9682fdc0,B
        ulkID:220928095508MKCOI7IO,BulkQuantity:0,Recheck:0,SF:28|17|19|48|102,TC:
        nil,Content:-5,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 56581198f8804c66ad9867f9bce5d267-20220928
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1738987356; Wed, 28 Sep 2022 09:55:08 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 28 Sep 2022 09:55:06 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 28 Sep 2022 09:55:06 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     <angelogioacchino.delregno@collabora.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <miles.chen@mediatek.com>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <wenst@chromium.org>
Subject: Re: [PATCH 3/6] clk: mediatek: mt8192: Do not re-register top_early_divs in probe function
Date:   Wed, 28 Sep 2022 09:55:07 +0800
Message-ID: <20220928015507.17206-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <0a1618c4-b808-56bd-e89f-560b0423191d@collabora.com>
References: <0a1618c4-b808-56bd-e89f-560b0423191d@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SORTED_RECIPS,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY,URIBL_CSS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> top_early_divs are registered in the CLK_OF_DECLARE_DRIVER() half of the
>> topckgen clk driver. Don't try to register it again in the actual probe
>> function. This gets rid of the "Trying to register duplicate clock ..."
>> warning.
>> 
>> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
>
>Can't we simply remove the CLK_OF_DECLARE_DRIVER() and top_init_early entirely,
>and transfer TOP_CSW_F26M_D2 to top_divs[] instead?
>I get that systimer concern and we have something similar in MT8195, where the
>TOP_CLK26M_D2 is registered "late".

Another reason for this:
Removing the CLK_OF_DECLARE_DRIVER() is good when we want to build our driver as
kernel modules because it does not work with kernel modules.

thanks,
Miles
>
>Getting back to MT8192, TOP_CSW_F26M_D2 seems to be used only for:
>1. systimer
>2. SPMI MST (registered "late").
>
>Being it a fixed factor clock, parented to another fixed clock, it doesn't
>even have any ON/OFF switch, so I think it would be actually possible to go
>for the proposed removal... which would further improve this cleanup.
>
>Regards,
>Angelo
>
