Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDC66062F5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 16:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbiJTO0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 10:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbiJTO0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 10:26:09 -0400
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27AE41A993A;
        Thu, 20 Oct 2022 07:26:06 -0700 (PDT)
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29KDCN3u026212;
        Thu, 20 Oct 2022 10:25:34 -0400
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2047.outbound.protection.outlook.com [104.47.73.47])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3k7pmcbrv5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Oct 2022 10:25:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Go2N7yshokrgUedilmYkuKN8vXZp/aDgMgCxVlN63cLJCQLfPIlw5yNNUvrW/UeYA4BfPoiQSXmjxQF7EqAWWVeEZniYlTxH0i2aT/aH5Sje8fNY2FL49mBarh8mHPjygFedfo9xPbTn4vLSkrQNEg739ZL2IJIxd5y6XnEB/dEfpG+z+Ef6sU8oeQ0rETs08AhlqwRnP4LB24B1KVRZSJSvcyqO34M164vfkpWifRx/QhAKjBOTq7mlnpInD0ZeG+VExGUy6qy9sBx+KFtiQNi21VsJCBc/bIF/An8DyEFZ8Yu9Ufy1SRGHFGN7O3ql/1+xuHVF6mRBhu2uHCfoDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ii6JjfdJMWLQmHYsDOF8LdfzfEMbQMl8LeFHUeOprsE=;
 b=fRU+OiQb/XII87xjyx3ljx8+OOGxVDX+vTWbSCJ6hC8gQhuYGBjZTmi6YcBom0w6WNfkXhUvHYJgWqoZpCTkr42syQcz6N7D1lMj8kToSgXDLkuOh0+8+HOUlKJXKRzGDBchKl9h7IBqEgt4b05boMfFoNU/mcJU5Utv0GTMtxWwbX+qGmfrNIIUbsXRysbg3Hf/P8dgHNAbAJkyYiK7b6Z8pnVHSKmtR60JC0OrAfSRcOVwDxG/lSZ12szpsW8fz+Xi18qRxJ4tyanZW1Zdjek29XDEyCyy7wG+yIzvHZO2zmXnB2KUlH5SGcsXPDxOoqT3ZOZGFtBb5orUMH13OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ii6JjfdJMWLQmHYsDOF8LdfzfEMbQMl8LeFHUeOprsE=;
 b=s4A0jjTS9le8ETOvCJStnBczIPDS0mBkVTJ0InSZ5XEYIdAvcK1tpws1zpZn9IPBCRPpO2O1seJb8jfjXoqXZ4zLwojgE3zJBmPHdSE37hqCa5d0/2ZTVn9uYhtSimnCV84As3iS9h9FMpsZLJKp4ZbAcIGV8t2AkbqWGvhdgfY=
