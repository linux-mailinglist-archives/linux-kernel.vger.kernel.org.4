Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEAEC5E7311
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 06:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbiIWEk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 00:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbiIWEkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 00:40:07 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6968715FE6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 21:39:58 -0700 (PDT)
X-UUID: 487a28df31454b88850da2e2ac74aa34-20220923
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=1KZyGx1JqtxeTxG8MfIi+v7uhwTWWMglV+1MnUR2ayE=;
        b=TdXRbfZ/8IpUgA+lgxgn3KDZv+0j7EA5CWlc4TohCN8q+rZHaFNgrEY7V+31LDmlQrDDAODk9tPs7vKTjb8uosN+bowdeTcGP3dXobFf0JJWKfBEgtkEbWWOTcUzeov0ZfCj3qbXbrBvzFeJmxO3xusmM7zq42IjKXLmPmyPWOo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:b6a5756d-ad41-4351-8341-83706ac362ae,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:28,RULE:Release_Ham,ACTIO
        N:release,TS:73
X-CID-INFO: VERSION:1.1.11,REQID:b6a5756d-ad41-4351-8341-83706ac362ae,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:28,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:73
X-CID-META: VersionHash:39a5ff1,CLOUDID:5370d0a2-dc04-435c-b19b-71e131a5fc35,B
        ulkID:220922192633HYJZ5STC,BulkQuantity:204,Recheck:0,SF:28|17|19|48|823|8
        24,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40|20,QS:nil,BEC:nil
        ,COL:0
X-UUID: 487a28df31454b88850da2e2ac74aa34-20220923
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1142852460; Fri, 23 Sep 2022 12:39:55 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 23 Sep 2022 12:39:54 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Fri, 23 Sep 2022 12:39:54 +0800
Message-ID: <978af4cc1a8bfa92675bb201947cfdac1e5429f1.camel@mediatek.com>
Subject: Re: [PATCH] ASoC: mediatek: mt8195-mt6359: Use snd_soc_pm_ops
 instead of custom ops
From:   Trevor Wu <trevor.wu@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Mark Brown <broonie@kernel.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <tiwai@suse.com>, <lgirdwood@gmail.com>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Fri, 23 Sep 2022 12:39:54 +0800
In-Reply-To: <ce4a6e7f-dee3-c260-bd42-bc77927916e8@collabora.com>
References: <20220922103502.49981-1-angelogioacchino.delregno@collabora.com>
         <YyxGXXSp2JD9a6ah@google.com> <YyxjZ9nCBdVovkVs@sirena.org.uk>
         <ce4a6e7f-dee3-c260-bd42-bc77927916e8@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_CSS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-09-22 at 16:10 +0200, AngeloGioacchino Del Regno wrote:
> Il 22/09/22 15:30, Mark Brown ha scritto:
> > On Thu, Sep 22, 2022 at 07:26:21PM +0800, Tzung-Bi Shih wrote:
> > 
> > > snd_soc_pm_ops[1] sets some more fields.  I'm not quite sure
> > > whether
> > > it would introduce any side effect or not.  Perhaps Trevor could
> > > provide some suggestions.
> > 
> > If it does it should be to fix isues rather than introduce new
> > problems - I suspect the other operations just don't work
> > currently.
> 
>  From my upstream tests, this didn't introduce any issues, that's why
> I've
> sent this patch.
> 
> In any case, let's check with Trevor, just as to be extremely sure,
> but please
> use an upstream kernel for eventual tests, as there are quite a bit
> of changes
> between 5.10 and current upstream.
> 
> Cheers,
> Angelo

I think it's not a big risk if Angelo already did the test and
snd_soc_pm_ops is also used in MT8186.
I can help do more tests on 5.10 when the patch is back to chromium in
the future.
MTK also have a plan to support complete suspend/resume functionality
in MT8195. If Tzung-bi has concerns about the patch, I can help submit
the patch at the time.

Thanks,
Trevor

