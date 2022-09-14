Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5BE75B8F09
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 20:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiINSrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 14:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiINSrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 14:47:46 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1AB7C317;
        Wed, 14 Sep 2022 11:47:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oZZ2xRWTknjYWIE5LYIQf1uc5lf0oh5QLleKJwPy1W/uzRdiu6s4BOjTzsY60wqA5GWc3VbP3JsLrjdJtl8Md1GYd3OqbMgHo+JGoS4GfjzyXdPiZicCflHOBsHI+1qrrg+tI0lTBjrwotBkMQ9/42tb+v7TmNlBBhuLblDv5OHW+nM15b2byqnHtZBAEYdwAriklM5SaiRUseWF8+9cntSxFmG011ZYVJ0EeJCH8f6sSqfpsYnCR+DZ+UBED4grNc9zDs+5VmzstTzTQV/ipEsA1TF1D3yBXSt3H9WNU0sH9eZ2a308LQ5ZpdG0GDQUVXEw8/3yUuIlYVXIdNsFHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UKJwdYa8Kw2tf5vjPqTTsPTnT+KjzQxuUTxfcxGtbIs=;
 b=RheYKbxblUzZdfiWNoNwAcFkODeT8+ZE5l9TIENQBHdl594a0MbMILN4fMa2Admp56p3z0uzS1GJyKmZ4rC+BocNlgRIl8ScrBvgHrdERIz1TUi1r6W2M9+GNsZadpAwWvvXS+qjQNWDqNTjs1ozIKks6DeEqyKIkdnAzIOYK2cQ0WJiq3LKZ86737oboX5KDorgRaR/Xcu3/l45l0ww8j9/lBn90Ed36ADMKFkToI3IujuhuWWrTH6ZvgL4+1ktNDk07CR5Kx2uxu6IMoNboe0dd9hmgE3udN/DziolQ8/eg64QhwGG06RpPmTQ5hCY8rxG7dZaVTDtRTAC4AkM3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UKJwdYa8Kw2tf5vjPqTTsPTnT+KjzQxuUTxfcxGtbIs=;
 b=MCIZ79I7jsrgG/ujkgecCMRe6Qoooyd5luuXMc7W80i8ao73pjbMpn75lsOi5tbH5FwZtCSlUwlFJ1+4UHKAmoLU2hV27fDLaQrtWTlcRawpvEMqciS1j7tALzV/+SmJKSGpJlS48yd4XkV9FTP06wAbsqFVCW1WlAqOT7Cu210=
Received: from BL0PR12MB2401.namprd12.prod.outlook.com (2603:10b6:207:4d::19)
 by PH7PR12MB5829.namprd12.prod.outlook.com (2603:10b6:510:1d4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Wed, 14 Sep
 2022 18:47:37 +0000
Received: from BL0PR12MB2401.namprd12.prod.outlook.com
 ([fe80::169:8fcb:d816:54d2]) by BL0PR12MB2401.namprd12.prod.outlook.com
 ([fe80::169:8fcb:d816:54d2%4]) with mapi id 15.20.5612.022; Wed, 14 Sep 2022
 18:47:37 +0000
From:   "Larson, Bradley" <Bradley.Larson@amd.com>
To:     Serge Semin <fancer.lancer@gmail.com>,
        "Larson, Bradley" <Bradley.Larson@amd.com>
CC:     Brad Larson <brad@pensando.io>,
        "linux-arm-kernel@lists.infradead.org" 
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
        "krzk@kernel.org" <krzk@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "piotrs@cadence.com" <piotrs@cadence.com>,
        "p.yadav@ti.com" <p.yadav@ti.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "samuel@sholland.org" <samuel@sholland.org>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "will@kernel.org" <will@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v6 04/17] dt-bindings: spi: dw: Add AMD Pensando Elba SoC
 SPI Controller bindings
