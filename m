Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4418264E5C6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 02:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiLPBri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 20:47:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiLPBrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 20:47:35 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2049.outbound.protection.outlook.com [40.107.114.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22C26A744
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 17:47:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IP0NzlcH8mq44iphZE6fhb8ipExmnw4ughGvB5ely3si+456twEFxPT5Qvj4ZnHrKWp4e4T5g06phI8w7S9ZkcGZvC4i1bQ4qyPDjZazhsXorGr8sb1VKCKJSKqnMDoCQQSooFdJLs2kE+LmwaGrFygnaJdayXiJ2mf/EahDIW4IbuaDVSS2iROGZCbX8zUqIhgge1DxL9oLCvoIoPvOAY/AGXdpXBo3csCZf+w1kCsTR5UrIIHAdJ9xMFWBSqdcanuY9ppnwN8P8N4HsZcbP8vTtSTDYegw3ig1PbAElRPRvWCtIpbeJJUbFMlxdMj9DxDtrDu1O64uz0r9cuFGMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U3SlLU8P401H22ot4+66oOKE4TEcPOWuCV0Ebr/mSDQ=;
 b=kpjCyPZScYPuCv5pdQFN1luqPxb79hfOqkn7BLm2diZha3Yf22MPjtuzAc9nqmtgBDwMQ+wYGQNA1B9cNZU1lgl5kJr0mdAIpr7wiFAA47wJD0t8YhgsKXi1Atwdf47XKbOG8Etupdw+m9mkIpREPNNbvbRpS1r6UAhBTF2XIWGJjgEKECOYzWPJmLdGcpa9b44yV2XM55yGetMIcJypwVw5faRRS0IABDru+JfB5nFIaIODeHHMKF/UfV6WeqgYUQagmZohB+Oxs66zo86B9FWNffzQMisXjBYKxpsU5eVys8hHtKDMGhItf66IMoElPfqFUY/x8oe0m03ZcBLhIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U3SlLU8P401H22ot4+66oOKE4TEcPOWuCV0Ebr/mSDQ=;
 b=Scsec0gXfF5NrEa3nSQbrXS2agMEA0vGha9m1qa+hWt9sK1sw9UZp7ZZLLPIlKPXMX19Qc6GYIUqLFuEkexaqQieS+zn8yAPmqE/gxp7hOOkYEO5hJ4ZmeYSWvcd6vu/2ho9Bksuy5AbvLl9icUj9xvzFMiNdZ+JwVH/aDILPaM=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by OSZPR01MB8514.jpnprd01.prod.outlook.com (2603:1096:604:18b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11; Fri, 16 Dec
 2022 01:47:31 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::8c61:6836:588:47aa]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::8c61:6836:588:47aa%4]) with mapi id 15.20.5924.011; Fri, 16 Dec 2022
 01:47:31 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH -next resend v3] mm: hwposion: support recovery from
 ksm_might_need_to_copy()
Thread-Topic: [PATCH -next resend v3] mm: hwposion: support recovery from
 ksm_might_need_to_copy()
Thread-Index: AQHZDujhHuQ/+e0VRkiyjfboC7PUFK5vwuSA
Date:   Fri, 16 Dec 2022 01:47:31 +0000
Message-ID: <20221216014729.GA2116060@hori.linux.bs1.fc.nec.co.jp>
References: <20221213030557.143432-1-wangkefeng.wang@huawei.com>
 <20221213120523.141588-1-wangkefeng.wang@huawei.com>
