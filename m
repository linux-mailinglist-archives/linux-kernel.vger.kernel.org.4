Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FAC5623117
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 18:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbiKIRI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 12:08:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231597AbiKIRI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 12:08:57 -0500
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46649E00F;
        Wed,  9 Nov 2022 09:08:56 -0800 (PST)
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A9GYUvq014298;
        Wed, 9 Nov 2022 17:08:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=fxefu6BL70q9QOsqaB1LHh0b56eWQqmLI0cYg8ygMZU=;
 b=jd5hIqmuKy3gODi6mhaA3EFuVF5q4N6o/tXJllDZP4LAVzTHjwFrI2lJ2Xtnva36HV7R
 gp/6BQE/UoxYpaDCmpfn3JFWj5Saj45A3m6le03tDd/PDYFy8VmLRf3OZsPoeyFZQXjs
 m7nRAXzHkifTym8coP+mSnD7HQsoMaQLuiJEfCXa33Gy5j7Km609csfQTRGgvqERJbUk
 a5CG4Iss36kS+i+zfcmodVbw2ZXxc90oKE2kBu1s3gsEAmF8AsMWhwIbvnTk3lYYuHW7
 UqiBm5RqR/nsTFotN6u/jFEqh3iKgDd4PukqN7iFJo6Ylz6ApMWJscUxHUpr52EhvWhM qg== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3krfud8by1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Nov 2022 17:08:40 +0000
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 01C155D175;
        Wed,  9 Nov 2022 17:04:11 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 9 Nov 2022 05:03:57 -1200
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 9 Nov 2022 05:03:57 -1200
Received: from P1WG14918.americas.hpqcorp.net (16.230.19.121) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Wed, 9 Nov 2022 05:03:57 -1200
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 9 Nov 2022 17:03:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EsOSt+14+q/WkroixkAMA40DupwESm/kTw/Ne18uH5a9Eq6YTR5od9Ywa7JKsoZXMXaktegjOM4YtiMq1HNHi5x0e0DuvtDMfL1QGxe1SbZ1g3K1tazPHDoWV5kB0yxpato29wnWanbkyRIpYY32XJ2GLJvgpM1hOUBOmcVZolzF2a1z9KVZ4ZA3yAyVS66lCAsgVfQ8JJWhhHm4VpmjbUHtzXbtk5ZUlwjpkKdUIdfIFZTDASbQoZvlvARkaiwsyPG60ilFwUOSmg3J4eZ2+4jqj3EhPsF/v7QjGlHgojxiCw8+TulTZDcyLlXVWqkuJvJ9Etpz7Wzz6vMivMWajA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fxefu6BL70q9QOsqaB1LHh0b56eWQqmLI0cYg8ygMZU=;
 b=FkMXSCtu0ADvf+WH+5Hx/5yBhxzZbcL6KbChMNC1zvEltQvgOTohTZ15wUnSXv8hOxx1qIxSqZeAwE5/7knjCiwelOmQeVyDY7n8LnbtC6x0S6gzxu89/ooUT/EJsSX7JQzIf1+3lY6AsFOzSQsZTj3rZbMC/Sj2EVhr2dLKOR1+O3eIEoj0kCzuCFA8hrFYI7OqdLu0gC86vAEsPCiZ7cY4jrfy50wM9W286RON6F+TaudVpGmJSxKmVweklhGhHosHpqTyU7K8Gv6gQVlpshlVDinPEkUuacsjYjQ/6ev7dU01XilqWqiKPuNuCD7O/7XLxt+Ms3nbeSWkEIvp0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c4::18)
 by PH0PR84MB1503.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:172::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Wed, 9 Nov
 2022 17:03:51 +0000
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::e739:d90:9fca:8e22]) by MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::e739:d90:9fca:8e22%7]) with mapi id 15.20.5791.026; Wed, 9 Nov 2022
 17:03:50 +0000
From:   "Elliott, Robert (Servers)" <elliott@hpe.com>
To:     Zhen Lei <thunder.leizhen@huawei.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Neeraj Upadhyay" <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v6 1/2] rcu: Add RCU stall diagnosis information
Thread-Topic: [PATCH v6 1/2] rcu: Add RCU stall diagnosis information
Thread-Index: AQHY9B8WepNC0ic5WUOW0S7L17lcwq42zGXggAAEhAA=
Date:   Wed, 9 Nov 2022 17:03:50 +0000
Message-ID: <MW5PR84MB184289B1E4475337A075ED3AAB3E9@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
References: <20221109093739.187-1-thunder.leizhen@huawei.com>
 <20221109093739.187-2-thunder.leizhen@huawei.com>
 <MW5PR84MB18423CA291ABCD3DCCE3D416AB3E9@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
