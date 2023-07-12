Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9916C74FC08
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 02:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbjGLAPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 20:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjGLAPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 20:15:30 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E239171C
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 17:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689120929; x=1720656929;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rmLXNkbZo3xzV92L3eqoQb6QKSq4S4Jar+nk5VhgZ/M=;
  b=Wphh/ClfI2Gb68ndRy+O3QR91neLe3e6jZvgvZTGagR1j4Xk/vMNgHPy
   IpTxXrZNabojH9z0BE5Nr1/pFQSrKGLzrUerhFlG3HPFEgI7T/kuPntnC
   5G3ztpamEuwiVnovUBXT26HlZiykZuL1KbWrPrV33VE8iFqb7Juq6FViz
   q5YpG8FXmB2NoMQolTm/j7Iis0ZD8M4dDGJwFQPnIx0Kc5NEJ/fNc5Rr6
   +/LjkEKEOeXAfah0u9LLwoTM6A3KrggRybaq92tMrwESIMX8HRDwF5gWk
   78epJmiGrsMktGxSOWE4RYAwGeusDNN/EvuIyHc2OZwg04pvL3hI5Ctwd
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="451130692"
X-IronPort-AV: E=Sophos;i="6.01,198,1684825200"; 
   d="scan'208";a="451130692"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 17:15:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="811396064"
