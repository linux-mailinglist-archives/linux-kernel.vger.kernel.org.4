Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7B46EF5A0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 15:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241191AbjDZNjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 09:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241140AbjDZNjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 09:39:43 -0400
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB3072A8;
        Wed, 26 Apr 2023 06:39:38 -0700 (PDT)
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33QDTgII016850;
        Wed, 26 Apr 2023 09:39:34 -0400
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2177.outbound.protection.outlook.com [104.47.73.177])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3q4c79853p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Apr 2023 09:39:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RZMKo8n1i/brQU4BlIowP4MV3kW8Cr+zKav+EOfbqknQx6WqTW4fFSwpk1M3sjb1MN+qcK+9XyMMtkAHmltbSo2tiNTqEC3i8pfj8Ex+g/kq2lr7W+Doit38sviB7hbzPcs31Z8xnubEu9IE2vbRt6vabrxmHUI3rXMOsZr+NTBu1X/q1pDTFwFp3OVPJU7cQToWY6MYiw8Yl1/4ZLvLn061Wjklm3R2H5lskmyT6vig8GnvTcjiXS1ytgU/qfaBLDSr4iv6IpJw7aOzbvbaSoxiVcVPQCnQfC4c0QMCFf6hqGZTMIqH18ryycjXSwdXeJjSD0+KnK6s4+7ykACJ0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FlvrLlBWDSVtWIh5vG98WHCXO8VQ91J9Gx8TLV4ruAI=;
 b=ULYxR0PiBVALwItxSrLza6CegnbxrTiLo9d8QOOcNTSuFslhdFAbyIwtlYziUETjIP2rTs6eOLOOUcROM4MFhjcCq26lWlWCKHzQ1gLIVGep0r/hPvazdf+3j608aQ38jk5mgEnHBKxz3Spw5v1GePyg5f9SwnmZL9WJVkyE5Mhi8vlmYTv5epxLO5ZeQCo05anf+g4alK9X4V876a9QKMSI3cM3ck3MxcIvPtGHbhjewrSwGt6IqSI2Ze6oJsRiZAGkMkxWpNZxlqHD8RyKPqnmRXuU2rTuSLPchIRp/dc62zDO3xFWlRy4x51dlyZ0L95nZwO/WpCuyyazJOkUYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FlvrLlBWDSVtWIh5vG98WHCXO8VQ91J9Gx8TLV4ruAI=;
 b=CXTgKEojdamc1YPuidrecIoOg37Re52MZp7e/RebFA+6hQ09dWU0wQ8KCUe1JC6On2zmeCZUzjdpzlikND298fpcjlg6o1aAsMu1fxICRYjI+DMgkeUggVS3u8FbfN6+9ezLo6ND+hsSDj9o1v+eySVLjuWHIaCCuwd8NKS5plY=
