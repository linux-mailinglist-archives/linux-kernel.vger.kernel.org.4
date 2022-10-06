Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 275155F6273
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 10:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbiJFITX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 04:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbiJFITN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 04:19:13 -0400
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-eopbgr90080.outbound.protection.outlook.com [40.107.9.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A50915CD;
        Thu,  6 Oct 2022 01:19:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P7FQzt78sXhSSTJigE5AH/nhwJbE4N3Uh+vw70iIjn0zzCwIZvY4NOee8QdUiXFjH8jaP3EQWelIYtBnoDcD9SW5n/6XK7Lx5cxW6YDfUV+QPdCDML3VWyvIO6K7DMOvDpkF4J9cnuw8+fL5AAMQ7k/RCqLWOtZKrs2CFM35z2uKm//pXqorjvIz2ZU9tonVvUgWknncds38vuJ7oKbbnUnbHD3G1K/BieXzBe20Mk6M1BeCeLhJY9Cp6EDelUbb5ylRcknaDGfyll+iv/Ykv185PmXJcK82hGWilZ0M6PWuvzHArHGhK9ZPUinMBujCUZoXE7proFCPWp1/hvGZsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dmMxqL/XcVe2isU7I/u5+BcGGeUTVVP3tZRIHbI5pwE=;
 b=EkBOo3kRxL3jTPSNsWtUL/G4PfWXqF51MRd6IRs7d2+1ty59dkkVHM+oQN6+n9eCd7lFnwg3bOizxO4PLPkYicnp0E1eCOYXJfWUsENe4qNskK0WOl4JvE4H40YZe1Hlz/LlTIeYBCidJCTLG7bviu/Vp1QHwB8+I1hXlUzYwpgMI/nRDFucni5ekzLbKhmCoQ54ko7zA9b7TwhIYiWc9EZG1SQZPLO6B7eefXBbP0etGJJp6n4Ie8O/iTSaLpj5N2f9JMfxxwCjIAM/cuJLMo1qDGL9H6bn5O7PyCF/1Z5EGfMviJ2XbNR4WiZa7FXDCiOXkZ6LOpPxL2jHBwVvlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dmMxqL/XcVe2isU7I/u5+BcGGeUTVVP3tZRIHbI5pwE=;
 b=hN6wuBLCUTduaGi6AzdMWCk3kFLvv+mGQmpyNZCR7b10N+3o05eoe5RCLNlrwde+w5yIhYEQR8veZLF+dzSozxby8ZeVDE0sKWRbHosnXaH0sx3jRisi5vL8nc0uCAE5+SBlMc/dY9yZObGSGfuyv3dLtBsKezCfRXkdpH5G3sHIslbHOROuVTPd/8cu1I5oc9KY6tpnFbBAA80Zqr/6Iuvkh6Vp0+nr3k8tAXaz6HphRTxFg3BczWOZGuCFyqQ2BxaNUndLxBqFR9/mfnTWZnZ6TghA0DQEsKSO5gUrBUJz/Mq/vL+WOYDzec3Cj2b64zfPLI9nE3vkKdEwQ9wUvQ==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR0P264MB1962.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:168::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.34; Thu, 6 Oct
 2022 08:19:08 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c854:380d:c901:45af]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c854:380d:c901:45af%5]) with mapi id 15.20.5676.036; Thu, 6 Oct 2022
 08:19:08 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: [PATCH] ata: pata_mpc52xx: Replace NO_IRQ by 0
Thread-Topic: [PATCH] ata: pata_mpc52xx: Replace NO_IRQ by 0
Thread-Index: AQHY2ULwo13q7okCIE6Pi+qP7CnouK4A20yAgAABFgCAAAtxgIAAHkMA
Date:   Thu, 6 Oct 2022 08:19:08 +0000
Message-ID: <044012e9-549a-5c23-c5b8-9013344477f8@csgroup.eu>
References: <a8c87c6d8dd6d9e57c515036a333ff89fc56bcbf.1665033366.git.christophe.leroy@csgroup.eu>
 <60557988-a5e5-8c81-72f9-c0f3ab9ed573@opensource.wdc.com>
 <14fa0e63-1a43-6c80-5ffe-1c7100ed88ba@csgroup.eu>
 <fcf05af6-fce0-0ac9-c4ff-7b8960bcacc6@opensource.wdc.com>
