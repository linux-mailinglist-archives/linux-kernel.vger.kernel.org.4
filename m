Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6606D8ECF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 07:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235031AbjDFFb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 01:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjDFFb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 01:31:57 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2085.outbound.protection.outlook.com [40.107.104.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40499903A;
        Wed,  5 Apr 2023 22:31:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gQRu38+eXbOGpTyzVIJ+d9c80xsfjVvSwwG+6leFJQq1qg7lWo23WQk7uLz4I5GqPUk79wn1MjSQ6jZEeoUyRz+dtZjtrvo/UbKKQnoG4Jir1pQv16uysoRoloUEYzlj2p8q8VlIMM0US3UD0G0H5q3IsT5+tAtcwrHasmRkMrYWvN3GDRiVK97nhDDms5aTH8lzkqj2G0JmffjK2/girqED2F7U7EMw4T39h03pdvR7Bf2fnAtp/zW46Eid8QhqasKzuX/RuvsoqakDSOaZJVnUTaiDI/+X90yXU021IPXIROfzZQA6ynQ+jbdWb49gKcWkMpXUsBMSFegU8ai7lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fS86FlQcKztKHrDg6ffj8W41544VCRPfDbFqfSDMrrc=;
 b=FbM8LaBOoAOiVN0zCh9r3XiVAA48SsZ3U8C8o9Jdpce2yWkdEIKF3VDu8Q8KUJYQktMgDPOxPzHJ1XhanUTYGKKREGVRL6t7XTgukMjfdnLGf1JuYzaRHmOjT6yS8r0JnYBW27pfh/sMvGj5pKW5Tjzczt9eREg6WvjMlVS9Fg28BMk75e/DjFWDlPs4+wET1LmkayoRiT/+ENfirBd0w7YZSutqtWwzuDtZTm4rbQlYlgsT++XvT3UIV/ImalCmtjcQKlvE7KBNicgQDPVEWYKS3GKKLGs2vW+4KLA94Ej+8Pt4PyfWiLVNZa/uRsilLG7O90dDMYg4oJOVkSARrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fS86FlQcKztKHrDg6ffj8W41544VCRPfDbFqfSDMrrc=;
 b=0Du5867pXW1lSgtc/sBbRaA3PVvkR7CEj5/CV1oWZ/g+3+49KJHSC6Ck4/LNtWLRvJLkTSJK8WDqt6yTkrzyhWjbH61iatLuVtuyjbCCS+fpVrP6vHvzsvlIQFc6ET7jWbJgpnB1LX3OihtQQIJ4+lvGT1Mlw25K2EWZn8CjarziY+t5MaNHT1SG3XeW15jC2UPwahTOtyAKpv++PJsh7Qm0T3J9m6ctySLGB9sVRDPJJBFC7CeKYsxHEdx4hh5hD7N1Ojg/hHzXRyK+YlETwMWT8DrAJ6BdHntLvkk99pw1zbpGJILVgr05fLitAjX//C7wD1Z4W/t2ucz4eXB4cw==
Received: from AS4PR10MB5895.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:517::18)
 by AM7PR10MB3127.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:106::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.30; Thu, 6 Apr
 2023 05:31:54 +0000
Received: from AS4PR10MB5895.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7268:b477:8203:8c6a]) by AS4PR10MB5895.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7268:b477:8203:8c6a%9]) with mapi id 15.20.6277.028; Thu, 6 Apr 2023
 05:31:54 +0000
From:   "Starke, Daniel" <daniel.starke@siemens.com>
To:     =?iso-8859-1?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC:     linux-serial <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 4/9] tty: n_gsm: fix unneeded initialization of ret in
 gsm_dlci_config
Thread-Topic: [PATCH 4/9] tty: n_gsm: fix unneeded initialization of ret in
 gsm_dlci_config
Thread-Index: AQHZZ5ffOE4Q3Wd0YUq3rGUD8vSlua8dwwAg
Date:   Thu, 6 Apr 2023 05:31:54 +0000
Message-ID: <AS4PR10MB58958C282E7E0FB653BC9406E0919@AS4PR10MB5895.EURPRD10.PROD.OUTLOOK.COM>
References: <20230405054730.3850-1-daniel.starke@siemens.com>
 <20230405054730.3850-4-daniel.starke@siemens.com>
 <2d67db22-3a5d-1ed7-cfa7-d549aa1475b@linux.intel.com>
