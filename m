Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3C65B93E4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 07:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbiIOFTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 01:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiIOFTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 01:19:19 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE379323A
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 22:19:14 -0700 (PDT)
X-UUID: eaee028f665b40e8ad518f2ce0622054-20220915
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:CC:To:Subject:From:MIME-Version:Date:Message-ID; bh=I/eK0cfbxCIDrkJpxpNUKq8DfD7I1QFLOHC7/nfS/3o=;
        b=dmn+CBxXltA8CLcFtZ+rGyEmzcSV/fz6VPlKGKEU4uGf0I95H5KjWcHIsiK64cmMthWvfM6s6q9T5yKGzV84EVyZMOgTaQfxIBeMSMebcmHdeGXR7iakLsVY0YLnfS/aMGTXOmwnVTcg4v2iMDim1wcYC/8UFKyT/3bLt6Fo0+o=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:60b2e5e1-0c7d-47f8-9011-4f681b75e465,IP:0,U
        RL:25,TC:0,Content:-5,EDM:0,RT:0,SF:45,FILE:0,BULK:28,RULE:Release_Ham,ACT
        ION:release,TS:93
X-CID-INFO: VERSION:1.1.11,REQID:60b2e5e1-0c7d-47f8-9011-4f681b75e465,IP:0,URL
        :25,TC:0,Content:-5,EDM:0,RT:0,SF:45,FILE:0,BULK:28,RULE:Spam_GS981B3D,ACT
        ION:quarantine,TS:93
X-CID-META: VersionHash:39a5ff1,CLOUDID:fc4fb37b-ea28-4199-b57e-003c7d60873a,B
        ulkID:220914161747OE9HJACH,BulkQuantity:69,Recheck:0,SF:28|17|19|48,TC:nil
        ,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:40|20,QS:nil,BEC:nil,COL:0
X-UUID: eaee028f665b40e8ad518f2ce0622054-20220915
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 76293047; Thu, 15 Sep 2022 13:19:05 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 15 Sep 2022 13:19:03 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Thu, 15 Sep 2022 13:19:03 +0800
Message-ID: <03cb748c-4531-9669-faac-7e975855149d@mediatek.com>
Date:   Thu, 15 Sep 2022 13:19:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
From:   Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Subject: Re: [PATCH] drm: mediatek: Fix display vblank timeout when disable
 dsi
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
CC:     Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?UTF-8?B?WGlubGVpIExlZSAo5p2O5piV56OKKQ==?= 
        <Xinlei.Lee@mediatek.com>,
        =?UTF-8?B?QWxsZW4tS0ggQ2hlbmcgKOeoi+WGoOWLsyk=?= 
        <Allen-KH.Cheng@mediatek.com>
References: <1663136309-29491-1-git-send-email-xinlei.lee@mediatek.com>
 <0723c329-475c-42a1-f6d5-f478d649aef1@collabora.com>
 <64bf6d7b-5a28-9b7d-fc3e-4c3c8eaa7d25@mediatek.com>
 <3dd03eea-84cf-73bc-0bd4-3450c44ac8ba@collabora.com>
Content-Language: en-US
In-Reply-To: <3dd03eea-84cf-73bc-0bd4-3450c44ac8ba@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,
        URIBL_CSS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi maintainer,

Patch v2 has been sent to [1].

[1]
https://patchwork.kernel.org/project/linux-mediatek/patch/20220914140031.18578-1-allen-kh.cheng@mediatek.com/

I'm sorry I didn't reply to all the email lists in the initial reply.

Below is the most recent information.

Thanks,
Allen

On 9/14/22 21:34, AngeloGioacchino Del Regno wrote:
> Il 14/09/22 15:30, Allen-KH Cheng ha scritto:
>> Hi Angelo,
>>
>> It's mt8186 corsola board. When this problem arises in system
>> susepend/resume, we have your fix[1] in our dsi driver.
>>
>> Because there is a conflict in mediatek-drm-fixes,
>> kernel/git/chunkuang.hu/linux.git.
>>
>> I'll assist Xinlei with another resend.
>>
>
> Ok, thanks for confirming!
>
> Cheers,
> Angelo
>
