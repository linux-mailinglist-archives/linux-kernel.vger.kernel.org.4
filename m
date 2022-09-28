Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5AF95ED7DA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 10:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbiI1Idv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 04:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233789AbiI1Idk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 04:33:40 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561D12183;
        Wed, 28 Sep 2022 01:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664354019; x=1695890019;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=clnlPy3I2kab2BWyxgvEBGffIxJniAaCFYVRLr+9D3Y=;
  b=LMPJzEGR5AMFeM6B7q6+Hv4cZWv++H/wFj3FyN0OG7C5p/+0T2sgv5Zp
   mffhKhyUN7joqTeBAT4DGgg1p06jp3Tiapk/r1BySlFXkolHgmdsfJc9h
   Vu1zt6RVuWl4gOiPYw5XGAlYlRvG/rUBKtIJZ1Q+m70Ma+M80S3IS9Rx8
   RpyMOiNBYk2US6iUJWHmR0YVjuTMC3kRKxjYcQicMruLqPvqWkKMmbPo9
   9nwIIm0SwNaovmCYbolK266EENqDAbr8nlHk4doNb32kdWOuFX5YrAYPK
   zUwsiCt3MEYFo0gEHJVRHqUjAaeIOnEr688vXwmmUNbtpNaWAbvs+hUWO
   A==;
X-IronPort-AV: E=Sophos;i="5.93,351,1654531200"; 
   d="scan'208";a="217649026"
Received: from mail-sn1anam02lp2046.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.46])
  by ob1.hgst.iphmx.com with ESMTP; 28 Sep 2022 16:33:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NyGO6YKaz/j1xy0eA5Tl7Z7hda8gqBzp3InMRHOv/hdMb4fACKWG9wTulq2yrqFU5NhPnwqSo58fr6gNC9GiQJCl4e/UngRxO9bxiRIAfxwJRAf7jo6jcAAjgw75uf93Zup0qaejNfBmFY0c0/HCHK8UMjIDqKWWoRAIzblhcqdEyBPa5fYn8cIaao9YkLrLoAC6+RUMTdPdfAxAJ8YD74vlTEnNI76R240svUrzItHTiZ/gQ0M6hvbDUxLFPVvieZ26FLc11jzPEKfIhaGew2fcPxGNEMpx5eiqzTHQBm6435EHN63Dho9U/3z31jtN0xfjiO3mbH4HqTrVg/vx0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=clnlPy3I2kab2BWyxgvEBGffIxJniAaCFYVRLr+9D3Y=;
 b=SitLxC/31ddmq3IcUriPt6h36LaXClPdi0N9nmXztv6wO4yHB87VWSipPlCRJ2pXVQ+8kChbExZ5mRovvSkPZ8zte5sRcMZzOrfzjGAWnE57GDTK6iXWQjA3hoh2Pf31gdh2zJCmIeHlRiQ7mNUlJdKC0AyWobtWoARo8VIknZROeBZojAIN/PvqlkBliqPTyVBKk1OUTH5OdwP0j91aqDSv9A/GA4Yg4Bd5FrxV5fNZp2CuGPiBAopLTy52l5EyHXuPdtZ8RMNDdD8sE8qQi4It1Kr51f4t34rgNj76EREIR24xL59c6B03sSO+EfSap04qH8XKacMmVwFkSVqICg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=clnlPy3I2kab2BWyxgvEBGffIxJniAaCFYVRLr+9D3Y=;
 b=W4sSIoey7TpK9lMeStShGxNnJc1Mp8lQKcivLsYXRgfTc630/yYQ9hp9ykVMrZZdwVdnDxKN3Eq/JvoGxApvMt1d2c4eHegv6EyFPHlpYD6tVRcOtC78MzOOvBKK1o+/tUND1CiRN0bdaxyRdr04+2kj5htprCUlBUi9g2xp4wQ=
