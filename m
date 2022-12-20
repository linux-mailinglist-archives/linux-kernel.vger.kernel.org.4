Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D660E651F78
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 12:11:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233274AbiLTLL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 06:11:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiLTLLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 06:11:23 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F082639;
        Tue, 20 Dec 2022 03:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1671534681; x=1703070681;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gbQxn6ui1g7SyU51QmLcT+oe1M69f05uvsO5/Q3kL38=;
  b=T5FxoPtIrRs/HV/gzw13kr7olyNDWipnANQBQw7iY5+GKvjBZFGNTX+/
   QP5gmqptzLHazhjYECwxcMUkgoqw/v+fW8iaPX9SgPg6csYrA1KwWSZGu
   nD3ozEGvRiVjs9qkArXcFDN57MUs8YjVClESCwHezAYqE9bV4uFkt4oDT
   xyrZV7QXIlutgVyhygKcVyoxNhSey1z5vvU2lXGi7+VmcRPIxeFUlpY5I
   5jXGzEEos6+8phmKgsi8tQSdVE5RnLzS/WYAT2qHhDuC8tOZCfklWUHXU
   7CCKsxkp4WxXV4dO1khNUWOh9mGGnCGsqwCa8dEy6qXrbxtOLOvfJZgAR
   w==;
X-IronPort-AV: E=Sophos;i="5.96,259,1665471600"; 
   d="scan'208";a="188965006"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Dec 2022 04:11:20 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 20 Dec 2022 04:11:18 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Tue, 20 Dec 2022 04:11:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W+FMf4ZE9nx05qSnCZUln1gxUnFM0gq36Vp7c1hKBbUOKQVgASh0mOv5zabZzMNC5iZupjDbfKywz5Ldfcoz5r1UzxM5+lDphnGYrTrgztkD4IPOJ2Jk2a/VCGUv2olIUNhOyBhQ0klCVnEygEj/OOEFSa/z36O4kD0QDHhBh5ryFDQal8tqgyvOviwe3n6ekwh7l4mO8J9qZo8D1+ppEqa0zo6UwO+40kbRR6nfCfPzQJRbOA3i4rToS4reRzwFmW42tYPjZYjqBbA+6rklittPUPPoP/VNcpvFU1yrCXPEe5H/bYIUAbBk215SgTHA87dLqmpQ4127UHg5XIHkIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gbQxn6ui1g7SyU51QmLcT+oe1M69f05uvsO5/Q3kL38=;
 b=YaC+VJ/kVi0G6uyT5mWYv9QPQktywdmCDarH8bGcq5XjWiq+yTuyYpHEfIsO2Yu+IDo9JwwY5nLi4AxPhJjAPXzPuRYnl9m9LsLaeZicZlL2fR6m7VAlvk+qLGsYRU4D0wa8XZomvcjeG/nB5gLqNviqaXsCVbwNAgt9oAebiuOjQpr2AbpcRFXB2BRrHXxUc4oBts0qrEk5EIKUTBFvZ/NfET7ie7XuhZ9bBxWhDFtaeeuunFANi1Y3qOwg2Uclrk4xKpLSrVQjJd4yVYwvGrxVVAYPEkB9lNxPCxAW1zqIXW9/SibrFXn1yaoept+2mzDZLATfhlUcMHmc20Fp4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gbQxn6ui1g7SyU51QmLcT+oe1M69f05uvsO5/Q3kL38=;
 b=rGT6Vf1nm7azvRZJxkEOo1p7zN6RWCVxFMCCfesnIb29cX8A0YA8JoWD0G2D1Aoif0GrACUIacdJotEmkS9z4pY7dupeVuckqJwcqdK8NB8DNCbx5ZODhxvt2m5qd0CPRIifIm4in643iwICP9logcFbtBCNHxC+wc45Q3v+i4Y=
