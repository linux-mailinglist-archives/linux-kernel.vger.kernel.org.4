Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7598D694D92
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 18:01:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjBMRBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 12:01:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjBMRBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 12:01:33 -0500
Received: from DM6FTOPR00CU001-vft-obe.outbound.protection.outlook.com (mail-cusazon11020019.outbound.protection.outlook.com [52.101.61.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538FA193E9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 09:01:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MjlXZK4URHHGVgzOI19CoK8y8RRiaUApktpVgNsTZiM7tbe+FTCiqX+tuHV+sVy3nhL96apc2HawDCH/lNZE17prGI6NxdeTBniL2UhSqCD/aBe7eiEKmxsaK+k/kUhZamMhRTtx3V1OOz4U3NguBR1a4LGNvistEZ2aVb6a66oZ3Z/faugFslo4A2oxghPqwzYcoUgw0AVaRRuu1X5IQ2/voXyUD2ZO3z2oV/rWTE7SD+D61xbLVg6+4bwWDPGxWEeg/i96xLPLRZH63xlnva4dhmjgtp75bFrDIef5kxeGTRI/EGoRx1iEvfqRfqZYO4U7fcT9RzyC/Ci4ulOyWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yTbN8871b/DCiVsuhVvVGG61UHWwm9xiFcXXftuQI9I=;
 b=XyMZf/JpX3gPfevPRlOScsGig0MONkWoJsWWKG6l/yM3HR3B6xf0cC49C9IGkZqKM/v683Y5ZrFZ8MSY5DM3+NsaHsjmwNEKs0c+9NBIxuIw1P9BuJe2P0mxfcY6jLv/NxFPzEik8CdfrIEOHFHNXV90cr2zViorgbTLgeVvt0nX0emloYNOcxi+J7ETHb5xrCGWd7iMZ/EplvFEzQYGpUp7dCLE3IRHUJW0Qwyn86dbtYDDX77Jp4gi3dd+2+5CULOx2UkVGddFae7vBjxrE0W+J4pPpw3lPoLNjrEwGplewCxdFT5UBrlFnF+DMul7FWR85XfhujvFlyIOA+8TGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yTbN8871b/DCiVsuhVvVGG61UHWwm9xiFcXXftuQI9I=;
 b=DO59p7aKogIh0tGqxaF32FO7eXGrPAy6XDCAx5n0qqpqHe7OyocwNNkqACnToG3e0/b94V4p8/Q0tfQGAUaK2jCKfGuECCUpCTPPbZcoFWunlJ84uPe5D5s4PTb7rq3QFhppGg7qVN+nd9k8QaFwlWTKNNH6CsVTD8t3uRrphjs=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by IA1PR21MB3712.namprd21.prod.outlook.com (2603:10b6:208:3e3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.7; Mon, 13 Feb
 2023 17:01:29 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::629a:b75a:482e:2d4a]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::629a:b75a:482e:2d4a%5]) with mapi id 15.20.6134.002; Mon, 13 Feb 2023
 17:01:29 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Juergen Gross <jgross@suse.com>,
        Christian Kujau <lists@nerdbynature.de>
CC:     Linux regressions mailing list <regressions@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: RE: [PATCH v2 5/8] x86/mtrr: revert commit 90b926e68f50
Thread-Topic: [PATCH v2 5/8] x86/mtrr: revert commit 90b926e68f50
Thread-Index: AQHZPFdUe0ixXjCLzUqrIEQ/ZgHZXa7IivqAgAPfSICAAF6fgIAATZSAgAAIQ6A=
Date:   Mon, 13 Feb 2023 17:01:28 +0000
Message-ID: <BYAPR21MB1688F89BB288FDC8FCF7C760D7DD9@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230209072220.6836-1-jgross@suse.com>
 <20230209072220.6836-6-jgross@suse.com>
 <9046a3cb-928a-5476-1e72-63bd197c039e@leemhuis.info>
 <129d8c1d-ffa6-dac2-f516-dab4fc8c6218@suse.com>
 <6e4198c2-d79c-8ebd-82f7-3826dd807f1b@nerdbynature.de>
 <f18e315f-bfe2-426d-0ecf-d82fb22a05f4@suse.com>
