Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 440C2640083
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 07:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbiLBGXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 01:23:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232341AbiLBGXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 01:23:24 -0500
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFAF6D743D;
        Thu,  1 Dec 2022 22:21:22 -0800 (PST)
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B23V7cg026943;
        Fri, 2 Dec 2022 06:21:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=67DqM33B2ymBcS2ydSPc6h/IUrYXj2Mq1fCFzKK2VPc=;
 b=TxCpNaVlJH2l09RMHpD+7WCXi+re3UwfId0/RbsMqsIsEMCVrxpHEdNOtnX33E2vcknv
 DYtUWw5ssppMgVn36JauCxxTqFX4vA/Jj8w7T+k3dWJTuqfZYP+LST7Gvqwb2CwzfsGg
 VO+vr9ZHt4KqKs2NBNpLbCT/ILRCax55LoSs3yKnN4oLQ2j+4NCAsNVQekXQz7BgvZxL
 GbkQlN/KcOeS/CBMCZ4+U0qgdCzMhFZ/Kwar0811kYm+8gDtueJpTx1brhrenMvx7sUv
 bxOpdcyf4nD42wDAldwIVawITd9UrqHNkCLQl7q8ibnF6uS7HJqlKZKC5fOd2/rD/Hno fQ== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3m79he9092-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Dec 2022 06:21:06 +0000
Received: from p1wg14924.americas.hpqcorp.net (unknown [10.119.18.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 65CC28040DE;
        Fri,  2 Dec 2022 06:21:04 +0000 (UTC)
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 1 Dec 2022 18:21:03 -1200
Received: from p1wg14926.americas.hpqcorp.net (10.119.18.115) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 1 Dec 2022 18:21:03 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Thu, 1 Dec 2022 18:21:03 -1200
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 1 Dec 2022 18:21:03 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WVMFl0G5qdlRJVCepHdaNEkD5w1oKx1uQ4bJAnqSu/adp9w28uHvl3pA7WgO6grePPPqZPSA84QaXzf03kIdHs5RRuYwX3xLjD3L6EgRMkw2gmmsjzxP6j4fEuZYmCY2oUJ1zlUK4oi5zYd1u+b4rkUfjqC5nsWkqhzuLXfrIm3ohZk2A31RqgxaFRjS/Z05rGrsk+bA99DB4IPnnkXLLv8TBZ5+BCp6dNynw7aOZ1eRIA9JK1vfDvayUwgDcGpIEYSNMoE785ziC6R/UmYJzviK9p8ghCyyE99mzQOR9sXcwULZQLcG09qJYpYTEpMO1NBFwGOkslXe0ej+LH4OQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=67DqM33B2ymBcS2ydSPc6h/IUrYXj2Mq1fCFzKK2VPc=;
 b=TWI0ZNIz+X/4Kyssc7OAhDGX60bP/gBfAWzE62/Oy2XjbN4tE5VsMMZCCOxznlbBjNt2NCRrFWN3kQRnC6SVXJDH7BiAM/lBVaa8uXm1PfUHUwlaXakfoRPHv3r8eaRfOZibF4jcHHUPrbwfw05G6NhzRfkOmFqZcyLiK1iBx42vGev+WWkJOou7RuFg25jOa1hxmHT5o/9xE0JtrUOnXPlo3rhHYS7lseZHdVadq4J4shprW2w62JGm0CaykyF6CTwDFTQr+b2QaJcAn2+rn1Mi0THkSAeS5eum329jNSbIn+bHSL5Y0cODNaZrqgczlmWf+a1u4BO7+u2zyaTKtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c4::18)
 by SJ0PR84MB1673.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:430::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10; Fri, 2 Dec
 2022 06:21:02 +0000
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::5511:bd85:6961:816]) by MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::5511:bd85:6961:816%9]) with mapi id 15.20.5857.023; Fri, 2 Dec 2022
 06:21:02 +0000
