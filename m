Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8633B67DF87
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 09:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232616AbjA0Iwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 03:52:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231709AbjA0Iwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 03:52:33 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C562331C
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 00:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674809549; x=1706345549;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LZGI5SYup6G5DFJskpWwkDzq3c3rBwOxLR6brrbhIBo=;
  b=aOM7p0nfCTS0LUcYr+w4uZLznvNfVe2EibqSaZiL9wuVyHJhVZjJZr2B
   ftxaoKNid7d5XvvflekG/pl5D3KlUEgqegnm10Nw6+aeh31aqrLbTktxp
   WSPZ9S3d4grYoVehDTzR02Le2Houru5sRN3h1B9IvelmoXDd6BDWlXLf2
   hZuTBSIxU7sMScGuYyRLiMKdThvNMkFK3FZZbazr4InA0l8G/MJl+638K
   jRXrgi+Iz/gidao2QVkUflgmccGylCz0GjRD/dqKt4ca2HNZ6kbf4PwQB
   kV/xKMM1GfamI8rMDIT724r/QOQa4+BD5v/tInbU+GDWPZm8GWuC1N9v1
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="389420271"
X-IronPort-AV: E=Sophos;i="5.97,250,1669104000"; 
   d="scan'208";a="389420271"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 00:52:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="787154857"
X-IronPort-AV: E=Sophos;i="5.97,250,1669104000"; 
   d="scan'208";a="787154857"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP; 27 Jan 2023 00:52:28 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 27 Jan 2023 00:52:28 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 27 Jan 2023 00:52:27 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 27 Jan 2023 00:52:27 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 27 Jan 2023 00:52:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ViSTXs7QGFzOtFuV87oSpcQGDAJaWJ8rkadPG2jGHZjRUOHUaAOEPJEhy9uB6KqVoAJNR4ZLnzbE+L/212PsAScqR+bQDzn871sl9+r5u1yC2Z1NUZdQ/alMXQCZOxMbbWLkCUgU1nC0rznl3ULfmzp3HJXb9xW8BEHSwqW2aS1Z9Ocab+l6pZvM/K5rovYWOPw+1vVo8hjjEktVbpbAIXvw/o1L1shOA7Hv5uXxI/G9dxAsmu+bB+AVijxnHojqji5dk2SnwmI5Z3FrgG2Xj/VGVRGvITxg283FIJuQJx1GebZFlCJyR8lZDCaXMDdVSTRvGfMG5slzliLrSPtrvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LZGI5SYup6G5DFJskpWwkDzq3c3rBwOxLR6brrbhIBo=;
 b=X7BncBN+BaZP2B7lgEUbaaUbMW7HeX311+/enJ25QzCZIRzwvZ2lVljO2Lg0xxGlYulUwMsVGRz4yjluaREYHaic01Mp9vvdqLyNatkb4GYGcZnEnfndclE47DCti3z8icEzjnXgsP8+rkFI/JKtgVTzNlnGIU0LnVzgB+pWHEnKZJxaY0cUWfg6OczvIjogOvULF2GnZvhpZF1o+6IRxwnJMK8R1YVWU0JOJlko8Tl9a+K6IrueBv3yu5aZo9cBsvmikOLz91oXvQnRolz4T0aPgF/Bi81SOHcR7BGhUbe51S1hXSVm/V+7UX7Iy+/yHf/Mn7iqCaDULsg7OBg0UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5750.namprd11.prod.outlook.com (2603:10b6:8:11::17) by
 PH0PR11MB5612.namprd11.prod.outlook.com (2603:10b6:510:e7::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6043.22; Fri, 27 Jan 2023 08:52:23 +0000
Received: from DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::f0e0:ca50:78eb:1030]) by DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::f0e0:ca50:78eb:1030%5]) with mapi id 15.20.6043.022; Fri, 27 Jan 2023
 08:52:22 +0000
