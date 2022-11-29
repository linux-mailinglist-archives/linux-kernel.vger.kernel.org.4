Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2B763C8C7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 20:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236277AbiK2TuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 14:50:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236132AbiK2Tt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 14:49:58 -0500
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2043.outbound.protection.outlook.com [40.107.105.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C385B42;
        Tue, 29 Nov 2022 11:49:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fUcxLQ6s7e8I3vDrlbrRu9CRRQoEGRQspIuFwODdI9A7y6S1Nt1Csq9UeGnDqr/o/qlCDQhlHJZe5cGV2jmyX2lozu41cW0t0bWNZh3fb3y5h89OcMhauoEdrbiWUhGFs5y9Yoj55SvOBrBCII4gEDurIKRN3YN52NcTg0yovIFaSQgfLBAVCp8X8H4LIOPzjKQX/wedURm107wxg8WGMLeaaupCebfGFo0orLAI5KB6KD7zE4CNM6MnpmARHyh3ZXjCYHnrVAmx8fGlZUNFtkGjJqpjPZHp1HZN1stBWmueNGC7sPVSFLO4a1boXYcEdp/2Ut7BNR8/xXlqu4pSJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ljgDa1rheopKppOrYLNijjJgssexG02gbnj2id2wxb4=;
 b=CDSbr7Be2IVGbFfZn+tCa6D00+0i9rXhj5J1E7djsMGr5sb+m9l1QuKyDw9RACywpyPR8856olNthcTD4hifyBJK1laDiNTHDH0YUHLzPE6+WGQ/61qEnJRuYpD/f/YzkSQQTCT/q85u2WMXBpVAY4SbGMAu/c2ssP7KoUG85trTsLMiyhdNydMtaW6skEKStVVWuW74GbidNtkYYMTM/PLZ6UXkqSKlByg1xap9RxFHyIfP92LoFDGiWcGM7t6CikGzjWCLSba1k29y5QA55Pul6btU4Cp0JO6ftFOEUO0rZGXM/j+0gIae0h3GiYv9Y6uCNE9RgQ4jGoW6aUTF2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ljgDa1rheopKppOrYLNijjJgssexG02gbnj2id2wxb4=;
 b=I+pnoU5dIqjzioqmf+TeoubAuRxClmY14ewZIC9NzswnnDiq5PiMe986mhSmlVGKpM7t3dIvUcR+2utZGLUWoh6XHLlkQEDgqM8MUv1t6dOiDjRYQ2+ebGFIlIGGyQxQmkARuMBVac5jcFGzlHLcNHEIlyOA5ec1J3Y3WZHqskY=
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com (2603:10a6:3:24::22)
 by VI1PR04MB7199.eurprd04.prod.outlook.com (2603:10a6:800:11d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Tue, 29 Nov
 2022 19:49:55 +0000
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::203a:e5da:a4a:7663]) by HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::203a:e5da:a4a:7663%12]) with mapi id 15.20.5857.023; Tue, 29 Nov 2022
 19:49:55 +0000
From:   Frank Li <frank.li@nxp.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Bough Chen <haibo.chen@nxp.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "open list:NXP i.MX 8QXP ADC DRIVER" <linux-iio@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
CC:     "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: Re: [PATCH 1/1] iio: imx8qxp-adc: fix irq flood when call
 imx8qxp_adc_read_raw()
Thread-Topic: [PATCH 1/1] iio: imx8qxp-adc: fix irq flood when call
 imx8qxp_adc_read_raw()
Thread-Index: AQHZBCvAnPKdihzbs0Sge0KlijZkQg==
Date:   Tue, 29 Nov 2022 19:49:54 +0000
Message-ID: <HE1PR0401MB233162590D56093385AC4CF888129@HE1PR0401MB2331.eurprd04.prod.outlook.com>
References: <20221129164531.2164660-1-Frank.Li@nxp.com>
 <bbacb73a-6904-d196-ab4a-3e388bcab56c@metafoo.de>