Received: from PH0PR11MB5611.namprd11.prod.outlook.com (2603:10b6:510:ed::9)
 by PH7PR11MB6858.namprd11.prod.outlook.com (2603:10b6:510:1ee::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Tue, 20 Dec
 2022 11:11:15 +0000
Received: from PH0PR11MB5611.namprd11.prod.outlook.com
 ([fe80::6c3b:ab9d:2acb:c630]) by PH0PR11MB5611.namprd11.prod.outlook.com
 ([fe80::6c3b:ab9d:2acb:c630%7]) with mapi id 15.20.5924.016; Tue, 20 Dec 2022
 11:11:15 +0000
From:   <Shravan.Chippa@microchip.com>
To:     <jacopo@jmondi.org>
CC:     <paul.j.murphy@intel.com>, <daniele.alessandrelli@intel.com>,
        <mchehab@kernel.org>, <linux-media@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v7 1/5] media: i2c: imx334: modify link frequency as for
 the configureation
Thread-Topic: [PATCH v7 1/5] media: i2c: imx334: modify link frequency as for
 the configureation
Thread-Index: AQHZE3Fd/5ane5WewEKrH3grruR5m651SdcAgAFLv6A=
Date:   Tue, 20 Dec 2022 11:11:15 +0000
Message-ID: <PH0PR11MB5611CA9634C1A7A66434703C81EA9@PH0PR11MB5611.namprd11.prod.outlook.com>
References: <20221219061526.3169369-1-shravan.chippa@microchip.com>
 <20221219061526.3169369-2-shravan.chippa@microchip.com>
 <20221219144414.lfusj67ojjk2phkv@uno.localdomain>