In-Reply-To: <fcf05af6-fce0-0ac9-c4ff-7b8960bcacc6@opensource.wdc.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PR0P264MB1962:EE_
x-ms-office365-filtering-correlation-id: b1f705ab-1cfe-4d07-485d-08daa773711d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fxYhhPtxLKbY3ZvTOL420kjUurS/y7IYg/6lA2ALNNaiCsl5lpaP4LvfBIvoTexfVTSZoc6wzAhxywmg1mzugmMid6M7aa0G9pW4UfOP1M2ZNjhSJTW1Qxcji5NruqDbsXTwDEuyCAW0NDbyUvloANHHlybGwTSxDYw249jfqiidDquOEWC7GOfmPtmAIi4z5knzmwTqwBPhsUJ6Nd5Tlj6fuJ4SXMiLBBt+s9hC2dUMhzXo2rcRgSihaeQBFZLucLkRa7jGFZH12ckSXa42jqSyilzP+qrNWh5/koQ8vD2x1uVM2MQgywgMxEzjoFyteseKsJxHeaDIrdql0xZyOsZ+trelYHErnkgtnZEvwDL5E9ibqY5imBdffGyLz3DjWkqwC4uHzUKqzk5hDEp7CA1Ipi3ojz4xX3R+nSYPE4z/Ga3+NSmqlnbE+X1R3RHEtoWxCEiF7+oL8wSkYz+cMYdNmsiz8FxwAXpzZOB2EDfrP7+p0QDGWTWcEzhpe2KleXvEY+H0zaBK4d+oqNLcATl2HhYT2bPNcPYuds9zkqKEbwQWkI4bCwpStyGR3ZaO13GycNa/kcl7IKPp7GcOfgLbuBYqtVFlg5UUXuXH5xxfw5MdlAhj/c3aKVerdDNdKBLAjE7gPEhQqHobjLTfYDFc48xiARseUEH3NeubOwWx0OlSQrZrtN+/959V7utmhryChZEdUPrJul2H9ab9KmE6qJSUlEl2hsWfblEA2u1pjwGfjkXWTUS0VCuLloIDtC8EyEf8XYUKCr4HqoqOtUEHgjw0q7xfd2mJdW3nseo11GdR7Cfkg9xtjSpe6eSodCEhFo/jhBy5HYL0IufxSA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(376002)(39850400004)(346002)(396003)(451199015)(2616005)(186003)(66574015)(83380400001)(8676002)(76116006)(66446008)(5660300002)(44832011)(41300700001)(91956017)(4326008)(66946007)(64756008)(8936002)(36756003)(66556008)(53546011)(2906002)(66476007)(6512007)(26005)(6506007)(31696002)(122000001)(71200400001)(54906003)(478600001)(110136005)(86362001)(6486002)(316002)(38100700002)(31686004)(38070700005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WmJJamg1bzQyUmNPUjZTSXRkT3o2akFlb0Ztclk3UjBaVzNJS1ltUzdhbWI2?=
 =?utf-8?B?OXhJNVUvL3FtUnZIanhTQndBT1R6VWRZbDdKa0NoTzlhem01T2RNbG4rbm5R?=
 =?utf-8?B?YTJ6T0pCM1VXMHdPdlhRaWY0c3lkU00xOVNiUzlFa2hLTXNZYTl1ckp4em0w?=
 =?utf-8?B?dmtYOTdGRUZITWpySG1JRlJ5dXlKeGp2b01UWjZQZ1U2N3p4ZS9EYnpxWTdi?=
 =?utf-8?B?NlZTZzBRY2N4QmpPVnpUM016bXBYTE1oUmlRdFV6UlhGYkY4R1l1V0IvL3dW?=
 =?utf-8?B?NnNzaEp0bFRQalZvOUNicG9rZnBraGMzN0IzQTZWeUVlbFpTUjRpd0JXQjlD?=
 =?utf-8?B?UlFNOTQyKzQwNFpuVkNFaFd3aEg1WTRld2RLTjJpWFBJcG1LcEhZdGhFelhn?=
 =?utf-8?B?eWRjL0ZFdTYyZ2RoMldVL3N4VDVBVDFrbFBWL05DcGxYWG43ZGpLcFdjVFRw?=
 =?utf-8?B?UngyWTMyN3ZROGF2Nm1FTjJxdGNTUzJqQmpsYk81cUFhWGNwNTRTdDI1Lzd6?=
 =?utf-8?B?MW1XQXdSb1YxU2tnUys1TGt2Snc3U3VmcHpDSldiR0VMRFJNb3FoZFpuUGVw?=
 =?utf-8?B?cmpQeStNNUpYY3BPM2NuOTBKVUx6WFNFcGNmTVFucVY1Y0FJZW10MXBUUTFv?=
 =?utf-8?B?dlhsMVVDbldEckZuZXBVaXdpcU13TTZxNDlMWlhvYWpVQm5oN25Nc2E0VXFy?=
 =?utf-8?B?ZzZkWmY5YXBnZkF3NFRXOEJOVlVMdkYrV0RZb0VodUgyZlRmZjdxNS8waDBQ?=
 =?utf-8?B?bHFRQ2RqczlmZWZZNndTRTMvMHU4OHFPRm00L2xJRFk5TnFvaHd3ZGRsYzF5?=
 =?utf-8?B?NzdJZ1VFbE8ydkVnb3I4R3BXMXl3ME02VGtWYTJoMFVVVGl3ZFRGeW92alRm?=
 =?utf-8?B?bFZMN2s4a2Zlc0EwU3c2VVFJWXI1eW9NV0daaU5RQmxEY0ZXdXVXZktHbHVk?=
 =?utf-8?B?N0R4QTF5RE5lL01yblpGRlhzR0FyV1lTT3AxRjNXcTRudzl5ZndZUUVRM3Nh?=
 =?utf-8?B?UDExZ3hURTQ3Ri9JcCtrR3JycHJJaytOOFA0WStMcDNaNVFCSlh4NUZnTmVx?=
 =?utf-8?B?VWhtWXBaNWwwb0ZqbzVrV2trdVBrYmFyUlFZS09JZk9oN0MyQXpmaUNzcXJu?=
 =?utf-8?B?bTdjUDlFUzgwbFY1WVkycThCTmZTVHc1YTlmTFhtMVZEZGEya2U3MWsxT3Qw?=
 =?utf-8?B?ckRYUGxtN2w4RlgxQW8xck9RMlBOWGhJU2NrcjdaSkhhbmJoektVMVUxYXg5?=
 =?utf-8?B?T1daR1JDYUkzZStyUHFTdVhLMkMxcSthK0ZwNjZabHh3Y0Q3bGhpUUlJT3VL?=
 =?utf-8?B?UlpBWm1xdHlEQS82S0hiYXZpKzY0TlEwV25YbDBodm4xbFFCYkJkTDBsZHVQ?=
 =?utf-8?B?a3BMcU5LckJKSk82Ym5xMExUYnJJVmVWVUZocDROQTBEQUszQ1pNV0M4QWRy?=
 =?utf-8?B?RUtPa2VhSHN0UFpuVVB1QjViU2gwZ3MvNkhIR05keVBDdFVabEk0b1krL1ZR?=
 =?utf-8?B?ODQ5NkxGVklPUnhJbU9CWExkQlY3ZG5SNXFvakNJcDc0L0FyMHpvdjBiWmln?=
 =?utf-8?B?NTJSU290UUcwT1FySE5GbjBtT3NxN3FBUHNENCtuYnYzRWJLWWY2bjcrbUNK?=
 =?utf-8?B?WCtnWnRJRmM5UGhRQjluZlBHTG8zU0RIRTJnZHFGbzBQZld1aTEwWlN2SFNo?=
 =?utf-8?B?cStuS0NLRkxLRUFqRVM2SHBuL2x4U3FVTXZBelA2MnI5d0dGZ3JYc2g5VEZI?=
 =?utf-8?B?TzlkNWNocWNOdzV2YnYrcHRaemdHZU5LblFiTFdwL3dsZ3U2QVRIVFhwcWhU?=
 =?utf-8?B?R3RIYXNIa1luNk1tWGl4UmZRWndMbXBYSDBYUURwSFFKcndXM2Y0VDQ3SGZP?=
 =?utf-8?B?KzdsYWJSTmtFYTNtLzFKc29VdldEVWNmajhkUm5hd2pNRlNvTHVENTk0OURE?=
 =?utf-8?B?OVRmQzFnc1UwVGMrSjY5bk1hcXFsblhobjlqcC9FdnZvbnFKUW9ORnBhRVlI?=
 =?utf-8?B?aHJhNHNkRlBCU2JCcE1MeEsvamgxUW9mZk5HUE51WFEvOGwvMG45U0tSZGp5?=
 =?utf-8?B?NzB4SkxoUG13Z2FsNFRVZGkrSkZmelEyeE4xbDVVTXViTDZsM1RSMmJmZ2ln?=
 =?utf-8?B?dHM1cC9lSmE0bnZsQVNyUUtjalBsWjU1ZHY1WEVFWGFxemlDQ3F2c3ArcUF6?=
 =?utf-8?Q?Lg0QGsAKZS0sq7eNTv9wrkM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EACDBBB068A4DC4187F03F3CFC7E1C1C@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b1f705ab-1cfe-4d07-485d-08daa773711d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2022 08:19:08.6699
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ogws0lLcAVCQjvCLbnit5f8F7QPdYI0Z0VGN5gMv9LFmne7NSCHNudYz2tcQCxPYH05Iti1zivSMoYJGxVUnOrrcdmSH0WNMQYLFq8S5hnI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB1962
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDA2LzEwLzIwMjIgw6AgMDg6MzAsIERhbWllbiBMZSBNb2FsIGEgw6ljcml0wqA6DQo+
IE9uIDEwLzYvMjIgMTQ6NDksIENocmlzdG9waGUgTGVyb3kgd3JvdGU6DQo+Pg0KPj4NCj4+IExl
IDA2LzEwLzIwMjIgw6AgMDc6NDUsIERhbWllbiBMZSBNb2FsIGEgw6ljcml0wqA6DQo+Pj4gT24g
MTAvNi8yMiAxNDoxNywgQ2hyaXN0b3BoZSBMZXJveSB3cm90ZToNCj4+Pj4gTk9fSVJRIGlzIHVz
ZWQgdG8gY2hlY2sgdGhlIHJldHVybiBvZiBpcnFfb2ZfcGFyc2VfYW5kX21hcCgpLg0KPj4+Pg0K
Pj4+PiBPbiBzb21lIGFyY2hpdGVjdHVyZSBOT19JUlEgaXMgMCwgb24gb3RoZXIgYXJjaGl0ZWN0
dXJlcyBpdCBpcyAtMS4NCj4+Pj4NCj4+Pj4gaXJxX29mX3BhcnNlX2FuZF9tYXAoKSByZXR1cm5z
IDAgb24gZXJyb3IsIGluZGVwZW5kZW50IG9mIE5PX0lSUS4NCj4+Pj4NCj4+Pj4gU28gdXNlIDAg
aW5zdGVhZCBvZiB1c2luZyBOT19JUlEuDQo+Pj4+DQo+Pj4+IFNpZ25lZC1vZmYtYnk6IENocmlz
dG9waGUgTGVyb3kgPGNocmlzdG9waGUubGVyb3lAY3Nncm91cC5ldT4NCj4+Pg0KPj4+IERvZXNu
J3QgdGhpcyBuZWVkIGZpeGVzIGFuZCBjYzpzdGFibGUgdGFncyA/DQo+Pg0KPj4gSSBkb24ndCB0
aGluayBzbywgYmVjYXVzZSB0aGUgb25seSB1c2VyIG9mIHRoaXMgZHJpdmVyIGlzIHBvd2VycGMg
YW5kDQo+PiBwb3dlcnBjIGhhcyBOT19JUlEgc2V0IHRvIDAuDQo+Pg0KPj4gSSdtIHNlbmRpbmcg
dGhpcyBiZWNhdXNlIEkgd2FzIHRvIHJlbW92ZSBOT19JUlEgaW4gcG93ZXJwYyBpbiBhIHNlY29u
ZCBzdGVwLg0KPiANCj4gT0suIEdvdCBpdC4gU28gcXVldWluZyB0aGlzIGZvciA2LjIgaXMgT0sg
PyBPciBkbyB5b3UgcHJlZmVyIHNlZWluZyB0aGlzDQo+IGFzIGEgImZpeCIgaW4gNi4xID8NCg0K
WWVzIDYuMiBpcyBmaW5lLg0KDQpUaGFua3MNCkNocmlzdG9waGUNCg0KDQo+IA0KPj4NCj4+Pg0K
Pj4+PiAtLS0NCj4+Pj4gICAgZHJpdmVycy9hdGEvcGF0YV9tcGM1Mnh4LmMgfCAyICstDQo+Pj4+
ICAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPj4+Pg0K
Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9hdGEvcGF0YV9tcGM1Mnh4LmMgYi9kcml2ZXJzL2F0
YS9wYXRhX21wYzUyeHguYw0KPj4+PiBpbmRleCA2NTU5YjYwNjczNmQuLjNlYmQ2NTIyYTFmZCAx
MDA2NDQNCj4+Pj4gLS0tIGEvZHJpdmVycy9hdGEvcGF0YV9tcGM1Mnh4LmMNCj4+Pj4gKysrIGIv
ZHJpdmVycy9hdGEvcGF0YV9tcGM1Mnh4LmMNCj4+Pj4gQEAgLTczMSw3ICs3MzEsNyBAQCBzdGF0
aWMgaW50IG1wYzUyeHhfYXRhX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKm9wKQ0KPj4+
PiAgICAJCXVkbWFfbWFzayA9IEFUQV9VRE1BMiAmICgoMSA8PCAoKnByb3AgKyAxKSkgLSAxKTsN
Cj4+Pj4gICAgDQo+Pj4+ICAgIAlhdGFfaXJxID0gaXJxX29mX3BhcnNlX2FuZF9tYXAob3AtPmRl
di5vZl9ub2RlLCAwKTsNCj4+Pj4gLQlpZiAoYXRhX2lycSA9PSBOT19JUlEpIHsNCj4+Pj4gKwlp
ZiAoIWF0YV9pcnEpIHsNCj4+Pj4gICAgCQlkZXZfZXJyKCZvcC0+ZGV2LCAiZXJyb3IgbWFwcGlu
ZyBpcnFcbiIpOw0KPj4+PiAgICAJCXJldHVybiAtRUlOVkFMOw0KPj4+PiAgICAJfQ0KPiA=
