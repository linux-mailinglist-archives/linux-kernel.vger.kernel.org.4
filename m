Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9102668FFA3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 06:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjBIFHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 00:07:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjBIFHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 00:07:19 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C57A243;
        Wed,  8 Feb 2023 21:07:17 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3194A7K2021575;
        Thu, 9 Feb 2023 05:07:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=c2nGFy+IElPs29N+acJ3sqj/lLfs+KMgOgIaoRRzbrs=;
 b=jYsG49fMoBxeT4wGdWgqJu4eJVu0Y+m50+TtXu2WTAjcVy4FCujsNLlSnOGYTEO74erU
 usNrSr2IfwWKHeBwReGrAA0uZU1PEXAPqxOJ6fI3MgtZOopuSkuz3iaj4Kifpc+ofRlu
 dGzfsw+qwcY1fiyKNS4qdLmd17uGSQHc0klAom1FqLdpCNAvmNXq89jk9kKTJjwz109d
 GZkZ0y2vYx1HFNai+IfwQzqWAHIBnfNyij8vbNkzbEL76HEEs2SwFL71RVv8vLrHK/FW
 kemJbscrsB4ELgbfR58pXMFY6s4+Xv3HbbTtISxnMkKhUare9up3dDa9KRkXDdqXLpn1 RA== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nm1yf3hs0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Feb 2023 05:07:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CBsV+kHMCUMK86NjGU0gf/Wdmw698WQpGyYtkA7pREd4caLf6dLrrrBQJ8CoCyPvP6U7+2RvHKjIQu+qfjJ7a/nEv+qW/stA/nIk1mI6kHuTsnwfSWOkHIz0HaXYLx5B2jvkKZ3MbOFV4JbiLderW9d30WnoT/B328LvAoSfxQFWjZOj+wut+5UO1UoecUH9dzTGQCfybdwPwS6Hcb2XGHhYZ1ShuTHwLUtjDqze+/6C7pu0emMiODU7BCtNmkbLnjJL6RfThPEUxOznw3EQXWaLe5JXK2vL0VrSsdxkEhuu9HzkFp2Y3JxsVtCqBX5TCrT8fk0hGOt89vgonsnL5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c2nGFy+IElPs29N+acJ3sqj/lLfs+KMgOgIaoRRzbrs=;
 b=myDrg9JqejaepgbtkvkKMBlGvfMjJsyQR6On5MXqU0nphgTVK+BC5NgUEmpQd+2gYGDOvFEspsMkzYQZzq5nTihwjDuLq7YXvymG3wJ3U+IUbcK8Cw2mU+Ur74foe1aTUFTr38qcQFZZGqd/hSlLDkgvMvqbxzGfZLzebJYYuIycuSeV8qryqsDYiPqy6LF8BFR2BeqmxFg6atE4ntP4K027TvyJUjPova2oIK3RmEHinhtQDIqNDB50gjHKKjs80tykvfRY8o3JHrOwmcBqk/JekxxNpSRKI98HgCE42apHyzOkUuUiDI0dBgeyWqRUPjirZ048j8r72a5QNw2Vxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from SN6PR02MB4205.namprd02.prod.outlook.com (2603:10b6:805:35::17)
 by PH0PR02MB7622.namprd02.prod.outlook.com (2603:10b6:510:59::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Thu, 9 Feb
 2023 05:07:09 +0000
Received: from SN6PR02MB4205.namprd02.prod.outlook.com
 ([fe80::3b23:f0f1:e8fd:7fc0]) by SN6PR02MB4205.namprd02.prod.outlook.com
 ([fe80::3b23:f0f1:e8fd:7fc0%4]) with mapi id 15.20.6064.031; Thu, 9 Feb 2023
 05:07:08 +0000
From:   Brian Cain <bcain@quicinc.com>
To:     Yang Li <yang.lee@linux.alibaba.com>
CC:     "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: RE: [PATCH -next] hexagon: Fix warning comparing pointer to 0
Thread-Topic: [PATCH -next] hexagon: Fix warning comparing pointer to 0
Thread-Index: AQHZO1pBBQyAbx+bdEmFoZLArzIKPK7GEcuw
Date:   Thu, 9 Feb 2023 05:07:08 +0000
Message-ID: <SN6PR02MB4205B282F3C5BD2C9B3B07A4B8D99@SN6PR02MB4205.namprd02.prod.outlook.com>
References: <20230208011105.80219-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20230208011105.80219-1-yang.lee@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4205:EE_|PH0PR02MB7622:EE_
x-ms-office365-filtering-correlation-id: 12bd6485-5f9c-4fdf-9b82-08db0a5b7edc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 56bFoHpU44QJLIjGFfBKjPJZQxEg8FGgz/tIMVigqT4kwQ6BDSWNwigDudb4IApvaRPDgRwVjXhQybU20+s3nHkJRjevK7kvpvo9m2bZHMIANIV2gBDvD29iER2FgkztroLXI1ZlB2vloGWVCmfcoa0Wdu18uTHmWCoG8LIOya+UWZ4QZTwPb07ou+K70KrBgimC5hbar3qywL8TTRC86BosWEFNeYWwkr63QjXhRvDBcKoA69Ma8TAUtd0Y3jWbqH9rLAFZ9ImH5F11PgoE18JOHbjt/Wtza6qasmxdXYh07JwuHzC7Wb0S4H49BVzfjluMYUk6bMLLgVLgZHKN2z90HmeDC0oBp0diqnhvZROE2r9HuVdHte6gGe1TKBsO9NO8gCcDj3rJlLBS9h8+ZN7jYS3sRxN4S1YJHlq78hEcvE73JFQli7pxQn61NajsSV5vrPYDzRJKAH/xvNYl30Hc8qyGXUkM/+YMFTahfMkh1F9N9pl1i1eeULrgfmHvtppQdtoSxlcpbFL3OT3TwMFHXok6uS3gAn4m4gt3ziqIgMOhghMcOlQ1bA5z4uzMy9gmd4FfqB9QIC2pHi6+brScF5aJqVWEYC9ooQ7I0oQCHfN7lC9qrHk0THALbYXcaWoGud51KehbGxeyvS+v5OIArIyLN2iGTEddoK5PTwbVepsLzivYWeM+amOcRMIAB+3D+eOnYuV9hr9RwtSgqfpS5cBLp8OtUeR5hlfs0sA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR02MB4205.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(396003)(39860400002)(376002)(346002)(451199018)(86362001)(33656002)(38100700002)(122000001)(38070700005)(186003)(6916009)(66476007)(66556008)(64756008)(66446008)(66946007)(41300700001)(52536014)(8936002)(54906003)(316002)(5660300002)(4326008)(76116006)(8676002)(55016003)(2906002)(4744005)(83380400001)(966005)(478600001)(71200400001)(7696005)(9686003)(26005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EuwZxGk7rR3H+B8vf5hTjqPFRdKjdNSa7ASx2HBeCSEB3QX0UXPtGUi523b9?=
 =?us-ascii?Q?1F+fYukEJzKNxMTsM7L2j/0WbVAeHhOiy2ffF72KR8atkiSZQs4KTqszN3dO?=
 =?us-ascii?Q?5zA29MqqxwQhfyp87ry2CzLdY0fUafa98UNyck2NJnKuDbXrAzXxx4cpt7kk?=
 =?us-ascii?Q?JsYjFsyhPN1XISvZwjDrQuoUQpVM23pLz/LniW8ZZra9LkrQrxdpGaMu4yze?=
 =?us-ascii?Q?grl3ic6bGiWHEjoEPB1o6otwuHu9aryhtEmW1qKarPsvpfxyNJCXSlWUNL1e?=
 =?us-ascii?Q?ySAZN9REzq65zvT+papKLJb2K44WovOusCrRgV/wCE31DohwCcX9wmxG8GKx?=
 =?us-ascii?Q?a4bvZK32pf5TjK8emaY8wFFqPT/d5WOqMi0+1jc8QXQ6ZhUK5oCdxcS2Imr/?=
 =?us-ascii?Q?H+YxkY3u5318K0dK9HHLT2W6IQCn+9DfMnV21UZhmZbicRr13E+ZpZR0F1Wc?=
 =?us-ascii?Q?7RovLLjqtbag5Y21Yu9E0Sngincd9ZBpzOpCgA5I2qQUCBotcQTOjy6kiP6J?=
 =?us-ascii?Q?jbov/BOTM6gbL+F8v0FYzDt3+lnozVX5opjhpB2lAEzJ6TFnw9jChNXCuPG/?=
 =?us-ascii?Q?vAWDcQAA+uUYpVPGl0lznCeb2ZlWJF+zEnK9hhaKT9sFtAzQh+T0qBLgY0gD?=
 =?us-ascii?Q?Sn2FZ2ESnxwJ7vIE9J9xwaNhxQg0Xk0DMcvJDNyTtUm2ei+leOV0RTlzPoJY?=
 =?us-ascii?Q?uC0sfLE33tT9z5f6wpRvOM2ehp3fAy/vS/gul25zCGFUHXnGo2f6RWqp947z?=
 =?us-ascii?Q?m3oVB9HIn82weDMj7g4aDTWLizrh7ijLbkaftVBMrYDEXBSjElanU3qh0RJ9?=
 =?us-ascii?Q?qAJo3cSsVJLcxd1V+sDHYPmnABJ5+dXpQ18MiN528ZF9kNlRuC1pJOXFeHaV?=
 =?us-ascii?Q?DqkwhViihA2ixHpWBl/omkwDya5ftyo/DNvBVQo/HMg3zTMNNv8L/ecDU2XL?=
 =?us-ascii?Q?1+QA/6lTYhSW9QSapS+7IOTXoe3RzeVIpdhwToDrYedBkX9ST0I90Ag9bQ1/?=
 =?us-ascii?Q?MP5v1QhLjVyEkmU/2Hxt6SUSRxVch6ruEjXRmkPOk7Wkx1n+ifxgNbU8hAs1?=
 =?us-ascii?Q?vEOJk+U4yRRt4Lf17KMmF4gxo+V3F3vSCgJeDV4BpY+CgZNSG7r+qcxRTI/k?=
 =?us-ascii?Q?ZjeVR0DzNN0VPAgQqMRkQ6zWqdR3Q432wAykqeHYy/tpfHDxh3IZqW4bDfhD?=
 =?us-ascii?Q?2mFZXqrN8zpiEvBEnFr/H2OQ1xB/ettxkhQqBMHfl1Dn3gggMo/dKl4vpZZx?=
 =?us-ascii?Q?7/txuufQyHnCSTgZtlZtfdmTcmFIptKZsdVbV2/YqrdR3yDKnjV5jfq0iUGk?=
 =?us-ascii?Q?j1AfbwLPEqmZaGsBcJmJJpenUCzTLFAjdKTVeJvdN/DyAAc4wu0X8WgoNgCE?=
 =?us-ascii?Q?Nm/XnMloCgPIzCPvNN3kbNRnH/rHEGSrKRiuJGbZNxz4sdEGcH0OGfRBEi+a?=
 =?us-ascii?Q?b/o+4DV00fJ84FC5XgFZi3+G33xjqlUpbvWHex7hCIaiYKtCgVyJmtRwFIAL?=
 =?us-ascii?Q?nC98y81wPUBxvumwlK/RSwWzVdtSS30Osj5ipSWLtBwAiMM0Qmzq3E+TZSPU?=
 =?us-ascii?Q?Xvwd6RC2+nDLwzg3McFYqfKgt8QdHlyMESKtD1u/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: oy8+ssIWP7sn6tVSj+A3bh7ajJ2bPGRc++BstBgzDl3VSFXanrOZtSmSVdG1jk6D4CTlMwVPCvnsi7xoZVSHiveVcD9snohIC0pnGkF1kWLYiqiOi6oE+jG0KFTnvpoX1xa9zcbO/N8wVpsRkYy0SeBlWOIsJvrhjWWWOoz8HDez1Yygt5c2AbMgpzqUao+tP++pND/niYUlxo2SpiBo2s0dxeDO27OG1apVhZIVRoZI0Uo6H+ziz4aXPNLlEqSQpo+xVWBl7p5vGZIHUW22mSGzRssvj95SNZd/AYSESvk94PwUwcmtC8cuCiJbGMpAhCjl4ctiqOR5ZZ4nvUJeu6o1uT6WO83tlJIbLLhk7hKEH38S8KdQDLdryUwIzjMSULZ9syn513P7bFrtMpOD/5wRiVYbbvSQ4bac/h6TTwzDV6abnTL/w18ghvD7kECIqJ7TMcoAKW2tSZMj8O9H8UHwhNQKmVJUQtO4qrmzqyiKNxdi6YgBKFcGnc116i2qSxKjO5CQzqhwpmYfRiNnDCM3mXaSli1F6giawxUIPecJFv5nAaA5HpNsVX6t4DQp1Nbr/Epp2rC5bCsPAVbnf74G57KA9Ubez9IKamHqmOXNm1vF9cpReoVNjJPyl+76nrdriycj/MMGD2sBle8KnfYPgmZT0KkP85b/cTGS3O6+7G9Q/p5OW/HKP7rkk2vJn2czgoVItsNoGbmGIlxDOUGHA1nmA2TYPqv6cNdda/WrOMYw7UyDeRz/LTfRK1JLYEyd9jYbHhX5Hwrx4dPBKZkoF+AFDfTwS5q8sPoswixDIp0L/wwjUAcuDYfkhwVEa+AHRCywBvUDxi0jH3lV9g==
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4205.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12bd6485-5f9c-4fdf-9b82-08db0a5b7edc
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2023 05:07:08.9277
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lnTWd8ZM2oTkD+IH1D6F+2OPbruU6+r3FYOBRaohADzO7Uwcb2USsjlnNSYswNzbSyq126szcCwNoAzVdqZePQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7622
X-Proofpoint-ORIG-GUID: 7o3xmFpgiDLt9vDbEYmJ6djnHCOe70Aj
X-Proofpoint-GUID: 7o3xmFpgiDLt9vDbEYmJ6djnHCOe70Aj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-09_02,2023-02-08_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 mlxscore=0 phishscore=0 clxscore=1011
 mlxlogscore=437 suspectscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2302090046
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Yang Li <yang.lee@linux.alibaba.com>
...
> ./arch/hexagon/kernel/traps.c:138:6-7: WARNING comparing pointer to 0
>=20
> Avoid pointer type value compared with 0 to make code clear.
>=20
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D3978
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  arch/hexagon/kernel/traps.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/hexagon/kernel/traps.c b/arch/hexagon/kernel/traps.c
> index 6447763ce5a9..fdbbf78b4ce0 100644
> --- a/arch/hexagon/kernel/traps.c
> +++ b/arch/hexagon/kernel/traps.c
> @@ -135,7 +135,7 @@ static void do_show_stack(struct task_struct *task,
> unsigned long *fp,
>                 }
>=20
>                 /* Attempt to continue past exception. */
> -               if (0 =3D=3D newfp) {
> +               if (!newfp) {
>                         struct pt_regs *regs =3D (struct pt_regs *) (((vo=
id *)fp)
>                                                 + 8);
>=20
> --
> 2.20.1.7.g153144c

Acked-by: Brian Cain <bcain@quicinc.com>


