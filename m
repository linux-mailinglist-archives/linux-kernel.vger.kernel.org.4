Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB72727D52
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 12:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234305AbjFHK4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 06:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233626AbjFHK4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 06:56:01 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9093CE6C;
        Thu,  8 Jun 2023 03:55:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hijlDKPXS6rSAUYIyCoqqx7xfmZ13Q6Pk1NPRd3LVYwnafdX13Zf2v35J1oI3agk+U7zxk1xu+72jWT9vKDj12+Ev9ouaWK48EbDPQ4mb1p1AyOHGR90Q8dCTYMDp0euK1REpeGAC01BttqAuuapWGoVn+HHgUrrWiAw3DKxl3ACQG+Aav3wqn7U79xfgceUf60r4DBcs+wlBFQJDnmNa1kPHcA9n+tUQoRBFgv//sCoy7nQIhSYt8Qz4iJwCuZBzx8HQQrBqS28gc97YWslqmARotn4txTsCjkm4fIPDwggzXWEkqWa6kCctq/nJ2QNDwiOSA47mFm5zR+XK0srFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NCpcjcT70TlN5RHlxuredBdGngA+K3+E/wmX8HsEoYw=;
 b=QEZZlt1J8uWLAYOBu+rQ7ErE6oUJFpB8nUVXmrsHar0b67FvUiOMZ8l07a8VDiULHcCpftnVdL8dLan+RZM92q9zqtzY59b0kHwQjhnJS+PRkM9MiQRMD8+tWRpebgyDJygPzmQ6Jco+Zjm/OG9znTnbryGZ7h0Yp6HDgS4IviQ6ByP7p9VusxklSxJgDxS076xta/sxFccr0E9ULdMkxmhcnET/mrElS19faZAoUP0nPolIx8VxL6lcbO+fdDQ1SAFb5ug+Au+uWHYlaGCQYWIz2DP3osHsbjQshovB98JQ7Sxmt3wdBDF9lRSyxHXBW2riYweGryPTAAiLjNKBww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NCpcjcT70TlN5RHlxuredBdGngA+K3+E/wmX8HsEoYw=;
 b=YkoXmDD61bpjbKI6JwwVMLIU0lI8bCqz99QWwFQFNfFi6Uww58KtdQ0Llt1w9yWd+nO58pwybXls+ZAAIrisWyAHQBeZ7/bjWnYw1yyR1MSuxB9XfJz5pvG3W6TYVE2yzPctEssyMSOXEqnGRBCHg+eTwqGdibvYvEsoawSfNyQ=
