Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F0C6E444A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 11:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbjDQJr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 05:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbjDQJrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 05:47:55 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5268E449F
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 02:47:13 -0700 (PDT)
X-UUID: c0b0b6cadd0411edb6b9f13eb10bd0fe-20230417
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=NKCkdEg5aJ3JRFS1sh5Igra4N928b73FCh4yQqzNjv4=;
        b=jtfTwGqREXCUrVwa22WUWAw6bMPxl8f++eVgFFmbJ64h/w8eqoupY/MrIBUSezYDoVAJQgZawPVDh4iXW8Me2fI0zyxBda9yJfulWbLvQliwGFi3nGTX4Wu1iBJWyANYSSAA+kQl7mLaa/SXCdjPEiRU9TIgVnnQKhS8IM4qQTg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:4ccfdc7f-7865-4523-a7d3-3899769cc100,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:45
X-CID-INFO: VERSION:1.1.22,REQID:4ccfdc7f-7865-4523-a7d3-3899769cc100,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:45
X-CID-META: VersionHash:120426c,CLOUDID:d75b38eb-db6f-41fe-8b83-13fe7ed1ef52,B
        ulkID:230417174640ZUEAK35S,BulkQuantity:0,Recheck:0,SF:28|17|19|48|29|102,
        TC:nil,Content:0|-5,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:ni
        l,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 1,FCT|NGT
X-CID-BAS: 1,FCT|NGT,0,_
X-UUID: c0b0b6cadd0411edb6b9f13eb10bd0fe-20230417
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <haibo.li@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 760056862; Mon, 17 Apr 2023 17:46:40 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Mon, 17 Apr 2023 17:46:38 +0800
Received: from mszsdtlt102.gcn.mediatek.inc (10.16.4.142) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Mon, 17 Apr 2023 17:46:38 +0800
From:   Haibo Li <haibo.li@mediatek.com>
To:     <linus.walleij@linaro.org>
CC:     <a.anurag@samsung.com>, <alexander.sverdlin@nokia.com>,
        <amergnat@baylibre.com>, <angelogioacchino.delregno@collabora.com>,
        <ardb@kernel.org>, <catalin.marinas@arm.com>,
        <haibo.li@mediatek.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux@armlinux.org.uk>,
        <matthias.bgg@gmail.com>, <rmk+kernel@armlinux.org.uk>,
        <xiaoming.yu@mediatek.com>
Subject: Re: [PATCH v3] ARM:unwind:fix unwind abort for uleb128 case
Date:   Mon, 17 Apr 2023 17:46:38 +0800
Message-ID: <20230417094638.153213-1-haibo.li@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CACRpkdZf0vQL9bJtGaKfn0wBPTQTZWsg0G7UTB1dmXhfi_2KmA@mail.gmail.com>
References: <CACRpkdZf0vQL9bJtGaKfn0wBPTQTZWsg0G7UTB1dmXhfi_2KmA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, Apr 14, 2023 at 8:10 AM Haibo Li <haibo.li@mediatek.com> wrote:=0D
> =0D
> > When unwind instruction is 0xb2,the subsequent instructions are=0D
> > uleb128 bytes.=0D
> > For now,it uses only the first uleb128 byte in code.=0D
> >=0D
> > For vsp increments of 0x204~0x400,use one uleb128 byte like below:=0D
> > 0xc06a00e4 <unwind_test_work>: 0x80b27fac=0D
> >   Compact model index: 0=0D
> >   0xb2 0x7f vsp =3D vsp + 1024=0D
> >   0xac      pop {r4, r5, r6, r7, r8, r14}=0D
> >=0D
> > For vsp increments larger than 0x400,use two uleb128 bytes like below:=
=0D
> > 0xc06a00e4 <unwind_test_work>: @0xc0cc9e0c=0D
> >   Compact model index: 1=0D
> >   0xb2 0x81 0x01 vsp =3D vsp + 1032=0D
> >   0xac      pop {r4, r5, r6, r7, r8, r14}=0D
> > The unwind works well since the decoded uleb128 byte is also 0x81.=0D
> >=0D
> > For vsp increments larger than 0x600,use two uleb128 bytes like below:=
=0D
> > 0xc06a00e4 <unwind_test_work>: @0xc0cc9e0c=0D
> >   Compact model index: 1=0D
> >   0xb2 0x81 0x02 vsp =3D vsp + 1544=0D
> >   0xac      pop {r4, r5, r6, r7, r8, r14}=0D
> > In this case,the decoded uleb128 result is 0x101(vsp=3D0x204+(0x101<<2)=
).=0D
> > While the uleb128 used in code is 0x81(vsp=3D0x204+(0x81<<2)).=0D
> > The unwind aborts at this frame since it gets incorrect vsp.=0D
> >=0D
> > To fix this,add uleb128 decode to cover all the above case.=0D
> >=0D
> > Signed-off-by: Haibo Li <haibo.li@mediatek.com>=0D
> =0D
> Way to go, remember to collect all the Reviewed-by tags before you put th=
e=0D
> patch into Russell's patch tracker.=0D
> =0D
> Yours,=0D
> Linus Walleij=0D
Thanks for reminding.I put the patch into Russell's patch tracker just now,=
=0D
together with the three Reviewed-by tags from you,=0D
Alexandre Mergnat and AngeloGioacchino Del Regno.=0D
Thank you all.=0D
=0D