In-Reply-To: <MW5PR84MB18423CA291ABCD3DCCE3D416AB3E9@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR84MB1842:EE_|PH0PR84MB1503:EE_
x-ms-office365-filtering-correlation-id: 24384fb0-57ac-4538-6665-08dac2745fcc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5XWWZSIaXN5wvBVoBxGlu+1tbcP+ox0rvKArMwxb/w+DqW1sueOpyrdAI2OH02u7iR5nsy98WsQexetLxJUtYz2PoAyrsapK4yR4NACwYAcZnHQJVCivhsFFgnbV7powxfhMPrcwPBzrBVrCggnzY5Vken4X0VRxr3W5XGuc4xuZu0I7RAsvmbUyfltsEwglzj/joclhuias+mKZcQ6K5+M0gXpvVD8T5dvShbUfaBLpfxthdatKv8yn4PawznGDnVaa4ugnc4nVJ0kW0VLBRsUUATsBrk8WyV3vhErjv4GuLOAGYDoZlgqmXygKd6z4l7JPw8xPsRCPzUjnziqmEC8JpuWfID8gb3jrm/zF+RrxWmOIBxbTmYjE5fOgAkjLCQ5IT7a2xP0gAAXvMXpf3XmDvyC/5opYUkd0khLdT6VfLstZSfTIicJP2/9Yg6zjG7fD3az4hG7qBylkqNDH3mt1IJbN93rpdfvCnjZde6DwpD3axbsiMx0ebH2N3NvTVNzZJ5x69C4d3jfCAF3ajMvVUUo581zKjL7UXSZtDpiO+csW0Yh5W1dnaP1IQVyBrXKYHI2nMlYjsmCz0vx7A2VtIcGfNwwLUJ8+FUz2zBA/SKn/k6M/mC2m65lYaLJKJbyIdyCgsYOxW6gsDH3RUtCgdj2Effdchm8dcG0B6zfSOLDTZzSokJgDUbCDN0AuRL6JalOn3w+88w+RSqsf71mgJ+H5TOsOSkWec3+yLDi4LTcvb0supoLhr2DSCtBdYBgF1z2uMM6FrXywyMBbFUD+7YvivJWq38BKUPzUwMw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(396003)(346002)(376002)(39860400002)(451199015)(8936002)(66946007)(52536014)(2906002)(66556008)(64756008)(8676002)(41300700001)(76116006)(110136005)(82960400001)(55016003)(71200400001)(33656002)(66476007)(5660300002)(7416002)(316002)(921005)(478600001)(66446008)(83380400001)(38070700005)(122000001)(86362001)(7696005)(6506007)(9686003)(2940100002)(26005)(38100700002)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5VjBfWoDqi63shpOuUMT2so27wSWTYwrKhFPT2fwqidJaK+EabwI9exj+NCa?=
 =?us-ascii?Q?kP4h7ddF2qGxSmd3aEYbbNBFNRWSP6oarcTcn3LFPTCo1aWKRPfWseydfJSF?=
 =?us-ascii?Q?3JvBvbsIPNwXntwbeGG++A+1IMszWs3TI48qcEiFSo1VHK8LjA0qFQqLmIqV?=
 =?us-ascii?Q?8usAcQO9pmOJ6DZlpoHXlU1yM9HsXH+oAfrd3hzyPNd0h0jaVK/9qOug+TQr?=
 =?us-ascii?Q?31nBwiIH8lepCFgRuyFKWO8q7aPNZuCiAD+YWMJkMOrHPg+Y/LrJe0LRfMv4?=
 =?us-ascii?Q?KywfSTs7SsWna2egYTb60nsu07+qWEdJGsciL0CKXw7dASBqxsJt0UDMeQJ0?=
 =?us-ascii?Q?1aVt26KTOc4xnt7PyqZylsQAHN+vXYXVJfDgqLFVR6fxxaW5TvVFgIRkz5dL?=
 =?us-ascii?Q?mRC1RJXvz2dquVkrPPohJw/SUd+32II7L+qRt3u6GwtQabDQ0/MZASNoxNpc?=
 =?us-ascii?Q?bH/PePp4X5ugkZBFtYGa4viVT+nJMas6a38pZE9W/DHtf+ifGDmBENu2fx6x?=
 =?us-ascii?Q?EcgaK2I7LZaDRYVVsF0Ti3lQB+KQblSZftBTOq+3iSW6ellHWpaXahH8gsfV?=
 =?us-ascii?Q?HDxN2C9wnfAb/zaM1imaLWcGKZaNcDtJJ+iKJckgvP4AhuxHfyTsa903Choy?=
 =?us-ascii?Q?1BQPn8dUdy0VZZnN+mg4AHyIlUsIxkv0up9lagaumOxKEzcWda6cEKvrtt4a?=
 =?us-ascii?Q?fDtV3gA9y02COfwVy3U20+QNUyA2GEvLXKvJKKlJBu2FY6MQopq+e09J1fEg?=
 =?us-ascii?Q?Chw9yk7Xzod3uZA8z/C23u7mVouZmaFG9/1Z7kwK7hfbt715rgFx4/tR57xQ?=
 =?us-ascii?Q?FBYd9K7YYXJozE47DPEWjZGNLI2ScKRp+CnDbbOI6GzZQdHQhnRLQSBVgOq1?=
 =?us-ascii?Q?dZ9B9MN2YZW7EjFwqz/zYMfIQUKCEcrjpal7IHuATsQqLzbO48rgPoMwc6k1?=
 =?us-ascii?Q?9DfiJOMguS/hglpMo7pS7k53eBQWJ51uMp6TBcrqOaLgQR+fJ2A/c8dZIXpS?=
 =?us-ascii?Q?yE2QMoV0xtxuASsJaerTe9K+ARg7uh7qNk05I6aAgTYxImxF2bCv/tXDMvaP?=
 =?us-ascii?Q?8PXXX5RNRuTACskwYNm0E6QYGXFIeNSdr1mEeL12cOIdiCCGwXZuoeAjo6ag?=
 =?us-ascii?Q?5Lfa4NFI3uye7tSZav6yE83ziqQzM7v2/bx5RO4qAOkAj335fhIqNrccwOpw?=
 =?us-ascii?Q?tKKpsp3kSBwB3srOm8jOjNqC068u1wEe6dWnzPGVLtomR1LBJubLsCic2G8y?=
 =?us-ascii?Q?VJt9Mj34h6g/lv09dOYlxgtbpq19ywIJ42owi6al/KArZ82cQo+TYv+qSLkZ?=
 =?us-ascii?Q?xMukO296sShnrx7WSBHUZWNrIFfLVYeHMUtSKQ487CMCjwIqzAikc52c0Zrf?=
 =?us-ascii?Q?8E9IXGohhLoXlGrIwQ9urqJDmQbxwX8Aeevv2kCKo+wi+nkQpwwNzGp/qibz?=
 =?us-ascii?Q?OsmsUzwqH40MmfxCUrUY8hwEFnCPxZjwBD9CBI4fk3w0YrE2P0N1essD222Q?=
 =?us-ascii?Q?Q9jIBnrUsQ3APdyYUZKHyUheTtAMsq9caorvMfS9Nt1xJsfP9uXu/OyNRRwB?=
 =?us-ascii?Q?PqdoGMjUYhLqPTLcJ70=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 24384fb0-57ac-4538-6665-08dac2745fcc
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2022 17:03:50.5103
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BpEcPxbS2PNnh98tSRHQKzz+Wu1a47MPIZlY5bhHxxARJtFC1jcV+CBI14+i9buA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR84MB1503
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: z5BFt2dZbVb-najDRryeKfD_MFVL7zyj
X-Proofpoint-ORIG-GUID: z5BFt2dZbVb-najDRryeKfD_MFVL7zyj
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-09_06,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 suspectscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211090130
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Elliott, Robert (Servers)
> Sent: Wednesday, November 9, 2022 10:56 AM
> > b/Documentation/admin-guide/kernel-parameters.txt
> > index a465d5242774af8..2729f3ad11d108b 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -5082,6 +5082,12 @@
> >  			rcupdate.rcu_cpu_stall_timeout to be used (after
> >  			conversion from seconds to milliseconds).
> >
> > +	rcupdate.rcu_cpu_stall_cputime=3D [KNL]
> > +			Provide statistics on the cputime and count of
> > +			interrupts and tasks during the sampling period. For
> > +			multiple continuous RCU stalls, all sampling periods
> > +			begin at half of the first RCU stall timeout.
>=20
> This description should start with:
>     "In kernels built with CONFIG_RCU_CPU_STALL_TIME=3Dy, "

Please ignore that comment - the module parameter is always
present (only subject to CONFIG_RCU_STALL_COMMON like the others).
The config option is just selecting the default value for
that module parameter.