Received: from DM8PR03MB6247.namprd03.prod.outlook.com (2603:10b6:8:3b::6) by
 SA1PR03MB6420.namprd03.prod.outlook.com (2603:10b6:806:1c3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.35; Thu, 20 Oct
 2022 14:25:31 +0000
Received: from DM8PR03MB6247.namprd03.prod.outlook.com
 ([fe80::17cf:8070:5f0f:8b37]) by DM8PR03MB6247.namprd03.prod.outlook.com
 ([fe80::17cf:8070:5f0f:8b37%7]) with mapi id 15.20.5723.034; Thu, 20 Oct 2022
 14:25:31 +0000
From:   "Tilki, Ibrahim" <Ibrahim.Tilki@analog.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Arslanbenzer, Zeynep" <Zeynep.Arslanbenzer@analog.com>
Subject: RE: [PATCH 2/2] dt-bindings: rtc: add bindings for max313xx RTCs
Thread-Topic: [PATCH 2/2] dt-bindings: rtc: add bindings for max313xx RTCs
Thread-Index: AQHY48BZbMpT/SjNa0SzYqltq8qQ864VyDiAgAAQ9QCAAX5sEA==
Date:   Thu, 20 Oct 2022 14:25:30 +0000
Message-ID: <DM8PR03MB6247FE3C128DE9FE5BF6F591962A9@DM8PR03MB6247.namprd03.prod.outlook.com>
References: <20221019133910.282-1-Ibrahim.Tilki@analog.com>
 <20221019133910.282-2-Ibrahim.Tilki@analog.com>
 <3d07998b-f02a-036c-af66-883671ac1730@linaro.org>
 <20221019153456.GD4602@roeck-us.net>
In-Reply-To: <20221019153456.GD4602@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-rorf: true
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcaWJyYWhpbS50?=
 =?us-ascii?Q?aWxraVxhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUt?=
 =?us-ascii?Q?NmI4NGJhMjllMzViXG1zZ3NcbXNnLTA5OTdiOWZhLTUwODMtMTFlZC04ZTYz?=
 =?us-ascii?Q?LTdjYjI3ZDcyMzFhYlxhbWUtdGVzdFwwOTk3YjlmYy01MDgzLTExZWQtOGU2?=
 =?us-ascii?Q?My03Y2IyN2Q3MjMxYWJib2R5LnR4dCIgc3o9IjI2NzEiIHQ9IjEzMzEwNzQ5?=
 =?us-ascii?Q?NTI2MTIyOTQ3MSIgaD0ibTV4dkg1QVI1VGFuRVhlRzhMMGVVSEp5Y1YwPSIg?=
 =?us-ascii?Q?aWQ9IiIgYmw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFB?=
 =?us-ascii?Q?RW9DQUFDZjBmekxqK1RZQWJtS3lFTmZGUnF5dVlySVExOFZHcklEQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUhBQUFBRGFBUUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUVBQVFBQkFBQUFYNWwyS3dBQUFBQUFBQUFBQUFBQUFKNEFBQUJo?=
 =?us-ascii?Q?QUdRQWFRQmZBSE1BWlFCakFIVUFjZ0JsQUY4QWNBQnlBRzhBYWdCbEFHTUFk?=
 =?us-ascii?Q?QUJ6QUY4QVpnQmhBR3dBY3dCbEFGOEFaZ0J2QUhNQWFRQjBBR2tBZGdCbEFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHRUFaQUJwQUY4QWN3QmxB?=
 =?us-ascii?Q?R01BZFFCeUFHVUFYd0J3QUhJQWJ3QnFBR1VBWXdCMEFITUFYd0IwQUdrQVpR?=
 =?us-ascii?Q?QnlBREVBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFB?=
 =?us-ascii?Q?QUFDQUFBQUFBQ2VBQUFBWVFCa0FHa0FYd0J6QUdVQVl3QjFBSElBWlFCZkFI?=
 =?us-ascii?Q?QUFjZ0J2QUdvQVpRQmpBSFFBY3dCZkFIUUFhUUJsQUhJQU1nQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUE9PSIv?=
 =?us-ascii?Q?PjwvbWV0YT4=3D?=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR03MB6247:EE_|SA1PR03MB6420:EE_
x-ms-office365-filtering-correlation-id: 330ac615-832c-41db-f72d-08dab2a6f184
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FFoFiMnwoDAycOl99kp5lGkZqSfgR259TV2KO7uJ+Z7jTG++f8GfZkdw1F6Wr3o7UrC6D0m3Vx+OCsmfyBsho7DWJq7RzmfRGoDxLZ8h9Eyc/wxWRwFjrvFG7hqkgPoBDCtwd/RKvh3W5L1AqP43ttJUTYo0oG2H0LN6ozY6/mQYHB/tzd8xSLvy/5KZoBk13EfBTTfkwVisjuHWty3pKbXqCQJowFrabf9dpTXBxxBaPzUyFVagJ1i9Du3bwBc88vAhtlnoeeIv+SDdYkakCz4CEGpWEeukMJVIGqYn6X53Oj6ryDsyzgZ4emA57vcUa3bzskyAjIn6dRJEeUDwKu4+lZ74Y3VPJ17pzqu3wlAC7h0N+0PvroesAd6yiefALBr6QbVCiIBegHxCyh2E22KGyVzv2f+nWbzaTTrA9GVHqcfXBpA49/J6hF1qpeQHLsj6aBybvM5orTyxRk/UqfkWVYOnjoJ9QJ+395mxI+q1SjSuRXhUunsSUiut/FK9huJ0kpsE/erB0BuYdSUjTAaDNPJYVDIWB6eueW4mecKeYvq9Lk37/iharB7+9KgoxWoaIYS2iCGVRA0I3+RP2brRn0JWq5VYzewPUsV/h0iSlDVTqzi03Y9kHwUOuIiNWnqNh43a06TTYWrxuKS1mkw/NRgQy7QlWzMUQVXZEHQARhKT4aosBKwtR5Z436IE6fbgb8fMESczQQ27tvUcim0DX7kjGYuJaEWYllLc6BvHop/LCDWjMCyRg6sKRJIHYb0rR30+yp8kzeYlE4GhCmGHZvvJf1BqHO5KbKX8uxA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR03MB6247.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(346002)(376002)(366004)(39860400002)(451199015)(66556008)(38070700005)(966005)(33656002)(86362001)(122000001)(38100700002)(66946007)(41300700001)(4326008)(5660300002)(478600001)(52536014)(7416002)(54906003)(316002)(8936002)(55016003)(71200400001)(9686003)(8676002)(76116006)(110136005)(26005)(53546011)(186003)(66446008)(66476007)(6506007)(64756008)(7696005)(2906002)(107886003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VzeExUzNq3sfHmoGUhMoBfNdkVc97dxb9tWoyh6KDz0fFIORGDDfXkFDxoyo?=
 =?us-ascii?Q?8z3goQ3ERGVXjuODnTvNHMIMzmoY3/JK85u+sliV+evUw23OvYb+v3s6bOzb?=
 =?us-ascii?Q?jEsF05Oplw/2rLSL8LRlOGIyV/oVfpcEIcgjxFsnVItf+JCmZvVMSQmQ8s/z?=
 =?us-ascii?Q?xpo+eKMgtUi26b0oYO10WHNDdfx2USXqm9mSEJkp8UYPfkCNaCIMHruHsyiQ?=
 =?us-ascii?Q?OGAsAYm2ink3ywZDaMtR1uzEU8zQAVqrSEjwTb1SnyIN9TG51O1grXde4cWi?=
 =?us-ascii?Q?9TOICleGWrVYVoi3OZ7UfrJVVY6TFiW+2OFOJDGUm6b/hMIKNE84mT8DzHsa?=
 =?us-ascii?Q?KOLdA8/uAElzpr2yXOoM0gFpcQpNR0g4uO1WnePdhwuwT+ckF/QqE1i/L/DH?=
 =?us-ascii?Q?pq+5dMzgT/NSLvZA7XLHPldkTA7WRp2QW6aaIrzWuJSntzqca30nsv9Q6wSl?=
 =?us-ascii?Q?JEx6U+7l1Ge0TfSaPP1INb/S5nL8KhCOtr/aaHckM0lmQsHeos0ZF3U1625o?=
 =?us-ascii?Q?5Q2Wl5qBL9Qxau9MA0cLBU9lXm0Y8JUjHn3wY94EzWB13c7WbojP+wp7bcxx?=
 =?us-ascii?Q?zJ+lDfZr/GyLa+6/I8KVzPsoPGX2YVUJzRZ/BCHCp4Vz8Q/8q7zX90y9PWwE?=
 =?us-ascii?Q?w2PvCB1uh4sITlnJiwBdmGOle+r6yo0oaFk84/4cUt1mmbmEzqATmXiOcokY?=
 =?us-ascii?Q?J765i/TyuQ4/H83HqpCXm/58kcV1MCa/JgX1Bcn9MLVuZml8UN9FUkpvuPdt?=
 =?us-ascii?Q?J9Ltjm/QcAVmYU7qAx49ToDGZI2j0enpSaF4/yCuqxf/MuIzL//zGsMFexJS?=
 =?us-ascii?Q?8I1fjJ/XsphgSmvkkEiWg8uWxQTwFRrbfkeYnReJznLCce3HUBSm8A63nDiA?=
 =?us-ascii?Q?L7agLp/JrmWC1F0Sm7b6JgE2POUkenmbSUEvhHIpUzbC/JyL/n+olS4TbDp6?=
 =?us-ascii?Q?ilko6KJj22BYG8eYaTY9eei3FpOnxu9bcR5iaERVWQO9mf1zcb3QJ2XcFryY?=
 =?us-ascii?Q?cl132jwA4/i1xFsOITQrUosBMaF1bD2KRErhz+gSCPbgGk/DBGqaB5ws8KaE?=
 =?us-ascii?Q?h7lyjXxBi66zbidT8T8eHm4/M589d434FewWXVSMe82wbgdKwn30ZkljZYPS?=
 =?us-ascii?Q?vkfRIbhLCm7Awjkm3HNay/N+iHiKIniIxq2sPCAvrkpsATqfJ3E0eCJlFoS+?=
 =?us-ascii?Q?akl+fg9JuOXh0eyBiYMO6kHSB2Vq4IH9XaswUdVvDwAXtTLHHze4YiE71Tb9?=
 =?us-ascii?Q?JKrg0t+E6wDR3rAUiZ1z5YZgL6MltrDNyTNhBLgPKdZ7XmmQeam+37WxevTd?=
 =?us-ascii?Q?GtjFALCExRGBBLISPNTsj1XmdhtzwZNHp8s2E5egDltY9Cd70XjZSbe6YaMR?=
 =?us-ascii?Q?9ooLXLAMr/jQ2cW8BAm+f3yJknh8elojEltJwF28X0GwHQnx0IV+Obi/t/6/?=
 =?us-ascii?Q?BlwizNVKbHcEFPS146fy8rS0nYle0e46sg/ijb9bDCnyDTh52HuCZIEHZD+s?=
 =?us-ascii?Q?xXUSvXcCsaW8vEeNiSGBtLvu1NrlLsUvWUm59YmrFJFY0RIHVZLSEmtjsqFB?=
 =?us-ascii?Q?9JKIDcWWcxSs51f21/ORLb54UVP1uX9d++eKzIf7?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR03MB6247.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 330ac615-832c-41db-f72d-08dab2a6f184
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2022 14:25:31.2528
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1GANHdjyQ4tXNWY+/ETMJH8LLbTHWrz9hygIhTn4GxMHpRniS/q4oGbsvKhIxGjYZxadxgiiveI/E1199xorP6Ypv3aEovr19lG0tqQnL9I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB6420
X-Proofpoint-GUID: ElQE9MWClaiATxOlelCT0VA9s7gr8IXN
X-Proofpoint-ORIG-GUID: ElQE9MWClaiATxOlelCT0VA9s7gr8IXN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-20_05,2022-10-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 suspectscore=0 clxscore=1011 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210200085
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Wed, Oct 19, 2022 at 10:34:15AM -0400, Krzysztof Kozlowski wrote:
> > On 19/10/2022 09:39, Ibrahim Tilki wrote:
> > > Devicetree binding documentation for Analog Devices MAX313XX RTCs
> > >=20
> > > Signed-off-by: Ibrahim Tilki <Ibrahim.Tilki@analog.com>
> > > Signed-off-by: Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
> > > ---
> > > .../devicetree/bindings/rtc/adi,max313xx.yaml | 163 +++++++++++++++++=
+
> > > 1 file changed, 163 insertions(+)
> > > create mode 100644 Documentation/devicetree/bindings/rtc/adi,max313xx=
.yaml
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/rtc/adi,max313xx.yaml =
\
> > > b/Documentation/devicetree/bindings/rtc/adi,max313xx.yaml new file mo=
de 100644
> > > index 000000000..1aa491799
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/rtc/adi,max313xx.yaml
> > > @@ -0,0 +1,163 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > +# Copyright 2022 Analog Devices Inc.
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/rtc/adi,max313xx.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Analog Devices MAX313XX series I2C RTC driver
> >=20
> > Drop "driver" unless it is some hardware-related term.
> >=20
> > > +
> > > +maintainers:
> > > +  - Ibrahim Tilki <Ibrahim.Tilki@analog.com>
> > > +  - Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
> > > +
> > > +description: Bindings for the Analog Devices MAX313XX series RTCs.
> >=20
> > Drop "Bindings for"
> >=20
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - adi,max31328
> > > +      - adi,max31329
> > > +      - adi,max31331
> > > +      - adi,max31334
> > > +      - adi,max31341
> > > +      - adi,max31342
> > > +      - adi,max31343
> >=20
> > This looked familiar... and indeed it is.
> >=20
> > https://lore.kernel.org/all/a382fdee-3672-50b8-cd58-85563b9d9079@linaro=
.org/
> >=20
> > Where is the changelog? What are the differences? How can we understand
> > what is happening here?
> >=20
>=20
> I hope that other submission was an error; otherwise it tried to sneak in
> the bindings for max313xx under an unrelated subject.
>=20
> Guenter

This binding was included in the v6 of max11410 patch by mistake and I
mentioned it in v8 cover letter:

https://lore.kernel.org/all/20221003105903.229-1-Ibrahim.Tilki@analog.com/

I still addressed your comments but did not include a changelog since
this is the first patch of a new series.

I'm sorry for the confusion.

Ibrahim