Received: from MN2PR03MB5168.namprd03.prod.outlook.com (2603:10b6:208:1ec::19)
 by PH0PR03MB7065.namprd03.prod.outlook.com (2603:10b6:510:29b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.34; Wed, 26 Apr
 2023 13:39:29 +0000
Received: from MN2PR03MB5168.namprd03.prod.outlook.com
 ([fe80::8f99:7745:fa5d:3dea]) by MN2PR03MB5168.namprd03.prod.outlook.com
 ([fe80::8f99:7745:fa5d:3dea%4]) with mapi id 15.20.6340.021; Wed, 26 Apr 2023
 13:39:29 +0000
From:   "Sahin, Okan" <Okan.Sahin@analog.com>
To:     Michael Walle <michael@walle.cc>
CC:     "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 2/2] gpio: ds4520: Add ADI DS4520 Regulator Support
Thread-Topic: [PATCH v1 2/2] gpio: ds4520: Add ADI DS4520 Regulator Support
Thread-Index: AQHZYKxFzu/viFi84UyZMktWpJEoz68UqJ8AgAaZoUCAAX9AgIAACimAgAMiPoCAAFCPgIACysWAgAMsY4CAFH9pMIABEksAgAHWFgCAAAyPgIAAEkIQ
Date:   Wed, 26 Apr 2023 13:39:29 +0000
Message-ID: <MN2PR03MB5168FCB9B9FB4CA7DFE67A41E7659@MN2PR03MB5168.namprd03.prod.outlook.com>
References: <20230327130010.8342-1-okan.sahin@analog.com>
 <20230327130010.8342-3-okan.sahin@analog.com>
 <CACRpkda5G5b+At5s1WFudpQBQ6LDQxhE3fZj7eBhkZ=thvnQhg@mail.gmail.com>
 <MN2PR03MB51682210CADA6E33FB99052CE7939@MN2PR03MB5168.namprd03.prod.outlook.com>
 <CACRpkdZJA0DyzgLxm9HFeHO03rqNUff=avuV=VrGuJkkOg6wNQ@mail.gmail.com>
 <25e1fda4b6df2d10444d7eca3cd0e387@walle.cc>
 <CACRpkdYKEid8-0-7sBECNgSyW3kMRCsv3DeBVUzxo4z6p+Grnw@mail.gmail.com>
 <ZDBivYlwJ6zgaFTg@surfacebook>
 <MN2PR03MB516879DCD6600827AEE2BDC9E7949@MN2PR03MB5168.namprd03.prod.outlook.com>
 <a3ca3e705b5b8668cd511fc15681c75f@walle.cc>
 <MN2PR03MB5168D7940E322DFC0A1A3148E7679@MN2PR03MB5168.namprd03.prod.outlook.com>
 <1ff70a97dfbcaddd69029001ce99bb69@walle.cc>
 <MN2PR03MB5168689A20C8D6C67F119BB7E7659@MN2PR03MB5168.namprd03.prod.outlook.com>
 <d4a6a640c373b6d939e147691efa596c@walle.cc>
In-Reply-To: <d4a6a640c373b6d939e147691efa596c@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcb2thbi5zYWhp?=
 =?us-ascii?Q?blxhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4?=
 =?us-ascii?Q?NGJhMjllMzViXG1zZ3NcbXNnLWMyYzAwNzhiLWU0MzctMTFlZC1iZWNkLTU4?=
 =?us-ascii?Q?NmMyNWQzYzNlNFxhbWUtdGVzdFxjMmMwMDc4ZC1lNDM3LTExZWQtYmVjZC01?=
 =?us-ascii?Q?ODZjMjVkM2MzZTRib2R5LnR4dCIgc3o9IjM1MzIiIHQ9IjEzMzI2OTg5OTY3?=
 =?us-ascii?Q?MDE1NzQ0MyIgaD0iRk9XUUg4N1RVaGdhbnVNb0hjTm0ya3psWnBJPSIgaWQ9?=
 =?us-ascii?Q?IiIgYmw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFBRW9D?=
 =?us-ascii?Q?QUFDRGVCZUZSSGpaQVR4QXZ4NXRIVUd6UEVDL0htMGRRYk1EQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUhBQUFBRGFBUUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUVBQVFBQkFBQUFTakVYeHdBQUFBQUFBQUFBQUFBQUFKNEFBQUJoQUdR?=
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
x-ms-traffictypediagnostic: MN2PR03MB5168:EE_|PH0PR03MB7065:EE_
x-ms-office365-filtering-correlation-id: 2297c6db-ed94-4aba-a1fa-08db465ba8e5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5Y7P97ElXGF+T1D76ZF63vDM22P0KQVubYJbncjbaDX3C09W4tj1x/I09bxXTxAFINMpjYty3t05lRXyGJWtDF1Vc2JSzFHMqLhxN6MjHYg+r8nkhuK49od3Y662jM/Fli9Dmsl8zv3L677/EikIicHANR9zMHOq2dwyd+2vvWyvRWGZnaYMOwCVAWxpM6kfnXyEaJsYjX39LOF6GQ2XMu3Lbo4AxNi3veAC8GQWPQs8+RSUXznNSks860nJqTL/ucbOpsosElh05V7xiTKUOUNwU8CdpxN2t8AXQCY3PYWmfR7xazp9IPa0IsD5XvSu9FIkVWWcklHhCR/Lcy4rZsklAnMNfgv2CMKPLyw145JhhimCqhRmxVfe8wVhh8CE6QhxUp1qtRW18V+YElLEw9GMRdTjeG6iKH6TDfthct9/9w4+T3iJXZHGzt0Aox0PE0iBCQcdcH5bq5ccnW3+MiXNqJUIXKiuKhhSFDipEZ7MlC4RFAGESDwtuRtRxjC3kzzYZGVCfWrvRB9CP59BXgrW0RLqDvCPv9O1j1QXH0LdtvlYLiv6oQA1l/qD99HZr0MJKFKsgQX0AsVAqoZToC/eVFXS3agmXwWz83FaQpc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB5168.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(136003)(39860400002)(396003)(346002)(451199021)(54906003)(38070700005)(478600001)(86362001)(33656002)(38100700002)(122000001)(8676002)(8936002)(2906002)(66476007)(4326008)(64756008)(6916009)(55016003)(66446008)(52536014)(66556008)(76116006)(66946007)(316002)(5660300002)(186003)(26005)(41300700001)(9686003)(6506007)(966005)(7696005)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+etRsYifz+GPxCyzfPHp21xNQ7tUTIbm44lXr3drFuIRmagcj3SdPPwF79f1?=
 =?us-ascii?Q?m6xvt2tZhPfuXJqiSnm3FHp5N21ge8Abh3hp/NK+9P20qBCuGV35EmuLn7uM?=
 =?us-ascii?Q?Qhum8ptpkaLZXpHSb4gGuRYubj2Dme8Ym5mSmNHtpSiLQ96BJvNrIqNlzO59?=
 =?us-ascii?Q?576QwEqT3NTsKoAbuin9xKU2FxffS+XmWwJMPolyKeeGSCb2sD58hnswfl3q?=
 =?us-ascii?Q?cF/A7Bh52uqB2z6x7mpNNvPySyEJc15nnWiwoJb7FJxKRk2wa7ZJQHTaB1iZ?=
 =?us-ascii?Q?6rFZCNhabFRFVQaObUy8SlZ/BjRg2qeeNqJArU/8alDEWeXv9wmGQzX+DKb7?=
 =?us-ascii?Q?1jMFBISR64a9sVrgnmMAodEYNz/PXEfIE4KIhq7kW47pJheTpjj3bH6SImjY?=
 =?us-ascii?Q?0+zAWYgrHKDb99VHMoHjq01q8+0koYhVawCcwfFuELEL5xKiTZJ+32tVPP+w?=
 =?us-ascii?Q?zJfrJI//xFFZkYsfeXwMYf2ZW9tQMztr9DTmo5uGpbvJ198mbkxCIvHcmNV3?=
 =?us-ascii?Q?ql/nBJtXHJSPipekd4+z4cMneKBhIUeOrddO+lzD4V/fmTh1S6N6f1/FwCGB?=
 =?us-ascii?Q?4vjiDzOazgIgv/Fpb5dRtUZccu3N9iQnh+TGIaKltlk2k0S8XSI28RMtLUUL?=
 =?us-ascii?Q?rrVEB8yg9L0wpjttBV4nwGeFy0rFI91KKjxmHgJzLjG2QddYBthMtZKBTfH+?=
 =?us-ascii?Q?/jhcbEnEcmyOs/jwTH2cR1ZL/76peRxS3Zhm7iFnc0j+1gQpXjXLg8NWNG/e?=
 =?us-ascii?Q?m5RBapvzchvjIeVMW5e4dzU2U8ET6o/a681Y9jOs5P+0cf6pXQ10AbD2VdPB?=
 =?us-ascii?Q?Kl6GIFdm2XsUW3kAeMR+UwK3vk7yhL9sAuIVxzfXA9EvpBOG5qozCaktp52I?=
 =?us-ascii?Q?hRn0foTijNfqy8SHz5Jw2OPKNqfDqC9O6b2FTEzpHv11veduXD5p/Dp9bgES?=
 =?us-ascii?Q?h2D++td1C9MeB7iNWC3s64VmFrNbBQXPnsn7qbjs/PU+B71SX9UPmqJestKE?=
 =?us-ascii?Q?kT86WuT03K5JsQgxyPwq+IvrERz/6FJjwXOsQTGowbAvPNKHBFoY9naKpVWf?=
 =?us-ascii?Q?AenAKX7TDAaDow7XJAfuexkTLXjy++E3mxiNqb9B7oTBbLnbapufswMz0fAw?=
 =?us-ascii?Q?B46dM6wj6F7ez0RqdHNiMavOtJK6ntT/Q9RkRWxr7gIbTv4A8o05E4aAPdri?=
 =?us-ascii?Q?7JFR6nycXSzcMk0ZI8c6tGmk3u/XgCACwTSWG+wejGjpuU/2Q4lARNIGHbtb?=
 =?us-ascii?Q?MjC7BG104LDDagFR69G45cQFQTJ+1MUc8kNiNIJ4U2buwtgdldTrmJlxpifo?=
 =?us-ascii?Q?xMpkMRnCroii8e8nNnVEF/Ygx/D8fpQR78gUHFobYufdmQ67U+rPt0d06VnQ?=
 =?us-ascii?Q?Z6lnvUFN5dUkxfcQ/wFvd4yVk8Am+jufSag31QCWsTcHI8g0+ovA0A2OS2Cs?=
 =?us-ascii?Q?1WikDtEKpHV1QldwYmtVqEtGAnwBUmGptcWIajhZPKfeivTxoblzdGFeKO3W?=
 =?us-ascii?Q?K7L1DBsx+/l7rLmZ/lkNYHp43nGipp2+LxQ6QRKN/yK2F8wJZSF599zlyZae?=
 =?us-ascii?Q?qnDTTp5g0mZVTia3z6ekSHZlU4VRS1MmpS0Uh7Q5?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB5168.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2297c6db-ed94-4aba-a1fa-08db465ba8e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2023 13:39:29.2262
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pjBpTLkwmpyQOdXYli2RT64q/+Czrx0o6qat6/xmej5E4uy2pogv5DwELAtKQMCzllz3PIhqtam9MdLD40stlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB7065
X-Proofpoint-ORIG-GUID: bMVATiU9YSPdNEOk9FhJsrqxpa4xmQqO
X-Proofpoint-GUID: bMVATiU9YSPdNEOk9FhJsrqxpa4xmQqO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-26_06,2023-04-26_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 priorityscore=1501
 phishscore=0 impostorscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 mlxlogscore=669 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304260122
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> I think I understand what you are trying to say so far. I did not have
>> too much
>> experience related to gpio. I will set pull_up register in .set_config
>> However, I did not understand where its parameters come from.
>> set_config(struct gpio_chip *chip, unsigned int offset,
>> 	      unsigned long config)
>> It might be trivial question, but Where does config come from?
>
>Others have to answer that one as I don't have that much experience
>either.
>
>> At the end, I should rewrite the code using regmap_gpio, right? So if I
>> rewrite
>> code using regmap_gpio, how can I replace set_config(...)?
>
>You'd have to add a .set_config to gpio_regmap_config and then in
>
>gpio_regmap_register():
>   gpio->set_config =3D config->set_config;
>
>I don't think it makes sense to have a default implementation in
>gpio-regmap,
>the variances between "simple" gpio controllers might be too broad.
>
>-michael

Hi,

One last question, as ds4520 IC has 9 I/O pins so I need to set registers l=
ike=20
below
struct gpio_regmap *gpio;
config.reg_dir_out_base =3D IO_CONTROL0; (get_direction and setting directi=
on)
config.reg_dat_base =3D IO_STATUS0; (for .get)
config.reg_set_base =3D IO_STATUS0; (for .set)

As I have both directions, I must set both reg_dat_base and
reg_set_base.

https://elixir.bootlin.com/linux/latest/source/include/linux/gpio/regmap.h#=
L52

In this case, I am able to use only pull_up register to set output value to=
 high
as default. Is that okay? I am asking again and again to minimize number of=
=20
patch. I want to be sure before sending new patch. Thank you for your contr=
ibution.

Regards,
Okan Sahin


