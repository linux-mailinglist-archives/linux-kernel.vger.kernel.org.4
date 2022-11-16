Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC5262BC11
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 12:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238393AbiKPLe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 06:34:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233342AbiKPLe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 06:34:28 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2087.outbound.protection.outlook.com [40.107.255.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC8538A8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 03:24:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OBBqDttkgWeZXtvpbsZ/q++mI/FNvMy6xOWSUp39u01p1qrejcHi9dzxYKwHu6HXyBEEcWJT2KvF3s4dbcL/JMN2d6NTwWsmyUsSVWB9pAFPmFM4Xk/W8Il2aTGeOMgka3QTLopZjFHWAlLcqmz/SVP0XzYgdv1K5LaSpw/DAZ7+8DuQCneeLWn1MQSPoE+SQY3AO9FwV79LoUGm1ce5R1n6dCxniSFul7FYI3r0QBKewGZKpwINmv0mXQKni5CLHU84OQoMfdY3n5K+FTUki9oOMygA+tYYrpi0Mm9sBajo5bhgzdcqJ3AgG/Rd+Pyrno6mFd6Ey4swzv+Kk93fgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T6AhgnMaa+t+xhKpdoKS4904zTp+SIVgjFtf3d3L7BU=;
 b=UZZGxxeuR97asMz4HQhVEGQX6nY6jeOYAxoUedCYYnbxeU3hhcvoFd4pbYZqf8AP4vXVWFGgVADUqILuB/1YeNKr+TUDAm9XtqGYzyp+rVZ9u8ajLQWj1nF+qav++HMxonqdJwqL1FQZpBU3LWKKD+SUuG0QxqKnNOz4YltcEGZmp7yout5XrNbpNunhZE6KYD7UnPwbgFaK7DOKjIfpgqRfI64n/E7HSW43XYLRsb2MZP3biqDD30fxepqYgT6h2w1C9seMEtDa0svDdBz0bigRHPOE3VJugU85purPDUdt2TCf8ayHwq3c0rVJbwWA0h6a/oYXnjTGOsg23bhkmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T6AhgnMaa+t+xhKpdoKS4904zTp+SIVgjFtf3d3L7BU=;
 b=Fse6EnO3XE39G7yuFzHUBboB3ipCmRBTl8mNh00+DcIy4FuRJVPtxlDb13xj0v0FPcW4+d+c+uBaxGr/7hagsH3qnCXnN+hyemMxjLsFUEEbvTCxAm7pFyNlqVbZeUHqltfFOdT5+c6dTskSh+PTfkCKzJPrOL6V+UEnKFqASM5JSUGXXJWFm+/vtEE/EoY/NlFgN1jxlURJBmMOab3p4HUzwm3R2GJiX5+oAbffOwtBvkTjW1zP/wuGbc4MdihOmUUfUnb127jhokxztWR9H/2TI8rYM0JpFyLQ1bqkeQ1ycqhqI0scUEUjc0eHZvCyGxwHHLkjKDYgRYblo7vu2w==
Received: from TY2PR06MB3424.apcprd06.prod.outlook.com (2603:1096:404:104::19)
 by TYUPR06MB6195.apcprd06.prod.outlook.com (2603:1096:400:352::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.16; Wed, 16 Nov
 2022 11:24:23 +0000
Received: from TY2PR06MB3424.apcprd06.prod.outlook.com
 ([fe80::3fde:75ae:e50a:7b24]) by TY2PR06MB3424.apcprd06.prod.outlook.com
 ([fe80::3fde:75ae:e50a:7b24%7]) with mapi id 15.20.5813.014; Wed, 16 Nov 2022
 11:24:23 +0000
From:   Angus Chen <angus.chen@jaguarmicro.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        "Michael S. Tsirkin" <mst@redhat.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Subject: RE: IRQ affinity problem from virtio_blk
Thread-Topic: IRQ affinity problem from virtio_blk
Thread-Index: Adj4GDwuFWHl+dEdQ1up6lA52hDITABKCKOAAADen4AAAK+KgAAAs48AAABvT4AAAul7cAAUyiAAAABK+xA=
Date:   Wed, 16 Nov 2022 11:24:23 +0000
Message-ID: <TY2PR06MB3424E673A1374CAC37E647CA85079@TY2PR06MB3424.apcprd06.prod.outlook.com>
References: <TY2PR06MB3424CB11DB57CA1FAA16F10D85049@TY2PR06MB3424.apcprd06.prod.outlook.com>
 <87v8nfrhbw.ffs@tglx> <20221115174152-mutt-send-email-mst@kernel.org>
 <87sfijrf9o.ffs@tglx> <87o7t7rec7.ffs@tglx>
 <20221115183339-mutt-send-email-mst@kernel.org>
 <TY2PR06MB34241333364AA5843CD4BAA885079@TY2PR06MB3424.apcprd06.prod.outlook.com>
 <87fsejqicd.ffs@tglx>
In-Reply-To: <87fsejqicd.ffs@tglx>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR06MB3424:EE_|TYUPR06MB6195:EE_
x-ms-office365-filtering-correlation-id: 8e27058b-c6bf-4df8-72b8-08dac7c51d33
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dhUUBIbvnhfCsxI45YcrMyWXytZrHVFYhqu638kDdSed6DwOO5FiYs/+vZGtju/0OkHCHIeyqjuVMOtgvsFXW9t/L+haxvnyAY9SRYzHMp3V/yoUZ5A5ImQXQp5LEKxVRUpgx/HzWAlyPsyJ5jEtK4hAOwtNI/yUz8MKnbnAP3v697WwfuRGxINgb71jl8nmkey6QRBFf7O8gU88qMFGtgYsEXGYILsnsguolJRBTWdni40wp1bYynrcDfJJUs4533Qglb8XhsP5QJvUOrcgxo+DuA7LnwtnlUl6w4x10RDpp2pvbSUzcaGA5FAKMt29MsE2WHSZ08d1A+yQwnUUCoOr+CEMogmKEWDy+OpL75AKXoitI113hKcj5AiUnRyt+izmUwJgYF8bdnEOhQk/nmdLlNBvppjORW+YQ55AoAXAuAYZ2ECI1O5tSySLY6ZF6RTSKpXHT2V8mqzXhv1IH6VWLN7BgBNAFyujQSmGZaBMpqsvN09eT26wHXnxlanvOMCz39+BL+vm87v7ubQ6aci4pc/CL1ILaxLxFnNTX01Cz2/y/ENOkKlqdzN4bfwa1s3OFkh2t5XLdjry7UJjV1u50czyYECJ4COzTap0blfdyqU5lxbxvfgHCoxwRTUymlTHoas2UiiyABZtafLrTc1p7FQiO28ztfp7D1QDITCafZr9NFADcyl19FehoyUlmrwlItHd0RUIbBV+rnXA/9mUMxvqKt3atCKc9MKHL/jQXTRpdI4sTQc8C49CCvTBeAelqd/IbrCe9Iagby5rIQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR06MB3424.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39840400004)(396003)(346002)(376002)(366004)(136003)(451199015)(5660300002)(4326008)(66446008)(4744005)(8676002)(8936002)(52536014)(41300700001)(66476007)(478600001)(76116006)(66946007)(44832011)(53546011)(86362001)(2906002)(7696005)(54906003)(66556008)(6506007)(38070700005)(83380400001)(71200400001)(64756008)(186003)(26005)(122000001)(55016003)(9686003)(316002)(38100700002)(110136005)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dTBmaHZ3OWVZeVRJMGlMVHFpdFVsd2hVZXNZdU03UjA3ZWpTdThybkJnbzRJ?=
 =?utf-8?B?cjdna0F2VjdDcTI3cklPUnhVaUZrdDFsL0c0elpGMmh5Q0xMYzVHVm1tc1Rq?=
 =?utf-8?B?WnRGNVlDL3VFSERXcDFLQnBPc2s5VHdIb05LWWhxMUpnb3gvaVBIWkpaZ09L?=
 =?utf-8?B?TnRvTUJIZWd5c1VvQndmRHU5azFQdnhhd3hKRkx0eXJKUWlnbWpodFczbFg4?=
 =?utf-8?B?UDdXYmdSbmtOVWFzcGtFZDF2RHEwejg0Zk5ZSlVhOXh6UVphYUhXWitqa3B5?=
 =?utf-8?B?QVBSbmF3UjJXZDhtWmMwbnIzTUxGQ2tyOEZENzR2bWdSdUNwTzVHckt6UmtK?=
 =?utf-8?B?ZWhRdGdKOEZCUWtoTXBHUHc0YjZvclppMENnT0k1RVpEUk85d1c5Yyt3dFk2?=
 =?utf-8?B?WUhYMkk1RENGNzU3UHlqYUxMbnp3Q2NSQjhRVHBDMlJXK1J3SlJMNWMwVUlT?=
 =?utf-8?B?OVpxZ3lwcHdmQmFyckFkM2RCRTBseGlBZkRXR1VmU2ozRG5YVmpOYXdPNnRV?=
 =?utf-8?B?QjluR0ZSeVlsZnFSVEMzQXIzd0E3VVpCZUdzeXRsaEpxTkVUelRlNXlLMmJS?=
 =?utf-8?B?ZUVpeExYZ3ZYZnNZSXNrRm45Skp5SHJISXhkekpuVTRDcUdDaW43ZjByMVFu?=
 =?utf-8?B?ZDZMMVhKRmRGbFJlYU5iNDQzUWhRbEFrYXo0STE0ZXBBV0hVc29FOXc1VkdP?=
 =?utf-8?B?Q1hMK1dkTDlRWlZUL3Fsakgra2hoeXRRSVdsVGp6Y1pYSWR5MXFuMVZtazQ5?=
 =?utf-8?B?L3YwNHhMSXdJdXllTHZoWDFaTUd2YzJSZXhIdlpCaGxhaTY1cElmY1pQWU9w?=
 =?utf-8?B?MzFSVjRCRkNNQ1pIV2R5djVBRFBldVFGS1d4WFFERkFHc1NaUGVvMTVzeTJk?=
 =?utf-8?B?VmcvaUF4QktCN0JmRm5UOURUdWp4aHlVZjVYTmp1SmpVZmFvVVFqd1dDZ1F5?=
 =?utf-8?B?RDM3ZnVNYUkyaW8rcVUvR3JmNlk5anNqTlYxY0VkN3BqUEoyU0w3NFpIVjNu?=
 =?utf-8?B?eFJPa09jNmYzWmE0M1k3b0lhL1F3TFR5SWhkMi9lbEVjWVNBbG9kQnIrY1VL?=
 =?utf-8?B?REQ2dTRhUlZ6KzNVdGVUd2ZZM0lCYTZ4b0xWY21Canc3OTIrVmNzQ1cyTk9Q?=
 =?utf-8?B?c1lWUTRURktaeXNhd0lhWDBtSEJIWWZaUVFlRU1GeWVqQWNjb3BpVFFVSWk4?=
 =?utf-8?B?QXJhSnBFODJNZmhmWStvNmE1eTdvb2dsWEJKMm9wc1RyZnJLeDlBQWpLbi9t?=
 =?utf-8?B?YVZFN21vZmRPR2FkNHBZME1TNWRJRmdHZElnODBFaDIzWU95ZDdRQ1VlVk9x?=
 =?utf-8?B?WkxUbEVWV0JyVWNqL01INDAyRHJ5SFJoZ3B1L210MTJjZ1NRYk1HVzduTW9R?=
 =?utf-8?B?MU9EcWFSL2pyWFNKamVwdy8rR2QvdHJyWVV3UFBVWFhsODFZNXQ4VXAxSUVo?=
 =?utf-8?B?NUNFRlZ0VVZrQkdWbHBNNHllNmppQ2syUldEalFHM0ZQa3hZRFdIM28zdGpu?=
 =?utf-8?B?R01QSWd3dnZTSjhkMC85c1dheFlqclVoT3dtTkxXRW54bFpFK21aTnRvSnRS?=
 =?utf-8?B?aDRRekpwbmw0WlNadDdLZzdxTkpFQ1hrSHNTcXV5cFRTbE80RHZGVHlJd1JF?=
 =?utf-8?B?RTNWS3I1QlRDWnI4WWRsZngwelRhRzZEU1dndllpSkRlUEJoNENzZTNNN1Fa?=
 =?utf-8?B?SzRVb0c5SnFLUUViRVBDaUJ2WkY0UDNrdi9tc25FTE1qNzV4S1hMUmtkUmRX?=
 =?utf-8?B?Wi90d1NBVXp1eDZyWW1jWDB2ODVpVC9sZUpMUlUyVENyaE05dUxySFJZMnhi?=
 =?utf-8?B?eDRrajd0Y1h0NGlTbmU0SXFBYWVZdmlweG5sM2FZTW9mc2tUMXBzZmdhMGZk?=
 =?utf-8?B?akJOWlEwY2ZTVFA3ak5kZUV1Vk5qdDN3eElZc2tmcjFia2dSRHhHWUVSYjlO?=
 =?utf-8?B?M0VVbUxDR1djMHdrWmN2ekRiYzF1UTM0NEIwTGxaMUJSeU8zZkt0aHdpb1Ri?=
 =?utf-8?B?cEswOWlkSi9SUUo4WTZkQVZQamVoSG0wSVE5TXZSSThTTlcwd2dCellNclMx?=
 =?utf-8?B?b0pKa2lpRktUOUN5ckRYeHNFS2xPYnJtUzRxVmpLcWdNSm5LVGJZanRUWE9x?=
 =?utf-8?B?M1hnSWNHVWgwbGhFZDhmUmMxYUpRaTFMZUZkN2R2OVZ0QWhnUDJaaG0zMmNV?=
 =?utf-8?B?d2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR06MB3424.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e27058b-c6bf-4df8-72b8-08dac7c51d33
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2022 11:24:23.8585
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zuKMoJ5J/sM1NL0ZjIPBSNAaLTH32Z3pD6gNvWTEU3LH97hKp6DGZlV4XtfgvqH1sYLwVN0NF/CVOJ4sm0kGl8Bcf0U8SG1tEO7xjPlPB4Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6195
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVGhvbWFzIEdsZWl4bmVy
IDx0Z2x4QGxpbnV0cm9uaXguZGU+DQo+IFNlbnQ6IFdlZG5lc2RheSwgTm92ZW1iZXIgMTYsIDIw
MjIgNjo1NiBQTQ0KPiBUbzogQW5ndXMgQ2hlbiA8YW5ndXMuY2hlbkBqYWd1YXJtaWNyby5jb20+
OyBNaWNoYWVsIFMuIFRzaXJraW4NCj4gPG1zdEByZWRoYXQuY29tPg0KPiBDYzogbGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZzsgTWluZyBMZWkgPG1pbmcubGVpQHJlZGhhdC5jb20+OyBKYXNv
bg0KPiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPg0KPiBTdWJqZWN0OiBSRTogSVJRIGFmZmlu
aXR5IHByb2JsZW0gZnJvbSB2aXJ0aW9fYmxrDQo+IA0KPiBPbiBXZWQsIE5vdiAxNiAyMDIyIGF0
IDAxOjAyLCBBbmd1cyBDaGVuIHdyb3RlOg0KPiA+PiBPbiBXZWQsIE5vdiAxNiwgMjAyMiBhdCAx
MjoyNDoyNEFNICswMTAwLCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6DQo+ID4gQW55IG90aGVyIGlu
Zm9ybWF0aW9uIEkgbmVlZCB0byBwcm92aWRlLHBscyB0ZWxsIG1lLg0KPiANCj4gQSBzZW5zaWJs
ZSB1c2UgY2FzZSBmb3IgMTgwKyB2aXJ0aW8gYmxvY2sgZGV2aWNlcyBpbiBhIHNpbmdsZSBndWVz
dC4NCj4gDQpPdXIgY2FyZCBjYW4gcHJvdmlkZSBtb3JlIHRoYW4gNTEyIHZpcnRpb19ibGsgZGV2
aWNlcyAuDQpvbmUgdmlydGlvX2JsayBwYXNzdGhyb3VnaCB0byBvbmUgY29udGFpbmVyLGxpa2Ug
ZG9ja2VyLg0KU28gd2UgbmVlZCBzbyBtdWNoIGRldmljZXMuDQpJbiB0aGUgZmlyc3QgcGF0Y2gg
LEkgZGVsIHRoZSBJUlFEX0FGRklOSVRZX01BTkFHRUQgaW4gdmlydGlvX2JsayAuDQoNCkFzIHlv
dSBrbm93LCBpZiB3ZSBqdXN0IHVzZSBzbWFsbCBxdWV1ZXMgbnVtYmVyICxsaWtlIDFvciAyLHdl
DQpTdGlsbCBvY2N1cHkgODAgdmVjdG9yICx0aGF0IGlzIGtpbmQgb2Ygd2FzdGUsYW5kIGl0IGlz
IGVhc3kgdG8gZWFoYXVzdGVkIHRoZSANCklycSByZXNvdXJjZS4NCg0KSVJRRF9BRkZJTklUWV9N
QU5BR0VEIGlzIG5vdCB0aGUgcHJvYmxlbSwNCmJ1dCBtYW55IGRldmljZXMgdXNlIHRoZSBJUlFE
X0FGRklOSVRZX01BTkFHRUQgd2lsbCBiZSBwcm9ibGVtLg0KDQpUaGFua3MuDQoNCj4gVGhhbmtz
LA0KPiANCj4gICAgICAgICB0Z2x4DQo=
