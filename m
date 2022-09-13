Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F32AD5B7CD1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 23:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbiIMV5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 17:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiIMV5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 17:57:16 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C3272ED8;
        Tue, 13 Sep 2022 14:57:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h9Jn4ai4hst21UGjvVzxjqLBsjf9sye6NBYAvzBZKok2a7gxM/NDJcTmi21TNCtJVlAHh2Q2LUUX/OzGW5AI95oFEQD9UR0BwMmK8naMScu0q8Jqe2QXvs2DuVfkK7zH4+zCePtCrdk2HL3kZJMFqYq+T1Z8tTTEId4g2PUA9zvCZjyUg6SDMxUR5AtqAPuSDl5E1bkeuXFrrwmFEFdUx7lHZ4Fqg73+5RuI9b/rRLlpa8AH7AGZbObn9PRTTgObuBRVgYRVFSeDBZOL4ux7c1Fo38wGtAmIR7cEg75/B7kvI9iCShthxFjdD650jP42b1Q96cK7yg3kCG9FJgYxKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nZ4Vb1xTnkTkt4mgIzyid9ika+sSfwQWAKtpeIDs+cw=;
 b=C5WoHwobzU5o9TfZkNZUXgXJ8OUlizhZw90IgLWo8IYgLKgqDImJK2DUuAjFqGzZdUP2qh7qJHK72/cbzzj41m5SfpD3jaUTUNDYIHGn70+7MAI5owmbluQY8KaVso/zs4ykX9rHZ+BE8QfX3tlpN/StDoCoWVIvMvAT+vmc7+k5W1wl4tYq5k5F+bRrPtin1IMVw2ldQ/BRQvIxMzxz++6Myi8q3XFxDtlsoOjVCPcJiJBKq/NCrEJByn1vsUCF2RfARVi/LKcZNfOWKUJav7P0OvC5zHQ13qeQD22lQO01xXGhCmx18W3to2iRVAyJzz4kxPMHbKWoWZYysoOrhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nZ4Vb1xTnkTkt4mgIzyid9ika+sSfwQWAKtpeIDs+cw=;
 b=bA19wzVycTACkT38b2v9mWMe1ENL87pEMbX0j1kxHjoyk30+vCmbBZYDyqHlzo4Kjn+8eRfrS8E/B+h3MBFlmFt8736TwDbApikgSP9oCFb0Uxo//sWXXXDhVLG2X4xIFWpjkp19VvzBLzqwn0K0SgX99QewxgjQooZXVTDiNok=
Received: from BL0PR12MB2401.namprd12.prod.outlook.com (2603:10b6:207:4d::19)
 by SJ0PR12MB6901.namprd12.prod.outlook.com (2603:10b6:a03:47e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Tue, 13 Sep
 2022 21:57:04 +0000
Received: from BL0PR12MB2401.namprd12.prod.outlook.com
 ([fe80::169:8fcb:d816:54d2]) by BL0PR12MB2401.namprd12.prod.outlook.com
 ([fe80::169:8fcb:d816:54d2%4]) with mapi id 15.20.5612.022; Tue, 13 Sep 2022
 21:57:04 +0000
From:   "Larson, Bradley" <Bradley.Larson@amd.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Larson, Bradley" <Bradley.Larson@amd.com>,
        Rob Herring <robh@kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "alcooperx@gmail.com" <alcooperx@gmail.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "brijeshkumar.singh@amd.com" <brijeshkumar.singh@amd.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "gsomlo@gmail.com" <gsomlo@gmail.com>,
        "gerg@linux-m68k.org" <gerg@linux-m68k.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "piotrs@cadence.com" <piotrs@cadence.com>,
        "p.yadav@ti.com" <p.yadav@ti.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "samuel@sholland.org" <samuel@sholland.org>,
        "fancer.lancer@gmail.com" <fancer.lancer@gmail.com>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "will@kernel.org" <will@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v6 06/17] dt-bindings: mfd: amd,pensando-elbasr: Add AMD
 Pensando Elba System Resource chip
Thread-Topic: [PATCH v6 06/17] dt-bindings: mfd: amd,pensando-elbasr: Add AMD
 Pensando Elba System Resource chip
Thread-Index: AQHYtM86gXzQRkjAqk6/46/G7K6NoK26/IIAgA61EQCAAItaAIAA3uMAgApmjwCACIuFgA==
Date:   Tue, 13 Sep 2022 21:57:04 +0000
Message-ID: <9a98d026-7f70-a69b-64de-c77419888e42@amd.com>
References: <20220820195750.70861-1-brad@pensando.io>
 <20220820195750.70861-7-brad@pensando.io>
 <20220822142544.GA3770388-robh@kernel.org>
 <554f33b4-d235-5516-e8ff-5bf80d63a9b9@amd.com>
 <936c5623-07b9-c49d-e113-fc056a4eb9bc@linaro.org>
 <b064ed4c-d5a7-614f-008e-61ff2ac27f88@amd.com>
 <0852ffa5-9996-0f42-c5a8-d1fe9d39887e@linaro.org>
