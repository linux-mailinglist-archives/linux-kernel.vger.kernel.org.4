Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE94C6402CD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 10:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232696AbiLBJCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 04:02:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232865AbiLBJBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 04:01:51 -0500
Received: from mo-csw.securemx.jp (mo-csw1516.securemx.jp [210.130.202.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78467C7706;
        Fri,  2 Dec 2022 00:59:19 -0800 (PST)
Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 2B28x2CW006852; Fri, 2 Dec 2022 17:59:02 +0900
X-Iguazu-Qid: 34trdMalR7brPJRuLU
X-Iguazu-QSIG: v=2; s=0; t=1669971541; q=34trdMalR7brPJRuLU; m=nLzmPchtsAICdRQBvo8iI26jKvI+ur1ueiEXkxH05/M=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
        by relay.securemx.jp (mx-mr1513) id 2B28x0Yf018015
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 2 Dec 2022 17:59:00 +0900
X-SA-MID: 46974225
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lWsQnCHQNS5ffrP2at6VyCdXX3xPH5WvWBHGBUFKlgFrQT90PTH+X9Iwb6C0n8HbU8agZAcMF7m72LDm+l3iRJInKynuRNgMTdCPnOzcqj+CKen37C+4Vbhqe/g3cIrONE2pZH2PCBX5GMTFi29Zx58KfnWWjg74wX1bXYbo1RxtXF1TSqRLsgsKmYqK9e05CJa46OYq1xIj8cQrZVJJBTdrK10J7HCu99d6EPmfzvTuJJvh38dUTmYfCRWy2LO9EbZpUxj1hMpI4l2LmV0VxFUzfmeCVWL/d8S1zSrX7KJq1082VG5who0eMTV5YyB1C5bXWm3nDNJL1AYTc1+kWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I3CKnf5EIBE+4AKa99JsJm8tF5kCF2w02PM1in7vOgs=;
 b=fhGGnrahpZVTXFo6w8tftyZegFIm2EODIqGwnxKAjVn7Dm+XiH3mPWaBuOQ6BkbfFK/cyx9NL9Ez2pFmf74bB/d+3w7xNHO9USNt9uqkhHshWzemiRQSw3LcpG1X/CkU6QQrNY09H1P/GfJsG1H2o6lfuUElMRRUhLB28aUnBSvy0iSuTzlDHakXsEguQPLtCm0m/xU0G3cBeCspfjiCVCpDlTpDwA9m6j/Gl/bjbUW4e1FWZXSYG3X537m8uhRH1ENzNecL7M6xgTE7DQlTsBbmLjBUhtnu3fmdW1ls0Ad1L9/jVU3z7IEcAQFscYT3vdaIbBUM08geldnU3xfoxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From:   <yuji2.ishikawa@toshiba.co.jp>
To:     <hverkuil-cisco@xs4all.nl>, <posciak@chromium.org>,
        <paul.kocialkowski@bootlin.com>, <mchehab+samsung@kernel.org>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <tfiga@chromium.org>
Subject: RE: Question for an accepted patch: use of DMA-BUF based videobuf2
 capture buffer with no-HW-cache-coherent HW
Thread-Topic: Question for an accepted patch: use of DMA-BUF based videobuf2
 capture buffer with no-HW-cache-coherent HW
Thread-Index: AdjnXTbTKaza2ljVTOuz35R3VQs17wAH+O+AAGOERzAHG16ugAAn4Vxw
Date:   Fri, 2 Dec 2022 08:53:52 +0000
X-TSB-HOP2: ON
Message-ID: <OSZPR01MB619702A81F31DCED772B96E592179@OSZPR01MB6197.jpnprd01.prod.outlook.com>
References: <TYAPR01MB6201561D2644EE783BA8B196922E9@TYAPR01MB6201.jpnprd01.prod.outlook.com>
 <b645f983-447b-7b4b-6dd6-d5f10da08e96@xs4all.nl>
 <TYAPR01MB62019A8DD1215F41F0FE663C92309@TYAPR01MB6201.jpnprd01.prod.outlook.com>
 <20badb75-65c7-719e-ab93-28e6b5e97f22@xs4all.nl>
In-Reply-To: <20badb75-65c7-719e-ab93-28e6b5e97f22@xs4all.nl>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB6197:EE_|TYCPR01MB8239:EE_
x-ms-office365-filtering-correlation-id: a8aa144f-da0d-422e-acce-08dad442bcea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S/7FOu6d9FBuXXjG1XxTpfDVkeLp4qWwRYG9HNdOr0wHrWxcDG+GGVp6/vXMqF3BDo6tIE8v1LlsPdRSvuzfK3GbVqZFOIy/0Oi/DlNljMB+ByYacbb++vDp2hya5ncKBgdj6sJguheTgsYuwfAnNw/34A3KqItgU4U99GIgUQR6RXYTGzTeboQu0pjW/xF8hB/dAWZBiCac9QfyTPSWDH8hUAOkjJw2l1qezqKYyGtnPaJj/96UrdnnrKQFg0rY4cbockwdeh1w8aCjn/TMM1vBix1W90Dl+96nHt1CpKIIUdYAh4MAUX9aNiA9bB9rRFxILyUBw3e61yd+SMd/rwIuA0YEWYDAM7l8ee6Rcs+/fAqQ/t3wYU13eN0rGLTTaCqFK56wd1X+yxoqMPazl3/iYpV3s4b+L1/2G7qvPNdAXFeSsL1J+8/Xfru4ZbDjuwKswWZd68YBAGnUiDIvAkf3/Y+y0upRSejn29Q59hdw+U3J75aV7wO0bMBUvmqItkP/a1ThVhX2wdxhfjhYQJSJsCl2yASrH7hYO2ex9StT+WglVryFRUYhj0L1LOQhjl4noOsY9Uj8pfsq6/iqHms8PgHDjfIRQgO4bfVbAyTkg04drvtI5BDsWZTS/j4ipU+ptO5VDh7sCD/6c0CECQoDVCYRI0s1Lo/J5pJjujwHwrEVwur5nNM7B0jk80xY/DfbnDoFi5XMKO4WsFwHjKQughhbOIrVqqJOb1Ge/Kk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB6197.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(376002)(366004)(396003)(346002)(451199015)(7696005)(53546011)(6506007)(966005)(186003)(26005)(316002)(478600001)(9686003)(110136005)(64756008)(8676002)(66446008)(76116006)(66476007)(71200400001)(66946007)(66556008)(41300700001)(8936002)(52536014)(5660300002)(2906002)(83380400001)(55016003)(86362001)(122000001)(33656002)(38100700002)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dWl5Q3RMRXZwREEzbjNkTDZBZC90cE9aK2dPd09tSVVhbzFPNkNTWDFrNW54?=
 =?utf-8?B?QnYzQXIxUy9zQ0JBQk1SQ1Z1SU5FRWlOcm5nSmpuVTVrRStLd1Y2Y3QyZ1dB?=
 =?utf-8?B?RWM1eVQ0U01zMnAwUDg0aEs4TnNMcVdHSzgzNjNML2xWS3dtVktqL0tubXk2?=
 =?utf-8?B?UzhFSTROWUlMUGNXUjRrRjduQ1JUSFFCYXZ5WW9LUUdjdDZRY0lxa3BoU0pS?=
 =?utf-8?B?Mkx2enovdzFUOTRxajJjbjNsMm9Zcm5lOUlNTVpodWRrTElYQmwvdTdicDRt?=
 =?utf-8?B?MytmVjJrSlM4M3lpN2J6azVza2xFOURKTStMUHVwZDdQRlRDd1pJK2xOUVNZ?=
 =?utf-8?B?SUNQOUNUZ3gvRWJBaHhYTkVpc1lNNG9rT0syQjBYOTBBNy9uRng5VHdXbDdN?=
 =?utf-8?B?cmIwSnBuaTE0WFo4aFh5bmdZVkxlT3V2Um5aSWxXVzVMKzVwZDdpZkpQWCtj?=
 =?utf-8?B?NG4vVVZMcWlvQWwyZHJXdlhJdndSTXJRbkVvQ1MySFkvdWdra3dKTXg2ZVQz?=
 =?utf-8?B?K3g5Q2VrRUdoUzFoNUI4QzlLWEJRdTlDNXZudGlZTTM0ZzBPaGZzblByR1gr?=
 =?utf-8?B?Znhza1drbTNNVUtEbjVDYkw0WTU1WGZlNjA0enl3LyttNDBZR3l0T0p5SFZz?=
 =?utf-8?B?cWxZQWZtU0RpU09wMTJxV3dGUWNVRjZjWk90ZHFjVEdod3R1dU9XdzRCbUw1?=
 =?utf-8?B?UDVsVlJrNEZQbnlNM3FEQ2Vzc1UxVVh2UDNDT0g2UW0xUnRrY1pmVGdzaDlX?=
 =?utf-8?B?cnlkS2drdGw1bmtHRDlBdEo3YTR3Z1BiQjVxbVR5OTJ5SGJKbi8yNnNOTmRN?=
 =?utf-8?B?cVlYdkNLcjhtV3UySjU0RTZrR2hNWS9FNm9oU2tVRXNEZnJza0JPSzUwY2cv?=
 =?utf-8?B?bW9uSXg2RCtxQTRvNFdVdjZGN042MzVOOHFReUhUSVd4bHFUbXVubkNaVm5E?=
 =?utf-8?B?VUVHTnZSQ0wzelh1UEJ5Q2pjTnowZjU1RGRHdldWQ1pUNTYxamk4QWNEZTdr?=
 =?utf-8?B?TnVMQ053ZEdGTTZCbk5zNCsrdXovcGtuYzdGU0F1SjJ5cmZ6RUduSGt4dDRJ?=
 =?utf-8?B?TUxVaEgraXloS3RzUm9Jd2lwZG9mUUowdUV5TnQ2aFlxQ0Z6eTJPaExtVFVZ?=
 =?utf-8?B?ZXVMdXJVSGhoRjlkTysrL3NrUXpWelIzTVAxQ0JiczRDMlVLZHorMzNLbUIx?=
 =?utf-8?B?a24zeTEvd2pzVG91U3dMN0tGNmtreENLNm45bHd6QU5Ra3NuSUZPbS8vNXB1?=
 =?utf-8?B?dm1BYlB3M01vNDBVTy9XMWIwWHlGNGtKMnV4OUgxQVA1QkJGK2k4Uzd4UERy?=
 =?utf-8?B?anR6b0YrcUpnNFp5YTNGRGhkd2ZPM1lBSEt6NURla1RTNjNaTzl3bWhCOHlS?=
 =?utf-8?B?TkRLQy9tTFlGSm8zOE9sVkZQN3E3SGYyTHB5bmZ3OG1WZDJhZEVmaTdyWVdP?=
 =?utf-8?B?ekpZUEVJcGJlN1l1UVN2WlZYNkR3VTN4WHkzQU9Pb3QzNFhLNVRuWGRkei9C?=
 =?utf-8?B?aU9Wc2gwZVJ2UVljZER6YStuNmN4Q1JBc3AweTRTTWFzZmJxL0ZiTWxzazJm?=
 =?utf-8?B?RFVXbnRSdTBpM3cwVGR1Znk0MlpROTc3UlcxMTNjNWVCNzdMeWNRZ3UxSlRj?=
 =?utf-8?B?MGF2T0R1czd4Z1hEeXpHLzFZODhGSCtocEoxZXA3MDZ6dVY3R2p6bXl6Sk9R?=
 =?utf-8?B?ZkpyTk8vNWdOUGJuRVBjS2xZbkFjRVVGMlBuVlY4UWczV0Z0aHZMMXJtUXp5?=
 =?utf-8?B?bGpMSW1kdnNGRTBEemlhRUlpOURyT0RmbWZja3I3empPQk1tdFowR3BISEpG?=
 =?utf-8?B?T0h1RVE5UXBvVllLdEduQkpyWmh2ZlkrUExaVVJJMnBIV3J1VGtXL2tFcXJy?=
 =?utf-8?B?a1lGSHgwUVNacHZadGU0eE1Td2VpMG1OZUNSZzNldzBDTVVoUWMrVHd2dDJN?=
 =?utf-8?B?dzJmbWg2b040RFZJL0VVNWZtM2tsS1JpM0hHaGV1cUFGclpXN2xCbUFKaXIx?=
 =?utf-8?B?cktDQzh1cmRDRldFNU5TQjJsNDY0RklZRDVydlRaOE9tU3lvSzFvTWl5SjdB?=
 =?utf-8?B?UzRBa0NoTDczYTBVSi9aUmhQaDZhaTZ0V0Y2dnBZQ2xZSVg1SHFvcjFHNk4y?=
 =?utf-8?B?WGRBMWlEekU5bEp0VXJCT3pUaEJJWkpwcEsySjFOQjdzcG5FcVMvTXhqK3Jo?=
 =?utf-8?B?MUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6197.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8aa144f-da0d-422e-acce-08dad442bcea
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2022 08:53:52.8460
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kwFvN2xVl5pPolyNFoP/FXi5hPgdUX4O0OmP797o7mJ/iI1MUbXwApi0BHcmmKFuwcIgrO4Mwy5UFs0EkieOqTGEo7U2elcicgL5352JJhM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8239
X-OriginatorOrg: toshiba.co.jp
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSGFucywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBIYW5zIFZl
cmt1aWwgPGh2ZXJrdWlsLWNpc2NvQHhzNGFsbC5ubD4NCj4gU2VudDogVGh1cnNkYXksIERlY2Vt
YmVyIDEsIDIwMjIgODozMyBQTQ0KPiBUbzogaXNoaWthd2EgeXVqaSjnn7Plt50g5oKg5Y+4IOKX
i++8su+8pO+8o+KWoe+8oe+8qe+8tO+8o+KXi++8pe+8oemWiykNCj4gPHl1amkyLmlzaGlrYXdh
QHRvc2hpYmEuY28uanA+OyBwb3NjaWFrQGNocm9taXVtLm9yZzsNCj4gcGF1bC5rb2NpYWxrb3dz
a2lAYm9vdGxpbi5jb207IG1jaGVoYWIrc2Ftc3VuZ0BrZXJuZWwub3JnOw0KPiBsaW51eC1tZWRp
YUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IFRvbWFzeiBG
aWdhDQo+IDx0ZmlnYUBjaHJvbWl1bS5vcmc+DQo+IFN1YmplY3Q6IFJlOiBRdWVzdGlvbiBmb3Ig
YW4gYWNjZXB0ZWQgcGF0Y2g6IHVzZSBvZiBETUEtQlVGIGJhc2VkIHZpZGVvYnVmMg0KPiBjYXB0
dXJlIGJ1ZmZlciB3aXRoIG5vLUhXLWNhY2hlLWNvaGVyZW50IEhXDQo+IA0KPiBIaSBZdWppLA0K
PiANCj4gT24gMjYvMTAvMjAyMiAxMToxNiwgeXVqaTIuaXNoaWthd2FAdG9zaGliYS5jby5qcCB3
cm90ZToNCj4gPiBIaSBIYW5zLA0KPiA+DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+ID4+IEZyb206IEhhbnMgVmVya3VpbCA8aHZlcmt1aWwtY2lzY29AeHM0YWxsLm5sPg0KPiA+
PiBTZW50OiBNb25kYXksIE9jdG9iZXIgMjQsIDIwMjIgNDo0OSBQTQ0KPiA+PiBUbzogaXNoaWth
d2EgeXVqaSjnn7Plt50g5oKg5Y+4IOKXi++8su+8pO+8o+KWoe+8oe+8qe+8tO+8o+KXi++8pe+8
oemWiykNCj4gPj4gPHl1amkyLmlzaGlrYXdhQHRvc2hpYmEuY28uanA+OyBwb3NjaWFrQGNocm9t
aXVtLm9yZzsNCj4gPj4gcGF1bC5rb2NpYWxrb3dza2lAYm9vdGxpbi5jb207IG1jaGVoYWIrc2Ft
c3VuZ0BrZXJuZWwub3JnOw0KPiA+PiBsaW51eC1tZWRpYUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gPj4gU3ViamVjdDogUmU6IFF1ZXN0aW9uIGZvciBh
biBhY2NlcHRlZCBwYXRjaDogdXNlIG9mIERNQS1CVUYgYmFzZWQNCj4gPj4gdmlkZW9idWYyIGNh
cHR1cmUgYnVmZmVyIHdpdGggbm8tSFctY2FjaGUtY29oZXJlbnQgSFcNCj4gPj4NCj4gPj4gSGkg
WXVqaSwNCj4gPj4NCj4gPj4gT24gMTAvMjQvMjIgMDY6MDIsIHl1amkyLmlzaGlrYXdhQHRvc2hp
YmEuY28uanAgd3JvdGU6DQo+ID4+PiBIaSwNCj4gPj4+DQo+ID4+PiBJJ20gcG9ydGluZyBhIFY0
TDIgY2FwdHVyZSBkcml2ZXIgZnJvbSA0LjE5LnkgdG8gNS4xMC55IFsxXS4NCj4gPj4+DQo+ID4+
PiBXaGVuIEkgdGVzdCB0aGUgcG9ydGVkIGRyaXZlciwgSSBzb21ldGltZXMgZmluZCBhIGNvcnJ1
cHRpb24gb24gYQ0KPiA+Pj4gY2FwdHVyZWQNCj4gPj4gaW1hZ2UuDQo+ID4+Pg0KPiA+Pj4gQmVj
YXVzZSB0aGUgY29ycnVwdGlvbiBpcyBleGFjdGx5IGFsaWduZWQgd2l0aCBjYWNoZWxpbmUsIEkg
c3RhcnRlZA0KPiA+PiBpbnZlc3RpZ2F0aW9uIGZyb20gbWFwL3VubWFwIG9mIERNQS1CVUYuDQo+
ID4+Pg0KPiA+Pj4NCj4gPj4+DQo+ID4+PiBUaGUgY2FwdHVyZSBkcml2ZXIgdXNlcyBETUEtQlVG
IGZvciB2aWRlb2J1ZjIuDQo+ID4+Pg0KPiA+Pj4gVGhlIGNhcHR1cmUgaGFyZHdhcmUgZG9lcyBu
b3QgaGF2ZSBIVy1tYW50YWluZWQgY2FjaGUgY29oZXJlbmN5IHdpdGgNCj4gPj4gQ1BVLCB0aGF0
IGlzLCBleHBsaWNpdCBtYXAvdW5tYXAgaXMgZXNzZW50aWFsIG9uIFFCVUYvRFFCVUYuDQo+ID4+
Pg0KPiA+Pj4gQWZ0ZXIgc29tZSBob3VycyBvZiBzdHJ1Z2dsZSwgSSBmb3VuZCBhIHBhdGNoIHJl
bW92aW5nIGNhY2hlDQo+ID4+PiBzeW5jaHJvbml6YXRpb25zDQo+ID4+IG9uIFFCVUYvRFFCVUYu
DQo+ID4+Pg0KPiA+Pj4NCj4gPj4+DQo+ID4+Pg0KPiBodHRwczovL3BhdGNod29yay5rZXJuZWwu
b3JnL3Byb2plY3QvbGludXgtbWVkaWEvcGF0Y2gvMjAxOTAxMjQwOTUxNTYuDQo+ID4+PiAyMTg5
OC0xLXBhdWwua29jaWFsa293c2tpQGJvb3RsaW4uY29tLw0KPiA+Pj4gPGh0dHBzOi8vcGF0Y2h3
b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1tZWRpYS9wYXRjaC8yMDE5MDEyNDA5NTENCj4g
Pj4+IDU2IC4yMTg5OC0xLXBhdWwua29jaWFsa293c2tpQGJvb3RsaW4uY29tLz4NCj4gPj4+DQo+
ID4+Pg0KPiA+Pj4NCj4gPj4+IFdoZW4gSSByZW1vdmVkIHRoaXMgcGF0Y2ggZnJvbSBteSA1LjEw
Lnkgd29ya2luZy10cmVlLCB0aGUgZHJpdmVyDQo+ID4+PiB5aWVsZGVkIGltYWdlcyB3aXRob3V0
IGFueSBkZWZlY3RzLnYNCj4gPj4+DQo+ID4+Pg0KPiA+Pj4NCj4gPj4+ICoqKioqKioqKioqKioq
Kg0KPiA+Pj4NCj4gPj4+IFNvcnJ5IGZvciBhIG1lbnRpb24gdG8gYSBwYXRjaCByZWxlYXNlZCA0
IHllYXJzIGFnby4NCj4gPj4+DQo+ID4+PiBUaGUgcGF0Y2ggcmVtb3ZlcyBtYXAvdW5tYXAgb24g
UUJVRi9EUUJVRiB0byBpbXByb3ZlIHRoZQ0KPiA+PiBwZXJmb3JtYW5jZSBvZiBWNEwyIGRlY29k
ZXIgZGV2aWNlLCBieSByZXVzaW5nIHByZXZpb3VzbHkgZGVjb2RlZCBmcmFtZXMuDQo+ID4+Pg0K
PiA+Pj4gSG93ZXZlciwgdGhlcmUgc2VlbXMgbm8gY2FyZXMgbm9yIGNvbXBlbnNhdGlvbnMgZm9y
IG1vZGlmeWluZw0KPiA+Pj4gbGlmZWN5Y2xlIG9mDQo+ID4+IERNQS1CVUYsIGVzcGVjaWFsbHkg
b24gdmlkZW8gY2FwdHVyZSBkZXZpY2VzLg0KPiA+Pg0KPiA+PiBJJ20gbm90IGVudGlyZWx5IHN1
cmUgd2hhdCB5b3UgbWVhbiBleGFjdGx5Lg0KPiA+Pg0KPiA+IE15IGNvbmNlcm4gaXMgY29uc2lz
dGVuY3kgYmV0d2VlbiBpb2N0bHMgYW5kIHRoZSBzdGF0ZSB0cmFuc2l0aW9uIG9mIGNhcHR1cmUN
Cj4gYnVmZmVycy4NCj4gPiBHZW5lcmFsbHksIHN0cmVhbWluZyBJL08gKERNQS1CVUYgaW1wb3J0
aW5nKSBidWZmZXJzIGFyZSBoYW5kbGVkIGZvbGxvd2luZw0KPiBieSB1c2VybGFuZC4NCj4gPg0K
PiA+IElvY3RsKFZJRElPQ19RQlVGKSAtPiAvKiBETUEgdHJhbnNmZXIgZnJvbSBIVyovIC0+IGlv
Y3RsKFZJRElPQ19EUUJVRikNCj4gLT4gLyogYWNjZXNzIGZyb20gQ1BVICovIC0+IGlvY3RsKFZJ
RElPQ19RQlVGKSAtPiAuLi4NCj4gPg0KPiA+IFRoZXJlZm9yZSwgZXhwZWN0ZWQgc2VtYW50aWNz
IGlzIHRoYXQgYSBidWZmZXIgaXMgb3duZWQgYnkgSFcgYWZ0ZXIgUUJVRiwNCj4gYW5kIG93bmVk
IGJ5IENQVSBhZnRlciBEUUJVRi4NCj4gPiBJbiBwcmFjdGljZSwgaW9jdGwoUUJVRikga2lja3Mg
dmIyX2RjX21hcF9kbWFfYnVmKCkgYW5kIGlvY3RsKERRQlVGKSBraWNrcw0KPiB2YjJfZGNfdW5t
YXBfZG1hX2J1ZigpIGJlZm9yZSBhcHBseWluZyB0aGUgcGF0Y2guDQo+ID4gVGhpcyBpbXBsZW1l
bnRhdGlvbiBrZWVwcyBjb25zaXN0ZW5jeSBpbiB0ZXJtcyBvZiBjYWNoZSBjb2hlcmVuY3kgYXMN
Cj4gY2FjaGUtY2xlYW4gaXMgZG9uZSBpbiB2YjJfZGNfbWFwX2RtYV9idWYoKS4NCj4gPg0KPiA+
IEJ5IGFwcGx5aW5nIHRoZSBwYXRjaCwgaW9jdGwoRFFCVUYpIGRvZXMgbm90IGtpY2sgdW5tYXBf
ZG1hKCkgYW55bW9yZS4NCj4gVGhlIHNpbWlsYXIgZm9yIGlvY3RsKFFCVUYpLg0KPiA+IFRoZXJl
Zm9yZSwgaW4gcHJhY3RpY2UsIGEgYnVmZmVyIGlzIG5vdCBvd25lZCBieSBDUFUganVzdCBhZnRl
ciBpb2N0bChEUUJVRikuDQo+ID4gVG8ga2VlcCBjb21wYXRpYmlsaXR5IG9mIGJ1ZmZlciBvcGVy
YXRpb25zLCB0aGVyZSBzaG91bGQgYmUgZGVsYXllZA0KPiBtYXBfZG1hKCkvdW5tYXBfZG1hKCkg
Y2FsbCBqdXN0IGJlZm9yZSBETUEtdHJhbnNmZXIvQ1BVLWFjY2Vzcy4NCj4gPiBIb3dldmVyLCBu
byBvbmUgcmVmZXJyZWQgdG8gc3VjaCBmdW5jdGlvbiBpbiB0aGUgdjRsMiBmcmFtZXdvcmsgaW4g
dGhlDQo+IGV4YW1pbmF0aW9uIG9mIHRoZSBwYXRjaC4NCj4gPiBBbHNvLCB0aGVyZSBpcyBubyBh
ZHZpY2UgZm9yIGluZGl2aWR1YWwgdmlkZW8gZGV2aWNlIGRyaXZlcnM7IHN1Y2ggdGhhdCBhZGRp
bmcNCj4gbWFwX2RtYSgpL3VubWFwX2RtYSgpIGV4cGxpY2l0bHkuDQo+IA0KPiBUaGUgY2FjaGUg
c3luY2luZyBpcyBzdXBwb3NlZCB0byBoYXBwZW4gaW4gX192YjJfYnVmX21lbV9maW5pc2goKSB3
aGVyZSB0aGUNCj4gJ2ZpbmlzaCcgbWVtb3AgaXMgY2FsbGVkLg0KPiANCj4gQnV0IGZvciBETUFC
VUYgaXQgbm90ZXMgdGhhdDoNCj4gDQo+ICAgICAgICAgLyoNCj4gICAgICAgICAgKiBETUEgZXhw
b3J0ZXIgc2hvdWxkIHRha2UgY2FyZSBvZiBjYWNoZSBzeW5jcywgc28gd2UgY2FuIGF2b2lkDQo+
ICAgICAgICAgICogZXhwbGljaXQgLT5wcmVwYXJlKCkvLT5maW5pc2goKSBzeW5jcy4gRm9yIG90
aGVyIC0+bWVtb3J5IHR5cGVzDQo+ICAgICAgICAgICogd2UgYWx3YXlzIG5lZWQgLT5wcmVwYXJl
KCkgb3IvYW5kIC0+ZmluaXNoKCkgY2FjaGUgc3luYy4NCj4gICAgICAgICAgKi8NCg0KSXQgc2Vl
bXMgSSBoYXZlIG1pc3VuZGVyc3Rvb2QgaG93IERNQS1CVUYncyBjYWNoZSBzeW5jcyBhcmUgbWFp
bnRhaW5lZCBhbG9uZyB3aXRoDQp2aWRlb2J1ZjIgQVBJIGNhbGxzLiANCkkgdW5kZXJzdGFuZCB0
aGF0IGNhY2hlIHN5bmNzIGFyZSBleHBlY3RlZCB0byBiZSBoYW5kbGVkIGJlZm9yZSBwcmVwYXJl
KCkgYW5kIGFmdGVyIGZpbmlzaCgpLg0KVGhlICJvd25lcnNoaXAiIHRyYW5zaXRpb24gYWxvbmcg
UUJVRi9EUUJVRiBjYW1lIGZyb20gbXkgbWlzdW5kZXJzdGFuZGluZywgcGxlYXNlIGZvcmdldC4N
Cg0KPiBBbmQgaGVyZSBodHRwczovL2RvY3Mua2VybmVsLm9yZy9kcml2ZXItYXBpL2RtYS1idWYu
aHRtbCBJIHJlYWQgdGhhdCB1c2Vyc3BhY2UNCj4gbXVzdCBjYWxsIERNQV9CVUZfSU9DVExfU1lO
QyB0byBlbnN1cmUgdGhlIGNhY2hlcyBhcmUgc3luY2VkIGJlZm9yZQ0KPiB1c2luZyB0aGUgYnVm
ZmVyLg0KPiANCj4gQXJlIHlvdSBjYWxsaW5nIERNQV9CVUZfSU9DVExfU1lOQz8NCg0KTWlzc2lu
ZyBjYWxsaW5nIGlvY3RsKERNQV9CVUZfSU9DVExfU1lOQykgaW4gdXNlcmxhbmQgd2FzIGV4YWN0
bHkgdGhlIGNhdXNlLg0KSSByZWFkIHRoZSBkb2N1bWVudCwgY2FycmllZCBvdXQgZXhwZXJpbWVu
dHMgYW5kIGZvdW5kIGl0IHdvcmtlZCBjb21wbGV0ZWx5Lg0KVmVyeSBzb3JyeSB0byBib3RoZXIg
eW91Lg0KDQpSZWdhcmRzLA0KCVl1amkNCg0KPiBJIHN1c3BlY3QgdGhhdCB2YjJfZGNfdW5tYXBf
ZG1hX2J1ZigpIGNhdXNlZCBhIGNhY2hlIHN5bmMsIHNvIHlvdSBuZXZlcg0KPiBub3RpY2VkIGlz
c3Vlcy4NCj4gDQo+IFJlZ2FyZHMsDQo+IA0KPiAJSGFucw0KPiANCj4gPg0KPiA+Pj4NCj4gPj4+
DQo+ID4+Pg0KPiA+Pj4gV291bGQgeW91IHRlbGwgbWUgc29tZSBpZGVhIG9uIHRoaXMgcGF0Y2g6
DQo+ID4+Pg0KPiA+Pj4gKiBEbyB3ZWxsLWltcGxlbWVudGVkIGNhcHR1cmUgZHJpdmVycyB3b3Jr
IHdlbGwgZXZlbiBpZiB0aGlzIHBhdGNoIGlzDQo+IGFwcGxpZWQ/DQo+ID4+DQo+ID4+IFllcywg
ZG1hYnVmIGlzIHVzZWQgZXh0ZW5zaXZlbHkgYW5kIEkgaGF2ZSBub3QgaGFkIGFueSByZXBvcnRz
IG9mIGlzc3Vlcy4NCj4gPg0KPiA+IE1hbnkgYXJjaGl0ZWN0dXJlcyBjYW4gYXZvaWQgdGhpcyBw
cm9ibGVtLg0KPiA+IEEgcHJvYmxlbSBzdGF0aXN0aWNhbGx5IG9jY3Vycywgb25seSBpZiBhIHZp
ZGVvIGNhcHR1cmUgSFcgZG9lcyBub3QgaGF2ZQ0KPiBIVy1tYWludGFpbmVkIGNhY2hlIGNvaGVy
ZW5jeSB3aXRoIENQVS4NCj4gPiBEb2VzIHRoaXMgcGF0Y2ggY29uc2lkZXIgc3VjaCBjYXNlPw0K
PiA+DQo+ID4+Pg0KPiA+Pj4gKiBIb3cgc2hvdWxkIGEgdmlkZW8gY2FwdHVyZSBkcml2ZXIgY2Fs
bCBWNEwyL3ZpZGVvYnVmMiBBUElzLA0KPiA+Pj4gZXNwZWNpYWxseQ0KPiA+PiB3aGVuIHRoZSBo
YXJkd2FyZSBkb2VzIG5vdCBzdXBwb3J0IGNhY2hlIGNvaGVyZW5jeT8NCj4gPj4NCj4gPj4gSXQg
c2hvdWxkIGFsbCBiZSBoYW5kbGVkIGNvcnJlY3RseSBieSB0aGUgY29yZSBmcmFtZXdvcmtzLg0K
PiA+Pg0KPiA+PiBJIHRoaW5rIHlvdSBuZWVkIHRvIGRlYnVnIG1vcmUgaW5zaWRlIHZpZGVvYnVm
Mi1jb3JlLmMuIFNvbWUgcHJpbnRrJ3MNCj4gPj4gdGhhdCBzaG93IHRoZSBkbWFidWYgZmQgd2hl
biB0aGUgYnVmZmVyIGlzIG1hcHBlZCBhbmQgd2hlbiBpdCBpcw0KPiA+PiB1bm1hcHBlZCArIHRo
ZSBsZW5ndGggaXQgaXMgbWFwcGluZyBzaG91bGQgaG9wZWZ1bGx5IGhlbHAgYSBiaXQuDQo+ID4N
Cj4gPiBJIGFkZGVkIHByaW50ayBhbmQgZHVtcF9zdGFjaygpIHRvIHNldmVyYWwgZnVuY3Rpb25z
Lg0KPiA+IFRoZSBwYXRjaGVkIGZ1bmN0aW9uIF9fcHJlcGFyZV9kbWFidWYoKSBpcyBjYWxsZWQg
ZXZlcnkgaW9jdGwoUUJVRikuDQo+ID4gRnVuY3Rpb24gdmIyX2RjX21hcF9kbWFidWYoKSBpcyBj
YWxsZWQgb25seSBmb3IgdGhlIDFzdCBjYWxsIG9mIGlvY3RsKFFCVUYpDQo+IGZvciBhIGJ1ZmZl
ciBpbnN0YW5jZS4NCj4gPiBBZnRlciB0aGF0LCB2YjJfZGNfbWFwX2RtYWJ1ZigpIHdhcyBuZXZl
ciBjYWxsZWQsIGFzIHRoZSBwYXRjaCBpbnRlbmRlZC4NCj4gPg0KPiA+IFJlZ2FyZHMsDQo+ID4g
CVl1amkNCj4gPg0KPiA+Pg0KPiA+PiBSZWdhcmRzLA0KPiA+Pg0KPiA+PiAJSGFucw0KPiA+Pg0K
PiA+Pj4NCj4gPj4+DQo+ID4+Pg0KPiA+Pj4gKioqKioqKioqKioqKioqDQo+ID4+Pg0KPiA+Pj4g
WzFdIEZZSTogdGhlIGNhcHR1cmUgZHJpdmVyIGlzIG5vdCBvbiBtYWlubGluZSB5ZXQ7IHRoZSBj
YW5kaWRhdGUNCj4gPj4+IGlzLA0KPiA+Pj4NCj4gPj4+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L2FsbC8yMDIyMDgxMDEzMjgyMi4zMjUzNC0xLXl1amkyLmlzaGlrYXdhQHRvDQo+ID4+PiBzaA0K
PiA+Pj4gaWJhLmNvLmpwLw0KPiA+Pj4gPGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDIy
MDgxMDEzMjgyMi4zMjUzNC0xLXl1amkyLmlzaGlrYXdhQHQNCj4gPj4+IG9zDQo+ID4+PiBoaWJh
LmNvLmpwLz4NCj4gPj4+DQo+ID4+Pg0KPiA+Pj4NCj4gPj4+DQo+ID4+Pg0KPiA+Pj4gUmVnYXJk
cywNCj4gPj4+DQo+ID4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBZdWppIElzaGlrYXdh
DQo+ID4+Pg0K

