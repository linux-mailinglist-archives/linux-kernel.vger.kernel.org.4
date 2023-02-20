Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4A0D69CFC6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 15:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232136AbjBTO7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 09:59:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbjBTO7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 09:59:19 -0500
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1801BB92;
        Mon, 20 Feb 2023 06:59:18 -0800 (PST)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31KELe77001814;
        Mon, 20 Feb 2023 09:58:51 -0500
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3ntvf9v96h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Feb 2023 09:58:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CSxLEOfNuUSzPBVaQCt3UxSwARQ97rFNTKlZD/iKloNtGjW6MUD17KPjrb16R1kXhT7s6jEuDnKrmYMDKjs8mYlcF/Ozg80FJTBFGHJRNkeObIi/FR9t0ZnW0Tvdp4diG8SdJC3QEqaBaW6F8RDbfzxeqEXamM6o+cpzYi0m6oXStvGZth8z5eBjIdH3Uqce39YTJom2yE/D561M80tdat7s8sd5dd5Mj7oEfbHh80GIFwpf0SvAyxJWAW4XH+Vt5c/TouGwmUcIAuoVNVXWtQ+k5AS98wlOJCWaf1rWEY0Ay+uZRXbYAK2RWFv8NQILs/ktpqsmd/VZ0CXn16Gu1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wt6NxkhvOg55+6NNtj4lKnG15XDxZ3xKdflGlz2OlUE=;
 b=Gs5XshrVCfW34j+uB2+WAqCAVznF3EYrPfmrBv0plXztCmL3OenAxBeIS/OWp5g+Rc1nJkvEbhUIo2yLf0qxZgRbSdKTGlTByhiQtIyTv9Tt/+dqmcgS/Xcz7ebMOqkjvav6pjIYM3m8Vqyrp80uom2xE1M1NYtzKGfuGj1PKtYofoUWzaPipU5cKzZcVUtG/z/j3gPUUC7k0ib2lFdBHR7ZMNlwvyHXlFVpRehI/Hg2zVyLT5R5rCRzOR9Hei1a92cNvZTFZKMkkJPTn8MGVsgI/M97YXbloaSB72CEV9cdr33YRZp8pLvI78MC03Mto/UudTsKpAzI2bFtIxeeYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wt6NxkhvOg55+6NNtj4lKnG15XDxZ3xKdflGlz2OlUE=;
 b=rSQeTqXahqL5ZpNilJ8cBF45XTYlk/J6DpSFU2DcPzREzatEAoaNJoceggNEokPBG6GnNkGobwvvnLZTa7/E7HQbEal1wNhADEaaFYmrcDUR7A5uEiQ+iGHlHtdFuzIMjrtNEZXstTYlHe/GII9GUwHbIX+gvrmA7nsdmVeuiQ0=
