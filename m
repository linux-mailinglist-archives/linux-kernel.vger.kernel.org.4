Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4A55747C1D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 06:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbjGEEqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 00:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjGEEqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 00:46:12 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F9710F5
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 21:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688532369; x=1720068369;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pcYoDXn9x4LyYiL+CJULk3Nbm1p1CeXR8KhIPmBbOB0=;
  b=dVwGozSwhcIUHSrytlLVTZCdau5bpHP7sy1fxntaU2zv7fgRwuK8KNP9
   nSiFVpZELL8HZGhh32X/lb0QvbeSePzXqMefAogBwwdvXmzGXmqZ66lQK
   Q5A6jTkEmY+QEM3numWnhssp5wp5RPN0LSGB7S21COudLQi2g7VilTi7a
   NTaRsgzxG0rSoFcsRP6U2/sLCjotGBIT/GYRxJzoTIGTbYf2Vg7CiwJcr
   S/2/Sl1AkWPCuXFsd3WmOflt8Pq1qUdXZKlzRF/MmkhJlusigjxOgpBHf
   5fW2je5CGbk49f6wiZX2noYTt/iQeC9ua7FMEFuyLLptEJSAux35gZye2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10761"; a="449615724"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="scan'208";a="449615724"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2023 21:46:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10761"; a="893045325"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="scan'208";a="893045325"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP; 04 Jul 2023 21:46:07 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 4 Jul 2023 21:46:07 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 4 Jul 2023 21:46:07 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 4 Jul 2023 21:46:07 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 4 Jul 2023 21:46:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b7t/ptO94v4ktJHE2CEvI4rMickbyGUppT34fsGOmT2QGL4/HAd69E9BuegYfxNcJzXbyu+Ju9WdbYend0Vy6BSz/aCZkUVsM/zwyHnBYiY0y2dZ0Cwt0aHntiATohMAXdaA3Wk8b0VT+MN16b9p+cbXqMQGyyyI4wD1lyLre+CGwo0B5sV8DHQzJo0PvZrD5LTJq6n61v3MhoQ1uSRzn0DcmO/tXRYlIvEOowV3CRsMQoOGr8YKpYc751fVo2Zaxe9zHeOg2arXChc3pTPrK18F2SqxL94o9w57x2JdoCDzC/r2CGzBPb4dLSzBV+NWYO+lqpVqO3I0liRME6gFTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pcYoDXn9x4LyYiL+CJULk3Nbm1p1CeXR8KhIPmBbOB0=;
 b=b4shaBMmM1C5htN9PMXPKhmBDzb+0WqOGGfffk9/akECTDbegiMvPVRJo0pGsFMUXFOmtZySTlhMvx5QRC96kvG4O+pxP0r1P9UrYPTZVDqlvwo3fiyT+VS7RVZxjUHKVIOxBgjTGqAbct43VcckykHoF6XJTLSNRzexEFrzlDk7+jJbGUjKrSZM0IwUMTNm0ff8VYhCZZeT2AgXBE7Fbps6sSqQw26SH+zp+nWIaoM7+zlG9z/GtL5W/MA1BkP8so1bc97BECCpHyL+e2/uE2Cqudkdnk4Tw3IVl9fPy+CMOwPHQ8E7G1qoQ78TQuDPW1zeEDGBWGb2UFz/xHFN5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SA2PR11MB5020.namprd11.prod.outlook.com (2603:10b6:806:11f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 04:46:04 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::f232:e1a0:b936:2aed]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::f232:e1a0:b936:2aed%7]) with mapi id 15.20.6544.024; Wed, 5 Jul 2023
 04:46:03 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Peter Newman <peternewman@google.com>
CC:     James Morse <james.morse@arm.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        Drew Fustini <dfustini@baylibre.com>,
        Babu Moger <Babu.Moger@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        "carl@os.amperecomputing.com" <carl@os.amperecomputing.com>,
        "lcherian@marvell.com" <lcherian@marvell.com>,
        "bobo.shaobowang@huawei.com" <bobo.shaobowang@huawei.com>,
        "tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>,
        "xingxin.hx@openanolis.org" <xingxin.hx@openanolis.org>,
        "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>,
        "Pitre, Nicolas" <npitre@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        "aricciardi@baylibre.com" <aricciardi@baylibre.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [RFC PATCH 2/2] resctrl2: Arch x86 modules for most of the legacy
 control/monitor functions
