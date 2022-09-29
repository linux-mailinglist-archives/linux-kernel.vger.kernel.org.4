Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 156985F011F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 00:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiI2W7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 18:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbiI2W7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 18:59:19 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-westcentralusazon11010011.outbound.protection.outlook.com [40.93.198.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2BFCE6ED
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 15:58:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C/pRvLL9PC/356EKt1EVoTEM+98Ct/SJ9w5rQE9uMeOl+KPsbixkCjK/WAogkj/dW3Y5Kg4p48x1cCHwFL/WPkhUvZcJRZHF/I4110fRjvefZ/vADf9zb/hNtdnrzTy71BAriiaDT//S8y0ZLws2bPIzO6NNg/6fzJJkYEvhwd0EM6nexkLBiUlAyxkataJy+qJrAOqwT/xsu77TRaLNHraYsVC9m4D5ZtTYKEMPOFhk8G4GCqHIADGQRCZt8duNJxRu+mf/Py+c7kVneT1g7MnwTHNvr7+4yZXHsbvkK1gdlDj2r8OGs5xxzWEN+6tCCc5qQzyvu1u5oeBXbdL8FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=53qxUJran7eY6NWrFYWniv9tqBQl4Q7sEMo4ER8VPOY=;
 b=BCLGoAKN6g2EER7qBQj8Bgk2K1obnyVrfPStXz8jem8kHcONSud3rLIC9wQTip79i73HoEJB5uO0gvo8hGk5dHAVaJKQAtQ7mSw73cfJFrsIZQeZEXDKDendhO6AVLVUeY72avd46w+yYuq4BqqjP1QtKbSSBlzATqptcDj0iIVMvh8ZjEgSn2MH1HD0ZgNF2OnVRBUPJ0ILZY5O7SoYc37iZ9OTBBQUi1ztn/SB1PJMjDbDv4tVh6+BfgStM8mAFktQmeFn4RnRx/LilWiRrFpF5HblUV81nkCmjsMshK7Rwc7ZG/oL4E4022r1YAwE6U2YlcRK7Z3m+XsIPCiLew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=53qxUJran7eY6NWrFYWniv9tqBQl4Q7sEMo4ER8VPOY=;
 b=jOMQE0Gg+LYLCxKAeUagVI2cF8Ht8SGPiNnoUrT6/eSFXtqLe6sowtw9oHas0HjYY9d42SxVHVz1utmm5OhxqJEjLczHvoVKpioLdTaLTe4LUVq8E3aQ6BiNP/Fi2b+hurW5NNalupctk7rGairy0CKDYz5q3OYJuTVKJ7H/3Cw=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by DM6PR05MB5833.namprd05.prod.outlook.com (2603:10b6:5:108::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.11; Thu, 29 Sep
 2022 22:58:46 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::942c:7d1b:6b3d:85b6]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::942c:7d1b:6b3d:85b6%5]) with mapi id 15.20.5676.020; Thu, 29 Sep 2022
 22:58:45 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Randy Dunlap <rdunlap@infradead.org>
CC:     Xin Hao <xhao@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] x86/mm/tlb: fix error word 'clleared' to 'cleared'
Thread-Topic: [PATCH v2] x86/mm/tlb: fix error word 'clleared' to 'cleared'
Thread-Index: AQHY0+Nfynu1c+gMXkWe4/HZBn3Gwq3271AAgAAW94A=
Date:   Thu, 29 Sep 2022 22:58:45 +0000
Message-ID: <FD6D2974-13DD-4FE6-B175-E0BBF5306BD8@vmware.com>
References: <20220929091040.45390-1-xhao@linux.alibaba.com>
 <651530a9-2dc1-c781-a1b5-1e712684f94d@infradead.org>
