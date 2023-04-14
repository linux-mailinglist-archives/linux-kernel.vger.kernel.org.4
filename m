Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC3FF6E1C15
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 07:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjDNF5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 01:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjDNF5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 01:57:17 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3761C2729
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 22:57:12 -0700 (PDT)
X-UUID: 2f6e9498da8911eda9a90f0bb45854f4-20230414
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=H9vNvewfpPR814IH1BCiBiPgoYyABnkdJEK5tx2llaM=;
        b=Kme3YT+NH82Igci+OiepJoYbzUtp1ua/9kFxkSGCWS/DI5o4btG3t/td626U0703znIxGWW4IKX11zCB5Q7tFq4NaAG66MVeujF1U47tN0TwQb04NHND+qp85CkwusRoigfqtNv770gyX3hw9kspPS46LrMWp0i6NhgaawKj7mg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:789c86aa-2cc2-4e1c-b1b7-f2ba7d580589,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:28,RULE:Release_Ham,ACTIO
        N:release,TS:73
X-CID-INFO: VERSION:1.1.22,REQID:789c86aa-2cc2-4e1c-b1b7-f2ba7d580589,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:28,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:73
X-CID-META: VersionHash:120426c,CLOUDID:a8364ea1-8fcb-430b-954a-ba3f00fa94a5,B
        ulkID:230413153914DG0XTWF2,BulkQuantity:25,Recheck:0,SF:29|28|17|19|48|102
        ,TC:nil,Content:0|-5,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:40|20,QS:nil,BEC
        :nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 1,FCT|NGT
X-CID-BAS: 1,FCT|NGT,0,_
X-UUID: 2f6e9498da8911eda9a90f0bb45854f4-20230414
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <haibo.li@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2009065627; Fri, 14 Apr 2023 13:57:05 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Fri, 14 Apr 2023 13:57:04 +0800
Received: from mszsdtlt102.gcn.mediatek.inc (10.16.4.142) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Fri, 14 Apr 2023 13:57:04 +0800
From:   Haibo Li <haibo.li@mediatek.com>
To:     <angelogioacchino.delregno@collabora.com>
CC:     <a.anurag@samsung.com>, <alexander.sverdlin@nokia.com>,
        <amergnat@baylibre.com>, <ardb@kernel.org>,
        <catalin.marinas@arm.com>, <haibo.li@mediatek.com>,
        <linus.walleij@linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux@armlinux.org.uk>,
        <matthias.bgg@gmail.com>, <rmk+kernel@armlinux.org.uk>,
        <xiaoming.yu@mediatek.com>
Subject: Re: [PATCH v2] ARM:unwind:fix unwind abort for uleb128 case
Date:   Fri, 14 Apr 2023 13:57:04 +0800
Message-ID: <20230414055704.123841-1-haibo.li@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <22bb4f8f-8f4b-6efb-74ab-b33eabc1fbb9@collabora.com>
References: <22bb4f8f-8f4b-6efb-74ab-b33eabc1fbb9@collabora.com>
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

