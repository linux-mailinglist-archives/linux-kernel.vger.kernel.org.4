Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A21915F27B5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 04:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbiJCCsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 22:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiJCCsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 22:48:35 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519983CBC2;
        Sun,  2 Oct 2022 19:48:30 -0700 (PDT)
X-UUID: 919b954a1ee5423097d1341476326cae-20221003
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=2vONuU2pab5GQ7YgJJPuGj5E4IMi9T4UtvmYRBEDwIU=;
        b=uGVDvN+Ihjijrz0GHz3cwqueRPDjrvaJ3XtwrrToFKZVVd+Wiba8kknWUpgi6N0jzyId3P91IeqLWfd/zseYYuOKP04haPDYvlz3xvCxKl1yiTOqGBW/l4plW+UuKqlL8d+O9HwnB8WMUolb9mkqpx/NcV0B4ZK82HGxRm9ewU8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:f0594070-e85b-4cb3-97bc-be6780e43be7,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:45
X-CID-INFO: VERSION:1.1.11,REQID:f0594070-e85b-4cb3-97bc-be6780e43be7,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:45
X-CID-META: VersionHash:39a5ff1,CLOUDID:a3edf4e4-87f9-4bb0-97b6-34957dc0fbbe,B
        ulkID:220930201300B3TGD7D5,BulkQuantity:136,Recheck:0,SF:38|28|17|19|48|82
        3|824|102,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40,QS:nil,BEC
        :nil,COL:0
X-UUID: 919b954a1ee5423097d1341476326cae-20221003
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1715034978; Mon, 03 Oct 2022 10:48:20 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Mon, 3 Oct 2022 10:48:19 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 3 Oct 2022 10:48:19 +0800
Message-ID: <ff5ce171d32d70a939603ff700b44f140baab9c6.camel@mediatek.com>
Subject: Re: [PATCH v1 2/2] media: platform: mtk-mdp3: fix error handling
 about components clock_on
From:   moudy ho <moudy.ho@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
CC:     <linux-media@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Mon, 3 Oct 2022 10:48:19 +0800
In-Reply-To: <8afa9c8e-079e-6e50-a8d7-21e0b1698f76@collabora.com>
References: <20220930102306.13201-1-moudy.ho@mediatek.com>
         <20220930102306.13201-3-moudy.ho@mediatek.com>
         <8afa9c8e-079e-6e50-a8d7-21e0b1698f76@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_CSS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-09-30 at 14:12 +0200, AngeloGioacchino Del Regno wrote:
> Il 30/09/22 12:23, Moudy Ho ha scritto:
> > Add goto statement in mdp_comp_clock_on() to avoid error code not
> > being
> > propagated or returning positive values.
> > This change also performs a well-timed clock_off when an error
> > occurs, and
> > reduces unnecessary error logging in mdp_cmdq_send().
> > 
> > Fixes: 61890ccaefaf ("media: platform: mtk-mdp3: add MediaTek MDP3
> > driver")
> > Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
> > ---
> >   .../platform/mediatek/mdp3/mtk-mdp3-cmdq.c    |  4 +---
> >   .../platform/mediatek/mdp3/mtk-mdp3-comp.c    | 24
> > ++++++++++++++-----
> >   2 files changed, 19 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c
> > b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c
> > index e194dec8050a..124c1b96e96b 100644
> > --- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c
> > +++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c
> > @@ -433,10 +433,8 @@ int mdp_cmdq_send(struct mdp_dev *mdp, struct
> > mdp_cmdq_param *param)
> >   	cmd->mdp_ctx = param->mdp_ctx;
> >   
> >   	ret = mdp_comp_clocks_on(&mdp->pdev->dev, cmd->comps, cmd-
> > >num_comps);
> > -	if (ret) {
> > -		dev_err(dev, "comp %d failed to enable clock!\n", ret);
> > +	if (ret)
> >   		goto err_free_path;
> > -	}
> >   
> >   	dma_sync_single_for_device(mdp->cmdq_clt->chan->mbox->dev,
> >   				   cmd->pkt.pa_base, cmd-
> > >pkt.cmd_buf_size,
> > diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
> > b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
> > index d3eaf8884412..fe6a39315e88 100644
> > --- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
> > +++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
> > @@ -699,12 +699,22 @@ int mdp_comp_clock_on(struct device *dev,
> > struct mdp_comp *comp)
> >   			dev_err(dev,
> >   				"Failed to enable clk %d. type:%d
> > id:%d\n",
> >   				i, comp->type, comp->id);
> > -			pm_runtime_put(comp->comp_dev);
> > -			return ret;
> > +			goto err_unwind;
> >   		}
> >   	}
> >   
> >   	return 0;
> > +
> > +err_unwind:
> 
> For this label to be clearer, I would rename it as `err_revert`, or
> `clocks_off`, or even simply `err`, as the `unwind` word may create
> some confusion here.
> 

Hi Angelo,

Thanks for the suggestion to rename to "err_revert" and make the flow
more readable.
I will correct it in the next version.

Regards,
Moudy

> > +	while (--i >= 0) {
> > +		if (IS_ERR_OR_NULL(comp->clks[i]))
> > +			continue;
> > +		clk_disable_unprepare(comp->clks[i]);
> > +	}
> > +	if (comp->comp_dev)
> > +		pm_runtime_put_sync(comp->comp_dev);
> > +
> > +	return ret;
> >   }
> >   
> >   void mdp_comp_clock_off(struct device *dev, struct mdp_comp
> > *comp)
> > @@ -723,11 +733,13 @@ void mdp_comp_clock_off(struct device *dev,
> > struct mdp_comp *comp)
> >   
> >   int mdp_comp_clocks_on(struct device *dev, struct mdp_comp
> > *comps, int num)
> >   {
> > -	int i;
> > +	int i, ret;
> >   
> > -	for (i = 0; i < num; i++)
> > -		if (mdp_comp_clock_on(dev, &comps[i]) != 0)
> > -			return ++i;
> > +	for (i = 0; i < num; i++) {
> > +		ret = mdp_comp_clock_on(dev, &comps[i]);
> > +		if (ret)
> > +			return ret;
> > +	}
> >   
> >   	return 0;
> >   }
> > 

