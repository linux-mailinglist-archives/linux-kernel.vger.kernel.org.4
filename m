Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1C90731034
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 09:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244527AbjFOHKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 03:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244523AbjFOHJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 03:09:29 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767E3296D
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 00:08:07 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230615070804epoutp04b1cff79eb64b4195937ea3c50da65f2a~ow2GXYut50219602196epoutp04H
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 07:08:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230615070804epoutp04b1cff79eb64b4195937ea3c50da65f2a~ow2GXYut50219602196epoutp04H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1686812884;
        bh=EGcDW2JUgCyU9XRlFhBjJMiX44JWtj7BLhhL20mI6/0=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=AS2oT8R+F9B5iBBIUn8v1qb3owWdgNjirpu3OAG9knp6GTTCzFgoKdHLbpDi7lfGl
         w3ZgQ1Od6gwoTzhW9OVUiZ1s+1Td7MuX6UtN75LDvXBVE65ONFufVJq/fBEPvPIWRw
         WnoRAzHdpm3IDkUGXT/O3ne6q+x9ABxcT7IC77xc=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20230615070803epcas5p36465025387f9e56699ad4291dbb183da~ow2FznXib2015820158epcas5p3b;
        Thu, 15 Jun 2023 07:08:03 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.181]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4QhYKD6mGvz4x9Pp; Thu, 15 Jun
        2023 07:08:00 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        54.73.44881.0D8BA846; Thu, 15 Jun 2023 16:08:00 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20230615065406epcas5p361076a0d683d59a8bc82ac30b5ee48e7~owp6bvCW90557505575epcas5p39;
        Thu, 15 Jun 2023 06:54:06 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230615065406epsmtrp16bb639768ac3e50b4acd97640f0c6563~owp6atjZz2692326923epsmtrp1R;
        Thu, 15 Jun 2023 06:54:06 +0000 (GMT)