From:   "Reshetova, Elena" <elena.reshetova@intel.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Shishkin, Alexander" <alexander.shishkin@intel.com>,
        "Shutemov, Kirill" <kirill.shutemov@intel.com>,
        "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@intel.com>,
        "Kleen, Andi" <andi.kleen@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Wunner, Lukas" <lukas.wunner@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jason Wang <jasowang@redhat.com>,
        "Poimboe, Josh" <jpoimboe@redhat.com>,
        "aarcange@redhat.com" <aarcange@redhat.com>,
        Cfir Cohen <cfir@google.com>, Marc Orr <marcorr@google.com>,
        "jbachmann@google.com" <jbachmann@google.com>,
        "pgonda@google.com" <pgonda@google.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        James Morris <jmorris@namei.org>,
        Michael Kelley <mikelley@microsoft.com>,
        "Lange, Jon" <jlange@microsoft.com>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Subject: RE: Linux guest kernel threat model for Confidential Computing
Thread-Topic: Linux guest kernel threat model for Confidential Computing
Thread-Index: AdkwsXY+8ptYLAlAQXCgWg2jZ1ntPwACTigAAAR067AANbNtAAAhqAlg
Date:   Fri, 27 Jan 2023 08:52:22 +0000
Message-ID: <DM8PR11MB5750678B5F639F6C2848FC3CE7CC9@DM8PR11MB5750.namprd11.prod.outlook.com>
References: <DM8PR11MB57505481B2FE79C3D56C9201E7CE9@DM8PR11MB5750.namprd11.prod.outlook.com>
 <Y9EkCvAfNXnJ+ATo@kroah.com>
 <DM8PR11MB5750FA4849C3224F597C101AE7CE9@DM8PR11MB5750.namprd11.prod.outlook.com>
 <20230126105618-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230126105618-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5750:EE_|PH0PR11MB5612:EE_