In-Reply-To: <bbacb73a-6904-d196-ab4a-3e388bcab56c@metafoo.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: HE1PR0401MB2331:EE_|VI1PR04MB7199:EE_
x-ms-office365-filtering-correlation-id: 262e0f65-97b9-4708-fb2b-08dad242e35c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y5PtgIOxJEcHVQo9F9xOJyjtvGVNrMI6Jjnyb+9BoU+dpJ9/s2oHv9W1thLWpZFrKlCkhkVO6w7H7XJltjdyERDl7r0Scb/L24noHv2iNN4KnLawog6Y3SO5G8LB0wV3GkuwhSjI4Nu8VX1M4yb/83IAh8YyJt4IbJdh1rsRrvt97H+UTUhcyCCCgH9pgQpuT6Zr3uQRjBUnSHpSWIpjBcbsTIEPMIaWw7yhaDVV/Tsk99Cg/eSu9xfNGPBr4+MgwaxnxmzQJNaCq/fjsChVkpv4vhrLyjdTaHmrygjC+mjFsXZeLw9JKggUuYdEiMyOK2nD23CabQM9efejIelVqd59GuqwCgpQh/Q6G7zInhLDAWH/HPyNRzWLDxjIHzWdUhuFjzzeHcS/+FoKb8v1Ekc0fBv+fhBYcikqG1A25g6hKzYpk9U4mC+52sVLt8HRqEVMD6oyTcAlL5eY9ak3ECltk1o5k3713pfONDMxR6gqwxAQa9s+M0un+fpugJUhpYcjxo9h2XOMz1qOJqhGLqTb3Ul7Gz2VisvICT/NuMVAmhT2YY5arl0hv4XzuodmgTFvdPHNhhmrXmZbwyZ3MCuuom5LJDUBPYSpPKDpffu3jHPu0ChX6+Qlsjtc0UHcxyeZJreVkmIAbEaReA+xXgVdm3CUwJVNN928WAk3G78j/HsiATuN7ZmSwiXFW+8u3oNJAUTUNHemrbRE3y2KVMMPZJsMZmCB8JK1p/RlEqc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0401MB2331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(366004)(346002)(376002)(136003)(451199015)(52536014)(38070700005)(6506007)(33656002)(921005)(86362001)(55016003)(9686003)(53546011)(55236004)(66946007)(64756008)(41300700001)(66446008)(186003)(66556008)(8676002)(76116006)(8936002)(4326008)(71200400001)(26005)(478600001)(66476007)(7696005)(316002)(110136005)(122000001)(83380400001)(38100700002)(44832011)(4744005)(7416002)(5660300002)(2906002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L0JOSnVCR2ZFYUlyUkVpdmM0eC9vWjM2UTh1dGJzTC9tNU1BeC9lUFlJVHov?=
 =?utf-8?B?d3dIUVJxQlhYL05vbnNTd2NpeVdndnNURTBNcWpubFdkaldvcnk0dnZqbXZG?=
 =?utf-8?B?b0hNdklMMkpWaElIUW9kTEQzOFFYWVN3ci9HVWpWQlZVTWpnY3RraVVmYkh2?=
 =?utf-8?B?TElHMkRmRXdrdmd4ZTFYUlAvL1k3MzB6T0g3dzhDN2lBU0xQOG5xa0Q4KzMx?=
 =?utf-8?B?UjQzSHhVUzlVa3VGa2xpVDlWRDJsRUt3UGZ1Q2lEM3J4WmRIaXY3RE94dWd3?=
 =?utf-8?B?UlZhOHhYT3ZXZ2xEUHROYXNLNW1Zc05SekFqclBZS2IrTHhxYmhGL0NRMGxl?=
 =?utf-8?B?dFptUHNENG9YUmJId1BiU2tkYzRVcEFsUUlHaTd1TXRuY29zR3VuVGJrSlZh?=
 =?utf-8?B?ajJqM2JBYThiRFZyUnp2RVYvdzJTYktPQTNHU1loSE94NGVQY1RrbkNRZ2RR?=
 =?utf-8?B?N1FtODMvcmJTQkZqSkYwWHBkSFhiZ2JvMHB2cE0xcGR6S2lhbkFNYldMLzQw?=
 =?utf-8?B?MmQ4ODdEaDFFNUc3ZDBrajNia1hPQzh0eUpVMjcvUmZKQS85d09ZUzNRQU1n?=
 =?utf-8?B?WnFJNjc1Vjg3Z0M0R2tLd29GNFhwMDVNQ2o5NTU3Tzkzdk16TXdHRVIzRDRi?=
 =?utf-8?B?NmlyMDc0VzQxdXpGa0x5Yk9Ja3l0MjQyRk5GVFRkL3haVU1QY2N3d2hSTzBh?=
 =?utf-8?B?S3ZzY3ZvcDl4WHpwNlRwVjFvL1A2N2Q1SWJvR01nOXF0UENjM3FSZFRQQm5u?=
 =?utf-8?B?bDlzbml2RFpkZVlwenBwZ0U4TFFleklacjBnZmN3NnFEMWxhYVY1dmltM0U5?=
 =?utf-8?B?VisxSHEyUXVpVGNRSTVscGE0anRITnAzcVQ1d3lvRlZHMENDSnZWREYxM0dE?=
 =?utf-8?B?eVBPYUxpa0FOSFo4a0dJQ3JuYzREV2pmYUJ6L1RsUWdUdzljSDhtZ3hBdE5S?=
 =?utf-8?B?V2drazRUZTVFWWdPdXFYalpaUjFJYzgvWVFzSjczYmg0dWJNdTVMTEhlUngw?=
 =?utf-8?B?N3VDNW9aVEU1c3R4T2FBZWU2UmtEK2JaQzFubzRFZkR2M2RMTksyZnNwamRy?=
 =?utf-8?B?WTlwMFZzVEpTM0lVOW45Z3JaSkViMlFWZFhZSmpkMXR6dzRpSThrT0VCTWVU?=
 =?utf-8?B?RUhNcjh1Q013T3Z0R2s1UHpMeEtaWndsRFdseWxqRGlNTEhVUXkzZytFeTl3?=
 =?utf-8?B?RmNIczArTWduTTdUSytMd3RJUDk5Y0V4NWllNEhyR0s1d1orekhwQkpaT2Yv?=
 =?utf-8?B?MkoySGJaaGJEaExMaS9wM3R5dHlyNm5ta1dXbUZYY2hqQ2VHMDNPT3NlM3hI?=
 =?utf-8?B?NVpaVEZwQmFBZUVEcHd2TkhBcFBOQlJDTXBiWW5WWE1LM1g4S0NrbENxWlhy?=
 =?utf-8?B?M2hhS3ZzQ1hsSTVwWHpjaDQzTWEwWER3RlgvUEdZUXhjNTN1djFoRUhUWFdE?=
 =?utf-8?B?ZksyUEZwMmV5Q2tEYjNVb0MzUjZKaWVOTDBCMHMveWxNQng4d0RDMmhUb1J3?=
 =?utf-8?B?ZjRxSm5iNHJDWDVYZlc1NVVCMWF3aWFQMGJoai9oNXRRQ0plQUtMSklxdlhy?=
 =?utf-8?B?eHRRdUdXZ3FSWHczUFlCZ0ZvT05vZWp2djJLeDRVWEx5SWt6ZFZ4Z1VvT0NX?=
 =?utf-8?B?WXpWWjBzOGEyb244L1pYOUMzNDF6SVdla2l6VDJxaEF4a1JIaWUwd2tHMjJT?=
 =?utf-8?B?dmoyc0VQZytLN2RoaWwrQ3VVOTlHNGVINytsSUpzcGErTjZTYlIrVTNob2pz?=
 =?utf-8?B?emJEbGw3VXpKeEF2ckdmVDdFbmp5S3hEWkd3NkJoYUtKMVl2VzlQUkh0eTVi?=
 =?utf-8?B?Y1NSa0R2TUR4ZGxnVGI3T0piYnU0cWt2S3ZJeFp2YmhaLzVCTFg3NG1jZTJY?=
 =?utf-8?B?WkJaUkhhaDlHMlMzVmtTUEV1Uy9nRVkxT3M1Yy9nK3ZVQy92WFhFSzBhOUJq?=
 =?utf-8?B?Z0JHS2tJUkx5NVovVTEwcWJNS3RUYTRLejZCcWNZRTc1RWp5SkRlckVGcGIr?=
 =?utf-8?B?NzRER1dEcS9YOWp5Z0NXaU9nSElWWXVVVWtPb2VkRjJ1ekcyYjFBN2xpTFNv?=
 =?utf-8?B?cWgwN3gwckM0OUdXcHQ1ZGVCWXhQMjQycmlZZkxRMjZBR0tXVENtL0RMWGxZ?=
 =?utf-8?Q?mOd0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0401MB2331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 262e0f65-97b9-4708-fb2b-08dad242e35c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2022 19:49:55.0386
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5UpARicugVHDQPYkzXZWkNvtjVElGHYH3WsW7IT5tX/zt05myFSffDmpgzyUBqN8IFeiFTWUHWA5z5r1K4is0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7199
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IE9uIDExLzI5LzIyIDA4OjQ1LCBGcmFuayBMaSB3cm90ZToNCj4gICAgICAgICAgICAgICAg
ICAgICAgICByZWFkbChhZGMtPnJlZ3MgKyBJTVg4UVhQX0FEUl9BRENfRkNUUkwpKTsNCj4gPiBA
QCAtMjcyLDYgKzI3NSwxMCBAQCBzdGF0aWMgaXJxcmV0dXJuX3QgaW14OHF4cF9hZGNfaXNyKGlu
dCBpcnEsIHZvaWQNCj4gKmRldl9pZCkNCj4gPiAgICAgICBpZiAoZmlmb19jb3VudCkNCj4gPiAg
ICAgICAgICAgICAgIGNvbXBsZXRlKCZhZGMtPmNvbXBsZXRpb24pOw0KPiANCj4gU2hvdWxkbid0
IHRoZSBjb21wbGV0aW9uIGJlIHRyaWdnZXJlZCBhZnRlciB0aGUgcmVhZGluZyBvZiB0aGUgc2Ft
cGxlcz8NCj4gb3RoZXJ3aXNlIHlvdSBoYXZlIGEgcmFjZSBjb25kaXRpb24gb24gYSBtdWx0aS1w
cm9jZXNzb3Igc3lzdGVtLg0KDQpZZXMsIHlvdSBhcmUgcmlnaHQuIEkgd2lsbCBzZW5kIHVwZGF0
ZWQgcGF0Y2ggc29vbi4NCg0KPiANCj4gPg0KPiA+ICsgICAgIGZvciAoaSA9IDA7IGkgPCBmaWZv
X2NvdW50OyBpKyspDQo+ID4gKyAgICAgICAgICAgICBhZGMtPmZpZm9baV0gPSBGSUVMRF9HRVQo
SU1YOFFYUF9BRENfUkVTRklGT19WQUxfTUFTSywNCj4gPiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICByZWFkbF9yZWxheGVkKGFkYy0+cmVncyArIElNWDhRWFBfQURSX0FEQ19SRVNGSUZP
KSk7DQo+ID4gKw0KPiA+ICAgICAgIHJldHVybiBJUlFfSEFORExFRDsNCj4gPiAgIH0NCj4gPg0K
DQo=
