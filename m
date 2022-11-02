Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA606166F8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 17:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbiKBQDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 12:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbiKBQDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 12:03:04 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2126.outbound.protection.outlook.com [40.107.113.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A37F2CC92;
        Wed,  2 Nov 2022 09:02:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XruKcnHctxQNgv6+wkxdv8dxabuiPIYfyb1AZ0Nmyb9MjAlssLvJvciekAC7kPLhxCXioGMehpawoSmDMwju4J0F6eiSLKdW5aHfs5BURcF3jJ2D2tjTRZ7/F9pVbmPtkEGTa4Db1NC39549qQjrjUJM4PdpljlB+VjxX5g1G7KvN6byAY7NXfWRyJzSqs/2r3kSipZVm7pyKR+Pe/xlWpVR8PoHShWuaUJSp0lbdcRYLzEDAvpEPyYmwQAY0fyzDV1JnjfsBJB9cg997xqh4FprD/fEhzF/h/dBFNEthYOLRklCOlZBwyGtwUSYhmm3U9bsE+t3x8QIePW4gil0zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+W1fbR4E9M1oSkQ5Q8+li09hvqFLeno+mv3VRIjQbwQ=;
 b=Qp4/vvNyAKTKRZ5jtjhEvwIC/r/FpbUnaCvNjgedulFNE/OF6dKZshau8SOCSmLJCzzBk8KJD3C2/LM3Ly1EITHZEUBa4AzRTJOwIaQJpXEdvEeTJ66a+LCwCr5Mdzo2oHJ5xsiB4+lEIVgmUh73b8wX/jlWpXSJXPIYMXKiSBjgJ1ImVdyh0Yjh62LLMfEakZgokk4xccv80A3qnsHeTOgB7SCeNGxZmDf0W68kkQZ+s8vWfG3OFfrA38LiD02sfzvrGCEWfl/nR5ccdnNOeYarFhJQ2OvAZns9sJ5/dQjEPXHAcS0jli5YLH1tOXkmBd+8qyNKU0wJdkMZnhI29Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+W1fbR4E9M1oSkQ5Q8+li09hvqFLeno+mv3VRIjQbwQ=;
 b=pBsxn0ZBnqL06mlolDx0AbEsKsHJ03H5/uTMYQJDs4MjsGgFJD9ZJ+o6QgATnMRfp9MyWIOpArFtczw+Ah4Gkpck+TDeKH7qMyYQDchaNPKZanyELvDK8IHRNfkLtFfq7HpGw6iB2itA2J9Qt7n0FoPn41+4YjLYPk7JGQyNDq0=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB5807.jpnprd01.prod.outlook.com (2603:1096:400:45::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Wed, 2 Nov
 2022 16:02:35 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::5b24:f581:85bd:6ce2]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::5b24:f581:85bd:6ce2%3]) with mapi id 15.20.5791.020; Wed, 2 Nov 2022
 16:02:35 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Sasha Finkelstein <fnkl.kernel@gmail.com>
CC:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "marcan@marcan.st" <marcan@marcan.st>,
        "sven@svenpeter.dev" <sven@svenpeter.dev>,
        "alyssa@rosenzweig.io" <alyssa@rosenzweig.io>,
        "asahi@lists.linux.dev" <asahi@lists.linux.dev>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/4] pwm: Add Apple PWM controller
Thread-Topic: [PATCH v2 2/4] pwm: Add Apple PWM controller
Thread-Index: AQHY7scaJddHyAtwqkGPO5YDCJjX564rwPswgAAJOYCAAABF0A==
Date:   Wed, 2 Nov 2022 16:02:35 +0000
Message-ID: <OS0PR01MB592217539BCA46FD8F523C2386399@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20221102141513.49289-1-fnkl.kernel@gmail.com>
 <20221102141513.49289-3-fnkl.kernel@gmail.com>
 <OS0PR01MB59227A9E7B8A471E4D6B665786399@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMT+MTT1ptFymwDdOe=OXYzKfOPHdQbAfpx_9LBYn+C9NFhddg@mail.gmail.com>
