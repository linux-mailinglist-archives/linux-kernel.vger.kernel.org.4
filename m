Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8BF617CB1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 13:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbiKCMf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 08:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbiKCMfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 08:35:47 -0400
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2E9CE15;
        Thu,  3 Nov 2022 05:35:44 -0700 (PDT)
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A39j3rR019274;
        Thu, 3 Nov 2022 08:35:34 -0400
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3kjn4nykr0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Nov 2022 08:35:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YfXTCgDCZrRG8TaTDZ2Ua06lSviUPVLBNlYPBhJY44ARVrd1owo9oibmBuBXUltt6yeOAC1izfgwzbs867D3xhg6vjN7Ac1FGO8RF21vHRrSG08xJxxisUDm5alhOVtgra1rKbSx2gshDPEqlRNz/InA3gOERv5j0t3j+KhznhQQ8Bm6F+JnJxQEee53QtZzJONcLIzw1UCL0J+k5ziLZejtQJ5TMsOle3u5jj0kse+/XbK5KcsPLKxEVomLYXdfxVAxZdr+Z6P9aHu/ooH7gEzY0Uedq3hKE2MPg8Zpl9ohUgIjlVH8X0wIpOXTWF5wm//ORLCz/OtuY/EmmXwrCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TyPMoL/hHz8sjBFlCqMtRYMybnTY64GCGocxhkzHtS8=;
 b=MR/ghiX65bKZ3YD6xjM1D40ALNBrZY7bG1e2DH3j6ZUpJ4F70vwUs8Fqg8M+9qkNwIVC8CCF0Z1AKgZYvverYv2UveebYcU1aXDNpQ0F4qdcAnUI6OCkZwPk7LAPeGFZrsfOf/KTfycaDmRCAv+phx4NpqOiBE3IDfeFeudGA4+GQcQulAyvAXzk2YFC9ykbwm5RF0GISbEYdyK/0/Ic1UM0V22wVEs9rpE5s8ixcefiVIoHuJdWTd14x0gRMdhg4OmfV2TUQjB6NIRpdFO9rzld7T+GkeRbjtynP4PtOQ4z3sl79AgT5LUlf36RLevMRKEBN0fbGZPkV/bHGgrNfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TyPMoL/hHz8sjBFlCqMtRYMybnTY64GCGocxhkzHtS8=;
 b=XUkl467+uLRwukgTS4yVvMmFrCOPh7kTQe8hQAN6HcvUfB45sKbjbz4LYZAC9def4bdh34SVxRDkrMcEm9leqFjfMCMBf/WXaEvuuvaK8Gfp/l4CdQyEVi/oh21s1vhJdi7SKzR9Tl/9StEo9LWvoNrzaSbBJCxOgiLcdvTzCi0=
