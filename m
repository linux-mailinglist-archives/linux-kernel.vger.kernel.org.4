Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B54E5EBDB9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 10:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbiI0Irg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 04:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbiI0Ire (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 04:47:34 -0400
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-eopbgr90045.outbound.protection.outlook.com [40.107.9.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A02A7FFA3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 01:47:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WI49gkF7ISP6s5WD327V6MKNdqORTeAOP8fFiI0z1FJjyGrDfS09DWd/SRo5XjbPRPTSqajI0Vh1SOmNvkTsaKd1XYqVjr486JL1Oici7kvxoURIPaRpArBucCixD5Ap9frW7YBQZoPSBJP9+b7Gx5pONtcSk2uMFJHLoywjeZ3w6WlOjj9a+ufgc2TLlMOEd3ezCv+AqywFL9cNk4SCONmxxnQyg89zvN/QTvXYj8bWvnje/Fs3zLXXZrbUy0Tzz3MKutMlUHiscg/WGVa0reFwpVHMfntWpRj/Ips39/TK+e765OsMdIOHl1B4QwLTkDtfhKlyZcf4syXdfPNyXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ztXT0mS7NefIHghr3eNkLcWy1mS6T81HkjVLRuAvJY=;
 b=e6kz73uCISshEkbNGzDI2yJ9hiiBiBF1I24tbLkAImIYDzuY37BXq0kDF7iJTrdNLcbnAUh/mUf0OU9tgt7OJYxxqCVOxzWHQJGucP+TfZEosi7Sch4r9nc22Fgn3joyOfeEBqOx3DdcODTZmdLsshhydGVnCR8WubgkvYDhPGkM0zH0om20ohZWwEg/YvWT/GEwrgVjO3gwczhUiVdWfHuk8jy/dAYNJMl73ONf25HiBQfDDGqlRhSsjkFAK1RO6anbyjHIbfiZR2aOF5Hn8UTMXvAYpmn2NZ3yHHnVi2uZpkEe8IKByT58xvb2hsJVgOuDJh58Si9Slnkwm3Jf0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ztXT0mS7NefIHghr3eNkLcWy1mS6T81HkjVLRuAvJY=;
 b=Yx4oJShh3f3TeXp6/t6fX8ahyFMl/8NQRkcfloKAktrWg5m76A1UsBYvyJzgi+kjdmvDArYEQ5c+w3WAU4rGyQxLz7NqDA3Me6Sb1NZI1DMwwi3E02LIe1L495u0kmKgmKzMApw7C0oOw3i0RN4l0Ej+p6ci+6BF6LJp3e3ESf0aNYpBSByC23+VO4B/HRFq9qUzugI8jdUDQTlgav55H2vO5Q8BaQYOGcSddOXiN8VIBalu0muPYX2Bewik8pF5KSEQf8E2HjvRFdaHX2HlLA163Ej2/rtE8PdSEFu7C/FsDA4xVtiBrOUVDoCoeXX3tuObArCI3j2v2FqWhDsWqg==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MR1P264MB2452.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:35::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.18; Tue, 27 Sep
 2022 08:47:29 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::f4ad:3944:a7f4:fcf3]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::f4ad:3944:a7f4:fcf3%5]) with mapi id 15.20.5654.025; Tue, 27 Sep 2022
 08:47:29 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Yajun Deng <yajun.deng@linux.dev>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/early_ioremap: Combine two loops to improve
 performance
Thread-Topic: [PATCH] mm/early_ioremap: Combine two loops to improve
 performance