Received: from MN2PR03MB5168.namprd03.prod.outlook.com (2603:10b6:208:1ec::19)
 by SJ0PR03MB6240.namprd03.prod.outlook.com (2603:10b6:a03:3ae::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.20; Mon, 20 Feb
 2023 14:58:48 +0000
Received: from MN2PR03MB5168.namprd03.prod.outlook.com
 ([fe80::e23e:3ad3:46ba:be2f]) by MN2PR03MB5168.namprd03.prod.outlook.com
 ([fe80::e23e:3ad3:46ba:be2f%5]) with mapi id 15.20.6111.019; Mon, 20 Feb 2023
 14:58:47 +0000
From:   "Sahin, Okan" <Okan.Sahin@analog.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        "Bolboaca, Ramona" <Ramona.Bolboaca@analog.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: RE: [PATCH v4 2/5] drivers: regulator: Add ADI MAX77541/MAX77540
 Regulator Support
Thread-Topic: [PATCH v4 2/5] drivers: regulator: Add ADI MAX77541/MAX77540
 Regulator Support
Thread-Index: AQHZNik+tm1Ya74YjkGZfAcBvJC/Vq66JxAAgB3hXCA=
Date:   Mon, 20 Feb 2023 14:58:47 +0000
Message-ID: <MN2PR03MB516851FC99B1EDA2604B557FE7A49@MN2PR03MB5168.namprd03.prod.outlook.com>
References: <20230201103534.108136-1-okan.sahin@analog.com>
 <20230201103534.108136-3-okan.sahin@analog.com>
 <Y9p3dIj+ix0A7SpR@sirena.org.uk>
In-Reply-To: <Y9p3dIj+ix0A7SpR@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcb2thbi5zYWhp?=
 =?us-ascii?Q?blxhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4?=
 =?us-ascii?Q?NGJhMjllMzViXG1zZ3NcbXNnLTExNDM5YmQyLWIxMmYtMTFlZC1iZWE0LTU4?=
 =?us-ascii?Q?NmMyNWQzYzNlNFxhbWUtdGVzdFwxMTQzOWJkNC1iMTJmLTExZWQtYmVhNC01?=
 =?us-ascii?Q?ODZjMjVkM2MzZTRib2R5LnR4dCIgc3o9IjE0MjYiIHQ9IjEzMzIxMzc4NzIz?=
 =?us-ascii?Q?OTg3NjE3MiIgaD0icWFsWEFxRC9hekdpMWNYRXVEWHFrNXlEUW9nPSIgaWQ9?=
 =?us-ascii?Q?IiIgYmw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFBRW9D?=
 =?us-ascii?Q?QUFCTUJwN1RPMFhaQVpUbzdENEZ2VmRjbE9qc1BnVzlWMXdEQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUhBQUFBRGFBUUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUVBQVFBQkFBQUFRZGlrNVFBQUFBQUFBQUFBQUFBQUFKNEFBQUJoQUdR?=
 =?us-ascii?Q?QWFRQmZBSE1BWlFCakFIVUFjZ0JsQUY4QWNBQnlBRzhBYWdCbEFHTUFkQUJ6?=
 =?us-ascii?Q?QUY4QVpnQmhBR3dBY3dCbEFGOEFaZ0J2QUhNQWFRQjBBR2tBZGdCbEFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHRUFaQUJwQUY4QWN3QmxBR01B?=
 =?us-ascii?Q?ZFFCeUFHVUFYd0J3QUhJQWJ3QnFBR1VBWXdCMEFITUFYd0IwQUdrQVpRQnlB?=
 =?us-ascii?Q?REVBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFD?=
 =?us-ascii?Q?QUFBQUFBQ2VBQUFBWVFCa0FHa0FYd0J6QUdVQVl3QjFBSElBWlFCZkFIQUFj?=
 =?us-ascii?Q?Z0J2QUdvQVpRQmpBSFFBY3dCZkFIUUFhUUJsQUhJQU1nQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUE9PSIvPjwv?=
 =?us-ascii?Q?bWV0YT4=3D?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR03MB5168:EE_|SJ0PR03MB6240:EE_
x-ms-office365-filtering-correlation-id: 04fd9dbe-fe1b-4dec-ebcc-08db1352f861
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p6/5ygpDQlYHNGOHlqFGH9nzfaCOLbTG3r2njpIMer56cI39Dp6ynoFA1gx3+K4apxj0pqh9kpX8UmrI4RreZowbQH9SivLr9seBVR5V9sJSKzV9Mk0eTSB+sWwMZ62txzvZzLaEIHVTfv5RwgcVoYAT+NIGrtAqUtRPJUI0tGPB6UH4y/9HKqHsPqy6IlfuoCKDlO9LfjzdKq8JdCtGh32vj0jYa4nDEV31t+zy9eyWjlnwgI9HkH99i9/TRudux173kxOHMvLZ/99AGwF++ymbsUkQlQ8jXh+UpFtUqk1eVR5y9/N+8ywtquzbIG7qJTQ3L6c+o/oZt5FqPa9jJA/qhB5qmWDT5O++kQJ6owdgUoBbbBJvfLCsyz/8gFlYYvzQCv5+lahm0fptR5V6X6xVW/1q0b2wn6NGAeKLCPW/CuFrXgzMy4u+hp53p/2vcKGD0QYsirSqNAuqeCVSQrvJ3pfZS5SpEqEbcxXC8Gm1avX+Qz30E9B6/z1r8/kVUEd41vCTM+mG2yqaCTffzyqpeIvoxWfbsMvn2cg6gVzV1i29tpvHT1VyeGq3X9a+wlRu7tZaxqMfGDrMVmBZOr/qJt/NjVB/5aPuBL4RMBaD/FrryL4Yz1naFVHx0UqUVuYCgnMkWlNw61FXu6QFd7Di7qWhOFv/OMjnexYaL2fxzR41+vxLQlpB7YCrh9SSHvM+LoYRHHdGOX/cXuXeYw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB5168.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(366004)(376002)(396003)(136003)(346002)(451199018)(186003)(26005)(2906002)(122000001)(41300700001)(6506007)(9686003)(38070700005)(38100700002)(7416002)(5660300002)(8936002)(52536014)(33656002)(316002)(86362001)(76116006)(66446008)(66556008)(66946007)(66476007)(7696005)(8676002)(6916009)(4326008)(478600001)(64756008)(71200400001)(55016003)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZPPJN1ZdPU0H3d52Oax0C6CYh2VxSoyaUqOnCo3yNSxlSLcP/iRlWS0b0aRn?=
 =?us-ascii?Q?SIjskMgXde5Dv0qd6b6S2IgLKVC1qzu2IFnNeg0GZKEo229eulJLqC+Xtw3+?=
 =?us-ascii?Q?GBtLvfn7IRmONWW/J3p+Nxw1ONDJZIHniKu8QHhnj3shHWGKjZDZneottdDz?=
 =?us-ascii?Q?R1w/JjhR6en4cQCUSOoS7jNzjSKGxxZd4jESmzlWx27sFBmN8xFVSxim4TTa?=
 =?us-ascii?Q?ccDRDkpTt3FxtVEPMCTu7oqurS5/ye6TVVNQnyDgx9UW7OO7RKgNBvvqQITA?=
 =?us-ascii?Q?NywNdyPen1aGcj2VJPHa5+TPifzKqjUDsKEWlFM4rVwZnARAnyjUJ9FllnyK?=
 =?us-ascii?Q?STMQnptiL/rBj1wpvoKdbq5/n1v7d/d4bUwjTFvMnQwike+ppG3gMk8X1Kb7?=
 =?us-ascii?Q?VmXZPC09T60QkBk9YHJV4StiIKenloC823ZnRodd2KeJstKiSfJ/omhB5Oju?=
 =?us-ascii?Q?6aOs5xuimY4Ny8baAcd3dWTwlEVaMdarYFzi0Cv0IpU+rna2aFEWGyCy1UfX?=
 =?us-ascii?Q?JbePxXYePr6ZdynzFfmHGNfQ0ArC9Hm6sSC6FJpM06F+JhPBc+jeBE/douSD?=
 =?us-ascii?Q?NkgO0gnNRJe26fc97efR1cz/L95p9Q7SddlJSpDu8hSL3inzfLuMTbVwklHe?=
 =?us-ascii?Q?m08Q219+D4z480KLSsaFe4V3bnoj+T2x9ECjW6UcEjZuadH8SgnUzT5IBYBt?=
 =?us-ascii?Q?1TiNhqadaBWNRa1HUEvZXV1IEMpFr8oqeg9n+KMNGOZJIDgN8gvKmdJsB/L7?=
 =?us-ascii?Q?Nhs1JYKvdJAXCpFnttAn0ePIJj3YQChhhiXtxuXnwk2E+wQCZYhuIWMOtZdq?=
 =?us-ascii?Q?wgwtKdBMpI4AZfB3Fj0O+juROoS1WWjFwp97UmjfqdrGVXQT92LdNDxABY7M?=
 =?us-ascii?Q?zZp1LlooLLZar2kG3S9NExy+py+Q3WhZSegyXlNOnss29R6ZasWQIvtWKY3b?=
 =?us-ascii?Q?2kA+1g3/ONo+mmL7Qi/sP4shVqiV6HxMp3P4cO0R4MU44pT7I/wjOvYj3dQi?=
 =?us-ascii?Q?c2tn8U8VCDpm7rn4c2Ly5ZDUv7iDYMo0Dw3NOPMxCMEtlXmGZQjhJ62pIicb?=
 =?us-ascii?Q?h3TaZVi7OU374Hck/BILNxkDwk+BLZpfT5e9YSWaL7WID6ClUeh9Pg1RdEXa?=
 =?us-ascii?Q?6oVA01IKJH9CXVd+geU4CW8aW+jcUwnsEc3czZdHtjWZZetVMvCFB0POswoS?=
 =?us-ascii?Q?/FWX3lBgGlpvMcnEgFXvznPzCNsz3nj92lVEu9xd5Gcyg9X42dz/POxDCbSP?=
 =?us-ascii?Q?n5UfGQI/NrIxYBtU3a3D8XCoOHByb4L18xFNmlQqR4eTxysLsmWsfI/g38i3?=
 =?us-ascii?Q?3aCCCho+vymMgj7ELB2b+oka8LP+sUGO4APXFgxtHh0jibl0ZVdPqqU9ry75?=
 =?us-ascii?Q?QvgkH4r0A68rCO3MDzhW7r8tRBBdm1UK9DVrWREtQSLCwkWTEZRaas8RbHpR?=
 =?us-ascii?Q?a+TmU4qWxruso0D5CpVaOnv/569OAG+WVCocrMZAPs4EHgjADO/2ebAW6rhC?=
 =?us-ascii?Q?cbE4S7sHCyMnH5/rCymloytibcERjTWqrmOHMWpy6DADoAYzPgCJRHMxe2ss?=
 =?us-ascii?Q?1dmqMoE+auKg3oUa1NYQQGG05qFACSbtbs71QrdQ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB5168.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04fd9dbe-fe1b-4dec-ebcc-08db1352f861
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2023 14:58:47.8001
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s+UFHcxMED/16TgzqE2/G+Ia/3fv6CufF+T3PEswYTbmdz5E+DXlAoE6NXbzi0nJb1GAnhHfpkG4QXJtIIR7lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6240
X-Proofpoint-GUID: tGD6fzmGHO7fEdmnok_g15zgbNAMQzh6
X-Proofpoint-ORIG-GUID: tGD6fzmGHO7fEdmnok_g15zgbNAMQzh6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-20_12,2023-02-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 spamscore=0 adultscore=0 mlxlogscore=648 clxscore=1011
 phishscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302200137
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wed, 1 Feb 2023 5:30 PM
Mark Brown <broonie@kernel.org> wrote:

>On Wed, Feb 01, 2023 at 01:35:15PM +0300, Okan Sahin wrote:
>> Regulator driver for both MAX77541 and MAX77540.
>> The MAX77541 is a high-efficiency step-down converter with two 3A
>> switching phases for single-cell Li+ battery and 5VDC systems.
>
>Please submit patches using subject lines reflecting the style for the sub=
system,
>this makes it easier for people to identify relevant patches.
>Look at what existing commits in the area you're changing are doing and ma=
ke
>sure your subject lines visually resemble what they're doing.
>There's no need to resubmit to fix this alone.
>
>> +	if (max77541->chip->id =3D=3D MAX77540)
>> +		desc =3D max77540_regulators_desc;
>> +	else if (max77541->chip->id =3D=3D MAX77541)
>> +		desc =3D max77541_regulators_desc;
>> +	else
>> +		return -EINVAL;
>
>Write this as a switch statement for extensibility.
>
>Otherwise this looks good.

Hi Mark,

Thank you for your feedback.  I am not sure that I fully understand your fe=
edback. What do you mean by "reflecting style for the subsystem". For examp=
le, this patch includes files modified or added under regulator directory a=
s stated in the subject line. Do I need to say anything about mfd as regula=
tor is subdevice?

Regards,
Okan Sahin
