Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA9B7682579
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 08:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbjAaHVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 02:21:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbjAaHVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 02:21:25 -0500
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B2035246;
        Mon, 30 Jan 2023 23:21:23 -0800 (PST)
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30V3eu8x030380;
        Tue, 31 Jan 2023 02:20:54 -0500
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3ncxbfeuwc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 02:20:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IBIr6wADMags1RBDarPqS1PA6/gUfm8MwmCk62Pja2s1bG0x3zIFhF11jKEnI3BDg+xYHM8Vtr0J+Z/ebBB94I8pJdQp1UoEn/jL4sJElnYN5FHrV4agEX9wZNXHbLG6p0oLOEIsjYtbckPXTe4tOxd1rfB/oMMvCWy/zTYHHx8SexUq1r2Q9dZPxGqOZERUZzxlIS32B+aBtmIEt8miZalAZmahdRy1qfxY9ZDw6C5gLQYcKpxRfI199z7t9yfHexUy9PF7HVIPYPsZrqEUotfkyBndHmeBuO2TftOx1J40J5Iw60modXDbVSeeQb9P4RjoSo61AeAlenfpV7+OKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e2rAct9SknL68Gbb64iGUHBah20LyMe+QicPBN1ozxk=;
 b=KplRVGbTmU/py5aV6EXaEGRFDgoJ4OBRA1WUDyfjVtt24AikM+pg0a7HQ10h4b+Hpqh+zK697fJMKuunVwh+wtLXVXo4xM8Ab1tCgX16NNMOn7sWuTUvLZc3r7d4OtHkIMRJjOoD/MmgJyai+jo6iv7xb/7G0InTQFYfDbqZpR8jw7edWrbZ+2cyRfRqx3IxkBatFaiACqviLLM/KprsnglcaJmzcq4ZyH7VFdef1jUZ2uJb37XrEEyA7VjtyWMuJ9X0jgemfLkHFliCyFN4BQPL4QCD7syR3gdexfXBCHUgonrwEdBisy5ytm0yRek8L1whvT47/NI75qV6mPrF/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e2rAct9SknL68Gbb64iGUHBah20LyMe+QicPBN1ozxk=;
 b=qX4NiCbRzYcr96ZO0qvvcerJbORoAKkWMBRjwI8eGxrTK8huO28gBLJ8xFMDspZLhtl9ccBLTGd2EX9zkuDWZ6/tqrARJ2fcC67e6nrPI9y3GCAzeflV4c/t08fxKHOSoLGJjpphh/Ij+iJpXo+qG34OYtquiEBdi0SiHbUG85o=