From:   "Elliott, Robert (Servers)" <elliott@hpe.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
CC:     "davem@davemloft.net" <davem@davemloft.net>,
        "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
        "ap420073@gmail.com" <ap420073@gmail.com>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "David.Laight@aculab.com" <David.Laight@aculab.com>,
        "ebiggers@kernel.org" <ebiggers@kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 10/24] crypto: x86/poly - limit FPU preemption
Thread-Topic: [PATCH v4 10/24] crypto: x86/poly - limit FPU preemption
Thread-Index: AQHY+XHqfLLvXNGxcESumjNg7U4Mn65BZh+AgA36OwCACrj5IA==
Date:   Fri, 2 Dec 2022 06:21:02 +0000
Message-ID: <MW5PR84MB1842C2D1EA00D5EF65784E25AB179@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
References: <20221103042740.6556-1-elliott@hpe.com>
 <20221116041342.3841-1-elliott@hpe.com>
 <20221116041342.3841-11-elliott@hpe.com> <Y3TF7/+DejcnN0eV@zx2c4.com>
 <Y4B/kjS0lgzdUJHG@gondor.apana.org.au>
In-Reply-To: <Y4B/kjS0lgzdUJHG@gondor.apana.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR84MB1842:EE_|SJ0PR84MB1673:EE_
x-ms-office365-filtering-correlation-id: d09dcba0-5acd-4808-9a65-08dad42d62ba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SqI4zECHCeKKiuc/spOfZYHTrlRJulXM3F8lZ/5G4sO+nxc8G3UsiCK436KotZ9LLGl3EgEx0WPkwMt7ch9Be4i9h2tc97KWFUD9TMjzwayILJ9+mCWUgjsgLI7ERuhxek9ZbTjhsnN8ZcZOCQG5RpndnWMVFLRQs6mmJ9VuGojm8tjU9f0+lm87x7f3Of9+Atr6d3T/KOzzT24DA9S4oyzT0hZO6x/i5mZwTGDjtJ8MUVrC1dlLumVqh8Qwi5JjYNIHPbGNjbIMRmiHFInh5oU7nfV6WZrsok3xV0AyhSk0brws6oCvk1OPtucQZvDBdsTYywJT7Bshi//1G7POjZLHLDyO4Nd8IufNMN5ZsH3WusRsAIi5/VUL4hFCZi9tpw1+63wBHw7SEnx0J/Pi2ByO3s8YErQOOL57KdMG+AtPRUvwktJtJ4uOBdIdOYKNoVms4IGsCJ3E84JbqSgHiEHFs7jJurg5cGLlQ9+RZTI9DXAgUL2bcPUG+yEjUCJPTcPWFsjX8v/uDPmjvf3kZTwAx2mm+blOTQIubzHgj+QGxVA3GInMocaUQUKcM/JXnVFpIWjvzDRhGxk5ISWZLr6UABfKt6tGCAdhqJ/kAeWkdQBOzMOU6cAA/+E9zgv4MxTOOTr1JFZYjHZHMXCiqgh+7+V/2LnnJ9e8ngZJd889jWahPr+RlngnGrjhIsglHDqgzozv2INA+OQGFFrulg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(39860400002)(396003)(376002)(136003)(451199015)(9686003)(26005)(6506007)(7696005)(53546011)(478600001)(71200400001)(66899015)(76116006)(66446008)(66476007)(66946007)(66556008)(64756008)(4326008)(186003)(41300700001)(5660300002)(8936002)(52536014)(7416002)(122000001)(83380400001)(2906002)(8676002)(38100700002)(86362001)(82960400001)(38070700005)(316002)(54906003)(110136005)(33656002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dhmpuTeCGL8/u0Nufuq0ODRracEnwc5D417cuNiPAssBry9BDkEwYcb5QqLU?=
 =?us-ascii?Q?qrkz7tYhilxEP8HiMWrkqINfwxjLX0VV+UbaABJuCeX6w4DDVIy+zXxgD1xt?=
 =?us-ascii?Q?tICVmCSBcF1K0WrUQlQY7M+0+KEDPhUL8ZP6kBnfaoNdzG20ouutafOr1ZTj?=
 =?us-ascii?Q?waN0IiImeE/T02q6A7uGBo31/1zgTMwHt3qfS/yi9BCPSumXlLptQeY0RSVl?=
 =?us-ascii?Q?MYYif3Yk+W5x+AKNAKXRj54vY0UALvB/phwk5xB4Wjxs1+8/5bWWJQDdgsOl?=
 =?us-ascii?Q?dEVWyBlkR1bUnqT4MvGDPwwQXzvmvb807S/OsUcQ7pfxzvuvNkKIuOipMR3+?=
 =?us-ascii?Q?sFYjg2lgiQUyhFUS/aWSy/XXzzBjJpzOxfi8zPx3HOVPvqUuwlcVTpsTrXs7?=
 =?us-ascii?Q?pXXOuPSFqz9gOtbgkJ7Qx1uOAQiPnX2shtZzseadAfh8crKwy4HlsfZFPdIs?=
 =?us-ascii?Q?dekUi/OVJIjTmrrwSWhZDiCas+92o3H28G2i7AqIoIVuyABxtE6mdz46dQnP?=
 =?us-ascii?Q?ZBnl96bYh3f16rWZVgS06CjzsHsO9JO/nny8gu24XMqfZ/GnIeyw0b/inBuy?=
 =?us-ascii?Q?tGOhayIrX4DuNtzCWCL3+2USwXdRslXvCkSAa2bQA23UeAX++psAX6jJBbOY?=
 =?us-ascii?Q?KfaSFpb90bCtL8U27b6H6hhlRvBptDhqokA4DD41yErOm+RZfAGJgEW8uMy6?=
 =?us-ascii?Q?jDkS3SK3zkEjS9ds+qG8ob0PL4TxnC5YLf1zUpWMGnYdD4+DeyBdZld4mOy/?=
 =?us-ascii?Q?cZcbilpdOdCYzuZ1bgE68ahU9IAZkNHbWmFSDgZ/2BRC0BYyL91BMTKQcb+Z?=
 =?us-ascii?Q?fNaX5hSqG17mJE+q5ncHKWriEugHadk52e0tBNZyH119USvQaW06Lk36deP9?=
 =?us-ascii?Q?XvFoDxlSWWcBt88/uTi9ATPnJ3Evd43iFWfCcMENveafe0vNQWom62zSRTHv?=
 =?us-ascii?Q?E1jnF0uFthQxuOTU49CI49RsZsvIMqCSdP3TgNlK08rSvz7WbM5QqPuf7Ksj?=
 =?us-ascii?Q?uVaDVmZVYDbpDMBYru9tAiteQ6/CgYnRplOVYrvNDP0jiKXRCxovaNy8lvmj?=
 =?us-ascii?Q?smqGYSYABRprelMhM5oR+gUzAWkKDxib05ic2nVSNTgB+LVnEaSpH4oY5Ukn?=
 =?us-ascii?Q?9Qo6HOdYE6X8nswyf5tPf5RY8on8H3HvpfVA0fNKB/y53KMTDnqplLV5NtAK?=
 =?us-ascii?Q?yCdqxNY5sRXuooAO9a6kCF50vhH8eu1HGk3/0GLhku/LNvq8V/SmUr3RSPhZ?=
 =?us-ascii?Q?pREtR3M8EhM9KVDTCLGF9/xE3WIyLmTKRSCI7sRw7fvbG5TtRGaGaARd9zPY?=
 =?us-ascii?Q?Ua5E7kBelnAuEBl46J0bK8jqcdOBOag42hEcjY8NdH0Wq253FDQjlRIYW7c3?=
 =?us-ascii?Q?/WsTQVOUbg+3wJ3I9s03u/dneCQf/8a3RoWJAhJxpWn/VBWyyoBTAqwmiPYj?=
 =?us-ascii?Q?jVxQDgdMb5YYDwxUB+N6dy4oCyob+n5pVu9MT6rJ36if+vFNU9thl1UIMMRh?=
 =?us-ascii?Q?PQxfZh2uvei12P+rM4PMFnNjI6k5ZlVOai8fvx5ywFNcaACAUhzXpZCsDCpD?=
 =?us-ascii?Q?7OEsZsQxzbTi67h7E6U=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d09dcba0-5acd-4808-9a65-08dad42d62ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2022 06:21:02.1204
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: beG0VpmCEo/c9ZenKKeiPhk1eCPoDaym5oDTS9VcJmDu8/s6GOzzN0fFgB1UDO8g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR84MB1673
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: Chf3Efrf3jM1VKXNbMhKpVyH-RkxP7UA
X-Proofpoint-ORIG-GUID: Chf3Efrf3jM1VKXNbMhKpVyH-RkxP7UA
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-02_02,2022-12-01_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 impostorscore=0
 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212020047
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Herbert Xu <herbert@gondor.apana.org.au>
> Sent: Friday, November 25, 2022 2:41 AM
> To: Jason A. Donenfeld <Jason@zx2c4.com>
> Cc: Elliott, Robert (Servers) <elliott@hpe.com>; davem@davemloft.net;
> tim.c.chen@linux.intel.com; ap420073@gmail.com; ardb@kernel.org;
> David.Laight@aculab.com; ebiggers@kernel.org; linux-
> crypto@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v4 10/24] crypto: x86/poly - limit FPU preemption
>=20
> On Wed, Nov 16, 2022 at 12:13:51PM +0100, Jason A. Donenfeld wrote:
> > On Tue, Nov 15, 2022 at 10:13:28PM -0600, Robert Elliott wrote:
> > > +/* avoid kernel_fpu_begin/end scheduler/rcu stalls */
> > > +static const unsigned int bytes_per_fpu =3D 337 * 1024;
> > > +
> >
> > Use an enum for constants like this:
> >
> >     enum { BYTES_PER_FPU =3D ... };
> >
> > You can even make it function-local, so it's near the code that uses it=
,
> > which will better justify its existence.
> >
> > Also, where did you get this number? Seems kind of weird.
>=20
> These numbers are highly dependent on hardware and I think having
> them hard-coded is wrong.
>=20
> Perhaps we should try a different approach.  How about just limiting
> the size to 4K, and then depending on need_resched we break out of
> the loop? Something like:
>=20
> 	if (!len)
> 		return 0;
>=20
> 	kernel_fpu_begin();
> 	for (;;) {
> 		unsigned int chunk =3D min(len, 4096);
>=20
> 		sha1_base_do_update(desc, data, chunk, sha1_xform);
>=20
> 		len -=3D chunk;
> 		data +=3D chunk;
>=20
> 		if (!len)
> 			break;
>=20
> 		if (need_resched()) {
> 			kernel_fpu_end();
> 			cond_resched();
> 			kernel_fpu_begin();
> 		}
> 	}
> 	kernel_fpu_end();
>=20