In-Reply-To: <0852ffa5-9996-0f42-c5a8-d1fe9d39887e@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR12MB2401:EE_|SJ0PR12MB6901:EE_
x-ms-office365-filtering-correlation-id: cf463815-984c-48b4-bfc0-08da95d2e51d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KI2NjUkoSAWqpbpy+KhqTxN6NK0nUkvR53ecoWLXobikvcBYNNt8HF+63/Eb0KbisPw2TdQNHHL6prpz7unjfj0x2vTF0Ernk3P0W/LzbiOIWlbnISFd/RpvMw4NHc9JVBlNRc6SuUDf5Km+/Jr5OtLdwKlota0SLoF1IRRgWGWYUXKV77k3fnfpK7Ogb7Op+GxsSrEef2MNyWdEQtoODtbVdJH0TIio6EChp1bra2pi3dhgFinWHNonfjmhQ1dL95iRz3KtXclGS0C+4KwqC6fv5cvVSbmHmcsSITyI+PxZZZORlbHbgLiKuQcZ90WBr/MFXDmFNJq5oJ3ujSZbivIyeFJlEtbRwLWip5A9SjMggleOj4py78FiSpvCscutrf7vuN2qwt1sm6Na2oIU1SLbdZqU8GBuavoWg/buYlbMbuIbM4lWDdcgDzfYQqA8MrkwFn1IgchUdIcNzhHg+0+MB0/0ew8WQkYjLBEfNp9DplDTrtoW6DpqcN+YZkj56U7aGrTGQvhRmklvups1exrPvh/naNdgOsJ6RiAfuqOaKik7hMz/x7wpw3lfa0CDFxjr/jWLn204HCu5/M1wItatqTybK9Sz+YtpLbJsaQihApe2LGI68GUgBLBxSnuEW7LEO+CGLNjU4xBdXvjY1X4uXweMcwBxexBD5bvcCLF4OZ8nn2sIyvEtwDr3iUD6dqSgypbF+oDDQOuaBm/x7EXq3vaqr3A+NnFZIhBxTF8OKw+8XRXYtDB42kMSDeKyOQIvcuJOaPJhTsMsbx7OmVq4iA3UiwenhkZALL2wnPU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2401.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(346002)(376002)(366004)(136003)(451199015)(36756003)(6512007)(53546011)(31686004)(122000001)(8936002)(38070700005)(38100700002)(86362001)(31696002)(186003)(2906002)(41300700001)(83380400001)(2616005)(6506007)(110136005)(4326008)(6486002)(91956017)(5660300002)(66446008)(478600001)(71200400001)(7416002)(54906003)(316002)(8676002)(76116006)(66476007)(64756008)(66946007)(66556008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VmpOYnJYT3pBczZ5M0x0V2g0ck5KYmh3SlZRTFE5SEV6RXRwUlFwMXRmSmQ2?=
 =?utf-8?B?MFQ2UFJFb3NLU3JuRW5zMU1EdDJpcEFla3pldmlJbXVLd1BMT0FraG5CVVpS?=
 =?utf-8?B?a3VvSlNqZ2t3VlV5ZDNOZjlaSHcxS1VFMGhWVVlHMDZrYzVvMnZKQ1hXZTlt?=
 =?utf-8?B?S085SWlrUEk4YlNNaVFvZ0Q5TXJMU3F6SnlIc1IvWDUxK0ZlZnQ3eHF3WXRK?=
 =?utf-8?B?Zy9kUlNyeGppMmNla2ZlV0lXd3ZSVThTWE91ajRtWUVacDhTU3U4V3h6eGZj?=
 =?utf-8?B?eEJJRkxzaXVWRjJkVVlPRUkrZnJHY3p0c3pWS0szdERBVzZCNHhzU1ovc29Y?=
 =?utf-8?B?Ry9NampOY3dPNHpvbmQ4ZkxRZ3V0bjNZSnhTclRvaXhldFlBamhUOXEyRmdN?=
 =?utf-8?B?ZE9Kc3dWT1ZicEc2eGNTUUJ3UDhORkpuNzJHbkhUMG9NSkhVSmdRNjJpTWRt?=
 =?utf-8?B?UVBUeERtTFl2WmNhdzhrMUt4cllTc3k0MjdlZUtDNjBWbWlBRHI3R241NHV4?=
 =?utf-8?B?S2NabmRyeUY5TzFybGhCQWFqWStkSUJ4OHM3M255NmtaRk9lZzYvd0pNcXdw?=
 =?utf-8?B?emowQ3kxSFR0dFRRbHB6cFhiWXRFUFBKNUZWZWRVNUFyMVBEVTRRTU1vdnAy?=
 =?utf-8?B?OTdtN3hwVXNVWWhRQkNvVDZXZHVCVDcvUjBTUzVXUzN1eVJIcjQyQTNEd09L?=
 =?utf-8?B?SU9VMjF1dEVNREJiZkNsMHJSQ2d0UWdqdEdEbnBXWFhuZXBUN0JVb3I0WjNR?=
 =?utf-8?B?OTJuakhVUW8xMllIMzZueitPT1FtTGZOczZBZlhFWWRQazg5MUtkc21WV1Jw?=
 =?utf-8?B?MFh5QmtuSXBwWVBMRTVoOVRMYjNNdEJ1cE9JYXRyTTJRVXpxNlZqM3Y5UmhW?=
 =?utf-8?B?QkNXTlphTXB1djVDUERhY1Fod2xkckhmSTdNR21WVmFaNXNhb1c5QTFOVHhq?=
 =?utf-8?B?ZEdNaXY3YzU2MHI2R2NMTms4K3N6T2thcjNKeG9ZMXk1U2VXY2p6TkR3ODhv?=
 =?utf-8?B?NW5WYVdPNURaT2lhT3lOUkZjYWFvUUMxNWovQjhOR2JpVmpzVVpJVjRYblM0?=
 =?utf-8?B?NTN6Tzh1R2tuWE9Rd0NmOGswVlNrS3FLR1RyUFc2MWVwTExrUnhYenpsaHV3?=
 =?utf-8?B?bXhHMzVYNHhZTW92QnJnMG9MRFZZSmFwNVhIbHNCV004ZnZWeXBaM1BUaDZ1?=
 =?utf-8?B?UzZSaFpVb1VVdVp1S3dLR2J1d29sK3lLOEE4ZXlJM3g3UElXL3ZmWkR0YzJs?=
 =?utf-8?B?Z2lvZFJlamNHSnFZbXhTK09EclU5TzFsdkU0QlV0TGdNSVZ4d3F2ZzlMTUZy?=
 =?utf-8?B?ejZ1ZjM4MzVtbDdRTjZ5VmlhdHA5cVBiMXp6ZVp4QitOUVFwWERqVUpYbGVl?=
 =?utf-8?B?T3VxVUNNV2s0SjJlNjFtZVJ2NzVlSFpuTW5OQ2ZuOXdHYU1INmZaeEp2Q3ZX?=
 =?utf-8?B?U3VaalNEdlFlY3BweTdLdlBvVmlEZk1OVldQd2NhckJjblBvNUpnL1lZU2U4?=
 =?utf-8?B?NWE2SjZNZGlJYTdSUGFlSi9BYk1wVXRCeC9jQ3V6b2ZuUmlZeXZQaUhUcEJ3?=
 =?utf-8?B?SXhCM2JzeTRpWmJReWxKWWM1WmtDVlhEd2ZZQzlpbFNPV1VCMVladW5qOERr?=
 =?utf-8?B?QVRVS1Q4Z0xiTGNlQWJJOVV6RERsM01TOFZJUmhuQ3AvaXdnSFBHRFZxRTBH?=
 =?utf-8?B?N04ydWN4bkttY1R2WUkyRDFPNzg3RHEreGV2Q0piT2E4Y2RIODdXMmJSRUNx?=
 =?utf-8?B?RFVlam85RHprbWJXRmtkRjZKY3pVMUo2SXRET2VVOGdNeVM4Rk90QTQ5K2o2?=
 =?utf-8?B?MkR1TlprcmlLakZQbFMvYVlNbFJqbDZDc3ZLNnVmRFFSK1l3dXFHdk44dDM0?=
 =?utf-8?B?MW1iZkl6R1JJSlhyRHJ6bVdtUUN1VjFqME56bDRIc08rQUVGcU9JYnhVbVVZ?=
 =?utf-8?B?bk9QZlZpRzJFR3dtZTZHd0pORlFnTHlWY2lmRFR1MFhRSzhweWlGS01TS1ZR?=
 =?utf-8?B?dUEzSlZCVzMwMXUySnZJNitpVWtrSXVFQ2hsdjB2a1hlNkNmRjBMYlY3Mm5B?=
 =?utf-8?B?TkprRk9hd0lSb3pObHNJaWlEa3BkWC9vZjA1eVVQb2l5d2FjV2xoRE1uaGdC?=
 =?utf-8?B?U3hZczFqeFpheXBZK1QvUktXdkNUazdGUjQ3eG50ZE94ZHZwTlY4OGNNckFz?=
 =?utf-8?Q?lLMKvomyLGblWpzDvwFRq+w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8E92119EAB7CC34082F986999405E574@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2401.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf463815-984c-48b4-bfc0-08da95d2e51d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2022 21:57:04.5636
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5o9TOY9dSAFJPf2IRAPeq42TMh3smyeeDFhTC+YN+veD+JsNYvzMZrCcyjlON31C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6901
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOS84LzIyIDQ6MjcgQU0sIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+IE9uIDAxLzA5
LzIwMjIgMjI6MzcsIExhcnNvbiwgQnJhZGxleSB3cm90ZToNCj4+IE9uIDkvMS8yMiAxMjoyMCBB
TSwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4+PiBPbiAwMS8wOS8yMDIyIDAyOjAxLCBM
YXJzb24sIEJyYWRsZXkgd3JvdGU6DQo+Pj4+Pj4gKyAgaXMgaW1wbGVtZW50ZWQgYnkgYSBzdWIt
ZGV2aWNlIHJlc2V0LWNvbnRyb2xsZXIgd2hpY2ggYWNjZXNzZXMNCj4+Pj4+PiArICBhIENTMCBj
b250cm9sIHJlZ2lzdGVyLg0KPj4+Pj4+ICsNCj4+Pj4+PiArbWFpbnRhaW5lcnM6DQo+Pj4+Pj4g
KyAgLSBCcmFkIExhcnNvbiA8YmxhcnNvbkBhbWQuY29tPg0KPj4+Pj4+ICsNCj4+Pj4+PiArcHJv
cGVydGllczoNCj4+Pj4+PiArICBjb21wYXRpYmxlOg0KPj4+Pj4+ICsgICAgaXRlbXM6DQo+Pj4+
Pj4gKyAgICAgIC0gZW51bToNCj4+Pj4+PiArICAgICAgICAgIC0gYW1kLHBlbnNhbmRvLWVsYmFz
cg0KPj4+Pj4+ICsNCj4+Pj4+PiArICBzcGktbWF4LWZyZXF1ZW5jeToNCj4+Pj4+PiArICAgIGRl
c2NyaXB0aW9uOiBNYXhpbXVtIFNQSSBmcmVxdWVuY3kgb2YgdGhlIGRldmljZSBpbiBIei4NCj4+
Pj4+IE5vIG5lZWQgZm9yIGdlbmVyaWMgZGVzY3JpcHRpb25zIG9mIGNvbW1vbiBwcm9wZXJ0aWVz
Lg0KPj4+PiBDaGFuZ2VkIHRvICJzcGktbWF4LWZyZXF1ZW5jeTogdHJ1ZSIgYW5kIG1vdmVkIHRv
IGVuZCBvZiBwcm9wZXJ0aWVzLg0KPj4+IFRoZW4geW91IHNob3VsZCByYXRoZXIgcmVmZXJlbmNl
IHNwaS1wZXJpcGhlcmFsLXByb3BzIGp1c3QgbGlrZSBvdGhlcg0KPj4+IFNQSSBkZXZpY2VzLg0K
Pj4NCj4+IFdpbGwgbG9vayBhdCB0aGlzIGRlcGVuZGVudCBvbiB0aGUgcmVzdWx0IG9mIGJlbG93
DQo+Pg0KPj4NCj4+Pj4+PiArDQo+Pj4+Pj4gKyAgcmVnOg0KPj4+Pj4+ICsgICAgbWF4SXRlbXM6
IDENCj4+Pj4+PiArDQo+Pj4+Pj4gKyAgJyNhZGRyZXNzLWNlbGxzJzoNCj4+Pj4+PiArICAgIGNv
bnN0OiAxDQo+Pj4+Pj4gKw0KPj4+Pj4+ICsgICcjc2l6ZS1jZWxscyc6DQo+Pj4+Pj4gKyAgICBj
b25zdDogMA0KPj4+Pj4+ICsNCj4+Pj4+PiArICBpbnRlcnJ1cHRzOg0KPj4+Pj4+ICsgICAgbWF4
SXRlbXM6IDENCj4+Pj4+PiArDQo+Pj4+Pj4gK3JlcXVpcmVkOg0KPj4+Pj4+ICsgIC0gY29tcGF0
aWJsZQ0KPj4+Pj4+ICsgIC0gcmVnDQo+Pj4+Pj4gKyAgLSBzcGktbWF4LWZyZXF1ZW5jeQ0KPj4+
Pj4+ICsNCj4+Pj4+PiArcGF0dGVyblByb3BlcnRpZXM6DQo+Pj4+Pj4gKyAgJ15yZXNldC1jb250
cm9sbGVyQFthLWYwLTldKyQnOg0KPj4+Pj4+ICsgICAgJHJlZjogL3NjaGVtYXMvcmVzZXQvYW1k
LHBlbnNhbmRvLWVsYmFzci1yZXNldC55YW1sDQo+Pj4+Pj4gKw0KPj4+Pj4+ICthZGRpdGlvbmFs
UHJvcGVydGllczogZmFsc2UNCj4+Pj4+PiArDQo+Pj4+Pj4gK2V4YW1wbGVzOg0KPj4+Pj4+ICsg
IC0gfA0KPj4+Pj4+ICsgICAgI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2ludGVycnVwdC1jb250cm9s
bGVyL2FybS1naWMuaD4NCj4+Pj4+PiArDQo+Pj4+Pj4gKyAgICBzcGkgew0KPj4+Pj4+ICsgICAg
ICAgICNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPj4+Pj4+ICsgICAgICAgICNzaXplLWNlbGxzID0g
PDA+Ow0KPj4+Pj4+ICsgICAgICAgIG51bS1jcyA9IDw0PjsNCj4+Pj4+PiArDQo+Pj4+Pj4gKyAg
ICAgICAgc3lzYzogc3lzdGVtLWNvbnRyb2xsZXJAMCB7DQo+Pj4+Pj4gKyAgICAgICAgICAgIGNv
bXBhdGlibGUgPSAiYW1kLHBlbnNhbmRvLWVsYmFzciI7DQo+Pj4+Pj4gKyAgICAgICAgICAgIHJl
ZyA9IDwwPjsNCj4+Pj4+PiArICAgICAgICAgICAgI2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+Pj4+
Pj4gKyAgICAgICAgICAgICNzaXplLWNlbGxzID0gPDA+Ow0KPj4+Pj4+ICsgICAgICAgICAgICBz
cGktbWF4LWZyZXF1ZW5jeSA9IDwxMjAwMDAwMD47DQo+Pj4+Pj4gKw0KPj4+Pj4+ICsgICAgICAg
ICAgICByc3RjOiByZXNldC1jb250cm9sbGVyQDAgew0KPj4+Pj4+ICsgICAgICAgICAgICAgICAg
Y29tcGF0aWJsZSA9ICJhbWQscGVuc2FuZG8tZWxiYXNyLXJlc2V0IjsNCj4+Pj4+PiArICAgICAg
ICAgICAgICAgIHJlZyA9IDwwPjsNCj4+Pj4+IFdoYXQgZG9lcyAwIHJlcHJlc2VudCBoZXJlPyBB
IHJlZ2lzdGVyIGFkZHJlc3Mgd2l0aGluICdlbGJhc3InIGRldmljZT8NCj4+Pj4gUmVtb3ZlZCwg
SSByZWNhbGwgYSBjaGVjayB0aHJldyBhIHdhcm5pbmcgb3IgZXJyb3Igd2l0aG91dCByZWcuDQo+
Pj4+DQo+Pj4+PiBXaHkgZG8geW91IG5lZWQgYSBjaGlsZCBub2RlIGZvciB0aGlzPyBBcmUgdGhl
cmUgb3RoZXIgc3ViLWRldmljZXMgYW5kDQo+Pj4+PiB5b3VyIGJpbmRpbmcgaXMgaW5jb21wbGV0
ZT8gSnVzdCBwdXQgJyNyZXNldC1jZWxscycgaW4gdGhlIHBhcmVudC4NCj4+Pj4gV2l0aG91dCBh
IHJlc2V0LWNvbnRyb2xsZXIgbm9kZSBhbmQgYm9vdGluZyB0aGUgZnVuY3Rpb24NCj4+Pj4gX19v
Zl9yZXNldF9jb250cm9sX2dldCguLi4pIGZhaWxzIHRvIGZpbmQgYSBtYXRjaCBpbiB0aGUgbGlz
dCBoZXJlDQo+Pj4gVGhhdCdzIG5vdCBhY3R1YWxseSB0aGUgYW5zd2VyIHRvIHRoZSBxdWVzdGlv
bi4gVGhlcmUgd2FzIG5vIGNvbmNlcm5zDQo+Pj4gd2hldGhlciB5b3UgbmVlZCBvciBub3QgcmVz
ZXQgY29udHJvbGxlci4gVGhlIHF1ZXN0aW9uIHdhcyB3aHkgZG8geW91DQo+Pj4gbmVlZCBhIGNo
aWxkIGRldmljZSBpbnN0ZWFkIG9mIGVsYmFzciBiZWluZyB0aGUgcmVzZXQgY29udHJvbGxlci4N
Cj4+Pg0KPj4+IFlvdXIgYW5zd2VyIGRvZXMgbm90IGNvdmVyIHRoaXMgYXQgYWxsLCBzbyBhZ2Fp
biAtIHdoeSBkbyB5b3UgbmVlZCBhDQo+Pj4gY2hpbGQgZm9yIHRoaXM/DQo+Pj4NCj4+IElmIHRo
ZSBwYXJlbnQgYmVjb21lcyBhIHJlc2V0LWNvbnRyb2xsZXIgY29tcGF0aWJsZSB3aXRoDQo+PiAi
YW1kLHBlbnNhbmRvLWVsYmFzci1yZXNldCIgdGhlbiB0aGUgL2RldiBub2RlIHdpbGwgbm90IGJl
IGNyZWF0ZWQNCj4gV2h5IC9kZXYgbm9kZSB3aWxsIG5vdCBiZSBjcmVhdGVkPyBIb3cgYmluZGlu
Z3MgYWZmZWN0IGhhdmluZyBvciBub3QNCj4gaGF2aW5nIHNvbWV0aGluZyBpbiAvZGV2ID8NCj4N
Cj4+IGFzIHRoZXJlIGlzIG5vIG1hdGNoIHRvICJhbWQscGVuc2FuZG8tZWxiYXNyIiBmb3IgY3Mw
LiAgRm9yIGNzMCBpbnRlcm5hbA0KPj4gdG8gbGludXggdGhlIHJlc2V0LWNvbnRyb2xsZXIgbWFu
YWdlcyBvbmUgcmVnaXN0ZXIgYml0IHRvIGhhcmR3YXJlIHJlc2V0DQo+PiB0aGUgbW1jIGRldmlj
ZS4gIEEgdXNlcnNwYWNlIGFwcGxpY2F0aW9uIG9wZW5zIHRoZSBkZXZpY2Ugbm9kZSB0byBtYW5h
Z2UNCj4+IHRyYW5zY2VpdmVyIGxlZHMsIHN5c3RlbSBsZWRzLCByZXBvcnRpbmcgdGVtcHMgdG8g
aG9zdCwgb3RoZXIgcmVzZXQNCj4+IGNvbnRyb2xzLCBldGMuICBMb29raW5nIGF0IGZ1dHVyZSBy
ZXF1aXJlbWVudHMgdGhlcmUgbGlrZWx5IHdpbGwgYmUgb3RoZXINCj4+IGNoaWxkIGRldmljZXMu
DQo+IFlvdSBtZWFuICJhbWQscGVuc2FuZG8tZWxiYXNyIiB3aWxsIGluc3RhbnRpYXRlIHNvbWUg
bW9yZSBkZXZpY2VzPyBXaHkNCj4geW91IGNhbm5vdCBhZGQgdGhlIGJpbmRpbmcgZm9yIHRoZW0g
bm93PyBUaGlzIGlzIGFjdHVhbGx5IGltcG9ydGFudA0KPiBiZWNhdXNlIGVhcmxpZXIgd2UgYWdy
ZWVkIHlvdSByZW1vdmUgdW5pdCBhZGRyZXNzIGZyb20gY2hpbGRyZW4uDQo+DQo+PiBHb2luZyBk
b3duIHRoaXMgcGF0aCB3aXRoIG9uZSBjb21wYXRpYmxlIHNob3VsZCByZXNldC1lbGJhc3IuYyBq
dXN0IGJlDQo+PiBkZWxldGVkIGFuZCBmb2xkIGl0IGludG8gdGhlIHBhcmVudCBkcml2ZXIgcGVu
c2FuZG8tZWxiYXNyLmM/IFRoZW4gSQ0KPj4gd29uZGVyIGlmIGl0IGV2ZW4gYmVsb25ncyBpbiBk
cml2ZXJzL21mZCBhbmQgc2hvdWxkIGp1c3QgYmUgbW9kaWZpZWQNCj4+IGFuZCBwdXQgaW4gZHJp
dmVycy9zcGkuDQo+IEhvdyBpcyBpdCByZWxhdGVkIHRvIGJpbmRpbmdzPw0KVGhlIGNvbXBhdGli
bGUgImFtZCxwZW5zYW5kby1lbGJhc3IiIGlzIG1hdGNoZWQgaW4gDQpkcml2ZXJzL21mZC9wZW5z
YW5kby1lbGJhc3IuYw0Kd2hpY2ggY3JlYXRlcyAvZGV2L3BlbnNyMC48Y3M+IGZvciBzcGkgY2hp
cC1zZWxlY3RzIGRlZmluZWQgaW4gdGhlIA0KcGFyZW50IG5vZGUgYXM6DQoNCiDCoMKgwqDCoMKg
wqDCoCBudW0tY3MgPSA8ND47DQogwqDCoMKgwqDCoMKgwqAgY3MtZ3Bpb3MgPSA8MD4sIDwwPiwg
PCZwb3J0YSAxIEdQSU9fQUNUSVZFX0xPVz4sDQogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIDwmcG9ydGEgNyBHUElPX0FDVElWRV9MT1c+Ow0KDQpUaGUgY29tcGF0aWJsZSAi
YW1kLHBlbnNhbmRvLWVsYmFzci1yZXNldCIgaXMgaW4gDQpkcml2ZXJzL3Jlc2V0L3Jlc2V0LWVs
YmFzci5jDQp3aGljaCB1c2VzIHJlZ21hcCB0byBjb250cm9sIG9uZSBiaXQgaW4gdGhlIGZ1bmN0
aW9uIGF0IGNzMCB0byBoYXJkd2FyZSANCnJlc2V0IHRoZSBlTU1DLg0KVGhpcyBpcyB0aGUgcmVh
c29uIGZvciB0aGUgcmVzZXQtY29udHJvbGxlciBjaGlsZCBhbmQgdGhlIHR3byBkcml2ZXIgDQpm
aWxlcy7CoCBUaGUNCnByb2JlIGluIGRyaXZlcnMvbWZkL3BlbnNhbmRvLWVsYmFzci5jIGlzIGNh
bGxlZCA0IHRpbWVzLCBvbmNlIHBlciBzcGkgDQpjaGlwLXNlbGVjdA0KYW5kIGZvciBjczAgbWZk
X2FkZF9kZXZpY2VzKCkgaXMgY2FsbGVkIGZvciB0aGUgcmVzZXQgY29udHJvbGxlci4NCg0KSSds
bCBjaGFuZ2UgInJzdGM6IHJlc2V0LWNvbnRyb2xsZXJAMCIgdG8gInJzdGM6IHJlc2V0LWNvbnRy
b2xsZXIiLg0KDQpNYXliZSBJJ3ZlIGdvdHRlbiBvZmYgdHJhY2sgZm9sbG93aW5nIHdoYXQgbG9v
a2VkIGxpa2UgYW4gYXBwcm9wcmlhdGUgbW9kZWwNCnRvIGZvbGxvdyAoImFsdHIsYTEwc3IiKSB0
aGF0IHdhcyBpbml0aWFsbHkgYWRkZWQgaW4gMjAxNyBhbmQgaGFzIHRoZSBzYW1lDQpkZXZpY2Ug
dG9wb2xvZ3kgd2hpY2ggaXMgU29DIDw9IHNwaSA9PiBDUExEL0ZQR0Egd2hlcmUgYTEwc3IgaGFz
IGEgM3JkIA0KZHJpdmVyDQpmaWxlIGZvciBhIGdwaW8gY29udHJvbGxlciByZXN1bHRpbmcgaW4g
dHdvIGNoaWxkIG5vZGVzLg0KDQpJbiBvdXIgY2FzZSBpdHMgbm90IG9uZSBmdW5jdGlvbiBpdHMg
Zm91ciBpbiB0aGUgZGV2aWNlIHdoZXJlIHRoZSBmdW5jdGlvbg0KYXQgY2hpcC1zZWxlY3QgMCBp
cyB3aGVyZSB0aGUgaGFyZHdhcmUgdGVhbSBwcm92aWRlZCB0aGUgYml0IHRvIGNvbnRyb2wNCmVN
TUMgaGFyZHdhcmUgcmVzZXQuwqAgSXMgdGhpcyBhIGJhZCBhcHByb2FjaCB0byBmb2xsb3cgYW5k
IGlmIHNvIHBsZWFzZQ0KcmVjb21tZW5kIGFuIGFjY2VwdGFibGUgYXBwcm9hY2guwqAgQWxzbywg
ImFtZCxwZW5zYW5kby1lbGJhc3IiIHdpbGwgbm90DQppbnN0YW50aWF0ZSBtb3JlIGRldmljZXMu
DQoNClNuaXBwZXRzIGJlbG93IGZvciBhMTBzciBpbiBsaW51eC1uZXh0OiBEZXZpY2Ugb24gb3Ro
ZXIgZW5kIG9mIHNwaSwNCm9uZSBjaGlwIHNlbGVjdCwgdHdvIGNoaWxkIGRldmljZXMgYW5kIDMg
ZHJpdmVyIGZpbGVzIGluIG1mZCwgcmVzZXQsIGFuZCANCmdwaW8uDQoNCkZJTEU6IGFyY2gvYXJt
L2Jvb3QvZHRzL3NvY2ZwZ2FfYXJyaWExMF9zb2Nkay5kdHNpOg0KJnNwaTEgew0KIMKgwqDCoMKg
wqDCoMKgIHN0YXR1cyA9ICJva2F5IjsNCg0KIMKgwqDCoMKgwqDCoMKgIHJlc291cmNlLW1hbmFn
ZXJAMCB7DQogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbXBhdGlibGUgPSAiYWx0
cixhMTBzciI7DQogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJlZyA9IDwwPjsNCiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3BpLW1heC1mcmVxdWVuY3kgPSA8MTAwMDAw
PjsNCiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyogbG93LWxldmVsIGFjdGl2ZSBJ
UlEgYXQgR1BJTzFfNSAqLw0KIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpbnRlcnJ1
cHQtcGFyZW50ID0gPCZwb3J0Yj47DQogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlu
dGVycnVwdHMgPSA8NSBJUlFfVFlQRV9MRVZFTF9MT1c+Ow0KIMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBpbnRlcnJ1cHQtY29udHJvbGxlcjsNCiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgI2ludGVycnVwdC1jZWxscyA9IDwyPjsNCg0KIMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBhMTBzcl9ncGlvOiBncGlvLWNvbnRyb2xsZXIgew0KIMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29tcGF0aWJsZSA9ICJhbHRyLGExMHNy
LWdwaW8iOw0KIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
Z3Bpby1jb250cm9sbGVyOw0KIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgI2dwaW8tY2VsbHMgPSA8Mj47DQogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIH07DQoNCiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYTEwc3JfcnN0OiByZXNl
dC1jb250cm9sbGVyIHsNCiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGNvbXBhdGlibGUgPSAiYWx0cixhMTBzci1yZXNldCI7DQogwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAjcmVzZXQtY2VsbHMgPSA8MT47DQogwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH07DQogwqDCoMKgwqDCoMKgwqAgfTsNCn07DQoN
CkZJTEU6IGRyaXZlcnMvbWZkL2FsdGVyYS1hMTBzci5jIChwYXJlbnQpDQpzdGF0aWMgY29uc3Qg
c3RydWN0IG1mZF9jZWxsIGFsdHJfYTEwc3Jfc3ViZGV2X2luZm9bXSA9IHsNCiDCoMKgwqDCoMKg
wqDCoCB7DQogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC5uYW1lID0gImFsdHJfYTEw
c3JfZ3BpbyIsDQogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC5vZl9jb21wYXRpYmxl
ID0gImFsdHIsYTEwc3ItZ3BpbyIsDQogwqDCoMKgwqDCoMKgwqAgfSwNCiDCoMKgwqDCoMKgwqDC
oCB7DQogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC5uYW1lID0gImFsdHJfYTEwc3Jf
cmVzZXQiLA0KIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAub2ZfY29tcGF0aWJsZSA9
ICJhbHRyLGExMHNyLXJlc2V0IiwNCiDCoMKgwqDCoMKgwqDCoCB9LA0KfTsNCg0Kc3RhdGljIGNv
bnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgYWx0cl9hMTBzcl9zcGlfb2ZfbWF0Y2hbXSA9IHsNCiDC
oMKgwqDCoMKgwqDCoCB7IC5jb21wYXRpYmxlID0gImFsdHIsYTEwc3IiIH0sDQogwqDCoMKgwqDC
oMKgwqAgeyB9LA0KfTsNCg0KRklMRTogZHJpdmVycy9yZXNldC9yZXNldC1hMTBzci5jIChyZXNl
dCBkcml2ZXIpDQpzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBhMTBzcl9yZXNldF9v
Zl9tYXRjaFtdID0gew0KIMKgwqDCoMKgwqDCoMKgIHsgLmNvbXBhdGlibGUgPSAiYWx0cixhMTBz
ci1yZXNldCIgfSwNCiDCoMKgwqDCoMKgwqDCoCB7IH0sDQp9Ow0KDQpGSUxFOiAuL2RyaXZlcnMv
Z3Bpby9ncGlvLWFsdGVyYS1hMTBzci5jIChncGlvIGRyaXZlcikNCnN0YXRpYyBjb25zdCBzdHJ1
Y3Qgb2ZfZGV2aWNlX2lkIGFsdHJfYTEwc3JfZ3Bpb19vZl9tYXRjaFtdID0gew0KIMKgwqDCoMKg
wqDCoMKgIHsgLmNvbXBhdGlibGUgPSAiYWx0cixhMTBzci1ncGlvIiB9LA0KIMKgwqDCoMKgwqDC
oMKgIHsgfSwNCn07DQoNCkluIGNvbXBhcmlzaW9uLCB0aGUgcGVuc2FuZG8gZGV2aWNlIGlzIGFs
c28gb24gdGhlIG90aGVyIGVuZCBvZiBzcGksDQpmb3VyIGNoaXAgc2VsZWN0cyB3aXRoIC9kZXYg
Y3JlYXRlZCBmb3IgZWFjaCBmb3IgdXNlcnNwYWNlIGNvbnRyb2wsDQphbmQgb25lIGNoaWxkIGRl
dmljZSBvbiBjczAgZm9yIGh3IHJlc2V0IGVtbWMgdGhhdCB0aGUgTGludXggYmxvY2sNCmxheWVy
IGNvbnRyb2xzIChzaW5nbGUgYml0IG1hbmFnZWQgb25seSBieSBrZXJuZWwpLg0KDQpQZW5zYW5k
bzoNCiZzcGkwIHsNCiDCoMKgwqDCoMKgwqDCoCBudW0tY3MgPSA8ND47DQogwqDCoMKgwqDCoMKg
wqAgY3MtZ3Bpb3MgPSA8MD4sIDwwPiwgPCZwb3J0YSAxIEdQSU9fQUNUSVZFX0xPVz4sDQogwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDwmcG9ydGEgNyBHUElPX0FDVElWRV9M
T1c+Ow0KIMKgwqDCoMKgwqDCoMKgIHN0YXR1cyA9ICJva2F5IjsNCiDCoMKgwqDCoMKgwqDCoCBz
eXN0ZW0tY29udHJvbGxlckAwIHsNCiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29t
cGF0aWJsZSA9ICJhbWQscGVuc2FuZG8tZWxiYXNyIjsNCiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgcmVnID0gPDA+Ow0KIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAjYWRk
cmVzcy1jZWxscyA9IDwxPjsNCiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgI3NpemUt
Y2VsbHMgPSA8MD47DQogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNwaS1tYXgtZnJl
cXVlbmN5ID0gPDEyMDAwMDAwPjsNCg0KIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBy
c3RjOiByZXNldC1jb250cm9sbGVyIHsNCiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGNvbXBhdGlibGUgPSAiYW1kLHBlbnNhbmRvLWVsYmFzci1yZXNldCI7
DQogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAjcmVzZXQt
Y2VsbHMgPSA8MT47DQogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH07DQogwqDCoMKg
wqDCoMKgwqAgfTsNCg0KIMKgwqDCoMKgwqDCoMKgIHN5c3RlbS1jb250cm9sbGVyQDEgew0KIMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb21wYXRpYmxlID0gImFtZCxwZW5zYW5kby1l
bGJhc3IiOw0KIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZWcgPSA8MT47DQogwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNwaS1tYXgtZnJlcXVlbmN5ID0gPDEyMDAwMDAw
PjsNCiDCoMKgwqDCoMKgwqDCoCB9Ow0KDQogwqDCoMKgwqDCoMKgwqAgc3lzdGVtLWNvbnRyb2xs
ZXJAMiB7DQogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbXBhdGlibGUgPSAiYW1k
LHBlbnNhbmRvLWVsYmFzciI7DQogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJlZyA9
IDwyPjsNCiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3BpLW1heC1mcmVxdWVuY3kg
PSA8MTIwMDAwMDA+Ow0KIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpbnRlcnJ1cHQt
cGFyZW50ID0gPCZwb3J0YT47DQogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGludGVy
cnVwdHMgPSA8MCBJUlFfVFlQRV9MRVZFTF9MT1c+Ow0KIMKgwqDCoMKgwqDCoMKgIH07DQoNCiDC
oMKgwqDCoMKgwqDCoCBzeXN0ZW0tY29udHJvbGxlckAzIHsNCiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgY29tcGF0aWJsZSA9ICJhbWQscGVuc2FuZG8tZWxiYXNyIjsNCiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmVnID0gPDM+Ow0KIMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBzcGktbWF4LWZyZXF1ZW5jeSA9IDwxMjAwMDAwMD47DQogwqDCoMKgwqDCoMKg
wqAgfTsNCn07DQoNClJlZ2FyZHMsDQpCcmFkDQo=
