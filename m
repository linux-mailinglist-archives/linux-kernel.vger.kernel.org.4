Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8382B6DE99B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 04:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjDLCoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 22:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjDLCoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 22:44:15 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06447103
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 19:44:12 -0700 (PDT)
X-UUID: e5c02beed8db11eda9a90f0bb45854f4-20230412
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=H5FYrATT4VGI92VQEIJH6GiQshptGEG+Fy5j9MIU3tA=;
        b=Q4KHGIPpwzYgs69hcIX9w3wgLWh0fGeHQ4RgWfuSQ9huTN0aYo0rDqKG96QNIO4vSgMOY05az+JEKJ+kBWNz4ess3hmUKzzslc1cwWsXkyXco0P2AQh2E0wUsMcoZRTw8os1NFujcF7ODX/PISfsIz98Xcn3fp7JPUETliVUtAY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:1521a4d0-e889-4c92-a3fb-78ba5dd5f796,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:45
X-CID-INFO: VERSION:1.1.22,REQID:1521a4d0-e889-4c92-a3fb-78ba5dd5f796,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:45
X-CID-META: VersionHash:120426c,CLOUDID:4b2fa8ea-db6f-41fe-8b83-13fe7ed1ef52,B
        ulkID:2304120532092V9NDB9G,BulkQuantity:7,Recheck:0,SF:17|19|48|29|28|102,
        TC:nil,Content:0|-5,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:40,QS:nil,BEC:nil
        ,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 1,FCT|NGT
X-CID-BAS: 1,FCT|NGT,0,_
X-UUID: e5c02beed8db11eda9a90f0bb45854f4-20230412
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <haibo.li@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 800472532; Wed, 12 Apr 2023 10:44:08 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Wed, 12 Apr 2023 10:44:07 +0800
Received: from mszsdtlt102.gcn.mediatek.inc (10.16.4.142) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Wed, 12 Apr 2023 10:44:06 +0800
From:   Haibo Li <haibo.li@mediatek.com>
To:     <linus.walleij@linaro.org>
CC:     <a.anurag@samsung.com>, <alexander.sverdlin@nokia.com>,
        <angelogioacchino.delregno@collabora.com>, <ardb@kernel.org>,
        <catalin.marinas@arm.com>, <haibo.li@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux@armlinux.org.uk>,
        <matthias.bgg@gmail.com>, <rmk+kernel@armlinux.org.uk>,
        <xiaoming.yu@mediatek.com>
Subject: Re: [PATCH] ARM:unwind:fix unwind abort for uleb128 case
Date:   Wed, 12 Apr 2023 10:44:06 +0800
Message-ID: <20230412024406.62187-1-haibo.li@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CACRpkda8qTuCmF_RDjtp26k_DMpME=0wAPjejh4ODkUr9SxVqg@mail.gmail.com>
References: <CACRpkda8qTuCmF_RDjtp26k_DMpME=0wAPjejh4ODkUr9SxVqg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, Apr 7, 2023 at 5:33 AM Haibo Li <haibo.li@mediatek.com> wrote:=0D
> =0D
> > When unwind instruction is 0xb2,the subsequent instructions=0D
> > are uleb128 bytes.=0D
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
> [Added people such as Catalin, Ard and Anurag who wrote the lion's=0D
> share of actual algorithms in this file]=0D
> =0D
> I would just link the wikipedia in the patch commit log actually:=0D
> =0D
> Link:https://en.wikipedia.org/wiki/LEB128=0D
> =0D
> for poor souls like me who need a primer on this encoding.=0D
> =0D
> It's great if you also have a reference to the spec where you=0D
> found this, but I take your word for that this appears in code.=0D
> Did compilers always emit this? Then we should have a Cc stable=0D
> to this patch. Unfortunately the link in the top of the file is dead.=0D
Yes.I also study uleb128 enc/dec format from this link.=0D
In experiment,Both Clang and GCC produces unwind instructions using ULEB128=
=0D
> =0D
> > +static unsigned long unwind_decode_uleb128(struct unwind_ctrl_block=0D
> *ctrl)=0D
> =0D
> So this decodes max an unsigned long? Are we sure that will always=0D
> suffice?=0D
For now,the maximum thread size of arm is 16KB(KASAN on).=0D
From below experiment(worse case while impossible),two uleb128 bytes is suf=
ficent for 16KB stack.=0D
0xc06a00e4 <unwind_test_work>: @0xc0cc9e0c=0D
  Compact model index: 1=0D
  0xb2 0xff 0x1e vsp =3D vsp + 16384=0D
  0xac      pop {r4, r5, r6, r7, r8, r14}=0D
From below experiment,the code picks maximum 4 uleb128 encoded bytes,=0D
correspoding to vsp increments of 1073742336,the unwind_decode_uleb128 retu=
rns 0xFFFFFFF.=0D
So unsigned long is suffice.=0D
0xc06a00e4 <unwind_test_work>: @0xc0cc9e0c=0D
  Compact model index: 1=0D
  0xb2 0xff 0xff 0xff 0x7f vsp =3D vsp + 1073742336=0D
  0xac      pop {r4, r5, r6, r7, r8, r14}=0D
> =0D
> > +{=0D
> > +       unsigned long result =3D 0;=0D
> > +       unsigned long insn;=0D
> > +       unsigned long bytes =3D 0;=0D
> > +=0D
> > +       do {=0D
> > +               insn =3D unwind_get_byte(ctrl);=0D
> > +               result |=3D (insn & 0x7f) << (bytes * 7);=0D
> > +               bytes++;=0D
> > +               if (bytes =3D=3D sizeof(result))=0D
> > +                       break;=0D
> > +       } while (!!(insn & 0x80));=0D
> =0D
> I suppose the documentation is in the commit message, but something terse=
=0D
> and nice that make us understand this code would be needed here as well.=
=0D
> Could you fold in a comment of how the do {} while-loop works and th expe=
cted=0D
> outcome? Something like:=0D
> =0D
> "unwind_get_byte() will advance ctrl one instruction at a time, we loop=0D
> until we get an instruction byte where bit 7 is not set."=0D
> =0D
I will add a comment in later patch.=0D
> Is there a risk that this will loop forever or way too long if it happens=
=0D
> to point at some corrupted memory containing say 0xff 0xff 0xff ...?=0D
> =0D
> Since we're decoding a 32 bit unsigned long maybe break the loop after ma=
x=0D
> 5 bytes (35 bits)? Or are we sure this will not happen?=0D
in case of some corrupted memory containing say 0xff 0xff 0xff ...,the loop=
 breaks after =0D
max 4 bytes(decode as max 28 bits)=0D
> =0D
> > @@ -361,7 +376,7 @@ static int unwind_exec_insn(struct=0D
> unwind_ctrl_block *ctrl)=0D
> >                 if (ret)=0D
> >                         goto error;=0D
> >         } else if (insn =3D=3D 0xb2) {=0D
> > -               unsigned long uleb128 =3D unwind_get_byte(ctrl);=0D
> > +               unsigned long uleb128 =3D unwind_decode_uleb128(ctrl);=
=0D
> =0D
> Is unsigned long always enough? We are sure?=0D
For the patch,it can cover single frame up to 1073742336 Bytes.So it is eno=
ugh.=0D
>=0D
> Yours,=0D
> Linus Walleij=0D
