Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99A6A62F23F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 11:13:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240943AbiKRKNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 05:13:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234711AbiKRKNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 05:13:33 -0500
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3578810566;
        Fri, 18 Nov 2022 02:13:33 -0800 (PST)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AI9KFQG026589;
        Fri, 18 Nov 2022 05:13:28 -0500
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3kx0p7jb6r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Nov 2022 05:13:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dc/7fUEvkQcodXjmvBCxRLhvoaqsDDcnMijEa+D2xK8VlfkSrITt5+QC5Sat++sdGKZcdeFHK9wXqZjsDo5lMsX/fwj2pn38t9LwP1LfZTbZQhTpDoB6/FSH8YBfRDqYUxWl+V/MgKIH/1ufNBLxuEAUQwjI5EoobjQHAThw8HGWPVDW7UHLLU+rZhA04xRdKukvhVHhGQTrh/wlTVLRa/2QqTk4DE52WHhQmmk+k4QRCW9TZzVpTs/gHyakvEUrVtfA0yppBzzKW0hmOST3A/VNN0kvmHNzzE/8ZPMGvOuaJBhM1HWl9EoiKOrQHul/iFtsTKpDWFZD+YU3kNQgGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=52ST/0eRv/iEFIh5b8bAqES4/ULUotBB7eyT3RHLgz0=;
 b=UKueZTRUGMXeVvdxp8PKfMloAksQOnCf1MWjvM/oPol6KcEm+aFcStwK4HNL33B3sa/sFrMaCYgbvviCU0M62UWPiw7PcK7Y4q5A+31TEzGO7GrSUVWimN8Ync0ege4vL6i08k9GDr1h7oCpFm4NyIEfIrxbcof8KmqoKRs23AkSNQV3zUgkbjB6V5X0ZRgeSXmpCBCdFhSVOWquj7Cjp5YWkA6YaI6Lue/wnJ9OjEIBisREdBNfOgK1+++NYHOB+MnoWzyBBbGM+cHP/+/PTmaLm9D2fQe8adoLl176rCawLU6es+nCg5TVZqe3Jvgea3KA3YIPFXaXLX+WDn4KXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=52ST/0eRv/iEFIh5b8bAqES4/ULUotBB7eyT3RHLgz0=;
 b=GDwhEpSvOnTqpIWxz5yCD+LIgUjxfThgm4kaaqo6HGcToi78Xg5lohXe/f+t6KyfIY9AajcO9Hqs9/lSMT6V7Ma3cNpqSPAj40aKqeOg3i+Bkfas4ZaYrJD1opJDB4wWJIhuP0RCl6p1G5PAJ4CCizbtQbs5jFLxb7RgNYcLc7w=
