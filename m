Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 282556B18F8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 02:59:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjCIB7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 20:59:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCIB7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 20:59:11 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF2A4B80E
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 17:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678327150; x=1709863150;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5H/GFoHkX8l2aihFRbgocOz3JRaTf8YWgEvZO7NRTPU=;
  b=FuzLHG4HY+Dca7IAjsVyjGIyupi9zBdt51qmfYY6gAyb05+ULfNOdtJn
   5rBMx3H0GZMd4jRUYxpInRvbJfMM54ymg/+ZaFnRDyrisjYkLia03s43w
   QkCqF9cj/sxWdz4InL2WRRcRX4W+LU3qta34Uq2n42n289z5ecYZTFKdL
   T4Y1ti73g6QnwAI2qQ/SJpI9lrZP/dX6kR7kDsP71AiUV9D76UB0A5bja
   0bmlV0j+kS2v6lfAoOVE/xfMiyfIIcCozIjU0/XYTZM81uqMDRG7frhFB
   KQ8YBE86fKBTkIuxWGUrKwYmM8l0+OTt2H0NN3qLVgzWMnFLpbkCbYcBc
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="363965767"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="363965767"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 17:59:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="679562186"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="679562186"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP; 08 Mar 2023 17:59:09 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 8 Mar 2023 17:59:09 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 8 Mar 2023 17:59:09 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 8 Mar 2023 17:59:09 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 8 Mar 2023 17:59:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Va9xFbvEwDt3cbprWxKG6cwMqLdNjFcKfd31v6R8hMYjXTKiSS7TNoW/5+TzbJ8RubgAa9sMdmhGSCG8jO9JTg3TJfuypplIwzaaRwshY247bq99BClAOjfYSqm/K6dlG/hGPs/6QhxHOkaloR+plY9YqN2j/fNwfM/TY6nTtBWesDb5GF2a75V4h5xgVNjaHTrJlUEX7Fpc/S7PAvCM2bpICX8YgyPHxgqodfilu3ppMGQgmO8zoUZjn7wEXiuCnSZgXCPsC3UmbCURUVCOW2OvZUw3lxFNvJcmgjGpCmv72ItCZ1yO6jtvW5sW7j9ZUmgTFTC3LPRqIcjdJfcAzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5H/GFoHkX8l2aihFRbgocOz3JRaTf8YWgEvZO7NRTPU=;
 b=lYYkEsDvUJNCLU5cYCDkK0Mas7pjd5EoeTD6w54E8jvyedYFMAO8uNjLBKkz6gzFkvD6nGadzg+i2Y2rEV2eE8vB2wVLJTx6V9F3Dp16D3eM+WlfIf8VsoL8sQZUBRW5CBrJVN+T1T2/xF3UcPq3AZCvMxtV02nBvZcr+Kf9S16cEbLjLyjOW1cknLjUxAxJzPB5p9mbK+JLtks8cfcHk44pdMyitxKmk5Lk9P8CYhLzS+oyjNn+mL0aYrrVh32ksXdKW/xU236W1kIzl5001mVJf3Y2+g/7V55Beg9v8rGWhgyhXXY/uj/8ptagVXcVIgdiY2sThAEepYRw+D9yNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by MN0PR11MB5986.namprd11.prod.outlook.com (2603:10b6:208:371::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.18; Thu, 9 Mar
 2023 01:59:01 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536%3]) with mapi id 15.20.6178.017; Thu, 9 Mar 2023
 01:59:01 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "rppt@kernel.org" <rppt@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "song@kernel.org" <song@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH 0/5] Prototype for direct map awareness in page
 allocator
Thread-Topic: [RFC PATCH 0/5] Prototype for direct map awareness in page
 allocator
