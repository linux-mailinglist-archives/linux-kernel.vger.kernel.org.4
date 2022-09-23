Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BBA95E7440
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 08:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbiIWGiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 02:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiIWGiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 02:38:51 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78631280EE;
        Thu, 22 Sep 2022 23:38:49 -0700 (PDT)
X-UUID: 2fcd4526bd3345e9a0a65fc83988413f-20220923
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=JLVykaXDOlUyh8cNeSdQSaSgupPXu2DvwcPbFmC76aQ=;
        b=IFogwBWmi1RUHYBxEwF4ruH8905H8QRBo59ZL/7lsq9/YAeKLjCplQ0uhKF9J6Hw3oK9vk6Jrx7WTmLxVYhzGYtzJABweYGAM6OpJ6YVf34o75j8PWQ413A1nal8nkgLnVAmrk6smPsSrfKEY2VU2XQBnVnRNJLMFpZ1cr7mciw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:b57a91e6-101e-4aa3-a336-70a951be3e3e,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:45
X-CID-INFO: VERSION:1.1.11,REQID:b57a91e6-101e-4aa3-a336-70a951be3e3e,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:45
X-CID-META: VersionHash:39a5ff1,CLOUDID:b848c606-1cee-4c38-b21b-a45f9682fdc0,B
        ulkID:220923143847UXDWMQU0,BulkQuantity:0,Recheck:0,SF:28|17|19|48|823|824
        ,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL
        :0
X-UUID: 2fcd4526bd3345e9a0a65fc83988413f-20220923
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <jia-wei.chang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 724443049; Fri, 23 Sep 2022 14:38:44 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 23 Sep 2022 14:38:43 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Fri, 23 Sep 2022 14:38:43 +0800
Message-ID: <d9e56d6fb6a31ecbd024cfe81e331817fa492331.camel@mediatek.com>
Subject: Re: [PATCH] cpufreq: mediatek: Fix KP and lockups on proc/sram
 regulators error
From:   Jia-Wei Chang <jia-wei.chang@mediatek.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
CC:     <rafael@kernel.org>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <matthias.bgg@gmail.com>, <andrew-sh.cheng@mediatek.com>,
        <rex-bc.chen@mediatek.com>, <nfraprado@collabora.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Fri, 23 Sep 2022 14:38:43 +0800
In-Reply-To: <20220921071913.p7kwsjnnuad2jgvk@vireshk-i7>
References: <20220909093724.40078-1-angelogioacchino.delregno@collabora.com>
         <20220921071913.p7kwsjnnuad2jgvk@vireshk-i7>
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

On Wed, 2022-09-21 at 12:49 +0530, Viresh Kumar wrote:
> Jia, do you want to reply to this thread as the Fixes patch was added
> by you ?
> 
> On 09-09-22, 11:37, AngeloGioacchino Del Regno wrote:
> > Function regulator_get_optional() returns a negative error number
> > on
> > any kind of regulator_get() failure: failing to check for that in
> > the
> > teardown path will lead to a kernel panic due to a call to function
> > regulator_disable().
> 
> I don't see how this can happen. The code does check if the
> regulators
> are enabled earlier or not.
> 
Hi Angelo,

Could you help provide more details, like the call stack of kernel
panic? and how to reproduce this failure?

> > Besides that, the "proc" regulator does actually provide power to
> > the
> > CPU cluster(s): disabling it will produce a lockup on at least some
> > SoCs, such as MT8173.
> 
> We are just dropping the count that we increased earlier, how will
> that disable the regulator which was already enabled ?
> 
> > That consideration is also valid for the "sram" regulator,
> > providing
> > power to the CPU caches instead, present on some other SoCs, such
> > as
> > MT8183, MT8186 (and others).
> > 
> > Resolve both situations and by simply removing the entire faulty
> > branches responsible for disabling the aforementioned regulators if
> > enabled, keeping in mind that these are enabled (and left enabled)
> > by the bootloader before booting the kernel.
> 
> This looks fishy, we just keep on increasing the ref count of the
> regulator but never take it down.
> 
Angelo,

Do you mean the ref count of the regulator in the kernel will be
affected if that regulator is enabled earlier in the bootloader?

Thanks.