x-ms-office365-filtering-correlation-id: 26d6f71d-4cf9-400f-bdc0-08db0043ce3e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BMJzS190Bd6YDGdBML4xQ6IW2mTewfZ5CqA1MMbrU3QQEvLMklslbiMr6mNbwcafp66ypU0svpzyVzsOKM5pa+Lzjb6WnlmIHT3FzAJd8UfNqCWjJuMqeRs3Sq+wTohGmQFsc4xwJNKX+bSX6BXvE1UyLSeqgRqxf+lc+pDo5kCx4UgvO98BvtsFENmtN/h2fJqbLIuQeH6GM3u3W5UlJfVmmnDc2JMYHkOEUGCDDkjxfPqdVK2IL2YUZhPoOGO+gcEfcARN0YX5uG2uXPfWso0LcindfH2rsj+B0yMiAHBqiN5y+TH6eqXU/WCWXN0gda5E08E/BUcX8wdMl9GGWy4l/UeUFrs0N2NoG5mOB8L8l4ItRXm7etLQyE5tHiAw43m29NCMlS2GboV0AUeKPGDBjwrFTq581bgiAMp165GZWZG2o7J3X4qFk85pzvbD6FSs7m0+e9Dgt8IxJKRkNQFs6wKx1r3TiGrMw3/KqzM2aq9SC5cztA4tIyy+aBICmuZzP/uIls7FZBZhkHFb1f24+QxdWV6SuCzdtfnGzOiDi6FDVB9o2gQhqFJR4p9vtW3DbVKLxbWy0NcP5up/dZnYTMTK6ul9+hQIYG36ZRq5N9hLwtTttoTSLjeK+i4uQFekCshGFXvcWbjViI27Lmqc7gsx+r2OPHlpPYxXlBOF7HB7znOXqWPtjfhREuvTvUnpfRflRyMFHngl1DpDoQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5750.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(366004)(39860400002)(376002)(396003)(136003)(451199018)(7696005)(33656002)(83380400001)(8676002)(71200400001)(478600001)(6506007)(66446008)(54906003)(5660300002)(7416002)(76116006)(6916009)(2906002)(4326008)(52536014)(66946007)(64756008)(66476007)(66556008)(8936002)(41300700001)(38070700005)(316002)(38100700002)(55016003)(122000001)(186003)(86362001)(82960400001)(26005)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NVFOZk8zQVF6dERLL0x0Q0xHLzVLWWl5eVVVTEZnNEJDblFaWThZYTNDL3Js?=
 =?utf-8?B?bFlOOWV2QUZaaU1MbXFPWldiYmVtQmxxS3NmTEpKK2prcWY5ZWptQ1YxbC90?=
 =?utf-8?B?N0toSWpuNUVoS0FBSEF1QTVJMnV2UjF3NW1iQ29TcUpyaVBQUW9kRFhCWGxY?=
 =?utf-8?B?SlNNbHAwakZZdExjU2syejg2VHluWjkvT0k0RG9namRDTHFvWllUMWVseVVz?=
 =?utf-8?B?N2tmYVplMWEveU9kbVdROFJPUVZmUjFKMVF1ODZidnlxQVJLUXdMRHlqTW1l?=
 =?utf-8?B?eVJSRFAvK2xMdUNJdFFwb1RnTTVObTVBdlpZbEVrUnlpM2M0V1RlQzdncFFB?=
 =?utf-8?B?K1FjTzI4U2RtWFVhamJGQ1JWNnlPa0RKVHB2bmVRc2RRbFA4aDMzditmZVdj?=
 =?utf-8?B?UDViVitCMUl0WGVkZ21kSFhqRkRQd2NVT2hLYnlvbUJtUmxiR0Mzb1lSQ2lr?=
 =?utf-8?B?NExHOHVXelB2U2pQazkrM2hXRDd0bTVuR3krakxobFBPaHZVbUc3RjdBYXBB?=
 =?utf-8?B?N1pGUDhnbFhDUTVVV0J5eXFwaTlMVndUZVkxMTFDMVd6b3M1UHErU2JnazFr?=
 =?utf-8?B?VW1SSXl2K0Fad3VYN200YjhLL3FNVTBQT2V4Nzg1RVVPNWdFYXRwQ01Femp5?=
 =?utf-8?B?YkQ5OHYvSWVzUTY2RnIxQ2NrRnpjMjNZNDQwVTNEL3FtRjRkaHhKRDFKNjFZ?=
 =?utf-8?B?NG9yek1hNjY1cFFFM0syaGdVUG0wZ2JZQWs1ejEybGhDK3RiY1Q0Z2tab3Q4?=
 =?utf-8?B?Vm43YzdhaFdDcGJIZU9XUURCaEVOYnRuR29ILzEzdU1WVndmcVRrcisvYnRQ?=
 =?utf-8?B?RndTKzU4REFSc21kRTBsSjNQdVZIT3pqdjlvcmQzZTBhRkFSVm9WR3VkS0ZI?=
 =?utf-8?B?clo3RzBlVTZUK0lFVFRNMysrM2VRL0RLQ0NlU1dEc0dtVmF5T25IbzNhQkU1?=
 =?utf-8?B?QlRmM2hZajJaQUlxWmExMlMwc1czNmlDUTRnbm1jMkVLcFZINkpWMFVLUkxa?=
 =?utf-8?B?UjlDc0FwbzUxalVOUjNHSFp6QTNoT213V2lOTVVURDIraWNXUmNqcjMrUmxn?=
 =?utf-8?B?Ymtrdy9XVE9nR0tEdllpWmxFN3A1WDU3aHFOT3MxRitMZDNiVUl0TE55U3c5?=
 =?utf-8?B?VURNZlJyUExTWW1KSHptd1Fhb1V2SEhIQ2RvWmFBTG1yY1o4akdVcTRyNjI0?=
 =?utf-8?B?bVpnZUVVaVF2Qjh1SjA3QXByYnZvWHJQZzBqMVd2QkJvMW9wTFBlakZhdzBm?=
 =?utf-8?B?ZnF4Y1FYZnZYNGx6RXpSd1NJdFBpcldTcmxQa3NVN3ZqYlRmRzZzSmVqelhi?=
 =?utf-8?B?c09SbWorKzlYazh1RWlBeU9lQVRVVkl2eDgrbXkwMTkwV2ErdDFoVGxFVFJm?=
 =?utf-8?B?L2NaME9JM1hvZi9TOGFmb0ZXTVhxb3NyOUttREduSzh2L3FXZC9hejBBZFRJ?=
 =?utf-8?B?UWNRUnlWUXlqT0k5UjUwM1M3R005cWpkK29XWG02ejliL1pKNTJqN2krUlVB?=
 =?utf-8?B?RWFYdnhXZUJuMHVBTCtiemJaZmQvLy9IWmt4VEt0bkhwZ1FTbTRLNTdGcyts?=
 =?utf-8?B?bW1wcEhhWER6NXdXMTR5MzA1Y0I0L0VRZkc4U1VvcHE2R0xiWUpidmEza0h5?=
 =?utf-8?B?VFdPVHpLTWJsaXpLcmZ6OUJ5cHNzU0dlcWVJbHFyOEQvWVVuS2pDelpkTWYw?=
 =?utf-8?B?WjBEMitueWF5QzNGV1J5Y3QzRytUTlk2Qm13UWtPSUhYaUpCZkZwY2hKSFhR?=
 =?utf-8?B?MFpSSXJPMUloYVNBNzIydFBVZTlHZjFpa3ZjcjVNTWJxQTEvckRMYlJKY2Ir?=
 =?utf-8?B?cW4wb2dEdkhVb2xVeTNTdEVhbzJZR2doU3l4eWVuUnlsVTUwUFFYTjZmS1NL?=
 =?utf-8?B?RnlaWVRsNHR4VjBOaW5Hckl4TzAwcm5EdGljWHRETzY2bUQwMzFZVGQvdVd1?=
 =?utf-8?B?amdDN2FEbEpsRnlSN21scEs5eEZyckFmdTBKekwxbjBHZDFsMmEzZmxLaE5r?=
 =?utf-8?B?KzhWMmQ0UnN1RU1wWUVaTnJ4NXRndzA2L2d0Q1BFaS9Dbm81RzcyZXJlQ2ZS?=
 =?utf-8?B?ejZ2dXd2VFhyMVh6QUt1alhkMWpMTm5vT2ZlbGNTM3RBNG9iS01XblhEcGN1?=
 =?utf-8?Q?rEMs56JtlD554OcG184qME4z6?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5750.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26d6f71d-4cf9-400f-bdc0-08db0043ce3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2023 08:52:22.5771
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KHpeJla6aGCX4RMacMLOVDPv9KiWyTZQPwO4AuyT58bFrLsnIkLdA+pfR9g6BtETR5gy3hNBrElIEa3pDDR+P8EP4b1oWZSZew5fQsHjStI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5612
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBXZWQsIEphbiAyNSwgMjAyMyBhdCAwMzoyOTowN1BNICswMDAwLCBSZXNoZXRvdmEsIEVs
ZW5hIHdyb3RlOg0KPiA+IEFuZCB0aGlzIGlzIGEgdmVyeSBzcGVjaWFsIGFzcGVjdCBvZiAnaGFy
ZGVuaW5nJyBzaW5jZSBpdCBpcyBhYm91dCBoYXJkZW5pbmcgYQ0KPiBrZXJuZWwNCj4gPiB1bmRl
ciBkaWZmZXJlbnQgdGhyZWF0IG1vZGVsL2Fzc3VtcHRpb25zLg0KPiANCj4gSSBhbSBub3Qgc3Vy
ZSBpdCdzIHRoYXQgc3BlY2lhbCBpbiB0aGF0IGhhcmRlbmluZyBJTUhPIGlzIG5vdCBhIHNwZWNp
ZmljDQo+IHRocmVhdCBtb2RlbCBvciBhIHNldCBvZiBhc3N1bXB0aW9ucy4gSUlVQyBpdCdzIGp1
c3Qgc29tZXRoaW5nIHRoYXQNCj4gaGVscHMgcmVkdWNlIHNldmVyaXR5IG9mIHZ1bG5lcmFiaWxp
dGllcy4gIFNpbWlsYXJseSwgb25lIGNhbiB1c2UgdGhlIENDDQo+IGhhcmR3YXJlIGluIGEgdmFy
aWV0eSBvZiB3YXlzIEkgZ3Vlc3MuIEFuZCBvbmUgd2F5IGlzIGp1c3QgdGhhdCAtDQo+IGhhcmRl
bmluZyBsaW51eCBzdWNoIHRoYXQgYWJpbGl0eSB0byBjb3JydXB0IGd1ZXN0IG1lbW9yeSBkb2Vz
IG5vdA0KPiBhdXRvbWF0aWNhbGx5IGVzY2FsYXRlIGludG8gZ3Vlc3QgY29kZSBleGVjdXRpb24u
DQoNCkkgYW0gbm90IHN1cmUgaWYgSSBmdWxseSBmb2xsb3cgeW91IG9uIHRoaXMuIEkgZG8gYWdy
ZWUgdGhhdCBpdCBpcyBpbiBwcmluY2lwbGUNCnRoZSBzYW1lICdoYXJkZW5pbmcnIHRoYXQgd2Ug
aGF2ZSBiZWVuIGRvaW5nIGluIExpbnV4IGZvciBkZWNhZGVzIGp1c3QNCmFwcGxpZWQgdG8gYSBu
ZXcgYXR0YWNrIHN1cmZhY2UsIGhvc3QgPC0+IGd1ZXN0LCB2cyB1c2Vyc3BhY2UgPC0+a2VybmVs
Lg0KSW50ZXJmYWNlcyBoYXZlIGNoYW5nZWQsIGJ1dCB0aGUgdHlwZXMgb2YgdnVsbmVyYWJpbGl0
aWVzLCBldGMgYXJlIHRoZSBzYW1lLg0KVGhlIGF0dGFja2VyIG1vZGVsIGlzIHNvbWV3aGF0IGRp
ZmZlcmVudCBiZWNhdXNlIHdlIGhhdmUgDQpkaWZmZXJlbnQgZXhwZWN0YXRpb25zIG9uIHdoYXQg
aG9zdC9oeXBlcnZpc29yIHNob3VsZCBiZSBhYmxlIHRvIGRvDQp0byB0aGUgZ3Vlc3QgKGZvbGxv
d2luZyBidXNpbmVzcyByZWFzb25zIGFuZCB1c2UtY2FzZXMpLCB2ZXJzdXMgd2hhdCB3ZQ0KZXhw
ZWN0IG5vcm1hbCB1c2Vyc3BhY2UgYmVpbmcgYWJsZSB0byAiZG8iIHRvd2FyZHMga2VybmVsLiBU
aGUgaG9zdCBhbmQNCmh5cGVydmlzb3Igc3RpbGwgaGFzIGEgbG90IG9mIGNvbnRyb2wgb3ZlciB0
aGUgZ3Vlc3QgKGFiaWxpdHkgdG8gc3RhcnQvc3RvcCBpdCwgDQptYW5hZ2UgaXRzIHJlc291cmNl
cywgZXRjKS4gQnV0IHRoZSByZWFzb25zIGJlaGluZCB0aGlzIGRvZXNu4oCZdCBjb21lDQpmcm9t
IHRoZSBmYWN0IHRoYXQgc2VjdXJpdHkgQ29DbyBIVyBub3QgYmVpbmcgYWJsZSB0byBzdXBwb3J0
IHRoaXMgc3RyaWN0ZXINCnNlY3VyaXR5IG1vZGVsIChpdCBjYW5ub3Qgbm93IGluZGVlZCwgYnV0
IHRoaXMgaXMgYSBkZXNpZ24gZGVjaXNpb24pLCBidXQNCmZyb20gdGhlIGZhY3QgdGhhdCBpdCBp
cyBpbXBvcnRhbnQgZm9yIENsb3VkIHNlcnZpY2UgcHJvdmlkZXJzIHRvIHJldGFpbiB0aGF0DQps
ZXZlbCBvZiBjb250cm9sIG92ZXIgdGhlaXIgaW5mcmFzdHJ1Y3R1cmUuIA0KIA0KPiANCj4gSWYg
eW91IHB1dCBpdCB0aGlzIHdheSwgeW91IGdldCB0byBwYXJ0aWNpcGF0ZSBpbiBhIHdlbGwgdW5k
ZXJzdG9vZA0KPiBwcm9ibGVtIHNwYWNlIGluc3RlYWQgb2YgY29uc3RhbnRseSBzYXlpbmcgInll
cyBidXQgQ0MgaXMgc3BlY2lhbCIuICBBbmQNCj4gZnVydGhlciwgeW91IHdpbGwgbm93IHRhbGsg
YWJvdXQgZmVhdHVyZXMgYXMgb3Bwb3NlZCB0byBmaXhpbmcgYnVncy4NCj4gV2hpY2ggd2lsbCBz
dG9wIGFubm95aW5nIHBlb3BsZSB3aG8gY3VycmVudGx5IHNlZW0gYW5ub3llZCBieSB0aGUNCj4g
aW1wbGljYXRpb24gdGhhdCB0aGVpciBjb2RlIGlzIGJ1Z2d5IHNpbXBseSBiZWNhdXNlIGl0IGRv
ZXMgbm90IGNhY2hlIGluDQo+IG1lbW9yeSBhbGwgZGF0YSByZWFkIGZyb20gaGFyZHdhcmUuIEZp
bmFsbHksIHlvdSB0aGVuIGRvbid0IHJlYWxseSBuZWVkDQo+IHRvIGV4cGxhaW4gd2h5IGUuZy4g
RG9TIGlzIG5vdCBhIHByb2JsZW0gYnV0IGluZm8gbGVhayBpcyBhIHByb2JsZW0gLSB3aGVuDQo+
IGZvciBtYW55IHVzZXJzIGl0J3MgYWN0dWFsbHkgdGhlIHJldmVyc2UgLSB0aGUgcmVhc29uIGlz
IG5vdCB0aGF0IGl0J3MNCj4gbm90IHBhcnQgb2YgYSB0aHJlYXQgbW9kZWwgLSB3aGljaCB0aGVu
IG1ha2VzIHlvdSB3b3JrIGhhcmQgdG8gZGVmaW5lDQo+IHRoZSB0aHJlYXQgbW9kZWwgLSBidXQg
c2ltcGx5IHRoYXQgQ0MgaGFyZHdhcmUgZG9lcyBub3Qgc3VwcG9ydCB0aGlzDQo+IGtpbmQgb2Yg
aGFyZGVuaW5nLg0KDQpCdXQgdGhpcyB3b24ndCBiZSBjb3JyZWN0IHN0YXRlbWVudCwgYmVjYXVz
ZSBpdCBpcyBub3QgbGltaXRhdGlvbiBvZiBIVywgYnV0IHRoZQ0KdGhyZWF0IGFuZCBidXNpbmVz
cyBtb2RlbCB0aGF0IENvbmZpZGVudGlhbCBDb21wdXRpbmcgZXhpc3RzIGluLiBJIGFtIG5vdCAN
CmF3YXJlIG9mIGEgc2luZ2xlIGNsb3VkIHByb3ZpZGVyIHdobyB3b3VsZCBiZSB3aWxsaW5nIHRv
IHVzZSB0aGUgSFcgdGhhdA0KdGFrZXMgdGhlIGZ1bGwgY29udHJvbCBvZiB0aGVpciBpbmZyYXN0
cnVjdHVyZSBhbmQgcnVubmluZyBjb25maWRlbnRpYWwgZ3Vlc3RzLA0KbGVhdmluZyB0aGVtIHdp
dGggbm8gbWVjaGFuaXNtcyB0byBjb250cm9sIHRoZSBsb2FkIGJhbGFuY2luZywgZW5mb3JjZQ0K
cmVzb3VyY2UgdXNhZ2UsIGV0Yy4gU28sIGdpdmVuIHRoYXQgbm9ib2R5IG5lZWRzL3dpbGxpbmcg
dG8gdXNlIHN1Y2ggSFcsIA0Kc3VjaCBIVyBzaW1wbHkgZG9lc27igJl0IGV4aXN0LiANCg0KU28s
IEkgd291bGQgc3RpbGwgc2F5IHRoYXQgdGhlIG1vZGVsIHdlIG9wZXJhdGUgaW4gQ29DbyB1c2Vj
YXNlcyBpcyBzb21ld2hhdA0Kc3BlY2lhbCwgYnV0IEkgZG8gYWdyZWUgdGhhdCBnaXZlbiB0aGF0
IHdlIGxpc3QgYSBjb3VwbGUgb2YgdGhlc2Ugc3BlY2lhbCBhc3N1bXB0aW9ucw0KKG92ZXIgd2hp
Y2ggb25lcyB3ZSBoYXZlIG5vIGNvbnRyb2wgb3IgYWJpbGl0eSB0byBpbmZsdWVuY2UsIG5vbmUg
b2YgdXMgYXJlIGJ1c2luZXNzDQpwZW9wbGUpLCB0aGVuIHRoZSByZXN0IGJlY29tZXMganVzdCBj
YXJlZnVsIGVudW1lcmF0aW9uIG9mIGF0dGFjayBzdXJmYWNlIGludGVyZmFjZXMNCmFuZCBicmVh
ayB1cCBvZiBwb3RlbnRpYWwgbWl0aWdhdGlvbnMuIA0KDQpCZXN0IFJlZ2FyZHMsDQpFbGVuYS4N
Cg0KDQo=
