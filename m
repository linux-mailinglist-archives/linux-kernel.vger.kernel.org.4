Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2D7E5B52C7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 05:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbiILDJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 23:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiILDJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 23:09:49 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0831D4E;
        Sun, 11 Sep 2022 20:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662952187; x=1694488187;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=htDB6JgiT1AWA5xILcwIFoY/BxljceA4Ctk7IvVZlyM=;
  b=nBiabUrlEqJzg9DA39bPENdCtluAorrsMBI/aEQyvccnOhXCnWyB9iXV
   ayzQXL0mXXoFi8Y2d4TTGLwAMWLaTW+6LJWmMtOqRG6JSJCQjjXLIhdjr
   iKpRi6Q24C6Eckg96TBDkH8xpf4x3OCx+cwYDovAwjz5uRTJiMDRUmKQ2
   kY4K0qsP18A/8zMacJz60TYt1wG/U4iOnZyY7DuF5eFB+5zXv8HvT65X3
   5Krxcc1rJIsPCfkAQF8KHuqZYc5s6vB6kl1/6HM+4gLMH4Z8rBNmm/P43
   cxfw8cOzt79fwZaZ5beZ5xWG6DIrQxjwRkglNUHZgvTngUCscxs//CG+b
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10467"; a="359500150"
X-IronPort-AV: E=Sophos;i="5.93,308,1654585200"; 
   d="scan'208";a="359500150"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2022 20:09:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,308,1654585200"; 
   d="scan'208";a="791405789"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga005.jf.intel.com with ESMTP; 11 Sep 2022 20:09:47 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 11 Sep 2022 20:09:46 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 11 Sep 2022 20:09:46 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Sun, 11 Sep 2022 20:09:46 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Sun, 11 Sep 2022 20:09:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cOAGhYkC6XJ28JiZEBXnFcfR6607HMyEcPnae2Gd2xKUXBIVB2aEOn3ybEf7DgAAMT7ire/P8t4qnBeqANrVPvIswoHmfgvmu6ileM6KYdDof8Z/LrNsvSBYkNczuXd7xBHeuH1XgxW5AVtCEycvHLrxrSLjxCvcJT+o/f3AfpYmmxXmJayDnysiJ2UHJtux+Y1hHFpjS58rdrGKdEbiTvwS40vuxURUyUaIkHnfAx/NURlx/o+w6abNPKdOj+wUynQRlam2PjauqJYV6f7pgDjRcbrDW0FtDFAFsSP2Lx/9LWX+OIhiuAEzvRsf6dLMZZ1nPVlP9mF31vpKiEDjow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=htDB6JgiT1AWA5xILcwIFoY/BxljceA4Ctk7IvVZlyM=;
 b=OeOyvyj9LHc6JGH/dPuZKtbuK8ENaHrqiSONELSGqlHBBZJwXhYP8A7Yn1ozBLa6TIC5BGSlnd4Hx5yrA+gLVlwkk+U7b9MKHj9SBeTkx5i8NsBhFMyDnaincwgKYphQPsZIRQ9tlJQ54icSqHSK5b8A4jNjqaH0eGj/7LhKX9dzar1XztkE5dEuGLuRkLgbbOtGS3U2S/xeDAzY5hoo7IOacJwWypZTPvhtf5imf6kVmmPSHHEglhYM+BfYcnsOtzJweauZ1wJodj07u2kZR6/71r0gyg2KAp1MM5L6Y1256M8ZckKw/1Z0hRvyBS787vyfzO9T446MYVQNG0MNhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SJ0PR11MB5631.namprd11.prod.outlook.com (2603:10b6:a03:3ae::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.16; Mon, 12 Sep
 2022 03:09:43 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::e03d:fd3:dad2:2248]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::e03d:fd3:dad2:2248%6]) with mapi id 15.20.5612.022; Mon, 12 Sep 2022
 03:09:43 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>
CC:     "jarkko@kernel.org" <jarkko@kernel.org>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: Re: [PATCH] x86/intel: Clear SGX bit if both SGX driver and KVM SGX
 are not enabled
Thread-Topic: [PATCH] x86/intel: Clear SGX bit if both SGX driver and KVM SGX
 are not enabled
Thread-Index: AQHYxCOqzZOxa9vUg0Knyate5r52r63XAjWAgAQftoA=
Date:   Mon, 12 Sep 2022 03:09:42 +0000
Message-ID: <4e1e76f93cda5799fa5eab6fb23ef6fa216ea9eb.camel@intel.com>
References: <20220909080853.547058-1-kai.huang@intel.com>
         <8d7a22f3-6677-1438-84d2-68a56211ad11@intel.com>