Received: from MN2PR12MB4333.namprd12.prod.outlook.com (2603:10b6:208:1d3::23)
 by SJ1PR12MB6292.namprd12.prod.outlook.com (2603:10b6:a03:455::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Thu, 8 Jun
 2023 10:55:56 +0000
Received: from MN2PR12MB4333.namprd12.prod.outlook.com
 ([fe80::af2b:af3d:a4ec:5673]) by MN2PR12MB4333.namprd12.prod.outlook.com
 ([fe80::af2b:af3d:a4ec:5673%5]) with mapi id 15.20.6455.037; Thu, 8 Jun 2023
 10:55:55 +0000
From:   "Mehta, Piyush" <piyush.mehta@amd.com>
To:     Rob Herring <robh@kernel.org>
CC:     "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "Paladugu, Siva Durga Prasad" <siva.durga.prasad.paladugu@amd.com>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "nava.manne@xilinx.com" <nava.manne@xilinx.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "Simek, Michal" <michal.simek@amd.com>,
        "git (AMD-Xilinx)" <git@amd.com>
Subject: RE: [PATCH 1/2] dt-bindings: reset: convert the xlnx,zynqmp-reset.txt
 to yaml
Thread-Topic: [PATCH 1/2] dt-bindings: reset: convert the
 xlnx,zynqmp-reset.txt to yaml
Thread-Index: AQHZmQzFYJwDBJ2eJES25hU5GHN3p69+81WAgAG07KA=
Date:   Thu, 8 Jun 2023 10:55:55 +0000
Message-ID: <MN2PR12MB4333E0628E2E67652E80067A8850A@MN2PR12MB4333.namprd12.prod.outlook.com>
References: <20230607065121.2265076-1-piyush.mehta@amd.com>
 <20230607065121.2265076-2-piyush.mehta@amd.com>
 <168612336438.2153757.6000360498539992409.robh@kernel.org>
In-Reply-To: <168612336438.2153757.6000360498539992409.robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR12MB4333:EE_|SJ1PR12MB6292:EE_
x-ms-office365-filtering-correlation-id: 7b1ec2a8-375b-43a9-df60-08db680eef6a
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vp8LRP74xpWM/OthUrRIWOT8I0G28QVzhaf7C8FwvGARWWUjavWnUcrl+ENpp6Pa7Yz6lq4tonQpNISk97VqYgvQWkZSg5ugJolTzY2LPQiA9S1pfWtv87NcNr3rC8jV2t3BXkL1iE/sPfJOlQdie9kF7+iYYAqnsMY4qsCQ8d7siiMEt+B/hUzrGXlAk0alW89QZrqVidWYtggcrbcS2xG7oLr/T9/ORJ4c/NC4oZme4zDG7WCSHwwgBB816G00ChI7yWRkpJGAFY0drginCmFTrnHJWkf+ui3GbHnu8G+UpI0FI8AZYe28w7r0JcSQ0Nt1cwVUrtTnL5ez3ghYf2OgZ62I88OQst5yG4aDoXYaLmLOx0MKVcEWFOMgilmTw8oNeyysujDHkgPJ9G2q1rj7/bm4/R+2OKfdo5jLKpdLw7gGdHFpZiD1gYue/vCnFn4WIYasXzBw9pZUDkb43np3vhf3ZIhQdcJVpKccR7aLiH8aolRGmoFKsTmJh9nYVA2UqTPpNeOroDPuygA2MVO/qmz+eMzTmBKkES/VbnZtmXu6wKtrfzQM1EE71swKPx7ug4YCJ549NpO31d6/V24eLTzWsiI04k3sv/QZNC0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4333.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(39860400002)(396003)(136003)(346002)(451199021)(186003)(26005)(6506007)(53546011)(9686003)(966005)(83380400001)(7416002)(7696005)(2906002)(71200400001)(8936002)(8676002)(33656002)(54906003)(478600001)(55016003)(6916009)(122000001)(41300700001)(316002)(5660300002)(38100700002)(4326008)(86362001)(38070700005)(66446008)(52536014)(66476007)(66556008)(64756008)(66946007)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aHN2ZFFGVVBzdTFrSUFIQjlDUHFSWi9mTDlTUWMrbkZBTkdvNGJDam8zVFIv?=
 =?utf-8?B?OFJaUXdnbTZvcmFLTUY5T0ozbUtLZXc5V1pLSUtZYU56VllwQk5hYU16cnIz?=
 =?utf-8?B?WGVkUUxBYW9UY0YvVjRVbFBjQkNVVWdWVk83U1lpdDhoWEMveE16czVmZ1Bl?=
 =?utf-8?B?MGtKMkR3aXZ0T21QejhxUmNZTGtPd1hmMGx0cllxTm1iWE8vZWk1WWtDQmRS?=
 =?utf-8?B?NitqcHRCbjZpTmk2c0p0eThPL0wreUF3TjQwUTlnT2YxZzNZdXlqTUN4eUJT?=
 =?utf-8?B?cXJFdkp5dHlHems0b2lxNHh4MDFsbUVsZEVLdWtPckdRdWlLMlVqbXRHQUZF?=
 =?utf-8?B?Y2R1ZVVyeWdnUzBBM3NUTU4zZVdFK2g1WTRwK0w1Vkw3Y2FGYlNKUjNRb1dE?=
 =?utf-8?B?ODVIOVNVTU9XSWhMM29oczViRzIrdG5CdzVRcWIrcmJ1anhwY0FMRGVnTHph?=
 =?utf-8?B?N2tISCtZWlZnR0tSSC8xYW1GMm9LUm50R3hvVnczYUNiYWNJRWJmc2VvQ3hG?=
 =?utf-8?B?RUl4djFNdE95TCtsdCt0TEQyVjdOYzRZdGhvZFNGZFdEYVFyWFZCY01sTlJ5?=
 =?utf-8?B?ZDhZZWpQUzBNeFNPek8yYmVIeGEyYjNqYUIzV0k0Q3lvVGpEeGZuR2FwRDUw?=
 =?utf-8?B?NkdkdExmSlF4Q2c3YzJpWlFrQnZsdFpSUzVDTGdNTlR2aUNGYWhSbVFpKy8z?=
 =?utf-8?B?MlpuN2loR2FqT3BBSDFpcndPbHZLc0w5OWNLMlYyVFYxVS85Sk9qNnB3dDlV?=
 =?utf-8?B?emZ0YzRGOTQvcGRWMENFK1Y5K0srbjVOMmY5OEgyb1QrR3FzSFdpT3BKQ0dn?=
 =?utf-8?B?MXdoV0JDRXNUd2g5bG1IbzkyNUdIcWxFS2p5R0RSMlZ2aytkb05oWS9iR3Zm?=
 =?utf-8?B?WUUxSitPS2xvQi90aVNvZUdiSndiOVR5K29Ea0VJYy9ZRE1ZaU1CZHJ3Q0RO?=
 =?utf-8?B?Y1RINE9kYzhsOGdFRzRiTGJ1ZWM3bks0UTNrTU9rVWphcDBLUFhZbktHYU5o?=
 =?utf-8?B?TTV4a1crSFNPSzQwTzRQL3c1YjVMM0dkbGRESTJGN29ubHhvUDdNSkg3dWNT?=
 =?utf-8?B?M2c2SlN1RTZwU2FCQWJGbklVRXJOV0JMMzZGLzNWMlI5dlhxQndVVVFYUzlI?=
 =?utf-8?B?VVRjU0VhSUh6QnlYcnZkYmkvWHYvenNKVE55Rnk4ekpQS0RKZ3Zua1AxZ1lT?=
 =?utf-8?B?a3dFM2pEWS9nR2JtMEsyaGtpNm02KzhKeGNSMUlNNThoSXl1N2hBK3FyZE1F?=
 =?utf-8?B?enJEOGJQMXhQSjkxdmx1Smo1UTBVa2xiQWZSR0gvV0poeHpjVVNUUUIrWExk?=
 =?utf-8?B?a05Dd0llVmhMZG9TUEVRVTVuTXRCT3BodTFIbVBVa01ldXdvTHZFVDRiN0o0?=
 =?utf-8?B?ejZXOXRYT0RMQUcybzJUWHVoT3M5eGM5RWZNTFpRc21wQ1hwSEZIM2pVMjVV?=
 =?utf-8?B?VEUrN2RUR2UrSlppTkNMcy9LZEtlemhYWVdjdXJrWHB3empPcTBKVGhiTzlC?=
 =?utf-8?B?eFNoMFhiWU5BTTJRTThPMFhYSnRqNVpNallWMUs1TzNoeVJzN1FsVys2M05s?=
 =?utf-8?B?SU16ZThINWk2WjlGZ2JBQlZwNldXZHcwa3NpdXdkT2pITktaOWtQdG1NbGtr?=
 =?utf-8?B?TjlKQlRLOTM4T3RkbFc1QzQ3SnM0emIra3Nsd2c1ZTIzZk9rVktRci9ZbThM?=
 =?utf-8?B?WndWV2dNRVZKR0N4UXdHa0J5ck5Ua296REZDL0hjL3crdEZ6OGlVd0lBTXJF?=
 =?utf-8?B?K0pQSnJUZDAxeG5nRC9CbFZjR1d1dGNCVFNScFRRT1E0SWNzTHpLZUdmaGNO?=
 =?utf-8?B?M3cxaFdIL2ZPNjFkeGVJTDJIQ3hVRGEvbWpaVnZqMktWaVptNFZyUlloNEpR?=
 =?utf-8?B?LzV6YU9aRE9PWEJzb0NhaGpZcFNMc1dKMnUrR0hnYzV0MFJ0blRVYUxZeWRo?=
 =?utf-8?B?dEdVc3BFMWxNejhaUWxmc1dGUG1kcENzMFprL2tKVGxhOVV5SHRYalBreWJu?=
 =?utf-8?B?bDJIL244dmhyNUxWUnJMNitvTmhoUHljR3ZUa3lGWGZxVXdTSTZVcEUrR2lT?=
 =?utf-8?B?c1JTdC9VKzQxK2RDL3BOcDdsNVRick1ZUEQ1Y1F6RWNNaDE0R2hUajlwVGJH?=
 =?utf-8?Q?ArIw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4333.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b1ec2a8-375b-43a9-df60-08db680eef6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2023 10:55:55.8097
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3gjY8ybZLdZK5b19D3/chQj2YZnHYO5fD4YqNqZgqbCbgEO2rmSgoFfZypVhnNFx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6292
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8sDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUm9iIEhlcnJp
bmcgPHJvYmhAa2VybmVsLm9yZz4NCj4gU2VudDogV2VkbmVzZGF5LCBKdW5lIDcsIDIwMjMgMTow
NiBQTQ0KPiBUbzogTWVodGEsIFBpeXVzaCA8cGl5dXNoLm1laHRhQGFtZC5jb20+DQo+IENjOiBw
LnphYmVsQHBlbmd1dHJvbml4LmRlOyBQYWxhZHVndSwgU2l2YSBEdXJnYSBQcmFzYWQNCj4gPHNp
dmEuZHVyZ2EucHJhc2FkLnBhbGFkdWd1QGFtZC5jb20+OyBtaWNoYWwuc2ltZWtAeGlsaW54LmNv
bTsNCj4gbmF2YS5tYW5uZUB4aWxpbnguY29tOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsg
bGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LXVzYkB2Z2VyLmtlcm5lbC5v
cmc7IGNvbm9yK2R0QGtlcm5lbC5vcmc7DQo+IGtyenlzenRvZi5rb3psb3dza2krZHRAbGluYXJv
Lm9yZzsgcm9iaCtkdEBrZXJuZWwub3JnOyBTaW1laywgTWljaGFsDQo+IDxtaWNoYWwuc2ltZWtA
YW1kLmNvbT47IGdpdCAoQU1ELVhpbGlueCkgPGdpdEBhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTog
W1BBVENIIDEvMl0gZHQtYmluZGluZ3M6IHJlc2V0OiBjb252ZXJ0IHRoZSB4bG54LHp5bnFtcC1y
ZXNldC50eHQNCj4gdG8geWFtbA0KPiANCj4gDQo+IE9uIFdlZCwgMDcgSnVuIDIwMjMgMTI6MjE6
MjAgKzA1MzAsIFBpeXVzaCBNZWh0YSB3cm90ZToNCj4gPiBDb252ZXJ0IHRoZSBiaW5kaW5nIHRv
IERUIHNjaGVtYSBmb3JtYXQuIEl0IGFsc28gdXBkYXRlcyB0aGUNCj4gPiByZXNldC1jb250cm9s
bGVyIGRlc2NyaXB0aW9uLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUGl5dXNoIE1laHRhIDxw
aXl1c2gubWVodGFAYW1kLmNvbT4NCj4gPiAtLS0NCj4gPiBOb3RlOg0KPiA+IFRoZSAxLzIgcGF0
Y2ggaW50cm9kdWNlZCBhIHdhcm5pbmcgcmVsYXRlZCB0byB0aGUgZHQgYmluZGluZyBjaGVjaywN
Cj4gPiB3aGljaCB3YXMgc3Vic2VxdWVudGx5IGZpeGVkIGluIHRoZSAyLzIgcGF0Y2guIFRoaXMg
d2FybmluZyBpcyBhDQo+ID4gY29udmVyc2lvbiB3YXJuaW5nIGR1ZSB0byBhIGRlcGVuZGVuY3kg
b24gZmlybXdhcmUgZHQgYmluZGluZy4NCj4gPg0KPiA+IFdhcm5pbmc6DQo+ID4gICBEVENfQ0hL
DQo+ID4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Jlc2V0L3hsbngsenlucW1w
LXJlc2V0LmV4YW1wbGUuZHRiDQo+ID4NCj4gL3NjcmF0Y2gvcGl5dXNobS90b3J2YWxkcy9saW51
eC9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcmVzZXQveGxuDQo+IHgsenlucW1w
LXJlc2V0LmV4YW1wbGUuZHRiOiB6eW5xbXAtZmlybXdhcmU6ICdyZXNldC1jb250cm9sbGVyJyBk
b2VzIG5vdA0KPiBtYXRjaCBhbnkgb2YgdGhlIHJlZ2V4ZXM6ICdwaW5jdHJsLVswLTldKycNCj4g
PiAJRnJvbSBzY2hlbWE6DQo+ID4gL3NjcmF0Y2gvcGl5dXNobS90b3J2YWxkcy9saW51eC9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZmlybQ0KPiA+IHdhcmUveGlsaW54L3hsbngs
enlucW1wLWZpcm13YXJlLnlhbWwNCj4gPg0KPiA+IFBsZWFzZSBzdWdnZXN0IHRvIG1lLCBpZiBp
dCdzIGZpbmUgdG8gbWFrZSBhIHNpbmdsZSBwYXRjaCBpbnN0ZWFkIG9mDQo+ID4gdGhlIHNlcGFy
YXRlIHBhdGNoIDEvMiBhbmQgMi8yLg0KPiA+IC0tLQ0KPiA+ICAuLi4vYmluZGluZ3MvcmVzZXQv
eGxueCx6eW5xbXAtcmVzZXQudHh0ICAgICAgfCA1NSAtLS0tLS0tLS0tLS0tLS0NCj4gPiAgLi4u
L2JpbmRpbmdzL3Jlc2V0L3hsbngsenlucW1wLXJlc2V0LnlhbWwgICAgIHwgNjcgKysrKysrKysr
KysrKysrKysrKw0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDY3IGluc2VydGlvbnMoKyksIDU1IGRl
bGV0aW9ucygtKSAgZGVsZXRlIG1vZGUNCj4gPiAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL3Jlc2V0L3hsbngsenlucW1wLXJlc2V0LnR4dA0KPiA+ICBjcmVhdGUgbW9k
ZSAxMDA2NDQNCj4gPiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcmVzZXQveGxu
eCx6eW5xbXAtcmVzZXQueWFtbA0KPiA+DQo+IA0KPiBNeSBib3QgZm91bmQgZXJyb3JzIHJ1bm5p
bmcgJ21ha2UgRFRfQ0hFQ0tFUl9GTEFHUz0tbSBkdF9iaW5kaW5nX2NoZWNrJw0KPiBvbiB5b3Vy
IHBhdGNoIChEVF9DSEVDS0VSX0ZMQUdTIGlzIG5ldyBpbiB2NS4xMyk6DQo+IA0KPiB5YW1sbGlu
dCB3YXJuaW5ncy9lcnJvcnM6DQo+IA0KPiBkdHNjaGVtYS9kdGMgd2FybmluZ3MvZXJyb3JzOg0K
PiAvYnVpbGRzL3JvYmhlcnJpbmcvZHQtcmV2aWV3LQ0KPiBjaS9saW51eC9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvcmVzZXQveGxueCx6eW5xbXAtDQo+IHJlc2V0LmV4YW1wbGUu
ZHRiOiB6eW5xbXAtZmlybXdhcmU6ICdyZXNldC1jb250cm9sbGVyJyBkb2VzIG5vdCBtYXRjaCBh
bnkgb2YNCj4gdGhlIHJlZ2V4ZXM6ICdwaW5jdHJsLVswLTldKycNCj4gCUZyb20gc2NoZW1hOiAv
YnVpbGRzL3JvYmhlcnJpbmcvZHQtcmV2aWV3LQ0KPiBjaS9saW51eC9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvZmlybXdhcmUveGlsaW54L3hsbngsenlucW1wLQ0KPiBmaXJtd2Fy
ZS55YW1sDQo+IA0KPiBkb2MgcmVmZXJlbmNlIGVycm9ycyAobWFrZSByZWZjaGVja2RvY3MpOg0K
PiANCj4gU2VlIGh0dHBzOi8vcGF0Y2h3b3JrLm96bGFicy5vcmcvcHJvamVjdC9kZXZpY2V0cmVl
LQ0KPiBiaW5kaW5ncy9wYXRjaC8yMDIzMDYwNzA2NTEyMS4yMjY1MDc2LTItcGl5dXNoLm1laHRh
QGFtZC5jb20NCj4gDQo+IFRoZSBiYXNlIGZvciB0aGUgc2VyaWVzIGlzIGdlbmVyYWxseSB0aGUg
bGF0ZXN0IHJjMS4gQSBkaWZmZXJlbnQgZGVwZW5kZW5jeQ0KPiBzaG91bGQgYmUgbm90ZWQgaW4g
KnRoaXMqIHBhdGNoLg0KPiANCj4gSWYgeW91IGFscmVhZHkgcmFuICdtYWtlIGR0X2JpbmRpbmdf
Y2hlY2snIGFuZCBkaWRuJ3Qgc2VlIHRoZSBhYm92ZSBlcnJvcihzKSwNCj4gdGhlbiBtYWtlIHN1
cmUgJ3lhbWxsaW50JyBpcyBpbnN0YWxsZWQgYW5kIGR0LXNjaGVtYSBpcyB1cCB0bw0KPiBkYXRl
Og0KPiANCj4gcGlwMyBpbnN0YWxsIGR0c2NoZW1hIC0tdXBncmFkZQ0KPiANCj4gUGxlYXNlIGNo
ZWNrIGFuZCByZS1zdWJtaXQgYWZ0ZXIgcnVubmluZyB0aGUgYWJvdmUgY29tbWFuZCB5b3Vyc2Vs
Zi4gTm90ZQ0KPiB0aGF0IERUX1NDSEVNQV9GSUxFUyBjYW4gYmUgc2V0IHRvIHlvdXIgc2NoZW1h
IGZpbGUgdG8gc3BlZWQgdXAgY2hlY2tpbmcNCj4geW91ciBzY2hlbWEuIEhvd2V2ZXIsIGl0IG11
c3QgYmUgdW5zZXQgdG8gdGVzdCBhbGwgZXhhbXBsZXMgd2l0aCB5b3VyIHNjaGVtYS4NCg0KVGhp
cyBkdF9iaW5kaW5nIHdhcm5pbmcgaXMga25vd24gdG8gdXMgYW5kIGlzIGNhcHR1cmVkIGluIGNv
bW1pdCBkZXNjcmlwdGlvbiBub3RlcyBhbmQgdG8gcmVzb2x2ZSBpdCwgd2UgbmVlZCB0byBhcHBs
eSAyLzIuDQpJIHdhbnQgdG8gdGFrZSBEVCBtYWludGFpbmVyIG9waW5pb24gaWYgd2Ugc2hvdWxk
IGtlZXAgdGhlIGZpeCBpbiAyLzIgb3IgbWVyZ2UgaXQgaW4gMS8yLg0KDQpSZWdhcmRzLA0KUGl5
dXNoIE1laHRhDQo=
