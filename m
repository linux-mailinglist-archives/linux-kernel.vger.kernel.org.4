Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 284B072DB0E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 09:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239778AbjFMHfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 03:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240611AbjFMHfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 03:35:01 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2951EAA;
        Tue, 13 Jun 2023 00:34:59 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35D5IVBp031989;
        Tue, 13 Jun 2023 03:34:32 -0400
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2043.outbound.protection.outlook.com [104.47.57.43])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3r4k1683a6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jun 2023 03:34:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KL8Sx9PDLKx+NZao+d0QkRqrnvQv+VL68jXd8no83UMDakst5pDhQM1zrNrz8jlLTyoWh/S+f9wX3XFmr+IOEyz6lz4uNYLWjycL/2rGS/ve7D70Y2rGz6UXDG6xUneb+smw7oZjJZvYu+58WIdMLrjOh8lb++OM8GnJpjNBmUyvDdnIdxrfe2kIJhsn9Y2DRZgXYyd7HzTUlL3SEQ0Pg0MTwWufVV8t9B5JlLftFUVF3SBQfIn6/yIpDH269Pc97bWXEib07azhchcboWMQKxm5IeCWRxNV6yNfKJ0TAw629qTTT3fzP8L8udTZRX5Zm8LDVvCBOa089rNiFqcKVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B6S7hTtvZCN+lO3VCkr69n2hS4kANM/+C2W6g7LjQv4=;
 b=Msv1gKH98NE2gMELz+hQygdAJDwLxTfY3dnfYON5MSyxDwyhohIEZkoAdIHDWvYXpUTNuWNlsOpxMfWH9n+wV0hWn/yV8TFixtQS8dCwvICYJa2Dp10OVMZ+Lok3m6n7ZOvKc3XrGFuyTU3zdfXT3Q+5AeJZWTxHm1vrfwMqcQkjBxJzvcPnlnvC0R9qzda1TJuc330oLprlEsTRS50PM3u3vmwcJoBxBNR0RBfjnYsHxu/EAJ/bdDbaTfMB9KZneEa6Cx2mvkwGs3MkONevJ2OUb0VKilhl3XUxJF3nXolCfdFxw7A94X3FJnKnh+arAs7MEJcsByEqQCaBu4DNqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B6S7hTtvZCN+lO3VCkr69n2hS4kANM/+C2W6g7LjQv4=;
 b=zODPj+ibPOvIeRWhVHGz0zRTrU5eg9c+EW/2/f5YOf1lvOniMYXak2hPPrpD/cYvPOb0XwquEYLGI18GOkws0zRhkR9Qa0JiBdfok+YCg9A7jXesePK8wce8bfH8IrHluF1c9Pv9sDxw0wa3pQ65tdQf2L9PN2yok6GZa2xboYA=
