Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F1D5BC624
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 12:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiISKP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 06:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiISKPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 06:15:24 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2133.outbound.protection.outlook.com [40.107.113.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF21F10FEA;
        Mon, 19 Sep 2022 03:15:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PkNTClVc9RWepRNNibHMdm3Vm9cqOhZAV1GgloBZB3WBghQdBVuHu880LxKQbKUdHIP9rMlI+tXczr1WvgomRnRbelvMNEHjIZSgdrTt5t295y6kYDp2E586sFWk7B9UHtP2/4c8MsjgBO82rhV/gP5vwPZx9iC87+EssmNEFEy9RSmRimqwMGJOK4T2flPrtKbCJJpxNCzyENRWDln6I/R73Kr33X4l26cH40jlSEN7WjEFgv846bkAz7mQISx6EEIbfb/LJHSGdi+twYyaVuxZsrvamvqXfV/cMM6klVemc2H+I97j0q3BxWL5CM1wQdCQWjfGxDKJ27qaNJR2XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=70vfkgcv3u/Aw1tn+0r/tJdc84TrbyDUUlUgvoMDLAw=;
 b=drZo76M2XmWRHofwRpnjCNnHZBdGV5eU+nPnUgk3QwGG6iqS0M0zCJa3ZnlYDDrJFNHRf7zwTm2+vV9QPNhV/Z9mWnXObyb/hPRVkRmv3c/RkhbUGlLT5TMqV9d3vpZ1EUzae+IeKRBPTWMYj+DI/LuTlcTvwIjaMUPRwPJKUgSweYxsSOtZl08A6UpFQrQTFRGIH7VwIvjB+wv0Hf+63IBIWxSRPqGNeSzrR42//5BLdPyV7EbS7bXzaQQjxkp8Qe/aK6bEdjLyj3gKFAUmCTIBjTAsCVieprINjwrSn3FwOZAQs2PGuDgnAuveeGOr/3bZV4b9JhIN1B9YHdP+Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=70vfkgcv3u/Aw1tn+0r/tJdc84TrbyDUUlUgvoMDLAw=;
 b=wvo+r4ePS7OJHSkQpCpAVBwbFpH8U9HYZtVdMRwFpuuxkD/lun6pksVYftuZtec3c9OHLZjD5SRAjrvB6W0biH/45GHHeSiVgfXa05Y9LN3FjPqtERQOOMO+hoHs+P87eWSVoHISAApQi5PXtOI1gY5h6rwLzgspoaMhiRu37rg=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB8866.jpnprd01.prod.outlook.com (2603:1096:400:189::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.18; Mon, 19 Sep
 2022 10:15:20 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::c502:8f9f:ec5e:8e3f]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::c502:8f9f:ec5e:8e3f%3]) with mapi id 15.20.5632.021; Mon, 19 Sep 2022
 10:15:20 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH] arm64: dts: renesas: rzg2ul-smarc-som: Drop enabling wdt2
Thread-Topic: [PATCH] arm64: dts: renesas: rzg2ul-smarc-som: Drop enabling
 wdt2
Thread-Index: AQHYyD/rtz77kMV/LUKpS1dYBqhnjK3k6tOAgAGecYCAAAScQIAAAboAgAAA8+A=
Date:   Mon, 19 Sep 2022 10:15:20 +0000
Message-ID: <OS0PR01MB59221867F12797CCA685F954864D9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220914134211.199631-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdVRmuQm5xRgpQurCJTu7goqNi5zj+Q9cLLz_s_p=znbbA@mail.gmail.com>
 <CA+V-a8vDMFKJb0wDOR8LZifRDBa0hju-YgL_BDb0chVjpef98w@mail.gmail.com>
 <OS0PR01MB592272F7C6A9519E1CA99647864D9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMuHMdWzWQgL1eki_aL_MnfQfM_S1yTuabWQAP8GzuA_D_A_kw@mail.gmail.com>
