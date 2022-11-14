Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B57C662778C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 09:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236398AbiKNI1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 03:27:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236275AbiKNI06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 03:26:58 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2106.outbound.protection.outlook.com [40.107.255.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA0466461;
        Mon, 14 Nov 2022 00:26:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ipMmknGCTO4GHfHbhasbW8ftBV5wJeEMLGt+gd66RQmAHeYGTMG5jJqblRVdsNdyBlJwXvRg/lB0x8trEu6GMHPb59yrNh89n8e+D22cP4npNJb2jk5UZVRWXikEFTb/wHK64TexJON80DToXd84CTFZ1FHLoK5FCT2WwftZ67ZB4ShNduVOYue/G+Wqcx2d7eXUZv3sF+adPg4lC+aqvujMQum0ejjvo030FKv+gAsuJEoIb4wYHamUdsm2neejLdQOSZLESuAhMltinWp3HzrCSe2KdOypW0BF+8kmiPYeqlJ6DT5+EvCAbBMfEAskmXzy8hRXyUFAjHrMUAvlaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HlMUDtuhsjRp1sHHktXsuWwSnGbHeNrfZi4hEKeucw4=;
 b=KvHr4+WHmeRbGTv0gcLZOBLiaE+/Lc8a77KhvaUVveoQBdxuSdfmm/US3pWwjUuYWhjBvcCorcebFOWPkHGt7EELkqg1xuAlL4YPpdkpbJG5XgKzc1oJXPg8qCPF0OQLE8L8bkdszXn1CI2NzPoMr0AYo2Rc7YaEVoH6oXe0nRzZDF0jmUEEeGdWSCzWoY+GZIUkFdLt34JB+ltiP8ZzwpXQ/Fth/IBcCqhMxZzaIG7g85VJhvNuA1kqkQljrxpf0mmsswj8F0siPFkl2+DkeRHj3LiAlDM+O8e1JUMz5BnwretnD/br1UzM8qn2rt1ZXH+XBnG/q7XUXa2NIId21Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HlMUDtuhsjRp1sHHktXsuWwSnGbHeNrfZi4hEKeucw4=;
 b=MWPd6smS5RskSkbI90Rrd432ZQCpI9tVe7DUXGCQ0uwpgZBXHdDgRHeRWXIncdmq1cierxVErcLOLm5GQJd+2JrqmhmQ9EYluBDb6DLLwAiCiAnj9TssQ/T7kT+AXhq2Iq7DbYiTkrEXMIOXB+zAx+rtquRhB1POmEnq7dDcBoE8IVrhWkIVeQRhH2zsHNit9s+PntyaReuYtrvfLe+KsRxLnFjebukgMfCn29fyweMVfh9sDVypziuUVQIudyx4Pem4kpYTQKVJqqI6QIarYBJghtCAl98JDydAbZ14UjVqd7WHh9mrP/oCuJdVGjkPPgBhspZZwOPGizTSWgHtcQ==
Received: from SG2PR06MB3365.apcprd06.prod.outlook.com (2603:1096:4:69::12) by
 TY0PR06MB5185.apcprd06.prod.outlook.com (2603:1096:400:21f::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.17; Mon, 14 Nov 2022 08:26:50 +0000
Received: from SG2PR06MB3365.apcprd06.prod.outlook.com
 ([fe80::dd5d:e720:e00f:831]) by SG2PR06MB3365.apcprd06.prod.outlook.com
 ([fe80::dd5d:e720:e00f:831%6]) with mapi id 15.20.5769.019; Mon, 14 Nov 2022
 08:26:49 +0000
From:   Billy Tsai <billy_tsai@aspeedtech.com>
To:     Rob Herring <robh@kernel.org>
CC:     "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        BMC-SW <BMC-SW@aspeedtech.com>,
        "garnermic@meta.com" <garnermic@meta.com>
Subject: Re: [v2 1/3] dt-bindings: Add bindings for aspeed pwm-tach.
Thread-Topic: [v2 1/3] dt-bindings: Add bindings for aspeed pwm-tach.
Thread-Index: AQHY7ddeW4ZmCSdnLkm5NlBsHfM2O64qZyqAgAEXnQCAAHTPAIABZaMAgBFW4QA=
Date:   Mon, 14 Nov 2022 08:26:49 +0000
Message-ID: <D453751F-9FA5-4046-BC5F-866D11010805@aspeedtech.com>
References: <20221101095156.30591-1-billy_tsai@aspeedtech.com>
 <20221101095156.30591-2-billy_tsai@aspeedtech.com>
 <20221101184033.GA1879756-robh@kernel.org>
 <C4090559-71D3-4DC4-A994-474D375DC4EF@aspeedtech.com>
 <CAL_Jsq+eiFO9JyJW=2SB-HLHJLrXggO+7kwG8G-6Zt=K2QnFUA@mail.gmail.com>
 <294877DF-1EFB-4E62-9603-3586A13BE471@aspeedtech.com>
In-Reply-To: <294877DF-1EFB-4E62-9603-3586A13BE471@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.66.22101101
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR06MB3365:EE_|TY0PR06MB5185:EE_
x-ms-office365-filtering-correlation-id: cd68299c-12d3-4d23-7d55-08dac619f9f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b96sVHCVlfx0BrsbhGNUIHjRtPHHuX24uIuyppeH7YYJ0BcoeSdQ18xAl6WKDpnqf+r33+v72X/x+/AiCwOVUOsGsCPqkkZuiQqy6QBhO3ygi/ZFB4WJFZXNd8MvDdpGTPxtDOobWre+y2QCIn6iKN4dEj5aBS/rj3h6OIj8QMUYrqqCAp1kNX9zgibBCo0anFJhDLG1fA2x2jdR1JVcr6oCTtvZaxZnkVwTKznrlir5vw23t7dTtrBJGtkj+hNFjrLg2A5BkIXDh14JAQv2jDUDubPyfxOn3+WbFF75IAby4Vqj1krSuaQvJxIfPfSIQbIY91b5EXrd7Qa6ULWOnBDg3FYc6ynPUtYRUY1BTJtqhpcFu/P+J6lgpMXJtzwxGPmR8LO0zKeDH4xD9NcyjSnldUaIRnOc7ER6o21CP1SwrUSxQ/tZ1fT8kEAL2ak2ycnnn6ogxtp7PCrN4BQm/vK/K3nrFuOcqGoJEyVAuDUhSEwPsI72GyVWBRt/P6EKWSGcRKAUTO1DAORtFN2SRrGZIExJbEsspLAloV2xHz3DCTmkaYbGbahf9R0tkghl/Uye6TqpvIqv8TePQ3HQ6NHDoL9K0zU6CSp8wt04I/dwuGQThSNKEX02PByKFQ0aNIyM1+m80zUpKPtAP+gUuskdd73r26Hx6L3Iuz6bj+SdBQfPQU9hsy6Rl2y3zfQ2nfzELE0Q4QmV4bZkfsLWhOOxHkan+NW4pkxdi1ipMsU1ueUCtw/Kmy4BpfwFYgK6LcHY++aEG1bSjV7f9n73QS1dz3Hu5w5NvjDARJb3Dj4qIGmNm4/NFvx25AmUMpWA9Df6rsifx3oWySNyIcLKUYg2RWqHlL8bzQkX308X2wr8hrTobTX2jNTz0yZWAlrj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3365.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(376002)(366004)(39840400004)(346002)(451199015)(54906003)(6916009)(316002)(36756003)(478600001)(966005)(33656002)(71200400001)(26005)(86362001)(38070700005)(6512007)(6506007)(53546011)(2906002)(66476007)(8676002)(66446008)(2616005)(66556008)(186003)(64756008)(8936002)(7416002)(83380400001)(66946007)(122000001)(6486002)(41300700001)(38100700002)(5660300002)(91956017)(4326008)(76116006)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TDVSQmlJUXlqT0FhMTFlZjNrK0NQcXRvRzFVSXV1SmdabXRENUthT0ZlMTVB?=
 =?utf-8?B?RXUzb1ZmbXIyK3N4djY4UW92REM3ckM1b09nbXNNa1hKK2tEK3lraWloVkpX?=
 =?utf-8?B?VUdEOXQySjBCdEgwckVvT21oaHIwNmd0bzl6R3lySlEvQWhoUHNGWEE0R3VE?=
 =?utf-8?B?WkZ0TGFlV3BXeDJGR3I1ZzBjdzdYc0RrT3VFOVlGT3YwNXh6cU02eDM3WUhN?=
 =?utf-8?B?MzB3YSs3L0dER1BrZ2lRUUUvUHR4c0xyMkoxZzJWUll5YmtQamhJSlExV0ZU?=
 =?utf-8?B?NVdhLzh0RXdmNkQwYzdDS1dFZzh5ZTE4SS9XQktqTldWMVpUQnMxNThnTytj?=
 =?utf-8?B?blM1dnNWdTI5aXJYalBDYTNHMTR3VzIwaE55THp3NldJQ29oeWxoSklzSjJk?=
 =?utf-8?B?YU1BdnVaaDE1MCs1SVIreUlsb3BBdzZObkRLY1RkNFFWYjZxbW1OWVFFcVlr?=
 =?utf-8?B?QThOdVNGTmV2VmpwWGNvSmZJRkpua0JoUzB2U01JeGI4UnJxMVg3bGtIcGZE?=
 =?utf-8?B?azFkRHZrWGZjR3ZBdkRqM2pidEN4cUcwc0xGcm9zeTRHcFVNcUwveDR6RHBr?=
 =?utf-8?B?YVpTeVB0TkJhYTB5V0NPNTZDN0RjMW91NzA0SS9GMldQeGhHM0k1bWc3cHNz?=
 =?utf-8?B?NlpFSE80YzlDR2szQmFMMndsRm9RWmY0NnA3eHBnMmtENkExT2pFdlBqZmFW?=
 =?utf-8?B?clhlQmgwNFI1VVNFQWE0clNXNWFFc2lBaHBhTjNjaVdxQmpHMGJwYThab2lT?=
 =?utf-8?B?Nlp5b3pwQVRlTzJSM3V1ZExzUHh2V3pIYzJjSUJNdEUybjhtSXZncW14bkEy?=
 =?utf-8?B?cy9BeVBMa1BtSEV5Q052Rm5tWm9jRCtQZEtzWVRJVzdkY3R1c3AwbW1pNVlq?=
 =?utf-8?B?c3BSWWN5MDhMUW5BQ3Nid3JSRDg3RU5NQVNpcitVeGVjYVVCTzV0S1FOVmFY?=
 =?utf-8?B?amdBMHlrQlZnVm9OT1o0MlpkMmRqV0Q4T1ZqbHFycWJEQmwyZlhXNkt4dEhu?=
 =?utf-8?B?NmVQZkV1ZUF5Q1hyRzY2UGY4bzRiTVRLc0w5RFJINlZidGFvdkNrMGFLWGRn?=
 =?utf-8?B?THIxOXJCbzloaFlhYzBOSjBpbjAvajJoaldMTHE3NllTM3UyNzk5bldjUmxP?=
 =?utf-8?B?VE1XL0tNQllNaERINUJNS3ZGQklmNVVkSUJNMUd3a1dSMnlMdmk2bmNSWEVX?=
 =?utf-8?B?Z0ExNlRJK1ptOFZsUTcyTDBGYk1JZXFTekhyL1FJem81OE5jZUJtR2tDQk9D?=
 =?utf-8?B?YVJBU09GVUhGK2RMMG5LWFR4cHlQWDVXSm1kVlJJQkhnSkxjKzhPR09QRlRu?=
 =?utf-8?B?MXJna1R0UDBvSXJ3NGFWS2RlMS85bmRjMkFhdFBFSjhVU01BTS9qMCtZK09E?=
 =?utf-8?B?Ny9jTU9yRlo3RzRSUjRCWHBMUUoyZHFkdGg2STUyaEMzSEVwYkp5Szd2d1Va?=
 =?utf-8?B?UDY2bWlXWWVHZzNMdnlvVEd6bVVYNlFQWVlYcWFoZTVRUXFnWS9IaTVVZ3RV?=
 =?utf-8?B?eGVvTDZZSVpMZmtaZTRCZi9NUmZUVXNnb1RycVhWUW9XMG0wNnZzYVRQajk0?=
 =?utf-8?B?QjNKWDhlNkJRbjJiRUhZRlZ2alduZGZqUzRaWUp1cys1NDdQT3FmdXg1alJq?=
 =?utf-8?B?SW9GZ3ptRUZBRWd1eWxYQlhKYzgxRjhKcUllMXlsckUxaTliM3lzMFdRdDF4?=
 =?utf-8?B?azIxZjdxVUdmRjRRTytQYW53dHJVM2ZPVTE2eWM0MW1xSmJUcGt5QTZ0UXRu?=
 =?utf-8?B?M2wva1paNENxeFFpbm8yR2xUUVg0SlJFZm9veCtZM0pqUzJ5Vnp5SlRoZE8v?=
 =?utf-8?B?Ym9LeWt4cVdaK0pZS0ZTaWh6UVNYazRiaThNRDRGQUFobkxUQ1NER3FuSzVH?=
 =?utf-8?B?UGUxZFF0bDhmQ0cxRkZZSDFnL1NSVnd6S3hXMW1sMjRPQVR1VURvUzU3U25u?=
 =?utf-8?B?bGU1eWNtb29OaGJKd1I3akRYL2lzaFBpNEVTUjZxZFNnU0djNTRWd2FNcHV6?=
 =?utf-8?B?US9Ca1F2UkJYZlpVZ016ci9yRkEzSUF0NVJvY1lkMHdGWFVoVnlrZUtpS3cx?=
 =?utf-8?B?TVJGa0xLbGVyQmhTdjRZWEhuelRsR2RMK1BNNTFUSjlNc1JKY2g5ZjMvSTJx?=
 =?utf-8?B?ckd5YUk1Sy8vZGlrZ1RpZTAzeU9mNFdMc1lRSFBWWVl2SXgydk5QazFML2or?=
 =?utf-8?B?clE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8BCAA844BCD4A74C9D37070FDE116D94@apcprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3365.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd68299c-12d3-4d23-7d55-08dac619f9f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2022 08:26:49.6221
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FA5HK+cuAaD/XJRAA9iChNEtBhThagv32NgXVzuLGGu61/B4Q6ize5njeeKvsW3avYihVYcidaX8ZWV6N1AWzdwMjlxSNMgCwcJwSyGpxhU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5185
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUm9iLA0KDQpPbiAyMDIyLzExLzMsIDM6MzkgUE0sICJCaWxseSBUc2FpIiA8YmlsbHlfdHNh
aUBhc3BlZWR0ZWNoLmNvbT4gd3JvdGU6DQoNCiAgICBPbiAyMDIyLzExLzMsIDI6MTkgQU0sICJS
b2IgSGVycmluZyIgPHJvYmhAa2VybmVsLm9yZz4gd3JvdGU6DQoNCiAgICAgICAgT24gVHVlLCBO
b3YgMSwgMjAyMiBhdCAxMDoyMSBQTSBCaWxseSBUc2FpIDxiaWxseV90c2FpQGFzcGVlZHRlY2gu
Y29tPiB3cm90ZToNCg0KICAgID4gICAgPiBUaGF0IGFsbCBzb3VuZHMgbGlrZSByZXF1aXJlbWVu
dHMgdGhhdCB5b3UgaGF2ZSB3aGljaCB5b3Ugc2hvdWxkDQogICAgPiAgICA+IGVuc3VyZSB0aGUg
ZmFuIGJpbmRpbmcgY2FuIHN1cHBvcnQuDQoNCiAgICA+ICAgID4gSSd2ZSBhbHJlYWR5IHNhaWQg
dG8gdXNlIHRoZSBQV00gYmluZGluZyBpbiB0aGUgZmFuIGJpbmRpbmcgZXhhY3RseQ0KICAgID4g
ICAgPiBmb3IgdGhlIHB1cnBvc2Ugb2YgaG9va2luZyB1cCB0aGUgUFdNcyB0byBvdGhlciB0aGlu
Z3MuIFdoZXRoZXIgdGhlDQogICAgPiAgICA+IHRhY2ggY29udHJvbGxlciBpcyB1c2VmdWwgZm9y
IHNvbWV0aGluZyBvdGhlciB0aGFuIGZhbnMsIEkgZG9uJ3Qga25vdy4NCiAgICA+ICAgID4gU2Vl
bXMgbGVzcyBsaWtlbHkuIFRoZSBtYXg2NjM5IGFsc28gaGFzIGEgdGFjaCBjb250cm9sbGVyLiBT
byBpZiBvdGhlcg0KICAgID4gICAgPiB1c2VzIGFyZSBwb3NzaWJsZSBmb3IgeW91LCB0aGVuIGl0
IGNvdWxkIGJlIHBvc3NpYmxlIGZvciBhbnkgb3RoZXIgaC93DQogICAgPiAgICA+IGxpa2UgdGhl
IG1heDY2MzkuDQoNCiAgICA+IFRoZSBsaW51eCBrZXJuZWwgYWxyZWFkeSBoYXZlIHRoZSBzaW1p
bGFyIGJpbmRpbmc6DQogICAgPiBodHRwczovL2dpdGh1Yi5jb20vdG9ydmFsZHMvbGludXgvYmxv
Yi9tYXN0ZXIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2h3bW9uL3B3bS1mYW4u
dHh0IA0KICAgID4gVGhlcmVmb3JlLCBJIHdhbnQgdG8gcmV1c2UgaXQgYW5kIHRoZSBwd20tZmFu
LmMgaW5zdGVhZCBvZiBjcmVhdGluZyBhbm90aGVyIHNpbWlsYXIgZmFuIGJpbmRpbmcgYW5kIGRy
aXZlci4NCiAgICA+IEkgYW0gcmVmZXJyaW5nIHRvIHRoZSBmb2xsb3dpbmcgZmlsZXM6DQogICAg
PiBodHRwczovL2dpdGh1Yi5jb20vdG9ydmFsZHMvbGludXgvYmxvYi9tYXN0ZXIvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9rb250cm9uJTJDc2wyOGNwbGQueWFtbCANCiAg
ICA+IGh0dHBzOi8vZ2l0aHViLmNvbS90b3J2YWxkcy9saW51eC9ibG9iL21hc3Rlci9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcHdtL2tvbnRyb24lMkNzbDI4Y3BsZC1wd20ueWFt
bCANCiAgICA+IGh0dHBzOi8vZ2l0aHViLmNvbS90b3J2YWxkcy9saW51eC9ibG9iL21hc3Rlci9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaHdtb24va29udHJvbiUyQ3NsMjhjcGxk
LWh3bW9uLnlhbWwgDQogICAgPiBJdCB3aWxsIGFsc28gcmV1c2UgdGhlIHB3bS1mYW4gaW5zdGVh
ZCBjcmVhdGluZyBpdCBvd24gcHdtLWZhbiBiaW5kaW5nIGZvciB0aGVpciBod21vbih0YWNoKS4N
CiAgICA+IGh0dHBzOi8vZ2l0aHViLmNvbS90b3J2YWxkcy9saW51eC9ibG9iL21hc3Rlci9hcmNo
L2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHMxMDI4YS1rb250cm9uLXNsMjgtdmFyMy1h
ZHMyLmR0cyNMMjAgDQoNCkRvIHlvdSBoYXZlIGFueSBzdWdndWVzdCBhYm91dCB0aGUgYmluZGlu
ZyBsaWtlIHRoZSBsaW5rIGFib3ZlPw0KV2UgY2FuIGp1c3QgY3JlYXQgdGhlIHB1cmUgUFdNIHBy
b3ZpZGVyIGFuZCB1c2UgdGhlIHB3bS1mYW4gYXMgdGhlIGNvbW1vbiBmYW4gYmluZGluZyBpbnN0
ZWFkIG9mIGNyZWF0aW5nIGFub3RoZXIgZmFuLWNvbW1vbi55YW1sLg0KDQpUaGFua3MNCg0KQmVz
dCBSZWdhcmRzLA0KQmlsbHkgVHNhaQ0KDQoNCg0K
