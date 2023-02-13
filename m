Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D659693E72
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 07:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjBMGnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 01:43:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjBMGnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 01:43:33 -0500
Received: from BN6PR00CU002-vft-obe.outbound.protection.outlook.com (mail-eastus2azon11021027.outbound.protection.outlook.com [52.101.57.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0422330EB
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 22:43:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BColX/BcuLziDsRUKjBTnhgmtR+TwhyT4RR4SruApWSpFyV0KLwlbMvIxVK6+K5pEefl6mGtFSuAq31jNrU5HS0vQrBFUWr74t3bmUQS0GpzL8zgDQv+gbow8Ma+0euNtLNwqIMYY1T0FVzsEUydBZbCfMRXg2QWuvOcT2WB2QekEbye++EBGGo63e+FdCzE8Xd5N/0CFQhUGxj0UGYoKeANewpLd+8Yom2zCSyRMeW5pAjbk5qf0rQWYsjzV6b5ulwabUnJ3zddyUeuIdTASbBU8FcwQY4mjbThB91FhVjyqDl+Gvu/l1OPERuzsMLrZvp5DuP8zhs6antFXShlaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GducfhtaMEbpyj924tg+jCydlka+sphLYG1T6rWfAbA=;
 b=dOuAU+0qPtUqtq+r3oftAWSh/VxurTeC3k74SfCL1RhzIkelWdpagBA9uo+CSH0rFFAicVeHzKWwEkaXe+jS4Rs1OhrZ6T0xs6v49u80Q9XmpPFQi6RueR8Qko/GuiGARXx/mWO662+919FdZwWyKIAAu98UNBGITTsPXSwbs2T1T6GwmkVttBDU6p5BnIGb90J71VYbkJ1uE/2pdbwR/TzMHt3mLMCHEw7d6/EEpPyYW+VikPxg8kERnVv3RUvtmhe3RWo3+cpZhW5hBG7cmWpaK/0aCUO7jgPNHBXNwmAQAvKiObrhHiBIGIsOvHjlyhEbbxDR5P3K+5JHCxQTBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GducfhtaMEbpyj924tg+jCydlka+sphLYG1T6rWfAbA=;
 b=TBbkvhA+CoM7ivZRtYbGeEPfIlGq1w/riwK2i0Bxtww5cOVWGuTUceZtjDIxCNIS8uitMmq1hKNQsLzb5GjKpV3pLMBfbkb+k0pAyMQVsLoH85FMQhEx/g+9VL2nJQC05B4QT7O4uXNsChqR5KtWY/PZ9iQJzDT3tgEV46Ky4sE=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by PH8PR21MB3835.namprd21.prod.outlook.com (2603:10b6:510:216::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.6; Mon, 13 Feb
 2023 06:43:29 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::55a1:c339:a0fb:6bbf]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::55a1:c339:a0fb:6bbf%8]) with mapi id 15.20.6111.007; Mon, 13 Feb 2023
 06:43:29 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Juergen Gross <jgross@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "lists@nerdbynature.de" <lists@nerdbynature.de>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: RE: [PATCH v2 2/8] x86/mtrr: support setting MTRR state for software
 defined MTRRs
Thread-Topic: [PATCH v2 2/8] x86/mtrr: support setting MTRR state for software
 defined MTRRs
Thread-Index: AQHZPFdKu6v3b+HaGE2yB6PHNlodO67LulNAgAC1eACAAAQ60A==
Date:   Mon, 13 Feb 2023 06:43:29 +0000
Message-ID: <BYAPR21MB1688BC49C00AA08306DEC2BFD7DD9@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230209072220.6836-1-jgross@suse.com>
 <20230209072220.6836-3-jgross@suse.com>
 <BYAPR21MB168857905915E00B29BAFC7ED7DD9@BYAPR21MB1688.namprd21.prod.outlook.com>
 <b568c7e0-553c-4747-32c2-d2a25309f2d4@suse.com>
