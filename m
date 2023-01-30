Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85DA96816B8
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 17:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236017AbjA3Qnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 11:43:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237686AbjA3Qn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 11:43:27 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C5823A874;
        Mon, 30 Jan 2023 08:43:24 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30UGQckK028007;
        Mon, 30 Jan 2023 16:43:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=OL0jQeLXNviyA+tR6w9sJgml8ooOC6G1slO1eMzLUOA=;
 b=fQEtQHdkTL39wuHQBfZ0JCINBGUmAgnRJjXvp8n7+/N3y0znNRjomlqwspSXkf7Kqdxd
 PGn5YRYFthqgtJVi46EgHh6Fecd3Jw7gzaoia3TELLHfILS4vSESuEvIDWt24lpoBiHz
 ESvOOeWxr6ETjM8en9kmEKDFaswJ18l+OwEaFEcXlHDKWmzs2uM4fZfvxClaMgMLums/
 2auxFg/Sc4Rw3VnhuMHt9hMtrRL6YbsAoaUYehI+u6/17UwYkC7SSKm2t4DTQC6ZrO1B
 Hojg8UQdXfcNbolYz9ja9A7DQzpuZuIFywdJxlSZ/eEL5Uipnwgrq++NWcUHv/q6K37k Fw== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nehdm813p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 16:43:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ao+Wh6gyHEz0ytMQkXgIwMtXDrrBIctm61CcX3hu41ihKNYHKxpAhAJw0QhuUVY4cdCD5dzx+YcNho5aShHiOwyQp1ROHYOsW8vfaj/QXyoT1Jqrup7EBtgdf+dB8egHwTdQ8R4+4xJbbv8MipozerjGv97o3b2tZeAhoQhnNso37ZkuPKCSpGq0kVotoj4vvi88p9/L+5Dm3qqwEu2c85n83dbOQz7QCdjk9nZwwT0CNbwUbf+vcmLOhWrXeVDDXf8B3STdctQQ/M8ebgdR/NhP0+1OU9YeZEGk//5+FhIj7H30eM9n1GEncuSkQwZtTEjZek6wVacCOUhdDVDolw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OL0jQeLXNviyA+tR6w9sJgml8ooOC6G1slO1eMzLUOA=;
 b=Al0cbdD4eP1B++Bb4Zxkziyarncb5y/S+TOMs8JijFx8iv/ZeoXEobA0wSNEz31suYhTwvz/UuuvBC341LMkl1dUQJrB7tTS1Or2i+QCpD3ayEi5FLyiUeVAJKuPEKc3H2ZYgTl1CkwHEStBNnj9GnzNIVvpkv0xREXmxn5XmgFRnYCMUmZZSVcc1EdaembLhpiU4YXomx7hzMHYWBw3evLgdWViZbMrriEPIonqCj1VDwIjo6MTe9vPb1Ev2uZej3hZpdBkcPucdCsCp1hutnAS2n2t2OcGOXyuiLZciMoZXShcHaKV25K6JHj3vguOya2zB82smIQR5eVyTR325A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from SN6PR02MB4205.namprd02.prod.outlook.com (2603:10b6:805:35::17)
 by CH0PR02MB8275.namprd02.prod.outlook.com (2603:10b6:610:fb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Mon, 30 Jan
 2023 16:43:17 +0000
Received: from SN6PR02MB4205.namprd02.prod.outlook.com
 ([fe80::ee73:33f1:8e40:ce2e]) by SN6PR02MB4205.namprd02.prod.outlook.com
 ([fe80::ee73:33f1:8e40:ce2e%7]) with mapi id 15.20.6043.033; Mon, 30 Jan 2023
 16:43:15 +0000
From:   Brian Cain <bcain@quicinc.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
CC:     "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: RE: [PATCH] trap: Fix warning comparing pointer to 0
Thread-Topic: [PATCH] trap: Fix warning comparing pointer to 0
Thread-Index: AQHZMvx1VNpDD0t5kkeohxxgqDFCAq63Lcrw
Date:   Mon, 30 Jan 2023 16:43:15 +0000
Message-ID: <SN6PR02MB4205F8504967B809BA7EEFBFB8D39@SN6PR02MB4205.namprd02.prod.outlook.com>
References: <20230128093920.2729-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20230128093920.2729-1-jiapeng.chong@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4205:EE_|CH0PR02MB8275:EE_
x-ms-office365-filtering-correlation-id: 25d89554-9450-4b2c-6b9f-08db02e11584
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U/NjrPAe2zqSinzrcK7ss9xQpPiXRs9MeA5loj57GQmTmsrCN53fbuvWm4esMFK1n8Cvw/+ByM6dF9LQBnP09FyBBU4k7GYLyJQfwY6gcHxl3IN2zOuBnUvYPDMwpdpqEZnFlofWhhYW8PdBJAXl5rB+CMPCxsyE4l9TZjTY9gXiZYJptaeC8j8gR4R8h8D/tSsoxy7BzLHNpfmtiPXrAR2yZdxjmJa0BIvLX94NaC1F618NnZIFuKNwMLRrPRxoD6vmpUcVMMyQml4AHbxuXot4gPmymWulm3x0gW9VdGlORbP2Vnkz/FSfHh/Q4m1FGZH/EP2fD+i3jb1zEB07aHestToCnjgadUxKkxS3n2XJUui65pQ/5g9IwHm2KUvDMOb+kPkfj19U2mZXm7Lc+37NaOjLHDkEcaNAnlhRYlqlXNco0ArRZSCocaqG7JBUxbwKPJbEdxBfjGj3XzkJn88nXqSqdDM3+bsBMFLH3isL6+vQ53Seol1qWA1LbONlMn3YCtbI4Ja1rAHD9RosS1FS+ZQuzqYF5DkarkKpCKIza9oXx7g20bLdUr/VxR1P0spgvUw9oee9MAu/PWNumN83ZkMR60eh/TeJzzkTKreh8TyZZnEpyq2wLBk+IU7+Y/4nyF+NbfyKig5ySzW3ZgMnIOdkZTxErjJ5GAxU5D9cNuRrM4SPv04xVkNeeUDW8xF/E78PZs2P00aWk5adOkt2g4pl2MU1/KwnkgUE0sw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR02MB4205.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(39860400002)(396003)(366004)(376002)(451199018)(8936002)(316002)(66946007)(52536014)(54906003)(66446008)(66476007)(4326008)(8676002)(66556008)(6916009)(76116006)(64756008)(5660300002)(38100700002)(122000001)(33656002)(86362001)(38070700005)(966005)(71200400001)(6506007)(186003)(26005)(9686003)(41300700001)(4744005)(55016003)(2906002)(478600001)(7696005)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?inpk2xrAWlL+ygMg07IL3NFniMev56U7WatBH2/aotev5+1z+K0GUKo2LSFp?=
 =?us-ascii?Q?6t8MqHKaSa/JCs7nBjOYG6Sgd9cy6ZtZqP9VxsbKqorR4d4fXgUq7WBT2UCD?=
 =?us-ascii?Q?EqzQBLys/abKhcptbhCbAn4Ibs639Qyk+/7HlDpvCv/CjyZETQ2qTWKX4Tri?=
 =?us-ascii?Q?xJfR74T7TBEPPGiq7QlorqnZYPdVS6+NMUkIVfI3t93wdhJYuiFYbBXedFht?=
 =?us-ascii?Q?shMKTKA+Reg23/FLxRQRDzwza/5ELuB8Nj3TiAUXSCMI+i2S2yMtOvZUsdPd?=
 =?us-ascii?Q?0R9ap4Qqum3NsuN9/Pwc/Cm+fFqpK1ACohHyXXuWh7wvN2JZ5aWp6V1cCm53?=
 =?us-ascii?Q?n8RcgNYUiiM/sPj4a5Xpg6BUz4LrzcA6OzD9BS5LI7ZItneVbi20YVXjp2EW?=
 =?us-ascii?Q?5C33kqIAeYQTuhvs69OoWlHU7CuKn20JqrSOWQbYeLczu3x4XUD28UVOXR3v?=
 =?us-ascii?Q?gSAipUZJ0yn/Tic5ZZqAKoAm38M+RixEuNuK2NislalAOmKOBfqcOg90ADfM?=
 =?us-ascii?Q?/KpQqq1J9cJmSPNCFW3VFsoGTqFdMZeKzbLPBOmj4Qr1103M7zzIs77GRVfa?=
 =?us-ascii?Q?kh2U5x9HPVqRXIDe62QARnBza+LgL3KPAqK6lc/MO7Us+mb+4zm6AGb0MAEf?=
 =?us-ascii?Q?nz9e9iJereHs3wX3OKrj4JQX4icFoMbN95owA/1YYUAUUo03lv8r0FxsOS+K?=
 =?us-ascii?Q?ihiYUs48Tnevk6vBX/8X2QaMnVHa16MQtxFUD2gnCPDEV9EQZ1qU5ORaxi5e?=
 =?us-ascii?Q?e0RaeU7fftE/bQi2bIeDgRSzkb6XLat5bNTwYw20Rj5D2eXHxvP1oHv5/07d?=
 =?us-ascii?Q?7cwSmS1hT2UPtqI00UWOP4bKtBfJ+He+uE4FpH79lPLQPRuHnIQfW1xSbQzF?=
 =?us-ascii?Q?mXhFJ86hIa/yzNQwrtocyarNdCop1qBYKRYTeMVTdYAWAeZyqeyH6TvfhQMN?=
 =?us-ascii?Q?U/Ilmd1Xydl6nlV1bfl7YTJZU+1W/9qytK3tbP2/NhKcw55Jbi0Tyyg4/4yy?=
 =?us-ascii?Q?92m4liO+TiIF4ACRZ1vhr1WfZev1tu+BUDjaUaPP/7+RF4Ylx/SwT1dWEYMM?=
 =?us-ascii?Q?QjZz0fQ3X4tc9FGUGvZzDIJB2IEQnX7j5hFgZSYdzHtPUVyyJ8GtYDPfWKh9?=
 =?us-ascii?Q?LNmTyXuq/fJzg3TiRuXyqEiVjabyD8IrT6x69pk3IP9n6oGbxWr58WXXmHyW?=
 =?us-ascii?Q?++uqHc6FCO3uB4c37bgCShHc8YoBal+hRMLCt/mHuQdSPzuTNFG1H7L8VREL?=
 =?us-ascii?Q?awAlq7LfLXfcJgMd2PKG04YJvJo+kZE0m103QgDEuj4jkYZ+SE75QH6gRYKd?=
 =?us-ascii?Q?zi2W0LI5zzXkZ5mV0Pbgu+TrpAU2roM5rSvNHE9YEJMCH5opgGB35ge4by/8?=
 =?us-ascii?Q?Ii5dgMgD3N/7ihek6sDhLFle3Dc1k7wM5IVm20AxQGkcY94dpzhAPyGY+uXM?=
 =?us-ascii?Q?JoirVBwnc2dTwh/Q4KIYE4kqsc63U+4Oy0nMkmTedD8CZPbWmsY+YkRHYxrY?=
 =?us-ascii?Q?h402CjP7E+1P/Rj4VlmQf7r0YwNJ3P3YpWH1lxooGLet47LVpnwl+vypV0Gt?=
 =?us-ascii?Q?f5AD4PKkdYZsnkjxa5dbYIZGC0xxtphB8hvY9sdn?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6InZKcfeIDT88/7+SlPcF0DCFslvj4hiv5QDrDfjNqx222ywQMC8wGTrpePY3SacJ9qcMOfXx6OcLqApfMNDZSbXQ/vU3oeSKA6u4FNg/6oVA98aHu5635ple/81Abt1CyUyQq74b0SDoiNKtHZ+XB0RLxX8K82nzFlHxFg4MdioIpJRIyoSQ99jBI0vCUWN1NU4EGtCdxC1uKF/ToBJoIs72F3Wgv0BOoYUgo5K7nc874/iSKDq324i3FTsgXGLaZMTeztOGMpFVaP1pJKZdkHiqc9zcRmRjoaUXHsExdmKeQtuErAdNpCDX8OzYrzhVj1xQaS7oToGsqt1k8zqdAXR4Yp/iVyZZi8MDbcIBUrurA+2fGmtgtu10HAxdylAQBjIByIcudC3EQc+vGpImq3DpJAh1pEVIz+kdN4dVrfarqA+naN00AW2lUFVYNrcmv6X0KFFgJLl3AC7oI76UKZSZDRkP7p/4UdH7HLkoZGFZAd/74/uNVJt2jxDGUzPKu7q2Z6DwjvHhCTpBiIjEvdgOWiXJdZurmAxIQ9JBq8W1lfGEWDxmAn6q43hWZYIuUM9IvpDANAQ7agxjlyg1bbUbsOftFQIILEmgm0fKxpTt+3E7FavpMQxp+1k+inyyiusIdggbAsFjODq1GPquU6H0Toc23aYS2bVoc+jl6rDMNLOHRzz/oQhwweYHjPAEMDEmccQfuHuLKDB9dDrO3tDu5K2HyQ2GFaEaa+K9W5zbyAiNV8vGm4Cxu24WigPCydjriQN8qfsovD2R80Xd0cVe28WC1+Ra2lDWM6+3voP7krLYzOYmwa9P6QTb6ZEZY1EfFSEtEdZ5upioGrw1g==
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4205.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25d89554-9450-4b2c-6b9f-08db02e11584
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2023 16:43:15.4485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PvwCwi/0NIFwxhO3YijRX5ktF6xyyaUJbNCtKpYhZPzcPn91TkHBHvN0ac83IFPLk0v0SBHzxLiMJbsnYz4cuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB8275
X-Proofpoint-ORIG-GUID: e0GAe1C_Vzh4_eai4F1QKOkCateV5Kpq
X-Proofpoint-GUID: e0GAe1C_Vzh4_eai4F1QKOkCateV5Kpq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_16,2023-01-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 suspectscore=0 clxscore=1011 mlxscore=0 spamscore=0
 malwarescore=0 mlxlogscore=610 phishscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301300161
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
...
>=20
> Avoid pointer type value compared with 0 to make code clear.
>=20
> ./arch/hexagon/kernel/traps.c:138:6-7: WARNING comparing pointer to 0.
>=20
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D3860
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
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
