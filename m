Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 842CB6EFE94
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 02:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242869AbjD0Aln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 20:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239903AbjD0All (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 20:41:41 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2043.outbound.protection.outlook.com [40.107.114.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A1230EB;
        Wed, 26 Apr 2023 17:41:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KUgWKDBKT9TFo/vWQpOSZpjVHsNi9Zi2lLqq5l4vx+GWZ5mNHM3G6HLhK+EeIfJZktmcjO3rRWQNgkJrOWslALC4GRkdJX4KvZN9wEdJ6IdW9ttaHaNgjBoasvTa28WAPSbuhnVP8q333W3jXCddFG61URQ/VJO4spmv7+OeSzekEVDcD/3XTSObZ+J/Y0jkYmpkZWWqUjaT515ifvvIpl6LZw5SxiZEKMzx6El6e6ea40azoDK4y3mPvZeygSos79ogPEXxADlBImv8dVlfrTbHibtbaA0fQ72QmP+JitGLDJRZPHnX9MnDInbXLOD9dQetQ4WJKYfMYsnqlnTsHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P/SpcnzS56kXju/AWlpTPH/4kyooXsj/pnCBF1hsZVU=;
 b=ZRA5IZN5X/+6FjXK7QWJT8aliJPy49NinAv+I58o3/Bp4WmzS0vak7qg1V0ebLHn46MpExnR2f71Rz17XLlKsOOcjijHdpRsirwNlUahCCj3jbyVUWmbsiyyD/8D/9ogSbE/36PDXXkkuRQpENmOcx7rpfm5AFjY6gd+oyS6580w+Unv6qpthvJbbrigrqwuuButHAyRzVWeiY8B6b803CNl6XznkB1gb7K2DENzoDc9vS++7d6T9mxC6kJj21BS+i1BugnXJkEbDMFtN2S4q8qFk/xS9NxxXSurivbC+ZUwV1vB+Z0J9hWHlx1yxCqfflvbm4sd7rSpqmM5dBtznA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nskint.co.jp; dmarc=pass action=none header.from=nskint.co.jp;
 dkim=pass header.d=nskint.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nskint.onmicrosoft.com; s=selector1-nskint-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P/SpcnzS56kXju/AWlpTPH/4kyooXsj/pnCBF1hsZVU=;
 b=CzPOzYQAHv8bqigyYBDBnNpZBHrfkbS0kat8qG/YirArQXtlbr6zDojGogJb2phVWrKPB0kglP+b4g39aJG+JasL3FSql3IVQulpuaF4yLYDnw/L1lrF2eLuiCQPfvN1Wldky8pZlqlKY17ny/fIVomvv8icyhnuJeDfkuWkupo=
Received: from OSZPR01MB7004.jpnprd01.prod.outlook.com (2603:1096:604:13c::9)
 by TYAPR01MB5994.jpnprd01.prod.outlook.com (2603:1096:402:31::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22; Thu, 27 Apr
 2023 00:41:36 +0000
Received: from OSZPR01MB7004.jpnprd01.prod.outlook.com
 ([fe80::148a:7cac:32d9:1c03]) by OSZPR01MB7004.jpnprd01.prod.outlook.com
 ([fe80::148a:7cac:32d9:1c03%6]) with mapi id 15.20.6340.021; Thu, 27 Apr 2023
 00:41:36 +0000
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
        Mark Brown <broonie@kernel.org>,
        Yoshitaka Ikeda <ikeda@nskint.co.jp>
Subject: RE: [PATCH v2 4/4] spi: cadence-quadspi: use STIG mode for small
 reads
Thread-Topic: [PATCH v2 4/4] spi: cadence-quadspi: use STIG mode for small
 reads
Thread-Index: AQHZMJVBHgHXafuso0ywMCCxmHrW5689ZDXggABfGwCAARZ4MA==
Date:   Thu, 27 Apr 2023 00:41:36 +0000
Message-ID: <OSZPR01MB7004D229048A950C93B40CC88B6A9@OSZPR01MB7004.jpnprd01.prod.outlook.com>
References: <20230125081023.1573712-1-d-gole@ti.com>
 <20230125081023.1573712-5-d-gole@ti.com>
 <OSZPR01MB70048CE259A3D63C4179199A8B659@OSZPR01MB7004.jpnprd01.prod.outlook.com>
 <044a723e-b81e-f6f2-8bf7-3680a10abc86@ti.com>
In-Reply-To: <044a723e-b81e-f6f2-8bf7-3680a10abc86@ti.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nskint.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB7004:EE_|TYAPR01MB5994:EE_
x-ms-office365-filtering-correlation-id: 26fe160a-fda2-4a37-5d92-08db46b8283d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8vVOh7DNs32EJhh7WHsbhKKPCWU8QVN5R7AG7cFjlDvwS9QU8J8s5jnFGmHXm0ChMq3pj3EKoLxeoWFlLqRLw0/TgrZnIpF6bQrK5Vo0DiXfKqwYsf5fB5NlBboVcR3bYdS1L5smsj58UoYijyLw7Rq8uVVCk0bTcGnHRhaEyDHfN+a9+532tPbgYsafqmBSYQvfcojWglvWNyDKihGZZTD5xXSYPQieX4+dVoZwnoHf2Wj+utmQ1BEVqoCTp5X6+1Sse20D+zOgO0/ahA/3Rtvq8ENJCbxiD8nP4wtS3A+Z6Qqt3EL9OHM4k8LBqT3cbRcQZekfFTaFiojJ56Wc8ikaF7RY/4L4Q8Z4uifMffGoYbvdphSBjQ/11IhqAQTmMpJ6rOjbnAj8qKOhdMhmpu+8++fkeEjGJ8rw6LBapztRdEprXkgo7Fsk0N5rsyR/UtZdWY0xAkc8PTmciqo3PlQBkJ9Gc21Gz7w1EfbUZ2QFMFFbi6f8RyzBea4mht1gw9LA4PodchSAALUeWcKXrQ36Rpq3JeBuW1yAikjXVdMfTXqKrlYfXoXCzg9Azz2MCLHLjyPAU4S1Vla5G4LnInaw9We5wHXxGOoKZTqBC4g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7004.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(39840400004)(376002)(396003)(346002)(451199021)(8676002)(7416002)(5660300002)(8936002)(52536014)(6916009)(41300700001)(316002)(2906002)(4744005)(4326008)(64756008)(66446008)(66476007)(76116006)(66556008)(66946007)(54906003)(478600001)(71200400001)(7696005)(966005)(107886003)(186003)(9686003)(6506007)(26005)(83380400001)(38070700005)(38100700002)(122000001)(55016003)(86362001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WlVYSi9BU2xhTm4rNTFsODBpVnFUY211MlE2ZGlleHg3TlBhVnZaeXk4MlRE?=
 =?utf-8?B?bW5pVFFML0dyUktCMjdDcE1BRTNxYmZvTTJGYS9TNEpQZFgvQ2g0dVR1Y2tz?=
 =?utf-8?B?TjEzWERvZkFkMEJZREUwRTcxUysvTzFiQXZrOXlXVTI0WUYvaW9xcDZCREJo?=
 =?utf-8?B?bi9HY1UxeXVwb04xRzA5K0d3emxNS0JCdFFMc2JGOW5RTG9yWVJTaDY2NnpE?=
 =?utf-8?B?T29oY0tKOVdJMHdmR2xCNVhhRFRjZHZZUU5mVUZWeVRwL2hIMWI1U1V5a2g2?=
 =?utf-8?B?RDJyb1JpNE9YRDFoYVJrREhwenIrMGgxQVlCbzM1eHhyTjNmekVILzVSZGZx?=
 =?utf-8?B?dDdxdEg1NEgrb0RiL29tRXVhemJtNm9NWWZiaExUVjk1MkdkbmhEU0p6MlZl?=
 =?utf-8?B?YmcrV1JmMitxdERnSkVyUWFlQVhpWi94NFUzYXFXUEtOcXBZYkdJWlRid0sv?=
 =?utf-8?B?dFpKbFJqUE1Jam5TaUdSNHowOU5sNG5OTTRMTmNDZlRRYWg5ZXdvdzdyMWRr?=
 =?utf-8?B?QXFmZ2F0MzBFU0MrUG5ORE04K0FKaldnc0F0cXZIdkRaODlXZThsOWFQVTUr?=
 =?utf-8?B?UlNGcUZmeGpFS1FVZjZtcnZIYytDb3pMOE80dmZIYVBoanRlZlI5bmNvSzVX?=
 =?utf-8?B?MFhWNEdINmlKcHd4ZDlRMkd4ZUF5Zm14M25QNk00aGZWanNaSGZ0QmZtamhR?=
 =?utf-8?B?MVhKSStMbktGWVExYVZ4NThraTNaMEQvOFhrV1EzTVRNeHhjMXZzYzVqRHZn?=
 =?utf-8?B?N2lqSWJPNjlwZlhDeEdWc0ZueG9pUXFVQ1hsOVphMUVkbXVXR0FDa3FyV0Jt?=
 =?utf-8?B?dGI1M1pqekhGWUl2UnV2VTVBNVZMa3c0Rmlsb0tPWVkxTjBsdlV0bmcyTWM3?=
 =?utf-8?B?VVVPUGhZM0pCR3l2eVU2U21qdlNyNUt2eTE2QzJRbjJJMEEvMUVneXdWY0Fv?=
 =?utf-8?B?OGxGR2FLQjFBVXlmdGpvSHNKTnd4SXNFUTgwaHkrblRaSVBpUmxZK1BTc1pM?=
 =?utf-8?B?WGhwU2hMNWQ1VERZTkpsU0ZOenZWMlJWVjU3SThQN2lTT011UHZDM29NeUwy?=
 =?utf-8?B?U1J1VkJTbDdHWjI1ZUFLU2x5Ti90SVdpVVg1b2FINi80ZEFmeGczTEdxaW9s?=
 =?utf-8?B?bmVkM3FpaXA2bXozWFJwVlN6ZnpBUmwyOXQ2eTFlY2IrcGxXVnl6YjhWaW5w?=
 =?utf-8?B?ZzRGRFFrVW1yVTcxTVBqYnZMVFl4TGNXazdqcmpFcTh4cWthR2xicWdMeTZo?=
 =?utf-8?B?T3FKQUd0eU90b1ozeHR6dmJHSXdnNzkzRzBVYkU2dm9XSm9TTFI1bzJIMUgy?=
 =?utf-8?B?WG1KZEFmSjRUOTJSa3FKNUZzN1ExUjVlL0kvQkt4VGNmc2ZOMk9BMm1TSDFD?=
 =?utf-8?B?TXM5ZjZIM3dBM2Z4UGsrMGtJdUJPK1NsQnR3QzIxN2FJaEdIZW1QaHBnUit0?=
 =?utf-8?B?NHRVRVRISnpHNEU4Vkh3MlVLdjVrSVU5b29oc3NFYk5PUXA5cE5Bd1lvRUJx?=
 =?utf-8?B?WExIQmJubE9wMC9EOHpiRDBYeWNTZU9RSkduaHorME9INytqZldWSDEzb0F3?=
 =?utf-8?B?RGFJdnhpT3NPUFBTSlVHeDQzUHgrVzlrWG15bnRkaU5lVVFEeWM2YkR6SzNB?=
 =?utf-8?B?Tk0xajhJWWk4TDZMa2NYd2k5d3Q0V2pCL1lSQ1Ayellod3M5dStTak9vb3Nv?=
 =?utf-8?B?MGYzT3ZJeWlEdytObkRzREt4OXBZRTI4dXVxTHhibUF5T2FUTmdacVdXNTZz?=
 =?utf-8?B?YlFpaUJ5TjhYR25KK2FNOFBDQTI1UWNlVjNpcHlYcVRONXZ3aFNMa0c4Z1E5?=
 =?utf-8?B?RlJQM3dTbElZVVVZUTZxc3dFNElTZzhXZkovd3FWZW96NXNxQlN3MW9vMzlE?=
 =?utf-8?B?cUkxSnpaWitQQ0thQktWem1CWTFsc1NTZjVqZkgxM0orbVlqZXNEVnNGWUdo?=
 =?utf-8?B?WitGT3RVL3ZmWnJFUU9WWVA5MHFtN1RYMlRqWnNTclNaSDNGV0I3Y3JtelJM?=
 =?utf-8?B?d0R6VWtFbDNmWnNxMzRrWTcrMEdZeVRHUjFReHhyUFI2cjJ1VEQxdnVNSEV6?=
 =?utf-8?B?TjZzbmtyV0tqVUlTRCs2Tmp0YzZhbDNaZytnZkx4MWFSZWhvSFdqOGMwS2wz?=
 =?utf-8?Q?7QyuCBsSMZy+z24QRQhHbvjY/?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nskint.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7004.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26fe160a-fda2-4a37-5d92-08db46b8283d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2023 00:41:36.6038
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 727455a2-9822-4451-819f-f03e059d1a55
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dG7DAoms4XR95+YpdYwNxXKyLvV4KTme8Du14XtuUr0WbPwdOXxUBbzSU19biBxiQTHorCmgB8n67GrWGATGgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5994
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRGhydXZhLA0KDQo+IFBsZWFzZSBjYW4geW91IHNlbmQgbWUgdGhlIHJlZ2lzdGVyIGZpZWxk
cyBpbmZvcm1hdGlvbiBmb3IgdGhlIENRU1BJDQo+IGNvbnRyb2xsZXIgdXNlZCBpbiB0aGlzIGRl
dmljZT8NCj4gSSB3YW50ZWQgdG8gdmVyaWZ5IGlmIGF0YWxsIHRoZXJlIHdlcmUgYW55IG1pc21h
dGNoIGJldHdlZW4gdGhlIGNvbnRyb2xsZXIgSQ0KPiBoYXZlIHRlc3RlZCB3aXRoIHZzIHlvdXIg
U09DJ3MgY29udHJvbGxlci4NCg0KWW91IGNhbiBmaW5kIGl0IGluIHRoZSBwZGYgdGhhdCBjYW4g
YmUgb2J0YWluZWQgYnkgcHJlc3NpbmcgdGhlIGRvd25sb2FkIGJ1dHRvbiBpbiB0aGUgdXBwZXIg
cmlnaHQgY29ybmVyIG9mIHRoZSBmb2xsb3dpbmcgd2Vic2l0ZS4NCi0gaHR0cHM6Ly93d3cuaW50
ZWwuY29tL2NvbnRlbnQvd3d3L3VzL2VuL2RvY3MvcHJvZ3JhbW1hYmxlLzY4MzEyNi8xNS0wL2lu
dHJvZHVjdGlvbi5odG1sDQoNClRoZSBkZXNjcmlwdGlvbiBpcyBhcyBmb2xsb3dzOg0KLSAxNS4g
UXVhZCBTUEkgRmxhc2gNCiAgLSBRdWFkIFNQSSBGbGFzaCBDb250cm9sbGVyIEFkZHJlc3MgTWFw
IGFuZCBSZWdpc3RlciBEZWZpbml0aW9ucw0KDQotLSANClRoYW5rcyBhbmQgUmVnYXJkcywNCllv
c2hpdGFrYSBJa2VkYQ0KDQo=