Thread-Index: AQHZUaIwf5rXoI+dnE6C3j5CMP7aLa7xsioA
Date:   Thu, 9 Mar 2023 01:59:00 +0000
Message-ID: <e48a7fb1f8ab8d670b0884fd2a5d1e8c1c20e712.camel@intel.com>
References: <20230308094106.227365-1-rppt@kernel.org>
In-Reply-To: <20230308094106.227365-1-rppt@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|MN0PR11MB5986:EE_
x-ms-office365-filtering-correlation-id: 57c993a6-f92a-4ced-dd00-08db2041da35
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kVs33NL8719a39hcRRroYaxtPK+zi7YWOYDgJB7GVXwiN3jTmyTr7t4XATwiJLDS51k4AFAQBo+vHOkZfyORyKKtVdj1uSUAtXPEIIq93aVHU7V/iGZhmGRLBgPGHFwOP1g1E8Q05jBI3acgsbiJzynjPkkvi+StAYjcUHjr0gR80G/DNyyHvHrIqjoI9xZZDDeCDHDHMMbODu5YTIBJHtWloOzWvRHMYfOwGpJK/jwFpdCsiVDSnJRPgUVJu9FBYuf6aeTQpr8JTLyDVNmHuazPJLyYI7o3XFVMol/9qPNC2c1HNER9gROk/RSvN0zvVChGN9pXiBqYN/DxgghCKidzwSfqUtf8qSSozG1nhJsP+SV8a8eAbNk8cWyE0pHkIPuBreObkN1JqU1IP5OxTZO+pLAoF1DOCmxrjbkmPurnQ20324rOUF2LkXdS9aRZf2zcSCrE+sFGU+LpNpsmXVh7x1gztzphScpI3A5W9CEje8s56EsIbgGjPPRgquohkpXJU2tdOk+CJKYvJAg3XkS+GKOpjrvn51xoIZyZ9yGRgMMiV6JdX4aXt1wUcxi6i9529AGQWlPVQed94rSS0ZkAPIKiSRqhSbzCFawg3AzVasfdL7kNT2GUroElnptiXE6pe7sXGmNXnP2OY9ICiCInuk5qw+edvaO8e0IkSzevwhUhuSUaCkaokgcuiAGZcHMGK9vPf0ZLZsjNGxeQhA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(136003)(396003)(376002)(346002)(366004)(451199018)(36756003)(110136005)(54906003)(71200400001)(5660300002)(478600001)(966005)(6486002)(316002)(7416002)(41300700001)(66556008)(2906002)(91956017)(8676002)(64756008)(66476007)(76116006)(66946007)(66446008)(4326008)(8936002)(122000001)(82960400001)(38100700002)(6512007)(38070700005)(86362001)(186003)(2616005)(26005)(6506007)(83380400001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U3BsWXFSVjNkQ3VFYkVkcEl4NFQ2R1g0Mld1Yi9TZE50bGtSdHlQM1RsZUtz?=
 =?utf-8?B?NU5sK0RPZlVuVlRMTytOOGk4OFVKYnRrdWZINGhGYXFQWkMwbHZlSVBNS29E?=
 =?utf-8?B?VDdRUDhwSjRYSjdvcER1eFpUVEJYNkVoeEthRTBhbUFFMDY4ZUhHK0g5anRF?=
 =?utf-8?B?dm1aVGt1bXRXN0V4NHdWYmo1NGQ4c053elRHTUVEUHlyRUx3aUtmYzFWRkdZ?=
 =?utf-8?B?QiszSlc1eHovN1VSQzlvckFnbHA4VlZFTm05YXpyeXFxQTRRK2hvYUxoekRi?=
 =?utf-8?B?VjVIaStjcE5Vd3FKWDNxc2t6cjJIcVBWM1o2WnRGVW12U0Z3dndhdVdVZjRE?=
 =?utf-8?B?Q3EyYXpLMlkwd2ZsakVnY3hUWmFPVUdxcHprenJzRGlHVmZlYU5tWk1zYUlK?=
 =?utf-8?B?Y00wUzBxZWZIdTQ3amdlTkdhT014OGoxejl6MVNQNW5uMEppSTBWeHA5WnVj?=
 =?utf-8?B?WXo0TXlPSnhiZ3RqRjNjT3oxMTc3ajVWdVphZC9HWU5FZ05nRlc1VHZmZmNs?=
 =?utf-8?B?ZXZCcnBJaHE1Z1dDeU83aTdPazUzYzZ4MFZIemhsNit6R09tWXo1NDJXYmhw?=
 =?utf-8?B?SEhLajFaYWhvVWE1UHh0RGo1c3dJOEpIU0ZNVERlWTFVdTlZN0JIVVZrUlpr?=
 =?utf-8?B?YURZcVh6ZlgzbXZ1Ym9mUzY5M3E5VG1mbUpyUVRSQ1FWc2FPdUsxTHc3Vndm?=
 =?utf-8?B?VXpzZkJBTzYzbmhibDFpWnozQStUZUdzR0U4OUw1OUtvYTlYd0dGdkF6eFFL?=
 =?utf-8?B?VHFYV3FYemZKb09LeDlNZGpCOCs5T3ZpdHpBTWFiSjQyOGd2ZyszRyt5YnM3?=
 =?utf-8?B?bmJaL0JVK0xMQ0pianlVNFVNRzhVS0xNQ0tWYUgwellnVmZuQVBqL25vU051?=
 =?utf-8?B?Y2dpSXZHM2xZVldxSzJlTGgvU3YvSTRMbjEwTUh4NHlOdHFJUnA4c3FRWmdw?=
 =?utf-8?B?eUxsdUVmMlZBNnBWSEJjK3orSHpYQ1VpOGs5Q2xRZTdhNDBZbEEzU1h2Nlo0?=
 =?utf-8?B?VVo4NWh0cnM1QUtkcWJkemdZcEM4QitYUWlUNGtNekg0NkJrSkprMm1rSDNS?=
 =?utf-8?B?VCsrUi95Smg3ZzVxdkc0Z0dvbTdnK3ZaYitwY2lPclRKN0xzZ3hINXVKWDRi?=
 =?utf-8?B?blFzUStMelRRR2ZyVkxtSk9JWWlYOFJJczJBRFVYaGdCZWYxV2ZSQ09KVjlm?=
 =?utf-8?B?TEFaeEFIL3oxQ0EyZUtYSi9tSnpKOFQvWUY3KytDQ1lSeW8xUlNjZS9VZXVj?=
 =?utf-8?B?bm9INmVpWG5nU2g0N3RFWDhsa0x2K2xQUnh1dStvVnN6eWJQZFlMMnJkQjFw?=
 =?utf-8?B?TENWNjFLSk5uNDJ2L3ovMzJTSDdYaklVRDYwb0dvaFJ2dERldllyWVNDVk5h?=
 =?utf-8?B?cXVScllLbVhVc0RvZHR6bTV0Q1dXWjg4OG14Tmg5R0tGZTVVRkxOcTRpeW00?=
 =?utf-8?B?S2VHNEtsOHdHMTVsdWlKTngvOUFIK1lyVHF1UmYxVmdKdU9ZaEVEenBOejFx?=
 =?utf-8?B?dWxDVExGeHhocjdqbFNhYk5qK3dTakxHcy90M0Z1dXlaSk5lK3lzQUZ5c3Y5?=
 =?utf-8?B?Y2hSQytmWjZ0SnBWYkIwUkRYRVlvak1nSWVlSFBBQXlFS0hPcXFNODluWWlH?=
 =?utf-8?B?c25DTXF3S1lMdlRKY2JUVmlWTXBsTWtiSlR1Q1poMVlueWt0RmR3VkNJY3VX?=
 =?utf-8?B?anQ1d1dEdUpZYVZiQ0YwQVpFZnY3c0Z4NGNGc2V4Zk1ySWRrQ0pBSm53em5s?=
 =?utf-8?B?VzNiZmpvSmRFOEYyUFVjeHdJa1RFMXZCSDhxSUlySEF0eEttOTJ0STVYMktU?=
 =?utf-8?B?ZlF1U2RJejVJV1hNbWRhNXpSRW1mbG1Ha2ZqaDB3UmhRaURUN3U0RE9Nb28y?=
 =?utf-8?B?RXhLbGpRUkhqSEY5UHdQYVR6OFE4WERmOTNBaEcwVGk1SjhaSkNtVW0vQ3lP?=
 =?utf-8?B?VW5qNVRnNFh1K0hoT01IelBNM3pDOFlibE1ETitoRDQ0K1NzL0pQYzNiT1hS?=
 =?utf-8?B?RUdFdDB4OG8wdkRvKzZ5anBzK0gxNHR5dUI5YWhWKzZublg5MG84VG42MWlK?=
 =?utf-8?B?Z3BPM2NmNytuWDh3T2hKR2hYUHg4Yk1vdWJ2eXBIdlB1UVVvZzIwL3lnNUo5?=
 =?utf-8?B?R1Y1NDFOeGtGdFc1ejhVTEhWV2dWWjVGQU83L25GQythYll1aEhqcEhSdGFw?=
 =?utf-8?Q?AHYUQKjofbrGQsCl4cvjDqQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7F926CADB348A34083E49C162F9F51DF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57c993a6-f92a-4ced-dd00-08db2041da35
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2023 01:59:00.8827
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8/YcvG97un/9rhMXITP3RnEODF2xYjq8bMVipfnvinPSy5DGQOdS3MVu2askfnU2vcyJLXEHKyqCjFZu5w1a2DAOZ7GXB3nvGETIWca1Y9o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB5986
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTAzLTA4IGF0IDExOjQxICswMjAwLCBNaWtlIFJhcG9wb3J0IHdyb3RlOg0K
PiBGcm9tOiAiTWlrZSBSYXBvcG9ydCAoSUJNKSIgPHJwcHRAa2VybmVsLm9yZz4NCj4gDQo+IEhp
LA0KPiANCj4gVGhpcyBpcyBhIHRoaXJkIGF0dGVtcHQgdG8gbWFrZSBwYWdlIGFsbG9jYXRvciBh
d2FyZSBvZiB0aGUgZGlyZWN0DQo+IG1hcA0KPiBsYXlvdXQgYW5kIGFsbG93IGdyb3VwaW5nIG9m
IHRoZSBwYWdlcyB0aGF0IG11c3QgYmUgdW5tYXBwZWQgZnJvbQ0KPiB0aGUgZGlyZWN0IG1hcC4N
Cj4gDQo+IFRoaXMgYSBuZXcgaW1wbGVtZW50YXRpb24gb2YgX19HRlBfVU5NQVBQRUQsIGtpbmRh
IGEgZm9sbG93IHVwIGZvcg0KPiB0aGlzIHNldDoNCj4gDQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL2FsbC8yMDIyMDEyNzA4NTYwOC4zMDYzMDYtMS1ycHB0QGtlcm5lbC5vcmcNCj4gDQo+IGJ1
dCBpbnN0ZWFkIG9mIHVzaW5nIGEgbWlncmF0ZSB0eXBlIHRvIGNhY2hlIHRoZSB1bm1hcHBlZCBw
YWdlcywgdGhlDQo+IGN1cnJlbnQgaW1wbGVtZW50YXRpb24gYWRkcyBhIGRlZGljYXRlZCBjYWNo
ZSB0byBzZXJ2ZSBfX0dGUF9VTk1BUFBFRA0KPiBhbGxvY2F0aW9ucy4NCg0KSXQgc2VlbXMgYSBk
b3duc2lkZSB0byBoYXZpbmcgYSBwYWdlIGFsbG9jYXRvciBvdXRzaWRlIG9mIF90aGVfIHBhZ2UN
CmFsbG9jYXRvciBpcyB5b3UgZG9uJ3QgZ2V0IGFsbCBvZiB0aGUgZmVhdHVyZXMgdGhhdCBhcmUg
YmFrZWQgaW4gdGhlcmUuDQpGb3IgZXhhbXBsZSBkb2VzIHNlY3JldG1lbSBjYXJlIGFib3V0IG51
bWE/IEkgZ3Vlc3MgaW4gdGhpcw0KaW1wbGVtZW50YXRpb24gdGhlcmUgaXMganVzdCBvbmUgYmln
IGNhY2hlIGZvciBhbGwgbm9kZXMuDQoNClByb2JhYmx5IG1vc3QgdXNlcnMgd291bGQgd2FudCBf
X0dGUF9aRVJPLiBXb3VsZCBzZWNyZXRtZW0gY2FyZSBhYm91dA0KX19HRlBfQUNDT1VOVD8gSSdt
IHN1cmUgdGhlcmUgaXMgbW9yZSwgYnV0IEkgZ3Vlc3MgdGhlIHF1ZXN0aW9uIGlzLCBpcw0KdGhl
IGlkZWEgdGhhdCB0aGVzZSBmZWF0dXJlcyBhbGwgZ2V0IGJ1aWx0IGludG8gdW5tYXBwZWQtYWxs
b2MgYXQgc29tZQ0KcG9pbnQ/IFRoZSBhbHRlcm5hdGUgYXBwcm9hY2ggaXMgdG8gaGF2ZSBsaXR0
bGUgY2FjaGVzIGZvciBlYWNoIHVzYWdlDQpsaWtlIHRoZSBncm91cGVkIHBhZ2VzLCB3aGljaCBp
cyBwcm9iYWJseSBsZXNzIGVmZmljaWVudCB3aGVuIHlvdSBoYXZlDQphIGJ1bmNoIG9mIHRoZW0u
IE9yIHNvbHZlIGl0IGp1c3QgZm9yIG1vZHVsZXMgbGlrZSB0aGUgYnBmIGFsbG9jYXRvci4NClRo
b3NlIGFyZSB0aGUgdHJhZGVvZmZzIGZvciB0aGUgYXBwcm9hY2hlcyB0aGF0IGhhdmUgYmVlbiBl
eHBsb3JlZCwNCnJpZ2h0Pw0KDQo=