In-Reply-To: <8d7a22f3-6677-1438-84d2-68a56211ad11@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4 (3.44.4-1.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|SJ0PR11MB5631:EE_
x-ms-office365-filtering-correlation-id: 278c4733-e66b-4fac-3234-08da946c3d16
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iLVaZIJc5Yd86L65vJeoKqjBjIdYAMygz49R4fq1HlvqX+1AFufeYiq5JucVTyA8ldKRRz4YfWka6i6UVMAmAEOQyvJ90w5RGiBvk/gTgCBP47qCpchAORFs/jE3SFZBePjTjWvMKi1P90Xj4TusafKA9U8fbr1YwINqW0Q6bl4QOfKX1Dl4WQFdIsnUx7dvm9qEo8bu+xfAFicG47+IyhLMRkXjLcqVlEP6vvfBTrNHltkH7hVlOnFaR9aCTDvejnFzZY1cmaStSwCOyrLcB0lAm/vr9U0qsMDibvBzRhEVIs18eFjNVi8XwjSsvJFYKW7VPWijlzpxawjm7r18Iy12rBhjkOUvQbnnZxrFTJx2hOQRai1KbPsC0q4G3GXXe0CAHgpo5gvTgqqiG5FAD8FZxVxreS4ZwBvTExe8krE+HGqKr3b1b4qoSx0+gLyuyOHveoEHxiaM3ig/SlnrUGIQ/qzYsWuxvChLtoW+aaH0oSx+Z26rQUeRUS4jyWN8jyqx7NTGTY519TvP8pZ2Y7LHf2ERB+z3c4oKZkSGKoJPp/yDkVn2EYzMSGnvwbn7Ix8HCvKApAG2jhcqX7cruWo9nQi1tsStY1Rsk4wCNZk04EgZ0pNARzFEwtqEa016jfOy0aOXjv6rXu4C4rDk93pywM+ahF/vyuuK14H+OlaoEgRQnxry6wtXoc6BbtkY6MH9ICirgDF4afeuzT1hTkue0B0cNhrwMsoR1VRTaTgR5WIqPXeYXD//XxRjzS++9ULM9fqPEJV9AvDK16MDdtTAc2C3fASYhwMRJB7+un0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(376002)(136003)(39860400002)(366004)(346002)(8676002)(86362001)(38070700005)(82960400001)(8936002)(38100700002)(122000001)(66476007)(64756008)(66446008)(66556008)(66946007)(26005)(76116006)(6512007)(6506007)(53546011)(91956017)(4326008)(110136005)(71200400001)(41300700001)(478600001)(6486002)(83380400001)(966005)(316002)(6636002)(54906003)(2906002)(5660300002)(186003)(2616005)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SjFkQWQ1aTVoTWx4L2E0aEZXWGRLK3dGYVVsUkh3cURhOVJnY3BUK3BhdFNr?=
 =?utf-8?B?QzRqZW90VkJWYlVWVlpkYzBHVHk3U0FiUFlKWWVhSVQ2QkhLc1dIVFBqM3Fy?=
 =?utf-8?B?M3ZsNEV1VDNmSWtyMDJlM1pmRGlPUWJEVlp1Vzl1SWRIKzg3NWFyeDR6S2Yz?=
 =?utf-8?B?akNVVHk5eFQvUkJ2dzV5NmViOXhRQzlWbTJYTmd0YUhyYTNPb0FvQmdKZWps?=
 =?utf-8?B?RE55VU9NT0J6VEg4WXA1dkFaZnh1WUVLMnBmQWVxck8rNkl5aFZJWXk4bmZR?=
 =?utf-8?B?ZktIU1hNY3FIQ1k3NEVLQUNOYmdELzZneUtpcDlXQkU4eERzU2ZOdjBLcmlz?=
 =?utf-8?B?QVJCdzg1RmV6Qy9FSTZMZ3pTSm1zc2RwTEhua2Y4NlVaUDNacE52dTFTc3NJ?=
 =?utf-8?B?MEEwSXpPMElYWDBXWFBOMVdqbUlkeDZ3MHVkamJia0tCY0h5YmE1cWo3NTl1?=
 =?utf-8?B?VjEyUDU0dWhGN1dHS2ZZYjhDT0w2MkdyV2JSSy9TYWw2TTZoOTBDK29jdFlp?=
 =?utf-8?B?SDVaOFd2dWJUNFRPNUxkU3Y2U1JVQ3IyVmxmaW5vKzdndWtRNDh0S1VtTkJ4?=
 =?utf-8?B?SitnZ09tNVZXOUtleC94TllQdThiK3hLRWc5cGNyWHJmQlhCdVhhTXIrZ2k2?=
 =?utf-8?B?YnBsYU5BWmxaVkhwWTEwU2tjMjdkVXdybURwQUFxQ0dwU1d2dkJzV3pmeWxN?=
 =?utf-8?B?NGFGeXo4QndTWmU3VUw1VjVyeVJPOUZiNVZscDJlaEp3Ym05UTM3OHA5TGRJ?=
 =?utf-8?B?d054MWNBNU9ITS9wRXFnV1dIclRqMDNCMjNNWWVSNitSNXFFQTVaWlhYcVNl?=
 =?utf-8?B?c2R4T2V5YlNkZkhibTZVekE3Sjk4bzBwQ0ZzeFExUDUzeTVwTVdJUDkwMXdr?=
 =?utf-8?B?bXV0RU5iWGwvWmJ6bDdjWG1uZ0xGUDc3NFVXTm9kR0pwaUlkd3A3VTB1ME5R?=
 =?utf-8?B?VkdmK3BVNklnd0RoNC9neEQ3SWZnSFpTRW5pVVIwMXFQM2MxVW9qSnpQeW54?=
 =?utf-8?B?NVRJbENJeU1pL3pjNmtLOWkrV2Z1NGFGNTRVVHJTTXc2UzZNeTBWOFZ0aWlD?=
 =?utf-8?B?bllUZTd4VWRYTUpxWFFyYmsrWUxyQ3hZdUpZT05BaTVlMEFhNjhKNWZhSEYx?=
 =?utf-8?B?Q0x3SUQ3bGlNeWcyNlBJMXhYTEJKcnlsSXhuSFlPbmJnV3d5d0wrdFRyMWI3?=
 =?utf-8?B?MERkRUs4MEVOOVRqUFdmRzdxaG4vTkl3Uzk5WVlINm0vQi9tbkVyZERRSTBU?=
 =?utf-8?B?MmdiSnJFTEswZitObThWSVJPODcyeThSREEvQXF0Vko5TkI3N3BHNkFUc294?=
 =?utf-8?B?ZFY1eG41MXVhTlY1OVFuUWVHWklCM0JwbzN1WS9RN3BxYVBzQjRENWtNWGla?=
 =?utf-8?B?RkQrUTFsYldQdHNVb0ZNdHZlM2tqT2dZa3pvQ09xRDVsL1Rmd0x6Z3daL3ZH?=
 =?utf-8?B?dEdjakk0VVVpTksxSG1DQ2kvTk15b3FBNUswT0I1Sk5ac2xpd1FLa3dJZUNp?=
 =?utf-8?B?bSsvSU1JVjRsTUE5cjlwcFV5UUF4Qy9IeFN2RjhQYkxZL0tXVm9WMkRjalpH?=
 =?utf-8?B?alMrNmM0U1JCUldoZUliK0tmOU4yUjQ4RTJpKzBhRnQwZmhMR3VvMk1DS3Zn?=
 =?utf-8?B?ZG9aVDBzZDJNWFd4bzhKT3R5N2JZSGhRVmtydzltNzFsVDA4bVNtSmhKajdJ?=
 =?utf-8?B?UGgwMk1FeXhzdTZpMTIxZWZsMHVOV3oxd2dKSExnSGozUlFJTXJxN3ZZcEEx?=
 =?utf-8?B?M1ZjMk8raVdhQjBKRzRpOHB0OXJrWExQY285dDNIY3BWb0NISGFMY0xNZW4v?=
 =?utf-8?B?L1h4NTFZSVVFYlErTVRJWXV1MW9RYnVLL09xY1c2NzUyMkZYdzdpVkZNcHF2?=
 =?utf-8?B?cnNEM0lCQkxOMlNMRFF5UU9TRW9KNjA3Rktlc1lJVTl0eWtXSmlyOWJZVXVK?=
 =?utf-8?B?NjBHdklKMTc5RjhuNW8yOTlCL1ZrT0pKa3p3ZFJSaWtFZEorK1pmcmNnUzVK?=
 =?utf-8?B?UHNQb1Bab0dPSUlBd2hQY1VCdDZKMDhzM1JDZkFqbDkyRlp1SUpNUm1qQTJE?=
 =?utf-8?B?YmJMMjhlNmRQRGMxcDJmaUVVQTNreG84bTQxMzFKd1VoTDRQZjN5V0JyMmVv?=
 =?utf-8?B?V3E0ZEIyekNDYU5jSDNrTDhmNENIN0ZwOXRCcnBYTkdJUWMwUWE0SDJ2S2li?=
 =?utf-8?B?NUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <575B51D7F7D65A4A8F47BC133DD8F644@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 278c4733-e66b-4fac-3234-08da946c3d16
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2022 03:09:42.7965
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /wdSwsXz+qtY9J99nV9uksBYkxYzVoEtj+ir4b+OziByoUuywQw9qx/682AriOUG/4KQfNiD47OXPf3iiE5pRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5631
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIyLTA5LTA5IGF0IDA1OjExIC0wNzAwLCBEYXZlIEhhbnNlbiB3cm90ZToNCj4g
T24gOS85LzIyIDAxOjA4LCBLYWkgSHVhbmcgd3JvdGU6DQo+ID4gQ3VycmVudGx5IG9uIHBsYXRm
b3JtIHdoaWNoIGhhcyBTR1ggZW5hYmxlZCwgaWYgQ09ORklHX1g4Nl9TR1ggaXMgbm90DQo+ID4g
ZW5hYmxlZCwgdGhlIFg4Nl9GRUFUVVJFX1NHWCBpcyBub3QgY2xlYXJlZCwgcmVzdWx0aW5nIGlu
IC9wcm9jL2NwdWluZm8NCj4gPiBzaG93cyAic2d4IiBmZWF0dXJlLiAgVGhpcyBpcyBub3QgZGVz
aXJlZC4NCj4gDQo+IFdoeSBpcyBpdCBub3QgZGVzaXJlZD8NCg0KTXkgdW5kZXJzdGFuZGluZyBp
cyBpZiBhIGZlYXR1cmUgaXMgcHJlc2VudCBpbiAvcHJvYy9jcHVpbmZvLCB0aGF0IGZlYXR1cmUN
CnNob3VsZCBiZSBzdXBwb3J0ZWQgYnkgdGhlIGtlcm5lbCBhbmQgc2hvdWxkIGJlIHVzYWJsZSB0
byB0aGUgdXNlcnNwYWNlLiAgRm9yDQpleGFtcGxlLCBpdCBzZWVtcyBBTUQncyBTTUUgd2FzIGFs
d2F5cyBwcmVzZW50IGluIC9wcm9jL2NwdWluZm8gYXQgdGhlIHZlcnkNCmJlZ2lubmluZywgYnV0
IGxhdGVyIGl0IHdhcyBjbGVhcmVkIGlmIFNNRSBpcyBub3QgYWN0aXZhdGVkIGJ5IHRoZSBrZXJu
ZWwgaW4NCmJlbG93IGNvbW1pdDoNCg0KY29tbWl0IDA4ZjI1M2VjMzc2N2JjZmFmYzVkMzI2MTdh
OTJjZWU1N2M2Mzk2OGUgKHRhZzogeDg2X2NwdV9mb3JfdjUuMThfcmMxKQ0KQXV0aG9yOiBNYXJp
byBMaW1vbmNpZWxsbyA8bWFyaW8ubGltb25jaWVsbG9AYW1kLmNvbT4NCkRhdGU6ICAgVHVlIEZl
YiAxNSAyMTo0NDo0NiAyMDIyIC0wNjAwDQoNCiAgICB4ODYvY3B1OiBDbGVhciBTTUUgZmVhdHVy
ZSBmbGFnIHdoZW4gbm90IGluIHVzZQ0KICAgIA0KICAgIEN1cnJlbnRseSwgdGhlIFNNRSBDUFUg
ZmVhdHVyZSBmbGFnIGlzIHJlZmxlY3RpdmUgb2Ygd2hldGhlciB0aGUgQ1BVDQogICAgc3VwcG9y
dHMgdGhlIGZlYXR1cmUgYnV0IG5vdCB3aGV0aGVyIGl0IGhhcyBiZWVuIGFjdGl2YXRlZCBieSB0
aGUNCiAgICBrZXJuZWwuDQogICAgDQogICAgQ2hhbmdlIHRoaXMgYXJvdW5kIHRvIGNsZWFyIHRo
ZSBTTUUgZmVhdHVyZSBmbGFnIGlmIHRoZSBrZXJuZWwgaXMgbm90DQogICAgdXNpbmcgaXQgc28g
dXNlcnNwYWNlIGNhbiBkZXRlcm1pbmUgaWYgaXQgaXMgYXZhaWxhYmxlIGFuZCBpbiB1c2UNCiAg
ICBmcm9tIC9wcm9jL2NwdWluZm8uDQogICAgDQogICAgQXMgdGhlIGZlYXR1cmUgZmxhZyBpcyBj
bGVhcmVkIG9uIHN5c3RlbXMgd2hlcmUgU01FIGlzbid0IGFjdGl2ZSwgdXNlDQogICAgQ1BVSUQg
MHg4MDAwMDAxZiB0byBjb25maXJtIFNNRSBhdmFpbGFiaWxpdHkgYmVmb3JlIGNhbGxpbmcNCiAg
ICBuYXRpdmVfd2JpbnZkKCkuDQogICAgDQogICAgU2lnbmVkLW9mZi1ieTogTWFyaW8gTGltb25j
aWVsbG8gPG1hcmlvLmxpbW9uY2llbGxvQGFtZC5jb20+DQogICAgU2lnbmVkLW9mZi1ieTogQm9y
aXNsYXYgUGV0a292IDxicEBzdXNlLmRlPg0KICAgIEFja2VkLWJ5OiBUb20gTGVuZGFja3kgPHRo
b21hcy5sZW5kYWNreUBhbWQuY29tPg0KICAgIExpbms6DQpodHRwczovL2xvcmUua2VybmVsLm9y
Zy9yLzIwMjIwMjE2MDM0NDQ2LjI0MzA2MzQtMS1tYXJpby5saW1vbmNpZWxsb0BhbWQuY29tDQoN
CkkgYW0gbm90IDEwMCUgc3VyZSB3aGV0aGVyIHRoaXMgcnVsZSBzaG91bGQgYWx3YXlzIGJlIGFw
cGxpZWQgdG8gb3RoZXIgZmVhdHVyZXMsDQp0aG91Z2guICBCdXQgZm9yIFNHWCBldmVuIHRoZSBj
dXJyZW50IHVwc3RyZWFtIGNvZGUgY2xlYXJzIFNHWCBmZWF0dXJlIGluIHNvbWUNCmNvbmRpdGlv
bnMsIGZvciBleGFtcGxlLCB3aGVuIFNHWF9MQyBpcyBkaXNhYmxlZCBieSBCSU9TIChpbiB3aGlj
aCBjYXNlIG9ubHkgS1ZNDQpTR1ggY2FuIGJlIHN1cHBvcnRlZCkgYW5kIEtWTSBTR1ggaXMgYWxz
byBkaXNhYmxlZCwgaS5lLiBkdWUgdG8NCkNPTkZJR19YODZfU0dYX0tWTSBpc24ndCBzZXQ6DQoN
CiAgICBpZiAoIShtc3IgJiBGRUFUX0NUTF9TR1hfTENfRU5BQkxFRCkgJiYgZW5hYmxlX3NneF9k
cml2ZXIpIHsNCiAgICAgICAgICAgIGlmICghZW5hYmxlX3NneF9rdm0pIHsNCiAgICAgICAgICAg
ICAgICAgICAgcHJfZXJyX29uY2UoIlNHWCBMYXVuY2ggQ29udHJvbCBpcyBsb2NrZWQuIERpc2Fi
bGUgU0dYLlxuIik7DQogICAgICAgICAgICAgICAgICAgIGNsZWFyX2NwdV9jYXAoYywgWDg2X0ZF
QVRVUkVfU0dYKTsNCgkgICAgZWxzZSB7DQoJICAgICAgICAgICAgLi4uDQoJICAgIH0NCiAgICB9
DQoNClNvIEkgdGhpbmsgaXQgbWFrZXMgc2Vuc2UgdG8gY2xlYXIgU0dYIGlmIGJvdGggU0dYIGRy
aXZlciBhbmQgS1ZNIFNHWCBhcmUgbm90DQplbmFibGVkIGJ5IHRoZSBrZXJuZWwuDQoNCg0KLS0g
DQpUaGFua3MsDQotS2FpDQoNCg0K