Received: from SJ0PR03MB6778.namprd03.prod.outlook.com (2603:10b6:a03:40d::22)
 by CO6PR03MB6257.namprd03.prod.outlook.com (2603:10b6:5:35a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Thu, 3 Nov
 2022 12:35:31 +0000
Received: from SJ0PR03MB6778.namprd03.prod.outlook.com
 ([fe80::bdbe:d510:d09e:8abd]) by SJ0PR03MB6778.namprd03.prod.outlook.com
 ([fe80::bdbe:d510:d09e:8abd%8]) with mapi id 15.20.5791.020; Thu, 3 Nov 2022
 12:35:31 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     "Bolboaca, Ramona" <Ramona.Bolboaca@analog.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Bolboaca, Ramona" <Ramona.Bolboaca@analog.com>
Subject: RE: [PATCH v2 0/8] Remove adis_initial_startup usage
Thread-Topic: [PATCH v2 0/8] Remove adis_initial_startup usage
Thread-Index: AQHY71uS1QH1RLZlHUSZW0mLk8EYpa4tIjSg
Date:   Thu, 3 Nov 2022 12:35:31 +0000
Message-ID: <SJ0PR03MB677857576EF31B737F6D3DF599389@SJ0PR03MB6778.namprd03.prod.outlook.com>
References: <20221103080847.162509-1-ramona.bolboaca@analog.com>
In-Reply-To: <20221103080847.162509-1-ramona.bolboaca@analog.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctZmZiZDk2NjEtNWI3My0xMWVkLWI2YmEtYmNmMT?=
 =?iso-8859-1?Q?cxYzQ1ODgyXGFtZS10ZXN0XGZmYmQ5NjYzLTViNzMtMTFlZC1iNmJhLWJj?=
 =?iso-8859-1?Q?ZjE3MWM0NTg4MmJvZHkudHh0IiBzej0iMTc4MSIgdD0iMTMzMTE5NTI1Mj?=
 =?iso-8859-1?Q?k4NTAxNTAxIiBoPSJYVHR2WnBEL28zNE53WWduRVNBdGRDVk1xeEE9IiBp?=
 =?iso-8859-1?Q?ZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQU?=
 =?iso-8859-1?Q?FFb0NBQUI5OXhYQ2dPL1lBWGpkODQ1bHJ4M3hlTjN6am1XdkhmRURBQUFB?=
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
x-ms-traffictypediagnostic: SJ0PR03MB6778:EE_|CO6PR03MB6257:EE_
x-ms-office365-filtering-correlation-id: c5438dac-0d0f-4cc3-565e-08dabd97e5a8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dm0IVsKsEBWoZFcLA22i4BZAxQSUdFEAd2JFP9xuq6F+2mAHyR1rZGrwDcqxIFhGbRLRWwHyL/FVsnGlGzApBZWWM4ZjJiid/+flLPkPUgogTwhwq0rsQW/KZhhSA4V0xrjg/mozPF0VIVXYYHmdqKSv4yQ3BDh/i3yh8yaLKYItnI6ob1BLdff/01cJBz0bF3ynM9IOe/tuZApYWJafex6veeTmiLmzKAHMQnhMDwd2fRMlIpCM3ObG2bLS41igAbTMsklwg8wZ1HBBgZ7NigZOjUIJDu2oa+NUQmLuFkT5KjaPSS0LN0i3m8bZWXicjHi+X7NWca4MiP8ja08Cn32krIL53pLtEVk5aoOm3ev91LIFeWnxZ6yCg9vFdCQqkTG8ix5S4oc2x4mClnUF/jCyywznYk3D2DpOnxbVdD4TMi6TyKxqAG5ug7JoKQoI4ALxCWZZA8lDG+rLGPl1WHwtvGPBL6CFfMDq3ABWD54zVwy55Hp+NntnS3z29DboYx1wj7Yfyxv+LYKPD/n9seUOZu5ynSIEzxppYf5hpOfigiEwRwemkYw0NIysKh+7szL2ueZMVOQ3DyPWk6sOhfLuO//U5VZVdp/W+FtZc/EG4qwZ20cl+K6UGeHim1KuJbU1W5f9CbjU4RiOBxg8MGgclIPvJiS3avHC8hHeAHmiPv49lgsnBajdeQBTcvIPFwTmQaFAEYUPtezLTrhmuGpOq7l/lgDbSoN7heXckw4h87xu7QHX8OhfG/OzYbDyTjEPtWXWXxiW37D6AbnyOg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6778.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(396003)(39860400002)(376002)(366004)(451199015)(478600001)(110136005)(76116006)(6506007)(7696005)(52536014)(66556008)(41300700001)(9686003)(4326008)(66446008)(5660300002)(2906002)(8936002)(26005)(186003)(66946007)(66476007)(64756008)(83380400001)(38070700005)(86362001)(55016003)(71200400001)(38100700002)(107886003)(53546011)(8676002)(316002)(33656002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?YUUI24c/fsZAccR4PKpUkwoolLTaQSVQyOQZEN8Lq6snopjnJ+XdnLB+Qa?=
 =?iso-8859-1?Q?QQlKxzypNEpUiYaSY+FPoQcMx3PLrRC8+f8yJWtnOXe8vKeqMGBYFmFuO4?=
 =?iso-8859-1?Q?Q0/x1o1VjlNcO0WaC835bZ5ACT+P/AWQK6qnyyvFTpCkQn7G34h+4DInWN?=
 =?iso-8859-1?Q?G4y/Br53Z4N6lin0B1RxsC8GVzLHwBda3i/NEuc4rcL521amoc+EfcQI5b?=
 =?iso-8859-1?Q?B7EuTThf3sn33FbtRQSJinPuNXF+hH6ZjGdJ2VZj/i2yJfAArR9GIgVHRV?=
 =?iso-8859-1?Q?1rFEmfhxeTf3/0++AyJsn7yZOZeikl4HxhCi4Y5gZjyaqwzzSNS8c1E9AE?=
 =?iso-8859-1?Q?6vfAOvWQB5Mo5YRgKuu2bcc4WLOHfWia9qIBYxzlz06KT+ESTNd92GnzRY?=
 =?iso-8859-1?Q?YAy2d+5GKbisBp/iQnfNmVJ/YG9CiYEmrz7bp/Oe37G4CTH9kwG7roar/S?=
 =?iso-8859-1?Q?yUUJN4QW9FDY+nxWnqhvHFF4Finali8n12qXx48LTg36eEnr69RWlJ1WZU?=
 =?iso-8859-1?Q?ePy8mvgBK6Nmf/XMZrjTmZFOed9COpTLj4YOM1VRXBmvkwfV+D5AxKCeL2?=
 =?iso-8859-1?Q?1anyOWiNfL1VZLo44BR5Rrx68EinH8s3IbkD6BZzDTWLRoWB5xcFOrZbf3?=
 =?iso-8859-1?Q?m8hR2VXfQVrnIIKAcpVGv71akVtJEYY2komVYw+f11lY3vLgJgRv6/QkKV?=
 =?iso-8859-1?Q?24gEwVLbGKtWKfwQlj4q7+KyS6n17BG8l1q8fQsHVp0majF1B55p/si3bx?=
 =?iso-8859-1?Q?siQTc7kho2xmR27L/4A6C/GByJ/vQtLKZNzOCAHG9Jl92Lyl/9tHpZtdH3?=
 =?iso-8859-1?Q?e8Jhef6oo0v5FhZQDSFo1GIKmQrndnHWiv9Z0iUBToLSToh/68Uy8tIBvV?=
 =?iso-8859-1?Q?BMvSVfiGIurMRqNvt0iWx2+ZO5yOp74OES+L7JzTRYcZJFDhM1MxKI/Ocm?=
 =?iso-8859-1?Q?3EG74iwliz0Bv8weCCTyJJmYo80YHCsVqqxZshmO3MuzDMg8uik/D7f9XY?=
 =?iso-8859-1?Q?q0FzVGPmTkCo7cppl8fAb5Zk6DaahFUk1YU2Ayj8CY/aAv99+ggQTEpNEO?=
 =?iso-8859-1?Q?qq5IkQnTHVsR3AaE7D3GrxuBgV66royb9pKlJJnZJCupzFvHk84BhIA+Mz?=
 =?iso-8859-1?Q?mKhXXqeqMAuM4RqAUuPR7+Kx8zitLctGGtAvu36N800SY2VaZV2eNzMeZB?=
 =?iso-8859-1?Q?eg029dchyB04Jbof7CB1qEiejK0ub7e0kReF+W4dBGuwIc9RklI5Zwsfg0?=
 =?iso-8859-1?Q?77aa3hpAh9bOCDgtm7zIJGRScPtTGCgkVqkMx/o2VdlVtXSgoX8au8Gyeg?=
 =?iso-8859-1?Q?aURlXmZ8cBRcXYApGjBADD3sewT2FTcVn/AmJKd7iC+Vg8yPXybPeGSlA6?=
 =?iso-8859-1?Q?xJMW0AZYl464S1725ss5F9jaReUzO9T66/2dsJV25DRKmL75HDuGWP6PRm?=
 =?iso-8859-1?Q?+PR5TmNVeSfGkZGeXavWgRk//CTXAICx878kX/XExfthufH+Qy8PPzDu31?=
 =?iso-8859-1?Q?9VpL7pMUipsgPENgP7gT2YikRZFLc1al7UR1TSkjKc+V95xGm2hjfikrL5?=
 =?iso-8859-1?Q?dVQA0PUniR1fPWmNaHlwSlNVBJyZb5hzsn/P/NpEkPSNZ7mA2cCl9mFttU?=
 =?iso-8859-1?Q?kGVB+mBoL0r/zCvmr6iaD/A73EcAXFDWUI?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6778.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5438dac-0d0f-4cc3-565e-08dabd97e5a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2022 12:35:31.6916
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G17jVMI/PBdFf+dhnsbKf5wYs4JEgqVvXgnkQrVmXGvttvfOanxfYMylqHKeXCjxyqaXfmCRo/y8aphlRCsogw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR03MB6257
X-Proofpoint-ORIG-GUID: hxpnvKsJevejRsZG4Ftuu216EITn3mkx
X-Proofpoint-GUID: hxpnvKsJevejRsZG4Ftuu216EITn3mkx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-03_02,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 mlxlogscore=999
 clxscore=1015 adultscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211030086
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Ramona Bolboaca <ramona.bolboaca@analog.com>
> Sent: Thursday, November 3, 2022 9:09 AM
> To: jic23@kernel.org; linux-iio@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Cc: Bolboaca, Ramona <Ramona.Bolboaca@analog.com>
> Subject: [PATCH v2 0/8] Remove adis_initial_startup usage
>=20
>=20
> Remove 'adis_initial_startup()' usage due to the fact that it leads to a
> deadlock.
> The same mutex is acquired twice, without releasing it, once inside
> 'adis_initial_startup()' and once inside 'adis_enable_irq()'.
> Instead of 'adis_initial_startup()', use '__adis_initial_startup()'.
>=20
> Ramona Bolboaca (8):
>   iio: accel: adis16201: Fix deadlock in probe
>   iio: accel: adis16209: Fix deadlock in probe
>   iio: gyro: adis16136: Fix deadlock in probe
>   iio: gyro: adis16260: Fix deadlock in probe
>   iio: imu: adis16400: Fix deadlock in probe
>   staging: iio: accel: adis16203: Fix deadlock in probe
>   staging: iio: accel: adis16240: Fix deadlock in probe
>   iio: imu: adis: Remove adis_initial_startup function
>=20
>  drivers/iio/accel/adis16201.c         |  2 +-
>  drivers/iio/accel/adis16209.c         |  2 +-
>  drivers/iio/gyro/adis16136.c          |  2 +-
>  drivers/iio/gyro/adis16260.c          |  2 +-
>  drivers/iio/imu/adis16400.c           |  2 +-
>  drivers/staging/iio/accel/adis16203.c |  2 +-
>  drivers/staging/iio/accel/adis16240.c |  2 +-
>  include/linux/iio/imu/adis.h          | 12 ------------
>  8 files changed, 7 insertions(+), 19 deletions(-)
>=20

You could have placed your v2 changelog in the cover letter.
Moreover it's the same for all patches... Anyways:=20

Reviewed-by: Nuno S=E1 <nuno.sa@analog.com>

- Nuno S=E1