X-IronPort-AV: E=Sophos;i="6.01,198,1684825200"; 
   d="scan'208";a="811396064"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Jul 2023 17:15:28 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 11 Jul 2023 17:15:27 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 11 Jul 2023 17:15:27 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 11 Jul 2023 17:15:27 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 11 Jul 2023 17:15:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=brNhBHLGotXtW7kRJexoNv5FAKGuawtdtW80TvjU9a+KuVC7IGu3+1ATTN9ssTvQFAkh2YJW1MeB6cjFvyZr2nYmIP0QrWCFlwLOn6/1X1pEA7gOpD2+3kuscaLiVPjEMyL3RMDtMw51vWKTiP0vfUn10lS6VhOul7e+O2ZdmxZQYqTCegQbUNUl4FVPmU4dFoFuA6mC9VuFVoKloK1UB4rUfAudjrtDP0TrdF7tKhjilXl+Q5uoSgPbfM0He7zmRljw34rKMh5f1b0CMNk3h1t5aVzxAVrMWoMYdKe1TIdAgDf/r3P74Pr1oW5v9jOsFDUBW635aUFlE9PaG6hUJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rmLXNkbZo3xzV92L3eqoQb6QKSq4S4Jar+nk5VhgZ/M=;
 b=Igm2dF/Pf8NKLgzo+pxMfamx4Jw+qMmketukgpCzJGdaL/HTkSkzjJnfrMKPisMNzP7KaxMrkt8GDkHZBgcWTD++uBlRUwJY03G2HY4DwKN4xLxaNamdn0N48dlB7d1WTn2Jxnt/tpbI3YeQR70xJgvt6Na+ADY8khkuvt5bDUONJ5f+DjXmpQrfAIvdKpskm7UEUAppsU9neaRHtIi0wmBgBrDkG/Ck9KH/y46DEMlLZXSzXsLaUbryYYIZTwRdunBOwC3GbtGbls3DYoT1/d14wvErrRBRDBdgJXC1aoCcroZxwLE6Et3A4v9t6xu7HtacljFWsHAx853kUSyk+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB7590.namprd11.prod.outlook.com (2603:10b6:806:348::13)
 by MW3PR11MB4715.namprd11.prod.outlook.com (2603:10b6:303:57::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 00:15:25 +0000
Received: from SN7PR11MB7590.namprd11.prod.outlook.com
 ([fe80::5dd7:db99:bf1a:4702]) by SN7PR11MB7590.namprd11.prod.outlook.com
 ([fe80::5dd7:db99:bf1a:4702%4]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 00:15:24 +0000
From:   "Ma, Yu" <yu.ma@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     "Liam.Howlett@Oracle.com" <Liam.Howlett@Oracle.com>,
        "kirill@shutemov.name" <kirill@shutemov.name>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Zhu, Lipeng" <lipeng.zhu@intel.com>,
        "Deng, Pan" <pan.deng@intel.com>,
        "shakeelb@google.com" <shakeelb@google.com>,
        "Li, Tianyou" <tianyou.li@intel.com>,
        "Chen, Tim C" <tim.c.chen@intel.com>,
        "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>
Subject: RE: [PATCH v2] mm/mmap: move vma operations to mm_struct out of the
 critical section of file mapping lock
Thread-Topic: [PATCH v2] mm/mmap: move vma operations to mm_struct out of the
 critical section of file mapping lock
Thread-Index: AQHZtBg5DYxBd7/ZuUuEgQIQKNNwZa+04sMAgABepUA=
Date:   Wed, 12 Jul 2023 00:15:24 +0000
Message-ID: <SN7PR11MB75907B372E6A2D273A6AFFA9E136A@SN7PR11MB7590.namprd11.prod.outlook.com>
References: <SN7PR11MB75902EEF55E7ABE8189C6CABE12CA@SN7PR11MB7590.namprd11.prod.outlook.com>
        <20230711172020.562250-1-yu.ma@intel.com>
 <20230711112824.e559065488b08ce649cccfd7@linux-foundation.org>
In-Reply-To: <20230711112824.e559065488b08ce649cccfd7@linux-foundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB7590:EE_|MW3PR11MB4715:EE_
x-ms-office365-filtering-correlation-id: 913757dd-fa9a-4e47-51d2-08db826d16b8
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zQBlyjXOY7M/TQ4PK+hGr0EiWVW8jXhjUs1p9cyLvNn7F1phISbcjGkbjHp375mgSg1tuAH9L8+GRa2EkuBis9RDbxnBhJM9zFEN4dV7HyWfU+YiTOgaSVkRj7kd9z8rRStIvuZ3snOvTste6Uk5DBaluOKXFDZF3B8moHSgmCnxQIGpGngT/mZIwy7FUL7EweldjYX/R4bRtR1+yfmBjhIWJtWlZcQCo3VUkuhoEzbZdWmPZdMla4cfX2X0jJ2HG8A85yBFq8I78ZIR3tfkNkInaU2FiUDXLHqK7vPkzA4DEYBbPGUBu5t/I005x7/zTNz3et3D/E58/7P2/vVYSprX2PCpPzQXPN6bKLsrSK9UGQAUPHKWSOipGsKEGfOrWI82P6Ou7OJnt704iahd1e56zcqhDv8NN2mo6xmc0tQJGoxSK9+BqBeP9n6C5yLdXiXbI4EyMGbpJBzsVk7K/RTp3nZySB/m1+TBsgyzgtrJVWdc0f5/x7RV8fJFVByYcC0CQY3Uv08fXKssjvJ1wdvTfPODTQiNtQoeB541BXZfUeOIYDHcwmYIqcokXOswjhCFel/G4C8EtpBUDnv1v8kDbOI9UOC5l7jd3jxZydo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7590.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(39860400002)(136003)(366004)(346002)(451199021)(71200400001)(966005)(9686003)(316002)(7696005)(54906003)(4326008)(122000001)(55016003)(76116006)(38070700005)(38100700002)(478600001)(2906002)(66556008)(64756008)(66476007)(66446008)(66946007)(6916009)(82960400001)(83380400001)(5660300002)(8676002)(8936002)(52536014)(186003)(26005)(41300700001)(86362001)(53546011)(33656002)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N2JuV3p1bTZua29mVVdiVXc1Mm1iNnMxWUVCUVJmN0MxYjlGODVQR09jSjl4?=
 =?utf-8?B?Q0tKNitPN01pOXc3bEdtWlpEd1NjUzcxTE9vNFQxN3JaL0FMdHoxUUJ3cXlI?=
 =?utf-8?B?Q3lUYmVLZTlBd1M1RWVuRlpVWGxHVkNwT3hDdGhmVXNiWUpkRFYxQWVDbDMx?=
 =?utf-8?B?ZStlZkprRGpsY1NTUzZnWDNoTUVvdDh0UFJJbnhDc2R5SzRKbWVhdjlnSTV2?=
 =?utf-8?B?cDdRb3NOSFFmSmdIQUJPS2UyNkdia21DaHR0THpwTHdDS2ZMeGcvSzJwWm1W?=
 =?utf-8?B?UDFWOXVSeklQd0VWbDQxMHAyY3VGcG8zQlhMZUlMMU1MTWt6dWxSUkRzbyt2?=
 =?utf-8?B?WlMzeEREbDE5ejFwU2tJbk52dm56c0dDazN0d3U1QWswYjRWcWE3WlFWZmFt?=
 =?utf-8?B?eXNJZWhpT0YzZHVCb2syTGUyVEJPc2x2cDVMUjBiMFdic0FXNDdUUEg5YnE2?=
 =?utf-8?B?T2ZrMFNIUmlicGRENjRKcnh6RnNqY1lWYVRJdDl4S0NsTmpLK2lZczBlU0o1?=
 =?utf-8?B?a3ZsYzZEUWZEZFdPM2ViLzAwa2RHbWYyMHJrSk01SVZCRFNVL0hHM2FicEdo?=
 =?utf-8?B?MThDd0VLNVRFcXE5ZTdmTXBtSFZ1emVFUWt2b0RsTWw2UVhLUEg3NktZd0FG?=
 =?utf-8?B?K29IYU1xQ21ZVWl3UzIwbklSU25VVG1HZUNpdVhQWDNSM21PaitRUHFFVGVt?=
 =?utf-8?B?RmdITjZ2dFhXcUpCMnhFNzBmSjhkZ1R1UGNKdHRjeXp5K1Y0STdiQy92U2g0?=
 =?utf-8?B?NFpmSFU3RjBwODd6SU5BWnFBWHdmeEsrb3JHaVU1WDRaZG9oSmdZZGdtaEli?=
 =?utf-8?B?UzFGZ1djQ0VPZWxkUjJSZzJEQ0R4aWNwdmg0bUNCS2pzZG85VllnVW9tVE11?=
 =?utf-8?B?engyR1pnckJTWVVxQXZoaGZaVDdZRWlUS1FTSUhTKzhUSy9ML0JtbGtxU1JU?=
 =?utf-8?B?OXRoQkZjS3dnWjFxd0pOVURieWwrSytOazNuK1FFd1k3b0lSZzZJanc1YVhD?=
 =?utf-8?B?cmIrT1FjZ3NHTE9BZ2VZeERXWmpRcUZ1aklBbEVwUDZoSGgrVGd4N0xmUXpJ?=
 =?utf-8?B?NDB6YzI2cVA3K1FadENIUnVxWW5tTXRmUGlkcUFzT3JaVDB4WnZ4UGhuNFBV?=
 =?utf-8?B?NjF0eHV5dGFwZ01ZKzNpbTRhQnMvSkpmWVJhQVZEWmNGZzdMYklkNkdWeFdF?=
 =?utf-8?B?NXMyb2VNNzdvaXNnaDRUUTBKN1puakZNVDNXKzZhTldtbUZOai9nWnFXZzU1?=
 =?utf-8?B?WTVDYXBsMi9ubHhFY1dYL0NUU2hmV3p4Q0pQTTk2NmJna1BXOGZwQ2NZUVpD?=
 =?utf-8?B?UTkvVXdvQTlua0xBcTNFUTVPU1NMeEl1dlBnN3k2YVRUdW9heHM0aGxHV3Z4?=
 =?utf-8?B?MGd5allISkF2T0hFTjljbE5lLzU2dE8xS25Jd2c2a2dobVVSUGlaOGcvK2t1?=
 =?utf-8?B?U3lkWlBhbWlXb2s3ZzUrMk9tbXZxWEJWM1U5Z2ozNGFOdC9BR0htdnRLc3Jm?=
 =?utf-8?B?NSs1enpma0Y4N2pOZ1Rjamx5U0JJRkI3VWFYdGVIenBIeFNhQWJwUWJ1MThm?=
 =?utf-8?B?bHpDSjgvd3h6ODdyUDlFUFlpaDZJY0VuNEg1S2F0QmFrMFJkcXQzazBNTFQv?=
 =?utf-8?B?SXNpRGovdU1nZi82MWpXUnM2d1BVMzVlY3FMamZ6TDIySk5pMGhaampkMEJQ?=
 =?utf-8?B?QUk4VXdKOU14WVZ2Y0hvUEVZSGFtNXU5T3hoSjd2c0J5Y0toUmxCNk1uS0N6?=
 =?utf-8?B?UDhmVnZqSERoaFJKL1VteHZsUnE5WERqUlRrK2VWOEYyVS9zb09lc3dqNVV6?=
 =?utf-8?B?dGh1bFNQUUxRMmZObGlMQnRSNmMxMVFzb1RkS2lsR3RqM2M3UlVWNTZKMlRU?=
 =?utf-8?B?YmY1NWFmK2JjUWU0Y3R6MzFWbGd3eFI0SFQ5YWZXaDk0YXlQMWJRSjR2dFRC?=
 =?utf-8?B?Q3N1V1FkNUxOMENXUTNob0dIczZ1RHNlYmk5M2tUb0NnSmZtemYvM1lydW9F?=
 =?utf-8?B?ZUFrc1hCUkwvemw5UnR6bm1kRnQ1QXZLaWw4WkhrZThRb1FEaTF1U0FtQVhN?=
 =?utf-8?B?OWdwTHo0V2FJOTcyTjZwR3V1WVdIdk00RTZHVzRiVTJreUsrV0lVclJ6Wkt1?=
 =?utf-8?Q?ebeY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7590.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 913757dd-fa9a-4e47-51d2-08db826d16b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2023 00:15:24.7018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2U7Xs+M8dMIqImJ8qQX9oqaVdNMpqavU1jrNPBpQsL4PjxXEwnM/ou+ssotNeNVF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4715
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbmRyZXcgTW9ydG9uIDxha3Bt
QGxpbnV4LWZvdW5kYXRpb24ub3JnPg0KPiBTZW50OiBXZWRuZXNkYXksIEp1bHkgMTIsIDIwMjMg
MjoyOCBBTQ0KPiBUbzogTWEsIFl1IDx5dS5tYUBpbnRlbC5jb20+DQo+IENjOiBMaWFtLkhvd2xl
dHRAT3JhY2xlLmNvbTsga2lyaWxsQHNodXRlbW92Lm5hbWU7IFdpbGxpYW1zLCBEYW4gSg0KPiA8
ZGFuLmoud2lsbGlhbXNAaW50ZWwuY29tPjsgSGFuc2VuLCBEYXZlIDxkYXZlLmhhbnNlbkBpbnRl
bC5jb20+OyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtbW1Aa3ZhY2su
b3JnOyBaaHUsIExpcGVuZw0KPiA8bGlwZW5nLnpodUBpbnRlbC5jb20+OyBEZW5nLCBQYW4gPHBh
bi5kZW5nQGludGVsLmNvbT47DQo+IHNoYWtlZWxiQGdvb2dsZS5jb207IExpLCBUaWFueW91IDx0
aWFueW91LmxpQGludGVsLmNvbT47IENoZW4sIFRpbSBDDQo+IDx0aW0uYy5jaGVuQGludGVsLmNv
bT47IHRpbS5jLmNoZW5AbGludXguaW50ZWwuY29tDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjJd
IG1tL21tYXA6IG1vdmUgdm1hIG9wZXJhdGlvbnMgdG8gbW1fc3RydWN0IG91dA0KPiBvZiB0aGUg
Y3JpdGljYWwgc2VjdGlvbiBvZiBmaWxlIG1hcHBpbmcgbG9jaw0KPiANCj4gT24gVHVlLCAxMSBK
dWwgMjAyMyAxMzoyMDoyMCAtMDQwMCBZdSBNYSA8eXUubWFAaW50ZWwuY29tPiB3cm90ZToNCj4g
DQo+ID4gVW5peEJlbmNoL0V4ZWNsIHJlcHJlc2VudHMgYSBjbGFzcyBvZiB3b3JrbG9hZCB3aGVy
ZSBiYXNoIHNjcmlwdHMgYXJlDQo+ID4gc3Bhd25lZCBmcmVxdWVudGx5IHRvIGRvIHNvbWUgc2hv
cnQgam9icy4gV2hlbiBydW5uaW5nIG11bHRpcGxlDQo+ID4gcGFyYWxsZWwgdGFza3MsIGhvdCBv
c3FfbG9jayBpcyBvYnNlcnZlZCBmcm9tIGRvX21tYXAgYW5kIGV4aXRfbW1hcC4NCj4gPiBCb3Ro
IG9mIHRoZW0gY29tZSBmcm9tIGxvYWRfZWxmX2JpbmFyeSB0aHJvdWdoIHRoZSBjYWxsIGNoYWlu
DQo+ID4gImV4ZWNsLT5kb19leGVjdmVhdF9jb21tb24tPmJwcm1fZXhlY3ZlLT5sb2FkX2VsZl9i
aW5hcnkiLiBJbg0KPiA+IGRvX21tYXAsaXQgd2lsbCBjYWxsIG1tYXBfcmVnaW9uIHRvIGNyZWF0
ZSB2bWEgbm9kZSwgaW5pdGlhbGl6ZSBpdCBhbmQNCj4gPiBpbnNlcnQgaXQgdG8gdm1hIG1haW50
YWluIHN0cnVjdHVyZSBpbiBtbV9zdHJ1Y3QgYW5kIGlfbW1hcCB0cmVlIG9mDQo+ID4gdGhlIG1h
cHBpbmcgZmlsZSwgdGhlbiBpbmNyZWFzZSBtYXBfY291bnQgdG8gcmVjb3JkIHRoZSBudW1iZXIg
b2Ygdm1hDQo+ID4gbm9kZXMgdXNlZC4gVGhlIGhvdCBvc3FfbG9jayBpcyB0byBwcm90ZWN0IG9w
ZXJhdGlvbnMgb24gZmlsZeKAmXMgaV9tbWFwDQo+ID4gdHJlZS4gRm9yIHRoZSBtbV9zdHJ1Y3Qg
bWVtYmVyIGNoYW5nZSBsaWtlIHZtYSBpbnNlcnRpb24gYW5kIG1hcF9jb3VudA0KPiA+IHVwZGF0
ZSwgdGhleSBkbyBub3QgYWZmZWN0IGlfbW1hcCB0cmVlLiBNb3ZlIHRob3NlIG9wZXJhdGlvbnMg
b3V0IG9mDQo+ID4gdGhlIGxvY2sncyBjcml0aWNhbCBzZWN0aW9uLCB0byByZWR1Y2UgaG9sZCB0
aW1lIG9uIHRoZSBsb2NrLg0KPiA+DQo+ID4gV2l0aCB0aGlzIGNoYW5nZSwgb24gSW50ZWwgU2Fw
cGhpcmUgUmFwaWRzIDExMkMvMjI0VCBwbGF0Zm9ybSwgYmFzZWQNCj4gPiBvbiB2Ni4wLXJjNiwg
dGhlIDE2MCBwYXJhbGxlbCBzY29yZSBpbXByb3ZlcyBieSAxMiUuIFRoZSBwYXRjaCBoYXMgbm8N
Cj4gPiBvYnZpb3VzIHBlcmZvcm1hbmNlIGdhaW4gb24gdjYuNC1yYzQgZHVlIHRvIHJlZ3Jlc3Np
b24gb2YgdGhpcw0KPiA+IGJlbmNobWFyayBmcm9tIHRoaXMgY29tbWl0IGYxYTc5NDEyNDNjMTAy
YTQ0ZTg4NDdlM2I5NGZmNGZmM2VjNTZmMjUNCj4gPiAobW06IGNvbnZlcnQgbW0ncyByc3Mgc3Rh
dHMgaW50byBwZXJjcHVfY291bnRlcikuIFJlbGF0ZWQgZGlzY3Vzc2lvbg0KPiA+IGFuZCBjb25j
bHVzaW9uIGNhbiBiZSByZWZlcnJlZCBhdCB0aGUgbWFpbCB0aHJlYWQgaW5pdGlhdGVkIGJ5IDBk
YXkgYXMNCj4gYmVsb3c6DQo+ID4gTGluazoNCj4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9s
aW51eC1tbS9hNGFhMmUxMy03MTg3LTYwMGItYzYyOC0NCj4gN2U4ZmIxMDhkZWYwQA0KPiA+IGlu
dGVsLmNvbS8NCj4gDQo+IENvdWxkIHlvdSBwbGVhc2UgcmVkby9yZXRlc3QgdGhpcyBhZ2FpbnN0
IGEga2VybmVsIHdoaWNoIGhhcw0KPiAxYzc4NzNlMzM2NCAoIm1tOiBsb2NrIG5ld2x5IG1hcHBl
ZCBWTUEgd2l0aCBjb3JyZWN0ZWQgb3JkZXJpbmciKT8NCj4gbWFpbmxpbmUsIG1tLXVuc3RhYmxl
IG9yIGxpbnV4LW5leHQuDQo+IA0KT0ssIG5vIHByb2JsZW0uDQoNCg0KUmVnYXJkcw0KWXUNCg==
