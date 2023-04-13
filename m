Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8FC6E0794
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 09:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjDMHTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 03:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjDMHTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 03:19:36 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F70655AB
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 00:19:30 -0700 (PDT)
X-UUID: 8663f13ad9cb11eda9a90f0bb45854f4-20230413
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=TlS2syzLgaN+56EfstTdZIGRaa5/Hy8gJUg8hh7K3Fo=;
        b=J/CPNeNMZEaWg6RKHRPw9Tgg485PWAvUVKt769KX7pXBxsD2taDlO6IZANqMAoIe5C5Fj3v/8T/0IGxpPtc5YKXfNqbZPzznLjNw2qMexgUqx2+WDNhNETqC8Toe10CvJW9Z0pWz0zC7Ui703c7fGdMW+Kd0/ytBGwIg7WeeqvE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:6a577a3c-8eb7-496e-8935-1ccee7182488,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:120426c,CLOUDID:c576d2ea-db6f-41fe-8b83-13fe7ed1ef52,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|-5,EDM:-3,IP:ni
        l,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 1,FCT|NGT
X-CID-BAS: 1,FCT|NGT,0,_
X-UUID: 8663f13ad9cb11eda9a90f0bb45854f4-20230413
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <haibo.li@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 509895958; Thu, 13 Apr 2023 15:19:27 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Thu, 13 Apr 2023 15:19:26 +0800
Received: from mszsdtlt102.gcn.mediatek.inc (10.16.4.142) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Thu, 13 Apr 2023 15:19:25 +0800
From:   Haibo Li <haibo.li@mediatek.com>
To:     <amergnat@baylibre.com>
CC:     <alexander.sverdlin@nokia.com>,
        <angelogioacchino.delregno@collabora.com>, <haibo.li@mediatek.com>,
        <linus.walleij@linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux@armlinux.org.uk>,
        <matthias.bgg@gmail.com>, <rmk+kernel@armlinux.org.uk>,
        <xiaoming.yu@mediatek.com>
Subject: Re: [PATCH] ARM:unwind:fix unwind abort for uleb128 case
Date:   Thu, 13 Apr 2023 15:19:25 +0800
Message-ID: <20230413071925.42858-1-haibo.li@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <7d567846-a000-1bd2-6e43-7ca170366d76@baylibre.com>
References: <7d567846-a000-1bd2-6e43-7ca170366d76@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On 07/04/2023 05:33, Haibo Li wrote:=0D
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
> >   arch/arm/kernel/unwind.c | 19 +++++++++++++++++--=0D
> >   1 file changed, 17 insertions(+), 2 deletions(-)=0D
> >=0D
> > diff --git a/arch/arm/kernel/unwind.c b/arch/arm/kernel/unwind.c index=
=0D
> > 53be7ea6181b..e5796a5acba1 100644=0D
> > --- a/arch/arm/kernel/unwind.c=0D
> > +++ b/arch/arm/kernel/unwind.c=0D
> > @@ -20,7 +20,6 @@=0D
> >   #warning    Change compiler or disable ARM_UNWIND option.=0D
> >   #endif=0D
> >   #endif /* __CHECKER__ */=0D
> > -=0D
> =0D
> Why delete this line ?=0D
It may be changed by mistake.I will restore it.=0D
> =0D
> >   #include <linux/kernel.h>=0D
> >   #include <linux/init.h>=0D
> >   #include <linux/export.h>=0D
> > @@ -308,6 +307,22 @@ static int=0D
> unwind_exec_pop_subset_r0_to_r3(struct unwind_ctrl_block *ctrl,=0D
> >       return URC_OK;=0D
> >   }=0D
> >=0D
> > +static unsigned long unwind_decode_uleb128(struct unwind_ctrl_block=0D
> > +*ctrl) {=0D
> > +     unsigned long result =3D 0;=0D
> > +     unsigned long insn;=0D
> > +     unsigned long bytes =3D 0;=0D
> =0D
> Alphabetical order please.=0D
get it.=0D
> =0D
> > +=0D
> > +     do {=0D
> > +             insn =3D unwind_get_byte(ctrl);=0D
> > +             result |=3D (insn & 0x7f) << (bytes * 7);=0D
> > +             bytes++;=0D
> > +             if (bytes =3D=3D sizeof(result))=0D
> > +                     break;=0D
> > +     } while (!!(insn & 0x80));=0D
> > +=0D
> > +     return result;=0D
> > +}=0D
> =0D
> Please add a blank line for readability.=0D
OK.=0D
> =0D
> >   /*=0D
> >    * Execute the current unwind instruction.=0D
> >    */=0D
> > @@ -361,7 +376,7 @@ static int unwind_exec_insn(struct=0D
> unwind_ctrl_block *ctrl)=0D
> >               if (ret)=0D
> >                       goto error;=0D
> >       } else if (insn =3D=3D 0xb2) {=0D
> > -             unsigned long uleb128 =3D unwind_get_byte(ctrl);=0D
> > +             unsigned long uleb128 =3D unwind_decode_uleb128(ctrl);=0D
> >=0D
> >               ctrl->vrs[SP] +=3D 0x204 + (uleb128 << 2);=0D
> >       } else {=0D
> =0D
> Great job! I'm aligned with Linus Walleij's feedback about the need of fe=
w=0D
> comments to explain the decode loop, even if your code is clear, light an=
d=0D
> robust.=0D
Thanks for reviewing the patch.I will add the comment in later patch.=0D
> =0D
