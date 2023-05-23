Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7108C70E63C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 22:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238458AbjEWUIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 16:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234646AbjEWUIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 16:08:52 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFBB1119
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 13:08:49 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 34NHZGgm029572
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 13:08:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=sAfGEpakNy+434S2tLTHpXwzt+YOGXHD6ccChf2kols=;
 b=GFCNhQQYhHplci70qxEEOodUAbibwyaiNLnwOx/hMMxaY/Ah2z6GVgwImI+5ZYB1KPZ3
 D3Xb5jJ9VrymE15undjxYeiFI/7vqvsYOLP8y+cm29my6B65wC6nposVoZfPUU5SM3cu
 I/ULaLKS5sWYMQwkPt739d14XiODsKhNS3fkWMgO/tkIkVR892yoBc4D9fgJD+rJbojg
 75/k3CovdqoDx/UURiTnbsku4ogvvN36Xg6Ol1dNgRWoile3QnybYl/g3WT3x/cTHOjl
 qxIuM9Cse898cWWGQ+wcBruhmlgL99qG/VMynIy9nthNJ/1tXC3lN7m4xI8WvNAJenxU vA== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by m0001303.ppops.net (PPS) with ESMTPS id 3qrb8xaw76-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 13:08:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NAkCySBguUbu0Vbiz8B0QVJ//vTFWZQsZwGpgk2AqJw7VSiphdLUA+GhC5wl1HvgTuqDNR8XT3uzyzbnlso+O0v7QOXCXIv9MCpQAKSVvsZWrcpxnR7eNiFucK5EnoJrrLa0qADFznSXn7giUFFruQ+WRzsNp9or/guFKcplLFyfUOyw4OQXp/JYoP0PZxJAvFLJYdRgxylJw4suRCYwWiPr6IQr32+NTEYVchhPFWknNmHDHEHKaLSYEu3dYyiTdkM9Gs2UdoBZ8CqpU//BMYG2OYeXLPS7KhO5LD4a0T+ODPY4/m4K+Kvvmpv2e2ES3N4dY2JiCC1WdLe6WolkEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sAfGEpakNy+434S2tLTHpXwzt+YOGXHD6ccChf2kols=;
 b=HcaYAB+pBJLPkg+046lc6zHN/AUr6FwFwZyF7BiOLgsf3bp9hN9rlP89EBkjA2CcHad25NNjVIDOzram67zoHL2VkrP2CfJ+9ughUwyfeRv/y/V/ECYlgzbhUlYKrUjETLswNkHEGixRgrOcXtRz9Ou2pqa9uG3tlPcII8P4syA7uirwUwElT9TjX97hlTOECVlYGkB8lUM3dZgGLfhULxC2a+z/vG5iYVpFx4pHqNNh8Q6d6KnHDotdFfq3zcJ/9yU2cEkCpA0lNp9HDOQJRthclSQhxdJ4u4r3rfGKfKq7hZX5TCsXxWfYuI335imWzpftAck3HfwMZNQCzqRUVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from PH0PR15MB5263.namprd15.prod.outlook.com (2603:10b6:510:144::10)
 by IA1PR15MB5417.namprd15.prod.outlook.com (2603:10b6:208:38b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 20:08:43 +0000
Received: from PH0PR15MB5263.namprd15.prod.outlook.com
 ([fe80::40ec:9aff:7ee9:3502]) by PH0PR15MB5263.namprd15.prod.outlook.com
 ([fe80::40ec:9aff:7ee9:3502%5]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 20:08:43 +0000
From:   Rik van Riel <riel@meta.com>
To:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "tj@kernel.org" <tj@kernel.org>,
        "dhavale@google.com" <dhavale@google.com>
CC:     "nhuck@google.com" <nhuck@google.com>,
        "brho@google.com" <brho@google.com>,
        Kernel Team <kernel-team@meta.com>,
        "agk@redhat.com" <agk@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "joshdon@google.com" <joshdon@google.com>,
        "briannorris@chromium.org" <briannorris@chromium.org>,
        "snitzer@kernel.org" <snitzer@kernel.org>,
        "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>,
        "void@manifault.com" <void@manifault.com>
Subject: Re: [PATCHSET v1 wq/for-6.5] workqueue: Improve unbound workqueue
 execution locality
Thread-Topic: [PATCHSET v1 wq/for-6.5] workqueue: Improve unbound workqueue
 execution locality
Thread-Index: AQHZiedSI4sMbiE1HUe+Ip9kCQsEdK9gwX6AgAFvG4CAAAe6AIAE5hSAgAEOcoCAACQWAA==
Date:   Tue, 23 May 2023 20:08:42 +0000
Message-ID: <05fe8027e0f447d3249d423d843f943c3974489b.camel@fb.com>
References: <20230519001709.2563-1-tj@kernel.org>
         <CAHk-=whA2ztAcVrgsqj39j30LJYhjBSkk6Dju6TY16zGpXpkZQ@mail.gmail.com>
         <ZGf5rfESYhKYzPSY@slm.duckdns.org> <ZGgAKK-c_DZpvNJB@slm.duckdns.org>
         <CAHk-=whbP8BjGyGyXcSKi32orb+1+cHSC2HoVAMNVKwmbq8pSg@mail.gmail.com>
         <CAHk-=wiH9JLQ0AN98aLKpxiAL4ssbnnq_=3R_qvy7AEGNT_iJg@mail.gmail.com>
In-Reply-To: <CAHk-=wiH9JLQ0AN98aLKpxiAL4ssbnnq_=3R_qvy7AEGNT_iJg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR15MB5263:EE_|IA1PR15MB5417:EE_
x-ms-office365-filtering-correlation-id: 8befeef0-4dbe-430a-9a96-08db5bc981f1
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ERHL2brSCcJ90JKlZnsProyTn8h1A08aGOuIQ8VpYL5F9M1RTKWmcqvXFg8tkZtzBWyO9/rdDQSTeGd3DAAO2idXb/EqkqSwT5HxkgvbhDUv/wmMf70CoYAsW8hdh7F3CSbdzZnKfxhgPGH/1g/RGXKFYr82Cy4jpS5+wsBdr9pNSzk+DsP2YjvkAOv6hU0XXrqatqFv09hHw4yv25EITwiQsyL7vgGp1xZU3/qKAYhL5TXj7UPV0qaK0V9pxU0BKaQtKvGW/Buy8AD38bHRSkdW29heQkLahi5i6IqZ/dgvPI8XaLPeTbORvSsits0oirnRyIgWMzLrJ0g+FdsmwbRjWzK4M+l4S5m2t8quqVzKG8Ul6XLcNmuITeITeL9pNDh7MR1auuLZvHG4ioqivMNSY4pbUKXMosvAUtAk9Z0B8EXStbrjai+eZUVrjzpkoZfShl39+zApWExYMpfmplzNdQAZiodOwHC54kQPA12OHa374fDOetibosjWPEc0PVBn6HnsExb6ehPwJntVc9QyCvxCF4J2v3Ch4Sg0L6aWr+ggzfDVv5t4zQvZaEIRkW+oSYNUl0aFobPdTmAyI2ZrdL6qKnVENCF2cb8UdNqIsmWk7gDbSDC7ic66plAG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR15MB5263.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(396003)(39860400002)(136003)(376002)(451199021)(2906002)(91956017)(4744005)(76116006)(7416002)(5660300002)(8676002)(8936002)(4326008)(36756003)(316002)(66446008)(110136005)(54906003)(41300700001)(66476007)(64756008)(71200400001)(478600001)(66946007)(6486002)(66556008)(86362001)(186003)(9686003)(6512007)(6506007)(38070700005)(122000001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UGpnOHNFd09jREFJdXdId3VBTW5TcmxzUUIyS2lBUDRtRFlKeVFzVXBSNjhY?=
 =?utf-8?B?S0d0dTlPWGljcWducU1xdDRKaFpieHpzOVNsbEtwWFFLcXArVGtNVnRXU1dz?=
 =?utf-8?B?WmNDSk5CcnBzYjhuLzRpaDBVdnJQNkxpc3hsNzVlRGVmNUJ1d29RWFVNb3ZN?=
 =?utf-8?B?SmtVTmN0blVvaHZBV0lPMS9GTmtEVmI2SVRjRjdadUNnREhFT3FCRGw5bjE1?=
 =?utf-8?B?Rkw2TVkrUndMNE5pQUZxUVpnU2lOanFQY2Y2Z1g2ekJJUllkcHFXSFp3cVNu?=
 =?utf-8?B?NFdsWUQxRGRVbTZVV3BFNkVUcERpU2ZpOW1tVThiaTErRXR1cVdaQm1EelZu?=
 =?utf-8?B?UWwwem1YYXJZOERuT0ZtZU1kcitzUENoZXRzWXhFRitGOU1EbkpzWnRJVk1y?=
 =?utf-8?B?ajlzYVpRUXZIUUpUTzdJQnY3NGJodXZSMVVKRERsaWpFQjNTWmtIWVNKNGFu?=
 =?utf-8?B?aXpNdnI5T2tJQkd0WER2dnpKSy90U3l0WDJuN3FrWmxRb3BjTXlMRnlFKzJC?=
 =?utf-8?B?YTNScUFVYTBUMGxlRVJMWEhCTVZpVnpMMmdGMXc0c3ZqV2FBQ1Rxcm5PRUVs?=
 =?utf-8?B?SDlqMk5yZ3c1MmFZcUMrR0kwbG5PcmM3QktjNnhFdk9OZTJjVlg4N2FKdHZl?=
 =?utf-8?B?SktubitMYmRkaTVYS0IyOXpDUUdGb2U0MmJyYWVuU0FISlp5K0dnQk1wOW9O?=
 =?utf-8?B?enFOUS9zTFRTdFBDOXFPWmpLK094c2U4bFRpeGZWeW1yc1MxT0dDSXRZbURY?=
 =?utf-8?B?Wmx5by9OOUFibEpKWUIxb3d4UkZWeFNhck1WSS92ZEZqNmRVZ1owQ0VUaHFq?=
 =?utf-8?B?djRna0ZKVlVlTkQ2WTBGK0xXeEh0SGFCMmhaRmJOUFlJQkllbnpxY1o2T0JG?=
 =?utf-8?B?ZWFETXR5QkdOaTdxMVRoOWdpQXdjbVVaQXRUUFBweTMra2d5b3pqSlI2ZmI0?=
 =?utf-8?B?dU93L2ZLbWlKdWVwM0plRHdPNFB2UTBBdXRudzdrK0xhbmZlaU5Wd0VoRE40?=
 =?utf-8?B?blk5VXVTNWladzFpYWt2VHVOajhUN1Y4TzJ6LythMDVFK1hBKytCeWF2ZW9a?=
 =?utf-8?B?bG1UZGFDUWdJRUEzV2Zody9XbXlMNjQ2TCtaZStxRjg3WVRJMFljZXl3S2d6?=
 =?utf-8?B?QXJpZ0psT0RIOFJwc0w5ditXZTB1UFMvelJ5bnhSVFJySXZxaFNLOER2RERt?=
 =?utf-8?B?a25YR1hXSlN4dkY5QnREYXRtUGJIdFNNdzUxUnhPY3pDYytmUzROWjgyc1VX?=
 =?utf-8?B?OW8vUmFHaWRsNTdHbE03cDdNalhXKzhMQVQxVGExR2pJYVpMNUdRVjdMNVMv?=
 =?utf-8?B?MGFGelJFS1hNMVBJZWJGL0RqTkVTRmxMd0tESTA3eXZ5Z01YcTJTNjR1ZFQv?=
 =?utf-8?B?RFh4b3dGeHBSNCtxb2NPcGI5cWwwTS96b0hlSlVCcHdxRytTZ0p6ZFJkODNp?=
 =?utf-8?B?b3NtSFJsQWk5QkVRS0UzbEJkSkpTT2xlOWhuRHZSaTZpb3BOVmxhTXYybHVj?=
 =?utf-8?B?L2xFSTNtMjlTZ1dmMzR1ZFNWVW1GRVYrQUUxT1FNR3UxUzNGeVA0YkZ2ekQ2?=
 =?utf-8?B?cDVPY1Z2NUZjdVhVc3Q4dmRFMUVscGgrdmd3WGpGcjBpUnZNdWhLTzZsdFM5?=
 =?utf-8?B?QkNHd2RVSVJvUnZuaFhxVnU1NVR5ZnU2OXBHMHp4QnFQL0x0RXFxZU1ZdjJs?=
 =?utf-8?B?MHpJR1hKOGtSU1BldjJ5K1ZncHZzbUxuaUNwMHVtajBubjdkRFFFeUI4N2dQ?=
 =?utf-8?B?amVVYzdWb0FjVUIxNFhBbTcvZ0w0Q1pBNTk5Z0ZUdHZ6RElMV1dWc0ZVb1h2?=
 =?utf-8?B?MHFYaEovOVM2SFRsdE1KWWtvU0I4VmhnV1VvUnRyaHkwUjVMV1NHQmIxOXgz?=
 =?utf-8?B?TzVhTE1DQXYyU0FsSGl4aTJzbHVuY3o4Q3pUWTE2R0hBYllvbXhCZkliYUJh?=
 =?utf-8?B?SFg0RXlrL0N3S1kvMlNURXpVS2NKeFQ4dGE1NlZEbU1QaWZuL1BueEptZ2JM?=
 =?utf-8?B?QW5KMDFnLzVPQm1iK2tNRjRuQ3NzZ212MngyUTdBQ1c5ajk5eWVGTlJaZmda?=
 =?utf-8?B?NTNVdythM0tydmsyQjZBY1ZtV0ljS1ZVNmlPaXpGODBveG9PVjMzN1pRZkU4?=
 =?utf-8?B?QU5nZERmektPUGVEM3FSK200Z2pwR1NrYzdXRm1GL3Q4cTMySWlTd3RrWEs4?=
 =?utf-8?B?TGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B6ECC2A44215144288CB49CC84A336FC@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR15MB5263.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8befeef0-4dbe-430a-9a96-08db5bc981f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2023 20:08:42.9654
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HWTxM7wQbuVBi1XA3CH6PpSv7GPPpxfQm/iaeaCYJzbl5CHKzQk4P6jfqu0lLmZy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR15MB5417
X-Proofpoint-ORIG-GUID: y8DdfDvQBdmG8fw67TuJy6cFvfkuAZZw
X-Proofpoint-GUID: y8DdfDvQBdmG8fw67TuJy6cFvfkuAZZw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_12,2023-05-23_02,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTA1LTIzIGF0IDEwOjU5IC0wNzAwLCBMaW51cyBUb3J2YWxkcyB3cm90ZToN
Cj4gDQo+IEkgcmVhbGx5IGhhdGUgaG93IHdlIGhhdmUgcmFuZG9tIGRyaXZlcnMgYW5kIGZpbGVz
eXN0ZW1zIGRvaW5nIHJhbmRvbQ0KPiB3b3JrYXJvdW5kcyBmb3IgImt0aHJlYWQgd29ya2VycyBk
b24ndCB3b3JrIHdlbGwgZW5vdWdoLCBzbyBhZGQNCj4gcmFuZG9tDQo+IHR3ZWFrcyIuDQoNClBh
cnQgb2YgdGhpcyBzZWVtcyB0byBiZSBkdWUgdG8gdGhlIHdheSBDRlMgd29ya3MuDQoNCkNGUyBw
b2xpY3kgc2VlbXMgdG8gbWFrZSBzZW5zZSBmb3IgYSBsb3Qgb2Ygd29ya2xvYWRzLCBidXQNCnRo
ZXJlIGFyZSBzb21lIGNhc2VzIHdpdGgga3dvcmtlcnMgd2hlcmUgdGhlIENGUyBwb2xpY2llcw0K
anVzdCBkb24ndCB3b3JrIHF1aXRlIHJpZ2h0LiBVbmZvcnR1bmF0ZWx5IHRoZSBzY2hlZHVsZXIN
CnByb2JsZW0gc3BhY2UgaXMgbm90IGFsbCB0aGF0IHdlbGwgZXhwbG9yZWQsIGFuZCBpdCBpc24n
dA0KY2xlYXIgd2hhdCB0aGUgZGVzaXJlZCBiZWhhdmlvciBvZiBhIHNjaGVkdWxlciBzaG91bGQg
YmUNCmluIGV2ZXJ5IGNhc2UuDQo=
