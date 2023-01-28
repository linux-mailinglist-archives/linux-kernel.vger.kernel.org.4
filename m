Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6656067F4A6
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 05:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjA1Ebh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 23:31:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjA1Ebe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 23:31:34 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C78D7BBEB
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 20:31:32 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230128043130epoutp01d80f2a0c27835471d0aa47f98eb77c0e~_XsACtCWX0359303593epoutp01u
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 04:31:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230128043130epoutp01d80f2a0c27835471d0aa47f98eb77c0e~_XsACtCWX0359303593epoutp01u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1674880290;
        bh=sCUi0q3DODlkQrGiouXNdKFel8UvrLkIHjGwPdgOAK0=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=Rw3EwTp6ZF2azZXxT1p+Bxq2Iu8aaOhsIRMwlfeSeNzji68vRX2sfQCQaX5OCqsnk
         M/3ceW/BIFmQGK94Uy8I7Gw5EvgNM7TTJQiMZTdMwyyCxXnf+bvsMQE26xbA1tOqyk
         ohWXu1Eb57aSN1lhtQl7N+3nePI92t7nbxpASqPg=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20230128043129epcas5p3c8e99995e7a4b40de00c41175164a404~_Xr-mkbWR1679816798epcas5p3n;
        Sat, 28 Jan 2023 04:31:29 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.177]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4P3hNJ0ttpz4x9Pp; Sat, 28 Jan
        2023 04:31:28 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        96.E9.06765.025A4D36; Sat, 28 Jan 2023 13:31:28 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20230128043127epcas5p3923119a488e5ece83ac13cb4f44c8d27~_Xr9h5ZsE1672316723epcas5p3n;
        Sat, 28 Jan 2023 04:31:27 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230128043127epsmtrp167cac80e20f5152edb5967f159c63ce5~_Xr9hC2BW2096320963epsmtrp12;
        Sat, 28 Jan 2023 04:31:27 +0000 (GMT)
