Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB7066545F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 07:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbjAKGJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 01:09:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231713AbjAKGJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 01:09:23 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F35EDF32
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 22:09:16 -0800 (PST)
X-UUID: 78094772917611eda06fc9ecc4dadd91-20230111
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=i65n54Pntj3LMiHk0kDTcKGqGuncnAshkJdAZpuEpWA=;
        b=nvfoG21pOh2CcD9c3C/hTaCva/8FDgfUp43AjNHK3Va/SdJ7arP2NqyWh60WOeP3QW2yVJ69MgSySQhkydajWuLElIOiPd9tjL0EqgTE8eEZxX/ltVTphgE1TiTIvJPcrivZBqqQ43ugnsgNBJgpNs2GpQHP5f2yrW6NcWgcjlg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.17,REQID:471b37f3-1b2e-45f4-9db0-7ea402555533,IP:0,U
        RL:0,TC:0,Content:9,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:54
X-CID-INFO: VERSION:1.1.17,REQID:471b37f3-1b2e-45f4-9db0-7ea402555533,IP:0,URL
        :0,TC:0,Content:9,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:54
X-CID-META: VersionHash:543e81c,CLOUDID:2c7e5054-dd49-462e-a4be-2143a3ddc739,B
        ulkID:230111140913KY6GPHWI,BulkQuantity:0,Recheck:0,SF:28|17|19|48|102,TC:
        nil,Content:4,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:
        0,OSI:0,OSA:0
X-CID-APTURL: Status:success,Category:nil,Trust:0,Unknown:0,Malicious:0
X-CID-BVR: 0,NGT
X-UUID: 78094772917611eda06fc9ecc4dadd91-20230111
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <yf.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 553618668; Wed, 11 Jan 2023 14:09:12 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Wed, 11 Jan 2023 14:09:11 +0800
Received: from mbjsdccf07.mediatek.inc (10.15.20.246) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 11 Jan 2023 14:09:10 +0800
From:   <yf.wang@mediatek.com>
To:     <robin.murphy@arm.com>
CC:     <Libo.Kang@mediatek.com>, <Ning.Li@mediatek.com>,
        <iommu@lists.linux.dev>, <jianjiao.zeng@mediatek.com>,
        <joro@8bytes.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <will@kernel.org>, <wsd_upstream@mediatek.com>,
        <yf.wang@mediatek.com>, <yong.wu@mediatek.com>
Subject: RE: [PATCH] iommu/iova: Fix alloc iova overflows issue
Date:   Wed, 11 Jan 2023 13:57:49 +0800
Message-ID: <20230111055749.11519-1-yf.wang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <99695d77-e54f-3270-ee9a-9b3cbb3296e5@arm.com>
References: <99695d77-e54f-3270-ee9a-9b3cbb3296e5@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-01-09 at 11:47 +0000, Robin Murphy wrote:
> On 2023-01-09 08:34, yf.wang@mediatek.com wrote:
> > From: Yunfei Wang <yf.wang@mediatek.com>
> > 
> > In __alloc_and_insert_iova_range, there is an issue that retry_pfn
> > overflows. The value of iovad->anchor.pfn_hi is ~0UL, then when
> > iovad->cached_node is iovad->anchor, curr_iova->pfn_hi + 1 will
> > overflow. As a result, if the retry logic is executed, low_pfn is
> > updated to 0, and then new_pfn < low_pfn returns false to make the
> > allocation successful.
> > 
> > This issue occurs in the following two situations:
> > 1. The first iova size exceeds the domain size. When initializing
> > iova domain, iovad->cached_node is assigned as iovad->anchor. For
> > example, the iova domain size is 10M, start_pfn is 0x1_F000_0000,
> > and the iova size allocated for the first time is 11M. The
> > following is the log information, new->pfn_lo is smaller than
> > iovad->cached_node.
> > 
> > Example log:
> > [  223.798112][T1705487] sh:
> > [name:iova&]__alloc_and_insert_iova_range
> > start_pfn:0x1f0000,retry_pfn:0x0,size:0xb00,limit_pfn:0x1f0a00
> > [  223.799590][T1705487] sh:
> > [name:iova&]__alloc_and_insert_iova_range
> > success start_pfn:0x1f0000,new->pfn_lo:0x1efe00,new-
> > >pfn_hi:0x1f08ff
> > 
> > 2. The node with the largest iova->pfn_lo value in the iova domain
> > is deleted, iovad->cached_node will be updated to iovad->anchor,
> > and then the alloc iova size exceeds the maximum iova size that can
> > be allocated in the domain.
> > 
> > Adding judgment that retry_pfn must be greater than iovad-
> > >start_pfn
> > can fix this issue.
> 
> Hmm, indeed that's a sneaky little bug - thanks for the thorough 
> analysis - but couldn't we avoid the overflow entirely? I don't have
> the 
> complete logic paged in, but superficially it seems like:
> 
> 	retry_pfn = curr_iova->pfn_hi;
> 	...
> 		retry_pfn <= limit_pfn
> 	...
> 		low_pfn = retry_pfn + 1;
> 
> should still work, shouldn't it?
> 
> Thanks,
> Robin.
> 

Hi Robin,
Thanks for your suggestion, your solution is more perfect,
PATCH v2 version will modify it.

Thanks,
Yunfei.

> > Signed-off-by: jianjiao zeng <jianjiao.zeng@mediatek.com>
> > Signed-off-by: Yunfei Wang <yf.wang@mediatek.com>
> > ---
> >   drivers/iommu/iova.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> > index a44ad92fc5eb..0073206c2a95 100644
> > --- a/drivers/iommu/iova.c
> > +++ b/drivers/iommu/iova.c
> > @@ -209,7 +209,8 @@ static int __alloc_and_insert_iova_range(struct
> > iova_domain *iovad,
> >   	} while (curr && new_pfn <= curr_iova->pfn_hi && new_pfn >=
> > low_pfn);
> >   
> >   	if (high_pfn < size || new_pfn < low_pfn) {
> > -		if (low_pfn == iovad->start_pfn && retry_pfn <
> > limit_pfn) {
> > +		if (low_pfn == iovad->start_pfn &&
> > +		    retry_pfn >= iovad->start_pfn && retry_pfn <
> > limit_pfn) {
> >   			high_pfn = limit_pfn;
> >   			low_pfn = retry_pfn;
> >   			curr = iova_find_limit(iovad, limit_pfn);