In-Reply-To: <20221219144414.lfusj67ojjk2phkv@uno.localdomain>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5611:EE_|PH7PR11MB6858:EE_
x-ms-office365-filtering-correlation-id: c3cbddb9-bd63-45e3-44a6-08dae27ae97b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uUaYPA0hOBvaJJHBLnpcpgltDO7fxqs2LT2SrYfp5iyEdNct+VJpimKezeqHg291v7Rs07mfU9q3KnE8YI6/OJRNyNh9yzHgYMMaEahoqvt6WK71175Y1/jWCLECvLNXSSUwq/3vcbvTIQQ/IELW+1Wx3XWN6uUqIFU9Oj/h6WCvDPyGFwl9OgNbL8HH4AWPsdAt2pQ3Xct92LmL/Pd2BnLNg5urgPX0+PzAM3oL/+nGi6RVvzJx3Qq2bWdIRFyFWRvku4F+gA3gkmWCbL5rB68DbxSjWAkoUa6LHew1Yva2rdn1DafumBbhWLSXTa7gdQQ/4ZJraD+cqeZYrNnqrKRIbCoxBHKwSVux7quLHs//3QAMaDX7keZTr97oSCg3O74+h7UIRYAHNRdoxZ2SsNcJZM1puD3lYnM2lL4eigqTOtlm51CYjUIkVY82iIs2P7JKWY7OTxmL5XE/sHhRoNIeEpAbEkTPg/RzFHY0IM5Tltekw8XZaUbmd55a15Cl038I6g+qzgUNETUI5V0axLY5vh6biD/TheHQry8kI1TQqe6RKi2eqokXNhbXckms5rxNMits5CfolPbhG/h62ITYYLVLFKJifoi/SuwrnjQkWgp8pz8I5BSiP25jiofBMFLoQe1BCfef/pyVVZFCn5HTEhxz2z3o7FRP6CGa8CO7hk9RL1R7sZUR/XouYdQ1/zxbEjgE4JSXps86y1EpAA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5611.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(376002)(39860400002)(346002)(136003)(451199015)(9686003)(53546011)(26005)(6916009)(64756008)(478600001)(122000001)(66446008)(52536014)(83380400001)(38100700002)(66556008)(8936002)(76116006)(66946007)(8676002)(66476007)(71200400001)(4326008)(7696005)(316002)(86362001)(54906003)(55016003)(2906002)(41300700001)(33656002)(38070700005)(6506007)(5660300002)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MHNWU2RFOHdTbGVVUmh0VG9kaEIvbjh3WXlPQU93bUJSc2lJL1FTYUo2dEtj?=
 =?utf-8?B?MEszZzA2TkNZalE2bHdnY2pOUVg0YWNTaVJoYmxFbWkrTFhodm5nZ3RpR1Iw?=
 =?utf-8?B?ZVNWcnU1L0pZMVJJTjFGUEpwajV6cTRpVG5Lc2ViRnprdTFjdk9PZEl5ek9Y?=
 =?utf-8?B?eUFiaFZsaStXdlNwVng5N05PQlg0MkxtbTJYc2VCWW1aMytJUjZjdnB0UXdv?=
 =?utf-8?B?YkxBYkREVTlJaHBSeW4xVXpEZnhDKzBEYkNMaHdiL0w1aXlZVSsxQWs4bGUr?=
 =?utf-8?B?aUJ3cEtPM1R0TERhNXJTSURrUEJ5MmkvZjNxbUtaRXYzSDh6Rnpodm5jL0Uv?=
 =?utf-8?B?MUdTczhOSDlZSmNCT0MyVkNVNTBxbGdsektmQytNUmZYQnlWWG16RDFrekJa?=
 =?utf-8?B?SkJrRkdaUTNCRmQwei9rSVowVzF3TDE1UDU4cXNOcDU4bCtOQjA1ZHRUU0x0?=
 =?utf-8?B?eGJYaXpsUWJVK21HWStUWkF4dFY2clA5ajNyR0RjdkdRZFpvbUplS2h4VEMy?=
 =?utf-8?B?ZTM1eTlRNzFkVHRJTlo3dkdqWTJvVGc5eENhSDNtUkNCNG54YlJVKzFzM0dD?=
 =?utf-8?B?WmdsWGIydmtjY0V3ME8yVDJsWXRZMlN6N1FaSFpYQWFCWjFyZE9EZ3l0eFll?=
 =?utf-8?B?L09IWmNJTGt5Z3V1NDdpdGZWb2lSeENDaklKTENVVElBL1BUTS96NnF1ams1?=
 =?utf-8?B?YUs0NnJUOW1KNitSRlFIdGRKNTl1L1pWK3NoVERmQjQyUURrekhGZTBMNHNq?=
 =?utf-8?B?TS9rZCtmeTYvK0gwdDhyd0ZGYU8xdkc5ZzUxTmM1SExiZmJsV0xyekdCT1Fs?=
 =?utf-8?B?OFJmNVhlTm9ySHZhRlU4Wk5peUtGNmNNcXI0amtBbmVPZTVMTys3WGF2OU1q?=
 =?utf-8?B?bFpnbjVLS2cxZWZvSUxYSElFOFFJamtkeUhRM1NhbVpCNUdrVys1QVlqazRK?=
 =?utf-8?B?dlVvdVdpV1YwclIrVFpETXlxVUc3N1p5emlESktwQlhHaElxTFVHM2ViQ0xP?=
 =?utf-8?B?SytJSURtOGxSSHNmMC9BQ2RJbVhuaTV0R2hmeWN5MHZxQTlMdW5XMXlIN3VI?=
 =?utf-8?B?c2pLWE0xczAzaEJseU8rVERQK3F6UHUyOW5vbFN1UG1vWnhUMDI0VnVMNjV5?=
 =?utf-8?B?QWQ5VzFENVJFKzJLUmx1SDNYbXdXdmJ4VXZHY2ZwQW4rRUpjS1lPZXQ3eXFq?=
 =?utf-8?B?aGhRamxFbGJpemJpd3ZpdnpjUFdnV2tyaWVpS2s3MlBBYlZ2bStzRFR1ZnJs?=
 =?utf-8?B?OG9vOWUrM00yUUtJa1pHdENVWlVPUjBMazJsSnFCL1VWUUJld05tSGdoWTYx?=
 =?utf-8?B?M1dzaUlUOHdTUFJUYmRLWHpTZ0JnTFlndG44Qk1MeTdHdE9CZXVlcGdaR2or?=
 =?utf-8?B?WDNOOUMrdXFCSWdOY3EyVExtVFZDaUV6M3o4QUZCNXpWU25JTk95Ukp3QjdX?=
 =?utf-8?B?bW9JWlp6MXM4R2V6eWpDQWJaN3p4UlFOMW1LdU9nVy93UGk2TTZMNGpQYU5D?=
 =?utf-8?B?MUV3STlLTGYyRlVBdWExTnVUbjZqQTVYZlFqd1dKY25nTmpGcE9KZkoydWNQ?=
 =?utf-8?B?aUIzTHk4dWFoazYyRnZTWG94QU5ncGxxNWJiR2VEdmREdzk2aHlBelRiOVh3?=
 =?utf-8?B?WHdhVUJ6YU0rZG1YY3FqYkNyZ3o5NnZzdjBOanlEVUxIc2VxU1hMSjJTckxX?=
 =?utf-8?B?Zm00dFFDb3ltb2NieUFrd3FZWkxXV010aEprVDBuYkQrRjM4TG9vOU4zQ3o4?=
 =?utf-8?B?eHQxbUVhNUo4aWtUN1RVc3piUWFSTVlFUEtsR2N2d3FNV1VhN0J5Q0c4aUZO?=
 =?utf-8?B?SjZ3UWRndXF0UjhlbzZQS2RaM0hYL2c5TUtIWHN2OWJLMExjT0RUNVFlazJL?=
 =?utf-8?B?clIvU2xTZW1CdDc3YnYxUm9JKy81UnlJWm1QeW5kVFFvM3ZtdVU2N3JGaWhv?=
 =?utf-8?B?eS9iMjhrd3BOaUdJTng5VmhMNlpQL2N4dll4elpDUnpIUk5YOVpzTFcvanlV?=
 =?utf-8?B?UFFFS3VjR0RHa0Z1UnVDZFNwK0VQbnJMWUFXZGJFQmVNRFJYNi91UVdRVDZY?=
 =?utf-8?B?dW45ZXRQUWV5MlpieWoyUTVzRUpnZ3dIQ01Sc0RNa243NmJQVFp5Umc1R0FY?=
 =?utf-8?B?bFR1K0prUGF2a1dxcDVBeEh4NmUzNWcxd1FnNkw1VmhUOW55a0lpTmMyaWRu?=
 =?utf-8?B?ZHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5611.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3cbddb9-bd63-45e3-44a6-08dae27ae97b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2022 11:11:15.6935
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w2NUvAd8xgzmcXqLgBxcMkY+phW4ecY6eVckWZg9yBuL2J9krMguOpxjLb5gunWBI0wPTbSzH0OchIlwN2ZBeObS6I3k/il06kK2B2SjS2Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6858
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFjb3BvIE1vbmRpIDxq
YWNvcG9Aam1vbmRpLm9yZz4NCj4gU2VudDogMTkgRGVjZW1iZXIgMjAyMiAwODoxNCBQTQ0KPiBU
bzogc2hyYXZhbiBDaGlwcGEgLSBJMzUwODggPFNocmF2YW4uQ2hpcHBhQG1pY3JvY2hpcC5jb20+
DQo+IENjOiBwYXVsLmoubXVycGh5QGludGVsLmNvbTsgZGFuaWVsZS5hbGVzc2FuZHJlbGxpQGlu
dGVsLmNvbTsNCj4gbWNoZWhhYkBrZXJuZWwub3JnOyBsaW51eC1tZWRpYUB2Z2VyLmtlcm5lbC5v
cmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFU
Q0ggdjcgMS81XSBtZWRpYTogaTJjOiBpbXgzMzQ6IG1vZGlmeSBsaW5rIGZyZXF1ZW5jeSBhcyBm
b3INCj4gdGhlIGNvbmZpZ3VyZWF0aW9uDQo+IA0KPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNs
aWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZQ0KPiBjb250
ZW50IGlzIHNhZmUNCj4gDQo+IEhpIFNocmF2YW4NCj4gDQo+IE9uIE1vbiwgRGVjIDE5LCAyMDIy
IGF0IDExOjQ1OjIyQU0gKzA1MzAsIHNocmF2YW4ga3VtYXIgd3JvdGU6DQo+ID4gRnJvbTogU2hy
YXZhbiBDaGlwcGEgPHNocmF2YW4uY2hpcHBhQG1pY3JvY2hpcC5jb20+DQo+ID4NCj4gPiBDdXJy
ZW50bHkgaW14MzM0IHNlbnNvciBkcml2ZXIgaXMgY29uZmlndXJlZCBmb3IgMTc4Mk1icHMvbGFu
ZSBmb3INCj4gPiAzODQweDIxNjBANjAgcmVzb2x1dGlvbiB3aXRoIHJlcWlyZWQgcmVnIG1vZGUg
dmFsdWVzIGJ1dCBpZiB3ZSBydW4gdGhlDQo+ID4gY29tbWFuZCAidjRsMi1jdGwgLS1hbGwgLWQg
L2Rldi92NGwtc3ViZGV2WCIgaXQgaXMgc2hvd2luZyBpbmNvcnJlY3QNCj4gPiBsaW5rIGZyZXF1
ZW55LCBUaGlzIGlzIGJlY2F1c2Ugb2YgdGhlIGluY29ycmVjdCB2YWx1ZSBvZg0KPiA+IElNWDMz
NF9MSU5LX0ZSRVEgd2l0Y2ggaXMgODkxMDAwMDAwLiBpdCBzaG91bGQgYmUgMTc4MjAwMDAwMC4N
Cj4gPg0KPiA+IEluIGdlbmVyYWwgd2l0aCB0aGUgdmFsdWUgb2YgODkxMDAwMDAwIGxpbmsgZnJl
cXVlbmN5IGl0IGlzIG5vdA0KPiA+IHBvc3NpYmxlIHRvIGNvbmZpZ3VyZSAzODQweDIxNjBANjAg
cmVzb2x1dGlvbi4NCj4gPg0KPiA+IEZpeGVzOiA5NzQ2YjExNzE1YzMgKCJtZWRpYTogaTJjOiBB
ZGQgaW14MzM0IGNhbWVyYSBzZW5zb3IgZHJpdmVyIikNCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6
IFNocmF2YW4gQ2hpcHBhIDxzaHJhdmFuLmNoaXBwYUBtaWNyb2NoaXAuY29tPg0KPiA+IC0tLQ0K
PiA+ICBkcml2ZXJzL21lZGlhL2kyYy9pbXgzMzQuYyB8IDIgKy0NCj4gPiAgMSBmaWxlIGNoYW5n
ZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9tZWRpYS9pMmMvaW14MzM0LmMgYi9kcml2ZXJzL21lZGlhL2kyYy9pbXgzMzQuYw0K
PiA+IGluZGV4IDdiMGE5MDg2NDQ3ZC4uYWNjOWY5ZjE1ZTQ3IDEwMDY0NA0KPiA+IC0tLSBhL2Ry
aXZlcnMvbWVkaWEvaTJjL2lteDMzNC5jDQo+ID4gKysrIGIvZHJpdmVycy9tZWRpYS9pMmMvaW14
MzM0LmMNCj4gPiBAQCAtNDksNyArNDksNyBAQA0KPiA+ICAjZGVmaW5lIElNWDMzNF9JTkNMS19S
QVRFICAgIDI0MDAwMDAwDQo+ID4NCj4gPiAgLyogQ1NJMiBIVyBjb25maWd1cmF0aW9uICovDQo+
ID4gLSNkZWZpbmUgSU1YMzM0X0xJTktfRlJFUSAgICAgODkxMDAwMDAwDQo+ID4gKyNkZWZpbmUg
SU1YMzM0X0xJTktfRlJFUSAgICAgMTc4MjAwMDAwMA0KPiANCj4gSXMgdGhpcyB5b3VyIHJlYXNv
bmluZyA/DQo+IA0KPiB3aWR0aDogMzg0MA0KPiBoYmxhbms6IDU2MA0KPiBoZWlnaHQ6IDIxNjAN
Cj4gdmJsYW5rOiAyMzQwDQo+IGJwcDogMTINCj4gZnBzOiA2MA0KPiBsYW5lczogNA0KPiANCj4g
VG90YWwgYmFuZHdpZHRoOiAoMzg0MCArIDU2MCkgKiAoMjE2MCArIDIzNDApICogNjAgKiAxMiA9
IDE0LjI1Ni4wMDAuMDAwDQo+IEJhbmR3aWR0aCBwZXIgbGFuZSA9IFRvdGFsIC8gNCA9IDMuNTY0
LjAwMC4wMDAgbWlwaSBjbG9jayA9DQo+IEJhbmR3aWR0aF9wZXJfbGFuZSAvIDIgPSAxLjc4Mi4w
MDAuMDAwDQo+IA0KPiBUd28gcXVlc3Rpb25zOg0KPiANCj4gLSBTaG91bGQgeW91IHVwZGF0ZSB0
aGUgcGl4ZWwgY2xvY2sgYXMgd2VsbCA/IEl0IGlzIGN1cnJlbnRseSBzZXQgdG8NCj4gICA1OTQw
MDAwMDAgd2hpbGUgYXMgcGVyIHRoZSBhYm92ZSByZWFzb25pbmcgaXQgc2hvdWxkIGJlIGRvdWJs
ZWQgdG9vLg0KPiANCj4gLSBXaGVyZSBpcyB0aGUgc2Vuc29yJ3MgY2xvY2sgdHJlZSBwcm9ncmFt
bWVkIGluIHRoZSBkcml2ZXIgPw0KPiAgIEl0J3Mga2luZCBvZiB3ZWlyZCB0aGF0IHRoZSBwaXhl
bF9jbG9jayBhbmQgbGlua19mcmVxIGluIHRoZSBkcml2ZXINCj4gICBhcmUgaGFsZiBvZiB3aGF0
IHRoZXkgdGhlb3JldGljYWxseSBzaG91bGQgYmUuLi4NCj4gDQo+IA0KQXMgcGVyIG15IHVuZGVy
c3RhbmRpbmcuDQp0aGUgbW9kZV8zODQweDIxNjBfcmVnc1tdIGFycmF5IHZhbHVlIHdoaWNoIGlz
IHdyaXR0ZW4gdGhyb3VnaCB0aGUgaTJjIGJ1cyBpcyA0ayByZXNvbHV0aW9uLCA2MGZwcywgIGxp
bmsgZnJlcXVlbmN5IDE3ODJNYnBzIHBlciBsYW5lIA0KYnV0IHRoZSB2YmxhbmsgdmFsdWUgaXMg
ZHluYW1pYyBmcm9tIHVzZXIgc3BhY2UuIA0KTWluLTkwIHRvIE1heC0xMzAwMDAsIGRlZmF1bHQg
dmFsdWUgaXMgMjM0MC4gV2l0aCB0aGUgZGVmYXVsdCB2YWx1ZSwgd2Ugd2lsbCBnZXQgMzBmcHMu
DQoNCmlmIHdlIHNldCB2YmxhbmsgdmFsdWUgZnJvbSB1c2VyIHNwYWNlIGl0IHdpbGwgY2hhbmdl
IEZQUy4NCg0KVG90YWwgYmFuZHdpZHRoOiAoMzg0MCArIDU2MCkgKiAoMjE2MCArIDIzNDApICog
MzAgKiAxMiA9IDcuMTI4LjAwMC4wMDANCkJhbmR3aWR0aCBwZXIgbGFuZSA9IFRvdGFsIC8gNCA9
IDEuNzgyLjAwMC4wMDANCg0KVGhhbmtzLA0KU2hyYXZhbg0KDQo+IA0KPiA+ICAjZGVmaW5lIElN
WDMzNF9OVU1fREFUQV9MQU5FUyAgICAgICAgNA0KPiA+DQo+ID4gICNkZWZpbmUgSU1YMzM0X1JF
R19NSU4gICAgICAgICAgICAgICAweDAwDQo+ID4gLS0NCj4gPiAyLjM0LjENCj4gPg0K