In-Reply-To: <b568c7e0-553c-4747-32c2-d2a25309f2d4@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0baaff60-78b1-43bb-9ed6-23fdab65b201;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-02-13T06:42:33Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|PH8PR21MB3835:EE_
x-ms-office365-filtering-correlation-id: 00dab603-8b89-4b05-381c-08db0d8d9dd0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EPTDOLMfTcT1Is2TEBMczmQHaS14IL3xybfiG4kFSH4jjH7iu0jTpaKKa7OC1JqbKsB189c3sVBkyGaqoNg7nt+5N4apbvE5sdMsnYgBxwUXxnyJc3rSBrTTOVDH3x7zEat88HqgnnC2usa/KoNZ2HvAYXImI1TgLIgBfyzTTIUJiFFsOAZ5TRrxdTG1F6krL4ZZQB2lCGFx+wQ8fCsvqd1CMO9Ix+JvYMUluvchZ6KZntHbO+5oY8iCxDzI8inb8gl4wpyGWaUndx4MFzeZSpXPsnIdBdXfZP1yJ16vM2xVa/6UqLJ3Bw6/11j5ftmlI7S43lx//6Rti7lqICKtPlInoTaMEpCZKW+XfVpTPt+yOY8CcXsDFqzVC4hWfjXW8ZfZbHcH/+f2KDDhxuzxHx16HQGfmUqAkQE14lUXcXmOLbBX2PRTdd1Z6TEiLqRKa46sVGpf9tNbIZjh8TOwX/u3nxZtX+UGLXGKSyQG5JaXo43yCJHQg8IlBzHm7/UxXBNO0x/aRRs/jmi3qwGY+iE0Dhjup0KH8Cbf4RHf5J59xVVDvovHlQYyGzv7TmoKUQUgvMBFn6PC1MKL6yPPmYhHVjALoJVnpYZlblacxjzxbpA/ffm6aX2Ojh7W1ygm/GhS3bTH0/gOgEeRa2AjjL8kGLlT18tiKWmKHZk3C/ktNy9wtlbIStb1FhNqMGUEWkn3lWRK3RMmfYLc/I/kKVGclYV1LmabWh7wJ4fireETl9m2gmLmI4usKunrbR59
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(396003)(376002)(366004)(39860400002)(451199018)(38070700005)(6506007)(53546011)(55016003)(9686003)(186003)(86362001)(4326008)(66946007)(64756008)(66446008)(66556008)(66476007)(8676002)(8936002)(33656002)(5660300002)(41300700001)(76116006)(52536014)(71200400001)(7696005)(110136005)(54906003)(83380400001)(10290500003)(2906002)(82950400001)(82960400001)(8990500004)(478600001)(38100700002)(122000001)(7416002)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QWtBWkJhS1N4YjV1WG96Vnc1RGVoNVJNUUZJc2FEVWlLZThjK08zVEVUMVQ0?=
 =?utf-8?B?dnY3OENRK0REakVPQjdwS1pycXR2RUdNMzQ5dkNDTThRNCt6NEtGdjRtNWJQ?=
 =?utf-8?B?MERFQllReURxbjBEd3ZLWTU0Q1JncDVldzE4R3J2UE9RcFpVRHpHZ2xoamVV?=
 =?utf-8?B?WGtOcjR0ZFF1SVNQOHpXSlNpeGRrNkRJbTBNKzdPTmdlci9ET0tlRVM2T3FX?=
 =?utf-8?B?ODQrRnlMR3liNWtZbnBLdlZPTVd2R0hpS3EvZllEUXRBd1NrV3V0eVpJSWRj?=
 =?utf-8?B?eU9Vd0U1aVZZQzdENU81MFF6YU5DdU5DNGNrU0srU3gwWHlnSXgrdStLbmo0?=
 =?utf-8?B?NVNDWU5hSzIzNU1DYkU3K2d5UVRvUnUrdUt6L3p5citEdEpQQWpETThYZEdz?=
 =?utf-8?B?dzBhY0VWMS9EU1c3VFhRNXZFSnVta0phRTJhV3JGa0ZDbGhXOHVCcnZOV3k0?=
 =?utf-8?B?QVdTbWRKNHBtUEFadzA0Y0dCS091N0ErVk9DWnJLOTByYkJkRWZ3Nk01anFs?=
 =?utf-8?B?RHVnMzdDdUxoQVhCZmRDdEJQOHMyWmlESTgwYVVEdVo2alRVZ3cxWlU4QVhh?=
 =?utf-8?B?aDhwOW5FME9PbEk3a3hrYU1UdFRnVllrclVxR3U5RTJQTXpQR0xjWmpKV2Nu?=
 =?utf-8?B?bFdjSmtic2hzWEh5L0REL2NrRjZZOUpjdGpSSnNwTUw1U3JDZ2VTL0c1UDRL?=
 =?utf-8?B?dVBRNDN6aU52dXBaVHFuV2ZXcVR5cWYxTUNlWmJ1aFFNMWJONkhrT3o2YTBl?=
 =?utf-8?B?bTZLTHR6alJrbS9FYWtkMVhaSm1OSG00d3g5ak1hK25lWUxtdzlobmxFc0Rr?=
 =?utf-8?B?SEJPbTVBd2RBTFBDRlFxd0hiVUlvSHQyT1ZRcU9EZElRbXY0bTZUWDRlOXlE?=
 =?utf-8?B?TlVGQ2s5bFZsMXltS1JHOHFoS2ozQW5OK253a1RzTW1vNzAzcGNGTk9OL25o?=
 =?utf-8?B?L0tyUU5HRWlQamhMd05DLzhxT2kzcGYxR1o3ZTNLNEU2ejdVN2d4R0JJemhk?=
 =?utf-8?B?SjMxTlNySGErNTlsYWpLOEdjVXFPdjlCRW1UcmxLemZ6a1h6eHQ1dHh3c01S?=
 =?utf-8?B?QXNpRHk0Q2hnV3RmTVo1OUYyblJWTnp4YXd5QktHUnc4N0V5dk9aVDdVNHJj?=
 =?utf-8?B?b0JvbEEzZzVBSVQ1NjYxQzNpMGtIK2d5c0d5NVB2WGFjYjRIaFpSNEtUQis4?=
 =?utf-8?B?c08vS0QwTm1nSGNtMi9FMkhNcjRTSGx5Ym9hTkNzc0MzVU9nbEFTcExDc0w5?=
 =?utf-8?B?UkFyWDZGOUZhZDhILzdpNHNXUnF3RE8vbXBxVmhSV2FBVVVjOEM4UGRBNzd0?=
 =?utf-8?B?b0VlS0M5d0dPS3EvVGd1SVVZNEs4aGU5L1NlUGNlTzJnL0RTaU1tU3hmMVFD?=
 =?utf-8?B?TFNaNjE4ejR0TFNSc1NwZi85UVVQeWRVMEVsNmVmVG5TbmtVNXVKWVlpUm1s?=
 =?utf-8?B?QkIybnRUVVRIcHB6b0F4SUFaQzZYdGhCekEyZjl6UnZKaFlPRnoxWHZiNVVy?=
 =?utf-8?B?SWUwSVY0NFQxR2VQMC9uckpQL0VFWWFOaE1RTWNKZlcxTHFtaWhqdEUrQlBo?=
 =?utf-8?B?dWRaWmN2dlZwR3ZyamR0K2U4dmR5QzBRWmlxSGsvNFNXMzBSRVN2TTh0Q1l2?=
 =?utf-8?B?MlBXcWRRNEYwN0tvdy9lbzJuejVhbHV1MlQyQnJFSUNJZUFkMGRDektZdnF6?=
 =?utf-8?B?NkJ6ajhuek1XOVIxcFF2MlBOSkdLTjJHc0tvaHVVRnNRK3cyck9kNnZGNlRH?=
 =?utf-8?B?K0xlOGsxQTk3OWhSY1M3WGFaL2ZFZVNGYnFsQ2R0UHN3V2djS3JyRjJ3T2pi?=
 =?utf-8?B?N0JBV0xIaTYwU0p4ZVdZWFNyN2NrV3V2RzJQdktSK1lvd0JWZUkyRjBBT1h6?=
 =?utf-8?B?TzJVNVJUMGR3M01qaFJNY1A4eDJHWk40eVk3QjlENGZSM1diWVhkaVZoM3k1?=
 =?utf-8?B?R2U3K3pEYUg4UGgyeFFLMXg2clNROWFBc0VEWFlrbGc3OUtGbzNvTnlVQyt5?=
 =?utf-8?B?TUpKa0dwUjl5Zm9uMEp0RkdPKzhyQUFOZGd3eDNHbVZzNkZLMGhOdHp5b3VU?=
 =?utf-8?B?R3VseERYcVp2dDlRY2tWMTFpZDNZdTFKd2U4dWRkZnlWT2pzcm0vTmNKV2dr?=
 =?utf-8?B?TjhTUDNxYzRhZXYwQzdjTHVRN1B5dVdVbUkvQ1J4blRPaTVqU2tvVzRpcU03?=
 =?utf-8?B?OThIQ3hEK1NxQ2RTRTE3WnZ4OVVwVEFmWmFOQUwzSjNiQkF0Z2ovTGFia0hj?=
 =?utf-8?B?YzhjajhMU2hEVU9ZS0gvUUtmY0pnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00dab603-8b89-4b05-381c-08db0d8d9dd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2023 06:43:29.1638
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lDBFk9vMXhy04Ycj75/eMZ/TtFiKYoTIt5lidhs1/Anf76ZyTBzY3/cghabtkivePaaZKqaDtGxZwjEdQv2OmEyk7iG3igtBobdZyrrGtr0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR21MB3835
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogSnVlcmdlbiBHcm9zcyA8amdyb3NzQHN1c2UuY29tPiBTZW50OiBTdW5kYXksIEZlYnJ1
YXJ5IDEyLCAyMDIzIDEwOjI3IFBNDQo+IA0KPiBPbiAxMy4wMi4yMyAwMjowNywgTWljaGFlbCBL
ZWxsZXkgKExJTlVYKSB3cm90ZToNCj4gPiBGcm9tOiBKdWVyZ2VuIEdyb3NzIDxqZ3Jvc3NAc3Vz
ZS5jb20+IFNlbnQ6IFdlZG5lc2RheSwgRmVicnVhcnkgOCwgMjAyMyAxMToyMiBQTQ0KPiA+Pg0K
PiA+PiBXaGVuIHJ1bm5pbmcgdmlydHVhbGl6ZWQsIE1UUlIgYWNjZXNzIGNhbiBiZSByZWR1Y2Vk
IChlLmcuIGluIFhlbiBQVg0KPiA+PiBndWVzdHMgb3Igd2hlbiBydW5uaW5nIGFzIGEgU0VWLVNO
UCBndWVzdCB1bmRlciBIeXBlci1WKS4gVHlwaWNhbGx5DQo+ID4+IHRoZSBoeXBlcnZpc29yIHdp
bGwgcmVzZXQgdGhlIE1UUlIgZmVhdHVyZSBpbiBjcHVpZCBkYXRhLCByZXN1bHRpbmcNCj4gPj4g
aW4gbm8gTVRSUiBtZW1vcnkgdHlwZSBpbmZvcm1hdGlvbiBiZWluZyBhdmFpbGFibGUgZm9yIHRo
ZSBrZXJuZWwuDQo+ID4+DQo+ID4+IFRoaXMgaGFzIHR1cm5lZCBvdXQgdG8gcmVzdWx0IGluIHBy
b2JsZW1zOg0KPiA+Pg0KPiA+PiAtIEh5cGVyLVYgU0VWLVNOUCBndWVzdHMgdXNpbmcgdW5jYWNo
ZWQgbWFwcGluZ3Mgd2hlcmUgdGhleSBzaG91bGRuJ3QNCj4gPj4gLSBYZW4gUFYgZG9tMCBtYXBw
aW5nIG1lbW9yeSBhcyBXQiB3aGljaCBzaG91bGQgYmUgVUMtIGluc3RlYWQNCj4gPj4NCj4gPj4g
U29sdmUgdGhvc2UgcHJvYmxlbXMgYnkgc3VwcG9ydGluZyB0byBzZXQgYSBmaXhlZCBNVFJSIHN0
YXRlLA0KPiA+PiBvdmVyd3JpdGluZyB0aGUgZW1wdHkgc3RhdGUgdXNlZCB0b2RheS4gSW4gY2Fz
ZSBzdWNoIGEgc3RhdGUgaGFzIGJlZW4NCj4gPj4gc2V0LCBkb24ndCBjYWxsIGdldF9tdHJyX3N0
YXRlKCkgaW4gbXRycl9icF9pbml0KCkuIFRoZSBzZXQgc3RhdGUNCj4gPj4gd2lsbCBvbmx5IGJl
IHVzZWQgYnkgbXRycl90eXBlX2xvb2t1cCgpLCBhcyBpbiBhbGwgb3RoZXIgY2FzZXMNCj4gPj4g
bXRycl9lbmFibGVkKCkgaXMgYmVpbmcgY2hlY2tlZCwgd2hpY2ggd2lsbCByZXR1cm4gZmFsc2Uu
IEFjY2VwdCB0aGUNCj4gPj4gb3ZlcndyaXRlIGNhbGwgb25seSBpbiBjYXNlIG9mIE1UUlJzIGJl
aW5nIGRpc2FibGVkIGluIGNwdWlkLg0KPiA+Pg0KPiA+PiBTaWduZWQtb2ZmLWJ5OiBKdWVyZ2Vu
IEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+DQo+ID4+IC0tLQ0KPiA+PiBWMjoNCj4gPj4gLSBuZXcg
cGF0Y2gNCj4gPj4gLS0tDQo+ID4+ICAgYXJjaC94ODYvaW5jbHVkZS9hc20vbXRyci5oICAgICAg
ICB8ICAyICsrDQo+ID4+ICAgYXJjaC94ODYva2VybmVsL2NwdS9tdHJyL2dlbmVyaWMuYyB8IDM4
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+PiAgIGFyY2gveDg2L2tlcm5lbC9j
cHUvbXRyci9tdHJyLmMgICAgfCAgOSArKysrKysrDQo+ID4+ICAgMyBmaWxlcyBjaGFuZ2VkLCA0
OSBpbnNlcnRpb25zKCspDQo+ID4+DQo+ID4+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRl
L2FzbS9tdHJyLmggYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9tdHJyLmgNCj4gPj4gaW5kZXggZjBl
ZWFmNmU1ZjVmLi4wYjhmNTFkNjgzZGMgMTAwNjQ0DQo+ID4+IC0tLSBhL2FyY2gveDg2L2luY2x1
ZGUvYXNtL210cnIuaA0KPiA+PiArKysgYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9tdHJyLmgNCj4g
Pj4gQEAgLTMxLDYgKzMxLDggQEANCj4gPj4gICAgKi8NCj4gPj4gICAjIGlmZGVmIENPTkZJR19N
VFJSDQo+ID4+ICAgdm9pZCBtdHJyX2JwX2luaXQodm9pZCk7DQo+ID4+ICt2b2lkIG10cnJfb3Zl
cndyaXRlX3N0YXRlKHN0cnVjdCBtdHJyX3Zhcl9yYW5nZSAqdmFyLCB1bnNpZ25lZCBpbnQgbnVt
X3ZhciwNCj4gPj4gKwkJCSAgbXRycl90eXBlICpmaXhlZCwgbXRycl90eXBlIGRlZl90eXBlKTsN
Cj4gPg0KPiA+IENvdWxkIHlvdSBhZGQgYSBzdHViIGZvciB0aGUgIUNPTkZJR19NVFJSIGNhc2U/
ICBUaGVuIHRoZQ0KPiA+ICNpZmRlZiBDT05GSUdfTVRSUiBjb3VsZCBiZSByZW1vdmVkIGluIFBh
dGNoIDMgb2YgdGhpcyBzZXJpZXMuDQo+IA0KPiBJIHdhcyBvbiB0aGUgZWRnZSB3aGV0aGVyIHRv
IGFkZCBhIHN0dWIuIFRoZSBYZW4gdXNlIGNhc2Ugc3Ryb25nbHkNCj4gc3VnZ2VzdHMgdGhhdCB0
aGUgY29kZSB3YW50cyB0byBiZSBpbnNpZGUgYW4gI2lmZGVmLCB3aGlsZSB0aGUgSHlwZXItVg0K
PiBjYXNlIGlzIHNvIHNpbXBsZSwgdGhhdCBpdCB3b3VsZCBiZW5lZml0IGZyb20gdGhlIHN0dWIu
IEFzIHRoZXJlIHdhcw0KPiBhbm90aGVyICNpZmRlZiBqdXN0IGFib3ZlIHRoZSBhZGRlZCBjb2Rl
IGluIG1zaHlwZXJ2LmMgSSBiZWxpZXZlZCBpdA0KPiB3b3VsZCBiZSBmaW5lIHdpdGhvdXQgYSBz
dHViLiBBcyB5b3Ugc2VlbSB0byBsaWtlIGl0IGJldHRlciB3aXRoIHRoZQ0KPiBzdHViLCBJIGNh
biBhZGQgaXQuDQo+IA0KDQpUaGFua3MuICBBbmQgdGhhdCBvdGhlciAjaWZkZWYgaXMgZ29pbmcg
YXdheSBzb29uIC4uLg0KDQpNaWNoYWVsDQo=