In-Reply-To: <20221213120523.141588-1-wangkefeng.wang@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8591:EE_|OSZPR01MB8514:EE_
x-ms-office365-filtering-correlation-id: df40b05c-b24c-4824-921c-08dadf077ed5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hmusdwh/JpV3AXr6Tj85JOTe1KDRb06slTbzzFR5O4vleHBZfWGwXl3V6bxoSJ2JiFnoToJTf3c7WCs1MM2HNlKu56vQDc4T3ccTEKAJADdxZ+Ipf+1U1Riz4i5nXGnO/kqdI0NA3ieHvc4qqrocRmWTJFQnGhrTkRCtrHUzROaFHdeGPnjSNSH0PCbVjpravPWl9jEAaWNB6vdEw68WgyeqqKC/RcRg+Kz98CDhTHcVVVAXC1EuCx+liyGf5SnRFBuQ8AxRNIq/asFYsva1QUlaqjag/7gG5TFATmHL1jJMS4qxEIgtzhKG7gYQhsBTWbOXu+otHCCyUqtBeKXcMDVCU8m3D7OaFqUaawrGkJDaGAR9EXyfumeFTK3g1w1+p8DscSwUvQjlRFso994FxLVJojs8kMStvPQlLCJ5T3X6xheD7xTaSEsNfsxqA3o7mpdeXIDUxn/RXnS1Iv1pNtn2yqnD8MrHx4MB676cfdNRm3S4mOr6plJGAHxzl/AXW84ioa3thKJIomC0IoJqrKkCelcPUYoX4soe3fGa8PrrgoTByBe60Pq6dZcS/HEZq3LxNd04Iot+F6RL3aneOHt1LzGwRcucdSfEJkYOgXfyWGae8dY5iGHySGI6Y1jyuyycfZTI9fxE6pnYXF8pjVSE+4iWFjfSlC143iTHOQN9hZN5Eu5cErqWxPVhRhm8uSNrrEM+cumCzXdtzSOlYA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(376002)(136003)(366004)(396003)(451199015)(86362001)(83380400001)(38100700002)(66946007)(66476007)(5660300002)(2906002)(38070700005)(66556008)(4326008)(76116006)(8676002)(64756008)(66446008)(122000001)(82960400001)(41300700001)(186003)(9686003)(6512007)(6506007)(55236004)(1076003)(6916009)(316002)(54906003)(478600001)(6486002)(71200400001)(8936002)(26005)(85182001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V05zMmpqU005WW91a0NlVkl5Q1QveTgxUTZpdWpLUGJQWTE1YjlETGRaN1NF?=
 =?utf-8?B?YjRNSk45VWxZTDdOTms3NkFXQ01DSURwUURkZXkrY0JXZ3lIN21nell0NVJo?=
 =?utf-8?B?bVBmYW5TcTlFUUI5QXpUVmEwWUQzZWNtY1ZPclVCUkwyUnNheWdRNnpBSi9s?=
 =?utf-8?B?Sm5pdzAyeGgwMlVPMG5uMEtITWJJYkI5TGxNKytidnRTUjZtT1MwcFVEZUFN?=
 =?utf-8?B?dk5nT1RUT1BqR1FRYnhVL1RlalUvdWovdWI3UlJ4NTRJRkRYS081Z1kyempj?=
 =?utf-8?B?am4yMTRVblMrNVBKbUdzYWdrODVOWHEyUTZ3YWVFZDZjL1B5U2lQRTQwWEtV?=
 =?utf-8?B?QXVZZVBKR0dIK04yR1ZkNkxrcGlFdFdRY0VqZklsL0NyNU5XekFyd1Y2ZUR5?=
 =?utf-8?B?am9vTitmVXpwbmlRTHZkMkJWSEo5VTBlZVN1U2xxYmI3NFJ1T0dhQzF3ZDI5?=
 =?utf-8?B?SkJNRWJwTWVmSm9xMlgzcDQrUndTWFlQMWxFUEprRUVNdkdTSkJCck1sOCt5?=
 =?utf-8?B?MmZUT1V2YjkxaVo2T0pvN0w3Z3pNMTdncmhkL3BjZXdyb0lXTDYyNU56czBD?=
 =?utf-8?B?NURlVlB5cE44RFYrSW14aExINndnVVBreFROenAzaWcveUdhaENvMU5yVVhW?=
 =?utf-8?B?LzdNTWI5SmdFbkhLblFCcG5zY3FkTlBhUnhmMlB2cGk1d1dxQUxSSEJpd0N2?=
 =?utf-8?B?RjdOU2d0Z2VWNU5IS2ZiL25Kb2RGUXRGSmQ4QldZUGtSTzVNK3lQeGxFYWRm?=
 =?utf-8?B?cHZRb1E2N1VUNzZnSHRjUFBjdDRucjkvWjZSSVU5Vmxla3BSbnRGbFJmOHd4?=
 =?utf-8?B?bmFoTU5LRnRGYUx4Zyt2VVJZWWNqb1E4SnJDWmhDd2s5MFk2eWlMZlNFOTJN?=
 =?utf-8?B?NmY3NkJzOGJhUFZkZTZnR2pScERxeFpzRmVtSzJqVjNHRnNVM2R1M0hxdjFW?=
 =?utf-8?B?N3lxMFM0Sm5raHJ2TEdXaVlCV2JGOG55SU1HSkUxWTNIUGdTd1BPczRNREYw?=
 =?utf-8?B?bGJqaTNCc0ZBeFY2WjNKSjM5T2F2R014R0ZmNmkzRU1MNGRJd3V3eUNTREhG?=
 =?utf-8?B?Ymg5OXFocDF5TzJNZU4veXlXSjR0WmZicnRHMWdxZEV3dElEek9zam5vcFh5?=
 =?utf-8?B?UGR6cjZSazYrU1hGMnRnZ0h2SUN0YlZzVGhoeFg4RlJUVmFTUk1CcXVhazBI?=
 =?utf-8?B?eGxHS2pUQlBGcjArb0xwc2labzBDZ3hKcVd3ODA3QW5xUjFlSjdkU1dvUFB1?=
 =?utf-8?B?a2h1NUxyRGkrWG1ZTGhpeUxaWmVlbEtYYVNBYnBhQ09WMHkwR3dLVTRReld3?=
 =?utf-8?B?aTRKdElzUzBKWlFpMTI1c05qeHBHOUk1eUdRd25LbE1WQnVzWmNmVXo2eE4z?=
 =?utf-8?B?UHpUN1VMTlh2WUI2ZXZsVEFwR1RtNm1qNDdDZ3VhVE5FTnJPczk4RVFnU1Jz?=
 =?utf-8?B?ZlJGUk5mU1JVNjVZQlFYWituT0doTVFWY3hta05wSXE5NXVOSktMRGFFM3Bn?=
 =?utf-8?B?a1FQODNzZXFKMmkwOGdvT1E4MDIwd0FLdkdkUnNmSnpNWUF2d3VhR015OUpq?=
 =?utf-8?B?TXNKSHV1a2pLSnEvRVRIN3Z2bkVRZ282OWliWWo3eFF6c1JERGREVVVlWjd5?=
 =?utf-8?B?Qmd1bzFDbTNZalVSWVB5WUhBN1lUTnZOUEZUZzlvbFVOQnVqOWZWaWlMSTQ1?=
 =?utf-8?B?eVc2VDFpenp3dGN2TUc1RWxXSkN1aExTdVVxRXFCbnlzOU5TMW9nU05vSUgr?=
 =?utf-8?B?cE5WbXc1cDFDOU1iWDBVZjk3dzdxcjJsV2ZTQnFGSGtXNVlrcTNoeVNqZUF4?=
 =?utf-8?B?b01xdGxhR2xSNUNaNzBMTmpNOSsvL2o5Z2tkUWFNazlOU0RRQm9vdjJGdFVJ?=
 =?utf-8?B?R2l2KzJNNTFsYnpCOWRQZjl4SjhQaXZScFZjVm1xaXQ1TWs5bGg2TnJtQ252?=
 =?utf-8?B?WkswNGF5d3RaQmh3bmVnVXBDZHo5VlQyQVdDMW5EYmVsU0FKTHVjSXEvZ0Q5?=
 =?utf-8?B?QzJLOER1NUpBdk1Cbi9iT2h0NkFvd3pTRTVRRHFEZjNDWnNTR0FlaGZwcndz?=
 =?utf-8?B?Sk9VRXhEd2R0NG1HS3YyNzdOekhLMmRlelE0VlBtZjNVMFl1VkduRG5RVitP?=
 =?utf-8?B?SmE2cDJ1T0VrK29jYUd6RndCN2VDcEVkWGUrWnhhNEJHa2ZDSUhzcVJacnY4?=
 =?utf-8?B?cVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <58E787D72C8E24499180FF758A5A41FD@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df40b05c-b24c-4824-921c-08dadf077ed5
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2022 01:47:31.1568
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: STo9qP386lN+0VD0cizl7sZ4Y2fRsxm7aiD0tkwD2xNGJznN68sre3r9pt+7f2UPT47Wcpc6dzLbJiHiRJNeTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8514
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBEZWMgMTMsIDIwMjIgYXQgMDg6MDU6MjNQTSArMDgwMCwgS2VmZW5nIFdhbmcgd3Jv
dGU6DQo+IFdoZW4gdGhlIGtlcm5lbCBjb3B5IGEgcGFnZSBmcm9tIGtzbV9taWdodF9uZWVkX3Rv
X2NvcHkoKSwgYnV0IHJ1bnMNCj4gaW50byBhbiB1bmNvcnJlY3RhYmxlIGVycm9yLCBpdCB3aWxs
IGNyYXNoIHNpbmNlIHBvaXNvbmVkIHBhZ2UgaXMNCj4gY29uc3VtZWQgYnkga2VybmVsLCB0aGlz
IGlzIHNpbWlsYXIgdG8gQ29weS1vbi13cml0ZSBwb2lzb24gcmVjb3ZlcnksDQoNCk1heWJlIHlv
dSBtZWFuICJ0aGlzIGlzIHNpbWlsYXIgdG8gdGhlIGlzc3VlIHJlY2VudGx5IGZpeGVkIGJ5DQpD
b3B5LW9uLXdyaXRlIHBvaXNvbiByZWNvdmVyeS4iPyAgQW5kIGlmIHRoaXMgc2VudGVuY2UgZW5k
cyBoZXJlLA0KcGxlYXNlIHB1dCAiLiIgaW5zdGVhZCBvZiAiLCIuDQoNCj4gV2hlbiBhbiBlcnJv
ciBpcyBkZXRlY3RlZCBkdXJpbmcgdGhlIHBhZ2UgY29weSwgcmV0dXJuIFZNX0ZBVUxUX0hXUE9J
U09ODQo+IGluIGRvX3N3YXBfcGFnZSgpLCBhbmQgaW5zdGFsbCBhIGh3cG9pc29uIGVudHJ5IGlu
IHVudXNlX3B0ZSgpIHdoZW4NCj4gc3dhcG9mZiwgd2hpY2ggaGVscCB1cyB0byBhdm9pZCBzeXN0
ZW0gY3Jhc2guICBOb3RlLCBtZW1vcnkgZmFpbHVyZSBvbg0KPiBhIEtTTSBwYWdlIHdpbGwgYmUg
c2tpcHBlZCwgYnV0IHN0aWxsIGNhbGwgbWVtb3J5X2ZhaWx1cmVfcXVldWUoKSB0bw0KPiBiZSBj
b25zaXN0ZW50IHdpdGggZ2VuZXJhbCBtZW1vcnkgZmFpbHVyZSBwcm9jZXNzLg0KDQpUaGFuayB5
b3UgZm9yIHRoZSB3b3JrLiAgSSBoYXZlIGEgZmV3IGNvbW1lbnQgYmVsb3cgLi4uDQoNCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IEtlZmVuZyBXYW5nIDx3YW5na2VmZW5nLndhbmdAaHVhd2VpLmNvbT4N
Cj4gLS0tDQo+IHYzIHJlc2VuZDogDQo+IC0gZW5oYW5jZSB1bnVzZV9wdGUoKSBpZiBrc21fbWln
aHRfbmVlZF90b19jb3B5KCkgcmV0dXJuIC1FSFdQT0lTT04NCj4gLSBmaXggaXNzdWUgZm91bmQg
YnkgbGtwIA0KPiANCj4gIG1tL2tzbS5jICAgICAgfCAgOCArKysrKystLQ0KPiAgbW0vbWVtb3J5
LmMgICB8ICAzICsrKw0KPiAgbW0vc3dhcGZpbGUuYyB8IDIwICsrKysrKysrKysrKysrLS0tLS0t
DQo+ICAzIGZpbGVzIGNoYW5nZWQsIDIzIGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvbW0va3NtLmMgYi9tbS9rc20uYw0KPiBpbmRleCBkZDAyNzgwYzM4
N2YuLjgzZTJmNzRhZTdkYSAxMDA2NDQNCj4gLS0tIGEvbW0va3NtLmMNCj4gKysrIGIvbW0va3Nt
LmMNCj4gQEAgLTI2MjksOCArMjYyOSwxMiBAQCBzdHJ1Y3QgcGFnZSAqa3NtX21pZ2h0X25lZWRf
dG9fY29weShzdHJ1Y3QgcGFnZSAqcGFnZSwNCj4gIAkJbmV3X3BhZ2UgPSBOVUxMOw0KPiAgCX0N
Cj4gIAlpZiAobmV3X3BhZ2UpIHsNCj4gLQkJY29weV91c2VyX2hpZ2hwYWdlKG5ld19wYWdlLCBw
YWdlLCBhZGRyZXNzLCB2bWEpOw0KPiAtDQo+ICsJCWlmIChjb3B5X21jX3VzZXJfaGlnaHBhZ2Uo
bmV3X3BhZ2UsIHBhZ2UsIGFkZHJlc3MsIHZtYSkpIHsNCj4gKwkJCXB1dF9wYWdlKG5ld19wYWdl
KTsNCj4gKwkJCW5ld19wYWdlID0gRVJSX1BUUigtRUhXUE9JU09OKTsNCj4gKwkJCW1lbW9yeV9m
YWlsdXJlX3F1ZXVlKHBhZ2VfdG9fcGZuKHBhZ2UpLCAwKTsNCj4gKwkJCXJldHVybiBuZXdfcGFn
ZTsNCg0KU2ltcGx5IHJldHVybiBFUlJfUFRSKC1FSFdQT0lTT04pPw0KDQo+ICsJCX0NCj4gIAkJ
U2V0UGFnZURpcnR5KG5ld19wYWdlKTsNCj4gIAkJX19TZXRQYWdlVXB0b2RhdGUobmV3X3BhZ2Up
Ow0KPiAgCQlfX1NldFBhZ2VMb2NrZWQobmV3X3BhZ2UpOw0KPiBkaWZmIC0tZ2l0IGEvbW0vbWVt
b3J5LmMgYi9tbS9tZW1vcnkuYw0KPiBpbmRleCBhYWQyMjZkYWY0MWIuLjViMmMxMzdkZmIyYSAx
MDA2NDQNCj4gLS0tIGEvbW0vbWVtb3J5LmMNCj4gKysrIGIvbW0vbWVtb3J5LmMNCj4gQEAgLTM4
NDAsNiArMzg0MCw5IEBAIHZtX2ZhdWx0X3QgZG9fc3dhcF9wYWdlKHN0cnVjdCB2bV9mYXVsdCAq
dm1mKQ0KPiAgCQlpZiAodW5saWtlbHkoIXBhZ2UpKSB7DQo+ICAJCQlyZXQgPSBWTV9GQVVMVF9P
T007DQo+ICAJCQlnb3RvIG91dF9wYWdlOw0KPiArCQl9IGVsc2UgaWYgKHVubGlrZWx5KFBUUl9F
UlIocGFnZSkgPT0gLUVIV1BPSVNPTikpIHsNCj4gKwkJCXJldCA9IFZNX0ZBVUxUX0hXUE9JU09O
Ow0KPiArCQkJZ290byBvdXRfcGFnZTsNCj4gIAkJfQ0KPiAgCQlmb2xpbyA9IHBhZ2VfZm9saW8o
cGFnZSk7DQo+ICANCj4gZGlmZiAtLWdpdCBhL21tL3N3YXBmaWxlLmMgYi9tbS9zd2FwZmlsZS5j
DQo+IGluZGV4IDkwOGE1MjliY2ExMi4uMGVmYjFjMmMyNDE1IDEwMDY0NA0KPiAtLS0gYS9tbS9z
d2FwZmlsZS5jDQo+ICsrKyBiL21tL3N3YXBmaWxlLmMNCj4gQEAgLTE3NjMsMTIgKzE3NjMsMTUg
QEAgc3RhdGljIGludCB1bnVzZV9wdGUoc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWEsIHBtZF90
ICpwbWQsDQo+ICAJc3RydWN0IHBhZ2UgKnN3YXBjYWNoZTsNCj4gIAlzcGlubG9ja190ICpwdGw7
DQo+ICAJcHRlX3QgKnB0ZSwgbmV3X3B0ZTsNCj4gKwlib29sIGh3cG9zaW9uZWQgPSBmYWxzZTsN
Cj4gIAlpbnQgcmV0ID0gMTsNCj4gIA0KPiAgCXN3YXBjYWNoZSA9IHBhZ2U7DQo+ICAJcGFnZSA9
IGtzbV9taWdodF9uZWVkX3RvX2NvcHkocGFnZSwgdm1hLCBhZGRyKTsNCj4gIAlpZiAodW5saWtl
bHkoIXBhZ2UpKQ0KPiAgCQlyZXR1cm4gLUVOT01FTTsNCj4gKwllbHNlIGlmICh1bmxpa2VseShQ
VFJfRVJSKHBhZ2UpID09IC1FSFdQT0lTT04pKQ0KPiArCQlod3Bvc2lvbmVkID0gdHJ1ZTsNCj4g
IA0KPiAgCXB0ZSA9IHB0ZV9vZmZzZXRfbWFwX2xvY2sodm1hLT52bV9tbSwgcG1kLCBhZGRyLCAm
cHRsKTsNCj4gIAlpZiAodW5saWtlbHkoIXB0ZV9zYW1lX2FzX3N3cCgqcHRlLCBzd3BfZW50cnlf
dG9fcHRlKGVudHJ5KSkpKSB7DQo+IEBAIC0xNzc2LDE1ICsxNzc5LDE5IEBAIHN0YXRpYyBpbnQg
dW51c2VfcHRlKHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hLCBwbWRfdCAqcG1kLA0KPiAgCQln
b3RvIG91dDsNCj4gIAl9DQo+ICANCj4gLQlpZiAodW5saWtlbHkoIVBhZ2VVcHRvZGF0ZShwYWdl
KSkpIHsNCj4gLQkJcHRlX3QgcHRldmFsOw0KPiArCWlmIChod3Bvc2lvbmVkIHx8ICFQYWdlVXB0
b2RhdGUocGFnZSkpIHsNCj4gKwkJc3dwX2VudHJ5X3Qgc3dwX2VudHJ5Ow0KPiAgDQo+ICAJCWRl
Y19tbV9jb3VudGVyKHZtYS0+dm1fbW0sIE1NX1NXQVBFTlRTKTsNCj4gLQkJcHRldmFsID0gc3dw
X2VudHJ5X3RvX3B0ZShtYWtlX3N3YXBpbl9lcnJvcl9lbnRyeSgpKTsNCj4gLQkJc2V0X3B0ZV9h
dCh2bWEtPnZtX21tLCBhZGRyLCBwdGUsIHB0ZXZhbCk7DQo+IC0JCXN3YXBfZnJlZShlbnRyeSk7
DQo+ICsJCWlmIChod3Bvc2lvbmVkKSB7DQo+ICsJCQlzd3BfZW50cnkgPSBtYWtlX2h3cG9pc29u
X2VudHJ5KHN3YXBjYWNoZSk7DQo+ICsJCQlwYWdlID0gc3dhcGNhY2hlOw0KDQpUaGlzIG1pZ2h0
IHdvcmsgZm9yIHRoZSBwcm9jZXNzIGFjY2Vzc2luZyB0byB0aGUgYnJva2VuIHBhZ2UsIGJ1dCBr
c20NCnBhZ2VzIGFyZSBsaWtlbHkgdG8gYmUgc2hhcmVkIGJ5IG11bHRpcGxlIHByb2Nlc3Nlcywg
c28gaXQgd291bGQgYmUNCm11Y2ggbmljZXIgaWYgeW91IGNhbiBjb252ZXJ0IGFsbCBtYXBwaW5n
IGVudHJpZXMgZm9yIHRoZSBlcnJvciBrc20gcGFnZQ0KaW50byBod3BvaXNvbmVkIG9uZXMuICBN
YXliZSBpbiB0aGlzIHRob3JvdWdoIGFwcHJvYWNoLA0KaHdwb2lzb25fdXNlcl9tYXBwaW5ncygp
IGlzIHVwZGF0ZWQgdG8gY2FsbCB0cnlfdG9fdW5tYXAoKSBmb3Iga3NtIHBhZ2VzLg0KQnV0IGl0
J3Mgbm90IG5lY2Vzc2FyeSB0byBkbyB0aGlzIHRvZ2V0aGVyIHdpdGggYXBwbHlpbmcgbWNzYWZl
LW1lbWNweSwNCmJlY2F1c2UgcmVjb3ZlcnkgYWN0aW9uIGFuZCBtY3NhZmUtbWVtY3B5IGNhbiBi
ZSBkb25lIGluZGVwZW5kZW50bHkuDQoNClRoYW5rcywNCk5hb3lhIEhvcmlndWNoaQ0KDQo+ICsJ
CX0gZWxzZSB7DQo+ICsJCQlzd3BfZW50cnkgPSBtYWtlX3N3YXBpbl9lcnJvcl9lbnRyeSgpOw0K
PiArCQl9DQo+ICsJCW5ld19wdGUgPSBzd3BfZW50cnlfdG9fcHRlKHN3cF9lbnRyeSk7DQo+ICAJ
CXJldCA9IDA7DQo+IC0JCWdvdG8gb3V0Ow0KPiArCQlnb3RvIHNldHB0ZTsNCj4gIAl9DQo+ICAN
Cj4gIAkvKiBTZWUgZG9fc3dhcF9wYWdlKCkgKi8NCj4gQEAgLTE4MTYsNiArMTgyMyw3IEBAIHN0
YXRpYyBpbnQgdW51c2VfcHRlKHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hLCBwbWRfdCAqcG1k
LA0KPiAgCQluZXdfcHRlID0gcHRlX21rc29mdF9kaXJ0eShuZXdfcHRlKTsNCj4gIAlpZiAocHRl
X3N3cF91ZmZkX3dwKCpwdGUpKQ0KPiAgCQluZXdfcHRlID0gcHRlX21rdWZmZF93cChuZXdfcHRl
KTsNCj4gK3NldHB0ZToNCj4gIAlzZXRfcHRlX2F0KHZtYS0+dm1fbW0sIGFkZHIsIHB0ZSwgbmV3
X3B0ZSk7DQo+ICAJc3dhcF9mcmVlKGVudHJ5KTsNCj4gIG91dDoNCj4gLS0gDQo+IDIuMzUuMw0K
DQogICAg
