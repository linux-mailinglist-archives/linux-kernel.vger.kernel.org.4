Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1CD472FA47
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 12:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235910AbjFNKWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 06:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbjFNKWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 06:22:15 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7326F10D8;
        Wed, 14 Jun 2023 03:22:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jPCn9sRjxW3eMiIc2xyTNK+HPqV5KzT1I9cQ4n9oaFvurERflFtZIbn6oaRXOI2y9iLXUIGUrz4Xx/+zo9f75t9fVzXpN3X2q7lZnGLXGq2jhLfmpdv50qPEJsQc42PNKW2OWl4VcK7iZaWe+Egtf0/l70nutruueffRrJtVgK2aNmEzmEeTsxfCJuIUqcrQgluaMxHUJzM+qZTLxCpOFm66dfmWtOTitoOhQsYEMoZz63fqC4AVBccDqMJJXPR3181Er+p5m4Hmk9T2MDvmpNx9u7HNVGwHMLGOtSJ6z/XcijY/kctUnU3wPMfTqgqGZ2YdkRnnM66lY1ZCh8UpXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lYoN2G8Ys6JbNUmdX+4ebK4wWFh42LVDT9U5kVx3nnA=;
 b=koYibpKqbigTNhkn8kj4gQcwwjpygSBKhQ00Q6MjY5hUL+6wUg5ln5WzdM+zl2kIe5TmBcFPU/hxQA1ASI7lch7HTNdufHpQrabKtLX9JmrGNzxW6T3oF0YM8kDuwaYv6ilwbO8i9pQT2AEYvfGjfOa45q3joe02QnIxhR3BsLFyTvFpH+LC5oBHf/dD2ViwEZzU38j/m89MoQ5saQE9pRIotZZrEEL49sJ52DUmXti+j0Tta1O9twYOO6y6mijJIepmTXtO/5qre2W8Z3/4i5lV/ZArNinklZ1Iyl3bMu+FzyhVnJj6tvZjmwMdcWpYlOcJdsUD0dnnOz9XaykgWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lYoN2G8Ys6JbNUmdX+4ebK4wWFh42LVDT9U5kVx3nnA=;
 b=SiWRvgzIOnljnmtsaKzJz6dRZfx4Lpde7hiHTu+Tv1dvnasbSbN6xUy3xZUur/6DqBXk4YwPKarqTUpwIZ0j79TZCzPdFsN4U92RkpZkCbq+x3GFrFXx30uc3j0UynptZ1TXW4bt/YzHT/dAAoyMAqz9ShKOnT0jme9ilV0tv/c=
