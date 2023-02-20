Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06C0569C4C9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 05:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjBTEhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 23:37:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjBTEhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 23:37:01 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004C1E3A7
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 20:36:58 -0800 (PST)
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230220043654epoutp012359f231be620450126af1dfcd27a5a5~FbmSne1Q02626526265epoutp01I
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 04:36:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230220043654epoutp012359f231be620450126af1dfcd27a5a5~FbmSne1Q02626526265epoutp01I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1676867814;
        bh=sN4yzoa0EqD1TPdRZogh44HtM12a9exYGCzUo4GXyMk=;
        h=Subject:Reply-To:From:To:In-Reply-To:Date:References:From;
        b=lO6mh+yYMZQbcC+fy02uKTBh3EmYG9gsg4zHvDjaCAeeCu/8ZT1ss09sr6OMYwXH+
         UtUG60QCxt7rjyjdIqcH2Is1D014koAaekpziPhXLaFnnqfSAfuEW6QE9eyBfBHXAz
         PWL1MqtCsJ7JZTRjBQD+tn9n1YLUeZLFnW6NH7eg=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20230220043654epcas1p3f351b11af790cfaaa3cf52ec68d3adde~FbmSWgsLK0883508835epcas1p3D;
        Mon, 20 Feb 2023 04:36:54 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.38.231]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4PKqPx1N7kz4x9QD; Mon, 20 Feb
        2023 04:36:53 +0000 (GMT)
X-AuditID: b6c32a39-d01fc7000000d627-11-63f2f8e05c22
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        CF.46.54823.0E8F2F36; Mon, 20 Feb 2023 13:36:48 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH 3/4] extcon: added extcon_alloc_muex to simplify extcon
 register function
Reply-To: myungjoo.ham@samsung.com
Sender: MyungJoo Ham <myungjoo.ham@samsung.com>
From:   MyungJoo Ham <myungjoo.ham@samsung.com>
To:     Bumwoo Lee <bw365.lee@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20230217084613.25359-4-bw365.lee@samsung.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230220043648epcms1p6a85c5c4c11e888e934c715bcc56d4cb8@epcms1p6>
Date:   Mon, 20 Feb 2023 13:36:48 +0900
X-CMS-MailID: 20230220043648epcms1p6a85c5c4c11e888e934c715bcc56d4cb8
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDKsWRmVeSWpSXmKPExsWy7bCmvu6DH5+SDa4ds7A4sWYRk8X1L89Z
        LS7vmsPmwOzRt2UVo8fnTXIBTFHZNhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZK
        CnmJuam2Si4+AbpumTlAO5QUyhJzSoFCAYnFxUr6djZF+aUlqQoZ+cUltkqpBSk5BaYFesWJ
        ucWleel6eaklVoYGBkamQIUJ2Rnfli9hKzjDX3H7wXzWBsaJ/F2MnBwSAiYSV+fOZupi5OIQ
        EtjBKHHywlvWLkYODl4BQYm/O4RBTGGBeImTbxVByoUElCQabu5jBrGFBfQlOh5sYwSx2QR0
        JbZuuMsCMkZEoJ8RyPnLDDGfV2JG+1MWCFtaYvvyrYwgMzkFrCUeNydAhEUlbq5+yw5jvz82
        nxHCFpFovXcWaoygxIOfu6HiUhJPdk5mA9klITAZ6OQTxxkhnDmMEtM2vGODqNKXODP3JJjN
        K+ArMXfvFrBuFgFViXd/5zKBHCEh4CLRuIoXJMwsoC2xbOFrZpAws4CmxPpd+hBhPol3X3tY
        YV7ZMe8JE4StJnFo9xKom2UkTk9fCHWnh8Tsm8+hwbmZUWLe529sExjlZiFCdBaSbbMQti1g
        ZF7FKJZaUJybnlpsWGAKj8Tk/NxNjOBkpWW5g3H62w96hxiZOBgPMUpwMCuJ8Eof+pAsxJuS
        WFmVWpQfX1Sak1p8iNEU6M2JzFKiyfnAdJlXEm9oYmlgYmZkbGJhaGaoJM4rbnsyWUggPbEk
        NTs1tSC1CKaPiYNTqoGp3PZvybOX5yR2WC3MW5La4PvFQz5Mnv1FGcsBn+j9HUecOxZ2bJsX
        f+DuFfszhbKNd3Nt/10Qsnj46mfiyo1np3T2inrKHFi2PirSbLX/m5Y1vrstr/7ZdrtFxGy2
        S/2WiDcxrQFXebtXSL05s+er0b/oz+U33L+b/TBPULeT/tTZMJ+hzOZ00t7fa5JEXu+Runwu
        fXKv29JUjdS1/cozWbpfrTLaXhavvUDyxUOWAwennZ4T9v+gi6mfa58L48fukEaZWaIfutzN
        60rk9hd8nnHw5KP+eUmqvpqvPmz1eC+xst39yoLChevWNTk0eIRtbffpLz0teeUPz6MUXtXS
        W38dTj7ift2quTtQ/dNhJZbijERDLeai4kQAVxARSN8DAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230217084803epcas1p2d5e3ca2fbadd5fde7f58a8ae1940d53f
