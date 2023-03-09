Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A613A6B1FE0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 10:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjCIJWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 04:22:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbjCIJVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 04:21:49 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBDBCDB49B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 01:21:41 -0800 (PST)
X-UUID: cb63d448be5b11eda06fc9ecc4dadd91-20230309
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=u2Y+lndMZvPCQFgYhF0b5tZdi1oGwpOpzR4P4QFlUvU=;
        b=BnDhUGjzF8CCzeA3lNqrcX1LrXqVy9KEB7JxDMAy+kevwMJ404aguWjTCCmL6YPQIPnUBF46LMYNLUpCP6RD1Kypvg3/+kLXo/hbyVFF2NEsHatZ3s0uqBMgkUr6oJ/A3/VrnFSD0rM//qGO9/pkOfwoeDmrVgMzu1OSrcDdKLM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.20,REQID:fe97114d-fcb0-4547-acde-789eb8b9fc75,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:45
X-CID-INFO: VERSION:1.1.20,REQID:fe97114d-fcb0-4547-acde-789eb8b9fc75,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:45
X-CID-META: VersionHash:25b5999,CLOUDID:141246f5-ddba-41c3-91d9-10eeade8eac7,B
        ulkID:230308155434OUYWJX05,BulkQuantity:35,Recheck:0,SF:29|28|17|19|48|102
        ,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL:
        0,OSI:0,OSA:0,AV:0
X-CID-BVR: 1,FCT|NGT
X-UUID: cb63d448be5b11eda06fc9ecc4dadd91-20230309
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <haibo.li@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 442448829; Thu, 09 Mar 2023 17:21:38 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Thu, 9 Mar 2023 17:21:36 +0800
Received: from mszsdtlt102.gcn.mediatek.inc (10.16.4.142) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Thu, 9 Mar 2023 17:21:36 +0800
From:   Haibo Li <haibo.li@mediatek.com>
To:     <elver@google.com>
CC:     <angelogioacchino.delregno@collabora.com>, <dvyukov@google.com>,
        <haibo.li@mediatek.com>, <kasan-dev@googlegroups.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <mark.rutland@arm.com>,
        <matthias.bgg@gmail.com>, <will@kernel.org>,
        <xiaoming.yu@mediatek.com>
Subject: Re: [PATCH] kcsan:fix alignment_fault when read unaligned instrumented memory
Date:   Thu, 9 Mar 2023 17:21:36 +0800
Message-ID: <20230309092136.35799-1-haibo.li@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CANpmjNNw6utf5ozpwu1keDG92Ew_vL6B=LZoRw12p48eVJeNnw@mail.gmail.com>
References: <CANpmjNNw6utf5ozpwu1keDG92Ew_vL6B=LZoRw12p48eVJeNnw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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

> =0D
> On Thu, 9 Mar 2023 at 01:58, 'Haibo Li' via kasan-dev=0D
> <kasan-dev@googlegroups.com> wrote:=0D
> [...]=0D
> >=0D
> > The below patch works well on linux-5.15+arm64.=0D
> =0D
> Thank you, glad to hear - may I add your Tested-by?=0D
=0D
Sure.Appreciated.=0D