> Il 13/04/23 09:34, Haibo Li ha scritto:=0D
> > When unwind instruction is 0xb2,the subsequent instructions are=0D
> > uleb128 bytes.=0D
> > For now,it uses only the first uleb128 byte in code.=0D
> >=0D
> > For vsp increments of 0x204~0x400,use one uleb128 byte like below:=0D
> > 0xc06a00e4 <unwind_test_work>: 0x80b27fac=0D
> >    Compact model index: 0=0D
> >    0xb2 0x7f vsp =3D vsp + 1024=0D
> >    0xac      pop {r4, r5, r6, r7, r8, r14}=0D
> >=0D
> > For vsp increments larger than 0x400,use two uleb128 bytes like below:=
=0D
> > 0xc06a00e4 <unwind_test_work>: @0xc0cc9e0c=0D
> >    Compact model index: 1=0D
> >    0xb2 0x81 0x01 vsp =3D vsp + 1032=0D
> >    0xac      pop {r4, r5, r6, r7, r8, r14}=0D
> > The unwind works well since the decoded uleb128 byte is also 0x81.=0D
> >=0D
> > For vsp increments larger than 0x600,use two uleb128 bytes like below:=
=0D
> > 0xc06a00e4 <unwind_test_work>: @0xc0cc9e0c=0D
> >    Compact model index: 1=0D
> >    0xb2 0x81 0x02 vsp =3D vsp + 1544=0D
> >    0xac      pop {r4, r5, r6, r7, r8, r14}=0D
> > In this case,the decoded uleb128 result is 0x101(vsp=3D0x204+(0x101<<2)=
).=0D
> > While the uleb128 used in code is 0x81(vsp=3D0x204+(0x81<<2)).=0D
> > The unwind aborts at this frame since it gets incorrect vsp.=0D
> >=0D
> > To fix this,add uleb128 decode to cover all the above case.=0D
> >=0D
> > Signed-off-by: Haibo Li <haibo.li@mediatek.com>=0D
> > ---=0D
> > v2:=0D
> > - As Linus Walleij and Alexandre Mergnat suggested,add comments for=0D
> > unwind_decode_uleb128=0D
> > - As Alexandre Mergnat suggested,change variables declaration in=0D
> > Alphabetical order=0D
> > ---=0D
> >   arch/arm/kernel/unwind.c | 25 ++++++++++++++++++++++++-=0D
> >   1 file changed, 24 insertions(+), 1 deletion(-)=0D
> >=0D
> > diff --git a/arch/arm/kernel/unwind.c b/arch/arm/kernel/unwind.c index=
=0D
> > 53be7ea6181b..f37e55fcf81d 100644=0D
> > --- a/arch/arm/kernel/unwind.c=0D
> > +++ b/arch/arm/kernel/unwind.c=0D
> > @@ -308,6 +308,29 @@ static int=0D
> unwind_exec_pop_subset_r0_to_r3(struct unwind_ctrl_block *ctrl,=0D
> >       return URC_OK;=0D
> >   }=0D
> >=0D
> > +static unsigned long unwind_decode_uleb128(struct unwind_ctrl_block=0D
> > +*ctrl) {=0D
> > +     unsigned long bytes =3D 0;=0D
> > +     unsigned long insn;=0D
> > +     unsigned long result =3D 0;=0D
> > +=0D
> > +     /* unwind_get_byte() will advance ctrl one instruction at a time,=
=0D
> > +      * we loop until we get an instruction byte where bit 7 is not se=
t.=0D
> > +      * Note:It decodes max 4 bytes to output 28bits data.=0D
> > +      * 28bits data(0xfffffff) covers vsp increments of 1073742336.=0D
> > +      * It is sufficent for unwinding stack.=0D
> > +      */=0D
> =0D
> /*=0D
>   * unwind_get_byte() will advance `ctrl` one instruction at a time, so=0D
>   * loop until we get an instruction byte where bit 7 is not set.=0D
>   *=0D
>   * Note: This decodes a maximum of 4 bytes to output 28 bits data where=
=0D
>   * max is 0xfffffff: that will cover a vsp increment of 1073742336, henc=
e=0D
>   * it is sufficient for unwinding the stack.=0D
>   */=0D
Looks much better.Thanks.=0D
> =0D
> > +     do {=0D
> > +             insn =3D unwind_get_byte(ctrl);=0D
> > +             result |=3D (insn & 0x7f) << (bytes * 7);=0D
> > +             bytes++;=0D
> =0D
> also, I would do ...=0D
> =0D
>         } while (!!(insn & 0x80) && bytes !=3D sizeof(result));=0D
> =0D
> ...compressing the code and not creating any human readability concern.=0D
> =0D
> after which, you can get my=0D
> =0D
> Reviewed-by: AngeloGioacchino Del Regno=0D
> <angelogioacchino.delregno@collabora.com>=0D
get it.I will make a new patch.=0D