Received: from MN2PR03MB5168.namprd03.prod.outlook.com (2603:10b6:208:1ec::19)
 by CH0PR03MB6099.namprd03.prod.outlook.com (2603:10b6:610:ba::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Tue, 31 Jan
 2023 07:20:52 +0000
Received: from MN2PR03MB5168.namprd03.prod.outlook.com
 ([fe80::2f8c:567f:c6cc:dbd9]) by MN2PR03MB5168.namprd03.prod.outlook.com
 ([fe80::2f8c:567f:c6cc:dbd9%6]) with mapi id 15.20.6043.038; Tue, 31 Jan 2023
 07:20:52 +0000
From:   "Sahin, Okan" <Okan.Sahin@analog.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        ChiYuan Huang <cy_huang@richtek.com>,
        "Bolboaca, Ramona" <Ramona.Bolboaca@analog.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: RE: [PATCH v3 3/5] drivers: regulator: Add ADI MAX77541/MAX77540
 Regulator Support
Thread-Topic: [PATCH v3 3/5] drivers: regulator: Add ADI MAX77541/MAX77540
 Regulator Support
Thread-Index: AQHZKwfLM9q3yL8ciUSLt6aTy9zYOq6j1SEAgBRcQ/A=
Date:   Tue, 31 Jan 2023 07:20:52 +0000
Message-ID: <MN2PR03MB5168EC97926AB33D4D806FCCE7D09@MN2PR03MB5168.namprd03.prod.outlook.com>
References: <20230118063822.14521-1-okan.sahin@analog.com>
 <20230118063822.14521-4-okan.sahin@analog.com>
 <Y8erlpofdk24vwCC@smile.fi.intel.com>
In-Reply-To: <Y8erlpofdk24vwCC@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcb2thbi5zYWhp?=
 =?us-ascii?Q?blxhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4?=
 =?us-ascii?Q?NGJhMjllMzViXG1zZ3NcbXNnLWM4OTM4YThiLWExMzctMTFlZC1iZTk2LTU4?=
 =?us-ascii?Q?NmMyNWQzYzNlNFxhbWUtdGVzdFxjODkzOGE4ZC1hMTM3LTExZWQtYmU5Ni01?=
 =?us-ascii?Q?ODZjMjVkM2MzZTRib2R5LnR4dCIgc3o9IjIzNTMiIHQ9IjEzMzE5NjIzMjQ4?=
 =?us-ascii?Q?OTQ0ODAzOSIgaD0iK3NhMFA5MGgwdUlYcmR4dS9oM3pxZktZZlFzPSIgaWQ9?=
 =?us-ascii?Q?IiIgYmw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFBRW9D?=
 =?us-ascii?Q?QUFCbk12U0tSRFhaQVJ3OTJGU2pteFFpSEQzWVZLT2JGQ0lEQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUhBQUFBRGFBUUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUVBQVFBQkFBQUFSczFnRlFBQUFBQUFBQUFBQUFBQUFKNEFBQUJoQUdR?=
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
x-ms-traffictypediagnostic: MN2PR03MB5168:EE_|CH0PR03MB6099:EE_
x-ms-office365-filtering-correlation-id: 93b2db00-749c-43b9-44a1-08db035baf79
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +oYWEKV2WGm8GYa0x5Qs1uUpP53LyYSIT7xl7WdeGRcIYSM8s47t0uQscIhQ90+5+2oL3u/+w5rg13S/XE0rthjFSkJoRA9K360EIDrpRTyrx8kLaZd3fM0jvqd4PiMfxabKg9/QJW2i5Y4gQWpbvsl1EGqvo2GScRXaeabgOKutjzaQ6wXvyfaUwG9DiH2vJycrDDQWPYqiIoqiYNMHbTmXIaqxeCR0qwvPdkaGXFgqyUaKpP+QsGO+lilxQdZRNmgE38Gr3elFu6+1GqVmOLDza/NsuQs1n433LeCn1oOOR0GAftG2/LNl6PM/CUor4JZQM9bNx3HdC25AsaAmRWmZqnii7ZISoAKWakGR2PyKxoNIccjukKS/lUh5NJkKTdQa/S3UyiGfuf5iPE3v6TLkw/jRvdXHjFJuLe6lv3LnyIpOoeFJRcvGv6aPFViuZ/QUh+jib5DCzZkmZtHRU54faYrvzHELCnQhZa8ElTrboAUn9JhU9M9yoHeXEguFeU5ZMLvEuLgKj6RZgmrLztyAOZCnJi0r4mQQDnzWOPBnuM5I+zJHqJZQgaSs2Grrfs8++TCpjAH1/YBwDwK0L1i7aSs9KDqSJn3hACRT/6s4m8N+waBZGTd3duE8AGRSP09ltiXqBkVkdD6cNJp41VOyf+5ZBoaShFk/SLIKeWEO0rHRB2AKr++2ri0QahXTLwm8yKWF3S9qr1t7AeqK8w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB5168.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(366004)(396003)(39860400002)(376002)(451199018)(8936002)(41300700001)(122000001)(7416002)(66556008)(52536014)(66446008)(5660300002)(55016003)(86362001)(38100700002)(66476007)(38070700005)(76116006)(4326008)(64756008)(6916009)(71200400001)(7696005)(316002)(478600001)(8676002)(54906003)(66946007)(186003)(6506007)(26005)(9686003)(33656002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TLgZ48mT/WQ1AvcmaDm6LCP9eLuupNwwCBumXOfhnPOszZami0HqC6JcEmsm?=
 =?us-ascii?Q?tKLmSxsEsxzJVYVa6bIGxkn3DnlvzZRAjGncQFzGvh1MZwqYK72SSQLtCC5H?=
 =?us-ascii?Q?TTyl+Cim9CN/Gdsk+ovdIiHPGUGvBy5AAVtTAshOxxomAYo8IxUVRec3s/nj?=
 =?us-ascii?Q?LsNCXlJAG3L0xs7iGnfG/MLGmfNdjAB7EyfZzuOW6REHAMFoXrD7EIqIfG/y?=
 =?us-ascii?Q?V88iBxsJfEE3OyYe3/alXsFWt5+fG9sN5ERWd99zdqtau/Z2z8SffhE7Zcai?=
 =?us-ascii?Q?pdYy6+I6pkQ+nI2K/6L9KhK7S8tJwa8sYPM1IZRhROqI8Q8lSzpuOsZRPl/n?=
 =?us-ascii?Q?M3P8Lp2Ku9nhc+qaDvXpIY9ERUT+MppGInGA9S0OToRw0tC4DBMRTf1SXA6l?=
 =?us-ascii?Q?jAaQT65T+XSUy7uG6Yl3OKXP2147g7h7QlpYRDg4zZCsqvg2ujcSXeJQBAiB?=
 =?us-ascii?Q?eiCyEGFJzvss5erZ5OGlrOkFn74DkCRsIi50GiOL7lIMYutAzqYwQ28OjpkI?=
 =?us-ascii?Q?RWnmS26gWt2Qnxt0uc2FsCaEItntiHy8RDScgQE+BA318hy3S22dOgcYvQti?=
 =?us-ascii?Q?j/RZGDi1amH3pyw5UHjiCBNQGo7Ur4mq1S8zgNe9yDma/kOZ47igHFpR3c3a?=
 =?us-ascii?Q?5N2nfz3U470C3S9NiMYZVlBmU9TAkiApYg94e/XS6dcKhlLsOnETdSg1Uqle?=
 =?us-ascii?Q?JTdac1pEkn+TNp9N32fOWyZ6MYMFZH22+AfBnGltO+CuikYwu7wisagw/Jy9?=
 =?us-ascii?Q?qv+aTxyZTDEps78xPwSLCccMp4JZ4ADu0UtrBVmz3LHFu0W8gDX3XhAeQTlV?=
 =?us-ascii?Q?4NTeC09M3c8C/fNsUv8T6AYWNckC/UXFLn0xLWlsFQr2A78WmCKNZbWJHYuq?=
 =?us-ascii?Q?hbdTZawY1wdTr9sLQKNhVLnzud88wnvHDtFbnUKWCwG5O2CnzCb+0+VjHyay?=
 =?us-ascii?Q?/CGzo+xOVVdkKTU3JWxskJ53cZOpykqx5rguIvrstIBFuchngxPzjBE1WAV1?=
 =?us-ascii?Q?n09KIbZrnlVetyKVroE+YmwJoDyL9k4/hYqkr4W0dr3wQQRByAxMgqScKn02?=
 =?us-ascii?Q?AMy6VXl/6FPEnHNJzZ/Oo9P//DGlgc2jWy7VzYnCFOjTBLv0EQqNyqsXkYo9?=
 =?us-ascii?Q?h8AFzQY2uFBLyD5ChAwDTqsij+9ghbO1Ie1EoWaZjtmEioz+a/AC7+AU0qLi?=
 =?us-ascii?Q?f73Fi94ySA44QAnAUY0I7ehau4BTeNJlWssNNpO8LpRTfAJlzoQ1qr9iQ++H?=
 =?us-ascii?Q?OHIVwEZYaNC/bHPriF/T578ZRSwL/fqcP/NZnFxDUPQgxGoOa8wcyLgBy15E?=
 =?us-ascii?Q?tPfH2RISZASFEQwQcHZIZeb8FFDI2LNjghclQU4kN5qmFrz/dIoXW+V+6JCL?=
 =?us-ascii?Q?xxZx4zHi2jgDwK7yTL8rbKk8QJxmcixMrtJLMFiru98L0/rInwV4YdihGNhS?=
 =?us-ascii?Q?Xw5H35bCIY+eu9YOdl2Zo782uOWSrhzXWHTpqBrSMysbyrOXRpg/GJbxeB0k?=
 =?us-ascii?Q?WzLEeJOumuUhZ6y8MZz6RA+Cs5hExkxovQqS4gvysFBAhDHEtQsiEdaGNi8U?=
 =?us-ascii?Q?NxxPmreCgj0q7qaQSQQy4CU72u2OdVAE/gARWTU/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB5168.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93b2db00-749c-43b9-44a1-08db035baf79
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2023 07:20:52.3768
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zpGEyLBv/bAUrGqcWNyfsGm+hru1jYWaqCIMtVmGjvZrNSgPc/Daawsq8JO87VRcpXIOkmjx4Fcgm5SnYquY9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR03MB6099
X-Proofpoint-ORIG-GUID: BMENNIZXl0vJ5DfbMC2BuCqAxv7o5pNT
X-Proofpoint-GUID: BMENNIZXl0vJ5DfbMC2BuCqAxv7o5pNT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_02,2023-01-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 adultscore=0 clxscore=1011
 spamscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301310065
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

Thank you for your feedback and efforts. I have a question below.

On Wed, 18 Jan 2022 11:20 AM
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

>On Wed, Jan 18, 2023 at 09:38:10AM +0300, Okan Sahin wrote:
>> Regulator driver for both MAX77541 and MAX77540.
>> The MAX77541 is a high-efficiency step-down converter with two 3A
>> switching phases for single-cell Li+ battery and 5VDC systems.
>>
>> The MAX77540 is a high-efficiency step-down converter with two 3A
>> switching phases.
>
>...
>
>> + * Copyright (c) 2022 Analog Devices, Inc.
>
>Happy New Year!
>
>...
>
>> +static int max77541_regulator_probe(struct platform_device *pdev) {
>> +	struct max77541 *max77541 =3D dev_get_drvdata(pdev->dev.parent);
>> +	struct regulator_config config =3D {};
>> +	const struct regulator_desc *desc;
>> +	struct device *dev =3D &pdev->dev;
>
>You may rearrange this a bit
>
>	struct max77541 *max77541 =3D dev_get_drvdata(dev->parent);
>
>> +	struct regulator_dev *rdev;
>> +	int i;
>
>> +	config.dev =3D pdev->dev.parent;
>
>dev->parent
>
>> +
>> +	if (max77541->id =3D=3D MAX77540)
>> +		desc =3D max77540_regulators_desc;
>> +	else if (max77541->id =3D=3D MAX77541)
>> +		desc =3D max77541_regulators_desc;
>> +	else
>> +		return -EINVAL;
>> +
>> +	for (i =3D 0; i < MAX77541_MAX_REGULATORS; i++) {
>
>> +		rdev =3D devm_regulator_register(dev,
>> +					       &desc[i], &config);
>
>This is perfectly one line.
Thank you, I will arrange it.
>
>> +		if (IS_ERR(rdev))
>> +			return dev_err_probe(dev, PTR_ERR(rdev),
>> +					     "Failed to register regulator\n");
>> +	}
>> +
>> +	return 0;
>> +}
>
>...
However, this one is not fit when I set max-line-length argument as 80 in c=
heckpatch script. What do you suggest? This line has 99 characters.
>
>> +static const struct of_device_id max77541_regulator_of_id[] =3D {
>> +	{
>> +		.compatible =3D "adi,max77540-regulator",
>> +		.data =3D (void *)MAX77540,
>> +	},
>> +	{
>> +		.compatible =3D "adi,max77541-regulator",
>> +		.data =3D (void *)MAX77541,
>> +	},
>> +	{ /* sentinel */  }
>
>As pointed out, better to use pointers directly.
>
>> +};
>
>--
>With Best Regards,
>Andy Shevchenko
>

Regards,
Okan Sahin