Received: from PH8PR12MB6675.namprd12.prod.outlook.com (2603:10b6:510:1c2::15)
 by IA0PR12MB7506.namprd12.prod.outlook.com (2603:10b6:208:442::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Wed, 14 Jun
 2023 10:22:11 +0000
Received: from PH8PR12MB6675.namprd12.prod.outlook.com
 ([fe80::5abb:a70f:abff:f6c0]) by PH8PR12MB6675.namprd12.prod.outlook.com
 ([fe80::5abb:a70f:abff:f6c0%7]) with mapi id 15.20.6455.045; Wed, 14 Jun 2023
 10:22:11 +0000
From:   "Goud, Srinivas" <srinivas.goud@amd.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
CC:     "wg@grandegger.com" <wg@grandegger.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "gcnu.goud@gmail.com" <gcnu.goud@gmail.com>,
        "git (AMD-Xilinx)" <git@amd.com>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?utf-8?B?UkU6IFtQQVRDSCAxLzNdIGR0LWJpbmRpbmdzOiBjYW46IHhpbGlueF9jYW46?=
 =?utf-8?B?IEFkZCBFQ0MgcHJvcGVydHkg4oCYeGxueCxoYXMtZWNj4oCZ?=
Thread-Topic: =?utf-8?B?W1BBVENIIDEvM10gZHQtYmluZGluZ3M6IGNhbjogeGlsaW54X2NhbjogQWRk?=
 =?utf-8?B?IEVDQyBwcm9wZXJ0eSDigJh4bG54LGhhcy1lY2PigJk=?=
Thread-Index: AQHZnSMWoqaiQCN5yUSuy0pK7+H7EK+IXdSAgAG1alA=
Date:   Wed, 14 Jun 2023 10:22:11 +0000
Message-ID: <PH8PR12MB667577C4800ED8E82C36D57DE15AA@PH8PR12MB6675.namprd12.prod.outlook.com>
References: <1686570177-2836108-1-git-send-email-srinivas.goud@amd.com>
 <1686570177-2836108-2-git-send-email-srinivas.goud@amd.com>
 <20230613-outskirts-dove-e3e39b096647-mkl@pengutronix.de>
In-Reply-To: <20230613-outskirts-dove-e3e39b096647-mkl@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR12MB6675:EE_|IA0PR12MB7506:EE_
x-ms-office365-filtering-correlation-id: b6fca9c0-dcb9-44b4-fe0a-08db6cc1371d
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Qn62BTBTnkRw0ht6kZ6iD2tAKuzxTvgHbKKlDyeHqXbBdFkhqQP6qXwK2WVlYaymnVa+23OrS2QWGltsJGtTGGkR4oUheHxfl4kiXXbqcsC6J5bRGeb4LdN62SWkV1blXhNy2I8eJB3UH7YhGa4hDbCtDJbrNNkj/OkO1I38tkN9gmrs6ZXLbtvjfy2Jo/2HEfwfSh0rWSPHPi+NRG3mz0HgvNUlEkQ68XjwS8x0v74THlXmDOtSv8tiPo1hJdsTinR0IgxBIbsNkTiwA9763Bqa6LWGOQIiSdN00z4mVpCFmN00UsyBl1S+wyfuj6RxZNf/vhvWF8LU28+ZRv5DBbeLc122IYUIlgT4IhvwGcGaaNjYMVowt9Hzbzlx2p/gBkWX1Dq1dGCn0Bom99uopxAZHv/sn83tRGnpi6WxP0YB5QGcliROcGn+FSj8YRSUDSeHCEWxI1DZ/m7iyZOJa4Ssbl1kYQ/0Ype9HbIHyZ+0Rf0nvLpMSldwt5hKhzXfKJuW/tPxqto8byyLYBRKBuyv1PVFvuKJS4ElKiXErGJ1Mi32kBiSWmY2lT5Tc0kuu4/xQOQFeFVGnQucw/+Puo2sAA/NS56MhI81RU1N1Bk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6675.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(346002)(396003)(136003)(376002)(451199021)(83380400001)(5660300002)(52536014)(186003)(55016003)(6506007)(2906002)(7416002)(966005)(41300700001)(8936002)(9686003)(7696005)(26005)(316002)(38070700005)(33656002)(54906003)(122000001)(478600001)(38100700002)(86362001)(4326008)(76116006)(66476007)(66556008)(64756008)(66946007)(6916009)(66446008)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QURLUE16dnRCSG1OMXVKV05yOU5QckpqdkM2N2NROGJtTWk0cElaeEFPNmtS?=
 =?utf-8?B?d1FrQ2hMVi9sREVmUFNKQlZyVEJjSDFYYjJFLzltcmlVbGxNb3JJcVpuMWVY?=
 =?utf-8?B?QWV5MG8vc250eWU4Vm11UzlHTmQ1WFhVbDhnTDA2RjkxNVdLNHdIbUN2akRX?=
 =?utf-8?B?TU5Cb3RSZlhpemFsNitKc3NIYWFUditWbkZKeWNVWTR5ZDU2cFV5Nk10TFcz?=
 =?utf-8?B?YlhIQWt6dXZFd043VGx6a3U2UURQd1ZVYmhGNFBsblJiYzlBdVNVV2lySHNK?=
 =?utf-8?B?WkRYaDYvektCb2UxSURnMmJRY2U1U0ZHS2FDUG5zRWdLNEhnYVQ5K1dRMWU3?=
 =?utf-8?B?WXRLUmRnMGNhcmJOb1NwMEhJYVFVNXU5SkU3Ui9TQmRjdit1Q2lXdG50RVJx?=
 =?utf-8?B?ejVEZWh1eDBCcWZSZUhaOGdubWM3VHFobnhIUGlkS1M3Wmx0Z0JwK3Z5cVZE?=
 =?utf-8?B?TjF2M0UwYkJCU3FZVkE5dVM0Y1M0QVBUSG4yb2tqYlI3MHZqUDdjQjNrWUZr?=
 =?utf-8?B?aHgwMzdyWXhvdGtQQlB1TnA0a1VzaWJmSEs4dXZBcktCckJ3eFNFbEM3T0JB?=
 =?utf-8?B?Sk1aQW45cVhNNzJrM0dOcnFYYThpRmluamRJdXJFcVhlOEUwbGdhVmRlSUh2?=
 =?utf-8?B?WVZvWGJWUEZ5cU81OU4vSUZXWDEwS0h1by92YkhtVDVLd2lNdEE3UVltU1h6?=
 =?utf-8?B?UVFKTVJ6OHBDYjFpSE85ZDJuYjE2Y212V1FnbmkrcEZXRzQxRkMwcTJZVFRy?=
 =?utf-8?B?NFhlYStrUGZ3Mm9oOG1QcG9za2R0bVp1U1pHVXJ6R2Y4RnRHeldnZHNVTkp3?=
 =?utf-8?B?bWFBc3NsVzcyRXJFWGEvbHdmczFCK3BwODlHMlh4NkF4anNZQjZzT2c3YXlL?=
 =?utf-8?B?NFo1TXBMalZWaUMwZDE1czBMSVc2UFhsa213WDl1cURqU1A4aVVRTkFaYzlm?=
 =?utf-8?B?Zmtka2FkQ2pnL2RNdmFQQ0NTVVZvOG5qSjRyaGppYmMvR2FpUUpBUy9YR25v?=
 =?utf-8?B?RFEvTkhuNjA4VHRHek1SRU1aMHF1VDE4ejFxTFk1bDB1VXdNbk9iWlB4TDIz?=
 =?utf-8?B?WitVVEZXUDFQLzdtYzJROEZkZEozbXlsWVRvd1dCVmFzVTRYQjh6aHhVZXo0?=
 =?utf-8?B?dVJwS0JQMUU1bHZRVWdCQUJwdWZyc3Nrcmt6MkVRR2lTblllbDJaVVlUVWZW?=
 =?utf-8?B?ajJIMW9hSlVIZ25ZRS9WYUFBQ1ZQZnp2cDdFekthemlUdmdERUxycnFwTWNk?=
 =?utf-8?B?QTFqd1JzV0cycmFHSmMvVU1hVjdodDZNbTR5VzZrNWE3WFNUQm5YOVdpcmxS?=
 =?utf-8?B?Vi9xQkdVZkI0STU4T2ZZT2cvSy85ZEI5eUVKcVhUWFBlQzRrUmFJUU9jNFd1?=
 =?utf-8?B?Z0h1V2tuajF1RFNLK2ROWmgwczQyU2laOTZFZ1hkdjI2VEN5aVlqMG1oMGtV?=
 =?utf-8?B?eFQ5VXZkNmNwN2hCYzVzcFJkOWZJWVFFK0dxNHdGdlkrZzMyS3ROeC8yR09q?=
 =?utf-8?B?YUNUM1lpcW1yYmdQUWlUeDR3VnJjN2x1aTBLTXJubk1PbDFES0gwNDZYTW9H?=
 =?utf-8?B?T0xnQ3VUMXdYUG1LVWI5L2pCSWdZMUgyaXg3dklkclVYWFRBL21aSW50a3By?=
 =?utf-8?B?eFNHRHZoc2V6YzZOK09QblUxVlFOaWtCTnIrY1ZaQ3pYamlVa1JDSXJiMk5F?=
 =?utf-8?B?TjRTeEFlMVBYVlVRUjZ4am9TWjAwUG5wRnc0MDZuckJtTXhYS3JoWEhZTTNa?=
 =?utf-8?B?aFBmZjVsTjNLYXNPUVUxb2NIVHNEelJjbkhzN04rRkNXZGNBNGp6UHRNTnBi?=
 =?utf-8?B?VFRtbXVSSGliN0ZzSGRpZXFXWEZJUFdMRTNIa3F1M2Y3UldOa1o5dzRISGd4?=
 =?utf-8?B?eDFHbVEvYjJDanlONWhQZHZqVEEvUTJVM3BNNjRjSDl6T3lBVmJOU2lTQ1RV?=
 =?utf-8?B?MlJudTFFU3BUdkd3QkFYQjJOTXp4ZkRRcTI5NjFobzJyTXlmdDNnWmNNakNQ?=
 =?utf-8?B?MDRLNU9BRjdEbERJaWhDNXc0MEdaVDBnWHpCTTdha3pjUzZOK0xkemNVTVVW?=
 =?utf-8?B?dzdtdjhUcUZBS1dFT3hFZjVQcm5NVFlmTmhFUFlURmwra3k0RTVFV2tBSHkr?=
 =?utf-8?Q?ByL0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6675.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6fca9c0-dcb9-44b4-fe0a-08db6cc1371d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2023 10:22:11.1661
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VKJSfgYjQ5c8ncZzQrmjiKEikbnJOy0nXvQzYihPnT+tZ8/RKBRULTR6A4e3mo3I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7506
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IE1hcmMgS2xlaW5lLUJ1
ZGRlIDxta2xAcGVuZ3V0cm9uaXguZGU+DQo+U2VudDogVHVlc2RheSwgSnVuZSAxMywgMjAyMyAx
OjIzIFBNDQo+VG86IEdvdWQsIFNyaW5pdmFzIDxzcmluaXZhcy5nb3VkQGFtZC5jb20+DQo+Q2M6
IHdnQGdyYW5kZWdnZXIuY29tOyBkYXZlbUBkYXZlbWxvZnQubmV0OyBlZHVtYXpldEBnb29nbGUu
Y29tOw0KPmt1YmFAa2VybmVsLm9yZzsgcGFiZW5pQHJlZGhhdC5jb207IGdjbnUuZ291ZEBnbWFp
bC5jb207IGdpdCAoQU1ELQ0KPlhpbGlueCkgPGdpdEBhbWQuY29tPjsgbWljaGFsLnNpbWVrQHhp
bGlueC5jb207IGxpbnV4LWNhbkB2Z2VyLmtlcm5lbC5vcmc7DQo+bGludXgtYXJtLWtlcm5lbEBs
aXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+U3ViamVj
dDogUmU6IFtQQVRDSCAxLzNdIGR0LWJpbmRpbmdzOiBjYW46IHhpbGlueF9jYW46IEFkZCBFQ0Mg
cHJvcGVydHkNCj7igJh4bG54LGhhcy1lY2PigJkNCj4NCj5PbiAxMi4wNi4yMDIzIDE3OjEyOjU1
LCBTcmluaXZhcyBHb3VkIHdyb3RlOg0KPj4gRUNDIGZlYXR1cmUgYWRkZWQgdG8gVHggYW5kIFJ4
IEZJRk/igJlzIGZvciBYaWxpbnggQ0FOIENvbnRyb2xsZXIuDQo+PiBQYXJ0IG9mIHRoaXMgZmVh
dHVyZSBjb25maWd1cmF0aW9uIGFuZCBjb3VudGVyIHJlZ2lzdGVycyBhZGRlZCBpbiBJUA0KPj4g
Zm9yIDFiaXQvMmJpdCBFQ0MgZXJyb3JzLg0KPj4gUGxlYXNlIGZpbmQgbW9yZSBkZXRhaWxzIGlu
IFBHMDk2IHY1LjEgZG9jdW1lbnQuDQo+Pg0KPj4geGxueCxoYXMtZWNjIGlzIG9wdGlvbmFsIHBy
b3BlcnR5IGFuZCBhZGRlZCB0byBYaWxpbnggQ0FOIENvbnRyb2xsZXINCj4+IG5vZGUgaWYgRUND
IGJsb2NrIGVuYWJsZWQgaW4gdGhlIEhXLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFNyaW5pdmFz
IEdvdWQgPHNyaW5pdmFzLmdvdWRAYW1kLmNvbT4NCj4NCj5JcyB0aGVyZSBhIHdheSB0byBpbnRy
b3NwZWN0IHRoZSBJUCBjb3JlIHRvIGNoZWNrIGlmIHRoaXMgZmVhdHVyZSBpcyBjb21waWxlZCBp
bj8NClRoZXJlIGlzIG5vIHdheShJUCByZWdpc3RlcnMpIHRvIGluZGljYXRlIHdoZXRoZXIgRUND
IGZlYXR1cmUgaXMgZW5hYmxlZCBvciBub3QuDQoNCj4NCj5NYXJjDQo+DQo+LS0NCj5QZW5ndXRy
b25peCBlLksuICAgICAgICAgICAgICAgICB8IE1hcmMgS2xlaW5lLUJ1ZGRlICAgICAgICAgIHwN
Cj5FbWJlZGRlZCBMaW51eCAgICAgICAgICAgICAgICAgICB8IGh0dHBzOi8vd3d3LnBlbmd1dHJv
bml4LmRlIHwNCj5WZXJ0cmV0dW5nIE7DvHJuYmVyZyAgICAgICAgICAgICAgfCBQaG9uZTogKzQ5
LTUxMjEtMjA2OTE3LTEyOSB8DQo+QW10c2dlcmljaHQgSGlsZGVzaGVpbSwgSFJBIDI2ODYgfCBG
YXg6ICAgKzQ5LTUxMjEtMjA2OTE3LTkgICB8DQoNClRoYW5rcywNClNyaW5pdmFzDQo=