X-AuditID: b6c32a4b-46dfa70000011a6d-8f-63d4a520936f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D1.5D.05839.F15A4D36; Sat, 28 Jan 2023 13:31:27 +0900 (KST)
Received: from alimakhtar04 (unknown [107.122.12.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230128043125epsmtip1151e339582392558ac78c7dc5ee3cfa9~_Xr7WNNgu1321413214epsmtip1o;
        Sat, 28 Jan 2023 04:31:25 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        "'Krzysztof Kozlowski'" <krzysztof.kozlowski+dt@linaro.org>,
        "'Inki Dae'" <inki.dae@samsung.com>,
        "'Kyungmin Park'" <kyungmin.park@samsung.com>,
        "'Kukjin Kim'" <kgene@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Cc:     <replicant@osuosl.org>, <phone-devel@vger.kernel.org>,
        <~postmarketos/upstreaming@lists.sr.ht>,
        =?utf-8?Q?'Martin_J=C3=BCcker'?= <martin.juecker@gmail.com>,
        "'Henrik Grimler'" <henrik@grimler.se>
In-Reply-To: <20230120155404.323386-3-krzysztof.kozlowski@linaro.org>
Subject: RE: [PATCH 02/11] ARM: dts: exynos: drop unsupported desc-num in
 Exynos3250
Date:   Sat, 28 Jan 2023 10:01:23 +0530
Message-ID: <000101d932d1$62c2d670$28488350$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHNuRkKafHieBmUHCY1mc35yYPTTQHJclALAMEWT2qutdvb4A==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIJsWRmVeSWpSXmKPExsWy7bCmhq7C0ivJBj9+MVvMP3KO1eLtkl2M
        FpPuT2Cx6H/8mtmi78VDZou9r7eyW5xtesNusenxNVaLy7vmsFnMOL+PyeLMv6ksFgv+2Fms
        WyNo0br3CLvF5u9/GR34PXbOusvucfTKPVaPTas62TzuXNvD5rF5Sb3H/ztr2T2+NHezevRt
        WcXo8XmTXABnVLZNRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJuqq2Si0+A
        rltmDtD9SgpliTmlQKGAxOJiJX07m6L80pJUhYz84hJbpdSClJwCkwK94sTc4tK8dL281BIr
        QwMDI1OgwoTsjCc7TrAU7BermPTnJWsD4yHRLkZODgkBE4ll686xdTFycQgJ7GaUaNpxihEk
        ISTwiVFi034JiMQ3RonzH9uZuxg5wDo+3nOEqNnLKPGlUxyi5iWjxI5bW5lAEmwCuhI7FreB
        TRURWMsscWDLNjCHWeA0o8SVldvAVnAKuErcPfcWrENYIEzi+//LjCAbWARUJZ4edAAJ8wpY
        Smxff5cFwhaUODnzCZjNLKAtsWzha2aIFxQkfj5dxgpiiwg4STzeuJUZokZc4uXRI+wgeyUE
        3nBI/J3bxgTR4CJx68tKqGZhiVfHt7BD2FISL/vb2CG+9JBY9EcKIpwh8Xb5ekYI217iwJU5
        LCAlzAKaEut36UOs4pPo/f2ECaKTV6KjTQiiWlWi+d1VFghbWmJidzcrhO0h8XbLB+YJjIqz
        kDw2C8ljs5A8MAth2QJGllWMkqkFxbnpqcWmBcZ5qeXw2E7Oz93ECE7bWt47GB89+KB3iJGJ
        g/EQowQHs5II71bHS8lCvCmJlVWpRfnxRaU5qcWHGE2BgT2RWUo0OR+YOfJK4g1NLA1MzMzM
        TCyNzQyVxHnVbU8mCwmkJ5akZqemFqQWwfQxcXBKNTBtrqiq5Pa/Lyizr+f1+QiP+NQtE5qn
        loaKrvK5apkUxMS29d/e1KrG1XpGOwu4De/WOsxy/HJ4zen30epJVz4eWO0Yf7E59Gbxndj9
        ShbzXSXmnpVSWT/h2ypT1/k/e4S/LF9st0Mm+dg0/p/h/WeK73gtkD05MfLV+tvORz+rxFVL
        /GK7l3w+8t2F+RNZGmc5WVuff95pW3rc8fbDo9E+r2xN/swPnVR2NkdpNfMFjXSvoiAFp/6e
        3NVai69b7M90LDBoOeNQJrdd13JWXubZz2IMn7XlPX/Je/gFla8WaF3Q3yx1b1vRqTVZ/5Rq
        GVgv5K458lLojWnq5crPE9eZzG7x52Nf28d34HfLoTYlluKMREMt5qLiRABDZltWZAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDIsWRmVeSWpSXmKPExsWy7bCSnK780ivJBq9WSljMP3KO1eLtkl2M
        FpPuT2Cx6H/8mtmi78VDZou9r7eyW5xtesNusenxNVaLy7vmsFnMOL+PyeLMv6ksFgv+2Fms
        WyNo0br3CLvF5u9/GR34PXbOusvucfTKPVaPTas62TzuXNvD5rF5Sb3H/ztr2T2+NHezevRt
        WcXo8XmTXABnFJdNSmpOZllqkb5dAlfGq021BSsEKz7cu8LUwPiar4uRg0NCwETi4z3HLkYu
        DiGB3YwS//bsYuxi5ASKS0tc3ziBHcIWllj57zk7RNFzRonPc9pZQRJsAroSOxa3sYEkRAQ2
        M0scn3SQGcRhFjjPKHFjxgFWiBYgp2fvE7BZnAKuEnfPvWUCsYUFQiS+T9vJBnIHi4CqxNOD
        DiBhXgFLie3r77JA2IISJ2c+AbOZBbQlnt58CmcvW/iaGeI8BYmfT5eBXSQi4CTxeONWZoga
        cYmXR4+wT2AUnoVk1Cwko2YhGTULScsCRpZVjJKpBcW56bnFhgWGeanlesWJucWleel6yfm5
        mxjBEayluYNx+6oPeocYmTgYDzFKcDArifBudbyULMSbklhZlVqUH19UmpNafIhRmoNFSZz3
        QtfJeCGB9MSS1OzU1ILUIpgsEwenVAOTpcaNmR8UbtfL71SQZdG//HrulYojcyJ4Vily/2jd
        31Sulmka5NuSnenMWWMmO2Wr5qYlO3//5tm4+ISUUxPLFINdnGntu+x3PFw6Wbz6ysK6h9ea
        thm/W7/7aULpW495um9dlGLPlwteiPv7xm7O9ss6N792bLViVf4sMOvd87tPxSKkniw8Ws7g
        1RiwznHhNb0X3TcT/56fwcy05ph4V/EBk5S/7y6vFHBm8ZYUP3Ko478834bHJzqPVR3nszAW
        Vuq88PqMSbDLA/4LO9iU9x575HFfMVxPX/nI8ju7vPcy6KhzKwnZO+5UXHuldXfWKplpHVGi
        IQc57GzNVtUvCtx2t8r+TtDbJclloaFNSizFGYmGWsxFxYkAixyLE08DAAA=
X-CMS-MailID: 20230128043127epcas5p3923119a488e5ece83ac13cb4f44c8d27
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230120155419epcas5p13bf5df182a03b965ab92ab6adf797f4f
References: <20230120155404.323386-1-krzysztof.kozlowski@linaro.org>
        <CGME20230120155419epcas5p13bf5df182a03b965ab92ab6adf797f4f@epcas5p1.samsung.com>
        <20230120155404.323386-3-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Krzysztof Kozlowski <krzysztof.kozlowski=40linaro.org>
> Sent: Friday, January 20, 2023 9:24 PM
> To: Rob Herring <robh+dt=40kernel.org>; Krzysztof Kozlowski
> <krzysztof.kozlowski+dt=40linaro.org>; Alim Akhtar
> <alim.akhtar=40samsung.com>; Inki Dae <inki.dae=40samsung.com>; Kyungmin
> Park <kyungmin.park=40samsung.com>; Kukjin Kim <kgene=40kernel.org>;
> devicetree=40vger.kernel.org; linux-arm-kernel=40lists.infradead.org; lin=
ux-
> samsung-soc=40vger.kernel.org; linux-kernel=40vger.kernel.org
> Cc: replicant=40osuosl.org; phone-devel=40vger.kernel.org;
> =7Epostmarketos/upstreaming=40lists.sr.ht; Martin J=C3=BCcker=0D=0A>=20<m=
artin.juecker=40gmail.com>;=20Henrik=20Grimler=20<henrik=40grimler.se>;=0D=
=0A>=20Krzysztof=20Kozlowski=20<krzysztof.kozlowski=40linaro.org>=0D=0A>=20=
Subject:=20=5BPATCH=2002/11=5D=20ARM:=20dts:=20exynos:=20drop=20unsupported=
=20desc-num=20in=0D=0A>=20Exynos3250=0D=0A>=20=0D=0A>=20There=20is=20no=20d=
esc-num=20property=20for=20MMC=20nodes:=0D=0A>=20=0D=0A>=20=20=20exynos3250=
-monk.dtb:=20mmc=4012510000:=20Unevaluated=20properties=20are=20not=0D=0A>=
=20allowed=20('desc-num'=20was=20unexpected)=0D=0A>=20=0D=0A>=20Signed-off-=
by:=20Krzysztof=20Kozlowski=20<krzysztof.kozlowski=40linaro.org>=0D=0A>=20-=
--=0D=0A=0D=0AReviewed-by:=20Alim=20Akhtar=20<alim.akhtar=40samsung.com>=0D=
=0A=0D=0A>=20=20arch/arm/boot/dts/exynos3250-monk.dts=20=20=20=7C=201=20-=
=0D=0A>=20=20arch/arm/boot/dts/exynos3250-rinato.dts=20=7C=201=20-=0D=0A>=
=20=202=20files=20changed,=202=20deletions(-)=0D=0A>=20=0D=0A>=20diff=20--g=
it=20a/arch/arm/boot/dts/exynos3250-monk.dts=0D=0A>=20b/arch/arm/boot/dts/e=
xynos3250-monk.dts=0D=0A>=20index=2002a9dc479d34..c8eacf1b5d0b=20100644=0D=
=0A>=20---=20a/arch/arm/boot/dts/exynos3250-monk.dts=0D=0A>=20+++=20b/arch/=
arm/boot/dts/exynos3250-monk.dts=0D=0A>=20=40=40=20-438,7=20+438,6=20=40=40=
=20&mshc_0=20=7B=0D=0A>=20=20=09broken-cd;=0D=0A>=20=20=09non-removable;=0D=
=0A>=20=20=09cap-mmc-highspeed;=0D=0A>=20-=09desc-num=20=3D=20<4>;=0D=0A>=
=20=20=09mmc-hs200-1_8v;=0D=0A>=20=20=09card-detect-delay=20=3D=20<200>;=0D=
=0A>=20=20=09vmmc-supply=20=3D=20<&vemmc_reg>;=0D=0A>=20diff=20--git=20a/ar=
ch/arm/boot/dts/exynos3250-rinato.dts=0D=0A>=20b/arch/arm/boot/dts/exynos32=
50-rinato.dts=0D=0A>=20index=202eb682009815..812816af8476=20100644=0D=0A>=
=20---=20a/arch/arm/boot/dts/exynos3250-rinato.dts=0D=0A>=20+++=20b/arch/ar=
m/boot/dts/exynos3250-rinato.dts=0D=0A>=20=40=40=20-619,7=20+619,6=20=40=40=
=20&mshc_0=20=7B=0D=0A>=20=20=09broken-cd;=0D=0A>=20=20=09non-removable;=0D=
=0A>=20=20=09cap-mmc-highspeed;=0D=0A>=20-=09desc-num=20=3D=20<4>;=0D=0A>=
=20=20=09mmc-hs200-1_8v;=0D=0A>=20=20=09card-detect-delay=20=3D=20<200>;=0D=
=0A>=20=20=09vmmc-supply=20=3D=20<&ldo12_reg>;=0D=0A>=20--=0D=0A>=202.34.1=
=0D=0A=0D=0A=0D=0A
