Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 243656901D5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 09:08:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjBIIIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 03:08:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjBIIIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 03:08:18 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD5D43669E
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 00:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675930097; x=1707466097;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=zA1STHI54ioIO3/OdB0mTXnEzzGoMdZ6tCqCsQkFhWQ=;
  b=Sj17J5Eabq0gjzYSX6I6hwhUg6btgTzMDc92VT0qcRqg8iN5rfUAPS+9
   IHMCI2TanG25LD5KQCWtxjBiQt4sUkEcZ0NI3SFaQGMF02UAp/tfAhztZ
   cAhZ8yQkFaelXi0QLnP5F77DB7uE4ym9y6ojczP+/4H4SROd/Mk5cLWt+
   pJBSlzQq717Rp281yIT0wIiadlU84s5uZtTHPwYJRLLjbz0+4Tzl1BMzg
   REDGRv9mCiqpAZdUFnYPCDu5JCoGb6qgl3HjAjCNWkgCkt49YLr60lVWc
   VczRzmTrmZFJI1leI2AxNJlTP+ioiJqy/Anl+sY3m2ZEQk5YWrhYZPiEJ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="328692823"
X-IronPort-AV: E=Sophos;i="5.97,283,1669104000"; 
   d="scan'208";a="328692823"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 00:08:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="810257427"
X-IronPort-AV: E=Sophos;i="5.97,283,1669104000"; 
   d="scan'208";a="810257427"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga001.fm.intel.com with ESMTP; 09 Feb 2023 00:07:56 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 9 Feb 2023 00:07:55 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 9 Feb 2023 00:07:55 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 9 Feb 2023 00:07:55 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 9 Feb 2023 00:07:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TqS3Aq932QmThrnCMTjTzM2PTXqal7CIo7+uJgPxrW4hBGkOP0r2KIcbR8H+CV+0BOGkvIqmzjxHt7rGq5MHMrIP6NW5NLnUL/oqophlgT7NpF5BYYwLkb25GLbPCNqo0rMChZG2ijY0GGy0OutZ2IXvIqTdioO4+VnkzloxM0olym9Yu/x7w2D1RXJlYkOfmnKAK9UwG5pHd/L2ncgILYdB8L1deOdHVuUef7BISC4m3Z4ksf9i/eSHb3i+XuOjRkeO8yN0NtwWHFVwRxT0rI8VtCPyQVZplwdAFXJKFQ6MGOtaFMeow/aR0NnbDQlAHgnri1iID1t2+WicHIoETw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zA1STHI54ioIO3/OdB0mTXnEzzGoMdZ6tCqCsQkFhWQ=;
 b=PDG+PkF+QI8SUJlJToYDKfCFlIUDVHxA83jt68iAeSy+/kUe0V8qIBJTlEDYSQ26tpl+6Rbp10qCyTC1nSsnoBkquvJ2eBKDNG+ZzSo7EvP6Ur3ymQtdcB0aT4wSgnT/X73SbxkV6Dnh4CD1mHH70wOc/EmZp8wA59gGCT0D97cuX8aO6YTHfnLixQVbke4VbQmXw6B70zs/T+I5AgOsYvgHInr6VGIEKvpVReP0n9+ux1EEzSiUt1lBozntmwmLFkDvQUe3DVQmkTjp+jC5jU6IfpuBfrqAHZGqvSWWcKm5RQFaJYaWhu1n2tcuoHtabuFZ21GMPk5sLSMNVBIJQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by DS0PR11MB7682.namprd11.prod.outlook.com (2603:10b6:8:dc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Thu, 9 Feb
 2023 08:07:52 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::5b0e:bf7:d908:2837]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::5b0e:bf7:d908:2837%8]) with mapi id 15.20.6064.034; Thu, 9 Feb 2023
 08:07:52 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "ricardo.neri-calderon@linux.intel.com" 
        <ricardo.neri-calderon@linux.intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>
CC:     "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
        "srinivas.pandruvada@linux.intel.com" 
        <srinivas.pandruvada@linux.intel.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Neri, Ricardo" <ricardo.neri@intel.com>,
        "vschneid@redhat.com" <vschneid@redhat.com>,
        "bristot@redhat.com" <bristot@redhat.com>,
        "ionela.voinescu@arm.com" <ionela.voinescu@arm.com>,
        "Chen, Yu C" <yu.c.chen@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        "bsegall@google.com" <bsegall@google.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v3 00/10] sched/fair: Avoid unnecessary migrations within
 SMT domains
