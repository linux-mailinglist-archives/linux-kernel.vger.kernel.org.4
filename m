Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1926160DAC2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 07:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232859AbiJZFy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 01:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232403AbiJZFyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 01:54:23 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE80B14C9;
        Tue, 25 Oct 2022 22:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1666763662; x=1698299662;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=pqzhzEQqk7VyB7Ab9+L27bxW5/MsoF/k24tq6q4/qpg=;
  b=p9G1jBLqdaK4AnoXFHM5G/6o8LVtuudw2NZ1XtEKLswdZCF2uLzJslji
   epaEQuKGm4IZX/haDydovmlsiWo4iAUNm7LX7mTD37zIZVkkaMfi/KD6R
   mwEwSIe0zS/Zy/YgNCjNgW271BGB80o75yhPXgWZRLXG/pzSFQAjG7v+l
   D44geiVW4Tl9iuosj7uACiAs/Gst5NvYAA37DNrR0sKDG3gyUHPROkHMo
   lzvajYW1LF0iFilsk9Cu2G90Cw1+5iVyBhTThklnvY7mczitXQ/8BGE04
   4Uklefw72MS/TCldkCwe16HrAVO3Q5QxxfkwNTabM59g2hZA6UA6uacPn
   A==;
X-IronPort-AV: E=Sophos;i="5.95,213,1661842800"; 
   d="scan'208";a="120382490"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Oct 2022 22:54:21 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 25 Oct 2022 22:54:20 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Tue, 25 Oct 2022 22:54:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=maBfLWmFMPsDHA43OJCc28VSm8QcA6ZX7HEhiUKunkP9DvcXduZWjVfarbyTUNGtRVtGBkilTvT5SvClHsFFf8L4Hcfm3+8Cke843bcaIS2XZSPQgKyPcDV4UX3hr2znmwbX5H7Tc458pInzFiq1isqTKU+HlDSaSo4iVstXEvKEfp2oOiXNNAGauA+0Gf11uRraRgu5+rF6jODR+nSgGwhMUkPJ8yo5/MQUQ+w3rqGY275MzeWgRr8G6r3Go7Wr7r1ZWDzI3bYBLLuUs1vDQdNhIiT68a2n1oKOl2pDSzIgZKv+cmoH5IY9XOOoHkA6vec07PklkBZpbxNFD3pD0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pqzhzEQqk7VyB7Ab9+L27bxW5/MsoF/k24tq6q4/qpg=;
 b=YOPPaM3OVN4gWFTvwwqvW86VXE2e6ExlIWLOGyPPIeatfdhcAZd5nyuEoV1rxWPfcW670xzPgvZ9TFbIbldglRozETjXLFfpbSdWcsnoh3IY/0hAEkLbPe1p3457GCqjrWzDbPCBQhVUhuD76kEFkrodJdq2A7PcjGXjuQELx8ievkIgR0zIx0VAsQwnTqLLMktP6AYUaTdK0pQxgLaychTIu3qCpSl9ZPRpTImRreZ0ARaMLY0DeNWVLQB1XtCfYBERSnw2H+zMZX3yDgEC83yiat/rsGNciRo3GF/uN5kpiKbIsOS6G0tHM1XMdhTAFo5oDdZhXLrthqtJc7c2dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pqzhzEQqk7VyB7Ab9+L27bxW5/MsoF/k24tq6q4/qpg=;
 b=DqFbOOKPQ4FgsoDyfDoJly57ORYHJHwOudzXYKusmQYJ3tW/RVYk+fxFXzfaeeNVQXLrOLV4IGRb9oABGEMiGc+ybZfe6OKFxO2v+HXxYDEqP4u/FAvj3jltDakXIVKbjrCcryklW8+5WrMR320IoyiajzJjPmWk/iLScVGnwGY=