Thread-Topic: [PATCH v6 04/17] dt-bindings: spi: dw: Add AMD Pensando Elba SoC
 SPI Controller bindings
Thread-Index: AQHYtM841nPgSBs2aEa7V9yGUi8o5a25ozYAgA/CLYCAEUsugIAEuroA
Date:   Wed, 14 Sep 2022 18:47:37 +0000
Message-ID: <e0edd195-8642-3b59-beaf-a2027877d33a@amd.com>
References: <20220820195750.70861-1-brad@pensando.io>
 <20220820195750.70861-5-brad@pensando.io>
 <20220821174952.5i5pfftxt53dmqv3@mobilestation>
 <0c2ac76e-45ff-b5a1-f33a-177eea04c17d@amd.com>
 <20220911183415.ufeasmm3uev7wqx4@mobilestation>
In-Reply-To: <20220911183415.ufeasmm3uev7wqx4@mobilestation>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR12MB2401:EE_|PH7PR12MB5829:EE_
x-ms-office365-filtering-correlation-id: a35d7307-7b7e-46b7-5fed-08da96819805
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ocd3J9UYZ2XlCdDX2+U4LYzANylbfAPi4FysWKf1DdddeQYCpIELcTWNHxh8j3OQjS5Ru3LBdAO5GXYwvCWKLG6qZQqyiM5WiJrKyR+uhlIZTOEhxGcf3dIPj/jShnS3EItzR4FE+mHebLPDj9zCIwTdxfdvlVps0QpsHb4txutz7epeL4lX170X79HA0uUYTCRxbrzou0iJwdHN+AeKnTFJxjGwH5BewpaTfDpFyGe8Wro7M4B1Bph4HNVw88L3PbqV09yDsGsWb+HiA/I2F7+8S7XlY+tNptO2Rxuz8arRHDWbOwMgE8T/5lA3eNEZhs86udBbQ580uzbWJVncjPvcNAlbtidlgm/9w7JihbtNmIWhKgnL6aEPvNx/tFsidDvRkWUl+unSgbcSf6y4ly3k88i72YfPXUvMPqdsHeJuJ41lVaPCrQF2axm7LNzYpf7DMk2BTVjfT8hL/Qe/bfCVbVcEPKx2Y2sXPeRBl7I8EpbYgLIIg1nt/rjbhRtFLK4kNQ6xM93wTlVSs3p2X8BalPLTGs7Bwiy13kIT6yfwI0wM+yVRg55zqstVyv0y19IG6BDFC8+Uft40X+6AXpqzBjuTw98lm4UFdPgESPrK5PdbpflqWRjG8vZWvJfZf4fptIo4Z9CZMPaumFrYd0BQpdIeyktVUl9l2L0bb8pwaCvhWBu0uLifISnTTccEJ9c8mlAaZHQrlUHXqSDcC79EnOE6Aj7gkNzD4Ot5L73RCQGdTXykG39IPA52oKxJAwPcn7CvgyTgLg8FGERTExwKgTzqt8lBIXGZb9ocZ1nZlQaAfayeVgIL0sOXofzb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2401.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(366004)(396003)(346002)(376002)(451199015)(966005)(53546011)(6506007)(6486002)(186003)(2616005)(71200400001)(83380400001)(41300700001)(8936002)(31696002)(478600001)(66556008)(38100700002)(6512007)(316002)(36756003)(5660300002)(122000001)(110136005)(7416002)(54906003)(2906002)(38070700005)(66476007)(76116006)(8676002)(31686004)(64756008)(66946007)(45080400002)(4326008)(66446008)(86362001)(91956017)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WHo0VTczYllVN1dZTlREOHRKMWJjbm53NVZCQklIazlPNDkyMk9XVkR5ZDhr?=
 =?utf-8?B?cVFydWtmejNWSlpIVStidVVoVUhrcm5FS1FhWHZsTHAvUmlBdFV4akFoajM3?=
 =?utf-8?B?T2lPMkZ5Mmd5YkJscE5yTi9HbWdubjdFb1NxUjRURjdscjRobWh5MG4wbFR4?=
 =?utf-8?B?S1M2THRvWFFDUSs5RlRHY3lkbGRPMksvWHB3S2dlRDF4STdPL3JIR2pJTWJi?=
 =?utf-8?B?TVQ0ZHFXeGxBS2Nzc3FPRnhvQU01ZDQwWWxjemRxUGFTdnpCU0xLSUhZYS9l?=
 =?utf-8?B?SjM2UnhOaWJwSVB0SGVZT0kzcmY5d2pMV2dKVFNRSlhZY1VqSEpzWU1NWUc2?=
 =?utf-8?B?Z0xnT3B1dXNTZHZDZFYzcWduVjh3NWJBQXVXNVdoa21wYXFqRFNZN25MQzNi?=
 =?utf-8?B?RGRqd0QvOG9mcmpFbXEveEp1S1Q0UmJMYVpxdTBWMEEwWTdWc0dKOVI2UHds?=
 =?utf-8?B?ZEQ1R3MzK3pINmNCWWlzamdDV3BVVVpwaTNMNG9weWl4dXI5MkcrOStJTHBB?=
 =?utf-8?B?SFFUemlSRDRZNmkydW1NWDBoYzJRQm8zMHdSZUFTVGdPSUUyTi9kbTJ3SlRt?=
 =?utf-8?B?WXFXMWU5Q3lzenliY2k3cTdxZktEZzAwSW5mWE54MS90MnBRekFxMTl1TGRk?=
 =?utf-8?B?endVVW9vRFU5TExVSXk1ZVdIL0U0NCs0NW5IdERuazlSaXlKUU05UUhXRDZt?=
 =?utf-8?B?TjZLVUtreU5adkVmenh6T1A0SWhQSXFQVlhqQXJXWDVoN0p1akptRVlsTlYw?=
 =?utf-8?B?QnBrOFpmUzVkdmFHN2RwOVFsVGlndVNYRmxYSG5yS1FkZ3pxMyt2K3B2R0Va?=
 =?utf-8?B?MXRoU1crQmJvdnpGUkhtYXlRQTMybnhONTlaMW9BUmxRcmltOUk3OGZQOHpZ?=
 =?utf-8?B?WDRLR2FkUmVzbkRjdFEwdUxkdVdBbFV5b0VuOEdZV2RjTjBZTklaRnEwanZK?=
 =?utf-8?B?TWdTRzlZbkRyNnJITkM2TW5RNHlVMTFLK1Q1N0hYTkE3alVJRXpnL1VIdmhP?=
 =?utf-8?B?NndhR0gvRHN2SXdFNmFZRm9ZcldQZ3Y0R1ZRMzF0VXdEdm5PTkpKNGJUaGtC?=
 =?utf-8?B?OWF1NTV3cjhoZG5WWXZjRzBMb0lXSW9TcHhlbi9RVzFIQkhTME5EVThBT1JB?=
 =?utf-8?B?endtS2ZJUlhVRXlYVlllYUwwNys4U1Mrayt4YUl0K0Y3MEtOcy9GWSswclBp?=
 =?utf-8?B?TFFvb0oweGNpM3BnYk9ZWWRYandVcjlxWFp5N2FVdWlVZ1R0ZzhBR2ZpNmxU?=
 =?utf-8?B?cWNnMUFXd3FuZ29nQmp4QjdzTmRwKzFBTWlpUmRIOENsUzdOU0xkdis0ZlpZ?=
 =?utf-8?B?SC85WTJKazJRY0E4K0d1L29Ya29vRFFaanloV0pHRjZHTVNYeVJRWittc2Zx?=
 =?utf-8?B?QkoyeVQ5MTdEcmc4YXdPSVVQUnJQb1FRZDB3OTB5N1RvUHlvOVJxb0xXeGkv?=
 =?utf-8?B?RTJsOEQ5cXJOUGE2cmFnQ1JzWm1UZlhxZ0tSK2ljQkxvdFVFbEVqM0l0b29z?=
 =?utf-8?B?dmRPVzlta1ltQWcrNjU5TWVJOXBLWDRiaEduc0JBR0tyek9rQXgvdzd5NUE4?=
 =?utf-8?B?Z3Y1OHpxYVkwbE9SV0pmT2N1dVNEdXhRTVhnRHluSVhHNzE5eDJEWHR5WS9I?=
 =?utf-8?B?bGVCQlBnc1hKbER4clFhWnZHcElHd0dKbXYwVnR3YUk0V0ZkUER3SEw3aERO?=
 =?utf-8?B?cHU5eFZjRkJEZWt5N1k0TzQ4alYwNFQrTVdjWE5pSENWQ0tIR0QrOHdKSis5?=
 =?utf-8?B?NWxYUE1BUkpVejRLSzZtZ2NrKzltRWFQc1VDbktvZjZLZGJvL0daVFo3WWlr?=
 =?utf-8?B?ZzVncS9MbEQyZjU2L0xaOWoxZEY5YURpMHhGNUFNcm00d1BXZVBXaTRvZitj?=
 =?utf-8?B?ZlpaWWtDRk04RHM0eUgxQk1KUXJzUFFjcmNuZXhCVkpWRlVjSUtMeG9kVm5l?=
 =?utf-8?B?bXNTK1o1UFE4UFlyOWpWNGRxWmE2WnBDRlY3UVBuWmEycEdsL2RMdzl3OWYy?=
 =?utf-8?B?ZThLcGVCeTd1bnU5NjBZaVhWd2M2Mnd2eE1RMVFTQjdEYmxrU09CY0V3cTJE?=
 =?utf-8?B?dEtGTDRoTDZrWGdzSlVHZzhXczRhdjFZUXFRZjdLWUE5VkNtdEp4NUxLVTRV?=
 =?utf-8?B?Y2c1OXlaenlaWTJGcnRLZFNDSjlSdzhQMThGTmd0VDVBN090MTdiUWpGVEdC?=
 =?utf-8?Q?lLevjjY9o9vn+l1tmnFERrQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F7C741383138C140A14DDF2562D5D417@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2401.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a35d7307-7b7e-46b7-5fed-08da96819805
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2022 18:47:37.1626
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y4A6esZnSo7gPMRNvmG4W8LizJ/ZxvqhImWX1K2O1/0rZ9xuHL2traqG8OVuqrdk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5829
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOS8xMS8yMiAxMTozNCBBTSwgU2VyZ2UgU2VtaW4gd3JvdGU6DQo+IE9uIFdlZCwgQXVnIDMx
LCAyMDIyIGF0IDA2OjI4OjQ2UE0gKzAwMDAsIExhcnNvbiwgQnJhZGxleSB3cm90ZToNCj4+IE9u
IDgvMjEvMjIgMTA6NDkgQU0sIFNlcmdlIFNlbWluIHdyb3RlOg0KPj4+IE9uIFNhdCwgQXVnIDIw
LCAyMDIyIGF0IDEyOjU3OjM3UE0gLTA3MDAsIEJyYWQgTGFyc29uIHdyb3RlOg0KPj4+PiBGcm9t
OiBCcmFkIExhcnNvbiA8YmxhcnNvbkBhbWQuY29tPg0KPj4+Pg0KPj4+PiBUaGUgQU1EIFBlbnNh
bmRvIEVsYmEgU29DIGhhcyBpbnRlZ3JhdGVkIHRoZSBEVyBBUEIgU1BJIENvbnRyb2xsZXINCj4+
Pj4NCj4+Pj4gU2lnbmVkLW9mZi1ieTogQnJhZCBMYXJzb24gPGJsYXJzb25AYW1kLmNvbT4NCj4+
Pj4gLS0tDQo+Pj4+ICAgIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NwaS9zbnBzLGR3LWFwYi1z
c2kueWFtbCAgICAgIHwgMTEgKysrKysrKysrKysNCj4+Pj4gICAgMSBmaWxlIGNoYW5nZWQsIDEx
IGluc2VydGlvbnMoKykNCj4+Pj4NCj4+Pj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9zcGkvc25wcyxkdy1hcGItc3NpLnlhbWwgYi9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3Mvc3BpL3NucHMsZHctYXBiLXNzaS55YW1sDQo+Pj4+IGluZGV4
IDM3YzNjMjcyNDA3ZC4uNDAzZDY0MTZmN2FjIDEwMDY0NA0KPj4+PiAtLS0gYS9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc3BpL3NucHMsZHctYXBiLXNzaS55YW1sDQo+Pj4+ICsr
KyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zcGkvc25wcyxkdy1hcGItc3Np
LnlhbWwNCj4+Pj4gQEAgLTM3LDYgKzM3LDE1IEBAIGFsbE9mOg0KPj4+PiAgICAgICAgZWxzZToN
Cj4+Pj4gICAgICAgICAgcmVxdWlyZWQ6DQo+Pj4+ICAgICAgICAgICAgLSBpbnRlcnJ1cHRzDQo+
Pj4+ICsgIC0gaWY6DQo+Pj4+ICsgICAgICBwcm9wZXJ0aWVzOg0KPj4+PiArICAgICAgICBjb21w
YXRpYmxlOg0KPj4+PiArICAgICAgICAgIGNvbnRhaW5zOg0KPj4+PiArICAgICAgICAgICAgZW51
bToNCj4+Pj4gKyAgICAgICAgICAgICAgLSBhbWQscGVuc2FuZG8tZWxiYS1zcGkNCj4+Pj4gKyAg
ICB0aGVuOg0KPj4+PiArICAgICAgcmVxdWlyZWQ6DQo+Pj4+ICsgICAgICAgIC0gYW1kLHBlbnNh
bmRvLWVsYmEtc3lzY29uDQo+Pj4gUGxlYXNlIGFkZCB0aGUgImFtZCxwZW5zYW5kby1lbGJhLXN5
c2NvbiIgcHJvcGVydHkgZGVmaW5pdGlvbiBhcyBJDQo+Pj4gYXNrZWQgaGVyZToNCj4+PiBodHRw
czovL25hbTExLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0El
MkYlMkZsb3JlLmtlcm5lbC5vcmclMkZsa21sJTJGMjAyMjA3MDQxMzE4MTAua2Fia3V5NmU0cW1o
Zm0zbiU0MG1vYmlsZXN0YXRpb24lMkYmYW1wO2RhdGE9MDUlN0MwMSU3Q0JyYWRsZXkuTGFyc29u
JTQwYW1kLmNvbSU3QzVmNjFjOGY4MTMwYzQ3ZmE4MTQyMDhkYTk0MjQzZTE3JTdDM2RkODk2MWZl
NDg4NGU2MDhlMTFhODJkOTk0ZTE4M2QlN0MwJTdDMCU3QzYzNzk4NTE4MDY4NjM1NzcwNSU3Q1Vu
a25vd24lN0NUV0ZwYkdac2IzZDhleUpXSWpvaU1DNHdMakF3TURBaUxDSlFJam9pVjJsdU16SWlM
Q0pCVGlJNklrMWhhV3dpTENKWFZDSTZNbjAlM0QlN0MzMDAwJTdDJTdDJTdDJmFtcDtzZGF0YT11
emNTQmp1eHMxSlpGWGlSR0ZWTEdvakFzaXBKQUNYRUdza1lkR21yN3FBJTNEJmFtcDtyZXNlcnZl
ZD0wDQo+PiBQcm9wb3NpbmcgdGhpcyBhZGRpdGlvbjoNCj4+DQo+PiAtLS0gYS9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc3BpL3NucHMsZHctYXBiLXNzaS55YW1sDQo+PiArKysg
Yi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc3BpL3NucHMsZHctYXBiLXNzaS55
YW1sDQo+PiBAQCAtMTQ4LDYgKzE0OCwxNSBAQCBwcm9wZXJ0aWVzOg0KPj4gICAgICAgICAgb2Yg
dGhlIGRlc2lnbndhcmUgY29udHJvbGxlciwgYW5kIHRoZSB1cHBlciBsaW1pdCBpcyBhbHNvIHN1
YmplY3QgdG8NCj4+ICAgICAgICAgIGNvbnRyb2xsZXIgY29uZmlndXJhdGlvbi4NCj4+DQo+PiAr
ICBhbWQscGVuc2FuZG8tZWxiYS1zeXNjb246DQo+PiArICAgICRyZWY6ICIvc2NoZW1hcy90eXBl
cy55YW1sIy9kZWZpbml0aW9ucy9waGFuZGxlLWFycmF5Ig0KPj4gKyAgICBtYXhJdGVtczogMQ0K
Pj4gKyAgICBkZXNjcmlwdGlvbjoNCj4+ICsgICAgICBBIHBoYW5kbGUgdG8gc3lzY29uIHVzZWQg
dG8gYWNjZXNzIHRoZSBzcGkgY2hpcC1zZWxlY3Qgb3ZlcnJpZGUNCj4+IHJlZ2lzdGVyLg0KPj4g
KyAgICBpdGVtczoNCj4+ICsgICAgICAtIGl0ZW1zOg0KPj4gKyAgICAgICAgLSBkZXNjcmlwdGlv
bjogcGhhbmRsZSB0byB0aGUgc3lzY29uIG5vZGUNCj4+ICsNCj4gTm8uIFdoYXQgS3J6eXN6dG9m
IGFuZCBJIGFza2VkIHdhcyB0byBhZGQgdGhlIHByb3BlcnR5IGRlZmluaXRpb24NCj4gaW50byB0
aGUgYWxsT2Y6IFsgaWYgLi4uLCAgXSBzdGF0ZW1lbnQuIFBsZWFzZSByZWFkIG1vcmUgY2FyZWZ1
bGx5IG15DQo+IGxhc3QgY29tbWVudDoNCj4gaHR0cHM6Ly9uYW0xMS5zYWZlbGlua3MucHJvdGVj
dGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGbG9yZS5rZXJuZWwub3JnJTJGbGtt
bCUyRjIwMjIwNzA0MTMxODEwLmthYmt1eTZlNHFtaGZtM24lNDBtb2JpbGVzdGF0aW9uJTJGJmFt
cDtkYXRhPTA1JTdDMDElN0NCcmFkbGV5LkxhcnNvbiU0MGFtZC5jb20lN0M1ZjYxYzhmODEzMGM0
N2ZhODE0MjA4ZGE5NDI0M2UxNyU3QzNkZDg5NjFmZTQ4ODRlNjA4ZTExYTgyZDk5NGUxODNkJTdD
MCU3QzAlN0M2Mzc5ODUxODA2ODYzNTc3MDUlN0NVbmtub3duJTdDVFdGcGJHWnNiM2Q4ZXlKV0lq
b2lNQzR3TGpBd01EQWlMQ0pRSWpvaVYybHVNeklpTENKQlRpSTZJazFoYVd3aUxDSlhWQ0k2TW4w
JTNEJTdDMzAwMCU3QyU3QyU3QyZhbXA7c2RhdGE9dXpjU0JqdXhzMUpaRlhpUkdGVkxHb2pBc2lw
SkFDWEVHc2tZZEdtcjdxQSUzRCZhbXA7cmVzZXJ2ZWQ9MA0KPiBUaGUgZGVmaW5pdGlvbiBpcyBz
dXBwb3NlZCB0byBsb29rIGxpa2UgdGhpczoNCj4NCj4+ICsgIC0gaWY6DQo+PiArICAgICAgcHJv
cGVydGllczoNCj4+ICsgICAgICAgIGNvbXBhdGlibGU6DQo+PiArICAgICAgICAgIGNvbnRhaW5z
Og0KPj4gKyAgICAgICAgICAgIGNvbnN0OiBhbWQscGVuc2FuZG8tZWxiYS1zcGkNCj4+ICsgICAg
dGhlbjoNCj4gICAgKyAgICAgIHByb3BlcnRpZXM6DQo+ICAgICsgICAgICAgIGFtZCxwZW5zYW5k
by1lbGJhLXN5c2Nvbg0KPiAgICArICAgICAgICAgICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwj
L2RlZmluaXRpb25zL3BoYW5kbGUNCj4gICAgKyAgICAgICAgICBkZXNjcmlwdGlvbjogQU1EIFBl
bnNhbmRvIEVsYmEgU29DIHN5c3RlbSBjb250cm9sbGVyDQo+PiArICAgICAgcmVxdWlyZWQ6DQo+
PiArICAgICAgICAtIGFtZCxwZW5zYW5kby1lbGJhLXN5c2Nvbg0KPiAqIFBsZWFzZSBhbHNvIG5v
dGUgdGhhdCBJJ3ZlIHJlcGxhY2VkICJlbnVtOiIgd2l0aCAiY29uc3Q6IiBpbiB0aGUgaWYNCj4g
c3RhdGVtZW50IGFib3ZlLg0KPg0KPiBUaGUgZGlmZmVyZW5jZSB3aXRoIHdoYXQgeW91IHN1Z2dl
c3RlZCBpcyB0aGF0IG15IHZlcnNpb24gaXMNCj4gYXBwbGljYWJsZSBmb3IgdGhlIFBlbnNhbmRv
IEVMQkEgU1BJIGNvbnRyb2xsZXIgb25seSwgd2hpbGUgeW91cg0KPiB1cGRhdGUgd2lsbCBjYXVz
ZSBhcHBseWluZyB0aGUgImFtZCxwZW5zYW5kby1lbGJhLXN5c2NvbiIgcHJvcGVydHkNCj4gY29u
c3RyYWludHMgZm9yIGFsbCBEVyBTU0kgY29udHJvbGxlcnMgd2hpY2ggaXNuJ3Qgd2hhdCB3ZSB3
b3VsZCB3YW50Lg0KDQoNClllcywgSSBzZWUgYnkgbW92aW5nIHRoaXMgcHJvcGVydHkgaW50byB0
aGUgYWxsT2YgaXRzIG9ubHkgYXBwbGljYWJsZSANCmZvciBjb21wYXRpYmxlICJhbWQscGVuc2Fu
ZG8tZWxiYS1zcGkiLiBBbHNvIGNoYW5naW5nICJlbnVtOiIgdG8gDQoiY29uc3Q6IiBhcyBzaG93
bi7CoCBZZXMgb24gdGhlIERULWJpbmRpbmdzIGNoZWNrLiBSb2IgSGVycmluZydzIGJvdCANCmlu
ZGljYXRlZCBhbiBlcnJvciBidXQgSSBoYWQgbm9uZSBpbiBjaGVja2luZyBWNiBwYXRjaHNldC7C
oCBJIGRpZCBhIA0KZHRzY2hlbWEgdXBkYXRlIGFuZCBpdCB3ZW50IGZyb20gZHRzY2hlbWEgMjAy
Mi4zLjIgdG8gZHRzY2hlbWEtMjAyMi44LjMgDQphbmQgd2lsbCBzZWUgaWYgdGhhdCBpcyB0aGUg
cmVhc29uLg0KDQpSZWdhcmRzLA0KQnJhZA0K