Received: from SJ0PR03MB6778.namprd03.prod.outlook.com (2603:10b6:a03:40d::22)
 by SJ0PR03MB5757.namprd03.prod.outlook.com (2603:10b6:a03:2d8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20; Fri, 18 Nov
 2022 10:13:26 +0000
Received: from SJ0PR03MB6778.namprd03.prod.outlook.com
 ([fe80::a07b:a2c6:abe1:c35e]) by SJ0PR03MB6778.namprd03.prod.outlook.com
 ([fe80::a07b:a2c6:abe1:c35e%7]) with mapi id 15.20.5813.020; Fri, 18 Nov 2022
 10:13:25 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     "Bolboaca, Ramona" <Ramona.Bolboaca@analog.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Bolboaca, Ramona" <Ramona.Bolboaca@analog.com>
Subject: RE: [PATCH v3 01/10] iio: adis: add '__adis_enable_irq()'
 implementation
Thread-Topic: [PATCH v3 01/10] iio: adis: add '__adis_enable_irq()'
 implementation
Thread-Index: AQHY+ygrDzGBI4Cxq0uzp1+y71+ps65EdfJA
Date:   Fri, 18 Nov 2022 10:13:25 +0000
Message-ID: <SJ0PR03MB6778660019C2553E5E18F8EC99099@SJ0PR03MB6778.namprd03.prod.outlook.com>
References: <20221118083118.9641-1-ramona.bolboaca@analog.com>
 <20221118083118.9641-2-ramona.bolboaca@analog.com>
In-Reply-To: <20221118083118.9641-2-ramona.bolboaca@analog.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctYTBlOTdiZTUtNjcyOS0xMWVkLWI2YmItYmNmMT?=
 =?iso-8859-1?Q?cxYzQ1ODgyXGFtZS10ZXN0XGEwZTk3YmU3LTY3MjktMTFlZC1iNmJiLWJj?=
 =?iso-8859-1?Q?ZjE3MWM0NTg4MmJvZHkudHh0IiBzej0iMTcyMiIgdD0iMTMzMTMyNDAwMD?=
 =?iso-8859-1?Q?E5NTIxNjEyIiBoPSJxN3UzQ29oNmJFVEFSS3YydGdKV3g4akQ4N0U9IiBp?=
 =?iso-8859-1?Q?ZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQU?=
 =?iso-8859-1?Q?FFb0NBQUJNUUVKak52dllBVmlZMXlEUExadWFXSmpYSU04dG01b0RBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBSEFBQUFEYUFRQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBRUFBUUFCQUFBQVg1bDJLd0FBQUFBQUFBQUFBQUFBQUo0?=
 =?iso-8859-1?Q?QUFBQmhBR1FBYVFCZkFITUFaUUJqQUhVQWNnQmxBRjhBY0FCeUFHOEFhZ0?=
 =?iso-8859-1?Q?JsQUdNQWRBQnpBRjhBWmdCaEFHd0Fjd0JsQUY4QVpnQnZBSE1BYVFCMEFH?=
 =?iso-8859-1?Q?a0FkZ0JsQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdFQV?=
 =?iso-8859-1?Q?pBQnBBRjhBY3dCbEFHTUFkUUJ5QUdVQVh3QndBSElBYndCcUFHVUFZd0Iw?=
 =?iso-8859-1?Q?QUhNQVh3QjBBR2tBWlFCeUFERUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFDZUFBQUFZUUJrQUdrQVh3?=
 =?iso-8859-1?Q?QnpBR1VBWXdCMUFISUFaUUJmQUhBQWNnQnZBR29BWlFCakFIUUFjd0JmQU?=
 =?iso-8859-1?Q?hRQWFRQmxBSElBTWdBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQkFBQUFBQUFBQUFJQUFBQUFBQT09Ii8+PC9tZXRhPg=3D=3D?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB6778:EE_|SJ0PR03MB5757:EE_
x-ms-office365-filtering-correlation-id: 1884c3c4-34d9-4d05-d5a4-08dac94d87fa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9EbUTIa7fAYP1RD7OcpranZvnDuDQIDD3jitaSWa56D1emAfeMo4XOaOgw/xoqNi8thsnklymkf/FUMMCsC/U4Zi0FJhDplogD8IZSeW51GU2PNxTx4kluq7cZfZutMee+q7LEibhcRZjr1YtKObjGf/lG9OXcj8oCjJHLJ8fyHhkPjyp9exkZvTCNV2kHj8NNe3IXp2l+m0QoVG1WXnjseU0pHMnlQKOwWPe+tNQ2ahitNZ/Tf1j8XR1UrIJ7GjBn3GwOVVJJDDdpcvpNySi/sR38IlptTBcr7J8ZifeAH4OSzWzMaXFb/h9l0z2bKA0NTqh3sWH82ECFvsdn9OGjdspTMyjHjUwH9i/vLzbn6NeVfE/bjV5Iz6jGETaEi4M67a+ESTt3vRMTPVMCJzxpgZbPb2OMNqW9sJkxxIgND7OrMd8jWYKRHYTDRw/+tHBNZ72xJzmEDFpCRWPe+Lii+yQZUhxT7yHpmtpvNv2sppx+u+ry/Vs4QMoYDiEwWEfwHzvlTAUAtpRgmYwuQLaDZui+eZjxiXnfxzf6sShl81G22RtvZ4K/oKzT+3MfRLbKmTM7hyUynerZRi8ZWla/Ik1CnxboVQ2Fg9t/PyR7jHY9Bffc2ouuwg9jzmLIhbHbqMSMI/jhBL9FfRjrmN2vc42xhzgyrG/hMsaNLO+ROjrahHiB0ZJm6ZjS777LtaPD0Tn+YYln/PG4UiHrCQhg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6778.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(136003)(366004)(346002)(39860400002)(451199015)(83380400001)(52536014)(5660300002)(8936002)(186003)(41300700001)(2906002)(38070700005)(33656002)(86362001)(55016003)(38100700002)(122000001)(53546011)(66899015)(6506007)(7696005)(71200400001)(110136005)(316002)(107886003)(9686003)(478600001)(26005)(76116006)(4326008)(66446008)(8676002)(66476007)(64756008)(66556008)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?bAz728hHLrwiigxoQpBW7RRWtf/GbYFkNQPpr9SMLsU95vj4f8ovf8Ld3A?=
 =?iso-8859-1?Q?CffDuXR6eGTvLXA5H6TYsWXzwT6zmBjvfteiuF00gkQYFZyoKtyCLOSloX?=
 =?iso-8859-1?Q?aZyTbQM4UKmMcKyFlj3JgWncHqWlfg5fOoeB2viYAcaDpfBTGRyuzp+jXi?=
 =?iso-8859-1?Q?dGZnoAb8Swy7c/GL3FwBgqP9D+9eave+hWQDZG3Rt/Nsx1JVa5SGySruUi?=
 =?iso-8859-1?Q?wt0oNe07N8TgdWm0S75vQp7QC7Z4gcV+Dl5oPoEAb0IoEWgR+qvF4+vXK5?=
 =?iso-8859-1?Q?Grs99R2IpPd7pRtPkvhoWCStGZhLgU8VuSUlHquGBo6gyir/j2V9Hbj/KT?=
 =?iso-8859-1?Q?NJUEKBbAIoU1vc3KPvqBL6FGFMoaLdBY0kP1Hzqo/k8UdCoYdI43ljeL7j?=
 =?iso-8859-1?Q?825FZrAbkcrdtB7+uZEqq0wUuHjwZEjhxLtNycBTx8/zV09U54uffhWT9e?=
 =?iso-8859-1?Q?NhOby75kSfVV3gKWpqDXiS/QDT1ImweRtZq9ctkrfVletY7UsfN/2vmYmL?=
 =?iso-8859-1?Q?AP8lpZuGbABDnppCDewBWkjQRS/ZR8jyG0ooy3XI8p9H8KKDYIUd9TQyXj?=
 =?iso-8859-1?Q?WeOGhR8NW6Jgx/MqUzcjcGfJeiMIa2ukDzgZjBHZCgtzlnykkIpcb6LxSa?=
 =?iso-8859-1?Q?7qqIopLqstd95d4U+2sKoVOJheu2MJykowbcghUg7pElcR/5xRdG7uWWmU?=
 =?iso-8859-1?Q?Q9GznilUGkrZvXfwrTGit/e3dhlSLeuvfTxgRQL8oEwFdvupaCVgoV8eiL?=
 =?iso-8859-1?Q?d1NcChpxpLF7GP35rPYCQief2NFdk1lk4kPd/a6gMjcTuCL9kLtmEr/9cK?=
 =?iso-8859-1?Q?mo8bYU5GsZ7SvmI9BIDmqyJGwpBVhIeY4RZnWdlm5a5UcxjvpNreNVDEY+?=
 =?iso-8859-1?Q?EY5T6lPEVn6CYMbH/oYCIRZV7rkXwOCmWnAolqJFy/Mx894orgYXXonLwz?=
 =?iso-8859-1?Q?HMaQhSh9frPCCm2Dy2bmaP+qSKU3NBqJovq5fXYVKXSIdNwhEEIZjyDPSF?=
 =?iso-8859-1?Q?LMw8KB/pjMcv49Xi9eCJ9/rbwy9h68xf1mmtt5wspLK0twxvcOuVfbszAW?=
 =?iso-8859-1?Q?rgePlgDBNJx9ubMXbkL5dIminuyqSVh3a6Uxf7/barxgmMBif7oxIO/k53?=
 =?iso-8859-1?Q?PJP059+zHeaqhTR8al2Ofi34tBKiWEUxWeO5eLqU3DBrNVRuwgmiOaUSGX?=
 =?iso-8859-1?Q?FlTJ2gleuVY9aaCPAQAGBBHDhqpwQz4SwygYd2QYYnJtVlndqAxJw0BD5N?=
 =?iso-8859-1?Q?xOxsIMBYcAexIsbddDPfB8o3Q3rP8a0CmPilILcosPXECwDukWJSnZLLEN?=
 =?iso-8859-1?Q?7Addd6qGs803M2wH5s6y7qzyEZawalercC5hxymxYSgSleAmjr10R+77En?=
 =?iso-8859-1?Q?riBWjKpGVx/j+MhB3fpITh3pjItLW57eGmkUG7wYwfPO7wPt9BttDFI51Y?=
 =?iso-8859-1?Q?vhglqO9djSBfmp8nUKrMpHhLooZC4vg/G/H4AZZWE2Azu/mGkcz8Y76d7a?=
 =?iso-8859-1?Q?qdGPtPPVI7rFaT5F22idKNPNJwUTL47CR8qaMU0RKKHi65pbTDy2BH2ln4?=
 =?iso-8859-1?Q?CWPtIqcBZTRBstMZeTQlcp0UXW0FGaUVC8K8Tg03ijEnowaYlVGcuZ2m1T?=
 =?iso-8859-1?Q?/zz5QA6AVZp78=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6778.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1884c3c4-34d9-4d05-d5a4-08dac94d87fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2022 10:13:25.6749
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wCbE93OkjCkdfRLwTa9NBrK0clj3uFJa5Ck0cofTnLNDMfZpRHZXJKLqZJVHFl7yESxGPeW4b6lQpIGXGw8pIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5757
X-Proofpoint-ORIG-GUID: XQt7qcNc1zgO3ZESwgYRUenob4vLbpNa
X-Proofpoint-GUID: XQt7qcNc1zgO3ZESwgYRUenob4vLbpNa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-17_06,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=892
 priorityscore=1501 adultscore=0 suspectscore=0 phishscore=0 mlxscore=0
 malwarescore=0 spamscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211180061
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Ramona Bolboaca <ramona.bolboaca@analog.com>
> Sent: Friday, November 18, 2022 9:31 AM
> To: jic23@kernel.org; Sa, Nuno <Nuno.Sa@analog.com>; linux-
> iio@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: Bolboaca, Ramona <Ramona.Bolboaca@analog.com>
> Subject: [PATCH v3 01/10] iio: adis: add '__adis_enable_irq()' implementa=
tion
>=20
> Add '__adis_enable_irq()' implementation which is the unlocked
> version of 'adis_enable_irq()'.
>=20
> Signed-off-by: Ramona Bolboaca <ramona.bolboaca@analog.com>
> ---
> changes in v3:
>  - new patch
>  drivers/iio/imu/adis.c       | 26 +++++++++-----------------
>  include/linux/iio/imu/adis.h | 12 +++++++++++-
>  2 files changed, 20 insertions(+), 18 deletions(-)
>=20
> diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
> index f7fcfd04f659..cfcb4abeb5db 100644
> --- a/drivers/iio/imu/adis.c
> +++ b/drivers/iio/imu/adis.c
> @@ -270,23 +270,19 @@ EXPORT_SYMBOL_NS(adis_debugfs_reg_access,
> IIO_ADISLIB);
>  #endif
>=20
>  /**
> - * adis_enable_irq() - Enable or disable data ready IRQ
> + * __adis_enable_irq() - Enable or disable data ready IRQ (unlocked)
>   * @adis: The adis device
>   * @enable: Whether to enable the IRQ
>   *
>   * Returns 0 on success, negative error code otherwise
>   */
> -int adis_enable_irq(struct adis *adis, bool enable)
> +int __adis_enable_irq(struct adis *adis, bool enable)
>  {
> -	int ret =3D 0;
> +	int ret;

This change was not really needed as long as we 'return ret'
In the ' unmasked_drdy' case. Anyways, not a big deal for me...

- Nuno S=E1
