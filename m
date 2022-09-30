Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8C5C5F0585
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 09:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbiI3HJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 03:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbiI3HJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 03:09:41 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E4E1DADE2;
        Fri, 30 Sep 2022 00:09:31 -0700 (PDT)
X-UUID: f863f3bb240a419cada6cce2638b3b20-20220930
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=nsg8SlBW4owAEbvckoVuWyxzCs2P4j+O1NyGMe8wsNY=;
        b=ay1Efn+HaoaIKi2pNAwYvSzCsVz7I9chgS4kpXi6AVpLAV4lbkn2O0i88S4wtCm37Y5nZnilX1SeePMkrV6cn7moKUsbjD+k++FbgZURo1TRi2hOpvZj18gLrGgIe96OtWWFmp+KP4BNqWB42ZuN+AwKvNqhFnGe6BIPGLuMLvs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:5ce28993-c91d-4b44-8bb4-370467fcfd93,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:39a5ff1,CLOUDID:d4698c07-1cee-4c38-b21b-a45f9682fdc0,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:-5,EDM:-3,IP:nil,
        URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: f863f3bb240a419cada6cce2638b3b20-20220930
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1424445941; Fri, 30 Sep 2022 15:09:26 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 30 Sep 2022 15:09:24 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 30 Sep 2022 15:09:24 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     <wenst@chromium.org>
CC:     <angelogioacchino.delregno@collabora.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <miles.chen@mediatek.com>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>
Subject: Re: [PATCH 3/6] clk: mediatek: mt8192: Do not re-register top_early_divs in probe function
Date:   Fri, 30 Sep 2022 15:09:24 +0800
Message-ID: <20220930070924.5020-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <CAGXv+5FLwrE-kiZ_opjB3NA=e2_tDoNUs6hKE-o9m_DXcQmcGA@mail.gmail.com>
References: <CAGXv+5FLwrE-kiZ_opjB3NA=e2_tDoNUs6hKE-o9m_DXcQmcGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,MAY_BE_FORGED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_CSS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On Wed, Sep 28, 2022 at 9:55 AM Miles Chen <miles.chen@mediatek.com> wrote:
>>
>> >> top_early_divs are registered in the CLK_OF_DECLARE_DRIVER() half of the
>> >> topckgen clk driver. Don't try to register it again in the actual probe
>> >> function. This gets rid of the "Trying to register duplicate clock ..."
>> >> warning.
>> >>
>> >> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
>> >
>> >Can't we simply remove the CLK_OF_DECLARE_DRIVER() and top_init_early entirely,
>> >and transfer TOP_CSW_F26M_D2 to top_divs[] instead?
>> >I get that systimer concern and we have something similar in MT8195, where the
>> >TOP_CLK26M_D2 is registered "late".
>>
>> Another reason for this:
>> Removing the CLK_OF_DECLARE_DRIVER() is good when we want to build our driver as
>> kernel modules because it does not work with kernel modules.
>
>I agree. But as I mentioned in my other reply, we need to fix the clock
>user first before dropping that clock. And there's also the matter of
>DT backward compatibility. So we need to do it incrementally.
>
>
>ChenYu

Got it. thanks for doing this.

thanks,
Miles
