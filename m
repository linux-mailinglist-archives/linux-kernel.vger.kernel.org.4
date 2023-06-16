Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB88A732C70
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 11:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241505AbjFPJr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 05:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233647AbjFPJry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 05:47:54 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2053.outbound.protection.outlook.com [40.107.6.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55B92D59
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 02:47:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VAMX6hES43l/pLDOEBMJaSYYhAM4FvPCScokVgCaYp7V5HLDn2qgKWkDEbgAODUgKfBj/eWY1bhmmKFynuqiPu8qqAtw/glxlFLnCi0HjbkcUDTdJG7GeZLWWTzdPFYe7mD2aJl4rKsHCozXChitxu9szpRKKn741oHjWgN+BmmCs7AdmUbwMjSKe4BciE8x7jKAD8TLkhLD4XZ5Q0lzTD66z4nntVjIzyD53xrgNpRHBGnzqV/5j5EqIXBq+JmNG7iZUu1kDGhV9C6nIjOZZeTUyZMLF4bkan7b6FlWBuWz20sXNGlJP4YZIblgKtlmNN+i/Qc0yVBIhY9q/lGpfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wBGGjmeH35Sc1RUIvow4iS+cUKw68nh8gdecsEKYrtU=;
 b=a/t6iEG0AJ/kOcMSk/nJYLzQAlkIcJO+QqQ05R0UMERjlvV/71qu425Z1+n91avmh68iWupMfD2wnrEAPvTkArSj3ya8VorVXOsK2w9Jqu4uWZR1N/qOckm8hZxjdR9wJFhJwUU14hrI4JuNXy7wBJ7jwko4KYpCgvIZ1MrffBrMh35F4Yat+msLdt/J7jmg5XRbpuzmpLJagtODvM5U9obJCE1kMQvYD1X5efkVVgY8Y08bN33Q24OiDLnMu1ms0/2dYWJV+iRIz1IjebYa5J7U2TT9UqYj6/ErUa+kaQIFtSAD5uhNvepEfef3OXcJMZxg7Jylv6RnFOh09579FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wBGGjmeH35Sc1RUIvow4iS+cUKw68nh8gdecsEKYrtU=;
 b=PyX8N0l8PGEvnObes6oS7VAGPeEE257QLo/3NURT3Ic7VNu+baoTB90BgLlEAvXwsEO39MmtR7I+cgOilyYDyw228lNHOLSAHMUrQaQJHjEHQSzT8VpNxlQAFTx4X4gWIYUjxlXSCRSLyWzWbf4CE2lBgG6Fn5jGUJS8Zs/YQs9c7WS9syj7NVSdApJNOfEQzAAV8yfdwSUJyZlG01vIThdSz/FROz5+ljfyylwZpyZsmw25Sb6Es0Yiyr8XoucR8pcLICGrsWQe3C9l1bYDU65qs/KrAKLX0FCqb591pTiYA5hZJsAEmOriLhMliBKcFmtHNLGBekxdKkaqOjpH3w==
Received: from DB9PR04MB9476.eurprd04.prod.outlook.com (2603:10a6:10:366::11)
 by DB8PR04MB6956.eurprd04.prod.outlook.com (2603:10a6:10:11b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.29; Fri, 16 Jun
 2023 09:47:50 +0000
Received: from DB9PR04MB9476.eurprd04.prod.outlook.com
 ([fe80::85d5:a429:2806:b68b]) by DB9PR04MB9476.eurprd04.prod.outlook.com
 ([fe80::85d5:a429:2806:b68b%4]) with mapi id 15.20.6477.037; Fri, 16 Jun 2023
 09:47:50 +0000
From:   Jean Delvare <jdelvare@suse.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "mzxreary@0pointer.de" <mzxreary@0pointer.de>,
        "noodles@meta.com" <noodles@meta.com>,
        "kay.sievers@vrfy.org" <kay.sievers@vrfy.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] firmware: dmi: Don't restrict access to serial number /
 UUID
Thread-Topic: [PATCH] firmware: dmi: Don't restrict access to serial number /
 UUID
Thread-Index: AQHZnRSgbC5BfmvI5025YFjNaR+wNq+NNRAA
Date:   Fri, 16 Jun 2023 09:47:50 +0000
Message-ID: <c6b85691acc7864a58e94b99296abd4754fb143a.camel@suse.com>
References: <ZIbslWZev/Ayoug5@noodles-fedora.dhcp.thefacebook.com>
In-Reply-To: <ZIbslWZev/Ayoug5@noodles-fedora.dhcp.thefacebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.4 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB9476:EE_|DB8PR04MB6956:EE_
x-ms-office365-filtering-correlation-id: a8a0e7fa-ec81-49c7-c094-08db6e4ebfbd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SnJhsgKDkA8i08SAkE3Sm7x3vtF4QdMC9GHJ4nCR3YhAOfuvaRK3U2HGJdHfGPN1b3qroCrB3R4/8ZbUVdaqdoSgYpUYb57xkYDNsJqTcdKT3gidiICp+hTyyxWlGITCxxMXjDfVS7UTO2OJ6jtsAQyXe+5p39Ua7+3lD4FK2uG3Y0VgN6YT3GsHrTBtgPLKTQA+gYxoBM0+yypAys/mvwfiZpH0Vs3TXpPxa8H1ejxBWmFTUxAoGw1LWN9FF4U3fbG/yF1AuXIN3oWDfB79Nk7/cR6AQuB0z1qRPOtqNxtfkVeP/n7xOyiPQL3aQkU00+32GXDzNYXrNomurouMZrYY5E66OTrXLjDlhvk7xM+9Gew0SFhi+/THgEWk1Za6sSg8oaZ6t/I+rYuIo1eJZ7eS2cUu8z24hY4JPJO+3jUM8sDCmXslg2Y4KHI2UtrkKvAdlcGW2hkNbZBbHrGzRmPPIY3uXEcommPbJ1ZEe0cHFfhm9gtlGoKDkenwC7rfCrxff/+lVsCklX9oZti2lFcwEqKg14NiQXmeul14WqONs2J8HdgycHaJTR7yNUi+uZB8KLRGWMrqMvFAhomZDD6RPc359HSpIehSG25mOfMcqbElneB7yn4wix5ORmus
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9476.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(39860400002)(396003)(366004)(136003)(451199021)(478600001)(110136005)(6486002)(122000001)(5660300002)(8936002)(8676002)(41300700001)(4744005)(2906002)(36756003)(38070700005)(86362001)(38100700002)(66446008)(66476007)(66556008)(64756008)(316002)(66946007)(4326008)(91956017)(76116006)(71200400001)(6512007)(6506007)(186003)(83380400001)(2616005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dlh5MDNGTGQ3UVhvNG9mV2NIb2pNazhieDlJc0tPWHlVU2UwTkpPemptQjYz?=
 =?utf-8?B?VC9RU3JQaEVQSXVvSkxqaUhReUlZUmlFQzZkbTNFN0RSaUhVVWQxUU5KOG9B?=
 =?utf-8?B?OGNoUWlUbDNhSUNRWjhmMytJTDJERmw2RllCUFg0cDcwWWJtbGJLMU5wNkVr?=
 =?utf-8?B?SklTVURuRnZKZWdZWW42cFZyVWhvZktoYjJRM3U2WncrbjVBako4MTZVY2kz?=
 =?utf-8?B?dVFiYW01emJiUUM2RVZZenBlbnNkNnVoLzZveDJRZkk0a01kc2xTYnZ3dGND?=
 =?utf-8?B?WFJNUldyUEFJVW1GSWtNTnFGK05TTCtmNW05cWhmOXh5NjJPSURYZnpMSTZj?=
 =?utf-8?B?dUVxQXVzTWpTU3NidkhjUlduNDlOOGJHNkVzeG93b0xGd0xHTXB1VXE3SzJL?=
 =?utf-8?B?by9OMCtDWko0RWpySTBONDFFS0F2Kzl4WkxVbUFvSi9VYmFSY25WTFFJWVN0?=
 =?utf-8?B?RU9jbmx3RWRuMXMrUmhnY2laWmoxZGVlZ2lTSTFMSGZ1UlFoc1FqN1RVV1NN?=
 =?utf-8?B?SU5rbCtnbjBsa0N5WjBVOGZ1Y0lac1FHR0N5YTNDeVYvK1psbEg3QjdTbzYw?=
 =?utf-8?B?ckxqOVovWGJxdHhIenU5aXNXY29LNnlvSFYzUGJwaDQyQzBrM1dPZXJubVpy?=
 =?utf-8?B?MUViRWlibEhoYzRqZU4xWXlrbHltK1MzaFhpWXZ3ajJ1VVF0N0JqaXNPUXBV?=
 =?utf-8?B?UUJiNW45ZTdPT2dCcjJLbERnZ0JXSVl6dDEreXYrenJjUFRieHRHa3haeHNu?=
 =?utf-8?B?ZVg0SDI3OW1TWWxXRUxUSXB0czFCZDI0L1V1dW5DOE1aYmlTTk8ranNEY1JS?=
 =?utf-8?B?dy9sZEJoaWZoNXZOdWVBeWd5U3R5dG1SblZDeUcrbmc4Sk1VRHpoZTlpdDQy?=
 =?utf-8?B?blNzZ0dMZ1RMZ2xIOVpTTFFwSU4vNDMxZy94eXRmY1AyRTdaZ1l5YktIL0Ir?=
 =?utf-8?B?Wit1NVlLNm8wUVVhU0xDV0tqOW5FSS9URjdTREROK0dVZnZ3bHJGalZVcmxI?=
 =?utf-8?B?VzlPYXRqRVFuMzZ6VmF2d2c4N1dBU0RPaW9qbnYwYjlMcmlkRlI4U3pQQmdO?=
 =?utf-8?B?cXZSdDk3R3RKbFJZaWp5TENId3NUcWw5eCt0ZkJvZHZrWmlYMDJVQ04rSG0y?=
 =?utf-8?B?MW9GbFdDaHhFMitZV2tIeTNReXpnZ1BMSFlYVFZ4MW90WjBuWkVJZkVhM2Js?=
 =?utf-8?B?cmRkeGtWYUVHOEFhVHZYb2NEaFp2Y3pETTJsM0FFNURxWC9ESXM3WW5iUjlH?=
 =?utf-8?B?WnRjUGsyWmNGaTQ4TzZUdXJEQ0E3TStsMXdReEN3SW9CUldHeHRydFE1d0Qv?=
 =?utf-8?B?TDR2WG4zVVFxMGFQNEpEZkNaR1hHb0daZFFPRTJuQ1NwZGt5S09WT1Fnckxo?=
 =?utf-8?B?anZRZTMzVXg4bzJvYUlsQkovMkpabmpSaUFBRVRtMWduMmhVRWhxWi9ZUk9q?=
 =?utf-8?B?ZVRlUlAzaVl0aUlrWFcrNUU5N2VCVTZUWGVWL2NFTlhXT3poVU1nblJNRDkv?=
 =?utf-8?B?MTg3MVNtMnYzSDdLMFdpdy90WFdsWmpGT3pQQnVoR0tNR1pLbjA3cW5zM0s4?=
 =?utf-8?B?ZktOYzh1NHNGQkxnM1o1MDhXOUR1aStoZzFmTEs5Qk1kU3d1MUpXUVNhWTho?=
 =?utf-8?B?N0tXaG1aQU5Yd1ZQQUtzRmFFMUl2THBaMS9tUng2UURZdmtrY1A2NWN5MXBu?=
 =?utf-8?B?MXdKRDVLbDZVa1UzbVIrdjFGclF4RFR2TDlVdkczQzdja2cwWTd0Zm84OUxY?=
 =?utf-8?B?MVhwUmF0dVZHb3dOS0ZEd3l1bW5mKzlYNDhsZzJUY1VJVGxXalBoeXZVdWc2?=
 =?utf-8?B?V2l6Wk0rOGNzR0d4SlFCWWFGUDN0OGNIT2pZZmI4WTM5bytpWU9YUVpJd1pH?=
 =?utf-8?B?MlFtdDVJbjUyeWxuSFBTMTd2eEk5N29abTJXS084emM0NGxCV3h0VHdzUzNV?=
 =?utf-8?B?b1NFM3FxK2VWMkE3cUpRVkhrVjlmQUNYVlNiQUorL2N2cW5xYTU2QWlKcEtx?=
 =?utf-8?B?YW9KRC9sY1ovYUpiV1Z0RVFEMVJ3VGJNbnJqVzVyTFBYak1RVEVzRjlocnM2?=
 =?utf-8?B?TjR1YWpXelFhZ3N4RWcyb20xclgwd2NWTWQxSjdzZlN2aVJNMUVMc0RlcWgx?=
 =?utf-8?B?cjdQNU90b2IxWG9BOEJ2MHNnaWh3akYzakN6Q2k5QTVZWmNVWEtGK2dhc2dz?=
 =?utf-8?Q?Q6E4yMCfpkKbi+3THMZjyFRfqUeWEpis2Spg5fPcsX+F?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <698DDAAF88728C4DA25F6CACE6A310B0@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9476.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8a0e7fa-ec81-49c7-c094-08db6e4ebfbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2023 09:47:50.6030
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dYNfUYz32fQd2+TFVbSRHWb+VpqjHqEefZ3FkbcDayqPCxa35cuYQOv1QEAKY+SpWVYzd/OQ3BEyT6wh/ks6Mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6956
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSm9uYXRoYW4sDQoNCk9uIE1vbiwgMjAyMy0wNi0xMiBhdCAwOTo1OSArMDAwMCwgSm9uYXRo
YW4gTWNEb3dlbGwgd3JvdGU6DQo+IFRoZSAvc3lzL2RldmljZXMvdmlydHVhbC9kbWkvaWQvKl9z
ZXJpYWwgKyBwcm9kdWN0X3V1aWQgZmlsZXMgYXJlDQo+IGN1cnJlbnRseSBvbmx5IHJlYWRhYmxl
IGJ5IHJvb3QuIFRoZXJlJ3Mgbm8gY2xlYXIgcmF0aW9uYWxlIGZvciB0aGlzOw0KPiBXaW5kb3dz
ICsgT1MgWCBib3RoIGFsbG93IHJlZ3VsYXIgdXNlcnMgdG8gYWNjZXNzIHRoZSBpbmZvcm1hdGlv
biwgc28NCj4gdGhlcmUgYXBwZWFycyB0byBiZSBubyBleHBlY3RhdGlvbiBvbiB0aGUgbWFudWZh
Y3R1cmVyIHNpZGUgdGhhdCBpdA0KPiBzaG91bGQgYmUga2VwdCBzZWNyZXQuDQo+ICguLi4pDQoN
CkknbGwgdGhpbmsgYWJvdXQgaXQuIEhvd2V2ZXIsIHBsZWFzZSBub3RlIHRoYXQgdGhlc2UgcGVy
bWlzc2lvbnMgYXJlDQpvbmx5IGluaXRpYWwgcGVybWlzc2lvbnMsIGFuZCBub3RoaW5nIHByZXZl
bnRzIHVzZXItc3BhY2UgZnJvbSBjaGFuZ2luZw0KdGhlbSBhdCBydW4tdGltZS4gU28gaWYgYSBM
aW51eCBkaXN0cmlidXRpb24gYmVsaWV2ZXMgdGhlcmUncyBubyByZWFzb24NCnRvIGtlZXAgdGhl
c2UgdmFsdWVzIHNlY3JldCwgYSBzaW1wbGUgYm9vdC10aW1lIHNjcmlwdCAob3IgbWF5YmUganVz
dCBhDQpjb3VwbGUgb2YgdWRldiBydWxlcywgSSdtIG5vdCBzdXJlIGhvdyBwb3dlcmZ1bCB0aGVz
ZSBhcmUgbm93YWRheXMpDQp3b3VsZCBzb2x2ZSB0aGUgcHJvYmxlbS4NCg0KLS0gDQpKZWFuIERl
bHZhcmUNClNVU0UgTDMgU3VwcG9ydA0K
