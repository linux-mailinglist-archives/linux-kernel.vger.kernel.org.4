Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 232CE6A7B8E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 08:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjCBHCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 02:02:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCBHCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 02:02:01 -0500
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-pr2fra01on2075.outbound.protection.outlook.com [40.107.12.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 300CF113E9;
        Wed,  1 Mar 2023 23:01:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KV0vV7WMBFzHzRx864x7lg5tUbv0uTvpcUuNdAxWHbGL+5Y7A4f1SUW00/Vgt7GAj6hkyITp3A+T4P51DyccuG3uvv9dbQa4z+D3DuztNnoF4T2Rp/tQDkGEd86YF9/pmRXxNTn8QGov2hE5mT07gwD/FUtn0qWP+7cx20CJffAvtlhlApeyc+DePojDKuEtkCN8sR0FLBFp0lzvChg4aExROHexh2kLKwgmIgteKx85FH8+aoPkGF336lNRLqc3Bm9p9PFbeTANtC5spHjsgqaUoCUzTufg6CO7vs10bWMYfvWrhTk1Hx6dR5OnDSRd/6qEU/VjuReAAHRoWgBGyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OSzIe9gg3wBZjjrej6mgXLCIT6cbfhCujHxwibJs7L4=;
 b=n4/I1VccbeHOlgIbiH3hNSWMaiaIwOdovNk2sDJiU5CjZbTHN86Utq2R+XQCvAPhAaVyqi1w1CVGI0KgSjGFqTuTLhn9//8XGwHniE4E1TFxowdxWhie6a7xteCsawQkuuiU7aL0VWULwvv3248zGtuncmGVY+XrJMh3AyJUx2dk8QmUIW4qSTVej4akwF5G3ub2147u0SmYxNtTYRhLFyjGU1NnAOwn1yNH/NNTVPu6ACABd7KjYvcBfc6wp6MlziqKev4nNtUCYVNGd6ofZSb3wm1KNaFBYSOtYxgHAZjgEgqV4ELjpgrjXb5zQt6+7vGSwLrRFe13vqnzOIhoqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OSzIe9gg3wBZjjrej6mgXLCIT6cbfhCujHxwibJs7L4=;
 b=EjFakrnRJqftBskVWmYQgeCgTfrhxig4dZLP6Df39v91NPjdpdj1GsYFc9l42s7ZwSVRELVMdhvBhIThJiFiUYnFb607cRFWfOLmHPRN6V+XvmFarmTWDj9GjyQRKjvpHbipGQJFYkgIok43H6r+Fb4N8DDLG1qyP77gVfUJ9A8392225v5jlb5ROEhB/gNcWbwbEm75cJRJRYoj38in50C+d5mLnwqIchjzYMzNjV1Ug1D4PKac6HU4CeT0sqogoXw11Qzfympz6Fb652Mh8lzVr4CpdG/81UXEXrmfsoyBexE7uyyXQ9cBCDNi0xpvvl9uaF+SXSgZ8vujkt8Nig==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MR1P264MB1892.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:2::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.19; Thu, 2 Mar 2023 07:01:54 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::3943:154a:eccc:fe3a]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::3943:154a:eccc:fe3a%6]) with mapi id 15.20.6156.017; Thu, 2 Mar 2023
 07:01:54 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
CC:     "david@redhat.com" <david@redhat.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/debug_vm_pgtable: Replace pte_mkhuge() with
 arch_make_huge_pte()
Thread-Topic: [PATCH] mm/debug_vm_pgtable: Replace pte_mkhuge() with
 arch_make_huge_pte()