I implemented that conditional approach in the sha algorithms.=20

The results of a boot (using sha512 for module signatures, with
crypto extra tests enabled, comparing to sha512 with a 20 KiB
fixed limit) are:

  sha1  cond:  14479 calls;   784256 cycles doing begin/end; longest FPU co=
ntext     35828 cycles
sha256  cond:  26763 calls;  1273570 cycles doing begin/end; longest FPU co=
ntext    118612 cycles
sha512  cond:  26957 calls;  1680046 cycles doing begin/end; longest FPU co=
ntext 169140982 cycles
sha512 20KiB: 161011 calls; 16232280 cycles doing begin/end; longest FPU co=
ntext   4049644 cycles

NOTE: I didn't have a patch in place to isolate the counts for each variati=
on
(ssse3 vs. avx vs. avx2) and
- for sha512: sha512 vs. sha384
- for sha256: sha256 vs. sha224
so the numbers include sha256 and sha512 running twice as many tests
as sha1.

This approach looks very good:
- 16% of the number of begin/end calls
- 10% of the CPU cycles spent making the calls
- the FPU context is held for a long time (77 ms) but only while
  it's not needed.

That's much more efficient than releasing it every 30 us just in case.

I'll keep testing this to make sure RCU stalls stay away, and apply
the approach to the other algorithms.

In x86, need_resched() has to deal with a PER_CPU variable, so I'm
not sure it's worth the hassle to figure out how to do that from
assembly code.