Received: from BY5PR04MB6327.namprd04.prod.outlook.com (2603:10b6:a03:1e8::20)
 by CY4PR04MB0999.namprd04.prod.outlook.com (2603:10b6:910:56::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.16; Wed, 28 Sep
 2022 08:33:36 +0000
Received: from BY5PR04MB6327.namprd04.prod.outlook.com
 ([fe80::b116:fb8d:6e10:37b7]) by BY5PR04MB6327.namprd04.prod.outlook.com
 ([fe80::b116:fb8d:6e10:37b7%2]) with mapi id 15.20.5676.018; Wed, 28 Sep 2022
 08:33:36 +0000
From:   Arthur Simchaev <Arthur.Simchaev@wdc.com>
To:     "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Daniil Lunev <dlunev@chromium.org>,
        Avri Altman <Avri.Altman@wdc.com>,
        Avi Shchislowski <Avi.Shchislowski@wdc.com>
Subject: RE: [PATCH] scsi: ufs-bsg: Remove ufs_bsg_get_query_desc_size
 function
Thread-Topic: [PATCH] scsi: ufs-bsg: Remove ufs_bsg_get_query_desc_size
 function
Thread-Index: AQHYhKDynvKkVtaQm0SrWhB5D1T9dq3ooC4AgAGVWkCACuorUA==
Date:   Wed, 28 Sep 2022 08:33:35 +0000
Message-ID: <BY5PR04MB6327ED5C6D91CBD3A024F709ED549@BY5PR04MB6327.namprd04.prod.outlook.com>
References: <1655727966-31584-1-git-send-email-Arthur.Simchaev@wdc.com>
 <87e6fdb49d9d76c468712e1b42cbc130273b5635.camel@gmail.com>
 <BY5PR04MB6327B8C5001E315009E3AC6EED4F9@BY5PR04MB6327.namprd04.prod.outlook.com>
In-Reply-To: <BY5PR04MB6327B8C5001E315009E3AC6EED4F9@BY5PR04MB6327.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR04MB6327:EE_|CY4PR04MB0999:EE_
x-ms-office365-filtering-correlation-id: 87c99e66-7698-49af-50be-08daa12c22c7
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l5kvofMVBTAksCHhF+luyFmF6FGLWcagwnWq3VfOoBd6tjGnwf+YPi5RZ3tLO4NZU4q54mjcj0v0LCXcFscQSvNb0iIJmfj6/Iwx0r4eg+5M4hfUa+tWM7xe4PUxwrUBLD0WPJ8RzGAOCVWQRONEqHMHD8kysF/62ysQhgPbdYwp/+zx5vRdgDUif1GLpJhFCdWYxSneuBG6YGroHhGfdv6HldQY+fKvZMEOFcG1Jz75gfv4wJxm/fTD3RroaI1q8DpqFjqTtdayxk6wHaZuMBk0/wIx7B0AKDhg/pRAD+3+v4mY4OpLkuWEwlfeSM53Xfbli0mgaaY4A3cB7c0p/Rz91+hbn+RwWuKvdProfbIs0aQQSqnDm9WWp5ulFqmcdCmasJoG/4+mY2k4YBbBoxqDd3BK0En8Any0H2VywhSi7M2WBc1f+Bp1dOmW9t04OvC/jETNRSme2fF+AUmzfSljVo4Y33KMYmAyfsT0RiUPRhZ8XlZlTRuRN1l9pGhll23+j8Z267bh9yv67ep+eo/jXNc4mQg+yPLv6eWI2I9cj4WbghbopUt7nL+6i0+hWhGOjsyqwDiwL/b48+We25/hLy03XYnc15D94whtDrs0pOg5YytBk6iHSYKUeuOqQ/O4SX3p4v7J6odOzDztmGozLgltIRu9dUT9H/FLloR3uiEaDT1Gh8np3hs6DV6T9tzUP8MLD68Cap6FQ1ojVayXi5Zcwq6f0CkSdhT+x/uXut1hBAKu2IcQ86C4zJzt0j19wayZApE12p2ba7QicQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6327.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(366004)(376002)(396003)(136003)(451199015)(86362001)(66446008)(66476007)(41300700001)(26005)(9686003)(478600001)(82960400001)(38070700005)(122000001)(316002)(38100700002)(55016003)(110136005)(186003)(54906003)(4326008)(8676002)(52536014)(66556008)(76116006)(5660300002)(64756008)(8936002)(2906002)(66946007)(33656002)(83380400001)(53546011)(7696005)(6506007)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RWxscytMdjRsMmVVckErRzloUDh4T1hmREcrQ2JXbGlTNktNZlFxWkpuL0lE?=
 =?utf-8?B?T0FwTEY5ZzU1SGdQUmZMMGt4Ymp5TDNyWTQ3cWtaaXNTQ0lid3g0Zjg4ZTBJ?=
 =?utf-8?B?VFA3OUN3RURSWDZadWJPRzZodlNSTGRqSnNJb2lMTHNpbmVrMFAzTlg1aFgv?=
 =?utf-8?B?V1hCaStyUlptZy8vMW5EN0xEZjRQSVBhQVE4ZjBkeGxRZXVEUXVCemVJaWJ3?=
 =?utf-8?B?eTYrcGJlVW9BOVBuZmRvOTZ5bDVMbklMR3pqSjd6OXlVRTlZRGR0ck8va3lw?=
 =?utf-8?B?alFrN0RUcS9BRFhvcjg4dTdOc0tFQmJDSWNwc1JQQ2FhYVUrTlY5ajlUaTVC?=
 =?utf-8?B?NWgwMWhrTGNiMk1KT3NaWStSUUZzMzJRZS81ZzRVREhERkNpdnhLT1NERlVq?=
 =?utf-8?B?MzJCK2pJN1c0eXRQaU0xamkrdzRVRVBpTHpBZlcwUktVa0JVYjlNR3RtMCs1?=
 =?utf-8?B?c1VhejJaR1JnMzBBWWF0MzlnOS81MHF4ejVEZXlwaDZpTkc2MzRTUjFpTnZB?=
 =?utf-8?B?L0krUnFvWVVNUnkxMk0yRDRtTHZ2WHdoUjJuMWxMOVdlRmlPSDBKR3J0OEwx?=
 =?utf-8?B?bElmWWJjZGhGTTQwcXRZNDgzVW0rc0R5ck5kcVRQRW54NGVKMjhQZ0tiZk5X?=
 =?utf-8?B?dlg1ODRtOW1GRVljTlU3a0k5TDA3dS96ZGRHb25EOXBFa3lJSWQrZGplMHkw?=
 =?utf-8?B?MllrVkRWN2JadHlhK0pZMWRFR3BtWVhRWHMyYU1xT3liUWJQa0tPZUtTbGht?=
 =?utf-8?B?MmFwb0JDQ3QzT0tVdHVGM3luRDZlK3NJU0NGcnR0K09uMERPdEJtcGtjS0hZ?=
 =?utf-8?B?NGxLSkp1VnM5Y3JQWDh5N3F3WUxlWlk1SllhME00eGhoU1ZvS1dIdm5ncE8x?=
 =?utf-8?B?RjVWUjVMV0lhZmFtcG92OEZUb1o3dEFKSkdwcklrK1hnQXNyUlp2RXJvaFdx?=
 =?utf-8?B?N2duUUJFeEwzd1RHS1hzSENSTVRKTFp1aTdmK2xSczc3TC9kT3UxclNMMEpM?=
 =?utf-8?B?MUUreWtqbW9qcTdpcUhxWEpQZkZiL1FlZnVWcFB2bVV1SGlUVmlIOWJTZi90?=
 =?utf-8?B?ajI1QUZ6Y1ljVjIxWko5RkhFbnFDMGphSUs3MExjUTBGMXo4N3NEMklrR1Zi?=
 =?utf-8?B?NkwrTlBMNlQ0dDA0UG11WVVzMElpYytRYmEwaml5cTNWd3ErTmZSVGRIeTFM?=
 =?utf-8?B?QVQvbmtRY2xUc2J3UUpVQ0NTTUxwejdpUkNhUVRmYXdOS2VuMFppQjlVYVZs?=
 =?utf-8?B?MGw5MmoySEFjK3k4RldzdGxIYkg2RXIwZ1A1NjFSaXpUV1VGRUNJdXhrN3N5?=
 =?utf-8?B?KzhQS25mSnQzVG5TTVRCMzBDQkFSNlRWYk81b1JvQ2Z5bVVaVkE0R1lKK0RH?=
 =?utf-8?B?SmYwR05zRE1EVWxCL2V3a1NQNU9OTjBNVWJKeVZBKzZwTmxTUUdGUnNDbUZr?=
 =?utf-8?B?YWZOcnlIaVFPd0tnNGlNYWIwR2tqNGdhMVRBdDd5dzNHQmZmNzZJbnhtNzJx?=
 =?utf-8?B?bVVXM05uK2dldVYycTY3L01IUUs4aFVTN1RCakU2TEdKaHUrSXkrOHhQenR0?=
 =?utf-8?B?Qm52MFlOaTJKbUFWYmVMZ2JyNzdLbmI5WmRWNU4rS25Ia0VtcTlKUjVTZHlv?=
 =?utf-8?B?eTI4d2hXeW1hTHlJZ2tqWW14bDZHK01qT3ErYTdvR2VuNWJvUm14RGZEdXdI?=
 =?utf-8?B?MU9JV3c3K2xaZ2gvcjhxMzdTS2hnUVhNRTBsOHVuQnVWUE9LSEFSeGtMdHJp?=
 =?utf-8?B?VmdtNTVDQzdqNXI3VWwzRm13M3FlY04yNjI5RVAzY3FhNFVFYWhBcHAzMTEz?=
 =?utf-8?B?c0tVVWdjQUpIc2I0ZDE5dmFuS2w4eE1veFlmRklMUVdUUXZWM1I5a09qeVVM?=
 =?utf-8?B?bVlpeGtVTVBBNGUrRVpNbnR4S3MrbGJHWVdEdUg1aHNnQ2dudlN3Yk1KdkJz?=
 =?utf-8?B?cmZvc2VpRVRpSlZvajNJYjlOcGNuaFRnUUxWZDVZYUg2dHhlN1dJaEw4MW9E?=
 =?utf-8?B?R1czYmxsOFQ5WmhzSklYb2ZjRkxZdVljUDdHMzU0akhLZEEzbjAyaXJ3V3Ji?=
 =?utf-8?B?T2ZVOHFMQjBjekM3NGNnZkdudEtmV2xFQ0N4OEw2dHV2S0QyZWNvZWhDMHRI?=
 =?utf-8?Q?eRjB+Jv+D9AJ65FTPeHTYl7pT?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6327.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87c99e66-7698-49af-50be-08daa12c22c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2022 08:33:35.9842
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ol6YXmGZe2GwHqtmmD4G46vgjaMbIGS4paDjvLgh0dWCXvWvCPmj+7m+yg7irbF3f0zg4p/noQ2xe3BmHddIsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0999
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQmVhbg0KDQpJbiBjYXNlIHlvdSBkb24ndCBoYXZlIGFueSBjb21tZW50cyBJIHdpbGwgYXBw
cmVjaWF0ZSBpZiB5b3Ugd2lsbCBhZGQgInJldmlld2VkIGJ5IiB0byB0aGUgcGF0Y2guDQoNClJl
Z2FyZHMNCkFydGh1cg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEFy
dGh1ciBTaW1jaGFldg0KPiBTZW50OiBXZWRuZXNkYXksIFNlcHRlbWJlciAyMSwgMjAyMiAxMjo1
MyBQTQ0KPiBUbzogQmVhbiBIdW8gPGh1b2JlYW5AZ21haWwuY29tPjsgSmFtZXNAdmdlci5rZXJu
ZWwub3JnOw0KPiBFLkouQm90dG9tbGV5QHZnZXIua2VybmVsLm9yZzsgamVqYkBsaW51eC52bmV0
LmlibS5jb207DQo+IE1hcnRpbkB2Z2VyLmtlcm5lbC5vcmc7IEsuUGV0ZXJzZW5Admdlci5rZXJu
ZWwub3JnOw0KPiBtYXJ0aW4ucGV0ZXJzZW5Ab3JhY2xlLmNvbQ0KPiBDYzogbGludXgtc2NzaUB2
Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IEJlYW5Admdl
ci5rZXJuZWwub3JnOyBIdW9Admdlci5rZXJuZWwub3JnOyBiZWFuaHVvQG1pY3Jvbi5jb20NCj4g
U3ViamVjdDogUkU6IFtQQVRDSF0gc2NzaTogdWZzLWJzZzogUmVtb3ZlIHVmc19ic2dfZ2V0X3F1
ZXJ5X2Rlc2Nfc2l6ZQ0KPiBmdW5jdGlvbg0KPiANCj4gVGhhbmsgeW91IEJlYW4NCj4gDQo+ID4g
VUZTIGRlc2NyaXB0b3Igc2l6ZSBpcyBubyBsb25nZXIgaGFyZGNvZGVkIChkZWZpbmVkIGluIHRo
ZSBkcml2ZXIpLCB0aGUNCj4gPiBzaXplIG9mIHRoZSBkZXNjcmlwdG9yIGlzIHJlcG9ydGVkIGJ5
IFVGUyBpdHNlbGYsIGNoZWNrIHRoZSBsYXRlc3QNCj4gPiBrZXJuZWwuDQo+ID4NCj4gSW52b2tl
cyB1ZnNoY2RfbWFwX2Rlc2NfaWRfdG9fbGVuZ3RoIGZyb20gYnNnIGNvZGUsIHN0aWxsIHByb2Js
ZW1hdGljDQo+IGFsc28gaW4gdGhlIGxhdGVzdCBrZXJuZWwuIFRoZSBmdW5jdGlvbiBsaW1pdGVk
IHRoZSB1ZnMgYnNnIGZ1bmN0aW9uYWxpdHkuDQo+IEZvciBleGFtcGxlIEZCTyBkZXNjcmlwdG9y
IHB1Ymxpc2hlZCBpbiBKZWRlYyBVRlMgNC4wIHNwZWMgYW5kIGFscmVhZHkgZXhpc3QNCj4gaW4g
c29tZSBVRlMgZGV2aWNlcy4NCj4gT3Igb3RoZXJzIHJlc2VydmVkIGRlc2NyaXB0b3JzIChSRlVf
MC8xKSB3aGljaCBjYW4gYmUgdXNlZCBhcyB2ZW5kb3Incw0KPiBkZXNjcmlwdG9yLiBUaGUgZnVu
Y3Rpb24gcmV0dXJucyBsZW4gPTANCj4gV2Ugc2hvdWxkIGJlIGFibGUgdG8gcmVhZCBhbnkgVUZT
IGRlc2NyaXB0b3Igb2YgYW55IHNpemUgKHVwIHRvDQo+IFFVRVJZX0RFU0NfTUFYX1NJWkUpIG9y
IGlkbi4NCj4gQWNjb3JkaW5nIHRvIHRoZSBzcGVjLCB0aGUgZGV2aWNlIHdpbGwgcmV0dXJuIHRo
ZSBhY3R1YWwgc2l6ZS4NCj4gDQo+IFRoZSB1ZnMgYnNnIGRyaXZlciBzaG91bGQgbm90IGltcG9z
ZSBhbnkgc3VjaCBsaW1pdGF0aW9uLiBJdCdzIG9uZSBvZiBpdHMgZGVzaWduDQo+IGd1aWRlbGlu
ZXMuDQo+IEUuZy4gYXMgZG9uZSBmb3IgdGhlIGF0dHJpYnV0ZXMsIGZsYWdzIHRoZSBrZXJuZWwg
ZG9lc24ndCBjaGVjayBpdCBzaXplKGZvcg0KPiBhdHRyaWJ1dGVzIGlzIHRoZSBtYXggLSA0IGJ5
dGVzKSwNCj4gbm9yIGFjY2VzcyAocmVhZC93cml0ZSkuDQo+IEFuZCBqdXN0IHJldHVybnMgYW4g
YXBwcm9wcmlhdGUgZXJyb3IgY29kZSBzaG91bGQgYW4gZXJyb3Igb2NjdXIuDQo+IA0KPiA+IFRo
aXMgVUZTIGRyaXZlciBpcyBpbiB0aGUgd3JvbmcgbG9jYXRpb24sIEkgYXNzdW1lIHlvdSBhcmUg
dXNpbmcgYW4NCj4gPiBvbGRlciBrZXJuZWwgdmVyc2lvbj8NCj4gRG9uZQ0KPiANCj4gUmVnYXJk
cw0KPiBBcnRodXINCj4gDQo+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiBGcm9t
OiBCZWFuIEh1byA8aHVvYmVhbkBnbWFpbC5jb20+DQo+ID4gU2VudDogVHVlc2RheSwgU2VwdGVt
YmVyIDIwLCAyMDIyIDEyOjM4IFBNDQo+ID4gVG86IEFydGh1ciBTaW1jaGFldiA8QXJ0aHVyLlNp
bWNoYWV2QHdkYy5jb20+OyBKYW1lc0B2Z2VyLmtlcm5lbC5vcmc7DQo+ID4gRS5KLkJvdHRvbWxl
eUB2Z2VyLmtlcm5lbC5vcmc7IGplamJAbGludXgudm5ldC5pYm0uY29tOw0KPiA+IE1hcnRpbkB2
Z2VyLmtlcm5lbC5vcmc7IEsuUGV0ZXJzZW5Admdlci5rZXJuZWwub3JnOw0KPiA+IG1hcnRpbi5w
ZXRlcnNlbkBvcmFjbGUuY29tDQo+ID4gQ2M6IGxpbnV4LXNjc2lAdmdlci5rZXJuZWwub3JnOyBs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiA+IEJlYW5Admdlci5rZXJuZWwub3JnOyBI
dW9Admdlci5rZXJuZWwub3JnOyBiZWFuaHVvQG1pY3Jvbi5jb20NCj4gPiBTdWJqZWN0OiBSZTog
W1BBVENIXSBzY3NpOiB1ZnMtYnNnOiBSZW1vdmUgdWZzX2JzZ19nZXRfcXVlcnlfZGVzY19zaXpl
DQo+ID4gZnVuY3Rpb24NCj4gPg0KPiA+IENBVVRJT046IFRoaXMgZW1haWwgb3JpZ2luYXRlZCBm
cm9tIG91dHNpZGUgb2YgV2VzdGVybiBEaWdpdGFsLiBEbyBub3QgY2xpY2sNCj4gPiBvbiBsaW5r
cyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3UgcmVjb2duaXplIHRoZSBzZW5kZXIgYW5k
IGtub3cNCj4gdGhhdA0KPiA+IHRoZSBjb250ZW50IGlzIHNhZmUuDQo+ID4NCj4gPg0KPiA+IEhp
IEFydGh1ciwNCj4gPg0KPiA+DQo+ID4gT24gTW9uLCAyMDIyLTA2LTIwIGF0IDE1OjI2ICswMzAw
LCBBcnRodXIgU2ltY2hhZXYgd3JvdGU6DQo+ID4gPiBUaGUgYnNnIGRyaXZlciBhbGxvd3MgdXNl
ciBzcGFjZSB0byBzZW5kIGRldmljZSBtYW5hZ2VtZW50IGNvbW1hbmRzLg0KPiA+ID4gQXMgc3Vj
aCwgaXQgaXMgb2Z0ZW4gdXNlZCBieSBmaWVsZCBhcHBsaWNhdGlvbiBlbmdpbmVlcnMgdG8gZGVi
dWcNCj4gPiA+IHZhcmlvdXMgcHJvYmxlbXMsDQo+ID4gPiBhbmQgYXMgYSB0ZXN0IGJlZCBmb3Ig
bmV3IGZlYXR1cmVzIGFzIHdlbGwuDQo+ID4gPg0KPiA+ID4gTGV0J3Mgbm90IGJvdW5kIG91cnNl
bGYgdG8gaGFyZCBjb2RlZCBkZXNjcmlwdG9yIHNpemVzLCBhcyB0aGUgbmV3DQo+ID4NCj4gPiBV
RlMgZGVzY3JpcHRvciBzaXplIGlzIG5vIGxvbmdlciBoYXJkY29kZWQgKGRlZmluZWQgaW4gdGhl
IGRyaXZlciksIHRoZQ0KPiA+IHNpemUgb2YgdGhlIGRlc2NyaXB0b3IgaXMgcmVwb3J0ZWQgYnkg
VUZTIGl0c2VsZiwgY2hlY2sgdGhlIGxhdGVzdA0KPiA+IGtlcm5lbC4NCj4gPg0KPiA+DQo+ID4g
PiBEZXNjcmlwdG9ycyB0aGF0IHN1cHBvcnRzIG5ldyBmZWF0dXJlcyBhcmUgbm90IGRlZmluZWQg
eWV0Lg0KPiA+ID4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IEFydGh1ciBTaW1jaGFldiA8QXJ0aHVy
LlNpbWNoYWV2QHdkYy5jb20+DQo+ID4gPiAtLS0NCj4gPiA+ICBkcml2ZXJzL3Njc2kvdWZzL3Vm
c19ic2cuYyB8IDI4ICsrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiA+ICAxIGZpbGUg
Y2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAyNCBkZWxldGlvbnMoLSkNCj4gPiA+DQo+ID4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9zY3NpL3Vmcy91ZnNfYnNnLmMgYi9kcml2ZXJzL3Njc2kvdWZz
L3Vmc19ic2cuYw0KPiA+DQo+ID4gVGhpcyBVRlMgZHJpdmVyIGlzIGluIHRoZSB3cm9uZyBsb2Nh
dGlvbiwgSSBhc3N1bWUgeW91IGFyZSB1c2luZyBhbg0KPiA+IG9sZGVyIGtlcm5lbCB2ZXJzaW9u
Pw0KPiA+DQo+ID4gS2luZCByZWdhcmRzLA0KPiA+IEJlYW4NCg0K
