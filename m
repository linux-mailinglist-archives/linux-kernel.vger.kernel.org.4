Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 624FA6651F2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 03:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233501AbjAKCmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 21:42:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjAKCmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 21:42:52 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D73B85D
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 18:42:50 -0800 (PST)
X-UUID: a06154ca915911eda06fc9ecc4dadd91-20230111
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=JDatIFGfCYDp40epyQ6cVCFAB9XyGy7+db3Lps22ypY=;
        b=K+eRFK5b+Hb5DiyH9QVfdfzrxad3Q4ezcrin+70nVY80m2tkYnAgUEQjuCtH6BCav/ECUz2YjQaspnYgXU/HkZ1DgqZwSxZ+RjKq1jEENwJpLcbmS6/Nq4fvw9z4Of8TjHTrCWJKRaN7QEPYS7Wlj7HroA24mQSpz3UFfp6Qvz8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.17,REQID:ddbc5802-95eb-489c-b894-52bc26157e72,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:543e81c,CLOUDID:3c8f4a54-dd49-462e-a4be-2143a3ddc739,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
X-CID-BVR: 1,FCT
X-UUID: a06154ca915911eda06fc9ecc4dadd91-20230111
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1847046328; Wed, 11 Jan 2023 10:42:44 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Wed, 11 Jan 2023 10:42:44 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 11 Jan 2023 10:42:44 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     <angelogioacchino.delregno@collabora.com>
CC:     <airlied@gmail.com>, <chunkuang.hu@kernel.org>, <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <miles.chen@mediatek.com>, <p.zabel@pengutronix.de>
Subject: Re: [PATCH] drm/mediatek: stop using 0 as NULL pointer
Date:   Wed, 11 Jan 2023 10:42:44 +0800
Message-ID: <20230111024244.24295-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <7cc4fe44-55b9-a80f-27a5-197070759760@collabora.com>
References: <7cc4fe44-55b9-a80f-27a5-197070759760@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Angelo,

>Il 10/01/23 04:12, Miles Chen ha scritto:
>> Use NULL for NULL pointer to fix the following sparse warning:
>> drivers/gpu/drm/mediatek/mtk_drm_gem.c:265:27: sparse: warning: Using plain integer as NULL pointer
>> 
>> Signed-off-by: Miles Chen <miles.chen@mediatek.com>
>
>Please add the appropriate tag...
>
>Fixes: 3df64d7b0a4f ("drm/mediatek: Implement gem prime vmap/vunmap function")

No problem, I will add the Fixes tag and submit v2.

thanks,
Miles

>
>after which:
>
>Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



