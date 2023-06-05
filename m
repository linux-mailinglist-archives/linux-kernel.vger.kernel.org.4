Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98FEC72273F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 15:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234026AbjFENV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 09:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231882AbjFENV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 09:21:56 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D295A6;
        Mon,  5 Jun 2023 06:21:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UgVzf7LFJ9aNRiHGBKug8zWlL2YtcxdXZMc8nj/LkH36Mu0Hrh1hW+maNzlWa/nK6mWb1Q5wrrGXrWxinCO/dQ+bRqh+E/3z+WyjYq4VOFdTU4kTyMewcJ45IYydrJfIAk/ggZJMsHTBvkhH4T+Gt0SRAiZu1UREfigIjaeCW/CqiiueYeI1XhyxOuBc5YXk5IMN8Pm1llkoDuwJgiwRaP7Ux2zW+QsRT88IQaalZ4sQdj/CEZcEC50ekWaT1Q95LLbv7GRmUmhIJNjkAzoJTByZ0Bic4eWceqQ79O1o60yj0isNKnVMor+RuvQPqXD7w9gTv0vfr1rShJyN0wvACg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YwSKyOfdzBo1uAfnE7zgfS1AbcwbpmATaa++9CDquSU=;
 b=SRGJtu5Vc9w0b7T2ODfxAQGKhBqXASCC4H/H+9yVoCESFpAw09Pf8q0j4bXVia+/hSCt6zPtH18DJ2kSuB8SIjy4w2euJqcbu0irikAtNIWdu7X/z1LDHaCuVtgfVZCFpImPeh6eP2OLua9IxbADG+xOqjjIXB4vQECBW6AjLz8UvvsH8Kjhq3suHE2Zh0cX8QPWH8Khi5i68lMt0Us4zcsliQ0nsIffWO9L1GAB1KB7lsWLM0IGUU3ZZs8wqEx3wkvG5yzExcBbTQ5AXod6zqQLTdczjk5JZZg4wKqqST0j6rAJI4ukcwKvjTk/nsZBtxm15BGFLSpZTrnDKcfm8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=infinera.com; dmarc=pass action=none header.from=infinera.com;
 dkim=pass header.d=infinera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YwSKyOfdzBo1uAfnE7zgfS1AbcwbpmATaa++9CDquSU=;
 b=TMFVIOLZDHcs5KmMz/evun3JUwLuzMmTL25bgY2lRsozMQs968vC+8+NHpqiDuxWw9inj5VJWOKZONp8LrhNfmk4Uod7ebJyWLO2vQ4rDuJa0u3NZ1KQjCKEqJMXME0JuIGSSSjDWeNTnMV6Pe69rmMjEx+ysnLM4ikoZriK4DQSJej23WN80tmSNKUdV3DG2k8sfnK9DZYToveZMAbulNF8ybfbHG+48mOKuwFidAWUxVvOBjE5TFI0H/3obrUCoR0diRGf2Xd7IHuD6kvj673q2BuPQjkKKeQc66JHfbjOp2rrn6yAZ7o2dq1mz+z7xTamaW6lMDnSYQ26hxjIag==