Thread-Index: AQHZTLW11OeBjevOWEKHJKA9OZFkf67nEFIA
Date:   Thu, 2 Mar 2023 07:01:54 +0000
Message-ID: <94473cc4-f84f-d42d-2bd1-b6389d8c9ab3@csgroup.eu>
References: <20230302031833.360679-1-anshuman.khandual@arm.com>
In-Reply-To: <20230302031833.360679-1-anshuman.khandual@arm.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|MR1P264MB1892:EE_
x-ms-office365-filtering-correlation-id: e190c28d-ba8d-4f78-b218-08db1aec01a5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XFoDXJZ7q0eX9+xLw93kUZWlnXh/tY7xPkQsEdjKZFPkqtgSDngmzjg8GEjVay/Z0FEhv38cfpv6mqBc/17yNNnAiIGlnbv3EaTj+9YaUpFJzdX1XhuYO4foMamj2zpbgKQHy89j1voQ84+5JFxdX3gGXfbQD/bb3HIdg8cDMrCrC2OUZahIC/VdpfcpCTBVaqM2Uf4Ldo6fAM5UI7srH1eRBQx8RsBof07OymBdXYByeHKG4VSvhQZTHH/S0DBPHhK85DL34STcv4oHBEnjT+cbPH7JWqOX1e7mWi3/XXkL9+rzkAkASLQCtDpAUqWqkYHTmarlEWDbLUAUozoyzRIoid7XR1udtYaysUig0HrqGtYjV7eXqOhz6fQ2G2UjxAZHfcdyMYxM/G1jftSDNnyxbwOPwgvRNP2XYI/nbY4cz/agqf0J6dX0BjH2/rDjwpVA15VI/xVHsfIs/pAdpQ2LU8RCWOmw8M0KGEUdhTYAhzn4sXT3vrBVh/qGY5R6M9zjP7QLujmlJcZktLfQ4FepZzCl+Lw8cnYv9i/FLASi+ZAttqpaFhvcEziCFIbrY73g26QI8IyP+XMJhdyTz5Yh7cH+KCyjlCmIhQtzLOij02Nh5PumIPZ+v+vmqbcyeSP804iYsQlo6HELQrvP7pHvd2Li+KCdenAEIFG0znAc4zqlEqv80es8clW5oKCo+mmdtVAUyehi1ZzejMaG04iqQRfd/mrbMi1n44JEoH0ES0ISkJUl3HjbKMnbqmwMw4p4szjKHiW7U1nGYe5h8w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(346002)(396003)(136003)(39850400004)(376002)(451199018)(31686004)(5660300002)(4326008)(36756003)(41300700001)(8936002)(83380400001)(66574015)(2616005)(316002)(66476007)(8676002)(66946007)(91956017)(64756008)(66446008)(2906002)(76116006)(66556008)(44832011)(122000001)(6486002)(38100700002)(186003)(26005)(71200400001)(6512007)(6506007)(966005)(31696002)(478600001)(86362001)(54906003)(110136005)(38070700005)(14583001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OWNvYUdNdFVYc3ByUCtBWHFIOFVzT3lNR0dId21TRk9SWVRVamczd1NHd0hq?=
 =?utf-8?B?K2VYUVVQNXFTejg0RTlkQ2dSY05yT3o4SnRONGxYcndYN2FZTVlKL3RPZHlB?=
 =?utf-8?B?MnNZNnZJMmZUaVBENFhjanpxRXROOHdwdWN2YTZFbEE1OVpMVXV0N3lWRjV6?=
 =?utf-8?B?MXBOdFVMSFp1cUY1OFpESFhZdytiN3o2eGw3WG45TkhHNFFGb3p4MGdpajB3?=
 =?utf-8?B?VjF6R00wTk9zNi9NSHNycE9IZDlTVXJ1MHNsZytENmg4RVROQU5SMXQ1VmYz?=
 =?utf-8?B?aUNNbWxQYUpXNDhUYU5HdFVNZEVRZFZSY0pvQXBOSkhHSkUvWldDSkhnd0RE?=
 =?utf-8?B?encwRzVlcUVRdzVyQmR0TEtDcjkxeTdiMHEwR2JpM1c1bkR6ZlU4QUpiTWwv?=
 =?utf-8?B?c1pNYU41SEJ4RTZha2NDQlZDckhYMmxHaWE0Ym9kWVdnTzFTVUF5aHR3ais4?=
 =?utf-8?B?NnI0TzVSQjlTVHZpSjJvZW1xRGw4eGxkRm5mRnJoMHRjdVJvemVyRkFWVHMw?=
 =?utf-8?B?cjhJTXhnU3l3MlpHV3pCTTJIVjdkY1ExUGlxTDIrYjBPYlM4RG83di9CbWZN?=
 =?utf-8?B?V1JSSXNRM0JzMUpReExMc2h2Qm40NVkrL1ZtMTN4TmtJSmd1T1lXSGtUZ1lU?=
 =?utf-8?B?SVM3T3BEM1dVenp4aCt0ai8zbEQydUhrSzBMK3RjN0RmQTVjUTJONzlGSi9z?=
 =?utf-8?B?L2NWVmRIZE5wZTVlNDY5czUvbEtuNjJhQThxd1Y4cVNPWGxWWG5CbE55dWxu?=
 =?utf-8?B?QXRDQ2thRXhaeStacS9rSVZiWUxSTUxCTkVDUFkxalZVeVo5UXc0WkJUeDBM?=
 =?utf-8?B?YzZUVk9ScThDaGdrc2pwYk5rTldrWTBOeWV1dTNZL3pBdnRSTktOT1ppMFRZ?=
 =?utf-8?B?Uyt2L3Nrc1o2U3pVYmpRbVZkM1lWeVkxcUR6UUJMZFpJa1p1Sm1ZZDRnNE8z?=
 =?utf-8?B?MHMycENmcGYrYUpEY0s2SXVyeS8wcGFybUEwNnl2R3luZHFVNE1Rb2JPV3NP?=
 =?utf-8?B?S042anZ6NGppMDcraXFzbzMrMmZUYmtvcFhtZWxuN1BQbDdoRE9SRGRIMkFG?=
 =?utf-8?B?dnptMWlOSytodTZrN2QrM2cxdzF6RzJxMmhSdUM3K3NMTDMyM3BURzlORjV4?=
 =?utf-8?B?U2Q4b2o0OHJHSE1OS2FTZnBlbHBmZTZvNThpUXJDRndDN3B2cG1WU0I0bjFp?=
 =?utf-8?B?SExPYW5JU2tRM1hPem1MNnp1SW1mdTFkd01kQjNHaSt1NWdqSjJ0YnFucVlu?=
 =?utf-8?B?SC9kT2k1QVRKZWoxY2FxUm9VSzJsVURsUFB6UzNxSWU4UFNvZXY1VGhKM2hP?=
 =?utf-8?B?SnM4ZHduYzQ1ZGZlSUJNa3h2WjIwUGhLY2JCWW1DN05KaFh6WDhZdEJoUEFv?=
 =?utf-8?B?eXNka3h6R0xoTE5hYW1EWUg5eU5NbkJLd2xMZnU0RnJjTkZBbkxtZS9sSUJs?=
 =?utf-8?B?RWh3M3JnYlE2TFZLQTJ4RTZZWC9LdHE5TDhLYkpsVHMwY2M3SHVtTEhkQWta?=
 =?utf-8?B?TWI0Tk9xc1RXcFJ4SnJQOHhDOEFWOWdvZ1RxTkp0dFRBd21oeXpqS3JEcUF3?=
 =?utf-8?B?cnAxaFpMVXNQUit1S0xvOGdpTFVhOStPUS9FM25mVDVxL2c2MzhsNC9TVmpZ?=
 =?utf-8?B?L0FKdUplWVp1NUZ5THhnUkNBT1ZhWDNyVkplelk0b0lTaDRKSnUzNlhxQ3FJ?=
 =?utf-8?B?REtEU041WXdmcnZiaGtwNVFKamlaUmVqQ0hTTFFjb094TE9oSU95cnFaSE9s?=
 =?utf-8?B?OFF6RkJWbFdvMEVJSUQ0OTFVb2w4VWVnVm15Z2tFSWZGS05MSzZXL2NqcEpL?=
 =?utf-8?B?ajc2YWpHUVpUeUxHK09yMWF1UEJoNzFNaHFWd09OdndlcEgwRWVqY1JNS3NR?=
 =?utf-8?B?eDNhR0RGd05maTN6Z3pWS1Q2NmpIc0xEcFk5T21BM0NKUUQ4dE16Z05JQi9p?=
 =?utf-8?B?NHM3WVVOM0hweWN5Yy9aUzB5YTZDWm1VMStXdFFtQW8zNVVDaGt0Ky92eEZp?=
 =?utf-8?B?aU5rWGVFRjgzeStkSm5tUjJEaHZnUXBRRE96SzdlTkVzcUdIeWhYRUVvamNK?=
 =?utf-8?B?aEhTZFFQdi9EWlB5bXVpY3AwN1NFT3JSZEk5K3JBZE5BeThOZm96YnN4bEp2?=
 =?utf-8?B?T0VsYXZFZ0dyWG8vY25HR0huMHdmS1VkaUNSUjJoRGVicitmVHZPRXV5VDlx?=
 =?utf-8?B?amc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ED659C73852CB841997327D39F72BB79@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e190c28d-ba8d-4f78-b218-08db1aec01a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2023 07:01:54.4828
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vc/FEG23xqD32KvheksxgNbFooznw4xfjo3iou6HMJrQl62cJe8W0iTEYUqtPoAoN53aH6DP6XUu2JHdtC/ZwzqQCJF7cmdwRoKEPi1c18E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB1892
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDAyLzAzLzIwMjMgw6AgMDQ6MTgsIEFuc2h1bWFuIEtoYW5kdWFsIGEgw6ljcml0wqA6
DQo+IFNpbmNlIHRoZSBmb2xsb3dpbmcgY29tbWl0IGFyY2hfbWFrZV9odWdlX3B0ZSgpIHNob3Vs
ZCBiZSB1c2VkIGRpcmVjdGx5IGluDQo+IGdlbmVyaWMgbWVtb3J5IHN1YnN5c3RlbSBhcyBhIHBs
YXRmb3JtIHByb3ZpZGVkIHBhZ2UgdGFibGUgaGVscGVyLCBpbnN0ZWFkDQo+IG9mIHB0ZV9ta2h1
Z2UoKS4gQ2hhbmdlIGh1Z2V0bGJfYmFzaWNfdGVzdHMoKSB0byBjYWxsIGFyY2hfbWFrZV9odWdl
X3B0ZSgpDQo+IGRpcmVjdGx5LCBhbmQgdXBkYXRlIGl0cyByZWxldmFudCBkb2N1bWVudGF0aW9u
IGVudHJ5IGFzIHJlcXVpcmVkLg0KPiANCj4gJ2NvbW1pdCAxNjc4NWJkNzc0MzEgKCJtbTogbWVy
Z2UgcHRlX21raHVnZSgpIGNhbGwgaW50byBhcmNoX21ha2VfaHVnZV9wdGUoKSIpJw0KPiANCj4g
Q2M6IEpvbmF0aGFuIENvcmJldCA8Y29yYmV0QGx3bi5uZXQ+DQo+IENjOiBBbmRyZXcgTW9ydG9u
IDxha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnPg0KPiBDYzogIk1pa2UgUmFwb3BvcnQgKElCTSki
IDxycHB0QGtlcm5lbC5vcmc+DQo+IENjOiBsaW51eC1kb2NAdmdlci5rZXJuZWwub3JnDQo+IENj
OiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IENjOiBsaW51eC1tbUBrdmFjay5vcmcN
Cj4gUmVwb3J0ZWQtYnk6IENocmlzdG9waGUgTGVyb3kgPGNocmlzdG9waGUubGVyb3lAY3Nncm91
cC5ldT4NCj4gTGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzFlYTQ1MDk1LTA5MjYt
YTU2YS1hMjczLTgxNjcwOWU5MDc1ZUBjc2dyb3VwLmV1Lw0KPiBTaWduZWQtb2ZmLWJ5OiBBbnNo
dW1hbiBLaGFuZHVhbCA8YW5zaHVtYW4ua2hhbmR1YWxAYXJtLmNvbT4NCj4gLS0tDQo+IFRoaXMg
YXBwbGllcyBvbiBsYXRlc3QgbWFpbmxpbmUuDQo+IA0KPiAgIERvY3VtZW50YXRpb24vbW0vYXJj
aF9wZ3RhYmxlX2hlbHBlcnMucnN0IHwgMiArLQ0KPiAgIG1tL2RlYnVnX3ZtX3BndGFibGUuYyAg
ICAgICAgICAgICAgICAgICAgIHwgMiArLQ0KPiAgIDIgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRp
b25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24v
bW0vYXJjaF9wZ3RhYmxlX2hlbHBlcnMucnN0IGIvRG9jdW1lbnRhdGlvbi9tbS9hcmNoX3BndGFi
bGVfaGVscGVycy5yc3QNCj4gaW5kZXggMzBkOWEwOWYwMWY0Li5hZjM4OTFmODk1YjAgMTAwNjQ0
DQo+IC0tLSBhL0RvY3VtZW50YXRpb24vbW0vYXJjaF9wZ3RhYmxlX2hlbHBlcnMucnN0DQo+ICsr
KyBiL0RvY3VtZW50YXRpb24vbW0vYXJjaF9wZ3RhYmxlX2hlbHBlcnMucnN0DQo+IEBAIC0yMTQs
NyArMjE0LDcgQEAgSHVnZVRMQiBQYWdlIFRhYmxlIEhlbHBlcnMNCj4gICArLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tKw0KPiAgIHwgcHRlX2h1Z2UgICAgICAgICAgICAgICAgICB8IFRlc3RzIGEgSHVn
ZVRMQiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8DQo+ICAgKy0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLSstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLSsNCj4gLXwgcHRlX21raHVnZSAgICAgICAgICAgICAgICB8IENyZWF0ZXMgYSBI
dWdlVExCICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8DQo+ICt8IGFyY2hfbWFrZV9o
dWdlX3B0ZSAgICAgICAgfCBDcmVhdGVzIGEgSHVnZVRMQiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgfA0KPiAgICstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rDQo+ICAgfCBodWdlX3B0ZV9k
aXJ0eSAgICAgICAgICAgIHwgVGVzdHMgYSBkaXJ0eSBIdWdlVExCICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHwNCj4gICArLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tKw0KPiBkaWZmIC0tZ2l0IGEv
bW0vZGVidWdfdm1fcGd0YWJsZS5jIGIvbW0vZGVidWdfdm1fcGd0YWJsZS5jDQo+IGluZGV4IGFm
NTljYzdiZDMwNy4uOTJiZWQ1YmQ1ODc5IDEwMDY0NA0KPiAtLS0gYS9tbS9kZWJ1Z192bV9wZ3Rh
YmxlLmMNCj4gKysrIGIvbW0vZGVidWdfdm1fcGd0YWJsZS5jDQo+IEBAIC05MzQsNyArOTM0LDcg
QEAgc3RhdGljIHZvaWQgX19pbml0IGh1Z2V0bGJfYmFzaWNfdGVzdHMoc3RydWN0IHBndGFibGVf
ZGVidWdfYXJncyAqYXJncykNCj4gICAjaWZkZWYgQ09ORklHX0FSQ0hfV0FOVF9HRU5FUkFMX0hV
R0VUTEINCj4gICAJcHRlID0gcGZuX3B0ZShhcmdzLT5maXhlZF9wbWRfcGZuLCBhcmdzLT5wYWdl
X3Byb3QpOw0KPiAgIA0KPiAtCVdBUk5fT04oIXB0ZV9odWdlKHB0ZV9ta2h1Z2UocHRlKSkpOw0K
PiArCVdBUk5fT04oIXB0ZV9odWdlKGFyY2hfbWFrZV9odWdlX3B0ZShwdGUpKSk7DQoNCkRpZCB5
b3UgYnVpbGQgaXQgPw0KDQphcmNoX21ha2VfaHVnZV9wdGUoKSBuZWVkIDMgYXJndW1lbnRzLg0K
DQo+ICAgI2VuZGlmIC8qIENPTkZJR19BUkNIX1dBTlRfR0VORVJBTF9IVUdFVExCICovDQo+ICAg
fQ0KPiAgICNlbHNlICAvKiAhQ09ORklHX0hVR0VUTEJfUEFHRSAqLw0K