References: <20230217084613.25359-4-bw365.lee@samsung.com>
        <20230217084613.25359-1-bw365.lee@samsung.com>
        <CGME20230217084803epcas1p2d5e3ca2fbadd5fde7f58a8ae1940d53f@epcms1p6>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>--------- Original Message ---------
>Sender : =EC=9D=B4=EB=B2=94=EC=9A=B0=C2=A0<bw365.lee=40samsung.com>Product=
=20S/W=20Lab(VD)/=EC=82=BC=EC=84=B1=EC=A0=84=EC=9E=90=0D=0A>Date=20:=202023=
-02-17=2017:48=20(GMT+9)=0D=0A>Title=20:=20=5BPATCH=203/4=5D=20extcon:=20ad=
ded=20extcon_alloc_muex=20to=20simplify=20extcon=20register=20function=0D=
=0A>=C2=A0=0D=0A>The=20mutual=20exclusive=20part=20is=20functionalized=20fr=
om=20extcon_dev_register.=0D=0A>=0D=0A>Signed-off-by:=20Bumwoo=20Lee=20<bw3=
65.lee=40samsung.com>=0D=0A>---=0D=0A>=20drivers/extcon/extcon.c=20=7C=2010=
5=20++++++++++++++++++++++------------------=0D=0A>=201=20file=20changed,=
=2057=20insertions(+),=2048=20deletions(-)=0D=0A>=0D=0A>diff=20--git=20a/dr=
ivers/extcon/extcon.c=20b/drivers/extcon/extcon.c=0D=0A>index=2028058a1d274=
5..93cab4fe178e=20100644=0D=0A>---=20a/drivers/extcon/extcon.c=0D=0A>+++=20=
b/drivers/extcon/extcon.c=0D=0A>=40=40=20-1125,6=20+1125,60=20=40=40=20stat=
ic=20int=20extcon_alloc_cables(struct=20extcon_dev=20*edev)=0D=0A>=20=C2=A0=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0return=200;=0D=0A>=20=7D=0D=0A>=C2=A0=0D=
=0A...=0D=0A>-=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0if=20(=21edev->attrs_muex)=20=7B=0D=0A>-=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0ret=20=3D=20-ENOMEM;=0D=0A>-=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
goto=20err_muex;=0D=0A>-=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=7D=0D=0A...=0D=0A>+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0if=20(extcon_alloc_muex(edev))=0D=0A>+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0goto=20err_alloc_muex;=0D=0A=0D=0AIt=
's=20not=20good.=0D=0AYou=20may=20return=20an=20uninitialized=20value=20or=
=200=20when=20your=20new=20function=20has=20an=20error.=0D=0A=0D=0ACheers,=
=0D=0AMyungJoo=0D=0A