Thread-Index: AQHY0kY1fJB+v0igI0SP81kWrY1zLq3y9v8A
Date:   Tue, 27 Sep 2022 08:47:29 +0000
Message-ID: <f06b9b34-bb74-4d15-88a6-b44de2adcc3a@csgroup.eu>
References: <20220927075239.270583-1-yajun.deng@linux.dev>
In-Reply-To: <20220927075239.270583-1-yajun.deng@linux.dev>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|MR1P264MB2452:EE_
x-ms-office365-filtering-correlation-id: 398c6de0-291f-44a2-b485-08daa064e92b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NYy579hlIy0MNlufhAkNjp89KV36oGGvfH2pxstK4OejenJX5jICUlODjEP3Izc2uLJQeXcNVr3pcuWYFNn3H6jsOWDtz3En2sNqfzWaPVsFZGazvD2EUPMbXjoUQYI77YPOv9ZYi3UdTs2Vgkxk2uTClL2OFoPHS4PjMRRsQU0LjDRsu51NRu1BUq9xziI78rCtlyrPGfoV3u8Eka7JnQXqXd5Qa6csqRxgFgU4vsGzJ5nnMIkXEVqwXBOK8NION7ZuNZLjtfptqisEnzkksDayb+jXcmK1yCUclrWpfERiu/iW9NoVI9OAYkOTcmXs7FrQ5dnAf2vwOUpqo20BC2aTJLN2NPZ0etK5EKdrG0Am5qpBLhcPklrGkL5EDXYmPHnM4Vdazm4sxDYUY1cEwfYQnHhu52YEMthd/geqiy+KLD8ioI5TCXx6dacGxnsXDtBxoc0Rvl2D+kCwW1oYLaq0AdWx3ryub9shXVlCxRToyICfE0ycfmqitytakMo3kPFFI9MM8JexkRBiPyYz6n93QbQoX2HYHZxoe32hrU3nlV/naPb2e0V4msgBFYV7fU8qINDS/rV3H7mrcufOtBPWKxTJldW8l2lsvgValF/i88gDZH394+zpIOOsqp6FOStswXrfXds7+jzFEYdJxrk5o69U48NkDmK2SDIeub6CYgJLp3CSUBDeddBXowMKXl0oKdRyGHpKhekr6MB9ggLy/sCEBbtELYMkQGY4IwwJlO32lGWbNB2T/aL62Zs6jdwpbDF83PWkDX8h+D4Ct3Ke3GV5QvguWpUinPbWIGqtrSmFRJdTmpL/46Vkpcf7S70Y0BabFoe+O1/AVzOBiQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39850400004)(396003)(136003)(376002)(346002)(451199015)(316002)(4326008)(6486002)(478600001)(110136005)(71200400001)(66476007)(66946007)(64756008)(76116006)(66556008)(8676002)(91956017)(66446008)(31686004)(26005)(5660300002)(6512007)(44832011)(8936002)(6506007)(2616005)(186003)(36756003)(2906002)(41300700001)(54906003)(122000001)(31696002)(38100700002)(86362001)(83380400001)(38070700005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b3pCZS9qUk1SZ29iTkxoN2VKR1AwOVpPM09GSXNnbEM3UFRJVmVSdEVrKzRJ?=
 =?utf-8?B?VVpXS2gxSVhsY1BURkNROGRGQjFuKzI1c291SjR3bmNUOFk0em9HU3ZPVXFQ?=
 =?utf-8?B?OCtwUVVnOUh2eTByQW5XWHdBdStFcXZUTHQwNlBVVEEvWno5U3gzSXloN2F0?=
 =?utf-8?B?OHBTZEh6VXlkTU1CMmhTZ292U2VPT2k2bnhWdUN1UzA0RmRHRXBYQWg5R2FK?=
 =?utf-8?B?dUNCUGVRcHUrM3NpeGgwdVhLVFdua2xVMm1QNFc5N2ZYWURpS2dVcThpdzA3?=
 =?utf-8?B?WjFkS0NJOXFhUHZreGN2ZWVKNkZFNUdqMUYwWGM3WlpHZUk3SlBMTnBrNFhx?=
 =?utf-8?B?RHdPSUpzQkdXbFRaK2h3ZjkzWUY4YnFQanJyRnkxMThNRDMwZU81WVBnWjBM?=
 =?utf-8?B?bGErSFdFOEpqcENrOHJsUVFlUnA4TzVxR3ZGdFVaNkI1SDQ1UE1uaXl6OVVJ?=
 =?utf-8?B?akZ0WjFucms1NzRBNVhtdzBQUk9hcmNQbVU2UWFyNG43MkdWMi9OYVN2TXd6?=
 =?utf-8?B?cEFDdEZjM1BsaTF3d2gzdGJBRkp6N09OdzZxZWhnSm9DV2hQYUlwYU5GR2xp?=
 =?utf-8?B?L3RBekVITU1yYjViZTB1cStYang1dGYraFJQS0hQMk1ZL2diS2NyczlQdS95?=
 =?utf-8?B?T3JIcnBnSldjcm41M2k2UUZVakJvdkhtdU5BRzh4SkFoWkp4cVhkaVJXZ1Bw?=
 =?utf-8?B?Y0NjMjl5cEZJelZrdG51UGZkK0puZjBIbFhxaFFyZXZhM0tVUTFXclVSbFNi?=
 =?utf-8?B?WGZVaC9kVmlsVUZoQlZEUEFFcEVtUHAyL0pHTG5mUWNVVTJUUDRnYTJqOUVz?=
 =?utf-8?B?dVZGYjdaeFhrL2d5eCt2UWFjallKSzNqL0N0VVZyVkZmL1oxQVFVeklXSkdp?=
 =?utf-8?B?djB2c1QxNmtFU2ZHV2Y4RnB3UVozU2Q5YkQxbFVkaEdSRHBJNmE2TjR4Snlx?=
 =?utf-8?B?NFVRT1UrTFVRYU4yamY2QTVsTjlKSURtRmpUa00rMktSZUNoZUpZTDBSeHND?=
 =?utf-8?B?MnZCRjJ2aEs0dG9PUmRYbFcybjl1YnJOUC94WWVpbG5SY3hyUjV6MFNjblRR?=
 =?utf-8?B?MmJCWElyNEFaMFZVd1R2TzJLNmUwS0lFZmp5d0pnM2NlUERkV1kxcFA4WWU5?=
 =?utf-8?B?UVRSb0JKN0ZFU0ZocmZtU3BIQUE0WVkzVnpXN0NEM0VDKzlYZC82MysrOE5S?=
 =?utf-8?B?WTlWN1BndjVOTFloUFZzQTRJOGdodjRUTFBuTW0rdEltaUdONVdFcitsUVNY?=
 =?utf-8?B?Z2pKa1NyN3JJVjIreklUOEo1SDJZV0VKYU85ZHVUczhtN2ZLRWlQRFRPSTFG?=
 =?utf-8?B?ajdmOE5XNlp3WThGdFhwbnl1SVQ4aUc1L05CMkJSRmhkWkUySXJNUEh1Nngv?=
 =?utf-8?B?RUpxU0d3VjNlOU1IMnFBZkROSGg2eE1PS0ZwWDl4WUtDZ09CWktXbWZRQ0ZB?=
 =?utf-8?B?dUgwalRVMG9Pa0Jxd1RVOXhheFBiNzAwWXp2Si9DaCtZRk9welJkaGJtQ28z?=
 =?utf-8?B?eC9JY0JqWGZxTDJCOUFIN0ZidTVmMUxFdGIySW9WTkdzZ3lsTEMyaG5xTEdE?=
 =?utf-8?B?bERUTWlxT0prOHRURG5KT2tjNUI3MExQMnBBWEFIUlhkSVhZRmtFa2puZHBS?=
 =?utf-8?B?TWVyYVJSQlVXNHVWVkg1VElKL05FUDB0RDU3Q25ORVdXOFJnd2Z6TmhjTFR1?=
 =?utf-8?B?Q1V6bFpSeVhXV21odWpOQlRsWVhyY0REczF4enZnNHhFSldGTmlzcGdyVU9v?=
 =?utf-8?B?Sm1kZnhEZUExa0d4Uk44dDdrclQwOVltelhUeEtDODBEU1RiL1pNeGNvY0tu?=
 =?utf-8?B?aC9JbDRQUEZLcWo5Y3dQRGtQcnY3N0lmU2RlWkdscDQwNzRqdlhXK01XMHZD?=
 =?utf-8?B?bi8rckNSQWNhQjlZTDAwaVcwejFST05GcnJnRFhYZzVYUUxCbW8vZUo2c1p6?=
 =?utf-8?B?R1hUeUdXOEFBWXdGNHpvbXZtWEFLVWhHSlZUd2R4b2oyTWpMM2kxdUo2SWNN?=
 =?utf-8?B?UXJCejJGVFZFQWJvQVdRTnVvb0xLbUFYcjdzeWlwQ1ZJNFBpSWZpcnpzUVVB?=
 =?utf-8?B?ejdHZXRxekN2ZHRLYjFmZk5rQTd6UWQ4ZEJiVTJQWUNMWXQ0ZGNPd3Q5aVdF?=
 =?utf-8?B?WlNDMkU2Q3FzVTBqb0xaV3MrREtPWjFWNHVCOU93Rit4RjI4aDljbERJZnRW?=
 =?utf-8?Q?WZanrRQdzRdUT/aVijdgH2A=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4A622B540BBFB54A9FA436AC284D300B@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 398c6de0-291f-44a2-b485-08daa064e92b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2022 08:47:29.5163
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X7iBG85X6koaT/cJ6WBvxo6PGLcoophIJaW/tNS7Uin4AI/yALMPyJFBYSnSfMjDKfhPTsgqQuZYr5pcTLyTVN5hsTgjtM9dHfuWY38tySk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB2452
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDI3LzA5LzIwMjIgw6AgMDk6NTIsIFlhanVuIERlbmcgYSDDqWNyaXTCoDoNCj4gVGhl
IGZpcnN0IGxvb3Agd2lsbCB3YXJpbmcgb25jZSBpZiBwcmV2X21hcCBpcyBpbml0LCB3ZSBjYW4g
YWRkIGENCj4gYm9vbGVhbiB2YXJpYWJsZSB0byBkbyB0aGF0LiBTbyB0aG9zZSB0d28gbG9vcHMg
Y2FuIGJlIGNvbWJpbmVkIHRvDQo+IGltcHJvdmUgcGVyZm9ybWFuY2UuDQoNCkRvIHlvdSBoYXZl
IGV2aWRlbmNlIG9mIHRoZSBpbXByb3ZlZCBwZXJmb3JtYW5jZSA/DQoNCkxvb2tpbmcgYXQgdGhl
IGdlbmVyYXRlZCBjb2RlLCBJIGhhdmUgdGhlIGZlYWxpbmcgdGhhdCB0aGUgcGVyZm9ybWFuY2Ug
DQppcyByZWR1Y2VkIGJ5IHRoZSAhaW5pdF9wcmV2X21hcCB0aGF0IGlzIGNoZWNrZWQgYXQgZXZl
cnkgbGFwLg0KDQpCZWZvcmUgdGhlIHBhdGNoOg0KDQowMDAwMDI1MCA8ZWFybHlfaW9yZW1hcF9z
ZXR1cD46DQogIDI1MDoJM2QgMjAgMDAgMDAgCWxpcyAgICAgcjksMA0KCQkJMjUyOiBSX1BQQ19B
RERSMTZfSEEJLmluaXQuZGF0YQ0KICAyNTQ6CTM5IDI5IDAwIDAwIAlhZGRpICAgIHI5LHI5LDAN
CgkJCTI1NjogUl9QUENfQUREUjE2X0xPCS5pbml0LmRhdGENCiAgMjU4OgkzOCBlMCAwMCAxMCAJ
bGkgICAgICByNywxNg0KICAyNWM6CTM5IDA5IDAwIDA0IAlhZGRpICAgIHI4LHI5LDQNCiAgMjYw
OgkzOSA0MCAwMCAwMCAJbGkgICAgICByMTAsMA0KICAyNjQ6CTdjIGU5IDAzIGE2IAltdGN0ciAg
IHI3DQoNCi0tLS0gRmlyc3QgbG9vcCA6IC0tLS0NCiAgMjY4Ogk1NSA0NyAxMCAzYSAJcmx3aW5t
ICByNyxyMTAsMiwwLDI5DQogIDI2YzoJN2MgZTcgNDAgMmUgCWx3enggICAgcjcscjcscjgNCiAg
MjcwOgkyYyAwNyAwMCAwMCAJY21wd2kgICByNywwDQogIDI3NDoJNDEgYTIgMDAgMDggCWJlcSAg
ICAgMjdjIDxlYXJseV9pb3JlbWFwX3NldHVwKzB4MmM+DQogIDI3ODoJMGYgZTAgMDAgMDAgCXR3
dWkgICAgcjAsMA0KICAyN2M6CTM5IDRhIDAwIDAxIAlhZGRpICAgIHIxMCxyMTAsMQ0KICAyODA6
CTQyIDAwIGZmIGU4IAliZG56ICAgIDI2OCA8ZWFybHlfaW9yZW1hcF9zZXR1cCsweDE4Pg0KDQog
IDI4NDoJMzkgMDAgMDAgMTAgCWxpICAgICAgcjgsMTYNCiAgMjg4OgkzOSAyOSAwMCA4NCAJYWRk
aSAgICByOSxyOSwxMzINCiAgMjhjOgkzZCA0MCBmZiBiMCAJbGlzICAgICByMTAsLTgwDQogIDI5
MDoJN2QgMDkgMDMgYTYgCW10Y3RyICAgcjgNCg0KLS0tLSBTZWNvbmQgbG9vcCA6IC0tLS0NCiAg
Mjk0Ogk5NSA0OSAwMCAwNCAJc3R3dSAgICByMTAsNChyOSkNCiAgMjk4OgkzZCA0YSAwMCAwNCAJ
YWRkaXMgICByMTAscjEwLDQNCiAgMjljOgk0MiAwMCBmZiBmOCAJYmRueiAgICAyOTQgPGVhcmx5
X2lvcmVtYXBfc2V0dXArMHg0ND4NCg0KICAyYTA6CTRlIDgwIDAwIDIwIAlibHINCg0KQWZ0ZXIg
dGhlIHBhdGNoOg0KDQowMDAwMDI1MCA8ZWFybHlfaW9yZW1hcF9zZXR1cD46DQogIDI1MDoJM2Qg
MjAgMDAgMDAgCWxpcyAgICAgcjksMA0KCQkJMjUyOiBSX1BQQ19BRERSMTZfSEEJLmluaXQuZGF0
YQ0KICAyNTQ6CTM5IDI5IDAwIDAwIAlhZGRpICAgIHI5LHI5LDANCgkJCTI1NjogUl9QUENfQURE
UjE2X0xPCS5pbml0LmRhdGENCiAgMjU4OgkzOSAwMCAwMCAxMCAJbGkgICAgICByOCwxNg0KICAy
NWM6CTM4IGM5IDAwIDA0IAlhZGRpICAgIHI2LHI5LDQNCiAgMjYwOgkzOSA0MCAwMCAwMCAJbGkg
ICAgICByMTAsMA0KICAyNjQ6CTM5IDI5IDAwIDg4IAlhZGRpICAgIHI5LHI5LDEzNg0KICAyNjg6
CTM4IGUwIDAwIDAwIAlsaSAgICAgIHI3LDANCiAgMjZjOgk3ZCAwOSAwMyBhNiAJbXRjdHIgICBy
OA0KDQotLS0gTG9vcCAtLS0NCiAgMjcwOgk3MCBlOCAwMCAwMSAJYW5kaS4gICByOCxyNywxDQog
IDI3NDoJNDAgODIgMDAgMTggCWJuZSAgICAgMjhjIDxlYXJseV9pb3JlbWFwX3NldHVwKzB4M2M+
DQogIDI3ODoJN2QgMGEgMzAgMmUgCWx3enggICAgcjgscjEwLHI2DQogIDI3YzoJMmMgMDggMDAg
MDAgCWNtcHdpICAgcjgsMA0KICAyODA6CTQxIGEyIDAwIDBjIAliZXEgICAgIDI4YyA8ZWFybHlf
aW9yZW1hcF9zZXR1cCsweDNjPg0KICAyODQ6CTBmIGUwIDAwIDAwIAl0d3VpICAgIHIwLDANCiAg
Mjg4OgkzOCBlMCAwMCAwMSAJbGkgICAgICByNywxDQogIDI4YzoJNTUgNDggODAgMWUgCXJsd2lu
bSAgcjgscjEwLDE2LDAsMTUNCiAgMjkwOgkzZCAwOCBmZiBiMCAJYWRkaXMgICByOCxyOCwtODAN
CiAgMjk0Ogk3ZCAwYSA0OSAyZSAJc3R3eCAgICByOCxyMTAscjkNCiAgMjk4OgkzOSA0YSAwMCAw
NCAJYWRkaSAgICByMTAscjEwLDQNCiAgMjljOgk0MiAwMCBmZiBkNCAJYmRueiAgICAyNzAgPGVh
cmx5X2lvcmVtYXBfc2V0dXArMHgyMD4NCg0KICAyYTA6CTRlIDgwIDAwIDIwIAlibHINCg0KDQpN
YXliZSB1c2luZyBXQVJOX09OX09OQ0UoKSBjb3VsZCBiZSB0aGUgc29sdXRpb24uIEJ1dCBsb29r
aW5nIGF0IHRoZSANCmNvZGUgZ2VuZXJhdGVkIGlmIHVzaW5nIGl0LCBJIHN0aWxsIGhhdmUgdGhl
IGZlZWxpbmcgdGhhdCBHQ0MgaGFzIGEgDQpiZXR0ZXIgY29kZSB3aXRoIHRoZSBvcmlnaW5hbCBj
b2RlLg0KDQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFlhanVuIERlbmcgPHlhanVuLmRlbmdAbGlu
dXguZGV2Pg0KPiAtLS0NCj4gICBtbS9lYXJseV9pb3JlbWFwLmMgfCA5ICsrKysrLS0tLQ0KPiAg
IDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvbW0vZWFybHlfaW9yZW1hcC5jIGIvbW0vZWFybHlfaW9yZW1hcC5jDQo+IGlu
ZGV4IDliYzEyZTUyNmVkMC4uMzA3NmZiNDdjNjg1IDEwMDY0NA0KPiAtLS0gYS9tbS9lYXJseV9p
b3JlbWFwLmMNCj4gKysrIGIvbW0vZWFybHlfaW9yZW1hcC5jDQo+IEBAIC03MCwxNCArNzAsMTUg
QEAgc3RhdGljIHVuc2lnbmVkIGxvbmcgc2xvdF92aXJ0W0ZJWF9CVE1BUFNfU0xPVFNdIF9faW5p
dGRhdGE7DQo+ICAgDQo+ICAgdm9pZCBfX2luaXQgZWFybHlfaW9yZW1hcF9zZXR1cCh2b2lkKQ0K
PiAgIHsNCj4gKwlib29sIGluaXRfcHJldl9tYXAgPSBmYWxzZTsNCj4gICAJaW50IGk7DQo+ICAg
DQo+IC0JZm9yIChpID0gMDsgaSA8IEZJWF9CVE1BUFNfU0xPVFM7IGkrKykNCj4gLQkJaWYgKFdB
Uk5fT04ocHJldl9tYXBbaV0pKQ0KPiAtCQkJYnJlYWs7DQo+ICsJZm9yIChpID0gMDsgaSA8IEZJ
WF9CVE1BUFNfU0xPVFM7IGkrKykgew0KPiArCQlpZiAoIWluaXRfcHJldl9tYXAgJiYgV0FSTl9P
TihwcmV2X21hcFtpXSkpDQo+ICsJCQlpbml0X3ByZXZfbWFwID0gdHJ1ZTsNCj4gICANCj4gLQlm
b3IgKGkgPSAwOyBpIDwgRklYX0JUTUFQU19TTE9UUzsgaSsrKQ0KPiAgIAkJc2xvdF92aXJ0W2ld
ID0gX19maXhfdG9fdmlydChGSVhfQlRNQVBfQkVHSU4gLSBOUl9GSVhfQlRNQVBTKmkpOw0KPiAr
CX0NCj4gICB9DQo+ICAgDQo+ICAgc3RhdGljIGludCBfX2luaXQgY2hlY2tfZWFybHlfaW9yZW1h
cF9sZWFrKHZvaWQp