Received: from MN2PR03MB5168.namprd03.prod.outlook.com (2603:10b6:208:1ec::19)
 by DS7PR03MB5480.namprd03.prod.outlook.com (2603:10b6:5:2d1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Tue, 13 Jun
 2023 07:34:29 +0000
Received: from MN2PR03MB5168.namprd03.prod.outlook.com
 ([fe80::6ccf:ae70:970e:b3d1]) by MN2PR03MB5168.namprd03.prod.outlook.com
 ([fe80::6ccf:ae70:970e:b3d1%4]) with mapi id 15.20.6477.016; Tue, 13 Jun 2023
 07:34:29 +0000
From:   "Sahin, Okan" <Okan.Sahin@analog.com>
To:     Mark Brown <broonie@kernel.org>, Lee Jones <lee@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        "Bolboaca, Ramona" <Ramona.Bolboaca@analog.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        "Tilki, Ibrahim" <Ibrahim.Tilki@analog.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: RE: [PATCH v7 5/5] mfd: max77541: Add ADI MAX77541/MAX77540 PMIC
 Support
Thread-Topic: [PATCH v7 5/5] mfd: max77541: Add ADI MAX77541/MAX77540 PMIC
 Support
Thread-Index: AQHZbTAwI+aD1ACCtUO1/gFoBRLbUq80DQkAgABpiYCAAPfnAIAAYtuAgFLlgCA=
Date:   Tue, 13 Jun 2023 07:34:28 +0000
Message-ID: <MN2PR03MB516860989BD8ED6AC9A767FBE755A@MN2PR03MB5168.namprd03.prod.outlook.com>
References: <20230412111256.40013-1-okan.sahin@analog.com>
 <20230412111256.40013-6-okan.sahin@analog.com>
 <20230420103438.GI9904@google.com>
 <09eb8e4c-3e73-41f0-bf42-8ddf3c4254ec@sirena.org.uk>
 <20230421073938.GO996918@google.com>
 <82612171-46d7-4d82-a8fc-c7d6a99d57e9@sirena.org.uk>
In-Reply-To: <82612171-46d7-4d82-a8fc-c7d6a99d57e9@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcb2thbi5zYWhp?=
 =?us-ascii?Q?blxhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4?=
 =?us-ascii?Q?NGJhMjllMzViXG1zZ3NcbXNnLWI4N2U4ZjkxLTA5YmMtMTFlZS1iZWVkLTU4?=
 =?us-ascii?Q?NmMyNWQzYzNlNFxhbWUtdGVzdFxiODdlOGY5My0wOWJjLTExZWUtYmVlZC01?=
 =?us-ascii?Q?ODZjMjVkM2MzZTRib2R5LnR4dCIgc3o9IjU1OTgiIHQ9IjEzMzMxMTE1MjY1?=
 =?us-ascii?Q?OTMyOTc2NiIgaD0iak1NUU44NUo5K1RCbDVoOGJOQ3Bkb1g0SmgwPSIgaWQ9?=
 =?us-ascii?Q?IiIgYmw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFBRW9D?=
 =?us-ascii?Q?QUFEbWN0dDZ5WjNaQVRqNGYxQU52Nnc3T1BoL1VBMi9yRHNEQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUhBQUFBRGFBUUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUVBQVFBQkFBQUFSNmxUTEFBQUFBQUFBQUFBQUFBQUFKNEFBQUJoQUdR?=
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
x-ms-traffictypediagnostic: MN2PR03MB5168:EE_|DS7PR03MB5480:EE_
x-ms-office365-filtering-correlation-id: 3628e8c4-fcae-43b9-ca78-08db6be09ee5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jHQqJ6IcV4fC7qEu07xfw0NG1GVD7ncPXs+V6viKrNGfYQjLnRN/A/+QGiRYL0gbla6hbG+JMDpO2GeU8fbmfN7k2OkuXBtAG7+emjEF5XT0SBBm5rJBes1HDHblbH/kW8LKEovwDK/ipEmzc3ikly0g44segtfDCg3oEL39WQQghOHVp/kErJHIOC/D3HPONGjc2uzZWbNIz6PfrdkfUAJ4NTgQG7DYJkrz7RTXUAF09YKRvkhXUF023euYCmsYg4I6Bae8kTHngTm8onyAJoZuV7rmfrg+pK1ue6Mpkne5xdJRPpJzmhG9V7G+hQ0C28MvWqjqsXN1Xl5drL+9KTxw4hlEKLBQaGmMp0rVONtm+gN575i+xsPDaIudARrXTdhePsS2Uwo9LD7A/t5M7nxdxPMMZWOnFXvvJOZ9old2j1z0pKINYndDF6Wk+B3Lyomk1X8CiBcLgLAijxDBHqu/q9osPtVjjN55fZ0LhA0b5M39gxU/9h38cMo+2nbMBbjWF6mLJC7kYWs66TlWKHmcPWuGMks7iTUbJoY36bc+4NpRVbZhUrZ7Eu18pULc7fpfmFSyv2h088CTq2RTjzi5QigpO+9PVmMhCtkEmHPkmeKAQW1AdQpdU5eVLZWu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB5168.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(366004)(136003)(376002)(396003)(451199021)(83380400001)(86362001)(33656002)(55016003)(122000001)(38070700005)(38100700002)(478600001)(110136005)(54906003)(71200400001)(4326008)(7696005)(8936002)(8676002)(2906002)(5660300002)(52536014)(7416002)(64756008)(66946007)(66446008)(66476007)(66556008)(76116006)(41300700001)(316002)(186003)(66899021)(9686003)(26005)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YGgdSSJPBij2MAKJbi0Un6E6Nk9pS9mUYsRAyeiBvvLMLxodDihTy6xsgenB?=
 =?us-ascii?Q?+2qNg+J5WZTVqPZLlnTvk0d62CiXOTUTW6iYVzd/yF7EMxIHdU30wJ51YKMi?=
 =?us-ascii?Q?UcxiIZrMXpkrmHX64+YfAXNI3crPOKfsvS/Xj7RTjif+QdabWhUMGUWGC0k9?=
 =?us-ascii?Q?1kZVWmks0oMPkivI68HZOV8m/OX9nyo+mFY8p5LXd27hMui/iu9ZGl77VpnN?=
 =?us-ascii?Q?mvbbfrPvIyVeHGLAa9AZ/FKv4qZ6ECG+PDxN4a3cFm8XjRYb6MQFkGEdg73m?=
 =?us-ascii?Q?NT0tg2UI2tplCcE5C5pe9TtY/8VE0P7Pk6SYO636xw/d9YFeMoE3X9OTG1z2?=
 =?us-ascii?Q?wgfYmV1GQ8/rgus5g64HAIskBIpRbFrvvVWhBsa+s/nA5SWGsZDZZreexQdD?=
 =?us-ascii?Q?mWuT4zYkGd+p8HpOiXZNPhZ02Vler6saqFW6FrhIcAyslv8q+dm0Bv9rhdOS?=
 =?us-ascii?Q?XMiiQwZoPJvI5f777GYgG6ix0RrOyt2oJ2ldPIg8XDperuGona9Cawu2xqEo?=
 =?us-ascii?Q?8hojK6OGwy4BDUbeJA/gv8LrBEzBN3A5Zm/i1aI7P1Lra6d+SE1UZT1Wzngi?=
 =?us-ascii?Q?WoB0pCc1r+Jq4GzOvpDbOwKKv2EejT1zUbdwveAXxlcxJieTBDZ9SlvxyV2K?=
 =?us-ascii?Q?QiycMQjW0awFKdyKIAC4RLUhOqkhUQTXuXpUM0PuMyGU54ZzMLk3SfgmHApo?=
 =?us-ascii?Q?vAUqKAGj9UIJ1L9xpayP0qhUyqJXD6kvpOQYyKzPuzLTbrVn7T/mH+W02woS?=
 =?us-ascii?Q?Z3OF1nYFw25R17fnSZ/J+4Pk2NhpynHlBuMmW7F9c009EKU55f+ru/Q3gQsE?=
 =?us-ascii?Q?GV3K1EK73nOc9lCP6KifWIBW6BCcEq5ZWijQYCMNZFQPyysaqYqdJSBie3WG?=
 =?us-ascii?Q?urrpTSgLM4G3ZTRJK4iBilSst8zs6Sd+L7lcrHud5RTAblO06U/mseUyJK0x?=
 =?us-ascii?Q?pkMAr8iCxp1ck3oSmNyiOSNHkYXX/uAqt+eGfZCbC3PvV5VhiN4hJfr/lqb+?=
 =?us-ascii?Q?x28Gm2fPHFBUxUhGbsx+3icwtxM71Yxqt62LNotc9nHLveCNRjir6FzS3dEL?=
 =?us-ascii?Q?NPckUzoHcgbstcI6ti2+df8oNlYJs1B0S0q8uwvZaLEhJdlFnnKAQPyfU+XG?=
 =?us-ascii?Q?pxcNRsqMlzh2Jr+onQ+Q2DHM38ORrTuiQ5mVpjY9R79gUuORjg6qDfVqCHaa?=
 =?us-ascii?Q?0+TOCl9B/yqhahhrWBRqIpqz0VBtFiPeSgK7yNRXwEFxuEqeG9SEy1zulmkF?=
 =?us-ascii?Q?CWL0AHmawtxD/ZRjUU9/+Vx4ttL7eA5adguuzDa92757pGb/gGc8OB+BKOzz?=
 =?us-ascii?Q?SjBJax4qqCzpYBSBh1VJ1x72CyXCHj5FXSP4coX8s/YM8MY2lSCD+WuZJdzj?=
 =?us-ascii?Q?F2deyrjkgM5mgfwE4H67IUzvYUktnsJS8qhFT6pNPksGQW2MzjV2A3f7+XEF?=
 =?us-ascii?Q?5bgfWZf+ob201UXCkQY9pbOOBKWRC9qIZdcvUhPstphJYIIowroQvU2LXuw6?=
 =?us-ascii?Q?fVFo6bfIpCDfOMY97rbwFKLeY8mkkb+mesY41mknHWLZFf5JQOHaY4mlb0FG?=
 =?us-ascii?Q?oebiBT/GMbJUo6FLe4yQfSResn/VQyqRLK8tak2F?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB5168.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3628e8c4-fcae-43b9-ca78-08db6be09ee5
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2023 07:34:28.5459
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pr8Re7MlluCpbEIeQ3lx04GbqtJcZHXjrzwVbZ9T+D02CU8u8rycswKRNfkXW34v9HTo5la0KD/CUgO5rkPn1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB5480
X-Proofpoint-GUID: 7KeERJJqujbzwuj82IkWojqyHHXd6pUH
X-Proofpoint-ORIG-GUID: 7KeERJJqujbzwuj82IkWojqyHHXd6pUH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-13_04,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 phishscore=0 mlxlogscore=999 spamscore=0 mlxscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 clxscore=1011
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2306130067
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On Fri, Apr 21, 2023 at 08:39:38AM +0100, Lee Jones wrote:
>
>> I'll try anything once!
>
>> Fair warning, I think this is going to massively complicate things.
>
>> Either we're going to be left with a situation where child-driver
>> maintainers are scrabbling around looking for previous versions for the
>> MFD pull-request or contributors being forced to wait a full cycle for
>> their dependencies to arrive in the maintainer's base.
>
>If people are resending after the MFD has gone in they really ought to
>be including the pull request in the cover letter, with some combination
>of either referencing the mail or just saying "this depends on the
>signed tag at url+tag", the same way they would for any other dependency.
>
>I can't see how you applying stuff when you can slow things down TBH,
>the MFD bits will be applied faster and either people can pull in a
>shared tag or you can apply more commits on top of the existing core
>driver.
>
>> I'm not sure why simply providing your Ack when you're happy with the
>> driver and forgetting about the set until the pull-request arrives, like
>> we've been doing for nearly a decade now, isn't working for you anymore
>> but I'm mostly sure this method will be a regression.
>
>Like I said I've not been doing that, I've mostly been just applying the
>driver when it's ready.  This might not have been so visible to you
>since it means that the regulator driver doesn't appear in the series by
>the time the MFD settles down.  The whole "Acked-for-MFD" has always
>been a bit confusing TBH, it's not a normal ack ("go ahead and apply
>this, I'm fine with it") so it was never clear what the intention was.
>
>Before I started just applying the drivers there used to be constant
>problems with things like tags going missing (which some of the time is
>the submitter just not carrying them but can also be the result of some
>churn causing them to be deliberately dropped due to changes) or
>forgetting the series as you suggest and then not looking at some other
>very similarly named series that was also getting lots of versions after
>thinking it was one that had been reviewed already.  It was all very
>frustrating.  Not doing the tags until the dependencies have settled
>down means that if it's in my inbox it at least consistently needs some
>kind of attention and that the submitter didn't drop tags or anything so
>I know why there's no tag on it even though the version number is high,
>though it's not ideal either.

Hi Mark and Lee,

Is there anything that I need to do for this patch set. I have received rev=
iewed
by tag for all of them so far.=20

Regards,
Okan Sahin
