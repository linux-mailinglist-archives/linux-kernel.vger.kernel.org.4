Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC4667850C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 19:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbjAWSim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 13:38:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231788AbjAWSik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 13:38:40 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB5422A22;
        Mon, 23 Jan 2023 10:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674499119; x=1706035119;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=OAQIBKeZCcsF6faNse8CWrtaZqY9j6jWItLEwzdSx/E=;
  b=b7V7QU9+/IET2Oq5YWvz6ABPXGM+LhY0sn8Xe1tC4hTBNAqbbfjk18e/
   KLA5qYcgEjxR+BK6nJdDk1MQraltV87zVpwCrPdrWeldcV6/wLbOPGi/K
   tkxQOPdSNkH5ZYq+jZ/dVcfErG2/b5hPocj9EsYnTDnlLEx556TCigS1c
   nDMMzdJqtBA7ndEo9EZLESv7EsmpTgndiitO2Oh42FcaLgordInfYpKAt
   hqqG8il1huGKv5N3C31O7qQ/kbHbcbhtT4AzjDgByCTof8vQOtLgkc8yJ
   OP3QgcbEIaF/Znpf09085shfB/0su3puUPB9JjehiwoDuuUUTVv7xHqXV
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="326149957"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="326149957"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 10:38:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="730396854"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="730396854"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP; 23 Jan 2023 10:38:39 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 23 Jan 2023 10:38:38 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 23 Jan 2023 10:38:38 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 23 Jan 2023 10:38:38 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 23 Jan 2023 10:38:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NRj38HuvoFS4NBBcG7YUP2NHPQmniP6qNsECnFzXG1kyX9czr/3D4meMwiUGB0emb9mFZmDeI8hUuzxAExJ2lpI7gFp/FOnMiLEPnfcEKp5NHMTwh+C23lzNJCTCwwswpVEH3B7RaXCtgizDuzYXTlQwu3nQvYwN0O3Vi6X87MEQaMhlDDq6lr7tGesSaF0HejZQRRG4ADiH9d+XxclQuCIbMfBBMXg+Kt7M6w/MiMrBjJA15woBboiZ8EV8a3+HLvasJ/Coje6PzTtOqUIA1lyHWIOVZHuHeBih7a7HUDiCdAvNne/HK1LEfTiQ91m74B4gPcrXBAm/2N8sZntalg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OAQIBKeZCcsF6faNse8CWrtaZqY9j6jWItLEwzdSx/E=;
 b=WQfJnx3ZzNPt31XD0CRtGLvnrtJGNZaJdAA5SG9hPZAyVAWKRwhq1arH+MnwZHw3uitt7+v+aKWNLZEPSYGLqbghvHezNuasv7RuS6ZpJoM4X08E6UNQjdIdf4VKC1iuw7b8m/1K6pq3zfw0J+zsc8DqFK3M0DdyCKalqQ9nyoXwH57jL8bdjUTNIPwRPsIbT0eF/PEpvJbnQ9dBrQ6KiCliQlkZk/SWdjiszry4s7BrL42BodJMyrd1jUG6CXj6gLug5XhViqKdfqOuPMW61V6WzQptlyEeh22UX/gTuSaRiuyP0WElpHS15HdOhbtvYJGomzwFwlp6H7PSgZf8Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by MN2PR11MB4616.namprd11.prod.outlook.com (2603:10b6:208:26f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Mon, 23 Jan
 2023 18:38:32 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536%3]) with mapi id 15.20.6002.033; Mon, 23 Jan 2023
 18:38:32 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "peterz@infradead.org" <peterz@infradead.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "x86@kernel.org" <x86@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "Brown, Len" <len.brown@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v3] x86/hibernate: Use fixmap for saving unmapped pages
Thread-Topic: [PATCH v3] x86/hibernate: Use fixmap for saving unmapped pages
Thread-Index: AQHZLGEbISjNgrT7Sk+kpITTldc0ya6sVKmAgAAGXYA=
Date:   Mon, 23 Jan 2023 18:38:32 +0000
Message-ID: <6dcd7d8117549fa06240af17ae86ff96c3b91807.camel@intel.com>
References: <20230119235145.22740-1-rick.p.edgecombe@intel.com>
         <948c678b-5f26-2390-dd68-1b9b7b3fd50f@intel.com>
