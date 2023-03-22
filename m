Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF05F6C440E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 08:28:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbjCVH2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 03:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjCVH16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 03:27:58 -0400
Received: from mx0a-0014ca01.pphosted.com (mx0b-0014ca01.pphosted.com [208.86.201.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1324218B27;
        Wed, 22 Mar 2023 00:27:54 -0700 (PDT)
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32M53Q7K009355;
        Wed, 22 Mar 2023 00:27:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=QVnJywEvLgxwBXAQ1K6t8jeAFdtm+qDjBQ6fRjjYqWo=;
 b=PbQfnKlC/yRH9hsU0XpJYAp7W6iVmFDDfPP9X4SHJO1+BS5XhRKLutOmJPZhuu6H2ChP
 e4pMw0gQFfMVVJH0d7mbnF/M8hnN/pFuFLFoX+Wy+gX1r+eRs0mTpZBGuTemwaxBV65J
 KPg13V0I//P+xiaiGjRxbIcxki1301Jecf+YQtFLk8lpMC7gwnpxpKaGT93tFZxB6AJr
 8sQlAWu9/qBBGF6hKYIcnaUJ4dblOqBWFIxWVsjjelSM9I/SwJ3CL+sEoaSv+bwdormC
 /dTTriEFU/bcZ3BT593IUVbADDQpw9lPlG/2+uwaj8Fehxq/8E4TPwwUk+cuh761vAv3 Hw== 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2045.outbound.protection.outlook.com [104.47.73.45])
        by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 3pd8w2nfc5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Mar 2023 00:27:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bh7EJn8cquVlJc2MkRbUpQyShTOXKGLfjC/zpk4bFEM6pwCAJkMV60ksAY6TAiiFM0VTIwoyAdA0hdopFQ0K0b1ImAv6G7y17hx/M+CwomJwNxNp/XYtcA620wtU7LSE2XUGeoJloBaCtJRpx6Q7ba4yKMWfJgL31ebqmCSQpLEOx1LEA3Kws3UZza34vGP76Siyc5dBa+k9YPOiRCRvoT9neL07zh6sECeeDA5QcmSYdNw02HZsmHf5r7xLa7SznTpKeR23fF+Pwcv8nWgvvD5pCruYsK66mEjiKvWCSBFL5I7auxlCzz/OFU0sWW9kAhl3Ls8vlgtAf30B2sdGxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QVnJywEvLgxwBXAQ1K6t8jeAFdtm+qDjBQ6fRjjYqWo=;
 b=e+o65SQhzlTrYmLW/iAKSsNlTvuGlkaOjumn77nL9mGUxZT+18veEBqlTLRJPH5BZ1RHg+eg1wpE+7mdyGJm87SDJXN1Ps59/1h8lvSvAIew922Rzso7aDvTHYDIz/gV1bSmYIMb/Bygtxs8llp0w8pGnGhqEp4szb0XscsROY6QM9Afnir9MzskUyDQ5DNo5xJKv9t7cWDGl19zn52SBUH6LRWT3fl24iWjZmWeJnATLvj+O+W33ZPc1gYXi+AYmGsgxQ0E9FnGy4CpYAG5lnDmPLTECzpL2mQN/vzegu7F3+OrB05Js9DZ4BVGSGAnPs+3itZrIey6/qOvWLwSRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QVnJywEvLgxwBXAQ1K6t8jeAFdtm+qDjBQ6fRjjYqWo=;
 b=TZ81ZLjR7/rU6kix/aEhzJEMM06QF/OXbRedBTPd0ftJ6jE8GBvWt6Nj4yMeaaICAl7qMq5QAhhXUAqEw7YCpiuEwhl6gvHufXfE6qLh020tR3lYg7WNV6h3XUX2UjzT4FCjvHI0lvjio1d+Sn3FwsGnISBZ3BZ6dnlPX5XlS9M=
Received: from BYAPR07MB5381.namprd07.prod.outlook.com (2603:10b6:a03:6d::24)
 by BYAPR07MB4232.namprd07.prod.outlook.com (2603:10b6:a02:c0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 07:27:37 +0000
Received: from BYAPR07MB5381.namprd07.prod.outlook.com
 ([fe80::7a9f:f44:4172:5bb8]) by BYAPR07MB5381.namprd07.prod.outlook.com
 ([fe80::7a9f:f44:4172:5bb8%4]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 07:27:37 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Frank Li <Frank.Li@nxp.com>, Peter Chen <peter.chen@kernel.org>,
        Roger Quadros <rogerq@kernel.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:CADENCE USB3 DRD IP DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
CC:     "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH 1/1] usb: cdns3: fix super speed mass storage gadget
 device failure at imx8qm
Thread-Topic: [PATCH 1/1] usb: cdns3: fix super speed mass storage gadget
 device failure at imx8qm
Thread-Index: AQHZXDjqj8OQUmrUl0+OaTIEnBRe268GYozQ
Date:   Wed, 22 Mar 2023 07:27:36 +0000
Message-ID: <BYAPR07MB538127FB75FE24832DC1BBD6DD869@BYAPR07MB5381.namprd07.prod.outlook.com>
References: <20230321210521.2806486-1-Frank.Li@nxp.com>
In-Reply-To: <20230321210521.2806486-1-Frank.Li@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctMDJmMTJhNTYtYzg4My0xMWVkLWE4NjItNjBhNWUyNWI5NmEzXGFtZS10ZXN0XDAyZjEyYTU4LWM4ODMtMTFlZC1hODYyLTYwYTVlMjViOTZhM2JvZHkudHh0IiBzej0iMjM0NiIgdD0iMTMzMjM5NDM2NTQ0MDcyOTYyIiBoPSJVcWQ1RmVsbUJJRW5uSGt6SmxWSHBESllseWc9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR07MB5381:EE_|BYAPR07MB4232:EE_
x-ms-office365-filtering-correlation-id: 5f4a551c-4184-4335-1d30-08db2aa6e952
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VZKoXKXJjWYIPXuowAX7Kx1Ew9ObEbQ0yxiwTF1ceqrPAd+sIR9N7jcXL8hZIbMapJuDATClhR1OTVhihGYKLy+2GqbN0hACbg86XdbS7HNPqJKY4iXioBMJld6VrHdWMgeveigAQ2vBG5WUN4TvQHdbGRuWhvffykUhW+yNOXKUvFUlVwNYQ/0ObllwaDOPWvSoGA4IkkhLuZ7uM1xJU8sL7k93HHcX82Xo/0wvtt3e3mdkaabM++k6BjBIKOSV53SGrTHW+9vd4f+qLhZ26g4Hb1Y8qncchVWa2q85RvWqm2zlA71aaI/k9jF7Q7nXcF59EtGyYS1ORUnnzojz0XLfoKb3uavC5iAVKd8CNRQ2j/HepthZVeT+CGPTwv3yCUrhh3rkmAOxrwUHZJmIwODOK9HqF7hvmHkAIY5qHqD42Ym+uwk35pwHgYIxcsjV3kfO1C/kkZvsNoDfjupa6VzZK7DAjL8odmUuLvvmpOLa/iGkmVmbYCc0X9q1gK0Jzw3hfs2q1A+ToixJJsCvYNgqQbdHRDPxEosJRv2nAd76xmva+XUm1k/Tkish+00OG50AxZJytdaw5vBrd+tTceQO1oLJliM2klMl3r3Aj8pUnyuBas3yt/jF3Jb/C0d16NO4ytzGWnzpYTBA+td9DKBvnYdGL9McJ+9i8aYzoAW69iodAaqYGTDbv8297rAJvE5bISP1xo0SECxOeFCsrv7Y3PyTHaRDLsG+sefO8g4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR07MB5381.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(136003)(366004)(39860400002)(376002)(36092001)(451199018)(186003)(41300700001)(7696005)(38100700002)(71200400001)(9686003)(52536014)(2906002)(478600001)(55016003)(26005)(6506007)(5660300002)(8936002)(110136005)(122000001)(316002)(33656002)(66446008)(64756008)(66556008)(66946007)(66476007)(38070700005)(76116006)(83380400001)(4326008)(86362001)(8676002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/mamy/Uk35nuCEzUP+FcFy3hxGYyogz2eXQPO2REYqHMvd379ogmso9Disiv?=
 =?us-ascii?Q?RQcWQcvXqSC50EHzaf6RjYLgGWdfeJDYH76PGBJbbE07MS4KYrlcMnb2YRPJ?=
 =?us-ascii?Q?XgecFFXibo+VwatjHEBtACVjlADERW2lYP5TDBuGsIiWG2nqMAL/bIbrjf3I?=
 =?us-ascii?Q?mWkGRddcWRqoUo/oa3JVcrD12QaeclNdTQ2uwOnzIXizpeBuE+ri02IBKcIf?=
 =?us-ascii?Q?JuXNnNeGIPseVbVCAunEVjJ6PmHARXSnQS0TWI42ynHppGAiVQGvZQGTM0J1?=
 =?us-ascii?Q?/FljrpIiYYLObWKq2+WDonm09gBlyt4eMw3M0J72gnpjQ7srHClNNuVgHslB?=
 =?us-ascii?Q?VnW5GNPgXHb1DwsgR1F/FABUTD1kgEOBL7OCZ4Jifr5RCQMMtSJ7vyyAlc59?=
 =?us-ascii?Q?zPqOFHyMEM0/qu+RskDNQtcwLI71p7HWAlse58Y2KeVWAmCgIGK0ovDo8rHr?=
 =?us-ascii?Q?BMwgzkBzSr1fO8ET+wX9pvhLCrpVpI0iJe5gVZFSii5/1seVe+LidKiOw2jf?=
 =?us-ascii?Q?fMFjvJGpHNMMWtClrBFdvQo2XzUg3013XVLy4ujV105gUNIg2JUmtyL62PCL?=
 =?us-ascii?Q?Jg9yxLS7CEr2SVXv6M4vvk22Fkl7U2zCjbzV00SV0QnFrhCs+q8KPzvXgPuC?=
 =?us-ascii?Q?tCZ5841b35mUhSnpuMpM5oOcRHhZWuEbIuwNHCHpIEa7hiF0cIPlSVI8BMqU?=
 =?us-ascii?Q?+IM/7unh5F1h9POYN6SsHsqGBIFFTX0cwulhBaZpt19oUOThdd/THzu2NSI8?=
 =?us-ascii?Q?loc2A3QB8mspqvdonbzXZRPDD82bc8NM4TVV13rD670RLkZdBvY1yA8RMS71?=
 =?us-ascii?Q?3xh2M1XCaroo+qouWHpWS6qB4mYg49yFb4EjyIqhy8TtH2uUTq2M1fo6gs2D?=
 =?us-ascii?Q?jPt/dvUOO12ewE84aoy9yCqj2vPUOAnRD3Cgjs2V9A5Ob17wGKhHW/IP6Qpz?=
 =?us-ascii?Q?NQmK3r/wLYffv0nE7DRd/YK1BOVRS+YiIdkVhgNgeTG93tc/3PoUNBIzj1zt?=
 =?us-ascii?Q?ZnV/p8StwcBgqY9ihzzu2sZ0KDxEcblZ/vgYCJIO7a+/e/yg1vFPuL2gqJ99?=
 =?us-ascii?Q?lqtGDX/PCmsjoicAn0FW+m5MMiaKaPPymqtd0zPk1mtYGZT7g1YnJzWaW8X2?=
 =?us-ascii?Q?MP1eXn4+ANUt/uYAXiQMBCHwVRo4jwBrbGTikJ/XAoUsBurxu89uTVhHMAt7?=
 =?us-ascii?Q?tnIec4yBO4B+vLOVRcOcgqgb4vEdJS96EvvDg/Nz9I1WvBW53B7bNKU5wbQj?=
 =?us-ascii?Q?L7AROqHU9SfcVhF2A9/BA6YEfOfj/AcxcesMTzU59UFNc1/w9zGdJD2fO6dT?=
 =?us-ascii?Q?AhSIZJ4itMth/5lTchFRlzkeRkWYBp7SbTW937RIlZATaxSiOv92F0FyE8mX?=
 =?us-ascii?Q?QNpEyxTZKVx5FIVD+YxeQ71y2CG2xKrDHxZF2xQ5JZOIJehC1mABrjEzUi1v?=
 =?us-ascii?Q?DmoSVVzFt5uqbAipoLPunGLL53b8wPbZZMDqydpgr48odcwD1dFTNczBIB1C?=
 =?us-ascii?Q?qb/wOKAKkGzExoXZ8KSlT8h4SkzFw/ElB1SfAsJRwarXMllIZBGoswMCW6I1?=
 =?us-ascii?Q?dATVqTIodqa638Y4T6HL/muxDuz4sNzzw3IoIk5C?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR07MB5381.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f4a551c-4184-4335-1d30-08db2aa6e952
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2023 07:27:36.9842
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fl3Qg2F4bBcleivxRRWX396SiYZwCe8W5JL6SaXX63ujF6iUElIALSEnV+0YzKohIO1k+4v5nhSsRURUF1lNebZWdLKqNHiaWbYeX6nzaOU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4232
X-Proofpoint-ORIG-GUID: HyTJ2x6nRjro_FBkytQxQUBANk4K2FxN
X-Proofpoint-GUID: HyTJ2x6nRjro_FBkytQxQUBANk4K2FxN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-21_11,2023-03-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 clxscore=1011
 malwarescore=0 adultscore=0 mlxlogscore=838 spamscore=0 phishscore=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303150002 definitions=main-2303220051
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
>The mass storage gadget has one IN and one OUT endpoint. The below (Fixes)
>commit aimed to utilize all hardware FIFO to support composited gadget
>devices. This resulted in an ep_buf_size of 15 when a single gadget was
>enabled, such as the mass storage gadget.
>
>However, it was found that there are unknown limitations on the imx8qm and
>imx8qxp B0 platforms. The device would fail to work if ep_buf_size exceede=
d
>9.
>
>To resolve this issue, this patch reverts to the old settings used before =
the
>below commit for the imx8qm and imx8qxp B0 platforms.
>
>Fixes: dce49449e04f ("usb: cdns3: allocate TX FIFO size according to
>composite EP number")
>
>Signed-off-by: Frank Li <Frank.Li@nxp.com>
>---
>
>I hope cdns engineer, such as pawell@cadence.com help identfy the root
>cause.
>Look like old version ip use more memory then what ep_cfg show.
>
> drivers/usb/cdns3/cdns3-gadget.c | 11 +++++++++++
> 1 file changed, 11 insertions(+)
>
>diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-
>gadget.c
>index 5adcb349718c..497c8e87dabf 100644
>--- a/drivers/usb/cdns3/cdns3-gadget.c
>+++ b/drivers/usb/cdns3/cdns3-gadget.c
>@@ -3005,6 +3005,17 @@ static int cdns3_gadget_check_config(struct
>usb_gadget *gadget)
> 	priv_dev->ep_buf_size =3D priv_dev->ep_iso_burst =3D
> 			(priv_dev->onchip_buffers - 2) / (n_in + 1);
>
>+	/*
>+	 * There are unknown hardware limition: when work at super speed
>mode,
>+	 * ep_buffer_size can't bigger than 9 for one IN and OUT case at
>i.MX8QM
>+	 * and i.MX8QXP B0, which report there are 32k memory.
>+	 * Rollback to original settings for the these chipes.
>+	 */
>+	if (priv_dev->dev_ver < DEV_VER_V2) {
>+		priv_dev->ep_buf_size =3D min_t(u8, priv_dev->ep_buf_size, 4);
>+		priv_dev->ep_iso_burst =3D min_t(u8, priv_dev->ep_iso_burst,
>3);
>+	}
>+
> 	return 0;
> }

I'm not sure whether you have 32KB. I remember that you had a Soc which hav=
e only 18KB on-chip memory
and value in usb_cap2 was incorrect.=20
It was the reason why the on-chip-buff-size property has been added to driv=
er.

Please confirm that you have 32KB, then I will recreate such test on my tes=
ting board.=20

Regards,
Pawel
>
>--
>2.34.1

