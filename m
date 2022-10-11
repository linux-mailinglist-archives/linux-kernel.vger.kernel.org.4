Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6245FAF1E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 11:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbiJKJKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 05:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiJKJK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 05:10:27 -0400
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (mail-be0deu01on2126.outbound.protection.outlook.com [40.107.127.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D96A753B7;
        Tue, 11 Oct 2022 02:10:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a9Femzm2kQWeQApb9Kd5bwzB0k/x1uDlCvrDWb9lOcy8Fc2XHKW1qdKIKJw5wCSvJKzjYa083HyoRWnX7OjfGYm1Bf+DfuMpN6U2PiXelqU0XUgI9WTkOx8VUojVQziuO5v99AbyxZq/5dqsVDlQakTRGeBGS85OMgueHeS7kYc82iPUcGfcLEfsmCdICPOEePlLZOGPmb1gyuPsUYn0ri48T5KO+Xy14aebnjlcHcTqEAjZ09pK4Bwiz5MLo64/ESvPTxCwcjuxdiNRW2vvUlVl1bs2FxGD1DkKiZQkjExDHSgANiDwvY66tJBK10z7g/W+cjUYvZZmTU0fcmiYUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TLcVMuV8LWQUvpis9SYNN1oxlsBIvS5/RXCJM8kzP8o=;
 b=bWvb5J3lui47OsaWDWZQ6E6c2MB38Z74qz2teOYXMiJb0D8C7vPudukX+SugwY0pHTwA122S4lPF0fB8IVHoDBzkbuPVvJQb4lXjnhtRsHrGJLej7UxqI7kAI4xuS3nYatXMnJ5MjcvTUAGvC9Gfwksw/y/V2TAJNf5vqRhamC+/zd1xaFwwi2WExKRJ1+ryt4M/ymLK6pBP/YGSysFRNd3S6h9qafpRTOF6l5I8iLgRhLI7+ttRKVQTPrt7VZA/l87O4xeWDrUHwT56b0pzjgXxLYDkQL/eOVs2McDOSx5CgUnq6g8Ahuy9mz41u3D1FVFq7dlcCri7iU/BlosfHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductor.onmicrosoft.com;
 s=selector2-rohmsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TLcVMuV8LWQUvpis9SYNN1oxlsBIvS5/RXCJM8kzP8o=;
 b=GtVMcSH896GKse/jk2UovlgXlCS8+d9uuTg50naldVPDsxc51W2D3B+2gxg+bIYZm5EA5YZmfFfu6ytq5CxJbqWsb00y8QWs0NChnvOu+e2NV9AeFfPi0RwVRzThBTN19VL28zWlvzEKVSs0o8SDBujt2g+qq3lC2Z3e4yt40mc=
Received: from BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:59::10)
 by BE1P281MB2871.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:4d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.21; Tue, 11 Oct
 2022 09:10:22 +0000
Received: from BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
 ([fe80::3a53:b9b9:b851:76e4]) by BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
 ([fe80::3a53:b9b9:b851:76e4%5]) with mapi id 15.20.5709.019; Tue, 11 Oct 2022
 09:10:21 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>
CC:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 4/5] iio: accel: Support Kionix/ROHM KX022A
 accelerometer
Thread-Topic: [RFC PATCH v2 4/5] iio: accel: Support Kionix/ROHM KX022A
 accelerometer
Thread-Index: AQHY2ZFPkSIdWucYsEm9xmjmqpi3z64BsMKAgARS4YCAASiaAIABwzSA
Date:   Tue, 11 Oct 2022 09:10:21 +0000
Message-ID: <7abed64a-d544-a228-b5f1-4c7b5a3bd1be@fi.rohmeurope.com>
References: <cover.1665066397.git.mazziesaccount@gmail.com>
 <88e24b01da9f44ebf5fcd8344ded0b75ff742fbf.1665066397.git.mazziesaccount@gmail.com>
 <Yz8fK7j8pxlU76xt@smile.fi.intel.com> <20221009133351.6ff4894b@jic23-huawei>
 <Y0O4fiQQX0M317h/@smile.fi.intel.com>