In-Reply-To: <CAMuHMdWzWQgL1eki_aL_MnfQfM_S1yTuabWQAP8GzuA_D_A_kw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYCPR01MB8866:EE_
x-ms-office365-filtering-correlation-id: 5e42e7e0-10ca-4213-3e07-08da9a27db64
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BeeQ9OTnEAmV0FFLuwqKG53oPPzFVIUESB9e0QWbeFO4d3cudoxnqcImOP48jJlThmnpMG34q5JvV41KG+gBYkmufEDcy7FRy7dH5ULnW9kTZq2xL4Vb30iiZ16lVBrcggmrkpgN/RaybZ2JpXChMN3zErDEOkZ+a2GI/euNfqXZ4aJEPbcN/7KhT875HV7/WkrzZ5EH2HU3CmOdL3EVUl6J5GMXqNc5kQtduINyXPDvBgIzMnPhQr9iE7JRsiPMaO8Dq/cjgvOFMi+BGKkZSIvaZlKyCjUcT2xwth3mAquIc9Epa1FNogGMJvA1qQNR4UbfGuVbmHBrbKaCphZPVBwHrY6/i9+LzRYvlJ2Ft/lwDAYJZ7hDuto2jFCDaLq9mYWQDxqVUj7N2FAQcl+wnq0FNh8cf6yy3ra5G2u/VJ3+4lJpd+Eb8uf4vPY681106tB9LuNO+KeBSU6FB+2duysudy/0IYXevsmgfUFIEHN4BCpFgUodBJx/2T0A7AkTJOmIXqd3VDFfutgF3eFwfD9s65SOOZWOlUlJYGvvaCkrbHpc6Q0wnGU5B962Dik+EBoIOV4zi2ELIjpdX7DgHcveLHaPn3X5J2BO/x3WDPvDCYmcpD3oiwMBDzFTMUrQTNP9R+l9LQHJPE4GxbbfYVoXPcFte/Da5812uXnq0ClUtqAzb2R3Ye1qgr02M8RgqSpFgwvg4x7Jv6GkB0Qj3LpzT9BhTyPsx1V23Btv5oSMDIlxdAMcAEZlz7wAQx1Xm3cVoQXT532RqioWLOqwVg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(136003)(39860400002)(376002)(396003)(451199015)(2906002)(6506007)(7696005)(4326008)(38070700005)(71200400001)(38100700002)(66446008)(86362001)(66556008)(26005)(53546011)(55016003)(8936002)(9686003)(76116006)(66476007)(122000001)(33656002)(66946007)(64756008)(41300700001)(107886003)(8676002)(478600001)(83380400001)(54906003)(6916009)(316002)(186003)(5660300002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SXdBZkVWNW9LcWxsMDd3SEhoR0I4TUhRTXQ2dEJscXdXK1dudE5qcEFnYzJh?=
 =?utf-8?B?U29zN3lCVDd6Y0tDOSs0ekFyeWFjSHIvTGtOdVdtbDFhMmZ5YzZObFVSVGpF?=
 =?utf-8?B?Wjh5WktodmR0UUF3MFRDM0cyK1dLR3Q4bGpHeklRY2Z3eGNPakNYVGJZWWFW?=
 =?utf-8?B?VGVxTCtwbVpSc25la0gyOE8vaFd3YmF3WmU0Y04vTTBDZ2FGcXhPcXlCZXQ3?=
 =?utf-8?B?QklYVGg0N2daNXF1NGZrcWIvRi9hcEJlRVFJcUhlMzhJZEJhWWM2a244YVJK?=
 =?utf-8?B?NGt4bUo2aHdGcWE3RWdmKzY3Z3dTb0FLWlh0TXlZblcybUY1Vm9ObGdLZy9y?=
 =?utf-8?B?RURGVGdMME5mL3E3YlZiV3kvL1g3ckN6R1VoSnRvV3ZEb1I5WkVaQnVYeGxz?=
 =?utf-8?B?Y24wclhWNXEzZkozSEhJU3NiUnY4emdCMjFCVWxwcHhROStRMU9CcWVza05r?=
 =?utf-8?B?WXJPMXJEcXR1WTVqUUxvUmI4a1V2VlhKUjF4TmQrbnN2em1ZT0JwR2ZFcXVI?=
 =?utf-8?B?amFNcy9PWUR4RjkyZG1ZZXJkQ3ZLK2VURDlMSHpjTzV0TkJqWXFBMXBwcEc1?=
 =?utf-8?B?b0ZxZ1BnYk9RYTk4MjNuNlQzdURQTmxuS3Fkb3hRb29LaWdmUTFYbW9qdTF4?=
 =?utf-8?B?d1hyR041MTlvR0dlY0pOdno4elRIdUhmcU9QQTBEOXU1MDlGczErcUYyRFFU?=
 =?utf-8?B?UTkrN0hSazkxSTFMQlkzaGlIc056aWd1Y0JJalFwOGZ0OTB3cFUvRDczbysv?=
 =?utf-8?B?YlZDQUs5cmw3SjZMYzBHT3BqTzIwSnVWa3c5N0c3ak9pdW5rb0k1eTZRVHRw?=
 =?utf-8?B?ZkxrNUNmRUpVYVdDTmRDMzdlZDZ4U2dkZkNtTDBLSnR2N1lzdUlrMGRiUTNW?=
 =?utf-8?B?a0JkWXExeW5WNytlLzZyWWtFTEZYZm5nZXZFejBoMFNFelFjTE9EVlIwdkhm?=
 =?utf-8?B?M2xpUnFxQmZuSThselZwN0FVbSt0WldTUzFUbERwR052aDNZZ3c0UlpsUTJY?=
 =?utf-8?B?R2RmYWZtU3hyeWJTQ2Q3RVVFbDlzR0tYWkxIZU5qd3lLSzYvM2EyZ0k5eDRM?=
 =?utf-8?B?OGcxb25qN1BYcXZCRlJ0dys0THdXSXQ4cGVnV0hmdzBwN1h3NDNVSzgxWE9Q?=
 =?utf-8?B?TjNQblNJSy85a015YlJmTFFQT29oR2pzcVlQekV2UDFwT2pvYlVDU3B1WU1V?=
 =?utf-8?B?aDR4TjhwSUxFMzBRYVg1NDRNdExRSTRxekRkUGlMeHVRQ29lbktYeTlPTHZ0?=
 =?utf-8?B?L210c1lNbTFZQVdWQmVHbU9WVGp2dXpMWW9VcDVtTU8rUC9XR3YrQVIrcTFv?=
 =?utf-8?B?N2tvdmdzdEJ5N2JHVm10cXBodEJVOSs5anJPdHRDejFXYjAzbkRJTlkraUZI?=
 =?utf-8?B?VU53WUIydUJheW5LRUFNbHdlMUZqajFvWjYwWmg4aDdIaGxVemUxcnA5SnNG?=
 =?utf-8?B?ZHJyTlBrSVpaN2c2VzFCQmVMdG9tY1lBcklwbHRHb3dQQTFpOXlWV25HaHVQ?=
 =?utf-8?B?NFdwMStuV0UzK3pKdkdCZVZ4QnBxRXBDZTFaa0l3ay9OeGQ4U2RpQU5tV2J3?=
 =?utf-8?B?Q1Z6b3VGdENiaUtERFY4SkMzbVg2TDcvUlhzOUorcGlYTElLRmwyeGtwK3BW?=
 =?utf-8?B?cnNNWndIL1FvL0gvZFdSZThKU1FYR1QvWnNpVkgwM0I2ZFBoNDhsT3oxSGJv?=
 =?utf-8?B?YktNazFDMldsN2RiQ0RXMks2Z2drS3NMQWZkSnRkaTErTGZ3M1JUelZuUkJt?=
 =?utf-8?B?TnlGODZseU5iVEIybzI5WEpVNnF2OW5iMDE2Y2s5ZzdPdlU4dUdsTDdJS2Ey?=
 =?utf-8?B?Mzd4STRjcTNadG5QZ1lhQ0dxbXI4ZVpjR2FNalpPRWJJRGRPR0E5RzF3YnVE?=
 =?utf-8?B?anNML1o5TU9sbnJVNXo0TnArSU1mSUxKendBSDRSMXV4bDJDVmN5ZnZTRkNE?=
 =?utf-8?B?V3NSL1RxWHlmc1dwdm5NbmRvU3l5V2F1TFQxTitpUjkvNUEvbVJBR3dNeDh5?=
 =?utf-8?B?dmptRUdlU21qc1ZJenVuaWFSdjFLdHo5M0NrV1Y3K0MxZG9iR2dldVNwV29p?=
 =?utf-8?B?eHNSdTdoN3orNW5nSFBTMERpOTRiWS9HcU9Fc1QvTHh0TUNuZFdTdUUyb3pT?=
 =?utf-8?B?RkFJWnhMSG53K1RYeFYxL1RCblkrNloxU2xwOUJtd0lGQUhXS2ZVT0JMaVd3?=
 =?utf-8?B?RXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e42e7e0-10ca-4213-3e07-08da9a27db64
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2022 10:15:20.0434
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3gnDD0bi6sXE0NlimWnbxv0X3w8XqRD3ZS0EwEwfaXZcu+oQxCfsAb4b5QtGVlmPe3opV4cNMMpR3H18VKMMQqdeGnsasMbQjr9cx5jIpFA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8866
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR2VlcnQsDQoNClByYWJoYWthciBNYWhhZGV2IExhZCA8cHJhYmhha2FyLm1haGFkZXYtDQo+
IGxhZC5yakBicC5yZW5lc2FzLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gYXJtNjQ6IGR0
czogcmVuZXNhczogcnpnMnVsLXNtYXJjLXNvbTogRHJvcA0KPiBlbmFibGluZyB3ZHQyDQo+IA0K
PiBIaSBCaWp1LA0KPiANCj4gT24gTW9uLCBTZXAgMTksIDIwMjIgYXQgMTI6MDYgUE0gQmlqdSBE
YXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0KPiB3cm90ZToNCj4gPiA+IE9uIFN1biwg
U2VwIDE4LCAyMDIyIGF0IDEwOjA0IEFNIEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnRAbGludXgt
DQo+ID4gPiBtNjhrLm9yZz4gd3JvdGU6DQo+ID4gPiA+IE9uIFdlZCwgU2VwIDE0LCAyMDIyIGF0
IDM6NDMgUE0gUHJhYmhha2FyDQo+ID4gPiA8cHJhYmhha2FyLmNzZW5nZ0BnbWFpbC5jb20+IHdy
b3RlOg0KPiA+ID4gPiA+IEZyb206IExhZCBQcmFiaGFrYXIgPHByYWJoYWthci5tYWhhZGV2LWxh
ZC5yakBicC5yZW5lc2FzLmNvbT4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IFdEVCBDSDIgaXMgc3Bl
Y2lmaWNhbGx5IHRvIGNoZWNrIHRoZSBvcGVyYXRpb24gb2YgQ29ydGV4LU0zMw0KPiBDUFUNCj4g
PiA+IHNvDQo+ID4gPiA+ID4gZG9uJ3QgZW5hYmxlIFdEVDIgYnkgZGVmYXVsdC4NCj4gPiA+ID4g
Pg0KPiA+ID4gRm9yIGNvbnNpc3RlbmN5IEknbGwgZHJvcCBlbmFibGluZyBXRFQyIGZyb20gdGhl
IFJaL0cyTHtDfSB0b28uDQo+ID4NCj4gPiBEb2VzIHJlbW92ZSB1bnVzZWQgY2xvY2tzIHR1cm4g
b2ZmIFdEVDIgY2xvY2sgZHVyaW5nIGxhdGUgaW5pdD8/DQo+ID4NCj4gPiBJZiB0aGF0IGlzIHRo
ZSBjYXNlLCB3ZSBzaG91bGQgcmVtb3ZlIGVudHJpZXMgZnJvbSBjbG9jayB0YWJsZSBhcw0KPiB3
ZWxsPw0KPiANCj4gT3IgYWRkIGl0IHRvICpfY3JpdF9tb2RfY2xrc1tdPw0KPiANCj4gTm90ZSB0
aGF0IGRyaXZlcnMvY2xrL3JlbmVzYXMvcjlhMDdnMDQzLWNwZy5jIGNyZWF0ZXMgd2R0MiBjbG9j
a3MgYW5kDQo+IHJlc2V0cywgc28gdGhhdCBzaG91bGQgcHJvYmFibHkgYmUgbW92ZWQgaW5zaWRl
IHRoZSAjaWZkZWYNCj4gQ09ORklHX0FSTTY0IHNlY3Rpb24uDQoNClllcywgYm90aCB3aWxsIGRv
LCBJIGd1ZXNzIG90aGVyd2lzZSBXRFQgZW5hYmxlZCBieSBDb3J0ZXgtTTMzIHdpbGwgYmUgZGlz
YWJsZWQgYnkNCkNPUlRFWC1BNTUgZHVyaW5nIGJvb3QuDQoNCkNoZWVycywNCkJpanUNCg0K