In-Reply-To: <948c678b-5f26-2390-dd68-1b9b7b3fd50f@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|MN2PR11MB4616:EE_
x-ms-office365-filtering-correlation-id: 9ceac960-38b8-4e89-c5bc-08dafd710748
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aDwulLtptBWSQtpYn5Hif7Di2/d9THSzD9ASaBFvTM0gmJF4mxRP/VyGn8Ug5x/pizN2FeH4sLh1yZwgptC7AjBsmFbGWr8vaUjI/N8KyIcAbZEai9fer1g6qXGnUffNEFuWu1ExVEFKApKjuFdHqAHlcerv37hybMyAGmB9exllU91C1oELBi8bjyYxmMa7N9FVcMGt4DDnOgOlZeSatm6kBUuIN6KvT2UGGNZnRNgzCVe/Xqr7oLdMgWFd4MpMifq0xep0T0fa0P6hQ1zPizp+NagldwiD58NMLmyiI25W8Ift3s0ioyz+Q5xVG7PlR+p4+1QUnJlIlxDDjV7594Tp0k+/S+PWWKmCYHTqgTnVYT5gt1ckj+8FcT8Or1wD/U5dxKQWlw1P4CN+JnKKxXECRdLrwRIhsNqhYbJldPDUZ0InZtagtCLZhi/ePPGba/rFR9QPLFzxLwvaJFQ577C8dhAmtAzByFszno/UxI4dvCFHNQx9dfBbzPVnp/M21bnbpW3CEFjAV7NIHNRaq/KXlsDdWVyWC3VMUtntAy/77NTgh3R30IjERBfP9SS3Cf8i/XoCNvk99OsLaRZj36XUJChROkkI2yJ5gg5wI8EXh5Z8LD8rx8knKuZXATdjYGxtuxSvlsuPoFdZjdpyYlf862oY3hYWzPbp4tIWXU5rC7UeyqSRyjkV9hE8v6TIwnp4RGZ4rrARLqMunVuj3Ua8ag8LHy/VnW2uVmSYosTzmyvCUNUaTMAmvOx9xk8Q
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(366004)(376002)(39860400002)(396003)(451199015)(36756003)(316002)(71200400001)(4326008)(66946007)(86362001)(76116006)(66476007)(64756008)(8676002)(91956017)(66446008)(66556008)(6636002)(54906003)(110136005)(26005)(186003)(6512007)(53546011)(6506007)(83380400001)(921005)(478600001)(6486002)(82960400001)(2616005)(38070700005)(7416002)(5660300002)(122000001)(8936002)(41300700001)(2906002)(38100700002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eHBydE9NZGhlak4rYk9MS05jK3JyeVdndnFXbklTV25sQ0pEd0UwSEVEc1pY?=
 =?utf-8?B?aXBLUVNUZFBaeDIvQmdkbkxKWHVIYlRRRFFVRVFQVkpUWWQzM3h2STVzTUc2?=
 =?utf-8?B?UnlLdXh0NWJ2OGV4MXVVQU1iS0ZhZStOMUIxWHhtdVdwVTFiSitmZ2ZGZ0pH?=
 =?utf-8?B?a2dnS1l4NDFJdDdWQktBZUxCSjBIUm1QUVE0V3VZL2J5RVJBYmt6cDE0dXBZ?=
 =?utf-8?B?YytCTjdDc2JqeWRXY0RqNWtSUUpLYmtHNDFZR0FxUWhPV2txSS9GcmJtKzdZ?=
 =?utf-8?B?MVVUaXgxbG9UTTVkQzE4ZzZjQ3lGZGFsODI1VmVGejNMdC9UNlNNendUeUNp?=
 =?utf-8?B?Nks3VXdLOWxWQ09sRW9kUVRUSFVKaVhYSmhPaStWRm1OSTY4b1VhUmlyUVFJ?=
 =?utf-8?B?U0xGRkYwalJuUDNNMnlFbEV0ZzByR2dhWEVMeFlzb0pPYjhzMjluRE44QnRt?=
 =?utf-8?B?VmF0TkhaamliUHU3V2p4MGJFS1k4eDFJUjBVRnoyOUdKTktVajdGY2FmNFZa?=
 =?utf-8?B?R3B4bXhRVVZNVmozWXBNd01tVmRwbGI3Q2pEdW9uMFdlSkV1YVpHME40WXd5?=
 =?utf-8?B?SEp4aFk3MWdBS1pmdytuU0V5WW9ZZFZsbjZsL2tPNy9EeEo3cjNLSmFNRGRa?=
 =?utf-8?B?MEpNV29takFpck5vdGYvL0N1dHNnV1N2L2MvWlhBb0R4Z1Y2UGRSeTlXR3B5?=
 =?utf-8?B?OWFBdEJiaG1vZnh1RCsyaVhVbysxdzJVdWZ1OGNZbjUxd1JJSGduQUdDeUVM?=
 =?utf-8?B?SEVoSGc4YXlrZEoxbWtuNzAxRk1oaUJYMVdUSFppYVBRYXd4SVQyVDVUU3h2?=
 =?utf-8?B?bWY2MVluT3BUNG11aldzeE5ZNkc1cVhEK0cvdHpoYkV5Wm1rSHhJTmkyNmly?=
 =?utf-8?B?K1BGRGhlUmVRRGtPQlJ1a21IMW9IKzF2bHVabHh5TFBoRXBOdTJYanRaTWg5?=
 =?utf-8?B?U2VYNVVBUUFTcmRtaC8yVzZuZ0c3d0NMV1lnK0l6TUJVdk9xL2JKaVhCZzJ0?=
 =?utf-8?B?NGhtLzlyL285dUQ5azdPdU9iK0sxN1NObUxhZ2c2bStSSlZiT2pBS0NkTnZk?=
 =?utf-8?B?VmFSUU1xL2dzUmxsY2l6eXVCVXk5YXcvQWtTS0JuZG9FcjFaU1dkRjJLN0R3?=
 =?utf-8?B?K1B6VFNmeXU0VmhTbmVWSUJGRWhnSkFIenpReWtkeHo4aW1oaUxjU01nc2FM?=
 =?utf-8?B?OUVOdlJ6bjRzKzB2b0hWRUg1M3RmZWpIS0lJM3U3aXpKYllwdElzSGw4WWIr?=
 =?utf-8?B?SHB6dUZuVjlwWVExVlNkYXl3bGp6ZDRlMjBDbE4xa2VUQkdPWElmMVFNdzk3?=
 =?utf-8?B?Q0R3VWhKbHRrSW5uemhWOFAvRG9ja1o3bFgyTi9UL3hlNk92dlR3UWxaTnlj?=
 =?utf-8?B?TXp6UjZmYm5uajRsaWJVeS9jQlZwdEhVUmdocEs4OWM3MEVzUXFSb2tnRVF6?=
 =?utf-8?B?K2g2V0pYREFlZGxWR3pEdFdTbk5nVWtKRDMxeUJLblcrcnhjcVVqS2VhYmJ4?=
 =?utf-8?B?VlhJa29ObHBXVWRjUUxWeDZVazdFWmliN2x2V2JOK2ZPWnQ0Vnhrdk5pVmFz?=
 =?utf-8?B?cXdSY2pjRXpPR3FkVE9DcXhrOEx3WU5Hb2JFYTdoRW5KUGNxd1ltbEJodm9R?=
 =?utf-8?B?SkM2YVJUc1RPRXJJTzkwSUdOQ1Z5bUVBM3ovUVo4TUVhazE5Y3o2WUIxUEZD?=
 =?utf-8?B?VENpWFNvRzJ5bi9QZXFjVHFnNFRNQ3ZWVTRPOVgwTUVMbE5qTEN3dVJ3Wkly?=
 =?utf-8?B?cUxyclJJWGpzUStvVUlPczRIWUJOZjNyMlVSKy91S1lJOGdmaThMVFJyTkpZ?=
 =?utf-8?B?SEhxejloMkNxM1RmR0VjVjdxSFI3djkxYmI4bC9jOE11ZSt4VjJsTGlLK1Ba?=
 =?utf-8?B?WXdIMXpRaEJTaEtoaEpUclZYQ3BKVTBsRllNSEZFVDF4QlFibElVRUpFNDFT?=
 =?utf-8?B?dUM5cWh6UHoyRUcreUVBRUI3bVVGeFZtUHdBdW1ENkllQ3ZiWkV3K0NiUkxJ?=
 =?utf-8?B?czA1TVVzL0pKeTFGMTdIZnd2Mm8rMndvVDdVU1VMVDMyeFgwMjVXM0lhanZC?=
 =?utf-8?B?SS9ZRjRVT3FKTlk2VzNOcHhkR0tJYWVkUlFqUGpTaDNMMThmbTFYbktvdmlM?=
 =?utf-8?B?WVlNKzdadnpvaFEveGQyLzRsN0EzTTFvVUpaMWFRTGdhNzRISkZmSDBtRU1o?=
 =?utf-8?Q?5T0Jfe1VM36RrjwMR/ONlUI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CF7EC5F14B2CD541B023363D66DB9182@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ceac960-38b8-4e89-c5bc-08dafd710748
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2023 18:38:32.1063
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tChRFLhZ7U64HS5n3Bfqd+108gLvH6NqEr0HNpsaL7njH4maOI5CmGNGCqs2d0psQqrQSSEbAcd6+rm4ZlEHREluCuM1RNM944zK0ZL/T4k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4616
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTAxLTIzIGF0IDEwOjE1IC0wODAwLCBEYXZlIEhhbnNlbiB3cm90ZToNCj4g
T24gMS8xOS8yMyAxNTo1MSwgUmljayBFZGdlY29tYmUgd3JvdGU6DQo+ID4gSGliZXJuYXRlIHVz
ZXMgdGhlIGRpcmVjdCBtYXAgdG8gcmVhZCBtZW1vcnkgaXQgc2F2ZXMgdG8gZGlzay4NCj4gPiBT
aW5jZQ0KPiA+IHNvbWV0aW1lcyBwYWdlcyBhcmUgbm90IGFjY2Vzc2libGUgb24gdGhlIGRpcmVj
dCBtYXAgKCJub3QgcHJlc2VudCINCj4gPiBvbg0KPiA+IHg4NiksIGl0IGhhcyBzcGVjaWFsIGNh
c2UgbG9naWMgdG8gdGVtcG9yYXJpbHkgbWFrZSBhIHBhZ2UgcHJlc2VudC4NCj4gPiBPbiB4ODYN
Cj4gPiB0aGVzZSBkaXJlY3QgbWFwIGFkZHJlc3NlcyBjYW4gYmUgbWFwcGVkIGF0IHZhcmlvdXMg
cGFnZSBzaXplcywgYnV0DQo+ID4gdGhlDQo+ID4gbG9naWMgd29ya3Mgb2sgYXMgbG9uZyBhcyB0
aGUgbm90IHByZXNlbnQgcGFnZXMgYXJlIGFsd2F5cyBtYXBwZWQNCj4gPiBhcw0KPiA+IFBBR0Vf
U0laRSBzdWNoIHRoYXQgdGhleSBkb24ndCByZXF1aXJlIGEgc3BsaXQgdG8gbWFwIHRoZSByZWdp
b24gYXMNCj4gPiBwcmVzZW50LiBJZiB0aGUgYWRkcmVzcyB3YXMgbWFwcGVkIG5vdCBwcmVzZW50
IGJ5IGEgbGFyZ2VyIHBhZ2UNCj4gPiBzaXplLCB0aGUNCj4gPiBzcGxpdCBtYXkgZmFpbCBhbmQg
aGliZXJuYXRlIHdvdWxkIHRoZW4gdHJ5IHRvIHJlYWQgYW4gYWRkcmVzcw0KPiA+IG1hcHBlZCBu
b3QNCj4gPiBwcmVzZW50Lg0KPiANCj4gVGhlICJzcGxpdCIgdGhpbmcgaGVyZSBraW5kYSB0aHJl
dyBtZSBhIGJpdC4NCj4gDQo+IEZpcnN0LCB0aGlzIGNvZGUgZGVwZW5kcyBvbiBoYXZpbmcgYSAn
c3RydWN0IHBhZ2UnLiAgT24gNjQtYml0LCB0aGF0DQo+IG1lYW5zIHRoYXQgdGhlIHBhZ2VzIGF0
IGxlYXN0IGhhdmUgYW4gYWRkcmVzcyBpbiB0aGUgZGlyZWN0IG1hcC4NCj4gDQo+IEJ1dCwgdGhh
dCBkb2Vzbid0IG1lYW4gdGhhdCB0aGVyZSdzIGFuIGFjdHVhbCBtYXBwaW5nIGluIHRoZSBkaXJl
Y3QNCj4gbWFwDQo+IGZvciB0aGUgcGFnZS4gIExvdHMgb2YgdGhpbmdzIHphcCB0aGUgZGlyZWN0
IG1hcC4gIFRvIG1ha2UgdXAgZm9yDQo+IHRoaXMsDQo+IHRoZSBoaWJlcm5hdGUgY29kZSB0cmll
cyB0byB0ZW1wb3JhcmlseSByZXN0b3JlIGEgemFwcGVkIG1hcHBpbmcgd2l0aA0KPiBoaWJlcm5h
dGVfbWFwX3BhZ2UoKS0+c2V0X2RpcmVjdF9tYXBfZGVmYXVsdF9ub2ZsdXNoKCkuDQo+IA0KPiBX
aGF0J3MgdGhlIGFjdHVhbCBmYWlsdXJlIG1vZGUgaGVyZSwgdGhvdWdoPyAgDQoNCkl0J3MgYSB0
aGVvcmV0aWNhbCBmYWlsdXJlIHRoYXQgd2FzIHJhaXNlZCBpbiB0aGUgcGFzdC4gTGFzdCB0aW1l
LCBNaWtlDQpSYXBvcG9ydCBhZGRlZCB0aGUgd2FybmluZ3MgaW4gaGliZXJuYXRlLiBUaGV5IGhh
dmUgbm90IGJlZW4gc2Vlbg0KQUZBSUssIGJ1dCBJIGRvbid0ICp0aGluayogdGhlcmUgY2FuIGJl
IGFueSBodWdlIE5QIG1hcHBpbmdzIG9uIHRoZQ0KZGlyZWN0IG1hcCB0b2RheSBlaXRoZXIuDQoN
ClRoZSBmYWlsdXJlIHNjZW5hcmlvIGlzIHRoZXJlIGlzIGEgMk1CIHJlZ2lvbiAibWFwcGVkIiB3
aXRoIGFuIE5QDQptYXBwaW5nIChieSB0aGF0IEkgbWVhbiB0aGUgcmVnaW9uIG9mIHRoZSBkaXJl
Y3QgbWFwIHdoZXJlIHRoZSBwYWdlIGlzDQptYXBwZWQgaXMgbWFya2VkIGFzIG5vdCBwcmVzZW50
KS4gVGhlbiB3aGVuIGhpYmVybmF0ZSBpcyBzYXZpbmcgdGhlDQpwYWdlLCBpdCB0cmllcyB0byBz
ZXQgYSA0ayBwYWdlIGluIHRoYXQgcmVnaW9uIGFzIHByZXNlbnQuIENQQSB3aWxsIHRyeQ0KdG8g
Y3JlYXRlIGEgNGsgcmVnaW9uIG1hcmtlZCBwcmVzZW50IGFuZCB0aGUgcmVzdCByZW1haW5pbmcg
TlAuIFNvIGl0DQpzaG91bGQgdHJ5IHRvIHNwbGl0IHRoZSBodWdlIG1hcHBpbmcsIHdoaWNoIHJl
cXVpcmVzIGFuIGFsbG9jYXRpb24gZm9yDQp0aGUgbmV3IHRhYmxlIHdoaWNoIGNvdWxkIGZhaWwu
DQoNCj4gRG9lcyBfX2NoYW5nZV9wYWdlX2F0dHIoKQ0KPiBqdXN0IGZhaWwgdG8gZmluZCBhbiBl
eGlzdGluZyBQVEUgYW5kIGZhbGwgb3Zlcj8gIE9yLCBkb2VzIGl0DQo+IGFjdHVhbGx5DQo+IHRy
eSB0byBhbmQgZmFpbCB0byBhbGxvY2F0ZSB0aGUgUFRFIHBhZ2U/DQoNCkluIENQQSwgaWYgdGhl
IGFsbG9jYXRpb24gZm9yIHRoZSBuZXcgdGFibGUgZmFpbHMgaXQgd291bGQgYWJvcnQgYW5kDQpy
ZXR1cm4gYW4gZXJyb3IgdG8gaGliZXJuYXRlLCB3aGljaCB3b3VsZCBwcmludCBhIHdhcm5pbmcg
dGhlbiBjcmFzaA0KdHJ5aW5nIHRvIGNvcHkgaXQgYXMgaXQgcmVhZHMgZnJvbSBhbiBOUCBtYXBw
aW5nLg0K