In-Reply-To: <651530a9-2dc1-c781-a1b5-1e712684f94d@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR05MB8531:EE_|DM6PR05MB5833:EE_
x-ms-office365-filtering-correlation-id: 458f6247-042b-4dcb-4d02-08daa26e29d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bMyg9Z/yRSnpS3vWI/KFdVIojW7C0iZIAMofXMujEHmvS7RpIXGsL+vLBH2iEQD4I0RRQQlTyg1y5OPPir1xqLNtn2ZNsIEFkZT4eX76lOgTxjbqkZY3B3sQd0bYCaUes+ab3v2Dw6pFe1i4aWrOeeDkwnkrlWEykALVfhbIp4mU+PKQpo/hvv4yCaAJuA5b1awqSGtum9mFtLMchB0YOD09CnwdKovhRgRYDQgt+xBYeY5QBrethREZ7uV9MTL4U9M3MVKSN5Q7DyjYzgglTtQFlnO3qfb947fHt+wWXjIGMYGi18QZ3ciJYWP9yGr4MK/bQMkZmqEzBvI4qElOVOeu4H7+7yS+8B0zG/mnFK0T5tDym8qnZDPptyC15eSWMeiIO0dIg4REtgRthY4g95xrGDCk92XLW3G6jZsxQWav3qyHH4zWNHgzl7j0HFrlRoUIcfUbd5yWM72Psqs3HijYqXVBj9EljJPaVeiKRw7iIgjGnyBKsgxY1YhRsXFzjr+0Z87xd3ubJ7WAs98D92zGkMkWiUpVKU0TENE9KogcFsVyFYlyK4UsV2NbVAKgAQ8LoK7g78kDGr1DY1JiJfkyJbnlrc5Dznf4si9zTOh9MN4fdIpNPEoqcyyyfhSFIjnpnAeBV0e6mDnEF7OfziJm9dzZrvy7RXqyVNlVXgXwmBztSA55bdUOn4xfJgDgBI/q2tXVHzTVYruDorh3yLRyIAiXulZ5OD1QAaFwvjUE0Izwsmaqq4FHknfZ75Z4twthKngFB4px4nrDbko0+D5LKbeg8RUcPN4y6ycsTCc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(376002)(396003)(136003)(346002)(451199015)(86362001)(6916009)(2616005)(478600001)(83380400001)(38100700002)(38070700005)(122000001)(6506007)(76116006)(64756008)(66556008)(5660300002)(2906002)(66476007)(4326008)(8936002)(54906003)(53546011)(7416002)(41300700001)(186003)(8676002)(66946007)(6512007)(66446008)(71200400001)(316002)(33656002)(26005)(36756003)(6486002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?LzVKOWRWYkltVlZSUm4yWDBTUEtpcDFMQkJMb2V2aXU2NWxQVnp3Z0lMTmdN?=
 =?utf-8?B?OHFHeFUrcFdjU08wemlpWGNnVEU0UTlOQWpZNjNhZWtod1RJSG9ZK3JtQlhl?=
 =?utf-8?B?L2RaWG53V0QyRE51amEzalRJRU5LZ2tTaHltZjJRK1VoTlA0VFA3MW1zbHQy?=
 =?utf-8?B?T1NXclcvWWdCWkVvcXZIU1ppbzh3UEFyTkJEY2hlbU8wR1o4LytISnZ0NnN3?=
 =?utf-8?B?clFCcWpTTWtVUk9wamJQbUs5aExhZnFDOGh2VjJ4eU4yVm85RVoxWEJ2RXFW?=
 =?utf-8?B?bEdGcFRjaENUWHV2Z0FyUDlod2V1RXM1UlFROTlNZVlBWTU1RWRobG9HL3Aw?=
 =?utf-8?B?VU01TVdiSDVtd2sySWJwTGF0SUhjR2VlQXNUR0dkY1ZWakt4UzhCYUZLUjhH?=
 =?utf-8?B?ZUVHcWNrSXFGOUlRL2xPdlJhdEQ5THIwcEZKSE9ydHIzTTRaR2hkR2duM01z?=
 =?utf-8?B?VTlzV3NVdlpUTERTWHl5ZTI5YXR1RlZLODFZRGV1UXVqR3lqWW1xMjErTDNE?=
 =?utf-8?B?dExsV25CaWJxVWlvaGJ6OUUwbXZ1NDJIVzg0NEZlWDlnWnBwd1o0dktmd2Mz?=
 =?utf-8?B?RmplMjJyYzBJSGxGQ0M4VER2K2hMOEZ0NHUzeEJ6Z2NoRXlHRGhnblBLM2dO?=
 =?utf-8?B?TzVLMmkrOEZudHU2ekhKdzArc0d4ZzM2UWdzb0lyRjFqdVd3anBTNXJsRS9j?=
 =?utf-8?B?dk82WFp3YUo3RG95SjVWcXoxd0tIMUxDbytlYjk2c0ZnbWpHdEVOWTJPNlZv?=
 =?utf-8?B?U3FoVFNHc0x3TEFyTmNOb2F3Q2k0TDB2YzMxb1c0MmhubXpJOUlINE9ONy8y?=
 =?utf-8?B?U09sMng4cWlTanBON2VBYU9oTzNhNkRCUUNhUVFxWEU3eHFBczZ6R0lBU1Fa?=
 =?utf-8?B?MVNwNVlPNCtyeVJlUkdMTUhWdDB2MHhsdlBzTUs3OEd4bXhDOUFFWlRyckhE?=
 =?utf-8?B?WElLalpCem4zZ093SDVHSGJCbW1SOTBidWVPZmxKNkg4cUxJV0poUk5FVmZ6?=
 =?utf-8?B?TzNNenloOE1IZmJrdnFGNkZscFNWS3plb20zVkNuUlE4dll2a3Q1N3dDY3FF?=
 =?utf-8?B?bTZnSEhUVUx3dDRyU0puK2hldmdHZWN2b0xCa0drV09qVmxRSmRzVTZ1QlNL?=
 =?utf-8?B?Qm0ra3cvN0VpM1VCMFljZmNMdUpuQkg1U3hGQlR2ZG9kRjhzeHFkSUNEbjRj?=
 =?utf-8?B?eGszMkI4UEsrWm9oSWhLY0hDaGhDc3p2cDlGOHR6OGVmSXEvbUdwaG9nbUpB?=
 =?utf-8?B?Y3JEakxBamRGY0g5dlFWK2M2Qk0vYXp3czdJR29tV21UZkpWT3dwdjR3S1FU?=
 =?utf-8?B?S3lHVjI4aU5aUGRUUW1wWkRQRUEyRDNtNzQyZFU2SnpoRW5IY3pxaVlWOEJE?=
 =?utf-8?B?NWZVSUVudnp5WFg2bG1DWHhJZjByMXFHNEVoNTkyblB6NUlOcHRFeEZiNlRU?=
 =?utf-8?B?UWg4SVhQZ2VZZ1pCbEZ5WWJJb3VXbitHU01ZQm9HcjZlSHVMZi9xb0hOTStJ?=
 =?utf-8?B?TDVHU2l6WW1qQTA0Y2tyY3lXcWpFTFFVbkVSbXlkeWRzS24vaWFnWm4ycjNZ?=
 =?utf-8?B?UDZaTmFCc3VFWEt5VU5RUWh6TWI3NWNuU0FKYXBDR29HdUp5RW83MllGcTk2?=
 =?utf-8?B?cjJlbmhkWmlyL0Rhdm9Cb0FvV3ovQ1FsZ1NRMHZqMlo4ME5MSVdtRjZLbEdS?=
 =?utf-8?B?bkFtelBQUXJqN3htS3dCbEVzY3Bwa2hOZjg4V0RIam9OdmJjbXJHQ2N0Y1hx?=
 =?utf-8?B?SU5ubHg3S2E4Y3g2MDhhdDk4TWxNQ0ZaWEVJWTJPcjF3M25WWldOMUpnRVdR?=
 =?utf-8?B?b2M3cCtpeXJaTUpQN3JKcmpKbmdCbFFEYnhTbHRHOGw2ZWpKYmtnRTFmYVR1?=
 =?utf-8?B?YzMvK1M4VTNFLzljRmJyYytFN1EzT3ltYU1zRHE2YlVDOEpPNXhjd0Zncm5D?=
 =?utf-8?B?dlI2WTlLSHVxY1A4cDJ3UHExeUFrMFNubUtuMVVtTjhXM1poUDJOblZXUDIw?=
 =?utf-8?B?bWFiajhZKy9WL0JnU0l5bURFNHYyOHhmb0FZZFFuQjluRGh1QTl1ZWt0WWw5?=
 =?utf-8?B?VW52NHhJaFRBRjZjNkdURlBSVTlGMGkzdkhUNFVNV25JOVhuOVptUWkxMmtX?=
 =?utf-8?Q?/zMm7QPawqaLyqIr+oTPUNpHu?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <778092DD54E22F4DBA4B677C5258A76E@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 458f6247-042b-4dcb-4d02-08daa26e29d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2022 22:58:45.7628
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fMulY+w4eBvZCyqyj5wX5jDhyZTSalcDOrR8Ao2AxxKeW8TKMHfU9loZXG/a9F2UWxc2VIhef4hlfbRHwyXb6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR05MB5833
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2VwIDI5LCAyMDIyLCBhdCAyOjM2IFBNLCBSYW5keSBEdW5sYXAgPHJkdW5sYXBAaW5mcmFk
ZWFkLm9yZz4gd3JvdGU6DQoNCj4g4pqgIEV4dGVybmFsIEVtYWlsDQo+IA0KPiBIaS0tDQo+IA0K
PiBJIHdvdWxkIHNheSBsZXQncyBmaXggdGhlIHNlbnRlbmNlIGdyYW1tYXIsIGJ1dCBJIGRvbid0
IGtub3cNCj4gd2hhdCAiY2xlYXJlZCBzZXQiIG1lYW5zLg0KPiANCj4gDQo+IE9uIDkvMjkvMjIg
MDI6MTAsIFhpbiBIYW8gd3JvdGU6DQo+PiBKdXN0IGNvcnJlY3QgdGhlIHdyb25nIHdvcmQgJ2Ns
bGVhcmVkJyB0byAnY2xlYXJlZCcNCj4+IA0KPj4gU2lnbmVkLW9mZi1ieTogWGluIEhhbyA8eGhh
b0BsaW51eC5hbGliYWJhLmNvbT4NCj4+IC0tLQ0KPj4gYXJjaC94ODYvaW5jbHVkZS9hc20vdGxi
Zmx1c2guaCB8IDIgKy0NCj4+IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxl
dGlvbigtKQ0KPj4gDQo+PiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvaW5jbHVkZS9hc20vdGxiZmx1
c2guaCBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL3RsYmZsdXNoLmgNCj4+IGluZGV4IGNkYTMxMThm
M2IyNy4uYzgwYTE1ZWYwY2JjIDEwMDY0NA0KPj4gLS0tIGEvYXJjaC94ODYvaW5jbHVkZS9hc20v
dGxiZmx1c2guaA0KPj4gKysrIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vdGxiZmx1c2guaA0KPj4g
QEAgLTI5MSw3ICsyOTEsNyBAQCBzdGF0aWMgaW5saW5lIGJvb2wgcHRlX2ZsYWdzX25lZWRfZmx1
c2godW5zaWduZWQgbG9uZyBvbGRmbGFncywNCj4+ICAgICAgICAgICAgICBkaWZmICY9IH5fUEFH
RV9BQ0NFU1NFRDsNCj4+IA0KPj4gICAgICAvKg0KPj4gLSAgICAgICogRGlkIGFueSBvZiB0aGUg
J2ZsdXNoX29uX2NsZWFyJyBmbGFncyB3YXMgY2xsZWFyZWQgc2V0IGZyb20gYmV0d2Vlbg0KPj4g
KyAgICAgICogRGlkIGFueSBvZiB0aGUgJ2ZsdXNoX29uX2NsZWFyJyBmbGFncyB3YXMgY2xlYXJl
ZCBzZXQgZnJvbSBiZXR3ZWVuDQo+IA0KPiBJdCBzaG91bGQgYmUgbW9yZSBsaWtlOg0KPiANCj4g
ICAgICAgICAqIFdlcmUgYW55IG9mIHRoZSAnZmx1c2hfb25fY2xlYXInIGZsYWdzIGNoYW5nZWQg
YmV0d2Vlbg0KPiANCj4gWDg2IHBlb3BsZSwgZG9lcyB0aGF0IG1ha2Ugc2Vuc2UgdG8geW91Pw0K
DQpJdOKAmXMgbm90IGEgdGVzdCB3aGV0aGVyIHRoZSBmbGFncyBhcmUgY2hhbmdlZCwgYnV0IHdo
ZXRoZXIgdGhleSBhcmUgY2xlYXJlZC4NCg0KTGV04oCZcyBzZWUgaWYgd2UgY2FuIG1ha2UgaXQg
Y2xlYXJlciB3aXRoIHNob3J0ZXIgc2VudGVuY2VzLiBIb3cgYWJvdXQ6DQrigJxDb25zaWRlciB0
aGUg4oCYZmx1c2hfb25fY2xlYXLigJkgZmxhZ3MgdGhhdCBhcmUgc2V0IG9uIOKAmG9sZGZsYWdz
4oCZOyBGbHVzaCBpZg0KYW55IG9mIHRoZXNlIGZsYWdzIGlzIGNsZWFyZWQgb24g4oCZbmV3Zmxh
Z3PigJnigJ0uDQoNCg==
