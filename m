Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84FE05E79EB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 13:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbiIWLqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 07:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiIWLqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 07:46:46 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55FD9123D8E;
        Fri, 23 Sep 2022 04:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1663933604; x=1695469604;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=G8V8jWVbDYVTcfFGssLwuwLPdJZtVK8juMpdHdeAqts=;
  b=BnIlItekF4dGaUG6CptvhgmtoU4XuDuuwcCJFLUa1ag7WyxhFS6O1nF2
   R/sxrGAVPeq9g+IuTIHxyVKNVOk1EUvlveeBT+WtFczzwCT1BsLQb4P7H
   gf69glIltigbEIy0kEsbf17/Y0t9/nHyuQe+x3dktl0SqC1E14jB3doGG
   CIXO65ANjo2MUq7WXyQuMI3SQlOn3/+/ppvBfo4kSYIhKbUbUX/FX+aXx
   dUk1PqdINKaJHZsyoTnob+KtLD1JwtNWyCKrSfGhrbrBvLS9RfONnVXfY
   4x9Qw96BgYPAso6dMluI7njYfO+Ehq0EjPr4QJBrL0hHsBeiZF4MnQNAi
   A==;
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="192179615"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Sep 2022 04:46:43 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 23 Sep 2022 04:46:39 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Fri, 23 Sep 2022 04:46:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n5MwCUeX07izEitiTWxkQ7zlfNY2WfYUGDpZXLSL+YqrMq6M5oXqJbu3Ub6908cQ1VGGY5WDIfVIDYHPnRU5KISk4T+fSQP1nZQkrxV5b+niyXZssVlYS3Wy4XsgZefGGMxwmsUoDEev3QyVxG/9s1qWKodfjer77olFc8DzZ0qIpTBLMT25blr6n7c0F9k+97P7Q5ZsCYGWAs9mUHFmNeMiq36PMVpV8rvrNcDPqs85TJFbsecTW9UvpDubY80I8vw5y0iuzAD5w5AX1+rwtX4JOLlX1PCX/Mf0jNZT4eQEPKIUsKjCTLuiG6JH++mqLBIut7JUDgRxdKYiS42bQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8V8jWVbDYVTcfFGssLwuwLPdJZtVK8juMpdHdeAqts=;
 b=g38ktfL8YfWGw9LqJqUSXsA/e4Et2WN6QBY+oTDQ8Zvx/0imGS6JmARrxux6teetG37WiOL824MHF3pqDNEDZB7f0n9y6i3T+isFto25KynA2ke0SH+zMlKT6nNzjeSpuEs8ZCZu0DHQhAs+EcKsZti3lNbG7SXC2jflR5MZUbmlGBqRLQL+jYsVHrypWcMTVYw5tkEg9XcgnYT7Efk/TesAdChfY95UvMDqa2g9Le5bQW57ekfDyVy/boPF0HuODA3NAvY2wSGW99L/fvY1USKk4H5JsMh3tOVkRcjExvR1owES4MuzYrkFj94D0bG9xUwiXri4gIVtEtdnA6jjtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8V8jWVbDYVTcfFGssLwuwLPdJZtVK8juMpdHdeAqts=;
 b=HHh3J/XAhArh+6rW6ufMDblM3J+OGO0F+t8mrR8m0oSZxAJqMWzTbStXV622Gz3wPAOKw91teOtgl8DXmy5Z4v+7/qpJuu2tP1bh+Ep3R7rszOu4/Ja1K7fnx90ciE4276kNqH13EYdG0nbGOPity/LaRvZWq1pi0yl1H0mS9dA=