In-Reply-To: <Y0O4fiQQX0M317h/@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fi.rohmeurope.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BEZP281MB2454:EE_|BE1P281MB2871:EE_
x-ms-office365-filtering-correlation-id: c09d6667-dc87-4b75-a4d8-08daab686cf7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OHeg1yKSDjvDDLQl+whpp5Feufadl9gYQ1O5jQ9aW3fzgBEw9ErvNZbafJLB/1AMj7asTpyl6y+IaFb3JehXL7iHalexV0Zwn+x64cQApLEb5BzV7eNw3I2b4/eiTsYtrNFgpvnTJf++KFK/dDkfyr01yjMrHQ7lhVrL1TJv+MvzqNJjdZ8C4uATfmoeGY3iK78pQ0azRnuW5rwf2aE/bBhEmXXhAmuqRQ+kT49DpAJcs+b4TdP+2USGP5Qhk03j7bIMUTLv/uUzG+dvRbDfwqi2WR8MrdKzdlbXqejVJuhlutRdu5PMsgRG1zhAljnolAjWxYrSLIls9oXu04i5jGd/URHhVZQqWLSbeCFKIhYGDI8dg/dAbLnpRzrjv+m/Sd3cpRFwTexyH1GZRlQesD3H+licBqy9aPQFxceDWIGBkQXTecKECwXUc3XMqLUYVIa+jy9vOTeHGPZHLSX2DShxOuxA2BQ5zj1u9J5wvL7OGwLhxqeZfJBVScT9nEnyMh3cgVMOefFM3SS4h+SK4iH+0WZituLPZ5Gus7JxPBZ9nrqmlijz/RKQN3aknZRmP0ahfTHoVFF1zkbYxrZW0sGUPQ+UH/PJxWZdTzKNKGvnJxnwmwXt/ysj57ee8s2i0HUwiy8XkzMcibfeX1dQVRmwiFTWwiGuCgdhfhd/+b91agzY8hLmv7zBIqASN3rauBOm9MbwMhoShbFBNSTA4J4suHJ/pFCT3L3bsQ/AxdflnzGEYaaPjALH4Vm1ym9gNdKUBKfsrWl8yrVSQ+UGIZRX1f8960/uB5GuBPzKgMXVBsCwLvlLb5hnxQf5AO9u4PsdXIL5olE1GTULb97ing==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39850400004)(346002)(396003)(376002)(366004)(136003)(451199015)(6512007)(31686004)(110136005)(316002)(86362001)(54906003)(31696002)(478600001)(6486002)(71200400001)(38100700002)(122000001)(38070700005)(83380400001)(2616005)(186003)(53546011)(6506007)(7416002)(5660300002)(4326008)(8676002)(64756008)(66556008)(91956017)(8936002)(66446008)(66476007)(76116006)(66946007)(41300700001)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TC95YTh4SFdPTkxhMU5jNFlsbnRhUXoybnB2RUYydnF0a0hYRlRQNmNYSFAw?=
 =?utf-8?B?ZUtpc0h1WnZBWGR0b2dHSWtORktRVTNJZXhYcCsxaGNhTS9CV1ZUWCtXRzYr?=
 =?utf-8?B?dHRkU2U5c1RYNnIrU0N2YVhaQW9wVlh6Sk9pKzU4MmFJeW0xbXpQSUlaNUJu?=
 =?utf-8?B?RnFFVmphS0ErY0lnQnRMMjJ2cUlDYjZLM1BQYyt4WHl1TjFML0xjc2ZXdGN5?=
 =?utf-8?B?cVhEbm5BNVdSVGVrS1ovNXdiRzZHWnVtalVTMER6bjhKcVh1c1lvdkZkem5i?=
 =?utf-8?B?bndtSFJhckdJeTVJZU9TVkRjSVpmVE40NDR5NDllYUZQUFExK25QbC94OWw2?=
 =?utf-8?B?S0JuL01aTFNVQlZLNFZOWU5lcmNiOGdDRlhRRTZIS2dJK1ErMDhDWVlicGNE?=
 =?utf-8?B?TEp1Y09pWEtHM0JQUG5EenJqL3FUakx4azBwRllySmFGOGR4a0Y3VU9zNFNX?=
 =?utf-8?B?L1ZMVCt3L0pTV3BRQ0tobGVjM04rMTY3b1IrNUd3MkJxWkt0d3ZFVzhTOFIr?=
 =?utf-8?B?dDlVL1Z6aXh3MEdBeFZKSkE1NXVJeWNzVll3K1RTb1NJamdJZzVSSHQ5Z0x2?=
 =?utf-8?B?cmJaMld2YnFYSStaaDFXbHdJSk1ORlQ3VVZWVzh2MWpzVll5QkQ3R2RNWWRm?=
 =?utf-8?B?OHplSlJyMDRYVkk1Z1dQNWVoNzFyRFJjcDVvTTBEZkZndnB5eHNnbUhLYjJ2?=
 =?utf-8?B?S0xsZk1lZStpaUhuQkJBUENnWDVsbklwQytHQThPMUkrcThVQ1Vxc1A0cVZo?=
 =?utf-8?B?blBXWU56SFdHOE1vYm01LzU1OGc0bnFsZThDUzhEWnFEdnhHcFJ5d3NFQTky?=
 =?utf-8?B?U3lkNWhacDQ5bFJVUzdqbzlubmRMdHdjT1ArbnkyeTBTZktFbjVkUnArS0Mr?=
 =?utf-8?B?Wlh5YUIwWEFVVTljQXRMTjc3SURFU2Fqc0xoYm5Udi9ob2JuWSs4Y2RPYlc2?=
 =?utf-8?B?ZjNnMDlyM0ZGQ3VXTUFUUHZ6VG5rREhxSzhFcnpPNmU5aEJqNUIydFpOcDVl?=
 =?utf-8?B?cW5LN1p2QUJyaFlVSXR4TlNYZUMzWGFSeUVQZzNITTJzN0h2VHRoOEZwdnNW?=
 =?utf-8?B?eVExcWZwa3lENDA4ZndmWmRDYXZCa0JJVzArbHhkL1FvaUVvOW1XVThxZzY0?=
 =?utf-8?B?aEJ4aktJUGdGVnh6bHArbU1vM3RYckJSR0ZuTmgrTHd6VzZ1VUxWRC9XTGJ6?=
 =?utf-8?B?SnI5SkF1SU4rYm1RV241UVJuS21CM2FhWnFpNzdsRGh0ZFlMampjblV0ZmxK?=
 =?utf-8?B?WUVLc2RXR2xIYThlbVJSTHYyblI5TW96em42bDdDb21xL04wNFd2YUQ4dVB6?=
 =?utf-8?B?d2Q4VDFDRTFWSW1qTGFkTFNxSkVJVmd6RlErTW5lTFplOGI0ZTZNNFhXdERj?=
 =?utf-8?B?NE1rNE9EaGwvNkREUHM5MzZkVENtQXI4OGFPS1JFLzVsdTBTcldSNHhOK2N3?=
 =?utf-8?B?SFZaWldTN2NwcjdlOEZyRURCL2VxUEpjSXIzZFR1OHl0RTRmSzd2eWtOdUFU?=
 =?utf-8?B?VWl5TUlNMjk2akhINEZDVkhyWjZDT2VVeTc4ak9WeU1ab0dLZTdOb3IvZ1Rt?=
 =?utf-8?B?N3BuRFF5ZllWNkNaWHpwOXZjalNhUXFWU0Q2SGlmdFlPR1VSTTRRM25XcXpS?=
 =?utf-8?B?d0w5Q0ZzYWFDMTR5VlBpOTZMT1lvbXR3VzRoTGthbGJ6YVgxMU1wZE1FVlFj?=
 =?utf-8?B?WGQ0Zkw3OHpkSTM1eHR6ZUZIcmZtYzVtWk9zdVhOZlcrZ20vZ0ZhY1R3ZkNZ?=
 =?utf-8?B?VUpGZFg4UFNqZXgxY3Z3T0dNbHhwL25kVmxQaGNrSlhqcm5mOFBabVBSRm9o?=
 =?utf-8?B?cjEyQ2tjNHQrS0h0Um9hR1prVjhBb0YzYUlab3pVQmw2aE5tanJSaG4xNEdG?=
 =?utf-8?B?UXQwYkRoOFpxMmpqdk55YjQ0TFppTEp2cTVWVXJXc0xJWlI3RUVxaWNySTRl?=
 =?utf-8?B?aU5pSk1NSUxIY3dWL01kNjRybDlRUERmdkUxb1d5UWRySDloSGJhU3dtUWov?=
 =?utf-8?B?Zk9ZakxiUmpFZGFxUUU3VmJHNkVVcjFocExaczd2WnkzZDdvcG5ZQlNwZFJk?=
 =?utf-8?B?VXFPc0RTYWRtL0p0OW14ZXYyNXhEekNFdGladlBKRGg2SE5jcHYvK0JZbFhB?=
 =?utf-8?B?Y1lnUkpwSnJyZy9lNjdGVXZ1bDFwR2hGeFF1VTBKSHdCcVVrdHpXQ2NLS21H?=
 =?utf-8?Q?OY13RUo2bYd+gDKHFd17Xv0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <58C3C31A83AF744EB3A584F464615FE6@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c09d6667-dc87-4b75-a4d8-08daab686cf7
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2022 09:10:21.8995
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b24d4f96-5b40-44b1-ac2e-2ed7fdbde1c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nrXUgSUfbVeu8kkuyz+xja05HAs5gQvFKLveLZ0OVJ8B3R5+WThgRotqZSNDbCZXfs/2jn9PSUkzQYCSJLfpaV6aQ7mTSsYyRWxwqSPYrKd0Cotkedq1fa0WH7yQL/Pd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE1P281MB2871
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAvMTAvMjIgMDk6MTUsIEFuZHkgU2hldmNoZW5rbyB3cm90ZToNCj4gT24gU3VuLCBPY3Qg
MDksIDIwMjIgYXQgMDE6MzM6NTFQTSArMDEwMCwgSm9uYXRoYW4gQ2FtZXJvbiB3cm90ZToNCj4+
IE9uIFRodSwgNiBPY3QgMjAyMiAyMTozMjoxMSArMDMwMCBBbmR5IFNoZXZjaGVua28gDQo+PiA8
YW5kcml5LnNoZXZjaGVua29AbGludXguaW50ZWwuY29tPiB3cm90ZToNCj4+PiBPbiBUaHUsIE9j
dCAwNiwgMjAyMiBhdCAwNTozODoxNFBNICswMzAwLCBNYXR0aSBWYWl0dGluZW4gd3JvdGU6DQo+
IA0KPiAuLi4NCj4gDQo+Pj4+ICttb2R1bGVfcGFyYW0oZ19reDAyMmFfdXNlX2J1ZmZlciwgYm9v
bCwgMCk7IA0KPj4+PiArTU9EVUxFX1BBUk1fREVTQyhnX2t4MDIyYV91c2VfYnVmZmVyLCArCQkg
IkJ1ZmZlciBzYW1wbGVzLiBVc2UNCj4+Pj4gYXQgb3duIHJpc2suIEZpZm8gbXVzdCBub3Qgb3Zl
cmZsb3ciKTsNCj4+PiANCj4+PiBXaHk/ISBXZSB1c3VhbGx5IGRvIG5vdCBhbGxvdyBtb2R1bGUg
cGFyYW1ldGVycyBpbiB0aGUgbmV3IGNvZGUuDQo+PiANCj4+IEJhZGx5IGJyb2tlbiBoYXJkd2Fy
ZSAtIHdhcyBteSBzdWdnZXN0aW9uLiAgQWx0ZXJuYXRpdmVzIGlmIHRoZXJlIA0KPj4gYXJlIHVz
ZWNhc2VzIHRoYXQgbmVlZCB0byB1c2UgdGhlIGZpZm8sIGJ1dCBpdCBjYW4gd2VkZ2UgaGFyZCBp
biBhDQo+PiAgZmFzaGlvbiB0aGF0IGlzIGltcG9zc2libGUgdG8gcHJldmVudCBmcm9tIHRoZSBk
cml2ZXI/ICBNeSBndXQgDQo+PiBmZWVsaW5nIGlzIHN0aWxsIGRyb3AgdGhlIHN1cHBvcnQgZW50
aXJlbHkgd2l0aCBhIHN0cm9uZyBjb21tZW50IGluDQo+PiB0aGUgY29kZSB0aGF0IHRoZSBoYXJk
d2FyZSBpcyBicm9rZW4gaW4gYSBmYXNoaW9uIHdlIGRvbid0IGtub3cgaG93DQo+PiB0byB3b3Jr
IGFyb3VuZC4NCg0KSSBkaWQgc29tZSBxdWljayBzdHVkeSByZWdhcmRpbmcgY291cGxlIG9mIG90
aGVyIEtpb25peCBzZW5zb3JzLiAobGlrZSANCktYMTIyIGFuZCBvbGQgS1gwMjIgLSB3aXRob3V0
IHRoZSAnQScpLiBJdCBzZWVtcyB0byBtZSB0aGF0IHRoZSByZWdpc3RlciANCmludGVyZmFjZXMg
YmV0d2VlbiBtYW55IG9mIHRoZSBzZW5zb3JzIGFyZSBsYXJnZWx5IGlkZW50aWNhbC4gRXh0ZW5k
aW5nIA0KdGhlIGRyaXZlciB0byBzdXBwb3J0IHRob3NlIHNlZW1zIHByZXR0eSBzdHJhaWdodGZv
cndhcmQgKHNjYWxlcyBhbmQgDQpyZXNvbHV0aW9uIG1heSBuZWVkIHR3ZWFraW5nLCBhcyBkb2Vz
IHRoZSBGSUZPIHNpemUpIGJ1dCByZWdpc3RlciANCmNvbnRlbnRzIGFuZCBldmVuIG9mZnNldHMg
YXJlIGxhcmdlbHkgaWRlbnRpY2FsLg0KDQpBcyBzYWlkLCBpdCBzZWVtcyB0aGUgS2lvbml4IHNl
bnNvcnMgbWF5IGhhdmUgZGlmZmVyZW50IHNpemUgb2YgaW50ZXJuYWwgDQpGSUZPcywgb3IgZXZl
biBubyBGSUZPIGF0IGFsbC4gU28sIG1heWJlIHdlIGNvdWxkIHByb3ZpZGUgYSANCiJraW9uaXgs
Zmlmby1lbmFibGUiIGZsYWcgKG9yIGV2ZW4gImtpb25peCxmaWZvLXNpemUiKSBmcm9tIGRldmlj
ZS10cmVlPyANClRoaXMgd291bGQgYmUgYSB3YXkgdG8gaGF2ZSB0aGUgRklGTyBkaXNhYmxlZCBi
eSBkZWZhdWx0IGFuZCB3YXJuIHVzZXJzIA0KdmlhIGR0LWJpbmRpbmcgZG9jcyBpZiB0aGV5IGRl
Y2lkZSB0byBleHBsaWNpdGx5IGVuYWJsZSB0aGUgRklGTy4gDQooQmVzaWRlcywgSSBiZWxpZXZl
IHRoZSBGSUZPIGlzIHVzYWJsZSBvbiBhdCBsZWFzdCBzb21lIG9mIHRoZSBLaW9uaXggDQpzZW5z
b3JzIC0gYmVjYXVzZSBJJ3ZlIGhlYXJkIGl0IGlzIHVzZWQgb24gYSBmZXcgcGxhdGZvcm1zKS4N
Cg0KVGhpcyBjb3VsZCBnaXZlIHVzIHNhZmUgZGVmYXVsdHMgd2hpbGUgbm90IHNodXR0aW5nIHRo
ZSBkb29ycyBmcm9tIHRob3NlIA0Kd2hvIHdpc2ggdG8gdXNlIHRoZSBGSUZPLiBTdXJlIHdlIG5l
ZWQgYSBidXktaW4gZnJvbSBLcnp5c3p0b2YgLyBSb2IsIA0KYnV0IHRoYXQgbWF5IGJlIGxlc3Mg
b2YgYW4gb2JzdGFjbGUgY29tcGFyZWQgdG8gdGhlIG1vZHVsZSBwYXJhbSBpZiBHcmVnIA0KaXMg
c28gc3Ryb25nbHkgb3Bwc29pbmcgdGhvc2UuIChBbmQgdGhlIGR0LXByb3BlcnR5IGNvdWxkIGFs
c28gcHJvdmlkZSANCnNvbWUgdGVjaG5pY2FsIG1lcml0ZXMgYXMgdGhlc2Ugc2Vuc29ycyBzZWVt
IHRvIHJlYWxseSBoYXZlIGRpZmZlcmVuY2llcyANCmluIEZJRk9zKS4NCg0KPiANCj4gSSBhbHNv
IHdvdWxkIGRyb3AgdGhpcyBmcm9tIHVwc3RyZWFtIGFuZCBpZiBhbnlib2R5IGN1cmlvdXMsIHBy
b3ZpZGUNCj4gIHNvbWUga2luZCBvZiBHaXRIdWIgZ2lzdCBmb3IgdGhhdC4NCg0KV2VsbCwgSSB0
aGluayB3ZSBhbGwgYWdyZWUgdGhhdCBkb3duc3RyZWFtIGNvZGUgaG9zdGVkIGluIHNvbWUgDQp1
bm9mZmljaWFsIGdpdGh1YiByZXBvc2l0b3JpZXMgYXJlIHJhcmVseSB0aGF0IHZhbHVhYmxlLiBU
aGV5J3JlIGxlc3MgDQpyZWxpYWJsZSwgbGVzcyB0ZXN0ZWQsIGxlc3MgcmV2aWV3ZWQsIGxlc3Mg
c2VjdXJlIGFuZCBwcmV0dHkgbXVjaCANCmltcG9zc2libGUgdG8gbWFpbnRhaW4gaW4gYSB3YXkg
dGhhdCBpbnRlcmVzdGVkIHVzZXIgY291bGQgZ2V0IGEgdmVyc2lvbiANCm1hdGNoaW5nIGhpcyBw
cmVmZXJyZWQga2VybmVsLg0KDQpUaGVyZSBhcmUgcmVhc29ucyB3aHkgSSAocGVvcGxlKSBrZWVw
IHNlbmRpbmcgdGhlIGRyaXZlcnMgdG8gdXBzdHJlYW0gLSANCmFuZCB3aHkgc29tZSBjb21wYW5p
ZXMgZXZlbiBzcGVuZCAkJCBmb3IgdGhhdC4gSGF2aW5nIHRoaXMgZmVhdHVyZSBpbiANCmRvd25z
dHJlYW0gcmVwbyBpcyBub3QgbmVhcmx5IG9uIHNhbWUgcGFnZSBmb3IgdXNlcidzIHBvaW50IG9m
IHZpZXcgYXMgDQppcyBoYXZpbmcgdGhlIHN1cHBvcnQgdXBzdHJlYW0uDQoNCj4gQWxzbyBpdCBu
ZWVkcyBzb21lIGNvbW11bmljYXRpb24NCj4gIHdpdGggYSB2ZW5kb3IgdG8gY2xhcmlmeSB0aGUg
dGhpbmdzLg0KDQpJIGRvIGNvbW11bmljYXRpb24gd2l0aCB0aGUgdmVuZG9yIG9uIGEgZGFpbHkg
YmFzaXMgOl0gTm93YWRheXMgS2lvbml4IA0KaXMgcGFydCBvZiBST0hNLCBhbmQgRmlubGFuZCBT
V0RDIGhhcyBiZWVuIGNvbGxhYm9yYXRpb24gd2l0aCBLaW9uaXggDQpldmVuIGJlZm9yZSB0aGV5
ICJtZXJnZWQiIChidXQgSSBoYXZlIG5vdCBiZWVuIHBhcnQgb2YgdGhlICJzZW5zb3IgdGVhbSIg
DQpiYWNrIHRoZW4pLg0KDQpVbmZvcnR1bmF0ZWx5LCByZWFjaGluZyB0aGUgY29ycmVjdCBwZW9w
bGUgaW5zaWRlIHRoZSBjb21wYW55IGlzIGhhcmQgDQphbmQgb2NjYXNpb25hbGx5IGltcG9zc2li
bGUgLSBsb25nIHN0b3J5Li4uDQoNCg0KLS0gDQpNYXR0aSBWYWl0dGluZW4NCkxpbnV4IGtlcm5l
bCBkZXZlbG9wZXIgYXQgUk9ITSBTZW1pY29uZHVjdG9ycw0KT3VsdSBGaW5sYW5kDQoNCn5+IFdo
ZW4gdGhpbmdzIGdvIHV0dGVybHkgd3JvbmcgdmltIHVzZXJzIGNhbiBhbHdheXMgdHlwZSA6aGVs
cCEgfn4NCg0K