Received: from PH0PR10MB4615.namprd10.prod.outlook.com (2603:10b6:510:36::24)
 by BLAPR10MB4851.namprd10.prod.outlook.com (2603:10b6:208:332::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Mon, 5 Jun
 2023 13:21:52 +0000
Received: from PH0PR10MB4615.namprd10.prod.outlook.com
 ([fe80::f01a:585:8d6:3d3c]) by PH0PR10MB4615.namprd10.prod.outlook.com
 ([fe80::f01a:585:8d6:3d3c%6]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 13:21:52 +0000
From:   Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To:     "tiwai@suse.de" <tiwai@suse.de>
CC:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "perex@perex.cz" <perex@perex.cz>,
        "michael@ralston.id.au" <michael@ralston.id.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Subject: Re: [PATCH] ALSA: usb-audio: Fix "cannot set freq 48000 to ep 0x3"
 msgs
Thread-Topic: [PATCH] ALSA: usb-audio: Fix "cannot set freq 48000 to ep 0x3"
 msgs
Thread-Index: AQHZlIqVywGBgPuStUSeT/ugy2IRmK92AXUAgAXXGQCAAF+9gA==
Date:   Mon, 5 Jun 2023 13:21:51 +0000
Message-ID: <892df5be364e29f776ac8db2dd9e928de5a2f2a4.camel@infinera.com>
References: <20230601131116.1014250-1-joakim.tjernlund@infinera.com>
         <202bbbc0f51522e8545783c4c5577d12a8e2d56d.camel@infinera.com>
         <87pm6aicin.wl-tiwai@suse.de>
In-Reply-To: <87pm6aicin.wl-tiwai@suse.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=infinera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB4615:EE_|BLAPR10MB4851:EE_
x-ms-office365-filtering-correlation-id: ed96e288-9dd2-4c02-c5dd-08db65c7d343
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OEwCH/YHPJ3b7Y8wtegWS3zS+3i/q4eO0rYcpBX0Jbv3+MLCvOYz0IiDZhweVAf/qtd6KnpnVVwJHklgoIw2DZeJUhlHd0LuXnUgLG3ip28MECxw6Aj6SAiifYv+vr5utxN3katktgdpplt92g839F9uP7y92To7F06UTYvszl5dC6p0gg4HUk21qxRfit6jpUvkjVLnfQ2PD4lRhgdHc9wCgHQEVZxNfG1nWBCiSh4YnfNDBX7YkucFC+0uwHwHS4qcVakNjB396Hc98Pd5pfYrkSNJlFQsrZt402IHeOcJ9WkeWzlENt4vCcbJMDyHchb6QALQDdXEAP/vwHP0RvFx3Ab7nmyHtT6E6DEeV/sVYFpQpBRPLI7D+bsqMFpeVIMLe63qpCLqQTtO/GZumb9Bt7Abwq8ORWypxDdT3CquJtsWFQdOoWk/UwNUWSQDlLiZVZ/O8nZ0TpA25xB9qnudmZ8VudhFbc97UWFyvheSJPoJOl3pTWH7dV49nKR9J2P/Alxdczjs3EEDWMo5Tz8Gm+2Pzyf31Lr2ko1NYDZ9Ozd5fvBlMKsJCUGa37A9ayPdjfrK6gpKBFE0k0GNSzWYW0wr2UhR+fBL+hKL7eqjwXYF7sX4M9DRaHrf7V2x
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4615.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(396003)(346002)(376002)(39850400004)(451199021)(6512007)(6506007)(36756003)(83380400001)(86362001)(38070700005)(122000001)(38100700002)(186003)(2616005)(41300700001)(54906003)(2906002)(478600001)(76116006)(66946007)(91956017)(66476007)(66556008)(66446008)(64756008)(6916009)(4326008)(8936002)(8676002)(316002)(5660300002)(6486002)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SEJrMHhuMG82RE8yNjhiOXhMTlp0ODdiUkUvTmRET080OXIzdW5tZlkwcnB0?=
 =?utf-8?B?S2c2M21FNzlaSlR1SUlFakRSNSs0UEJJNEhDbU8wK3FaQ3JpYWRrclViaWkv?=
 =?utf-8?B?RUZ0N3FjOTNIaTRiLzZrSVV1VGtESVU4UGt4R25oSWJTeVBaSm5jTG80STlG?=
 =?utf-8?B?MlUrVkwrM0FaS1puV2lUc0pYUC9NcW43d2FGd1F2bDhuMTdpamhaa1kwZDI3?=
 =?utf-8?B?RERBYmxvTU43QkdOeEVFSUx3RjBFcklpTWh3R0hPSk9nN2pYNjF3YzZMUHo4?=
 =?utf-8?B?R1ZVR1d1L3NKK1N1MnlVMWdMeUwyQStmN3Y4ZWpqR05VS1BvZXhSclhpcENE?=
 =?utf-8?B?MEJtRk9CSDJzdXdyUDVQTWZyLy90SmpFM2ZYOFJCNC94ZytWb1hvbkY4b0hR?=
 =?utf-8?B?RUx1eGxIa0ovaUN0aXM4NnJQYlZOY0xUckt0T0t4UnBZYVhwSjRnaDB6VnNo?=
 =?utf-8?B?R2srSFBGQ2w0VDZidUtaUk5KelhpVjNSaHU3NWlGbTM4RnprVHVObGl3VVF4?=
 =?utf-8?B?NTN0MXdMeWt5THhDZ0JGU3dXUmN4UDZwemN3ZGMyZWVPL1UyVkZUUDhQYWZM?=
 =?utf-8?B?QjdSQnlKU1VCSGJDNEVJT3M2TkhIcTZpb0hUSEZOd2trK0dHOGF1RW51Njh2?=
 =?utf-8?B?Sm1JQ0YwWldVTG9Dc3J6TTA5bU4vT2RWTFpkcUtZTW5uc21TdG4zclV4aVRR?=
 =?utf-8?B?S0twMTdWaXVwOXdCeGtIdzdCdEh1YTE0TlUrYzVPOUVaWUNYeVF2UnoyS0FP?=
 =?utf-8?B?aG1idWxjUThTOFBNQTF4Zml5d290YnFZeTFuNmkxelBWUUtsVGY1OFNmdTJP?=
 =?utf-8?B?STVKcGFYVXo5UU1BaXZ6ZVgybUpDR0VISWxjWlZzQnNTMGY2U0lZc3pKYmVm?=
 =?utf-8?B?S2JQN096TE1OWFhYR2lvVFVFeFZ1ZXd4SkcyVXdKeEJ3M0hmSXpvcm9kMmxz?=
 =?utf-8?B?UmYwa0VmcWlmQWJRdEYyTEVEMFZ6MkRLWW5MZ2xkZHlWSGhxN2g0eVBnUmdZ?=
 =?utf-8?B?KzYzSGt0VzBaTlU0cGNzU1ZsbjlvMWd5SllZTnk2M1NnNGIxZzZYdlhoa0wr?=
 =?utf-8?B?Vi9wSWxzaW5ib1NJUkxHKzFmQS9EZUdTNWJvTFJsTXdYRHJMb0VaSFNMY2NC?=
 =?utf-8?B?SUJuZWl6YkcxUXAwS3IybDZJcDdFOWNtQllkRStOU25qN0pnMkJFeVJPdHZG?=
 =?utf-8?B?dFdnbHJYUTMzRFJESnVhYURtOVhMQzh1VUpBUStFeWFXaTJ4c0F0OCtrQ2lq?=
 =?utf-8?B?TEoyNUZSdzlKS1B0ZVRYdnFiYjlSNWxKSGZ6dnhzYjVNdG16SXQyTnFzTEhi?=
 =?utf-8?B?NS9kWDlRcHhrNGFWSTVEMnFsdUxGc2ViOXk1aC80bVd6OVZyWitFYXlOcnNN?=
 =?utf-8?B?cTdlTGVRQ2FRaEpEd0ZtR3dobkRLb3JpSExrdnVGMjZBdm9hNjVzb3FMMVRl?=
 =?utf-8?B?bTc5ZmJLd3c3NlhkOXpzYW9DbW95cFF1V0hlazZPU2ZvWFlHbGluMUd6eURx?=
 =?utf-8?B?aFB4dktuQjZLc0FsZW1GVkdqVWR6VG1jV1p4aWdpTkpmMmZ2aG1LcHlxRjQ1?=
 =?utf-8?B?RW9zbklqeDlMM2FJSDhqZTVYMXNCTXFuZ2k3YUdFRUhlSzk1WFNUVmRabEJx?=
 =?utf-8?B?dG1ySUt3ZmVBUW1YZkNsWGtaQWdkMzh2dnBjQUU3SHA0SFEyYnBuSWdSYVZ4?=
 =?utf-8?B?bmdUdTVYRXhZcVpvU1BTQThsQzBGYW9LNm9ud1RXajVrMzlDVjhVS3AxYkJv?=
 =?utf-8?B?cGFPT3JSN244ekR2dFlaWWNpQUNvT1poa3J0R3duTEIzbmdFc3RuSjVQTFhm?=
 =?utf-8?B?OWdkSldRdEs1blIrZUQvRTZBVW5yQmlWVSttajFoYkptMVVsaGVCZTdZcWVm?=
 =?utf-8?B?YzkrTVlIWWdGTzhxZ1BaTktnclZxMmpUYVdHUTh4OTRwUzB1bGV6b29mMzZn?=
 =?utf-8?B?blNDTjIrMkV1RXd6Y09lczhVOUtCWXg1WllrSW9MWDZDSEthUTJzYXk3VkNV?=
 =?utf-8?B?S3h3dEFjazRhSnJhL2NpamJXb2JvVnIxVWduOVdjSnRmNmxBK0VHRXpsQjB1?=
 =?utf-8?B?OUN4QTlMRDhzT3VrOHRrT2w2RnlzM0NFemxtTVAzWEdGbWpOK2VwaGZmTk5D?=
 =?utf-8?B?STd6UWszOFZVM2t0aW5pRVRBRmloWGxLbTFGNjVVRWZVajNGM2VEOXJ1cjlw?=
 =?utf-8?Q?SHXxwN+Ubw66sLz0YtFIyAUyeLwl8CdlLJhiuTNZ69cb?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DDB18C49CEF24248941DFC7B8C3BAF38@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4615.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed96e288-9dd2-4c02-c5dd-08db65c7d343
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2023 13:21:51.9994
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zXAqwddihc3EpAQ1A+o0Hkxp+a0aR0P4MZFXq13dWgUaKviteIE8qL0rwSF8IMOMZO18VkObmdpW9v9+R0+14A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4851
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTA2LTA1IGF0IDA5OjM5ICswMjAwLCBUYWthc2hpIEl3YWkgd3JvdGU6DQo+
IE9uIFRodSwgMDEgSnVuIDIwMjMgMTY6Mjg6MDUgKzAyMDAsDQo+IEpvYWtpbSBUamVybmx1bmQg
d3JvdGU6DQo+ID4gDQo+ID4gQWRkaW5nIE1pY2hhZWwgUmFsc3RvbiA8bWljaGFlbEByYWxzdG9u
LmlkLmF1Pg0KPiA+IA0KPiA+IEhlIGRpZCBoYXZlIHByb2JsZW1zIHdpdGggaGlzIGJlaHJpbmdl
ciBVTUM0MDRIRCBkZXZpY2Ugd2hlbiB0aGlzIHdob2xlIHNlcS4gd2FzIHJlbW92ZWQuDQo+ID4g
UmFsc3RvbiwgY2FuIHlvdSB0cnkgaWYgdGhlIGJlbG93IGNoYW5nZSBhZmZlY3RzIHlvdXIgZGV2
aWNlPw0KPiANCj4gU29ycnkgZm9yIHRoZSBsYXRlIHJlYWN0aW9uLCBhcyBJJ3ZlIGJlZW4gb2Zm
IGluIHRoZSBsYXN0IHdlZWtzLg0KDQpOUC4NCg0KPiANCj4gVGhlIGNvZGUgc2VxdWVuY2UgdGhl
cmUgc2VlbXMgcHJldHR5IHNlbnNpdGl2ZSwgYW5kIHN3YXBwaW5nIG9yDQo+IGRyb3BwaW5nIHRo
ZSBjYWxsIG1pZ2h0IGJyZWFrIHRoaW5ncyBlYXNpbHkgb24gY2VydGFpbiBkZXZpY2VzLA0KPiB1
bmZvcnR1bmF0ZWx5LiAgU28sIEkgZ3Vlc3Mgd2UgY2FuJ3QgdGFrZSB0aGUgcGF0Y2ggYXMgaXMu
ICBJZiBhbnksIHdlDQo+IG5lZWQgdG8gZmlkZGxlIHRoZSBjYWxsIG9yZGVyIGRlcGVuZGluZyBv
biB0aGUgZGV2aWNlIHF1aXJrIG9yIHN1Y2guDQo+IEkgZ3Vlc3Mgd2UgbWF5IHRyeSB0byBmaXQg
d2l0aCB0aGUgZXhpc3RpbmcgcXVpcmsgZmxhZy4gIExldCBtZSBjaGVjaw0KPiBpdCBsYXRlci4N
Cg0KeWVzLCB0aGlzIGlzIHRyaWNreS4gVG8gbWUgaXQgbG9vayBsaWtlIHRoaXMgY29kZSB3aWxs
IGFsd2F5cyBzZXQgNDgwMDAgc2FtcGxlIHJhdGUgYW5kDQpub3QgYWxsIGRldmljZXMgc3VwcG9y
dCB0aGF0IG9uIGFsbCBFUHMuDQpNYXliZSBvbmUgY2FuIGdldCBhd2F5IHdpdGggbm90IHNldHRp
bmcgc2FtcGxlIHJhdGUgYXQgYWxsPyBKdXN0IGd1ZXNzaW5nIHRob3VnaC4NCg0KIEpvY2tlDQoN
Cj4gDQo+IA0KPiB0aGFua3MsDQo+IA0KPiBUYWthc2hpDQo+IA0KPiANCj4gPiAgSm9ja2UNCj4g
PiANCj4gPiBPbiBUaHUsIDIwMjMtMDYtMDEgYXQgMTU6MTEgKzAyMDAsIEpvYWtpbSBUamVybmx1
bmQgd3JvdGU6DQo+ID4gPiBPbiBzb21lIFVTQiBzcGVha2VyIGRldmljZXMoSmFicmEvTG9naXRl
Y2gpIHdlIHNlZSBhYm92ZSBlcnJvcg0KPiA+ID4gbXNnIHdoZW4gY29ubmVjdGluZyBkZXZpY2Ug
dG8gY29tcHV0ZXIgYW5kIGtlcm5lbCBpcyBwcm9iaW5nIHRoZSBkZXZpY2UuDQo+ID4gPiANCj4g
PiA+IE1vdmluZyB0aGUgc25kX3VzYl9pbml0X3NhbXBsZV9yYXRlKCkgdG8gYWZ0ZXIgdXNiX3Nl
dF9pbnRlcmZhY2UoKSBtYWtlcw0KPiA+ID4gdGhlIGVycm9yIGdvIGF3YXkuDQo+ID4gPiANCj4g
PiA+IFNpZ25lZC1vZmYtYnk6IEpvYWtpbSBUamVybmx1bmQgPGpvYWtpbS50amVybmx1bmRAaW5m
aW5lcmEuY29tPg0KPiA+ID4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gPiA+IC0tLQ0K
PiA+ID4gIHNvdW5kL3VzYi9zdHJlYW0uYyB8IDIgKy0NCj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gPiA+IA0KPiA+ID4gZGlmZiAtLWdpdCBh
L3NvdW5kL3VzYi9zdHJlYW0uYyBiL3NvdW5kL3VzYi9zdHJlYW0uYw0KPiA+ID4gaW5kZXggZjEw
ZjRlNmQzZmI4Li5kOWFjODY2M2E0OGIgMTAwNjQ0DQo+ID4gPiAtLS0gYS9zb3VuZC91c2Ivc3Ry
ZWFtLmMNCj4gPiA+ICsrKyBiL3NvdW5kL3VzYi9zdHJlYW0uYw0KPiA+ID4gQEAgLTEyMjYsOCAr
MTIyNiw4IEBAIHN0YXRpYyBpbnQgX19zbmRfdXNiX3BhcnNlX2F1ZGlvX2ludGVyZmFjZShzdHJ1
Y3Qgc25kX3VzYl9hdWRpbyAqY2hpcCwNCj4gPiA+ICAJCS8qIHRyeSB0byBzZXQgdGhlIGludGVy
ZmFjZS4uLiAqLw0KPiA+ID4gIAkJdXNiX3NldF9pbnRlcmZhY2UoY2hpcC0+ZGV2LCBpZmFjZV9u
bywgMCk7DQo+ID4gPiAgCQlzbmRfdXNiX2luaXRfcGl0Y2goY2hpcCwgZnApOw0KPiA+ID4gLQkJ
c25kX3VzYl9pbml0X3NhbXBsZV9yYXRlKGNoaXAsIGZwLCBmcC0+cmF0ZV9tYXgpOw0KPiA+ID4g
IAkJdXNiX3NldF9pbnRlcmZhY2UoY2hpcC0+ZGV2LCBpZmFjZV9ubywgYWx0bm8pOw0KPiA+ID4g
KwkJc25kX3VzYl9pbml0X3NhbXBsZV9yYXRlKGNoaXAsIGZwLCBmcC0+cmF0ZV9tYXgpOw0KPiA+
ID4gIAl9DQo+ID4gPiAgCXJldHVybiAwOw0KPiA+ID4gIH0NCj4gPiANCg0K
