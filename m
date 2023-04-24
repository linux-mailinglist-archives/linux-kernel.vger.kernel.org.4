Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 440836EC45B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 06:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbjDXEZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 00:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjDXEZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 00:25:43 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D7BF2729;
        Sun, 23 Apr 2023 21:25:42 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33O4MskA003158;
        Sun, 23 Apr 2023 21:25:29 -0700
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3q4egjp35c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 23 Apr 2023 21:25:29 -0700
Received: from m0045849.ppops.net (m0045849.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33O4PSgM008120;
        Sun, 23 Apr 2023 21:25:28 -0700
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3q4egjp35a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 23 Apr 2023 21:25:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c98gvqMQuQ7YA92lbVdMwuDU7rf1ng1lckKFm/hNk9EWh6NPibhK0QtNQy2DhGbIfflGhxLWTRViuvesFgNUf91tqQ13bzfzaGks5eo9zyZuabe4qcZER81vGAvbXdkqLx4+nqgl8dPufB8jhiazd3vvpaOdES/zIPRBWAsCg3kO5irPyQkCVW2i8W9DQp8lyXDvgQvbtHApvQSTWlEqKYf63P/HN+/cT8MEJPZmzlm9IkHMtoDyuyUvsIY+Fgk1DTIznbSzmmqQH248fHQqp3i006aTNV3u9HVcD7zcnXYdhcfNAKMV6vP1gTVlEIC6HCt0AY/Bdz/Z+nT09pkEKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NCl2myddSYC0fcShTgje342UVq2/Wnrdy7jzrZrVB6k=;
 b=dXjk0z/hSVIhSNUEZ7HbHX1d61NbHiwTXw6jL1PK/3SVAf5eKgegQWYSVYYSEXPQFmuN1c9T1hjGk8q8/0238FJmvufUry092mCfcBu2dRI1vy4gJuk0vCd1DSekMMuoxBaRhj2nJIKAVPxFPTYgJUTPYtPfi7wKoTR9WilJWvoLD8eocA0ukbg1GgoUokSTlJVcdIW4UvPtJ13kLtOK7ysoVUFFvRR0kjHDPoBE1ct0sr15fwIjstNNNdRmtgklPMBwviueKLnR5xcPmPzBF2kMEySjuDIGM4/rtasukMIVl2VRFY2gNJzKaQaGUW0SOuXPhgKAm7dMZK1vD5jh/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NCl2myddSYC0fcShTgje342UVq2/Wnrdy7jzrZrVB6k=;
 b=aY/cgk3l0evDY/UZexn+w7DT3MTDQ4YO+OCxH48dix76RFvRigmuBFBKWiTK3mlMw8LEgciOWysRHVx/Kk5soW8385n8kCE/dscXRKZgxyruFdp+7CgjWBAQ7xKKQ4/2FJArR6BSkodSUkppOqfoYO0DLgLuzPJ2ukC+QTyN7tk=
Received: from CO6PR18MB4419.namprd18.prod.outlook.com (2603:10b6:5:35a::11)
 by DM6PR18MB3226.namprd18.prod.outlook.com (2603:10b6:5:1cd::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.32; Mon, 24 Apr
 2023 04:25:24 +0000
Received: from CO6PR18MB4419.namprd18.prod.outlook.com
 ([fe80::8f16:bff7:799d:e8d0]) by CO6PR18MB4419.namprd18.prod.outlook.com
 ([fe80::8f16:bff7:799d:e8d0%4]) with mapi id 15.20.6319.033; Mon, 24 Apr 2023
 04:25:24 +0000
From:   Manish Rangankar <mrangankar@marvell.com>
To:     Peizhi Li <meetlpz@hust.edu.cn>,
        Nilesh Javali <njavali@marvell.com>,
        GR-QLogic-Storage-Upstream <GR-QLogic-Storage-Upstream@marvell.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
CC:     "hust-os-kernel-patches@googlegroups.com" 
        <hust-os-kernel-patches@googlegroups.com>,
        Dongliang Mu <dzm91@hust.edu.cn>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] [PATCH] scsi: qedi: qedi_main.c: modify the code flow in
 'qedi_alloc_global_queues'
Thread-Topic: [EXT] [PATCH] scsi: qedi: qedi_main.c: modify the code flow in
 'qedi_alloc_global_queues'
Thread-Index: AQHZdQOsR97D8rxEU0Oo/XVzZpX0Wa8531uA
Date:   Mon, 24 Apr 2023 04:25:23 +0000
Message-ID: <CO6PR18MB44193EF2E69E60D525D72245D8679@CO6PR18MB4419.namprd18.prod.outlook.com>
References: <20230422101626.1722235-1-meetlpz@hust.edu.cn>
In-Reply-To: <20230422101626.1722235-1-meetlpz@hust.edu.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4419:EE_|DM6PR18MB3226:EE_
x-ms-office365-filtering-correlation-id: 92bd07f1-d173-4dfa-1aa5-08db447bec5f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U5Up1d7GSMQ0MWoed6EvMa8ALFaJTLdKxfOuVwNUsDpDZpuGRQJ+mld+ckMIdCVApY3Lb66ta6rvQC5EiSrVFZx4PApmdKHDllhnxuN27eaARiFiqjAO0lDNjDe8v8GMep83im6/i9JrpPp3fF8/YSlzHdvghVIe26HxzemcGoG/U3NqHLiphk2VwHt3cvRtu/v/wmu8Uc+wm+Lh82XUxwLDVRIEHpTlOkAznCMTlTfSImL+tVtKt7wQMl1QFfC9NRB7D5soY6R2KLtuNaBMaSRaOuRl22t6q+PU6daL/IE2XWEvzCfdUqf52jwh3tHD7lHJV3bW86cV7ncJiL69mqlSmWfFMzFzwsd8vTjAbdylY32dNZBE0tlPdF2SzKJcEkm08kM4TJQod1LvLw7pmqSyWzxE0nMwSjE3GFrB6fdU6G2SPeSTXXhBU0CQuaGm8DpltP8P+H6w9OPxLohWzpChsqOJTVGmf35uRTbCxDMzMo3h9cQa9MaMwMn6wjqdfJ0g/tIZOSuTtw65oiydlhdbsJCCD3kiAf1ycg7kjS3Qg3x4PgYa9CUfKAJWNG+t6gQjkYV40pA/XFNOCObf0E4kL0/o2/yn+zRTobU3ZuI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR18MB4419.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(39850400004)(396003)(366004)(451199021)(54906003)(110136005)(38070700005)(19627235002)(478600001)(316002)(4326008)(76116006)(64756008)(66446008)(66476007)(66556008)(55016003)(66946007)(122000001)(41300700001)(2906002)(8936002)(8676002)(52536014)(5660300002)(38100700002)(966005)(9686003)(6506007)(26005)(53546011)(86362001)(186003)(33656002)(83380400001)(71200400001)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VlhnlDRJgX/f2fROEeY+5ZeXG821CG1oR8Wf2mYENkizQy44z7uZwsZC65XZ?=
 =?us-ascii?Q?ik6ByZcw5GdAHEhtvHHA+bCnKEGkx+2xjKxSVL+otFMp16xQJztUBp9+G/Nh?=
 =?us-ascii?Q?nswOVqfoq33Jd0MFeUwxbGc6Tb3Sl8OWZXwcxtfx47CHLP1Ye5Nt0nAMuIJg?=
 =?us-ascii?Q?6JM9gHsHmL5+ADfHgwZRBLYq2xKc2tkJ2CH/poKmBtfse5tuu5SL2hYJXXRd?=
 =?us-ascii?Q?O04ZTw19x2tAAObwR0NGMK01JXvLWWXbQv3y0DcLV6RDyr6z/EJzBSgntELN?=
 =?us-ascii?Q?A9I9hjK4anAxovE8al+yb/Xceiyx8lhHDoHPgL0N6rdpS4r2dLHyp6usboRh?=
 =?us-ascii?Q?zhF6Mcv+x+30oGc/q7RhxSdXiREEz25D0mFTCQpLVaChQN7lF5lBYoGSDCfX?=
 =?us-ascii?Q?9y3+17NcmttOx4G4GcnYTV1sZ7WSbzI0AGsaQ1h81WVXPkvbN73HRXvjNOoH?=
 =?us-ascii?Q?pyJX8sW1tqcNb/GQUn+/8BufoXrJ0thvdYBgIMCcfx+qnrt+qkf97rdFPfA1?=
 =?us-ascii?Q?nU2C/u4SYEGF8/Lm6al3Y7vdq+5PLE7SnXa2F952AApZFZMsGKr3pyLdZN2V?=
 =?us-ascii?Q?IwXE7AaHAZdaxhyRaFPYacs7sxtopaxAOjI7WFjZEpmRPC3GNuO9uTHrxEiq?=
 =?us-ascii?Q?If8TObCs6VKeytGs5qAPMd+YexB6omFZ6hxphv+jUNrZg5MS9jWUU1a1VXl5?=
 =?us-ascii?Q?5cHC0fFVDyIZfyqQP4alL1hH/FC2gPnc+30PzUfm9MrXk+qUQpFeKWFZDW5Q?=
 =?us-ascii?Q?XbyhdNx4I3HXmEYyaUmwA4j072pK/iOf5wnh7RUbA/POh+rxPDCvndhWNF+C?=
 =?us-ascii?Q?sfm7PTlIIKNteWgu8TwTWq2+qmNWndwPvBGblAjmXAsVXgYnrZCOkoscMR2I?=
 =?us-ascii?Q?otKG+JBJUpRpfxWy0NdzxQoz+7RKK9ydKzQK5VU1GDzBXv5SttG/FtA+NrXa?=
 =?us-ascii?Q?g9D7vzYIGOhrP+8aE9foQVvwlGQFXVsPgE7bnZ174Gnt8TZXisi5mAHdAM+B?=
 =?us-ascii?Q?6YtDuzjOaE3i9pvCWjaH+XZezagrLW6XjO81Jf2+/lA8KsCdTUx+BlEyjpUp?=
 =?us-ascii?Q?jFlmjvtMo2tpbHNaSb9r3TI5Zazq2PmI7cx9D5J5P5HdVVGipfimgSePn5W9?=
 =?us-ascii?Q?36NayYMsuQPL2Fz6mBBAp9y0x4eaQDXb6HHTjq1KMFQrCTZv2jh9RSaoiJXw?=
 =?us-ascii?Q?rDFXcoxQVnimJ5Rz3lLJ7Om5TJMv67d2EyT4Xrf9Ev86bamVdK5uH1G5FGSJ?=
 =?us-ascii?Q?hMtT6ftXhVPik5g0hicI40xJO/jfhbGE1f1aOOykXyX1dI20cknQvJ8y+qms?=
 =?us-ascii?Q?NUfcOgRK+H23HLK9Lsxj4obtk0WEkrXQwKOcEb1r7POugJSA57Do9lT2Ti39?=
 =?us-ascii?Q?DNNHb+VhR/MNwJH2ePk5U5hpD/FwzkQwkRY8voP4XwcoMB8fLs5xDw6jpzSc?=
 =?us-ascii?Q?QJFFYTedCIVHcc7PiQ2eVgxqr/LSDFJFJ0LwxumKZddGOPpB6Uf7z04LHaGT?=
 =?us-ascii?Q?ggmHrmMw9iTd+FX+o5+Na/88z41zbTpJ3ZOB2vJHA/gGQdYn2jnT1Ie0RVLe?=
 =?us-ascii?Q?5LbBMEPf0m9R4IjrW8mbl56m9VOhp3ofxYhO4wGS?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4419.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92bd07f1-d173-4dfa-1aa5-08db447bec5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2023 04:25:23.9831
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4egUt/LkUq8+lH5tkAFl07YSNDhB2CzvJpZSgGqegWZAABRcnA99KyMbyQ5208Ndpk0Vs9FwF+rlHpHRTBeBDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR18MB3226
X-Proofpoint-ORIG-GUID: MxiIZOC1bVnYbjNfsCQ_pHDIc9XLeNsV
X-Proofpoint-GUID: nFdPmb8Hi5RFIXQzcsbZDCA5zyybXeKq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-24_02,2023-04-21_01,2023-02-09_01
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> -----Original Message-----
> From: Peizhi Li <meetlpz@hust.edu.cn>
> Sent: Saturday, April 22, 2023 3:46 PM
> To: Nilesh Javali <njavali@marvell.com>; Manish Rangankar
> <mrangankar@marvell.com>; GR-QLogic-Storage-Upstream <GR-QLogic-
> Storage-Upstream@marvell.com>; James E.J. Bottomley
> <jejb@linux.ibm.com>; Martin K. Petersen <martin.petersen@oracle.com>
> Cc: hust-os-kernel-patches@googlegroups.com; Peizhi Li
> <meetlpz@hust.edu.cn>; Dongliang Mu <dzm91@hust.edu.cn>; Dan
> Carpenter <dan.carpenter@linaro.org>; linux-scsi@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: [EXT] [PATCH] scsi: qedi: qedi_main.c: modify the code flow in
> 'qedi_alloc_global_queues'
>=20
> External Email
>=20
> ----------------------------------------------------------------------
> When goto the mem_alloc_failure, it will result in a null pointer referen=
ce to
> variable 'gl' in function 'qedi_free_global_queues', due to the 'qedi-
> >global_queues' not being allocated.
>=20
> Fix this by returning -EINVAL directly.
>=20
> Signed-off-by: Peizhi Li <meetlpz@hust.edu.cn>
> Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
> Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> The issue is found by static analysis and remains untested. Meanwhile, th=
is
> patches is similar with qedf which Jinhong Zhu fixed already.
>=20
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-
> 3A__lore.kernel.org_all_20230417135518.184595-2D1-2Djinhongzhu-
> 40hust.edu.cn_&d=3DDwIDAg&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3DAt6ko6G2bm
> E5NMB-6KMSliwRneAzZrOmmK21YHGCrqw&m=3D5ieD0l90bssMZBp8xnyd-
> eE3D1n_4P8CQfuaR8BW1hauGGhRlK891lfcT4e-
> UAyo&s=3DDshVk_3xiEVzwIyxpk90ObNr4U4lx6daDaS3uuN6t6g&e=3D
>  drivers/scsi/qedi/qedi_main.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/scsi/qedi/qedi_main.c b/drivers/scsi/qedi/qedi_main.=
c
> index f2ee49756df8..34f38e0f1c7d 100644
> --- a/drivers/scsi/qedi/qedi_main.c
> +++ b/drivers/scsi/qedi/qedi_main.c
> @@ -1637,8 +1637,7 @@ static int qedi_alloc_global_queues(struct qedi_ctx
> *qedi)
>  	 * addresses of our queues
>  	 */
>  	if (!qedi->p_cpuq) {
> -		status =3D -EINVAL;
> -		goto mem_alloc_failure;
> +		return -EINVAL;
>  	}
>=20
>  	qedi->global_queues =3D kzalloc((sizeof(struct global_queue *) *
> --
> 2.25.1

Thanks,

Acked-by: Manish Rangankar <mrangankar@marvell.com>