Thread-Topic: [RFC PATCH 2/2] resctrl2: Arch x86 modules for most of the
 legacy control/monitor functions
Thread-Index: AQHZoyiRzkyZFY81R02Tm9JumE5BQa+ppDIAgAEIVyA=
Date:   Wed, 5 Jul 2023 04:46:03 +0000
Message-ID: <SJ1PR11MB6083FF68838400D053C884B0FC2FA@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230620033702.33344-1-tony.luck@intel.com>
 <20230620033702.33344-3-tony.luck@intel.com>
 <CALPaoChdFLTfA5g=vawTuOLk5T6dEkG79XXqm27shh-VeqNCOw@mail.gmail.com>
In-Reply-To: <CALPaoChdFLTfA5g=vawTuOLk5T6dEkG79XXqm27shh-VeqNCOw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SA2PR11MB5020:EE_
x-ms-office365-filtering-correlation-id: ded8eebc-2d88-4ff2-c060-08db7d12bcfd
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n9YUPhmAbM9KTYFnqQIdYww+bodmLywBPvQJOCIDkC1as6waQrN3syYPzGMgRr5Ud5bvSCHAs+eGGWEeSAjeAd/Yb9HtjX/uNw0RxJURl4gXcNsIWey6GJWIt37+ox3UIiUvkwpIauYL3FEFakQ78/KqQw0VM3NpDRcGBJ6PEajiRlXQO4+x2kPmPH8BZGOKCHJ0sw0vR3xkPcEuoZij3B78rCaNMjsVM+FwrE8gwiN+8VwBhEFoS3OPqLPA9hXWGBQX40UbLxzyNFzo0K7vw1m9D5NeQgJ/xKAgphRL0z0fq9z4mKLKmiGSVkMB2U3YEyaIK4uGg/lITUMU6bJxEEr1Tk5HK/Uhp+GzkWUpVcmLS3kOTY4+nySjFbZPkDnxAq58BSvh/IqrkgOlMTDpeTB80pRVsi4EndPnqQ0FuYiVYTHR/Wyd0MG3uDGl+k5dUqFsPyoIHuj1Oo4lMiWLC0ubOFSyj7Bf4WBQ6GvtwFsDiNQPtEHoBDvuJYyxnSVnM1pIVEJo1Nfn26cJc21HP8YS5OAFNJhF4JFoyOGQZ5ITeWM0v6kAOKgI7SftXPFyVD+St3rTF88CvwaUNamMDZoJ4vdO0g/xL6ofORUygGU7PVzbM/Kyx31xoujYHPIQ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(346002)(136003)(366004)(39860400002)(451199021)(8676002)(2906002)(8936002)(55016003)(76116006)(52536014)(5660300002)(6506007)(7416002)(26005)(186003)(41300700001)(122000001)(7696005)(82960400001)(71200400001)(4326008)(66946007)(33656002)(66556008)(66476007)(66446008)(64756008)(316002)(83380400001)(6916009)(54906003)(38070700005)(478600001)(9686003)(38100700002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WlRUWFBGUTJVTmQ5RmlUOTJsb0xRQmVrVktObmN2SnVzLzdGNFFNQkRxSVdB?=
 =?utf-8?B?bTN2Y3NjVW16MGk1cmZ0aGZnZzZWZGhsVy93dFVnd1ZuamlkQWdDTzQ0TFN3?=
 =?utf-8?B?a29SSXVQT01lWHB0a040Ylo1bjF0SjM0VHY5N2tXb2lJQTJTbGNhYTNaMVY0?=
 =?utf-8?B?UUtMTDhuQkpsbXZYSkN3UEN2d2gxVldQL2tvQU9ZUU1pOHlyb2JHdExBQmJP?=
 =?utf-8?B?T0pDTCtDUXA2NTBMUTQ4SkQrN1JBeUxsMmQ4WEcwOEJmLzIxcGhRTTQ0aWx3?=
 =?utf-8?B?Q3huMGk4Q0JuOEErbm1takNadHZFUEdvVWF4bVoyNkljazlZbHd6YU5CZXJW?=
 =?utf-8?B?TTdrcEFMNGtPVEM5U3BydWRaaG5yTlBSTGJPUkpHNGRiL3RwdzVvVkVaU01K?=
 =?utf-8?B?dExDRThTOGVXR2ZyRGRUSmMvSHlnWElEMWZqc0h4TEpLWUtzLytDbTcrWVBs?=
 =?utf-8?B?UTk2SGZPOXhuN0E1cHJuNTg5eU5jZnlLMzhPSnRKM1A4UjlqWjY1eWxKRFFS?=
 =?utf-8?B?eDMwUEpvT2NDckdoeFhaUHhOSFFuNzRWYnE0SUYzeWZvandabGhpcXIxYk5K?=
 =?utf-8?B?aVU0WXhSZjhUSEtpUC94azY1aDNqME52OE0zUXEzc1ltQ3RhMkR0bFBXOFFk?=
 =?utf-8?B?OFNqZDZwejJaamZJZ2k4T2oybTUzOG5WajI3TGRCQkF2aVVzVWxsMFcxTlhP?=
 =?utf-8?B?RnpZY3crVmFVU0pDZG1oWEErQ1RORDhvK1lBaUQyb051VDcwUXRtMVdIOUpw?=
 =?utf-8?B?QmFYbFBPSGVaeERmUHBpN0cvQ0JtU2I0cS9LbEdvLzBWM3FONDQvZ2tHUFdQ?=
 =?utf-8?B?SWNxbEJlVFZSMmNRb0N5d09welE5d1dIL0RPbTAra0I3VGhjU1ZoMFNzZ1dO?=
 =?utf-8?B?ZlRBZE5OTGJQWDBZbHNBUE9jVytsRm5sdGx6N3FwRVpMejVOZm1oejFVdkE3?=
 =?utf-8?B?ZE5ZS1hkbmFWTVl2dHZPelhTOUJ5VzFYa1NyN1NQVWkwbVcyR3lGUVFWM1BP?=
 =?utf-8?B?a0VNL1BrT2sybER5NmErdHd1SDU5WDVUbWtFbjd4V3BXTWZqeWZqMmk0TnF4?=
 =?utf-8?B?cTFna1I2QW9RSHpNbTY2b2RLSExiRjU4NjlZNUNGOVU1SUJPaFgzQTFQNHFF?=
 =?utf-8?B?NG03dllUVmVlQjYyQW9LUzB2V2hFRWpjL3hMQjVRZFpkai9CT1hRREh1ZGs1?=
 =?utf-8?B?MHdhN0g0UHBydEhQQm5RWkhWclArOXh2b3hRR25kU3NjV2o4MFhweG1uWmpz?=
 =?utf-8?B?SllmT3lkNmh0OUk3QlRPK0hFT05nSzJVdDg3N3ZLRzhNVlYrMjIxVTlxWWtM?=
 =?utf-8?B?dkxqY0FpVjBsVVFUQkx5Y29BMEF1clZibGRPdmUvTTVrQ2RYM09KdmNZMUVn?=
 =?utf-8?B?UHUzWDExZjRjcWEwZm1YV3ozdVVkcUNZR1AyVXNOMW9LWFdFanMzZkhIUUFU?=
 =?utf-8?B?VE1TYXpNWFF0c2FvaFNzNnFhL2xwSGNlbWtpZkZWN3NIOStMMFNrcFNZSGJR?=
 =?utf-8?B?R25rYXdiOVB0V2hJUFNZTUwxd2R6VTJwNmR4bmlDMTZTSFpneC9sSlpCbHJr?=
 =?utf-8?B?cVFTYUxWNVpJeGo0NE5TQXU5REdqeE9Bcm9Cc1QwQVVHcllLSnJ1aWtMeGFJ?=
 =?utf-8?B?RnZJUnZSN0pWZzAwT2N5TGtsWlg1QmdKYUMrUUV4M21NMzlaRTNkL0tnZkdC?=
 =?utf-8?B?cWd4WGowVUQ3RkVFdXVBNGRXUHpMMHJETEk4aDhobHZUREJuSlpnRTNnbDRm?=
 =?utf-8?B?U1ppSWJRZFkrc3I5N1NCYXJqbzlqQURrd242a1h6bEREWFlKbiswM3IrbGJl?=
 =?utf-8?B?Ym5zcnNkT2gvZlBtcHdKb2JPUUY2V3M3dC9oMFZ4dHY2OFhscHp1VTFLMEFh?=
 =?utf-8?B?eHhYbjc4cE8xVnEwM0E2bnZyKzRLZy91TWRBeFdJMW0wS3plZWJhbDNFUElQ?=
 =?utf-8?B?K3FsZTVRSmFhWTRFQnNHWmxsSjNuOXMrRnViMkc5YzVuVWRodTlMTngxSWlu?=
 =?utf-8?B?bDhOWnc5anEvOE5kaE4xcVVscngxT0FiYzdlSFBkVFMvTHlsK2dYdkJZYU9M?=
 =?utf-8?B?UlVBMEMyb2pTQXRFWFRPS2s1U1V1THNUd2VvMDJXb2VtVmVyanphd0wzRW5z?=
 =?utf-8?Q?q1OY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ded8eebc-2d88-4ff2-c060-08db7d12bcfd
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2023 04:46:03.6679
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q2ejXcPOHvjTM9VbmrTv393UAFwIjewSUlzNcuNcqJAaylBSD+YTLdJWd4xkwptsKmc2DJQY+45SLQ9nHtA2pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5020
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

Pj4gKyAgICAgICBpZiAocnItPmV2ZW50IDw9IEVWX0xPQykgew0KPj4gKyAgICAgICAgICAgICAg
IHNwaW5fbG9ja19pcnFzYXZlKCZtLT5tc3JfbG9jaywgZmxhZ3MpOw0KPg0KPiBXaWxsIHRoZXJl
IHVsdGltYXRlbHkgYmUgYW55IGxvY2tpbmcgYXQgdGhlIGZpbGVzeXN0ZW0gbGF5ZXI/IEkgcmVj
YWxsDQo+IGZyb20gZmVlZGJhY2sgb24gbXkgY2hhbmdlIGFkZGluZyBhIHNwaW5sb2NrIGhlcmVb
MV0gYmVmb3JlIHRoYXQgdGhlDQo+IGZpbGVzeXN0ZW0tbGF5ZXIgbG9ja2luZyB0b29rIGNhcmUg
b2YgdGhpcy4NCg0KWWVzLiBXb3JraW5nIG9uIHRoYXQgbm93LiBUaGUgc3BpbmxvY2sgd2lsbCBn
byBhd2F5IHdoZW4gZXZlcnl0aGluZyBpcyBwcm90ZWN0ZWQuDQpieSByZXNjdHJsX211dGV4Lg0K
DQo+ID4gKyAgICAgICBpZiAoZXZlbnQgPD0gRVZfTE9DKQ0KPiA+ICsgICAgICAgICAgICAgICBz
bXBfY2FsbF9mdW5jdGlvbl9hbnkoJmQtPmNwdV9tYXNrLCBfX3JkdF9ybWlkX3JlYWQsICZyciwg
MSk7DQo+ID4gKyAgICAgICBlbHNlDQo+ID4gKyAgICAgICAgICAgICAgIF9fcmR0X3JtaWRfcmVh
ZCgmcnIpOw0KPg0KPiBJIGxpa2UgdGhhdCB0aGUgZHJpdmVyIGlzIHJlc3BvbnNpYmxlIGZvciBk
ZWNpZGluZyB3aGVyZSBJUElzIG5lZWQgdG8NCj4gYmUgc2VudCwgYnV0IGl0IGxvb2tzIGxpa2Ug
dGhlIGNvbnNlcXVlbmNlIGlzIHRoYXQgUkRULWxldmVsIGNvZGUNCj4gd2FudHMgdG8gYWRkIGlu
IHRoZSBjaGlsZCBtb25pdG9ycycgZXZlbnQgY291bnRzIG9uY2UgZXhlY3V0aW5nIHdpdGhpbg0K
PiB0aGUgY29ycmVjdCBkb21haW4uIFRoZSBvbmUtcGVyLWRvbWFpbiBJUEkgYXNzdW1wdGlvbiBm
cm9tIHRoZSBjdXJyZW50DQo+IHJlc2N0cmwgY29kZSBiZWluZyB3cm9uZyBpcyBwcm9iYWJseSBo
YXJkZXIgdG8gb3ZlcmNvbWUgdGhhbiBuZWVkaW5nDQo+IHRvIGZpZ3VyZSBvdXQgd2hhdCBhZGRp
dGlvbmFsIFJNSURzIHRvIHJlYWQsIGJ1dCBJJ2QgcmVhbGx5IG5lZWQgdG8NCj4ga25vdyB0aGUg
c3luY2hyb25pemF0aW9uIHJlcXVpcmVtZW50cyBmb3IgX19yZHRfcm1pZF9yZWFkKCkgdG8gaW5z
cGVjdA0KPiB0aGUgbW9uaXRvcmluZyBncm91cCBoaWVyYXJjaHkuDQoNClRoZXJlIGFyZSBsaWtl
bHkgc29tZSBnYXBzIGluIGN1cnJlbnQgY29kZS4gQnV0IEkgdGhpbmsgdGhleSBzaG91bGQgYmUN
CmZpeGFibGUuDQoNCj4gV291bGQgeW91IGNvbnRpbnVlIHRvIHByb21pc2UgdGhhdCB0aGUgRlMg
c3RydWN0dXJlIHdvbid0IGNoYW5nZQ0KPiBkdXJpbmcgYSBtb25pdG9yIHJlYWQ/ICBUbyB1cywg
dGhlIGJpZ2dlc3QgcHJpb3JpdHkgZm9yDQo+IHBhcmFsbGVsaXphdGlvbiBpcyByZWFkaW5nIGFs
bCB0aGUgZG9tYWluLWdyb3VwIGNvbWJpbmF0aW9ucyBpbiB0aGUNCj4gc3lzdGVtLCBiZWNhdXNl
IHdlIGhhdmUgYSBsb3Qgb2YgdGhlbSBhbmQgd2FudCB0aGUgdGlnaHRlc3QgcG9zc2libGUNCj4g
c25hcHNob3Qgb2YgYmFuZHdpZHRoIHVzYWdlLCBicm9rZW4gZG93biBieSBncm91cC4NCg0KVGhl
IG1ibV9wb2xsKCkgY29kZSB0aGF0IG1ha2VzIHN1cmUgdGhhdCBjb3VudGVycyBkb24ndCB3cmFw
IGlzDQpkb2luZyBhbGwgdGhlIGV4cGVuc2l2ZSB3cm1zcihRTV9FVlRTRUwpO3JkbXNyKFFNX0NP
VU5UKQ0Kb25jZSBwZXIgc2Vjb25kIHRvIGdpdmUgeW91IHRoZSBkYXRhIHlvdSB3YW50LiBCdXQg
ZXhpc3RpbmcgcmVzY3RybA0KZmlsZXN5c3RlbSBkb2Vzbid0IGxldCB5b3UgZG8gYSBidWxrIHJl
YWQuIEkgaGF2ZSBzb21lIGlkZWFzIG9uIGhvdw0KdG8gcHJvdmlkZSBzb21ldGhpbmcgYmV0dGVy
LiBPbmUgcXVlc3Rpb246IGRvIHlvdSByZWFsbHkgbmVlZCB0aGF0DQpzbmFwc2hvdCB0byBiZSBz
eXN0ZW0td2lkZT8gT3IgY2FuIHlvdSBsaXZlIHdpdGggc2VwYXJhdGUgTDMtc2NvcGVkDQpzbmFw
c2hvdHMgdGhhdCBhcmVuJ3QgdGlnaHRseSBzeW5jaHJvbml6ZWQgd2l0aCBlYWNoIG90aGVyPw0K
DQotVG9ueQ0K
