Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC8F715414
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 04:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjE3C4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 22:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjE3C4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 22:56:09 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2041.outbound.protection.outlook.com [40.107.113.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91765D2;
        Mon, 29 May 2023 19:56:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oZ0QVi5cmH4Jxsozpq0vy6/jkUHUxFDeWi9PMkkGFjcY3L6vxbStfMQe6qzzxPqIq1HcuBBySbDVFrOGYyyOlxq8XLqTfhue2Aw7AheOR2JHYf3+Uv8VgpQllw8EMHGf3Ve5nM6Mm4SW+cq/eJ3i2a78T+XgjAv5Iktp8Z2aJ3Aad4FkwGxQ4Y7vbgEcjHEs6aupYVDoFjzO1Y9AMhb5c1xEEOJBhiDDLK4FUvAjlMzsHYdz4x6S/3ab2C5j0yadEmDCt06NjczJdWCxMo24m6rhaJcEkgEaes8X/bFRSZtuLxzXL2sYiMxE66VdaBUSQ5OrDxIyGgnIfnTNw9z4mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ylYeiHZr+qrnXTyg0Hj6/5fp1UDgxLXKgF71SzX/ieU=;
 b=dgJYKMwFMf96BaDcyQtPzhnDDdNzACMHJCL26qNMsooMr8q+EbvD9kN0zZETlQ/NV1Oz4lkysghyvusUbBadC/fgsuXtVgZwDTyRw3+ibzgbsHmM1wOh4GJOwHQReunx9LkeOTmY6xkdbcUtbEsMvJ5hHbZrQOa83H1CFjWH3deSl5rDNUCjJScYf95LQfa4cFBQGQUELhcmrwlT1pCpLReAAItBCgun7Bt115hcnsrWJqsWBavjQirIFqdqjY+U3NGNaVF2zL6MvmTJwwd7nEEikh7HJryzEF7iaOKoYV8InkMAhkP/YoFnQlZ9yOG5ej7sj5YkDKAMio/hoPxplQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nskint.co.jp; dmarc=pass action=none header.from=nskint.co.jp;
 dkim=pass header.d=nskint.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nskint.onmicrosoft.com; s=selector1-nskint-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ylYeiHZr+qrnXTyg0Hj6/5fp1UDgxLXKgF71SzX/ieU=;
 b=mv8CdNmwjtFg971FCU3GSoZvFV6PGZMdMXNiDrRiNOWM7SuV29mxF2EPuofp/QCRPNL72Js2H5CEA+W8lqmJWTT4dA6kq3QC7AoBTsp8jltTfo1aDoQ5SUrSbAfgUXMz2bh/r+NnwkxGoet/xmcylwJVYRtWKxWOomIgQzpH9f0=
Received: from OSZPR01MB7004.jpnprd01.prod.outlook.com (2603:1096:604:13c::9)
 by TYVPR01MB11154.jpnprd01.prod.outlook.com (2603:1096:400:369::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 02:56:03 +0000
Received: from OSZPR01MB7004.jpnprd01.prod.outlook.com
 ([fe80::148a:7cac:32d9:1c03]) by OSZPR01MB7004.jpnprd01.prod.outlook.com
 ([fe80::148a:7cac:32d9:1c03%4]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 02:56:03 +0000
From:   Yoshitaka Ikeda <ikeda@nskint.co.jp>
To:     Dhruva Gole <d-gole@ti.com>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Vaishnav Achath <vaishnav.a@ti.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Takahiro.Kuwano@infineon.com" <Takahiro.Kuwano@infineon.com>,
        Pratyush Yadav <ptyadav@amazon.de>,
        Mark Brown <broonie@kernel.org>
Subject: RE: [PATCH v2 4/4] spi: cadence-quadspi: use STIG mode for small
 reads
Thread-Topic: [PATCH v2 4/4] spi: cadence-quadspi: use STIG mode for small
 reads
Thread-Index: AQHZMJVBHgHXafuso0ywMCCxmHrW5689ZDXggABfGwCAARZ4MIAA3JcAgBBuwJCAAFXLgIAAGoLggCJKngA=
Date:   Tue, 30 May 2023 02:56:03 +0000
Message-ID: <OSZPR01MB70043790C2DCF696243326B38B4B9@OSZPR01MB7004.jpnprd01.prod.outlook.com>
References: <20230125081023.1573712-1-d-gole@ti.com>
 <20230125081023.1573712-5-d-gole@ti.com>
 <OSZPR01MB70048CE259A3D63C4179199A8B659@OSZPR01MB7004.jpnprd01.prod.outlook.com>
 <044a723e-b81e-f6f2-8bf7-3680a10abc86@ti.com>
 <OSZPR01MB7004D229048A950C93B40CC88B6A9@OSZPR01MB7004.jpnprd01.prod.outlook.com>
 <b1d30948-ba3d-a4cc-e1ed-851a9dedba7c@ti.com>
 <OSZPR01MB7004907B2FB95F45E9B83FEC8B719@OSZPR01MB7004.jpnprd01.prod.outlook.com>
 <11c63702-cd25-67c9-d0bc-21ec47e14c98@ti.com>
 <OSZPR01MB7004DE3578325B0F51C5CE598B719@OSZPR01MB7004.jpnprd01.prod.outlook.com>
In-Reply-To: <OSZPR01MB7004DE3578325B0F51C5CE598B719@OSZPR01MB7004.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nskint.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB7004:EE_|TYVPR01MB11154:EE_
x-ms-office365-filtering-correlation-id: 176c762d-4d45-4c5d-53c0-08db60b9683b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SjWQM4BQifVD4mT4QIjBhRT3KPuhjIe2udxEedpOXdq1+sOGYGq7YMyj3+ZqcDkNrpR0WPxOBhBFdfqJquaOQGKmStxQAjRCH97vzun/cme77VLqvihzNf59/IQbfzeTVrXEDDD7uXq32W90B+uwZEEYuy2D5BgX/pZNZ1iLXNrj/eziWskRA65ks3K0CPEi5452ZObJ+TqSpuo4dh1M8tOiKMHGTnTH2E+lZ0I2tF8ZD/xO1zQc+ORWwPeG8NCmqnQIpOlKTfm50BE9c4PxC7aYu44QropXwD3kiZzV0vvBPblq/T00cFePd6oRR/oK6co2Umlj0xiR3CXuT5C2UU0fG3YCXuJZl0sWG5hatmFIMDI9l9EpV+I0yS1wMtMba1z67qL1G5hzoX0II0cxTyGMheA/tlNOvRfTkTlUig2O9/f91IvxUUsZtdqNBAdUAjB5b6d1mffAoCyoeZf4d0dvt5UKpGm2YokO+n4h5r12368ztT57/mNAwglgWHzLhHMTh2AI1TfHoefscXKUu+SiJJXnrZ89+HJKIxy5qZEkQndht1pH215Tmu+YOcrMGaURXdSNpTGKDY7nCZ4szpVgoOFMenvvlnhg8W38NNE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7004.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39850400004)(136003)(396003)(376002)(366004)(451199021)(71200400001)(478600001)(54906003)(8676002)(8936002)(7416002)(5660300002)(52536014)(33656002)(38070700005)(2906002)(86362001)(66476007)(4326008)(6916009)(122000001)(64756008)(66556008)(66446008)(66946007)(76116006)(316002)(55016003)(38100700002)(41300700001)(966005)(186003)(6506007)(9686003)(53546011)(26005)(7696005)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UXFzWFl5WVZlWjBPTkJlL3hhMDVVTXJZbjNIc0huMWllamFuSkJGajVkeWV3?=
 =?utf-8?B?RzFIWmlXdlF5WllHUkRwSzV6Y1o4R2tXcjZiTTlDYnZ6cXdxTm1ZdVZ0VUYz?=
 =?utf-8?B?OHlUUnFxMmZHQ1YzVlZMUi9sdmh2Mk8rZm50cVdMUDAzdVNqRUVXdVdMY2dr?=
 =?utf-8?B?TURWeDBkZEc4U0RhRmNRRzZJUFRSZy92R1plNmJvNVZZQmxmY3pWU0d3ekxP?=
 =?utf-8?B?WGp5ODNWUktLRjBBNUI4QjdCaVJiME85Qnh2K3RVbDB0Y1VCUVIrb2svc252?=
 =?utf-8?B?Ym1vcm91OS9QNjBweStpdGhSaTZ2OGZCbVhPL0h1bFUvVEZpWmcyUUg1ZWl1?=
 =?utf-8?B?a1hxNzB1cW9HeEs0K1Erd2RXcVBDci80U0lMZ0FoY0hjY0tyVzNKS2pqNTVi?=
 =?utf-8?B?MGprekFJNlBxZ3lSN3hPa0dOVGI2UUJqNy8yT1dDUE1zb1ZNRnNUSytIenJK?=
 =?utf-8?B?SmEweEpFTDN1Nm5iNWxHcS9paEJvNVlKYS9XWFl6TWVHSHdzZFNUaFBaYk0r?=
 =?utf-8?B?ZVBuUUFLYitDVjlrNFFZMU5FUWtGbjJ3SXdhRWhVTXBWdVROdWwrNXp6Ky9R?=
 =?utf-8?B?ZHZLWWRzKzU3QXlaTnNWSEdEWmp0Q2RMcDUvM3NjR3B0N2FMMWYxYXBHdU0r?=
 =?utf-8?B?eGtheUJCUnpnV2J0WUkzTmpaSmVGcnFjY0d0RGZDSmNxM2IyYW9JOVF4ajM0?=
 =?utf-8?B?MmxGdEZBajg4SWlJV0tJb2pnODl2WjJldDh6MlhmbEIzS3NIZ1EvOE5BamNa?=
 =?utf-8?B?Q0ZPTGh5NjI2Zmh4bTNBcVVIb2pxenlGenNVZ2g2R0Q0TDNpRWJwMXB4cys4?=
 =?utf-8?B?OUpRbWJuRWNCanByc2YrdVJRNVpEM2VBMzhvVFJtMjNueVlwQW9QU1ZCbkd4?=
 =?utf-8?B?Zjg3OEtJUDFEMmliNkhhUWc3TXdmeDZKNEJ0bXFNdjBHUXQyZVZzVGUwQ0NM?=
 =?utf-8?B?cXdMSTd6TGZDelRTRFo4NkZrSnV6d2t1LzVqTjFObzBzRjZIQnZUUms1NU5G?=
 =?utf-8?B?dlpKMVE3eUNTYlJYRlpoTTFiODlLSkp0QXByNTdLdzhRM1poR0FFbjBoYlhQ?=
 =?utf-8?B?RFRXTmJRbi9oSjI4Q2M0NkxGcWZxZzJTQUNSWmZ1bW5sZk41VHdualRFbFB2?=
 =?utf-8?B?aTJ6bUtZeEJqclZQc3NTOGJ4NkZaVmlVcUZ3R1k1OGtOOHpZQjNKUks5Ny9E?=
 =?utf-8?B?alA3TFlRUEg2aElwNnNzbDkydk84RmZZUGhMVm1KWHlzZmZDYUVEdnROZTFp?=
 =?utf-8?B?NlhLRVkxdlpVUlcrYWdoOStXd0V6RTFlbXhaVDJxMndvUkQ3a0VRcEc1N09y?=
 =?utf-8?B?dm04cmRURjBYMTdmWXhxSC80bUo1cWZyQmhmcTRpUHo2UEpPcjZnNEhiV1dm?=
 =?utf-8?B?YWh4SDVJNmZrS1kzTms4TWJOK0dXNEFpUDhjRlhXRDJDQXFaOGRKQWxTVVJ4?=
 =?utf-8?B?UWpxNEl2L2kyeWJKRWhQRG5VT1hDT245Z2NCQ1RUR3Y4WlNlOE5ydWxKRmFT?=
 =?utf-8?B?dDl6NWV3aS9jeTI5Y0Y1UmVEa09hbUxVQmJ5RFRxTmgyLzBzYUhZY3JtKzdW?=
 =?utf-8?B?cHJINjdoekx1YTNZeEtHWW9GTjJJYW11d1JLQ2p6NVdyZENENkIyU1liaVBZ?=
 =?utf-8?B?blFETEdOY3lGRnRvRkxVODB4Kzh2QW42V3I5SHlzSkVSM2dvNkZ1R05Cby9I?=
 =?utf-8?B?ak5mOVFKTnFqNjJIcng0Wkg0WE9BKzQveDJFWmJBZXBjUkhoemtvNDl4ZFRk?=
 =?utf-8?B?M3R1T2svZzFobmFDRlcyaWxpOWFyamJmcXlGdkRrUEQrYWhBbjFaNmFyRFRO?=
 =?utf-8?B?NDNlNnlJZkdBZzR3UVAyeEZSTzlXV1NTNlc5N3Q3djNLM2JXUStIeHFLY0x2?=
 =?utf-8?B?alFIK1liSU9naC8rZHV6NWQyRTgvdVkzMVB0cUt2SER6SjlSMStpVVJ6SFpK?=
 =?utf-8?B?WUxlZlBIdTV3UkYrVzhveEJKaldJTHdJNWZKbEpraGFSM2ZkNjlZZ1NiaTFp?=
 =?utf-8?B?dHBCUEFqUUdGUjJSL1BJdGJUNER1bFJqc2ZkRWNmUHcza3Q3eGJIRFNjZStl?=
 =?utf-8?B?azlUY292dG1YNGZ5eVFpbStjdkpqVFNFeG15Yk5DVlZaU05OdFg0L0JzRjZG?=
 =?utf-8?Q?J8NC4iuZCk1ZezCM/wVYfFi8E?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nskint.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7004.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 176c762d-4d45-4c5d-53c0-08db60b9683b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2023 02:56:03.6722
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 727455a2-9822-4451-819f-f03e059d1a55
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9OUTyqHXinkHEYVPHN7zCYHKxd1KpClrZrQxfjRCKRajycy8liF9syIa8g2/nH/lG3yNZC/7XmZkXUz97Vp2Zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB11154
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRGhydXZhLA0KDQpUaGUgcGF0Y2ggZGVzY3JpYmVkIGJlbG93IHdhcyBhYmxlIHRvIGF2b2lk
IHRoaXMgcHJvYmxlbS4NCkhvd2V2ZXIsIHdlIGNvdWxkIG5vdCBmaW5kIGFueSBtYXRlcmlhbCB0
byBkZXRlcm1pbmUgaWYgaXQgd2FzIGNvcnJlY3QuDQoNCg0KRGVhciBhbGwsDQoNCklzIHRoZXJl
IGFueW9uZSBlbHNlIGluIGEgc2ltaWxhciBlbnZpcm9ubWVudD8NCg0KDQpgYGANCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL3NwaS9zcGktY2FkZW5jZS1xdWFkc3BpLmMgYi9kcml2ZXJzL3NwaS9zcGkt
Y2FkZW5jZS1xdWFkc3BpLmMNCmluZGV4IDhmMzZlMTMwNmUxNi4uNGE5NTM1ZTZjODZhIDEwMDY0
NA0KLS0tIGEvZHJpdmVycy9zcGkvc3BpLWNhZGVuY2UtcXVhZHNwaS5jDQorKysgYi9kcml2ZXJz
L3NwaS9zcGktY2FkZW5jZS1xdWFkc3BpLmMNCkBAIC0xMzY1LDcgKzEzNjUsOSBAQCBzdGF0aWMg
aW50IGNxc3BpX21lbV9wcm9jZXNzKHN0cnVjdCBzcGlfbWVtICptZW0sIGNvbnN0IHN0cnVjdCBz
cGlfbWVtX29wICpvcCkNCiAJICogcmVhZHMsIHByZWZlciBTVElHIG1vZGUgZm9yIHN1Y2ggc21h
bGwgcmVhZHMuDQogCSAqLw0KIAkJaWYgKCFvcC0+YWRkci5uYnl0ZXMgfHwNCi0JCSAgICBvcC0+
ZGF0YS5uYnl0ZXMgPD0gQ1FTUElfU1RJR19EQVRBX0xFTl9NQVgpDQorCQkgICAgKG9wLT5kYXRh
Lm5ieXRlcyA8PSBDUVNQSV9TVElHX0RBVEFfTEVOX01BWCAmJg0KKwkJCSFvZl9kZXZpY2VfaXNf
Y29tcGF0aWJsZShjcXNwaS0+cGRldi0+ZGV2Lm9mX25vZGUsDQorCQkJCQkgICAgImludGVsLHNv
Y2ZwZ2EtcXNwaSIpKSkNCiAJCQlyZXR1cm4gY3FzcGlfY29tbWFuZF9yZWFkKGZfcGRhdGEsIG9w
KTsNCiANCiAJCXJldHVybiBjcXNwaV9yZWFkKGZfcGRhdGEsIG9wKTsNCmBgYA0KDQpUaGFua3Mg
YW5kIFJlZ2FyZHMsDQpZb3NoaXRha2EgSWtlZGENCg0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogWW9zaGl0YWthIElrZWRhIDxpa2VkYUBuc2tpbnQuY28uanA+DQo+
IFNlbnQ6IE1vbmRheSwgTWF5IDgsIDIwMjMgNDo0NCBQTQ0KPiBUbzogRGhydXZhIEdvbGUgPGQt
Z29sZUB0aS5jb20+DQo+IENjOiBsaW51eC1zcGlAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJu
ZWxAdmdlci5rZXJuZWwub3JnOyBWaWduZXNoDQo+IFJhZ2hhdmVuZHJhIDx2aWduZXNockB0aS5j
b20+OyBWYWlzaG5hdiBBY2hhdGggPHZhaXNobmF2LmFAdGkuY29tPjsNCj4gbGludXgtbXRkQGxp
c3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsN
Cj4gVGFrYWhpcm8uS3V3YW5vQGluZmluZW9uLmNvbTsgUHJhdHl1c2ggWWFkYXYgPHB0eWFkYXZA
YW1hem9uLmRlPjsNCj4gTWFyayBCcm93biA8YnJvb25pZUBrZXJuZWwub3JnPg0KPiBTdWJqZWN0
OiBSRTogW1BBVENIIHYyIDQvNF0gc3BpOiBjYWRlbmNlLXF1YWRzcGk6IHVzZSBTVElHIG1vZGUg
Zm9yIHNtYWxsDQo+IHJlYWRzDQo+IA0KPiBIaSBEaHJ1dmEsDQo+IA0KPiA+ID4gLSBFcnJvciBh
dCBzdGFydHVwDQo+ID4gPiAgICAtIEtlcm5lbCBsb2cNCj4gPiA+IFsgICAgMC45ODA1OThdICoq
KioqKioqKipzcGlfbWVtX29wIGR1bXAqKioqKioqKioqKioqKg0KPiA+ID4gWyAgICAwLjk4MDYx
M10gYWRkcjogbmJ5dGVzOjB4MCAsIGJ1c3dpZHRoIDB4MCwgZHRyIDB4MCwgdmFsIDB4MA0KPiA+
ID4gWyAgICAwLjk4NDIyM10gY21kOiBuYnl0ZXM6MHgxICwgYnVzd2lkdGggMHgxLCBkdHIgMHgw
LCBvcGNvZGUgMHg5Rg0KPiA+ID4gWyAgICAwLjk4ODY1Nl0gZGF0YTogbmJ5dGVzOjB4NiAsIGJ1
c3dpZHRoIDB4MSwgZHRyIDB4MCwgZGF0YSBkaXIgMHgxDQo+ID4gPiBbICAgIDAuOTkzMzYyXSAq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioNCj4gPiA+IFsgICAgMC45OTgz
MjldIHNwaS1ub3Igc3BpMC4wOiBmb3VuZCBtdDI1cWw1MTJhLCBleHBlY3RlZCBuMjVxNTEyYQ0K
PiA+ID4gWyAgICAxLjAwNjU3NF0gKioqKioqKioqKnNwaV9tZW1fb3AgZHVtcCoqKioqKioqKioq
KioqDQo+ID4gPiBbICAgIDEuMDA2NTgzXSBhZGRyOiBuYnl0ZXM6MHgzICwgYnVzd2lkdGggMHgx
LCBkdHIgMHgwLCB2YWwgMHgwDQo+ID4gPiBbICAgIDEuMDEwMTUwXSBjbWQ6IG5ieXRlczoweDEg
LCBidXN3aWR0aCAweDEsIGR0ciAweDAsIG9wY29kZSAweDVBDQo+ID4gPiBbICAgIDEuMDE0NTk2
XSBkYXRhOiBuYnl0ZXM6MHgxMCAsIGJ1c3dpZHRoIDB4MSwgZHRyIDB4MCwgZGF0YSBkaXIgMHgx
DQo+ID4gPiBbICAgIDEuMDE5Mjg1XSAqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioNCj4gPiA+IFsgICAgMS41MjQyNzFdIGNhZGVuY2UtcXNwaSBmZjcwNTAwMC5mbGFzaDog
Rmxhc2ggY29tbWFuZCBleGVjdXRpb24NCj4gPiB0aW1lZCBvdXQuDQo+ID4NCj4gPiBUaGlzIHBy
aW50IG1lc3NhZ2UgaXMgZnJvbSBjcXNwaV9leGVjX2ZsYXNoX2NtZC4gVGhpcyBmdW5jdGlvbiBz
aG91bGQNCj4gPiBvbmx5IGJlIGNhbGxlZCBmcm9tIGNxc3BpX2NvbW1hbmRfcmVhZC93cml0ZSAu
DQo+ID4NCj4gPiBIb3dldmVyLCBmcm9tIHNwaV9tZW1fb3AgZHVtcCB0aGF0IHlvdSBoYXZlIHBy
b3ZpZGVkIGFib3ZlLCB3aGVyZQ0KPiA+IGFkZHIubmJ5dGVzIGlzIDMgYW5kIGRhdGEubmJ5dGVz
IGlzIDB4MTAgKHdoaWNoIGlzID4gOCkgaXQgc2hvdWxkDQo+ID4gbmV2ZXIgaGF2ZSBlbnRlcmVk
IHRoZSBjcXNwaV9jb21tYW5kX3JlYWQgZnVuY3Rpb24uDQo+IA0KPiBUaGUgbG9jYXRpb24gb2Yg
dGhlIGxvZyBvdXRwdXQgaXMgYWZ0ZXIgdGhlIGNhbGwgdG8gY3FzcGlfbWVtX3Byb2Nlc3MoKSwg
c28gSQ0KPiBhc3N1bWUgaXQgaXMgY2FsbGVkIHdpdGggdGhlIGZvbGxvd2luZyBkYXRhLg0KPiAN
Cj4gWyAxLjUzMzQ4M10gKioqKioqKioqKnNwaV9tZW1fb3AgZHVtcCoqKioqKioqKioqKioqIFsg
MS41MzM0ODldIGFkZHI6DQo+IG5ieXRlczoweDMgLCBidXN3aWR0aCAweDEsIGR0ciAweDAsIHZh
bCAweDEwIFsgMS41MzcwNTVdIGNtZDogbmJ5dGVzOjB4MSAsDQo+IGJ1c3dpZHRoIDB4MSwgZHRy
IDB4MCwgb3Bjb2RlIDB4NUEgWyAxLjU0MTU3OV0gZGF0YTogbmJ5dGVzOjB4OCAsIGJ1c3dpZHRo
IDB4MSwNCj4gZHRyIDB4MCwgZGF0YSBkaXIgMHgxIFsgMS41NDYyNjZdICoqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKg0KPiANCj4gVGh1cywgdGhlIGNvbmRpdGlvbiBpcyBt
ZXQgYW5kIGNxc3BpX2NvbW1hbmRfcmVhZCgpIGlzIGNhbGxlZC4NCj4gV2UgaGF2ZSBhbHNvIGFw
cGxpZWQgdGhlIGZvbGxvd2luZyBwYXRjaCBhbmQgY29uZmlybWVkIHRoYXQgaXQgaXMgY2FsbGVk
Lg0KPiANCj4gLSBwYXRjaA0KPiBgYGANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc3BpL3NwaS1j
YWRlbmNlLXF1YWRzcGkuYw0KPiBiL2RyaXZlcnMvc3BpL3NwaS1jYWRlbmNlLXF1YWRzcGkuYw0K
PiBpbmRleCA2NGI2YTQ2MGQ3MzkuLjhkMzY4MWUxZjM1YyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy9zcGkvc3BpLWNhZGVuY2UtcXVhZHNwaS5jDQo+ICsrKyBiL2RyaXZlcnMvc3BpL3NwaS1jYWRl
bmNlLXF1YWRzcGkuYw0KPiBAQCAtMTM2NSwxNSArMTM2NSwyMSBAQCBzdGF0aWMgaW50IGNxc3Bp
X21lbV9wcm9jZXNzKHN0cnVjdCBzcGlfbWVtDQo+ICptZW0sIGNvbnN0IHN0cnVjdCBzcGlfbWVt
X29wICpvcCkNCj4gIAkgKiByZWFkcywgcHJlZmVyIFNUSUcgbW9kZSBmb3Igc3VjaCBzbWFsbCBy
ZWFkcy4NCj4gIAkgKi8NCj4gIAkJaWYgKCFvcC0+YWRkci5uYnl0ZXMgfHwNCj4gLQkJICAgIG9w
LT5kYXRhLm5ieXRlcyA8PSBDUVNQSV9TVElHX0RBVEFfTEVOX01BWCkNCj4gKwkJICAgIG9wLT5k
YXRhLm5ieXRlcyA8PSBDUVNQSV9TVElHX0RBVEFfTEVOX01BWCkgew0KPiArCQkJcHJpbnRrKCIt
LS0tLSAlZDolcygpICgxKSAtLS0tLVxuIiwgX19MSU5FX18sDQo+IF9fZnVuY19fKTsNCj4gIAkJ
CXJldHVybiBjcXNwaV9jb21tYW5kX3JlYWQoZl9wZGF0YSwgb3ApOw0KPiArCQl9DQo+IA0KPiAr
CQlwcmludGsoIi0tLS0tICVkOiVzKCkgKDIpIC0tLS0tXG4iLCBfX0xJTkVfXywgX19mdW5jX18p
Ow0KPiAgCQlyZXR1cm4gY3FzcGlfcmVhZChmX3BkYXRhLCBvcCk7DQo+ICAJfQ0KPiANCj4gLQlp
ZiAoIW9wLT5hZGRyLm5ieXRlcyB8fCAhb3AtPmRhdGEuYnVmLm91dCkNCj4gKwlpZiAoIW9wLT5h
ZGRyLm5ieXRlcyB8fCAhb3AtPmRhdGEuYnVmLm91dCkgew0KPiArCQlwcmludGsoIi0tLS0tICVk
OiVzKCkgKDMpIC0tLS0tXG4iLCBfX0xJTkVfXywgX19mdW5jX18pOw0KPiAgCQlyZXR1cm4gY3Fz
cGlfY29tbWFuZF93cml0ZShmX3BkYXRhLCBvcCk7DQo+ICsJfQ0KPiANCj4gKwlwcmludGsoIi0t
LS0tICVkOiVzKCkgKDQpIC0tLS0tXG4iLCBfX0xJTkVfXywgX19mdW5jX18pOw0KPiAgCXJldHVy
biBjcXNwaV93cml0ZShmX3BkYXRhLCBvcCk7DQo+ICB9DQo+IA0KPiBgYGANCj4gDQo+IC0gbG9n
DQo+IGBgYA0KPiBbICAgIDAuNzg2NjAwXSAtLS0tLSAxMzY5OmNxc3BpX21lbV9wcm9jZXNzKCkg
KDEpIC0tLS0tDQo+IFsgICAgMC43OTAzMTJdICoqKioqKioqKipzcGlfbWVtX29wIGR1bXAqKioq
KioqKioqKioqKg0KPiBbICAgIDAuNzkwMzE5XSBhZGRyOiBuYnl0ZXM6MHgwICwgYnVzd2lkdGgg
MHgwLCBkdHIgMHgwLCB2YWwgMHgwDQo+IFsgICAgMC43OTM4ODVdIGNtZDogbmJ5dGVzOjB4MSAs
IGJ1c3dpZHRoIDB4MSwgZHRyIDB4MCwgb3Bjb2RlIDB4OUYNCj4gWyAgICAwLjc5ODMyNV0gZGF0
YTogbmJ5dGVzOjB4NiAsIGJ1c3dpZHRoIDB4MSwgZHRyIDB4MCwgZGF0YSBkaXIgMHgxDQo+IFsg
ICAgMC44MDMwMTNdICoqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKg0KPiBb
ICAgIDAuODA3ODkyXSBzcGktbm9yIHNwaTAuMDogZm91bmQgbXQyNXFsNTEyYSwgZXhwZWN0ZWQg
bjI1cTUxMmENCj4gWyAgICAwLjgxNjA2Ml0gLS0tLS0gMTM3MzpjcXNwaV9tZW1fcHJvY2Vzcygp
ICgyKSAtLS0tLQ0KPiBbICAgIDAuODE5Nzc1XSAqKioqKioqKioqc3BpX21lbV9vcCBkdW1wKioq
KioqKioqKioqKioNCj4gWyAgICAwLjgxOTc4Ml0gYWRkcjogbmJ5dGVzOjB4MyAsIGJ1c3dpZHRo
IDB4MSwgZHRyIDB4MCwgdmFsIDB4MA0KPiBbICAgIDAuODIzMzQ4XSBjbWQ6IG5ieXRlczoweDEg
LCBidXN3aWR0aCAweDEsIGR0ciAweDAsIG9wY29kZSAweDVBDQo+IFsgICAgMC44Mjc3OTJdIGRh
dGE6IG5ieXRlczoweDEwICwgYnVzd2lkdGggMHgxLCBkdHIgMHgwLCBkYXRhIGRpciAweDENCj4g
WyAgICAwLjgzMjQ4MF0gKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqDQo+
IFsgICAgMC44Mzc0NDJdIC0tLS0tIDEzNjk6Y3FzcGlfbWVtX3Byb2Nlc3MoKSAoMSkgLS0tLS0N
Cj4gWyAgICAxLjM0NDY3MV0gY2FkZW5jZS1xc3BpIGZmNzA1MDAwLmZsYXNoOiBGbGFzaCBjb21t
YW5kIGV4ZWN1dGlvbiB0aW1lZA0KPiBvdXQuDQo+IFsgICAgMS4zNTAzMjhdICoqKioqKioqKipz
cGlfbWVtX29wIGR1bXAqKioqKioqKioqKioqKg0KPiBbICAgIDEuMzUwMzM0XSBhZGRyOiBuYnl0
ZXM6MHgzICwgYnVzd2lkdGggMHgxLCBkdHIgMHgwLCB2YWwgMHgxMA0KPiBbICAgIDEuMzUzOTAx
XSBjbWQ6IG5ieXRlczoweDEgLCBidXN3aWR0aCAweDEsIGR0ciAweDAsIG9wY29kZSAweDVBDQo+
IFsgICAgMS4zNTg0MjddIGRhdGE6IG5ieXRlczoweDggLCBidXN3aWR0aCAweDEsIGR0ciAweDAs
IGRhdGEgZGlyIDB4MQ0KPiBbICAgIDEuMzYzMTE0XSAqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioNCj4gWyAgICAxLjM2Nzk4MV0gc3BpLW5vciBzcGkwLjA6IG9wZXJhdGlv
biBmYWlsZWQgd2l0aCAtMTEwDQo+IFsgICAgMS4zNzUzNzZdIHNwaS1ub3Igc3BpMC4wOiBtdDI1
cWw1MTJhICg2NTUzNiBLYnl0ZXMpDQo+IGBgYA0KPiANCj4gPiBQbGVhc2UgY2FuIHlvdSBzaGFy
ZSB0aGUgZXhhY3Qgb3V0cHV0IG9mIHVuYW1lIC1hIHdoZXJlIHlvdSBvYnNlcnZlDQo+ID4gdGhp
cyBlcnJvcj8NCj4gDQo+IE15IGVudmlyb25tZW50IGhhcyBzaG9ydGVuZWQgdGhlIG91dHB1dCBv
ZiB1bmFtZSAtYSwgc28gaXQgbWF5IG5vdCBiZSB1c2VmdWwuDQo+IEluc3RlYWQsIEkgd2lsbCBn
aXZlIHlvdSBpbmZvcm1hdGlvbiBhYm91dCB0aGUga2VybmVsIEkgYW0gdXNpbmcuDQo+IEl0IGlz
IHRoZSBmb2xsb3dpbmcgKHY2LjMpOg0KPiBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20v
bGludXgva2VybmVsL2dpdC9zdGFibGUvbGludXguZ2l0L2NvbW1pdC8/aWQNCj4gPTQ1NzM5MWIw
MzgwMzM1ZDVlOWE1YmFiZGVjOTBhYzUzOTI4YjIzYjQNCj4gDQo+ID4gQXJlIHlvdSBjYXJyeWlu
ZyBhbnkgc29ydCBvZiBsb2NhbCBwYXRjaGVzPyBDYW4geW91IG1ha2Ugc3VyZSB0aGF0IHRoZQ0K
PiA+IENRU1BJX1NUSUdfREFUQV9MRU5fTUFYIGlzIDggaW4geW91ciBjYXNlIHRvbz8NCj4gDQo+
IFRoZXJlIGlzIG5vIGxvY2FsIHBhdGNoIGFuZCBDUVNQSV9TVElHX0RBVEFfTEVOX01BWCByZW1h
aW5zIDguDQo+IA0KPiAtLQ0KPiBUaGFua3MgYW5kIFJlZ2FyZHMsDQo+IFlvc2hpdGFrYSBJa2Vk
YQ0K