In-Reply-To: <2d67db22-3a5d-1ed7-cfa7-d549aa1475b@linux.intel.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2023-04-06T05:31:52Z;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Privileged;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=d0cc106f-30fe-496b-b1eb-177801be3abf;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0
document_confidentiality: Restricted
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR10MB5895:EE_|AM7PR10MB3127:EE_
x-ms-office365-filtering-correlation-id: 9566d652-9ff2-426e-4272-08db36603b31
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5Nuk79wue4x7rcZQo6XlOfY7Szmlc+8RFRABzIgb5VsBLFfparFlsWDqGa6zOjv87FteMkPwOietrTVwpPiimDBWx6q1bb3fm+xwvWyssYUVeDk6fTYySv0vwnFkW6Z5SgUV5Yuu5WpMmkHBSQGQpXPfiqIC3XFskueilRRsnRhiuFla6Z3KaqKrMfedL+dhz3K3WYI2bUjr8Nv7IJx5sm7MyN2rquFiTL/Dkh8I7AodBFuARbf50pKCwxb3DZWbRaN/HCd6aaQSa3ly9L4pbrnGOTnu8tJ33p7d/JxtITO8J2MqhgIRI5gamJGxY9v3NPLMjrDearnpAzhnN5CF/0K6K8KUs5NN39UMkjktDfC5icvWdIWMM5kgjblBssHYimM7TVmPUzdY6P5CvzMETaiQzGfxrczQNYQTWDVnL7verHLLQAEWTEfr/aer3dq8mJ5P/6VUdiHVvQoToSmMP9Yd6HqibH7uexbtfxISR9D380B1paIXSYCry0sNEnD+II+7FPPUkDJkJuCGCrvS8an0T6lqXD+QBpiYmk+O0x/zkjcTacGeQgKaL/dnaL5JUsg66S7fwmBpFWR5+tB2sHStq9Y4wvJ5lzy/aNAVto0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB5895.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(39860400002)(346002)(136003)(376002)(451199021)(41300700001)(2906002)(122000001)(7696005)(86362001)(38070700005)(186003)(54906003)(8676002)(966005)(6916009)(4326008)(82960400001)(71200400001)(478600001)(38100700002)(76116006)(66946007)(66556008)(64756008)(66446008)(66476007)(83380400001)(316002)(26005)(8936002)(52536014)(5660300002)(6506007)(9686003)(33656002)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?O7L9BpOrMLRHKP9hqp5ysmlWEhocXx0aiFzXS3rbWIc7YxRyAcXvP99kz5?=
 =?iso-8859-1?Q?5AznooCOf71Z9o7+2mmI3JybewrQz+ZhVJDvnC/WwCaimIROC8Xg3vn5Y3?=
 =?iso-8859-1?Q?aBvWIiPl8ojCYmtVfUxt7gpeBXbJPZp5EPJ+9Nq7KoH+fiYGisRELG/Ehx?=
 =?iso-8859-1?Q?NGpQLkiuIhuRkBs5ZutzPMoQp2RMnSgA0WRR3tNzjknUgWR1LYyfEoj7io?=
 =?iso-8859-1?Q?m+7h4hMPlgyIo+cstpStg66wBAq4I14HqMGx1Cz6buR98OGxwqapygkpI8?=
 =?iso-8859-1?Q?IEmtH4uKtB+qK8asx/OjbwjMlyfPr0zBuuLbofQdxRQxeWJV3ne9SM++q1?=
 =?iso-8859-1?Q?xzTdKWFjP+DIijcIhv6OkIJNWKR+68unFKODv6ryFnIS93Qn42kWwh01+f?=
 =?iso-8859-1?Q?USE2fnFbJ/urBLKanauD7vLo/CCTTQzGpZHmMv4/6OVkKVqzN+sHzjeQts?=
 =?iso-8859-1?Q?p+qRQpN8R8TG7t1q9Jy2Ncor0UE9ahX0U06DyXioNNu4WO709RwUMJH7Qj?=
 =?iso-8859-1?Q?aVlHXrXEznvr802GWKDI74dvM+hBeoU51BRtdK1R++SwYCaKYJP6OPmE8c?=
 =?iso-8859-1?Q?w0pW9Dd1kboJ/NGj4JDyiI7dUk2Eu/Qp6lpM9QlA+RlkoJldJty53iLZw4?=
 =?iso-8859-1?Q?NUI4rVSOcNfRw3p180l6GynZUjrf5jxhZmP2uluqIanwmq7IIhA55q2Hec?=
 =?iso-8859-1?Q?gdA0ldcDD3BTAAClS2HkRTBNHDG14Mf2440miiP3vI0ODoZT0vc5/1gZ9B?=
 =?iso-8859-1?Q?H2HCGBCmkfomQocQrgzpM7Yb1TIwH8+M7vD/mtJbrll71/j6N+Hr8OwmYb?=
 =?iso-8859-1?Q?oV9dH5u6OiFfcJS3DzmqoOI/hQM0utsqoo6uOELLPWvJN+pC15HxpmsO7l?=
 =?iso-8859-1?Q?35nEe9gsHGEDEPZzbM5UgKprlZeOtkzdEJWKeH0Iw/oDoz/pHG5tpzAqnN?=
 =?iso-8859-1?Q?0bo3m25eUGAuttP32WUUN86FAGkHeC1lKx0W7heLaJ4V7o8Tyrn/7SV16C?=
 =?iso-8859-1?Q?wg7AIPT8gxR8TLfKYzSBLdi62vuhdRc2Bk11CuNnmIv07eW9xF/b1d0K86?=
 =?iso-8859-1?Q?iY7asIl664FaRpnx0nNvge8wSzV9zpbw5YSsKMtgyjiygB+60NSuAQ+t3n?=
 =?iso-8859-1?Q?KrAfyBGAeKr0zpDxaKShVKl/u0p/C9cWXlq39wE9Otmu3AiAFXExIvMhpZ?=
 =?iso-8859-1?Q?CzyeQtq+WVnLY/UgeKw39+JXZTu6qa2ceUbXupKfFiYgce+u7Ef78zNaB3?=
 =?iso-8859-1?Q?lpP7AMJykpHO9ZNZWSPtlE1W0hNLRLpvPmEFC7WdMBUU2dvr27454miH+G?=
 =?iso-8859-1?Q?dV012CTWJZLE6PBbKppmQIHgFMSHcVuETYvg4VBeC/F3h5anTG4z7T++A0?=
 =?iso-8859-1?Q?JCCG02spdeVK3W75iNPGcjcIIK5H4zoQf8yqmvBzy6EgaN0nxpkjBQMsQP?=
 =?iso-8859-1?Q?EeDI2Hn9NzhiQJFLOn/2L2qJFlZ0nC1+8WkZMbqiYElan1g3t0ugfAn6na?=
 =?iso-8859-1?Q?Plo6jGgmsB3eGVT651i0aH5f9RVL3o0eBTPCQXXLmETpYyCVwjvCdiTzuM?=
 =?iso-8859-1?Q?kMDok18STIk7MbUkRjIbwo2ka/L/SRxa7rhy9eX6Dmg7gmTIv0wHukJoi1?=
 =?iso-8859-1?Q?u2AxrErxxh0rDFiTE2hhi6RODMDmYvYlLb?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB5895.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9566d652-9ff2-426e-4272-08db36603b31
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2023 05:31:54.0596
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1YZqEojxtEJ9JniTGBAZbsGbfzRzOavlzUP+X40OsD8IOmAH4doZlcpKo2KODTPvbyLsDHXzkZ6US3tqhwBCGsp/z+M32rOfAPoEJ+PS82M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3127
X-Spam-Status: No, score=1.1 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > From: Daniel Starke <daniel.starke@siemens.com>
> >=20
> > The variable 'ret' is not used before assignment from gsm_activate_mux(=
).
> > Still it gets initialized to zero at declaration.
> >=20
> > Fix this as remarked in the link below by removing the initialization.
> >=20
> > Fixes: edd5f60c3400 ("tty: n_gsm: fix mux activation issues in gsm_conf=
ig()")
>=20
> This doesn't "fix" any bug so Fixes tag seems inappropriate unless does i=
t=20
> fix a compiler warning (in which case you should quote the warning in=20
> this changelog and state you're fixing this warning from compiler)?

No, it does not change any compiler warning. I will remove the tag.

> > Link: https://lore.kernel.org/all/b42bc4d1-cc9d-d115-c981-aaa053bdc59f@=
kernel.org/
> >=20
> > Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
> > ---
> >  drivers/tty/n_gsm.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
> > index eb21ca583642..d42b92cbae88 100644
> > --- a/drivers/tty/n_gsm.c
> > +++ b/drivers/tty/n_gsm.c
> > @@ -3276,7 +3276,7 @@ static void gsm_copy_config_values(struct gsm_mux=
 *gsm,
> > =20
> >  static int gsm_config(struct gsm_mux *gsm, struct gsm_config *c)
> >  {
> > -	int ret =3D 0;
> > +	int ret;
>=20
> While at it, I'd move the declaration into the block where it's used so=20
> the scope where the variable is used is easier to see on the first glance=
.

I will move it accordingly.

Best regards,
Daniel Starke
