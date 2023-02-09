Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA646913B6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 23:48:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbjBIWsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 17:48:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBIWsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 17:48:10 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F9BD26B0;
        Thu,  9 Feb 2023 14:48:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JnclD02I1cYoAG7iH4JaW/eg7XOEbqsPO5M9evka2p7fQki+eYl+oF1CCVdjUyNTTVo8XpNxGzyuTW4NSLXLL8EVh4m9r377A6weTpCQ0oyw8TO5Cvoyp91U5F9u/stFbkMB3u9FGpBy1DDhsYTa3orLQ+bvbPPVQd9wmmq3rg2R6cKlNzTyb+aaVqA9foOm4CgiFrBJkaM429yN3v8jr1wmZR1BBjODom0hyIk3PECOS7k872iywXXont5Qm80pqFiqZyxywh8EC9/tyoI7uZfRGpnC1FMw3UQvSqQcVJYj6V+WzII78rXv3FQl5jntQQgoDDFgDE+lrcfreOLUgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sCekUYxviuoZf+71ZnBbq7Fw21CKWlzV12EpWBN3Cl8=;
 b=cKUHR4Tko9yjhVFgbB7tXiHpiDu1I0ADkNfH3M7ruNrpbt26O9HmJylkp897yaJJTu0Y6Af6TTTiPTdLrFmBp7+rOgPHiFI4YV9E23mnTU8irTOjFr45tIyo1ImjepBej34xDqFX7MfAswEZx9oUvwqiG7YssR9JqmG8+AArHoPlYN+qjq2CZmdUdlrJdfv3fOdcZiyL4NWE4jKfHim52tlvsUoVUzQ6MkqfdUAhAmFhjiMYXSb02gMNeox01FN2Arz7gOQ9yG2j1nfKZhhUjWX0o6JjFG/aik7BI7ew9YaHzaEaO0LOxAJ4v9jRdZJyeJMiT1BOcFuuavWx9CmUvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sCekUYxviuoZf+71ZnBbq7Fw21CKWlzV12EpWBN3Cl8=;
 b=RW3wH/r2Oryb835/KsyU1vrtyi0ELg7J46nUc2gOvXkZsqA0ZNME8hpB1m3OVOcVf/BgZtFV63VBxYo6r/GeyVr0BJcrCinVC/THterj1UySudSfPPT9T633c+HJNjchVA/DaOO2LJITKJY28HKQ1BXMXFT+P1Txr+9ZwLUwK31h7GOF4lXfIidhal/3XmlVn1gxixF2c/wTw+ArgvQRr9my14pIBf557HRhuQplnQ3jwOL0R7nufgYbuoWIkm8nD3MxCb7B+6d5XOtcCjVCse2yRXEALXgceb1TjZId8vCXf2JgHCv1r5CSD35HWShQ4j2T3XmkYzhUJhGFEiAK0g==
Received: from CH2PR12MB3895.namprd12.prod.outlook.com (2603:10b6:610:2a::13)
 by PH7PR12MB6882.namprd12.prod.outlook.com (2603:10b6:510:1b8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Thu, 9 Feb
 2023 22:48:07 +0000
Received: from CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::5f35:2f2d:94a4:f7c3]) by CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::5f35:2f2d:94a4:f7c3%4]) with mapi id 15.20.6086.017; Thu, 9 Feb 2023
 22:48:06 +0000
From:   Asmaa Mnebhi <asmaa@nvidia.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: RE: [PATCH v2 0/2] Add NVIDIA BlueField-3 GPIO driver and pin
 controller
Thread-Topic: [PATCH v2 0/2] Add NVIDIA BlueField-3 GPIO driver and pin
 controller