In-Reply-To: <f18e315f-bfe2-426d-0ecf-d82fb22a05f4@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=fe0c571d-9763-4473-bd8c-1688c2c1fe91;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-02-13T16:53:30Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|IA1PR21MB3712:EE_
x-ms-office365-filtering-correlation-id: f80fe2e5-36f5-4392-4aef-08db0de3f320
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jcIrXFducY34m/ogUeEoZBZo5rsgSV3q91ycWISK7Om3xjXCfa2TV3SfYVtqLZiLibKNWLCz0xuWbwR50pmpcSprQ6Wxb66gVwY3kSvMFMIekA2sDoSeL/aqIoU9Ba1h3E9ZwFqYzhnSMYmid8PUDV/NTbcOPTyiH8eSThu2Bt2jeszqyqen2gD7sh1t9gBFCr3CQgP5avAlg5+8NfjXvh4kE+L0xsKMeLGuTr70tzZEEcM3NEBkRPc6F9v4wn7ivMZcpIpzPepK63cUFx9IX0o/WLZrEde3J9ufiloGKk7OkREIdmWqV5XBJqvkm06uaKuoEiJm98B+EYiXSdXH2YLLbZRGAc5uvellt9rsbIoJGoxC7oOx6TQtrdIccFy96R3bI4KKesfuy8T9f4YcKFtDamb8QpgNjdngbg2oWL85Uu8OPE+mK71kzBDBPVRkpkQnbu5hvr5p/1G4qNahh7gZaiipYYSvF0Nc0ZmoTtAIIdDGVGqfhMV2o3VS6Cqd06tNSdCcOsm5IUEqQSwAaxGoAF8LmDLGu/XcCjIeidKlKs/ZyME+/mplLNE07z4yJpfJz/ZawQSZEoEVa03hKM8ZnkVAmAlqHji4AQAETeXcQRYMDlNngrzqtxqvofLUMPRPmu0KTTj0wzr4q/87oww3VaswulobxcRGV9EgXJRIKRIJY1Unab6yUmmRpJr/KtP7f9YuU//ZqLkQqsFlNpILP04x0Z1uUtElfdsApznwPxPunNS5o/B6aZI8uNbCc8qgb5esGCLlatORVNkgzQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(136003)(366004)(396003)(39860400002)(451199018)(478600001)(316002)(64756008)(8990500004)(71200400001)(7696005)(66946007)(2906002)(41300700001)(186003)(6506007)(53546011)(9686003)(54906003)(8676002)(82950400001)(66476007)(4326008)(76116006)(66556008)(66446008)(8936002)(110136005)(5660300002)(52536014)(7416002)(33656002)(122000001)(82960400001)(10290500003)(38070700005)(86362001)(55016003)(38100700002)(83380400001)(98903001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZlRJTGU4UTFOeGNzS2ZaUjhrcHlpaHNTVXJ4T2dVTDM0MG14VmpDQ0dPZjRC?=
 =?utf-8?B?c1o3NmJRSjNEWUVXYWxoT2ZMRnhONmpuRUZBcVplOURYc3JnYnpYZ01Bc0hB?=
 =?utf-8?B?dFNJNjVKOTlsZFNBcjdBKzZIanFuNDVOZHJXSTdEemU5cFFuQndMQ3BZaUx3?=
 =?utf-8?B?aTlrczBBYVdHN2I2WkJLRXlHVTAxZEV2cUtxOVJ5V0Vab1BtN2xaT3RLQVJ1?=
 =?utf-8?B?SmlodzVtd2tSMHNuUDRUQUVjdXFudnlpbVR0eTRWVW9oTTVMcnI0NEhXSStj?=
 =?utf-8?B?SE9tWnhxSHI5cHFRUUVzVnFXUXhwUVNXVDhOYUJDSjk3ZGNsSkxqMEFyOVQz?=
 =?utf-8?B?dVlIeHJTWFArdjRHRXJjdCt3L1g1UnE1VCthbjJ4SmpQQnpJbkhuWWNVWnFR?=
 =?utf-8?B?blpEODNRSmwzQmVGNDd5b2VVT1F6bFNROHNWUEVUT0prbVd4ZkxZaGFIdUY2?=
 =?utf-8?B?OS9ZUXdpdnJKWVlURjNHaWt5U1lPUGFZeXJoT0E0K2ZlN2NYK09DZnh3cnFR?=
 =?utf-8?B?c1VucWdtMzhRSmVMSkQxbGozL2piamhjdHBMaHMvNnV6cm1aV25LTWJhQzdF?=
 =?utf-8?B?VDg2ZmxFejlJL096dWFET0U5bkJOZ0FyR1RvdzBiZFlET3huQ3k3Ly9RMGxC?=
 =?utf-8?B?T0hUK3pOYWkySlpCeEErOWFZbEdmMjJmKzNQZmJIWlM5ZlJEcll0NVMrcncz?=
 =?utf-8?B?VVhocDRYUzNGRURaeUQwem8wY1pvcThDRTJENzc1NjZvTkQxWThPbXdBV0ZR?=
 =?utf-8?B?eEk5NDV6L1h1TUN2d1pnSm1UZlRLMGNra1VZcGNGbmNrZStWa3F5MGhKQjFa?=
 =?utf-8?B?ZEdXcWg4MHJBVjBXL3JQbDEyeDBTN2NIR1ZYZCtuaWNUOUVuL04xelNFWmEr?=
 =?utf-8?B?OWxoV1hZMHVWWVlmdVVpK0FhSFZoY2FUM1lWNC9mZC9UOFVWdzZHRTBiNmxi?=
 =?utf-8?B?U2FqdFg3NXF0aXlPS09VUG5CY0thMlpjb3JUTGYydWtyYmpWeTV0b0E3QXlo?=
 =?utf-8?B?VDZEVXNQZnFLa0d3RWVQaVNDTjdhNXVPUVhRQVBFWVlSOWVIcmhnODJ1L2U5?=
 =?utf-8?B?bDFGcFUwWEVBR3NoZjB0YkdRWjBvZWxRM3lkZy9VeEhWaVBTK21URmlEWWRX?=
 =?utf-8?B?a3J2VFRId2FoVEV3SCtCQjlJVFp2TUFCdng5dHBCMTJsYlBURi9pbWxzQXRQ?=
 =?utf-8?B?SGRBK3RPV2daWjdNamhJcHRFaElGS2NOQ243UjV6MUc3NlJJaXQ3bVBCUmZB?=
 =?utf-8?B?RnEyKzVqaDlFUmU5MnNjTU0va1VVTmp5M1lsd0tGUGlMUGEyNjA2eVk2bHcz?=
 =?utf-8?B?a3VMSGZwZmtzV1haZkIwMWFmL1phL2dsZCswSFZCN2hHSFZqV29OZExlUlBP?=
 =?utf-8?B?N240VDdzVWdPNzQvTUhvSTcyb2ZNWURsYnNtKzZxTmtwbFZlRU1yWTJNZy9J?=
 =?utf-8?B?RWo0bHR6TG9zM2UrbUoyVUV6UVZjNXVJa2oyTVFvd0tIVlBHalVldlZBU2h3?=
 =?utf-8?B?a0k3OVJuR01rdDlEY3FoZ3FZTjNDUG8vN2RZZ3FPUGFnM1pIU3lDc3RSamVO?=
 =?utf-8?B?a2JaQ2dIM2FRcVBLMkFLOFFnUENVYllEM0RBcS9oZnkza1d6UGF2UDUrR04r?=
 =?utf-8?B?enIxdmVLVXhjbE5PdDM3ZlFDSDR3MytveHJWamtMTm52ejdVTlBpNU1UNHVs?=
 =?utf-8?B?blIvbVY2VjVqUFdjVHdWR3hxd2tUZVIvUXMveFNneEJiZjBNWjd6ckdORisw?=
 =?utf-8?B?djljUTg5TlJENTZ0ZFFPSXZsWC9kcWMyMGErOTdkQW1XL3lrQjg5QnlhZUM5?=
 =?utf-8?B?QWkxWkNjb2FXUzg1VHlxUXpoZG1URGZtLytVUnMxQmphbmN4MGdXV3RReWFU?=
 =?utf-8?B?aGJhMEF3MDZKNyt4aHhuaDkvWWQyV2lFSGxackR3NGkxb1Qzb1ZWQlhvMHJi?=
 =?utf-8?B?cC8zcWczNGFKWkFRL01qaWpvbDVMbHQ4bmdzM0VxR0xCeVd1OVVlc05Oa2tx?=
 =?utf-8?B?WGJyRkl1MW5PaTkyTjBzaFJQVlhMblF1cTE0bjhVdHcwTG9Ha3owTkt1Q1Vp?=
 =?utf-8?B?a1hUZmhvT3BnMWNTUE1ZQ1NEV2ZyT3NTbXc5a1ZsMVBxOFpqZVNRMWlqcWF5?=
 =?utf-8?B?c0g0YnJnU21YQmV6OExIYmJTalNNYVkwdjhINW1tOFM2bmlGVytKYXFUbnBZ?=
 =?utf-8?B?V1JxNTRhdDV1akFaL0NDVkFmcGZLV3RSVjZ5cXdoUWF3b3lLR1FIZERNYVZ0?=
 =?utf-8?B?YTEvMVR2Q3hTT0RJVytIajRCbnhRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f80fe2e5-36f5-4392-4aef-08db0de3f320
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2023 17:01:29.0305
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QG1RtuA1jc0nnYQdzLfoZF7z5m5Rpjm8pjDvYdae1FNqDijTblVzXNvup4neo+gfwDl6Q78WpWL/EFXk4VxcsjBVfqc/g36XQ5OfnmZPp1k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR21MB3712
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogSnVlcmdlbiBHcm9zcyA8amdyb3NzQHN1c2UuY29tPg0KPiANCj4gT24gMTMuMDIuMjMg
MTI6NDYsIENocmlzdGlhbiBLdWphdSB3cm90ZToNCj4gPiBPbiBNb24sIDEzIEZlYiAyMDIzLCBK
dWVyZ2VuIEdyb3NzIHdyb3RlOg0KPiA+PiBPbiAxMC4wMi4yMyAxOTo1OSwgTGludXggcmVncmVz
c2lvbiB0cmFja2luZyAoVGhvcnN0ZW4gTGVlbWh1aXMpIHdyb3RlOg0KPiA+Pj4gSGksIHRoaXMg
aXMgeW91ciBMaW51eCBrZXJuZWwgcmVncmVzc2lvbiB0cmFja2VyLg0KPiA+Pj4NCj4gPj4+IE9u
IDA5LjAyLjIzIDA4OjIyLCBKdWVyZ2VuIEdyb3NzIHdyb3RlOg0KPiA+Pj4+IENvbW1pdCA5MGI5
MjZlNjhmNTAgKCJ4ODYvcGF0OiBGaXggcGF0X3hfbXRycl90eXBlKCkgZm9yIE1UUlIgZGlzYWJs
ZWQNCj4gPj4+PiBjYXNlIikgaGFzIGludHJvZHVjZWQgYSByZWdyZXNzaW9uIHdpdGggWGVuLg0K
PiA+Pj4+DQo+ID4+Pj4gUmV2ZXJ0IHRoZSBwYXRjaC4NCj4gPj4+DQo+ID4+PiBUaGF0IHJlZ3Jl
c3Npb24geW91IHJlZmVyIHRvIGlzIGFmYWljcyBvbmUgSSdtIHRyYWNraW5nWzFdIHRoYXQgd2Fz
DQo+ID4+PiBpbnRyb2R1Y2VkIHRoaXMgY3ljbGUuIFRoYXQgbWFrZXMgbWUgd29uZGVyOiBjb3Vs
ZCB0aGlzIHBhdGNoIGJlIGFwcGxpZWQNCj4gPj4+IGRpcmVjdGx5IHRvIGZpeCB0aGUgaXNzdWUg
cXVpY2tseT8gT3IgYXJlIHBhdGNoZXMgMSB0byA0IG5lZWRlZCBhcyB3ZWxsDQo+ID4+PiAob3Ig
dGhlIHdob2xlIHNlcmllcz8pIHRvIGF2b2lkIG90aGVyIHByb2JsZW1zPw0KPiA+Pg0KPiA+PiBQ
YXRjaGVzIDEtNCBhcmUgbmVlZGVkLCB0b28sIGFzIG90aGVyd2lzZSB0aGUgaXNzdWUgY2xhaW1l
ZCB0byBiZSBmaXhlZA0KPiA+PiB3aXRoIHBhdGNoIDUgd291bGQgc2hvdyB1cCBhZ2Fpbi4NCj4g
Pg0KPiA+IFRoZSAobGFzdD8pIC1yYzggdmVyc2lvbiB3YXMgcmVsZWFzZWQgeWVzdGVyZGF5LiBX
b3VsZCBpdCBiZSBwb3NzaWJsZSB0bw0KPiA+IGluY2x1ZGUgYXQgbGVhc3QgKG9ubHkpIHRoZSBy
ZXZlcnQgaW4gbWFpbmxpbmUgc28gdGhhdCA2LjIgd2lsbCBiZQ0KPiA+IHJlbGVhc2VkIHdpdGgg
YSB3b3JraW5nIHN0b3JhZ2UgY29uZmlndXJhdGlvbiB1bmRlciBYZW4/DQo+IA0KPiBIbW0sIHRo
aXMgd291bGQgbWFrZSBIeXBlci1WIFNFVi1TTlAgZ3Vlc3RzIHNsb3cgYWdhaW4uDQo+IA0KPiBJ
J20gbm90IGNvbXBsZXRlbHkgYWdhaW5zdCBpdCwgYnV0IE9UT0ggSSdtIGEgbGl0dGxlIGJpdCBi
aWFzZWQgYXMgdGhlDQo+IG1haW50YWluZXIgb2YgdGhlIFhlbiBjb2RlLiA6LSkNCj4gDQo+IE1p
Y2hhZWwsIHdvdWxkIHlvdSBzZWUgbWFqb3IgcHJvYmxlbXMgd2l0aCBkb2luZyB0aGUgcmV2ZXJ0
IGJlZm9yZSBoYXZpbmcNCj4gdGhlIGZpbmFsIHBhdGNoZXMgZm9yIGZpeGluZyB5b3VyIGlzc3Vl
LCB0b28/DQo+IA0KDQpJJ20gT0sgd2l0aCBkb2luZyB0aGUgcmV2ZXJ0LiAgSXQncyBwcm9iYWJs
eSB0aGUgcmlnaHQgdHJhZGVvZmYgZm9yIHRoZQ0KYnJvYWRlciBjb21tdW5pdHkgYmVjYXVzZSB0
aGUgSHlwZXItViB1c2UgY2FzZSBpcyBtb3JlIG5hcnJvdyBhbmQNCnJlcXVpcmVzIG1vcmUgY3Vy
YXRpb24gZm9yIG90aGVyIHJlYXNvbnMuICBUaGUgdXNlIGNhc2UgaXMgdGhlIEF6dXJlDQpwdWJs
aWMgY2xvdWQsIGFuZCB3ZSBjYW4gcHJldHR5IG11Y2ggbWFrZSBzdXJlIHRoYXQgb25lIG9mIHRo
ZSBzb2x1dGlvbnMNCmlzIGFwcGxpZWQgdG8ga2VybmVscyB1c2VkIHdpdGggU0VWLVNOUCBpbiB0
aGF0IGVudmlyb25tZW50Lg0KDQpNaWNoYWVsDQoNCj4gPiBPdGhlcndpc2Ugb25lIHdvdWxkIGhh
dmUgdG8gY2FycnkgYXJvdW5kIHRoYXQgc2luZ2xlIHJldmVydCBtYW51YWxseSB1bnRpbA0KPiA+
IHRoaXMgcGF0Y2ggc2VyaWVzIGhhcyBsYW5kZWQgaW4gbWFpbmxpbmUsIG9yIGNvbnZpbmNlIGFs
bCB0aGUNCj4gPiBkaXN0cmlidXRpb25zIHRvIGRvIHNvIDotXA0KPiA+DQo+ID4gQW55d2F5LCB0
aGFua3MgZm9yIGZpeGluZyB0aGlzIHByb2JsZW0sIEkgZGlkIG5vdCBleHBlY3QgdGhpcyB0byBi
ZSBzdWNoIGENCj4gPiBjb21wbGljYXRlZCBpc3N1ZSB3aGVuIEkgcmVwb3J0ZWQgdGhhdCB0aGlu
ZyA6LSkNCj4gDQo+IFllcywgSSBoYXZlIG9wZW5lZCBhIGNhbiBvZiB3b3JtcyB3aXRoIG15IE1U
UlIvUEFUIGRpc2VudGFuZ2xpbmcuDQo+IA0KPiANCj4gSnVlcmdlbg0K