Thread-Topic: [PATCH v3 00/10] sched/fair: Avoid unnecessary migrations within
 SMT domains
Thread-Index: AQHZPF2bLBJDh1L8+0C719OssYuiJQ==
Date:   Thu, 9 Feb 2023 08:07:51 +0000
Message-ID: <19416ae84ddbab82cb0419716c4c490ef296d08c.camel@intel.com>
References: <20230207045838.11243-1-ricardo.neri-calderon@linux.intel.com>
In-Reply-To: <20230207045838.11243-1-ricardo.neri-calderon@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|DS0PR11MB7682:EE_
x-ms-office365-filtering-correlation-id: 255674f5-0a1d-4307-56a2-08db0a74bda8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8kGXXDVfWGnZxIhQ8eMcmetZZ+ebqIEvCtpp0F9we6ZUiFA2/AsSHxd8jFVogXKaDXfFc1hP7vn/4WWcZUaz+c6hi9lF970mC1xteeUnDDay1e+vlP9Z1xtKXGkoWtpfTquRwFJxiX5wClR3nmTrRLyhhuVFgeoChk6ONYjF4EhfbJ0GfNnQ3qLKHvwCPDqHYS4XK/Xgn1SucZUAp244VjXHcBMj7PxyLT9aQ2oKhWXfjG4Z1HD49n2FOQ0aJGh0/f1emMzlinBj1X64dG4jG7mGE0M7gJHyxCfhv6c/R42bptzPABXFbKyLymS+Z79gXrXfyw6aLKutDUYgGSJxOefy0/R/IwJSjL81EdZ3z52ekHe5uhi9v5vykU585++jJk3Yi//KdO7yaTUg60nlVJBIeDEoS4CRM2iRoQP9CJ8YRvR0iM1zqvOMlnbsfOeR4tIQ4YCp1jQgKldbGS+iPxFtI6tFNEwQJFzYpFdifYfzQUP2JKUPWwWR08+34XwpzJx/AcMZh5502mCbKHzpq3j+Ep1EKPS8gvdGt0eb8Lto1t7W0H0xfRepUEdts/v/m1ouU758ybXw/3bpto+Olh51m5Fe+9r4uvxrnzn/XQI32rBwGG79s/SRK7Oe/z1tEX/tiTa2BmYFFGcYfXwM9k2h+FOQrz3mM1OAFV/PiJoJtpIbaAbvH3xFJfCI71vDEhIEBnz2dVA3mVOdJ2nnWV+ARS28la1jH8Yp8l2Pr1zyMyfp4InDbxmbGvaVUXvBJirmHySwTDcuseBDcPZvRg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(396003)(136003)(366004)(346002)(39860400002)(451199018)(83380400001)(2616005)(478600001)(54906003)(2906002)(316002)(76116006)(110136005)(38070700005)(91956017)(6486002)(38100700002)(71200400001)(82960400001)(36756003)(122000001)(966005)(41300700001)(66946007)(4326008)(66556008)(6506007)(8676002)(5660300002)(8936002)(26005)(7416002)(64756008)(86362001)(66446008)(6512007)(186003)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aDhlQ0RnUEhoRWRUZjhkSjd1VUkraDUyeGpUenM1MzhobUdMU25xOUYrME9z?=
 =?utf-8?B?Z01qR09kaVo3b1IwK0k3VWZ6S29hS1M2ckJMTDVCQ1RobzBUKzBGdng4QWhR?=
 =?utf-8?B?d0Vld0pNdndKbFMvWEkxbXBiQWR1SnRDREU4UzQrbU5PZjNMViswUWVMYmxD?=
 =?utf-8?B?anZtazczQzJWRW5mM2tMSmV1MEFLa0ZNanlWcy9CeUY3c3Z3eG5sMGUzS1JV?=
 =?utf-8?B?V1JKZndsNjdSc25vYUZVNEF2aFhQUXkzemZLV3hvYVFCdldnYVRHbm9HK3A5?=
 =?utf-8?B?N2xTM1dNS0lyR2ExTEJMTUpSVkN5MEh6cXY3b25TQWZ3QkR4SWsweGpxRkFT?=
 =?utf-8?B?ZzFscS9WK3FmdktQYUI2OFV1UUNOZG4rdW5ObXpNNUZMUkVOMmJFMmpOTXdp?=
 =?utf-8?B?eHFlRzhyQkFPNjFQbFZBRWpoMHZ1QU1MSFluZUk3cGpaOFMxRUU3aU1rSlFw?=
 =?utf-8?B?ZHk5S3FwKytKV2wxVHZjRkZWL3k4eGFpNnM3ZDVIaXMvTVNoR3F5YnlRYVVC?=
 =?utf-8?B?Zkp0YkNIcGFhL3BqZ2x6c2lrZ1U4VTJoTUQ4Qy9lOGJPN0lMUW5xSXluUmtW?=
 =?utf-8?B?aUZYbVlhYlFSZlNyNE9WRGR2QTFORFFaS1YvbVVFTDhuZjJreEE1cjR4WEoz?=
 =?utf-8?B?MS9rOCsxcTRrV0s0VEdFUjBHbVdOU1RxcnVBbGx3a05jWXdWYnlkQW5jc29F?=
 =?utf-8?B?UzdHNDdxZGpuU3cvWU9QUzBtQWxOZ1FXUXNyOG8wQndzZ2JvVmdzWUF5bFFm?=
 =?utf-8?B?d1QwdCt1Q1dtSFhaNWIxdlNnR1BieE9YaWtBV0EySGRlR3hqRVU0WGVoMVpm?=
 =?utf-8?B?eXhTTUE1TzFJTGwrTTR6WENtNklJZEorSlJNK05pT3J4emN1NCtaM0poak4x?=
 =?utf-8?B?RkZrcDVYMnJBU1RYM0pJQ0NMdXBEWVhjY25NTVh6SVdvU09GZlNMVEhFcTBa?=
 =?utf-8?B?Ykltc1pqekkzczhCNDdMTzdhOHNQYnNsajh4YkErYlNkckU2d2pUcUFjbjhL?=
 =?utf-8?B?ZFJxWjc2K1VzKzZDUGpjNm9iOXZDVzRoRmZZdTZSVmYveXdwOHFUMTBmK1FX?=
 =?utf-8?B?SVp4dEtFcEozejE1T3FDSTVnUnRqNzA4YXI0NkhBYmlUd1E2VDlGcUpRODNx?=
 =?utf-8?B?K3UrWUNlbEt2czB0M3ZsVFJITEtETWFXTXFubXZSam9sMVdJRWRLUGZuTExz?=
 =?utf-8?B?UVMrTjIyU3JPdUtzZWlSVWpTTU5yekNwN0pUc1ZaUkcxVlQ4c0l0WGwxY3Z2?=
 =?utf-8?B?bUFBVUNYZ0xOV3BuWVBzZkFYNFd6RFNjL2tPVnEzd3NKN0U3YWJnMGRBTEVQ?=
 =?utf-8?B?eUpsWkQ2WGlWWEVoZUpRRkd1SlM3UDhJNTQ3VWZ0U1dOUnhKbUpTVFNRSkVD?=
 =?utf-8?B?dU5FYk92cWRTY0laRUlGcEYyajVGb2VTQjA2YjZYWGNOQlRWZ2NBWnFsOHNN?=
 =?utf-8?B?RzZickk1c1Y2Um0vdk9lcmt1T0htSjU3MDRCWHFJcVhWQUdEbHIrRVNmY0Vi?=
 =?utf-8?B?c0N5Uk03SU9mNFIvY3JwRkMyMDZnTUU5dU4zNE4wcUxXalowODRNbWZxYTZT?=
 =?utf-8?B?My81QjJCMlo5b01ka214L2FzWkxVUVFENDJZUW9QTmpVeGhmWUdDM3Z0bHJU?=
 =?utf-8?B?cUpPSEtBNDNlWWtiTWRjM1Y0S2piVHo1dkNHRy8xN0VnUG5yWkxSZSs2ZTZp?=
 =?utf-8?B?SnhiNnhMbURyMEV6U0k0R1p6RUsxYjhGZzdGQVMremxPSXRWaW1uTW82MXE2?=
 =?utf-8?B?SC9kRXlVWE5qdG9QaTFhQldEYTFjeDBGdk9rRDkyeFp1NjZUakFmejBKbGlj?=
 =?utf-8?B?R25FdGV1RGwxOFdUMkREMEVXU0doZVJhQnQ0RUVERVo1aUMrQ2cwa3B3dWNx?=
 =?utf-8?B?YXVtSjVlOXRiQVNWa21LRjhFanhxQ1U2SHdUemZHdjFqaXhrUElGdlhPdDhG?=
 =?utf-8?B?THM5S2RtSFNWU051MFZienN2andTY2hVQzJoQjhVYW9XbTRiZmZja0FSRTho?=
 =?utf-8?B?Tk9NK1RxTzQyWTJBVTYyWWJoSHFiR2pabDN0ejg2WEw4TXovSEtoN3ZhN2xw?=
 =?utf-8?B?TmhIZ0VER2JyRHc1MFNSZEovREJYaXNLQzIxN21HbVhWZTRJZzRGakd5dUZm?=
 =?utf-8?B?aEtMYjduRFpjNkFGc3RmOFNvK0h5VEZIWGxDUWVDY2lmK3BUWHpDSjZZOGcx?=
 =?utf-8?B?cmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D00529BA352D05499FB749B3C2FD37B9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 255674f5-0a1d-4307-56a2-08db0a74bda8
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2023 08:07:51.7155
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gmmc1Bg1SuwcdGE2b09nEhn3CSk5TlltxzL/57/YSJ2mGyKQmJKhaW9O30UJwjhDkJOzxxdzON0yWVOEXmMA7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7682
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEFsbCwNCg0KT24gTW9uLCAyMDIzLTAyLTA2IGF0IDIwOjU4IC0wODAwLCBSaWNhcmRvIE5l
cmkgd3JvdGU6DQo+IEhpLA0KPiANCj4gVGhpcyBpcyB2MyBvZiB0aGlzIHNlcmllcy4gUHJldmlv
dXMgdmVyc2lvbnMgY2FuIGJlIGZvdW5kIGhlcmUgWzFdDQo+IGFuZA0KPiBoZXJlIFsyXS4gVG8g
YXZvaWQgZHVwbGljYXRpb24sIEkgZG8gbm90IGluY2x1ZGUgdGhlIGNvdmVyIGxldHRlciBvZg0K
PiB0aGUNCj4gb3JpZ2luYWwgc3VibWlzc2lvbi4gWW91IGNhbiByZWFkIGl0IGluIFsxXS4NCg0K
SSBoYXBwZW5lZCB0byBydW4gaW50byBhIHNpbWlsYXIgaXNzdWUgd2hlbiB0ZXN0aW5nIGFub3Ro
ZXIgcGF0Y2gNCnNlcmllcyB3aGljaCBhbGxvd3MgaWRsZSBpbmplY3Rpb25zIGZvciBwYXJ0aWFs
IGNwdXMgaW5zdGVhZCBvZiBhbGwNCmNwdXMuIA0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxs
L2E2OGE2ZjhjNzZjYjcxOWNkNDg2NWJkNmFhNzI2MzA2NzcyZDRlZTMuY2FtZWxAaW50ZWwuY29t
Lw0KDQpPbiBhbiBBREwtUCBOVUMgc3lzdGVtIHdpdGggNCBQY29yZXMgKGNwdTAtY3B1NyksIGFu
ZCA4IEVjb3JlcyAoY3B1OC0NCmNwdTE1KSwgdGhlIHByb2JsZW0gY2FuIGJlIHJlcHJvZHVjZWQg
YnkNCjEuIHN0YXJ0IDE2IHN0cmVzcyB0aHJlYWRzDQoyLiBmb3JjZSBpZGxlIGluamVjdGlvbiB0
byBhbGwgRWNvcmUgY3B1cw0KMy4gc3RvcCBpZGxlIGluamVjdGlvbiBhZnRlciAxMCBzZWNvbmRz
DQpBZnRlciBzdGVwIDMsIGFsbCB0aGUgUGNvcmUgY3B1cyBhcmUgMTAwJSBidXN5LCBhbmQgYWxs
IHRoZSBFY29yZSBjcHVzDQphcmUgYWxtb3N0IDEwMCUgaWRsZS4gVGhpcyBzaXR1YXRpb24gbGFz
dHMgZm9yIGEgbG9uZyB0aW1lLCB0aWxsIEkga2lsbA0KYWxsIHRoZSBzdHJlc3MgdGhyZWFkcyBh
ZnRlciAyMCBzZWNvbmRzLg0KDQpBZnRlciBzeW5jIHdpdGggQ2hlbiBZdSwgSSBhbHNvIHRyaWVk
DQoJc3RyZXNzIC1jIDE2ICYNCgljaHJ0IC1yIDcwIHRhc2tzZXQgLWMgOC0xNSBzdHJlc3MgLWMg
OCAtdCAxMA0KaW5zdGVhZCBvZiBpZGxlIGluamVjdGlvbiwgYW5kIHRoZSBwcm9ibGVtIGlzIGFs
c28gMTAwJSByZXByb2R1Y2libGUuDQoNCkFuZCBub3RlIHRoYXQsIHRoZSBwcm9ibGVtIGNhbiBi
ZSByZXByb2R1Y2VkIHcvIGFuZCB3L28gSVRNVCBlbmFibGVkLA0KYnkgcG9raW5nIC9wcm9jL3N5
cy9rZXJuZWwvc2NoZWRfaXRtdF9lbmFibGVkDQoNCldpdGggdGhpcyB3aG9sZSBwYXRjaCBzZXJp
ZXMgYXBwbGllZCwgSSBjYW4gY29uZmlybSB0aGUgcHJvYmxlbSBpcyBnb25lDQpib3RoIHcvIGFu
ZCB3L28gSVRNVCBlbmFibGVkLiBTbw0KDQpUZXN0ZWQtYnk6IFpoYW5nIFJ1aSA8cnVpLnpoYW5n
QGludGVsLmNvbT4NCg0KdGhhbmtzLA0KcnVpDQoNCj4gDQo+IENoYW5nZXMgc2luY2UgdjI6DQo+
IA0KPiBWaW5jZW50IGNvcnJlY3RseSBpbmRpY2F0ZWQgdGhhdCBJIHdhcyBhYnVzaW5nIGFzeW1f
cGFja2luZyB0byBmb3JjZQ0KPiBsb2FkDQo+IGJhbGFuY2VzIHVucmVsYXRlZCB0byBDUFUgcHJp
b3JpdHkuIFRoZSB1bmRlcmx5aW5nIGlzc3VlIGlzIHRoYXQgdGhlDQo+IHNjaGVkdWxlciBjYW5u
b3Qgbm90IGhhbmRsZSBsb2FkIGJhbGFuY2VzIGJldHdlZW4gU01UIGFuZCBub24tU01UDQo+IGNv
cmVzDQo+IGNvcnJlY3RseS4gSSBhZGRlZCBzZXZlcmFsIHByZXdvcmsgcGF0Y2hlcyB0byBmaXgg
aXQuLi4gYW5kIEkgcmVtb3ZlZA0KPiB0aGUNCj4gYWJ1c2Ugb2YgYXN5bV9wYWNraW5nLg0KPiAN
Cj4gRGlldG1hciBoZWxwZWQgbWUgdG8gcmVhbGl6ZSB0aGF0IHRoZXJlIGlzIGEgYmV0dGVyIHdh
eSB0byBjaGVjayB0aGUNCj4gaWRsZQ0KPiBzdGF0ZSBvZiBTTVQgY29yZXMuIE5vdyBJIGdpdmUg
dGhlIHRhc2sgdG8gdGhlIHNjaGVkdWxlciBpbnN0ZWFkIG9mDQo+IGFyY2hpdGVjdHVyZS1zcGVj
aWZpYyBvdmVycmlkZXMuIEkgdW5jb25kaXRpb25hbGx5IG9iZXkgQ1BVDQo+IHByaW9yaXRpZXMN
Cj4gYXQgdGhlIFNNVCBsZXZlbC4gVGhpcyBrZWVwcyBQb3dlcjcgaGFwcHkuIEF0IHVwcGVyIGxl
dmVscyAoaS5lLiwNCj4gd2hlbg0KPiBiYWxhbmNpbmcgbG9hZCBiZXR3ZWVuIGNvcmVzKSB0aGUg
c2NoZWR1bGVyIGFsc28gY29uc2lkZXJzIHRoZSBpZGxlDQo+IHN0YXRlDQo+IG9mIHRoZSBjb3Jl
IGluIGFkZGl0aW9uIHRvIENQVSBwcmlvcml0eS4gVGhpcyBzYXRpc2ZpZXMgeDg2Lg0KPiANCj4g
SW9uZWxhIHNwb3R0ZWQgYSB2aW9sYXRpb24gb2YgdGhlIHNjaGVkdWxlciB0b3BvbG9neSBzYW5p
dHkgY2hlY2tzLg0KPiBXZSBkaWQNCj4gbm90IGZpbmQgYSBjaGVjayB0aGF0IHN1aXRzIGJvdGgg
UG93ZXI3IGFuZCB4ODYuIEZvciBub3csIEkgcmVtb3ZlZA0KPiB0aGUNCj4gTkVFRFNfQ0hJTEQg
ZmxhZyBvZiBTRF9BU1lNX1BBQ0tJTkcuDQo+IA0KPiBIb3BlZnVsbHksIHRoZXNlIHBhdGNoZXMg
YXJlIGluIHN1ZmZpY2llbnRseSBnb29kIHNoYXBlIHRvIGJlIG1lcmdlZC4NCj4gDQo+IFRoYW5r
IHlvdSBmb3IgeW91ciBmZWVkYmFjayBhbmQgSSBsb29rIGZvcndhcmQgdG8gZ2V0dGluZyBtb3Jl
IG9mIGl0IQ0KPiANCj4gTmV3IHBhdGNoZXMgMiwgMywgNCwgNSwgNiwgNywgOA0KPiBVcGRhdGVk
IHBhdGNoZXM6IDENCj4gVW5jaGFuZ2VkIHBhdGNoZXM6IDksIDEwDQo+IA0KPiBCUiwNCj4gUmlj
YXJkbw0KPiANCj4gWzFdLiANCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDIyMDgy
NTIyNTUyOS4yNjQ2NS0xLXJpY2FyZG8ubmVyaS1jYWxkZXJvbkBsaW51eC5pbnRlbC5jb20vDQo+
IFsyXS4gDQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAyMjExMjIyMDM1MzIuMTUw
MTMtMS1yaWNhcmRvLm5lcmktY2FsZGVyb25AbGludXguaW50ZWwuY29tLw0KPiANCj4gDQo+IFJp
Y2FyZG8gTmVyaSAoMTApOg0KPiAgIHNjaGVkL2ZhaXI6IEdlbmVyYWxpemUgYXN5bV9wYWNraW5n
IGxvZ2ljIGZvciBTTVQgY29yZXMNCj4gICBzY2hlZC9mYWlyOiBNb3ZlIGlzX2NvcmVfaWRsZSgp
IG91dCBvZiBDT05GSUdfTlVNQQ0KPiAgIHNjaGVkL2ZhaXI6IE9ubHkgZG8gYXN5bV9wYWNraW5n
IGxvYWQgYmFsYW5jaW5nIGZyb20gZnVsbHkgaWRsZSBTTVQNCj4gICAgIGNvcmVzDQo+ICAgc2No
ZWQvZmFpcjogTGV0IGxvdy1wcmlvcml0eSBjb3JlcyBoZWxwIGhpZ2gtcHJpb3JpdHkgYnVzeSBT
TVQNCj4gY29yZXMNCj4gICBzY2hlZC9mYWlyOiBLZWVwIGEgZnVsbHlfYnVzeSBTTVQgc2NoZWQg
Z3JvdXAgYXMgYnVzaWVzdA0KPiAgIHNjaGVkL2ZhaXI6IFVzZSB0aGUgcHJlZmVyX3NpYmxpbmcg
ZmxhZyBvZiB0aGUgY3VycmVudCBzY2hlZCBkb21haW4NCj4gICBzY2hlZC9mYWlyOiBEbyBub3Qg
ZXZlbiB0aGUgbnVtYmVyIG9mIGJ1c3kgQ1BVcyB2aWEgYXN5bV9wYWNraW5nDQo+ICAgc2NoZWQv
dG9wb2xvZ3k6IFJlbW92ZSBTSEFSRURfQ0hJTEQgZnJvbSBBU1lNX1BBQ0tJTkcNCj4gICB4ODYv
c2NoZWQ6IFJlbW92ZSBTRF9BU1lNX1BBQ0tJTkcgZnJvbSB0aGUgU01UIGRvbWFpbiBmbGFncw0K
PiAgIHg4Ni9zY2hlZC9pdG10OiBHaXZlIGFsbCBTTVQgc2libGluZ3Mgb2YgYSBjb3JlIHRoZSBz
YW1lIHByaW9yaXR5DQo+IA0KPiAgYXJjaC94ODYva2VybmVsL2l0bXQuYyAgICAgICAgIHwgIDIz
ICstLS0tDQo+ICBhcmNoL3g4Ni9rZXJuZWwvc21wYm9vdC5jICAgICAgfCAgIDIgKy0NCj4gIGlu
Y2x1ZGUvbGludXgvc2NoZWQvc2RfZmxhZ3MuaCB8ICAgNSArLQ0KPiAga2VybmVsL3NjaGVkL2Zh
aXIuYyAgICAgICAgICAgIHwgMTc1ICsrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tDQo+IC0t
LS0NCj4gIDQgZmlsZXMgY2hhbmdlZCwgOTkgaW5zZXJ0aW9ucygrKSwgMTA2IGRlbGV0aW9ucygt
KQ0KPiANCg==