X-AuditID: b6c32a4a-c47ff7000001af51-19-648ab8d01d50
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        F8.DC.28392.E85BA846; Thu, 15 Jun 2023 15:54:06 +0900 (KST)
Received: from FDSFTE343 (unknown [107.122.81.111]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230615065404epsmtip26e78c3c12bef2561775b262eb8833001~owp3xiMFH0988109881epsmtip2-;
        Thu, 15 Jun 2023 06:54:03 +0000 (GMT)
From:   "Chandrasekar R" <rcsekar@samsung.com>
To:     =?UTF-8?Q?'Leonard_G=C3=B6hrs'?= <l.goehrs@pengutronix.de>,
        "'Conor Dooley'" <conor@kernel.org>,
        "'Rob Herring'" <robh@kernel.org>,
        "'Alexandre TORGUE'" <alexandre.torgue@foss.st.com>,
        "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        "'Wolfgang Grandegger'" <wg@grandegger.com>,
        "'Marc Kleine-Budde'" <mkl@pengutronix.de>,
        "'David S. Miller'" <davem@davemloft.net>,
        "'Eric Dumazet'" <edumazet@google.com>,
        "'Jakub Kicinski'" <kuba@kernel.org>,
        "'Paolo Abeni'" <pabeni@redhat.com>
Cc:     <kernel@pengutronix.de>, "'Rob Herring'" <robh+dt@kernel.org>,
        "'Krzysztof Kozlowski'" <krzysztof.kozlowski+dt@linaro.org>,
        "'Conor Dooley'" <conor+dt@kernel.org>,
        <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20230614123222.4167460-5-l.goehrs@pengutronix.de>
Subject: RE: [PATCH v2 4/8] dt-bindings: can: m_can: change from additional-
 to unevaluatedProperties
Date:   Thu, 15 Jun 2023 12:24:02 +0530
Message-ID: <11a001d99f56$2d94a360$88bdea20$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJBfgczi9zBCP0v/3p/15qYfXGLHQLr7mzDAWe+ZPGumRKpwA==
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJJsWRmVeSWpSXmKPExsWy7bCmhu6FHV0pBpP2m1r8fDmN0WLN3nNM
        FiunrmKzmHO+hcVi/pFzrBZPjz1it1g1dSeLRd+Lh8wWe19vZbe4sK2P1eLRhwZmi1XfpzJb
        XN41h81i/aIpLBbHFohZfDv9htGide8Rdov/e3awWyy9t5PVQdhjy8qbTB5P+7eyeyzYVOrx
        8dJtRo9NqzrZPO5c28Pm0f/XwOP9vqtsHp83yQVwRmXbZKQmpqQWKaTmJeenZOal2yp5B8c7
        x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gD9pKRQlphTChQKSCwuVtK3synKLy1JVcjILy6x
        VUotSMkpMCnQK07MLS7NS9fLSy2xMjQwMDIFKkzIzmg5/5K94CBXxfxZF9kaGP9ydjFyckgI
        mEh0vXnD1sXIxSEksJtRonf9BCYI5xOjxNXT76Ccz4wSf36cYoZpubdkKgtEYhejRP/cPVD9
        Lxglri98xghSxSagI/G+7xtYQkTgB7PE0gOnWUEcZoHFTBITvm9nAqniFLCXuN3/C6iKg0NY
        IF1i6wshkDCLgKrEk6sHwEp4BSwlmmedY4GwBSVOznwCZjMLaEssW/ga6iQFiZ9Pl7GC2CIC
        ThIbryxhh6gRlzj6s4cZZK+EQDOnxMQNl6EaXCQW9H9mhbCFJV4d38IOYUtJvOxvg7KLJV59
        n8wGYddI7Nu8GqrXXuLAlTksIDczC2hKrN+lDxGWlZh6ah0TxF4+id7fT5gg4rwSO+bB2IoS
        07bOBGuVALrtyLyQCYxKs5B8NgvJZ7OQfDALYdkCRpZVjJKpBcW56anFpgVGeanl8BhPzs/d
        xAhO81peOxgfPvigd4iRiYPxEKMEB7OSCO9TjfYUId6UxMqq1KL8+KLSnNTiQ4ymwOCeyCwl
        mpwPzDR5JfGGJpYGJmZmZiaWxmaGSuK86rYnk4UE0hNLUrNTUwtSi2D6mDg4pRqYuD/oXsu8
        Vt312orVn++7lDm/h9PHTFNbNtvQ/fHcJ3KWxK/0+DXfd9Wc0xeu/W34EWnLbeeouWqG39Uu
        n8/9OdffFRarrzi1Za33MZV193fu37VBapvQBLFjvyYfeTl/CZNDz9PiXS8i997sEJVkmexd
        HjbHQFgm4+8Pdq/7XdvMIjQYtSsCTeymFXw5faLog09cTKPBuifKHgyc7t3LpHfVRjk8CLxS
        pl5dwOcop+sQa3VQ44Udz4HIj586Dc99TdKXuLWPr66oOj7PorHKO8ORa3OhaLlw2qUptgHv
        OSfKfdWcn1cyaQ5flNOEm+68x7389P8JvTyV8+Z22iezqvK1i98mLJGQ3XlM558SS3FGoqEW
        c1FxIgC0YitjfAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02RfUhTURiHO7t3d3fT5XWTPBp9MCjCyo8IOZI4i6BriQlGhkY2281W25RN
        K6NgZBZazgpXOYZapG3LVWrWLC3T0iwzMw1jlixcU6y0pNmMNLYV+N8Dz/k9vHBITNCLh5Iy
        ZS6jUkrkIoKH32sXLVurbSyWRp5+HI7cY5cAqm3pYSGTzkwgw+tTOKp82sNGjo5PHGTWNeFI
        O2rHUMt4Iwf13tOy0adJDYbM0zoMvX1gINDta2U46qhahFwvvwBU2PKUg+aarRxU/bGJHS+k
        75res2hHaSOHrqrPo7/32QBdby4i6KF3zQRd+ieSnng0QNBT9UuTuWm8WCkjlx1mVBFxe3kH
        XA2nWDlXyaP2sUgNKOAUAy4JqfXw43UdXgx4pICyAvirp4nwiWBomez/x0JomnV6BwLqM4Al
        w9DDBLUGTmhdhGccRGlwWKgrwD0Co0wsOGLl+artAH6bm/AKLiWGttIZb1VIMbCrtt1bxakV
        cGSgleVhPhUDC/Q9uI8DYVf5yL/oalhiLwT/uebqOOa7bjl0O2rYHg6iNsG6/usc35tg+Mx9
        DjsPhPp5Kf28lH5eSj9vUgVwMwhhctSKLIU6KmedkjkSrpYo1HnKrPB92Yp64P30sDAraDZP
        hrcBFgnaACQxURDfseqMVMCXSvKPMarsDFWenFG3gcUkLgrm9xZ3ZQioLEkuc4hhchjVf8si
        uaEaVmLKwQi3vCCg8bdYJRYN+Q3OXp5anNmdG1cTk/6ITtvT3ne5O8JdkZi63dhmOtHaer88
        Vte641LC4JvehGSLSPnavzDe9iH1Ree3bZvqjNOibbErZ6J3f4U3Nw6Pyg1kacg+i0LrfOhI
        LeL6B/R3hsRPJ/0wfo36dUcR/7ycPVSttlsq8l1GNBp3cs64Bf4uo/auvRJq+Nlp72jeMJZ/
        IabEKRTzLZEXNj+Uy/ynqTjnUanjyXm3Nan/7M+tTWkuP9uMrFqWqXFmLiEVsdSr2qRobsqu
        i+P7sePiupTA2cpb51oCzWK3bMENqiu9zNXQnbDzyUDiwqIvocO2zhARrj4giQrDVGrJXwBG
        R7JjAwAA
X-CMS-MailID: 20230615065406epcas5p361076a0d683d59a8bc82ac30b5ee48e7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230614123256epcas5p4d6f139c203e63e7d2749c256806916ce
References: <20230614123222.4167460-1-l.goehrs@pengutronix.de>
        <CGME20230614123256epcas5p4d6f139c203e63e7d2749c256806916ce@epcas5p4.samsung.com>
        <20230614123222.4167460-5-l.goehrs@pengutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 > This allows the usage of properties like termination-gpios and terminati=
on-
> ohms, which are specified in can-controller.yaml but were previously not
> usable due to additionalProperties: false.
>=20
> Signed-off-by: Leonard G=C3=B6hrs=20<l.goehrs=40pengutronix.de>=0D=0A>=20=
Suggested-by:=20Rob=20Herring=20<robh=40kernel.org>=0D=0ALooks=20good=20to=
=20me,=0D=0AReviewed-by:=20Chandrasekar=20Ramakrishnan=20<rcsekar=40samsung=
.com>=0D=0A>=20---=0D=0A>=20=20Documentation/devicetree/bindings/net/can/bo=
sch,m_can.yaml=20=7C=202=20+-=0D=0A>=20=201=20file=20changed,=201=20inserti=
on(+),=201=20deletion(-)=0D=0A>=20=0D=0A>=20diff=20--git=20a/Documentation/=
devicetree/bindings/net/can/bosch,m_can.yaml=0D=0A>=20b/Documentation/devic=
etree/bindings/net/can/bosch,m_can.yaml=0D=0A>=20index=2067879aab623b5..76c=
5024b6423e=20100644=0D=0A>=20---=20a/Documentation/devicetree/bindings/net/=
can/bosch,m_can.yaml=0D=0A>=20+++=20b/Documentation/devicetree/bindings/net=
/can/bosch,m_can.yaml=0D=0A>=20=40=40=20-128,7=20+128,7=20=40=40=20required=
:=0D=0A>=20=20=20=20-=20clock-names=0D=0A>=20=20=20=20-=20bosch,mram-cfg=0D=
=0A>=20=0D=0A>=20-additionalProperties:=20false=0D=0A>=20+unevaluatedProper=
ties:=20false=0D=0A>=20=0D=0A>=20=20examples:=0D=0A>=20=20=20=20-=20=7C=0D=
=0A>=20--=0D=0A>=202.39.2=0D=0A=0D=0A=0D=0A