In-Reply-To: <CAMT+MTT1ptFymwDdOe=OXYzKfOPHdQbAfpx_9LBYn+C9NFhddg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYCPR01MB5807:EE_
x-ms-office365-filtering-correlation-id: 4a82cd68-8551-4ff3-321e-08dabceba827
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yQ0DVNwl1hM53WSXaZSEGRsDSSahdmIrAVf+tCtbKAkgzjrbQmyTdNRiPpfQBY0Kvu/6qcdCbFvhtmNutRud2hAPV2UL4SHaYAnva+7lx6DJBSLvfEkzL6VILjRMS3zUhjHOI0cF+oMv2CAbBihVbEt5Cfu8uKMPEmZ4G+7sjN6D3KyD1O/3CRPoB8Kh4eKym8cbFSMbI0N1dtXDKJWqP0farY+MFvm/PTS7mgmk0EB7eh2iO5LN58uGEBvxMHiptrwo/4O7J1S0RdCeHkKk6re6GzfiFAOXsBe/sMtO5XW0QOMCgUCXoiZ9wWH09rQkYUrJoD0AMLYfCHZxe/E6EeFLb4xJb7+bQRkwoaybOcy/joPFdoEJqfN804FiSEPfzCgZjzNmI7w9E3XEix72v3BrtaNIV4DN9+ZsK3j8MO8ckdQFQ8DFUJUsPbNhroVLEEcJ6vNugnSQyFcw+nBSTZ4lWwBainozTh+w7AAltK/2fmhsuEYjp262cMjGT2YYTNd5ffwvyewYMdl41HFn7nR/tqvyRviwHI/Ih26yK4VBkavofrzAjlWz5srg0ISxYTiRx9R9zpMPe468VXJmdYe623h70RbbtppcYIBXQ//qe/PfCRNPiTyX8s7Fs+3/O+qWKMM/bbXIVF2qMcpFD6KVI52z06lFdgQpjjyOu4//z8bZoFSIyLRGUqYLjrUlQpdk+p7hTksf0lELJR70UZqFg802yOa4i0e3rNQ68wKF7suidQQslN5KRcIyG45IOm293A2HNJh6CRLsr6lN9M3YEJedB/VIOixI60p+a4A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(396003)(366004)(376002)(39860400002)(47660400002)(451199015)(7416002)(41300700001)(5660300002)(4744005)(38070700005)(8936002)(2906002)(8676002)(55016003)(186003)(33656002)(52536014)(4326008)(71200400001)(83380400001)(7696005)(478600001)(9686003)(86362001)(122000001)(316002)(26005)(38100700002)(6506007)(66556008)(66446008)(6916009)(64756008)(66476007)(66946007)(54906003)(76116006)(46800400005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Mm5Bd2hKam11dGJ2N3B1Zk5CUWJvOHJFVWdTYTRNWGRtWWdrbEVrazFEa3hT?=
 =?utf-8?B?MisvbC82S00vWFpNdGl6dGxxQ1VQYnVObmFKK3B0SHJpdFdkd01LeTRhTmcx?=
 =?utf-8?B?UC81aFVpeDhqYkxtcEZGdThmK1dydFJ3SENiNCtpeFNQSSsvRU40Q1UyZlJ2?=
 =?utf-8?B?cU5oZUFpMEVQU21WQ3h2cFE4bHJxVHVkN1NHQVRjSDlhM045VHJqNFc0YUFV?=
 =?utf-8?B?RWs2Z3lhSjNKK0pTbmQxUndOWHhmWDBuYzd4WWFPODJhRnNjNG16dkQxaHNW?=
 =?utf-8?B?T0VYcGw0YjBpakh1NUhTWlQzZlpnVnhLR0pyTjIvV2pnTE9PZy82aFlieitS?=
 =?utf-8?B?d3pWZmV5dlhpN3dhMGg0RHVBZktKbnhHd2JZUXhzWnprcG0zVWdNbWRlR0Zk?=
 =?utf-8?B?MFoyd0F3NUQ4ejM1Z0w3S2V0UWNjdTFXYXZaUlBrUzVLSGY3S0R5K2p2MEth?=
 =?utf-8?B?ZmVmb0V4V3ZIb1ZXSlNIdkgwblhyM1RiaWNmeFQzNHREK2gyRzkyQkJ1MXA2?=
 =?utf-8?B?cURoand1eko3WVdpbTFRRXMxb1BmU3ZVeHI1c3JuRVVuTEtEc202LzBaME0r?=
 =?utf-8?B?WkZFRTQveSs2SEN1WU1KWktvWWdCaHF1QUxjTWVLWmx4clN6VWhqVklSai9U?=
 =?utf-8?B?MXYwZUJ6VlNwTHY4Zkx2YlJHOGJkc2p2Szg2UDYwd2grMk96VVVxczdUejVU?=
 =?utf-8?B?M3ZZQzBFNVgxLzdpVDZETEREWWlERnc2Q0JGQnFSck9uOC81M3R0T3VpdE1S?=
 =?utf-8?B?NHFLOGI1bjN4YmVSUGh0d2NkWFJKSkV3MnZiRDFFVDg5b0U4eUgwT2hyMjJh?=
 =?utf-8?B?T0RJb1ltT0xXemVlcXpoUU5YL0w3eUFZWDJrc1RSaE95U3BRdUg2eWplZzEx?=
 =?utf-8?B?M0U3SkZPc3lJaUJPTUhYc0NRUmR6OHluVVRabnlZUEpxcHRSLzRSZXB0djYr?=
 =?utf-8?B?cHpCM25Td2pjdi82VUxlUFl6UDd5S3d6MytCRFlFWnFBQUxMU0g0WGlPWWlx?=
 =?utf-8?B?VE1WYW91TGUzQzFUcHhOWTFMWnpXVTVUZG5aaTRNSldOOHJrczh0OE1nUy9t?=
 =?utf-8?B?N3dpQTVYU1VHODVwWXdyb0tSOGtoVm42bEIzL3BETnRYSFB5VFhoSVRCVEdz?=
 =?utf-8?B?M3BIdjExcGV1aWtXOXN4bW51eWNKbVpoU3ZiNnFlUnRRSm1takdNcjZRd2hE?=
 =?utf-8?B?akFZUFNVcUt6UlpRSlhaWUtmODJoYzEydjAwK3hYWkoyT3JlL0lyT3dmeXBD?=
 =?utf-8?B?UjJuSDFOQzJ2cW00Rk4yMGdYT1ZpT0RONm9UNnhoU25DQmI1b2cvY1QxYStG?=
 =?utf-8?B?QThvY3N5L3U3Q29Ia2loeTNSM05iamR5dXBTWG94WEEwUU4wMVdLampRZGhy?=
 =?utf-8?B?YlM4ZmtYYk8wQUtZeWtCeUdyenpyZld1a09mZFJtcmhPaHNyU3d2Tkpyano1?=
 =?utf-8?B?Wkk0MGh5QmloSVdFQS9kQjlEcndSY1QvamR0SFFFVVRDZmhiTk1yWWhQVHNH?=
 =?utf-8?B?RGxBdHlGMzdxd29HcUNnUStRZVRBalR5bmxrSjNGa3YzcS9LOTlzWWdLT3gz?=
 =?utf-8?B?UURLZEU3bFV4ajR4SmQ3RS8zL0FLRHY5S3BrNWV0VXRlSVh3aWtScTVIaTZL?=
 =?utf-8?B?Q2g5VjZlUEI1T3QvZC95NzlkQTdHKzg3TDVPNzZvV29Wc0tEUi83SkhBdThW?=
 =?utf-8?B?TkZpQ0NPQUpPU0VpUk9HaG4vMDYydEZPSksvQ1d2UTFueU1CbFZpUG4weEx4?=
 =?utf-8?B?VVgvdmVlS2VoMkNDRVVqQ1pIbjlKNTg5amZFeEFDWGpGR3FJd0hMZEw3VTk4?=
 =?utf-8?B?Nmc4VmxhbHNYN1A2MmZkZXlpZEFqK2F2OU5pd3c2aXA4bFRlU0F6TEFjcWM4?=
 =?utf-8?B?c1oreWJFVEEzV2pUQ2xneFNuMmlsR2xhalY4bUdQMnIzNUZwZi9MRCtnVlkr?=
 =?utf-8?B?Z3loUmxxS3hLaEZzd1IwbGZNMG9xMXdZR2UybEUvZzZ1MXdwcmRobk9NTEVC?=
 =?utf-8?B?OVFIUzd3anBjZmtQVHV2d2VodEZUdTMyZVduMjRqbUdVMCthUnVaZnI5d2FO?=
 =?utf-8?B?cTg1cEtkR0RpZHJHVUMyYytUeS9INzN5SFNDbjZPaGV1a0VmYys3Y1UzSTdB?=
 =?utf-8?B?Q2c2UEowdmhZdlc4akM3RVZ4ZTQ3R3hwMSs3R1EyRnVTQSszbzI5WkVycTlJ?=
 =?utf-8?B?bXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a82cd68-8551-4ff3-321e-08dabceba827
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2022 16:02:35.0667
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kd3hqaTa4mfVRtqDCma8HCH8baajyJB5MfWWCjClGuI5g3l6o4chQ/dpRfGo6w3lVI177xMezPKct6NPFino5HhT99dC8LItSkCwcOphbmg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5807
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDIvNF0gcHdtOiBBZGQgQXBwbGUgUFdNIGNvbnRyb2xs
ZXINCj4gDQo+IE9uIFdlZCwgMiBOb3YgMjAyMiBhdCAxODozMywgQmlqdSBEYXMgPGJpanUuZGFz
Lmp6QGJwLnJlbmVzYXMuY29tPg0KPiB3cm90ZToNCj4gPiA+ICsgICAgIGNsayA9IGRldm1fY2xr
X2dldF9lbmFibGVkKCZwZGV2LT5kZXYsIE5VTEwpOw0KPiA+ID4gKyAgICAgaWYgKElTX0VSUihj
bGspKQ0KPiA+ID4gKyAgICAgICAgICAgICByZXR1cm4gUFRSX0VSUihjbGspOw0KPiA+DQo+ID4g
V2hhdCBpcyB5b3VyIHVzZSBjYXNlPw0KPiA+DQo+ID4gUFdNIGlzIGNvbmZpZ3VyZWQgYnkgYm9v
dGxvYWRlciBpbnRpYWxseT8/DQo+ID4NCj4gPiBPcg0KPiA+DQo+ID4gUFdNIGlzIGNvbmZpZ3Vy
ZWQgYnkgTGludXggbm90IGJ5IHRoZSBib290bG9hZGVyPw0KPiA+DQo+ID4gT3INCj4gPg0KPiA+
IERyaXZlciBuZWVkcyB0byBzdXBwb3J0IGJvdGggPz8NCj4gDQo+IFRoZSBQV00gZGV2aWNlIGl0
c2VsZiBpcyBjb25maWd1cmVkIGJ5IGxpbnV4LCBidXQgdGhlIGNsb2NrIGl0IHVzZXMgaXMNCj4g
dGhlIHN5c3RlbXdpZGUgMjQgTUh6IGNsb2NrLCBhbmQgdGhhdCBpcyBjb25maWd1cmVkIGJ5IHBs
YXRmb3JtDQo+IGZpcm13YXJlLg0KDQpJIGp1c3QgYXNrZWQsIGJlY2F1c2UgeW91IGFyZSB1bm5l
Y2Vzc2FyaWx5IHR1cm5pbmcgb24gdGhlIGNsb2NrIG9yIGluY3JlYXNpbmcgdGhlIHVzYWdlDQpD
b3VudCwgZXZlbiBpZiBpdCBpcyBub3QgdXNlZCBieSBhbnlvbmUgZHVyaW5nIHByb2JlLg0KDQpD
aGVlcnMsDQpCaWp1DQo=