Received: from SN6PR11MB2749.namprd11.prod.outlook.com (2603:10b6:805:5f::16)
 by MW4PR11MB5910.namprd11.prod.outlook.com (2603:10b6:303:189::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Wed, 26 Oct
 2022 05:54:16 +0000
Received: from SN6PR11MB2749.namprd11.prod.outlook.com
 ([fe80::c345:76f0:58a8:31ba]) by SN6PR11MB2749.namprd11.prod.outlook.com
 ([fe80::c345:76f0:58a8:31ba%6]) with mapi id 15.20.5746.028; Wed, 26 Oct 2022
 05:54:16 +0000
From:   <Padmarao.Begari@microchip.com>
To:     <conor@kernel.org>, <Conor.Dooley@microchip.com>
CC:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <linux-kernel@vger.kernel.org>,
        <Daire.McNamara@microchip.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [RFC] riscv: dts: microchip: add OPPs to mpfs
Thread-Topic: [RFC] riscv: dts: microchip: add OPPs to mpfs
Thread-Index: AQHY5+AqRQC095ECRkKX8E8fBbJFtq4gLwGA
Date:   Wed, 26 Oct 2022 05:54:16 +0000
Message-ID: <bf68f00675b5cbc6ba8099496ddb68ed20e84f05.camel@microchip.com>
References: <20221024193647.1089769-1-conor@kernel.org>
In-Reply-To: <20221024193647.1089769-1-conor@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR11MB2749:EE_|MW4PR11MB5910:EE_
x-ms-office365-filtering-correlation-id: cbae2e58-a501-4c60-0d67-08dab716846f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2lKKMLgv7EQqc4GTu3EaBTJyBQ1A7J6tWy/2/PhfTRsIFo5cmoh0WrZJh5K1pc0M6Swbw6QyRy3SpVv4Z/EqQa2MWmpyijv/tRw8Ao/o+0DFJFStmF3IwQd+o2WSwd3EoqML51gV/R6Cvr81tw+oitOfpYpGeHWj2e2QyfpG41wWug2ATHzwfZkvqGtYwSp4GkcjsfDH7MeMoNFpUUl1Gi2c3/07+xBxUhzv7GL9S3KLBuSL6c1tHTLKV/MFtbxnqlSX020haSfsEWOPadKuqwA0FNCNrPKzqaTfnM2Y9f/F0xzoFG/a++vgS4zoPVs9KVqXRDuY94X1vFy28pmAzDLBD0y56SofjKRwUAgCCG/QQlosqkUqjo/TtB4DuE3cbixqRes7YBG1YprQoW7Y7EAcKMipNdv/98C8bpMxk/0K8YNcpF8z7OY0GNrTp9xXB5EOvFe8C3GybIzXfR2/9WPN0qjTD/+DCpoX6duAGZ9pPa7timwBuyGxaWsYjeSvpB1ftpHTAWa7WBXyCeGF4PIV0RmDNKso6qNIWaqJHSxDteedQHPcTearmz1Rn+79rH+4jCjf6HmDYg/eMXRU6dN7ZIN6jA2pmPaAgselu33AsD0iXUs4jgjo+CZe/PIkxP6ucDV3VooPoY+Vzh/gFEtfbsjGzjkpQvbxQVfPwUqd7DWsrnFHEuyLlu4G9yC+TAXMM5c02j4AOT3dxWMCtLe4brqGwXkLc/EfxVmDJca+YRkng9FMOlS0APuBYrKbZ3Z6CF1eBT6xtUbvavnlrQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB2749.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(136003)(396003)(39860400002)(376002)(451199015)(38070700005)(86362001)(38100700002)(71200400001)(4001150100001)(2906002)(6486002)(36756003)(478600001)(110136005)(8676002)(26005)(316002)(5660300002)(4326008)(91956017)(66446008)(66476007)(66556008)(66946007)(76116006)(64756008)(8936002)(54906003)(6636002)(41300700001)(6506007)(83380400001)(122000001)(6512007)(2616005)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U28yZ0hZZmIwNEh1UFZvbjZZdzBKdTc1VG9kVjhSUWNlaCsxdk5tSkFHZEdx?=
 =?utf-8?B?WkhSb1VoQkowSnJ1WjliVnFqVFdpTkJ5M01rVUVkTFEvNTRUbndOdDZiOUJR?=
 =?utf-8?B?VWhocGt0TWtXQjhBQ2V1dDV6bkFhZExUbUIxNnM1TzhDK3VTUm0xeDZrSWhk?=
 =?utf-8?B?UkdtWkQ3RUxrWk1WRG1uUnM4S1E2eEtoaittNWJrbDlwUFJORVZuUnpKdlJV?=
 =?utf-8?B?TkFNcHJlSXpTeFlYT0wvSHRUcHlpYXhlMWpIZ08xN0hTalRiWmhiMW12OFFM?=
 =?utf-8?B?cmJRSjRHYWhhVHIzMmFBeHcxMm44RFl1ZDlreTdReXc4a3R6aGhFaCtGNjFy?=
 =?utf-8?B?bzZJTFdxYW9Od2g1YjVSZTFsT1AvY2dHUlBFQm9EWlZ4YWpGcXJldVRmWkZ0?=
 =?utf-8?B?MDlQQWRIeFhzSkZTWjhBUTI5QTNQN2xkdnhhcm9kK3VOY2g5ZTd4c0NhWU1n?=
 =?utf-8?B?cEcreHcwWEpZZ00xbVdtNm5vMmNaeDYzK1l6dVhlbFZWQkhYNTZVamNrR20v?=
 =?utf-8?B?c0V4Um5YenhFTWZHaWQ1SUxITWFwcDNsajJwV2tIVHIzZVNiSlF5Z2t0Z3F1?=
 =?utf-8?B?ejFlNVBMOFBYbExFTGhjckZVM1YwSkdxM0UrdXNIZG42eDE4aXpHWE5HVTQy?=
 =?utf-8?B?dzI4MHFBMFg0cmk1TWsyeHpZbGl2QVA5WlZ5eGJJamxMblQzYkw2SzN0eE5V?=
 =?utf-8?B?WlYxWGUxV3JUUkd1RmxKaDRHWFJpcXh5Sld6QzhXa2lUZ1dFSzNsR1c4WmEy?=
 =?utf-8?B?K0JlV2dtcGtMZjk3R1pqdlBVZ29KTFpMblZtU0NkUWFYcnRXNUU0MTdpYmht?=
 =?utf-8?B?NzlpYUVQOE9wTUc3ZVpVM2xUM2lJNUZmSHE2aTUzdng1VmF3eFJTcWk1MXN0?=
 =?utf-8?B?KzFneWFxSlgwRmxBTHB4WHJxa2dXOWJOREw0TlY4NmlpcjZCK1picmpyL2lw?=
 =?utf-8?B?YThKL3R4dHZ3YzhXZ0hEemNJNHVrRUJVenRBakVaSDk2KzYrb2lZSmM1VEQx?=
 =?utf-8?B?dytmNHdiOWxLSy94NGdXQnFIR1RUNXFKNlpLVlpPTFFZM2ppa3E2amNFVDJC?=
 =?utf-8?B?NWVIV3VBUS9iemc2bE5jV3g4TFphUURFcnlJUXdCVFREc1gvd3hETDl5ckV2?=
 =?utf-8?B?Z0daRE5rd1pnZVRXUFJiRTN4NVJHRmxnSTdSd1ZMUTIwQ3VTMlprdzVLc2s3?=
 =?utf-8?B?d0FTNFI3WWlqMkpPVk9XQ1ZZeitpMkRmQkpadTFjaTVHalUzS1NvVDd3MllJ?=
 =?utf-8?B?UUFsYkJQMFdNeUhYUUx2Q3RyVjIxMUtMcHRJOXdBR3RJd0lyRVZ1ell2SHN2?=
 =?utf-8?B?d09Lck1MUmNUSzBpZW0vN3kxNU9lRVdWVmIzS0lRTnVzS3I1b3JOYTh5Y0dT?=
 =?utf-8?B?Q0xoVmpTVWFpU0ZraWQ3Z3YrZENNTFdZeGRRd3ZkZDl1NzFuWXdVSHg5TFhw?=
 =?utf-8?B?UWFtTTZDcnUvTktaUlpWNVIyT3FSMFlWQkdtNXNLRnJxa00vRk9oTmlXeGJJ?=
 =?utf-8?B?ZWJvOW9JOVBGZGtPaHhtZ3VuWkNwb0xtMmt6Qk5rak1RRGhUUXRQZHF3UXNn?=
 =?utf-8?B?RVE3eTMyZVFTUjdVRFlmQWlERXo0UjlOWUh4SnF2dDlNalp4REJoa1FRTmRt?=
 =?utf-8?B?OWV4WmxwS2g1RnpNOW5qNHk0bnZjV2RQbytqbjJYRkJDOC9IalZzdlZ5RTFP?=
 =?utf-8?B?Ny83WThXclRUR3ZTbHlTQTFSYkxhZ3JlYkJJcE1VcVV1clRNVFNhVFhQNHh4?=
 =?utf-8?B?aXdiRE5DREVxSTJNb2FKVlNBUFZac0w0QmZXaHdvaTBLNjk3QTg4eDdsdnVv?=
 =?utf-8?B?OTVIRTdxMWMyQy9LRGdVVGVtM2thUkZ0cTFhWDA2c2grVjlXS09vOEIxbnQ2?=
 =?utf-8?B?T0hpOVc2aFJET3VOSWZQeWhKdDVGV3o1KzJGV0ZVSW9POWNrMzNybXpJWGJJ?=
 =?utf-8?B?TVoxSEtvR0xkK216WkxuSy9kSnIweXlLck1uaGVBVGVpUDNFcUd6VWVlN1c3?=
 =?utf-8?B?enFvd0V2SEliQWNkMjBCZmQrN21CL2dZQnBDSEl5UENQN3dNbmZ6dTN1Rm9o?=
 =?utf-8?B?b1JOZ3gyTkQrbVk3UXdnQmRkcERiczN3KzN6UnVjYzMwdmppU0JUYmtqWHEz?=
 =?utf-8?B?VURFYzFJT28zRDR0MTI3cU83TS9hK1lGUUo0ajBManZlODh2TUhEYVVyUXVU?=
 =?utf-8?B?eHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D52E5BD6C5CE824BAE1D51A2C2F2CEF0@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB2749.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbae2e58-a501-4c60-0d67-08dab716846f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2022 05:54:16.4755
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v4wieY11NygPLbKfJlbs6xVSbe/xiJl59STJ0iDF3YMvTCBnaYWQKeiFEBhwZ71n3lT8WDKqhRX5yG2BRp6JeAbg8wif2WPjFoB/Gl40O90=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5910
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ29ub3IsDQo+IE9uIE1vbiwgMjAyMi0xMC0yNCBhdCAyMDozNiArMDEwMCwgQ29ub3IgRG9v
bGV5IHdyb3RlOg0KPiANCj4gRnJvbTogQ29ub3IgRG9vbGV5IDxjb25vci5kb29sZXlAbWljcm9j
aGlwLmNvbT4NCj4gDQo+IFRoZSBVLUJvb3QgZHRzIGZvciBtcGZzIGRlZmluZXMgdGhyZWUgT1BQ
cyB3aGljaCBhcmUgbWlzc2luZyBmcm9tIHRoZQ0KPiBMaW51eCBkdHMuIEZvciBlYXNlIG9mIHN5
bmNocm9uaXNhdGlvbiBvZiB0aGUgdHdvLCBhZGQgdGhlIG1pc3NpbmcNCj4gT1BQcw0KPiB0byB0
aGUgTGludXggZHQgdG9vLg0KPiANCj4gQ0M6IFBhZG1hcmFvIEJlZ2FyaSA8cGFkbWFyYW8uYmVn
YXJpQG1pY3JvY2hpcC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IENvbm9yIERvb2xleSA8Y29ub3Iu
ZG9vbGV5QG1pY3JvY2hpcC5jb20+DQo+IC0tLQ0KPiANCj4gSGV5IFBhZG1hcmFvLA0KPiBJJ3Zl
IGJlZW4gdHJ5aW5nIHRvIHBpY2sgb2ZmIHRoZSBiaXRzIHRoYXQncmUgZGlmZmVyZW50IGJldHdl
ZW4gdGhlDQo+IExpbnV4DQo+ICYgVS1Cb290IGR0cy4gRG8geW91IHJlbWVtYmVyIHdoeSB3ZSBh
ZGRlZCBPUFBzIHRvIHRoZSBVLUJvb3QgZHRzIGJ1dA0KPiBkaWRuJ3QgcHJvcGFnYXRlIHRoZW0g
ZWxzZXdoZXJlPw0KPiANCg0KSW5pdGlhbGx5IFdlIGFkZGVkIE9QUHMgdG8gdGhlIExpbnV4IGR0
cyBmb3IgdGhlIENQVSBGcmVxdWVuY3kgYW5kDQpWb2x0YWdlIHNjYWxpbmcgd2hpbGUgYnJpbmdp
bmcgdXAgdGhlIExpbnV4IG9uIGFuIEVtdWxhdGlvbiBQbGF0Zm9ybQ0KYW5kIHRoZSBJY2ljbGUg
S2l0IGZvciBQb2xhckZpcmUgU29DIGFuZCBzYW1lIGR0cyB1c2VkIGZvciB0aGUgVS1Cb290DQpi
dXQgdGhlIFUtQm9vdCBkdHMgdXBzdHJlYW1lZCBmaXJzdC4NCg0KUmVnYXJkcw0KUGFkbWFyYW8g
DQogDQo+ICBhcmNoL3Jpc2N2L2Jvb3QvZHRzL21pY3JvY2hpcC9tcGZzLmR0c2kgfCAyMyArKysr
KysrKysrKysrKysrKysrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDIzIGluc2VydGlvbnMoKykN
Cj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL3Jpc2N2L2Jvb3QvZHRzL21pY3JvY2hpcC9tcGZzLmR0
c2kNCj4gYi9hcmNoL3Jpc2N2L2Jvb3QvZHRzL21pY3JvY2hpcC9tcGZzLmR0c2kNCj4gaW5kZXgg
MGE5YmI4NGFmNDM4Li45ZDlmZjcxNzQzNDEgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvcmlzY3YvYm9v
dC9kdHMvbWljcm9jaGlwL21wZnMuZHRzaQ0KPiArKysgYi9hcmNoL3Jpc2N2L2Jvb3QvZHRzL21p
Y3JvY2hpcC9tcGZzLmR0c2kNCj4gQEAgLTIzLDYgKzIzLDcgQEAgY3B1MDogY3B1QDAgew0KPiAg
ICAgICAgICAgICAgICAgICAgICAgICByZWcgPSA8MD47DQo+ICAgICAgICAgICAgICAgICAgICAg
ICAgIHJpc2N2LGlzYSA9ICJydjY0aW1hYyI7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgIGNs
b2NrcyA9IDwmY2xrY2ZnIENMS19DUFU+Ow0KPiArICAgICAgICAgICAgICAgICAgICAgICBvcGVy
YXRpbmctcG9pbnRzLXYyID0gPCZjbHVzdGVyMF9vcHBzPjsNCj4gICAgICAgICAgICAgICAgICAg
ICAgICAgc3RhdHVzID0gImRpc2FibGVkIjsNCj4gDQo+ICAgICAgICAgICAgICAgICAgICAgICAg
IGNwdTBfaW50YzogaW50ZXJydXB0LWNvbnRyb2xsZXIgew0KPiBAQCAtNTEsNiArNTIsNyBAQCBj
cHUxOiBjcHVAMSB7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgIGNsb2NrcyA9IDwmY2xrY2Zn
IENMS19DUFU+Ow0KPiAgICAgICAgICAgICAgICAgICAgICAgICB0bGItc3BsaXQ7DQo+ICAgICAg
ICAgICAgICAgICAgICAgICAgIG5leHQtbGV2ZWwtY2FjaGUgPSA8JmNjdHJsbHI+Ow0KPiArICAg
ICAgICAgICAgICAgICAgICAgICBvcGVyYXRpbmctcG9pbnRzLXYyID0gPCZjbHVzdGVyMF9vcHBz
PjsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgc3RhdHVzID0gIm9rYXkiOw0KPiANCj4gICAg
ICAgICAgICAgICAgICAgICAgICAgY3B1MV9pbnRjOiBpbnRlcnJ1cHQtY29udHJvbGxlciB7DQo+
IEBAIC03OSw2ICs4MSw3IEBAIGNwdTI6IGNwdUAyIHsNCj4gICAgICAgICAgICAgICAgICAgICAg
ICAgY2xvY2tzID0gPCZjbGtjZmcgQ0xLX0NQVT47DQo+ICAgICAgICAgICAgICAgICAgICAgICAg
IHRsYi1zcGxpdDsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgbmV4dC1sZXZlbC1jYWNoZSA9
IDwmY2N0cmxscj47DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIG9wZXJhdGluZy1wb2ludHMt
djIgPSA8JmNsdXN0ZXIwX29wcHM+Ow0KPiAgICAgICAgICAgICAgICAgICAgICAgICBzdGF0dXMg
PSAib2theSI7DQo+IA0KPiAgICAgICAgICAgICAgICAgICAgICAgICBjcHUyX2ludGM6IGludGVy
cnVwdC1jb250cm9sbGVyIHsNCj4gQEAgLTEwNyw2ICsxMTAsNyBAQCBjcHUzOiBjcHVAMyB7DQo+
ICAgICAgICAgICAgICAgICAgICAgICAgIGNsb2NrcyA9IDwmY2xrY2ZnIENMS19DUFU+Ow0KPiAg
ICAgICAgICAgICAgICAgICAgICAgICB0bGItc3BsaXQ7DQo+ICAgICAgICAgICAgICAgICAgICAg
ICAgIG5leHQtbGV2ZWwtY2FjaGUgPSA8JmNjdHJsbHI+Ow0KPiArICAgICAgICAgICAgICAgICAg
ICAgICBvcGVyYXRpbmctcG9pbnRzLXYyID0gPCZjbHVzdGVyMF9vcHBzPjsNCj4gICAgICAgICAg
ICAgICAgICAgICAgICAgc3RhdHVzID0gIm9rYXkiOw0KPiANCj4gICAgICAgICAgICAgICAgICAg
ICAgICAgY3B1M19pbnRjOiBpbnRlcnJ1cHQtY29udHJvbGxlciB7DQo+IEBAIC0xMzYsNiArMTQw
LDcgQEAgY3B1NDogY3B1QDQgew0KPiAgICAgICAgICAgICAgICAgICAgICAgICB0bGItc3BsaXQ7
DQo+ICAgICAgICAgICAgICAgICAgICAgICAgIG5leHQtbGV2ZWwtY2FjaGUgPSA8JmNjdHJsbHI+
Ow0KPiAgICAgICAgICAgICAgICAgICAgICAgICBzdGF0dXMgPSAib2theSI7DQo+ICsgICAgICAg
ICAgICAgICAgICAgICAgIG9wZXJhdGluZy1wb2ludHMtdjIgPSA8JmNsdXN0ZXIwX29wcHM+Ow0K
PiAgICAgICAgICAgICAgICAgICAgICAgICBjcHU0X2ludGM6IGludGVycnVwdC1jb250cm9sbGVy
IHsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAjaW50ZXJydXB0LWNlbGxzID0g
PDE+Ow0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAicmlz
Y3YsY3B1LWludGMiOw0KPiBAQCAtMTY2LDYgKzE3MSwyNCBAQCBjb3JlNCB7DQo+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgfTsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgfTsN
Cj4gICAgICAgICAgICAgICAgIH07DQo+ICsNCj4gKyAgICAgICAgICAgICAgIGNsdXN0ZXIwX29w
cHM6IG9wcC10YWJsZSB7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAi
b3BlcmF0aW5nLXBvaW50cy12MiI7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIG9wcC1zaGFy
ZWQ7DQo+ICsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgb3BwLTYwMDAwMDAwMCB7DQo+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICBvcHAtaHogPSAvYml0cy8gNjQgPDYwMDAwMDAwMD47
DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICBvcHAtbWljcm92b2x0ID0gPDExMDAwMDA+
Ow0KPiArICAgICAgICAgICAgICAgICAgICAgICB9Ow0KPiArICAgICAgICAgICAgICAgICAgICAg
ICBvcHAtMzAwMDAwMDAwIHsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgIG9wcC1oeiA9
IC9iaXRzLyA2NCA8MzAwMDAwMDAwPjsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgIG9w
cC1taWNyb3ZvbHQgPSA8OTUwMDAwPjsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgfTsNCj4g
KyAgICAgICAgICAgICAgICAgICAgICAgb3BwLTE1MDAwMDAwMCB7DQo+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICBvcHAtaHogPSAvYml0cy8gNjQgPDE1MDAwMDAwMD47DQo+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICBvcHAtbWljcm92b2x0ID0gPDc1MDAwMD47DQo+ICsgICAgICAg
ICAgICAgICAgICAgICAgIH07DQo+ICsgICAgICAgICAgICAgICB9Ow0KPiAgICAgICAgIH07DQo+
IA0KPiAgICAgICAgIHJlZmNsazogbXNzcmVmY2xrIHsNCj4gLS0NCj4gMi4zOC4wDQo+IA0K