Thread-Index: AQHZO+8y9re52UCT3U2Ebedf+tA4N67HM7AAgAACSaA=
Date:   Thu, 9 Feb 2023 22:48:06 +0000
Message-ID: <CH2PR12MB3895C873B4381A88636A0EABD7D99@CH2PR12MB3895.namprd12.prod.outlook.com>
References: <20230208185714.27313-1-asmaa@nvidia.com>
 <CAHp75Vf7FcAvSwLPWj4OfnJ61iXy7TAFFzTAq_8b9VXeyCfBFg@mail.gmail.com>
In-Reply-To: <CAHp75Vf7FcAvSwLPWj4OfnJ61iXy7TAFFzTAq_8b9VXeyCfBFg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB3895:EE_|PH7PR12MB6882:EE_
x-ms-office365-filtering-correlation-id: 5907fd2d-c193-470f-c720-08db0aefb5ce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Lw3FSSeVieKziukDlwakWnfyGrYdDkVwz2IH4VnZSCNKY1fZMbDkhMfVBK2gUTV80lbpzy9trHOocPH/Mw+SKwxUZBJThYyCyEf4IodRGVlfcc0bs8Vbl/jJj5UrWSNJXfXIxdcNKmSjxpcSgNfYflT1WNGbQUPYwPaYR+Wf87HdE2FkmMuSPCaoBKR+SBk6ihVByhBjWyfb3CZOtOQY0R5aTFMWdJLo/6j3dQQPDejYHygj2xX78pciCxubS9u7M4EQtjZ+TogZR36HIG/RW319nfhgU1kl6U+vuSO05Y3dRE/D3SdAPut3uW/P3GV45oYwi2M/hDXdlt9JozTkDN+L0KW6EMEmTQNV+iMQyTH92BjMCpTh0EwmzIgjj7tv6+zzp+ToVQZKNRs7ZuIwyIWIAWXEYBssjcCUerEIRBYQaJ8E32z+LfSKF65QqbOrO0WfZ/z1/rLR3JyWTDdS/YvC/Sd0IxBj10mP928nvasDDLtJckJ6jN5AHi0yNCrFJUprTd6rNyKZ2y7sQusWQy70Zg+9JSf9hGHNaDX0qyW6yM247zux23hdNPMSPE/m6RjdqMF7hUfNiFMCuZ/C81eX/QrAP63pkYpzjqk9+nPfepAcTRg4wPUaES+1GffMKO76FCZSJNrPy4wPU4XGLHeuuhkRlQXP2rcpP/j0k+bcF2IIUFJwXPjOtoMJ2Ekn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3895.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(366004)(346002)(376002)(39860400002)(396003)(451199018)(53546011)(66476007)(83380400001)(4744005)(5660300002)(66446008)(2906002)(7696005)(33656002)(71200400001)(186003)(9686003)(6506007)(41300700001)(8936002)(52536014)(64756008)(66556008)(316002)(26005)(478600001)(86362001)(38100700002)(76116006)(38070700005)(55016003)(6916009)(54906003)(66946007)(8676002)(4326008)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eVZHeE9sU0toMlVBUUZMK3FLcTRsMVkvZzBrNDlZYjVuVDNMdkVlRUZRS3pB?=
 =?utf-8?B?WGRJVkFSNk9vUklvV0Z5VFNGTmxGZVZVbEFVT2o5N3RldnBvbHltMlBvMDNx?=
 =?utf-8?B?NWtaT2RjUE5rd2JLQlcrdE5Bc0NQWERRREFCNi9JVWhIOFU3VUpIZkJMeGYw?=
 =?utf-8?B?dUNocDFwUm9wcTR3eXpjaXFWb1V5SmxMb1RpNTBhbHNrTi9hSENydFhtTkdL?=
 =?utf-8?B?Nm9uck9xSnBFa2ROdlhiYmJ0N2g2Y3gzb1VSdXhkMW94SEo4TUt3TmRRa2Vq?=
 =?utf-8?B?OUY1cFJxRUl0bzk1a28vSjFXVEJZVHova3hYNndBTkg1WWRub2srYitKZXNi?=
 =?utf-8?B?UVdlYUs3R1liYnBuUnNBWEZyRnZNRGJJRTF1dVV6WHFVUFhrMTN4QVJWTCtN?=
 =?utf-8?B?WHpqa1NSc2QvZ3VveWZiblJyMEh3MjhocVdzRGI1Y0ZzM2JNS1luOVNmVE9C?=
 =?utf-8?B?UFlpR1IwWjB0RzJ5RFFKam9RakkwNXZaZTZ4UmZockE5d1RPZ2RNbWJGQWhF?=
 =?utf-8?B?b2ptbXF0Q1hscW9VTW51bW5MV3F3S2FDaHFnQUdTNEFyZmxPcklCK0NyN1FG?=
 =?utf-8?B?WW1jdks3SkFUN0tDUU81eVEzVmlvUUpISmRBeHk5blZCWFc2VnFGZW9scElw?=
 =?utf-8?B?Tlk2bnFQS2I5ZEZ6Z3VKZzAzREtvd0ZONHR2SFdoOVBmL3pQSkxQeUhpejhO?=
 =?utf-8?B?eWNhRTJCZWJxN2tJL3ZsQ0VuKzAxVmpBQlUrYWhEeHhXNDh3Y3VoVXZTOUU1?=
 =?utf-8?B?R0psRE12SXdaek1zMEVxK0lQQlE3N2hEUWtra2ErRmFxVUNaVU56NUxkZ2x4?=
 =?utf-8?B?ODl1dkdsTUIwZXZxRjExYllvQklyYjBLbzJFTmJTL2pwYzl0ZzZGbUxQZHFw?=
 =?utf-8?B?VURJMVk0TVh2ellBYkRmQ2VRMnU2dTg0SncrRERRMUlsSFVMVXZLTEZMaHZE?=
 =?utf-8?B?SFo4aU9SOWpCaGIvQmtlN0RYVDRPQi9YY0lBL3ErdW9tb0RmdFZDUE0wc2t5?=
 =?utf-8?B?bWRsYXh4V3RSN1ZNUVhqTDhEMDFEeS9VQnM4U1VXZ1VmUWlNbHJEZ2wzTTRF?=
 =?utf-8?B?dStMU0tnS0t3MHMySmNhMVJESk4zWEJMSHF6cFNvek1kbnR2SWIyK0l1SEZo?=
 =?utf-8?B?U0NSYzhXSUErMkR5dkExbkVONlhPeXJFakJEZVROdW9MQmJGSW9sT2pBQnAv?=
 =?utf-8?B?QXpnbWZwSy9nOG8va3BsTzFGQm90K282VS9MREdGd1J1TVBoVHN0OHJNcVRp?=
 =?utf-8?B?cFp3dWpaSXFpNWdmN1Q3ZEl0Q1Jqa3hTWlQxSVlKQVpha0I5MVM5a2dnVXNh?=
 =?utf-8?B?dGMrYmhrSzB1R2VhWEdnRmJYcVpGZW1LaS9veTgwRE9abEdGUkJwWk1VKzha?=
 =?utf-8?B?ZFlwRlZMbnI4ZzMyZjRKYU5ycndLbnBvZ0Jmb3ZjNzRWY29qMCt4cUdGSHRM?=
 =?utf-8?B?T29VQTk4WGlIMGJ6Z2tTbzgvK0JMK01WZ09kQXd0OEt1YmQ1L0NCdG4wbkZw?=
 =?utf-8?B?bVZnVGtZQVUwakRXd2wzU3dSUng0TXlPTWlvbTRQS0o3ZVBGOXJ5MktlQ3k5?=
 =?utf-8?B?RUdoR0ViYlVvZkZUaWdYUmx4Zis5VGpBN05UWUVVMnVGM05UaGFNVVk4OGdi?=
 =?utf-8?B?UFAyaWkwTFhvY2huR2tXRFoxbTJMRUY2ODhpSUJ5UFowNUllV1FBVmsxWTla?=
 =?utf-8?B?NUFqVWFJbjZFK2YzcE5YQ1VVZGp2R2s3S2JYc3FZYnpYREdUcDNZdEhvWktT?=
 =?utf-8?B?NzRaSCt2Tkh5Q2swRTV2R29GNEhSZkFKK2dtMnJuZ3htQTF2QmtMNmttK0kv?=
 =?utf-8?B?QmdIekNaNkRQODZFdEFsUldobkVBeTgwZ0I2ajVGTHF0RFYwUGo2ZTZEUnFS?=
 =?utf-8?B?Qk5FbnZWS0pPdTVqWHlqVW5VNWlzektJK2Q5K2pJYmhNUTIraXg4Vlg2RW1V?=
 =?utf-8?B?TnE2S05XWjdNQkR3dndWNjBsNDZTVEt2UmdDOEtjTVJMa2lTQlBxbGxkT3I3?=
 =?utf-8?B?bkN5WHEvUkN0MjMrVHMvZk5qa0lDWDZ5dDhFckxGWnFFWVFXK3BLL3RJRnhL?=
 =?utf-8?B?SjdPcVppUU1XZUx0T0N1eEEwWlhZbHdGdDZiT1VZL2lGUXVtT1Mzc0JsNS96?=
 =?utf-8?Q?VZJg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3895.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5907fd2d-c193-470f-c720-08db0aefb5ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2023 22:48:06.6433
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: egL/i2fAGgvmxpOmLCw9EQZsIzhWuAvxwK2iDOo5Kgq29wEFirrBsA9lFeTXtXX3lz88q6DqSe4aUk7VGWGaqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6882
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5keSwNCg0KVGhhbmsgeW91IGZvciB5b3VyIHJlc3BvbnNlLiBJIHdhcyBqdXN0IGdvaW5n
IHRvIGNvbnRhY3QgeW91IHJlZ2FyZGluZyB0aGlzLiBJIHN1Y2Nlc3NmdWxseSBzZW50IHRoZXNl
IHBhdGNoZXMgdG8geW91LCBMaW51cyBhbmQgQmFydG9zeiB3aGlsZSB0aGV5IGZhaWxlZCB0byBn
ZXQgZGVsaXZlcmVkIHRvIHRoZSAiKi5rZXJuZWwub3JnIiBlbWFpbHMgYmVsb3c6DQpsaW51eC1n
cGlvQHZnZXIua2VybmVsLm9yZzsNCmxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQpsaW51
eC1hY3BpQHZnZXIua2VybmVsLm9yZw0KDQpIYXZlIHRoZXNlIGVtYWlscyBjaGFuZ2VkPw0KDQpU
aGVzZSBwYXRjaGVzIGRvbid0IGhhdmUgbXVjaCBpbiBjb21tb24gd2l0aCBncGlvLW1seGJmIG9y
IGdwaW8tbWx4YmYyIGJlY2F1c2UgdGhlIGhhcmR3YXJlIHJlZ2lzdGVycyBhbmQgbG9naWMgaGF2
ZSBjaGFuZ2VkIGFjcm9zcyBnZW5lcmF0aW9ucy4gVGhlIG9ubHkgc2ltaWxhciBjb2RlIGJldHdl
ZW4gZ3Bpby1tbHhiZjIuYyBhbmQgZ3Bpby1tbHhiZjMuYyBpcyB0aGUgaXJxIGhhbmRsaW5nLg0K
DQpUaGFua3MuDQpBc21hYQ0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogQW5k
eSBTaGV2Y2hlbmtvIDxhbmR5LnNoZXZjaGVua29AZ21haWwuY29tPiANClNlbnQ6IFRodXJzZGF5
LCBGZWJydWFyeSA5LCAyMDIzIDU6MjggUE0NClRvOiBBc21hYSBNbmViaGkgPGFzbWFhQG52aWRp
YS5jb20+DQpDYzogbGludXMud2FsbGVpakBsaW5hcm8ub3JnOyA=