Received: from BYAPR11MB2758.namprd11.prod.outlook.com (2603:10b6:a02:c9::11)
 by DS7PR11MB6293.namprd11.prod.outlook.com (2603:10b6:8:97::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16; Fri, 23 Sep
 2022 11:46:37 +0000
Received: from BYAPR11MB2758.namprd11.prod.outlook.com
 ([fe80::2cfd:fc73:ba36:ae64]) by BYAPR11MB2758.namprd11.prod.outlook.com
 ([fe80::2cfd:fc73:ba36:ae64%4]) with mapi id 15.20.5654.020; Fri, 23 Sep 2022
 11:46:36 +0000
From:   <Sergiu.Moga@microchip.com>
To:     <gregkh@linuxfoundation.org>
CC:     <krzk@kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lkp@intel.com>
Subject: Re: [PATCH] MAINTAINERS: Solve warning regarding inexistent
 atmel-usart binding
Thread-Topic: [PATCH] MAINTAINERS: Solve warning regarding inexistent
 atmel-usart binding
Thread-Index: AQHYz0C+Cu3s8inqSUCvTCMVU655tK3s5JIAgAABMIA=
Date:   Fri, 23 Sep 2022 11:46:36 +0000
Message-ID: <1df4057f-00f5-05c9-28d8-047f15890cf3@microchip.com>
References: <20220923113415.90236-1-sergiu.moga@microchip.com>
 <Yy2bnM30h/d0kFae@kroah.com>
In-Reply-To: <Yy2bnM30h/d0kFae@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR11MB2758:EE_|DS7PR11MB6293:EE_
x-ms-office365-filtering-correlation-id: af23b1de-5e24-46f5-7347-08da9d594520
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 85fZ3NsYHi7LOsMC5K32iQzeXDOtBMUeHfGIsPB9r8ig98bpGmzq+dmcSFyqzHVQ9eyshiePSqpUBTJhFqpyQl5ml6wowTPicHCQgLgon+hSDTu4Bbge6nz8YU09AkiDDsPHwqU2/ZLOOu1BK8ZDgdi+Kb9qIyJ/qYalGqLT8isksYCRMG+OmcQIhC00bt65H436Md+CG1fWSUCqazmoh5jvJKLvGElKQH+U5CQ59fIWY14A93/oc31mF6QQ1Z6LOsr3YvHxiDpI6ZsbBiIK7jiWEzDMbNLpUjsxQKmvTfA+HsdnbCNuj1nk6FaLyanlkheTCdJh3Jxhhhi+d3+7iigFG+Y7WbJe/xHeVBaUwaJwHYUSfxfKvNXpzPAxvlipHCeV58u+0NTzO/oTszPraUjuBT2vp8pMSVMiwXLFfhPxf02J8azUMmAzfb2ipGqo1tofjdEr9gpGCXKc+jmdYnKwAU86CILStv9IUdCQdt3MX63D+CMdvU8BcXuBEZ3LlHFjxyFidej6bTGgKfhgUppyBLQz6/b8LanBo8lfB7dOZM1xcl6kjgbS5UNbVry0LyjaIvoU2Mfe8CQobagJ/J4G6xb9pmmD54pUCnWD29okRbzqUbPEMArdzHqgUbNl48LYuYxfD4T6MO+lqqD8HVLchDI0LysPQXJtG91Qd2kiPS5gCAxa/oJxNgiyufTm/XzkvbELJ9nfz05H8cWPED5j/B6ATD7tEG7tuAePrmxtmESHfCiaHp+JAHiU5Dy1FGTsdcGLxjHci/c9sb8JWrMFF5hXo+3oQbeCDfK0+Fc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2758.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(366004)(396003)(346002)(39860400002)(451199015)(36756003)(6486002)(71200400001)(31686004)(38100700002)(31696002)(38070700005)(186003)(8936002)(2616005)(122000001)(86362001)(6512007)(6506007)(478600001)(26005)(316002)(6916009)(4744005)(54906003)(66446008)(41300700001)(53546011)(4326008)(5660300002)(66476007)(76116006)(8676002)(2906002)(91956017)(66946007)(64756008)(66556008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TENNNTFjeFRjK005bStkcjFhOG96amdCZVRpYXgvYm5tUXFVRExTbTRGUzNu?=
 =?utf-8?B?UlhCa2ZlK3hJdnFlaHYyMXhrWHZORENxVjk3MGJSR0tRaEt5OHdwa28yMDBL?=
 =?utf-8?B?b1BnU3dEanl5R252cTFRMHEvdjBVTWVxUk1uUTAvc3ZmZWVLbVUyaVF6WU0y?=
 =?utf-8?B?blR2bzFreklaaUVHajZmN2dYM1NRNXc3cGdLTFRlWmVDMG4yUXBDRGpjNU95?=
 =?utf-8?B?QmFwRDNhOHRhQ1EweXpYMXltNWxFMkhKSEZHY3NOOTRwYUM2WUhweU5kZnBo?=
 =?utf-8?B?NEJNRnIxdkR1WTBzaEhrR2RLNG5FWG1TN2RZNkdodHZWYlhIaFQ3WXpFVWxa?=
 =?utf-8?B?QjdvN1RqNWtJblZnbW9FU001NXUzOWJlVXZOT0dYbGNOK2xEeWtDRlZHTWg4?=
 =?utf-8?B?RTV5djBnQkg4cVFxa1p6c0ZVUTB3TE02bW5kZ0pudzlvNThHNUt1UFcycUNk?=
 =?utf-8?B?WnlZTG1BSEtoVjRhUFRiZEdCRlR0TUg4dUZmdU52TDJOemRNVTVJanAwTW00?=
 =?utf-8?B?Q2w0RklzaUpTMWtvVmxlTSs2OVdaakp2Mm85SU0xSFozaGFuUjc0VVNSUzcr?=
 =?utf-8?B?dHd4MkRBNTdrVktLUTV0R2gyc1UySDN0cjcwT3FZVk16K2VWdFJST0R1aGpV?=
 =?utf-8?B?RlJMUUZvczFJOWw3MkZPaFJMdzBYUVBpdngzRFhvNHJpQ1F6SmdhQnk1OGhu?=
 =?utf-8?B?ZHNoa2t0cTVaVXdQb1RFc1phUFRQY25ESmhkKy8rWTZXaklMSW1rWXU3Zm1m?=
 =?utf-8?B?V0lhOGZMTmhMd3gyb2V1eVQ1aWkxWUVpK0p6d2xNTFo1UkYxNC9yeWs0cUhC?=
 =?utf-8?B?ZS9ncmUzQndwR1I5cWNUZnZlN0xpdTA3TFNEaTZKTUZCZmxmcWoxNEpBN2l4?=
 =?utf-8?B?YzVsWGFXZENvdWRrcUVlOVFPMEZyMEloNEtweGFJME5xQXB6UGY5WHNQYXFz?=
 =?utf-8?B?Zm9odU01L0hEUFFWOFkzTDRWODhONUdjK241TjZmckZrSk1JUzUxcXhuYzJT?=
 =?utf-8?B?T2RuUXdyNkdKZTFaakxtNGNyam5XY1h0TW5aZlE4dzhrdGZENWxJemlKcTZG?=
 =?utf-8?B?aG9uL2hRV2hUcEJWR1B4emgyR2NHQXVkbEI0YlF1V0YvQWk4QmVZOTJibzBT?=
 =?utf-8?B?TXB5aG83SmtDams0OWNsbExweTN0R1VGbG5DcDA0WWtVM3Z4ZmF2eWM2Q24x?=
 =?utf-8?B?bEZGT1BQTy9rSDdsekMvOFZHZ2VRWHliVTJ6WVlsR2p5Q0YwSWZqYU9PYllV?=
 =?utf-8?B?TUtPRFV1aXlxMFh3aEZuZFd2eEZHdWpuUGlqUlVjNUJVZ3dZMkgrbHVBeG1E?=
 =?utf-8?B?QzF0WmN1YWozT2hBTTRPUnlNc3BpZkZlWVRjcDJnVjd6b09WTzJVS20wZUlo?=
 =?utf-8?B?TFhvNGdxLzloNVhjcTBEcFFUTUdtWkZiZTlPY0I0eEhmK3lYQndnYXlUS2tj?=
 =?utf-8?B?NzhjTHoxRm9NVGNCYUlqNjNWTUJqcURNZGJIZkxwL3Q3engvTXIyZnRxMzJa?=
 =?utf-8?B?OXJYVEJqLzVpQ21aTWhRSlJpYi9HRnpyZ2pSMDNCU1dPaU9kMlVhTmhjb0NJ?=
 =?utf-8?B?N3B2TG0xdkhzMmNEQTJvRGJMZ2JoWU10QVByZ2ZCMzNlOXNTRnBJVVlZZkJv?=
 =?utf-8?B?d1Y4K0ZhUkJjdVBkdXVYc2ZrQlFUS1k3ZzkwdHdaYnpuRGlSS0ZyZDNuUGQx?=
 =?utf-8?B?YW9DN0JSRmpuUWJqay9mQUFwbWFzTlp5STM2dGRVZ1lvbWtWZUVpT1lNUlgy?=
 =?utf-8?B?dzU3N2NOVFVXZU9sQUxWZVFXMTNMaHJkNWNzZHJySVJ5bHo4TGswR3JLdWxs?=
 =?utf-8?B?R0tXS1JuM1pnbjljTiszM3JJUTVtbFNQVWJOR0R1M2dPUjQyQWF6ZkhMeU9I?=
 =?utf-8?B?bGx2TVNyMnIxem40NVk4azRaZ1NPMjhDYW5VOG5UTEhlVmtEVnJ1TGhhaUw1?=
 =?utf-8?B?L21uNEdMby9rcDZMWmY5VzN1RnZjTnlWYW1hQmNITmNJQ24wRHF3SXh1UzVN?=
 =?utf-8?B?Z2gzdDMxa3lLaXAwcEQ5LzQvaGk4OGF6VUJHamVwSjExbE9mVnlBVXJaaHF6?=
 =?utf-8?B?VEJzQmlHVzRBcWpvZjdNdDFLZkc5N2RjRDU0eWNqTlk0YVRBdFVDWVZ3cWR4?=
 =?utf-8?Q?yYa7qgaeqHplTPMk8az8++oby?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <47829327854F424DA3711A8B7BA2D3C6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2758.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af23b1de-5e24-46f5-7347-08da9d594520
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2022 11:46:36.3595
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rVC6PHu9KtqLFcjK30EUVlY1jBzH7XuVmOSwi7E7EavfS4E8IiaChllqug0RQDj4Ftishho6wssvAc2NIXbqGiuhiGMzoGQLyt9rw1O/fuQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6293
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjMuMDkuMjAyMiAxNDo0MiwgR3JlZyBLSCB3cm90ZToNCj4gT24gRnJpLCBTZXAgMjMsIDIw
MjIgYXQgMDI6MzQ6MThQTSArMDMwMCwgU2VyZ2l1IE1vZ2Egd3JvdGU6DQo+PiBBZnRlciB0aGUg
Y29udmVyc2lvbiB0byBqc29uLXNjaGVtYSwgd2hhdCB3YXMgcHJldmlvdXNseSBrbm93biBhcw0K
Pj4gYERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZmQvYXRtZWwtdXNhcnQudHh0
YA0KPj4gaGFzIGJlZW4gbW92ZWQgdG8gYW5vdGhlciBiaW5kaW5ncyBkaXJlY3RvcnkgYW5kIHJl
bmFtZWQgdG8NCj4+IGBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc2VyaWFsL2F0
bWVsLGF0OTEtdXNhcnQueWFtbGAuDQo+PiBUaHVzLCBtYWtlIGBNQUlOVEFJTkVSU2AgcmVmbGVj
dCB0aGlzIGNoYW5nZS4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBTZXJnaXUgTW9nYSA8c2VyZ2l1
Lm1vZ2FAbWljcm9jaGlwLmNvbT4NCj4+IFJlcG9ydGVkLWJ5OiBrZXJuZWwgdGVzdCByb2JvdCA8
bGtwQGludGVsLmNvbT4NCj4gDQo+IFdoYXQgY29tbWl0IGlkIGRvZXMgdGhpcyBmaXg/DQo+IA0K
PiB0aGFua3MsDQo+IA0KPiBncmVnIGstaA0KDQpNeSBhcG9sb2dpZXMsDQoNCkZpeGVzOiBiOWU5
NDdmYmYwMDggKCJkdC1iaW5kaW5nczogc2VyaWFsOiBhdG1lbCxhdDkxLXVzYXJ0OiBjb252ZXJ0
IHRvIA0KanNvbi1zY2hlbWEiKQ0KDQpUaGFua3MsDQoJU2VyZ2l1DQo=
