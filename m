Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48A917327EC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 08:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242991AbjFPGxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 02:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234958AbjFPGxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 02:53:32 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EEAB2D4A
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 23:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686898411; x=1718434411;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=L1/fJTGqrSIFHNygD0bCsNYmljbuksRqnZVGBpoBOBg=;
  b=HFu8MU6oXd7rt5UAsD7BT1B11k0XCnNi8N4pIO0HicZLdLgTmLd9IYi/
   28gy2ZR3o4cgm1ksH+eZpSw84e1R0SFaR48GYsCcWBx6P4X8YyjBUdRiP
   DyqyH8mATvQNI0ENN2Alup89wNsBJ4OZ6fvifqw1VIx6aKL/v2KkSSUHa
   5QrjxoGZtis4fKU525HVgLjp50DapedXnNeelNYhKXrGowvUk2nz8F7Tf
   2fiQehbGq7OnZYS3K1+gIVmUGC/Ejamj0hL4SBAt7qD3e9Zy5B+XbLS2J
   FLqvSLs1Ix3o/qypl/cvV+caIqVg82mU7F2d4O2Hwq28Dgjrsnmr8obnK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="358019403"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="358019403"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 23:53:30 -0700
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="746068225"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="746068225"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 15 Jun 2023 23:53:30 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 15 Jun 2023 23:53:29 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 15 Jun 2023 23:53:29 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 15 Jun 2023 23:53:29 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 15 Jun 2023 23:53:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PhUWpkb9/oc0uBihIhWzehUNODEyGxysrNP+GE4EToXRGP4d/RKlJzJirJhOi0ETMVQjgIyRZeKn+LUWnWv8c1UhefeDII3reXoNpXNz5aEUpj6nOaIGOJOhc57w+6Pp9OkhMbI0aSu0aewYYabOH62rRgQvSliCJPRbRa51Sa2Hmpx5t1aFxzW4iIhM5oaFm2LY9IRkWiZpEeJzn3IdKjdGTbow2f6I9VeX3xnWmuRKNhjHmslliskE8rhNfRfu2xjGMl8AyarePjXjdT7EkHDwHwlGj7R0MQoFbDzxOKM2XAolJuiWziF67thaCHMfRrlxweqm6ze9RfLGEEro4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L1/fJTGqrSIFHNygD0bCsNYmljbuksRqnZVGBpoBOBg=;
 b=kqHENPSGViy4K/EB1RRylE6QdQP5vH/I7rizeXE00Z2fmk4EmEhkhz9oVgJjISb/KjI5Cex2rJr7FNTbxjlhQb3M11/jtnciGpGJZ+AaeRWH0oQb7hTuj8J8/utgjwBO4a7+ORX21cvwwurFE6vxGqaZlJhKLUmludqllgVQuGCI1M4iBvEwMQ5Npird8OSz9hY26vJJZ7bsgc16x5l55SqZyPb7XnINqITINqHvAK7IB6vPa1EVGrUu7+gj+CC1+xkJuO31su2AGlHHoC2ix0ZsCsfeqR+nCDQ+kpN/nSD6OE8jFj9I21jr+Tgg54XDOOMUPjfaTLIPFuvvQCdEEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6605.namprd11.prod.outlook.com (2603:10b6:510:1b0::16)
 by CY5PR11MB6307.namprd11.prod.outlook.com (2603:10b6:930:21::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25; Fri, 16 Jun
 2023 06:53:21 +0000
Received: from PH7PR11MB6605.namprd11.prod.outlook.com
 ([fe80::f6a8:daa0:7575:801d]) by PH7PR11MB6605.namprd11.prod.outlook.com
 ([fe80::f6a8:daa0:7575:801d%7]) with mapi id 15.20.6477.037; Fri, 16 Jun 2023
 06:53:21 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "peterz@infradead.org" <peterz@infradead.org>,
        "Tang, Feng" <feng.tang@intel.com>
CC:     "Chen, Tim C" <tim.c.chen@intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Patch v2 2/2] x86/tsc: use logical_packages as a better
 estimation of socket numbers
Thread-Topic: [Patch v2 2/2] x86/tsc: use logical_packages as a better
 estimation of socket numbers
Thread-Index: AQHZnbiCY6eum+iSlk2uGaiesk42zq+LmcaAgAFpQIA=
Date:   Fri, 16 Jun 2023 06:53:21 +0000
Message-ID: <d97fe59e47de77a36746107e4070e44ed46bf4d1.camel@intel.com>
References: <20230613052523.1106821-1-feng.tang@intel.com>
         <20230613052523.1106821-2-feng.tang@intel.com>
         <20230615092021.GE1683497@hirez.programming.kicks-ass.net>
In-Reply-To: <20230615092021.GE1683497@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6605:EE_|CY5PR11MB6307:EE_
x-ms-office365-filtering-correlation-id: 70644180-dc17-4b76-3d97-08db6e365f6f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x+Y8CIwHNaXJpeJwcpch9ks+D6tU5lpzgKCeG+qwPATsRnhZhxmueaMdXwa77E/GxD0JcJRFlXW/KFqlTPndz2fDPyXYoV36chuKXw1d5sCRsL3JP0VkNdCaK/wiJDfCjb1lYrr4gHiVyvXVnpRMi+xFYbfNbmY+Cy2j4fWve7Ge0696UWivFXGCvTj0CkhasA+R/0xIj+gy067F6YRe0E1KQ3xSSjBqUkUUlMObujpSznZOFBJLAQox51km9VIOZ9cf4IIe8Sjm2qsNh3X6pDZOGIPmmoDojMNWitVN8UJ2pYXm55/n1w5Sk/kyCYDnKQiKW+8cnTd+Vg1Jk/rLPSUXcHpHQYIVuloQ579sfos1KGK3cMwiuemVL5d6ab1OQjitWM97YLbgFTuQZJgEIhEmdoRWCluh29Jr+W9v4l2D3FpnWNzVU1naC8I16KkgoGlTbokyaCFLixx1E4USXgNws3ggm/r7+X0c+DlPkQCtnDB3L81J8ZSXh15LjJ9rrdXACxF9Sd9y+1/Fm/HklnaVRP7OVKX6LUV12abrh2LWtFYo96tiH5J4s4LRRUj6kZS1P8mWIYbLWXPrqhw+ClbkZuhRsgkQpW2oqjDa7zIE8IKn+cz9P+NJmc/+6csC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(366004)(39860400002)(376002)(136003)(451199021)(5660300002)(478600001)(54906003)(8936002)(41300700001)(8676002)(316002)(6486002)(6506007)(7416002)(186003)(4326008)(71200400001)(64756008)(66446008)(6636002)(66946007)(76116006)(91956017)(66476007)(66556008)(6512007)(26005)(110136005)(2616005)(2906002)(83380400001)(82960400001)(38100700002)(122000001)(86362001)(38070700005)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?elhxdE02OFdiaU90ZzF5cVcxemRibzZudkYramM0c0FGL2c1YWl4bUY2RU9o?=
 =?utf-8?B?SmtvM3lGMzR4ejhaK09iVDI0VUJZd0xlSkZucGkwcDNvOE9MSW9TdklLbnFo?=
 =?utf-8?B?SnpOZTFGNFAyWW8rU0NVNVBBK2l0UVZPem1uZmNhYSt6RGhRVlFEOU0vSlZE?=
 =?utf-8?B?MndoNVZZVitxcTFBWFV1cG9aN0ZWMzdWV3BqVlJEQWtUUU43VlhOUzlVdkpl?=
 =?utf-8?B?RXRYREZQVzNTRERWNm13S2t2RzNQNit6VGdybkFWQ2JGU00yeURnYnBGMEpZ?=
 =?utf-8?B?ZHM2NWRydHJGb2t3MFJ6UEx3YUp3ckEzM0hSWFpwU3FsSXVJU3R3bFNnczFJ?=
 =?utf-8?B?b0M3U2t2dTloRGNmWEtHbnZVRHduZkhoL0xFRlpGWFFwZjZVeWJnNmkybHVE?=
 =?utf-8?B?TVEwSFVHdlhraXcrZ0lTV1NySXM1M2xETXIvb0IreHNrV01jTFZpMTRRUFFz?=
 =?utf-8?B?a0MwaC9IcnhjU1hvbGpNeXhCOVZ3VmVjNTlpL2FDNFlvQ0pZS1QzdEp0d29r?=
 =?utf-8?B?TlR6M3RBd29oN3E5bUFSdEFyeWovdSt5MEdMVkhYNVpyanNxbzdiL2F3U3ow?=
 =?utf-8?B?SjNvdlp2NkllZDBLL0JBdEpZcnVVaDF2cG95T1c3THFZOVljNUJTK3lqM3Na?=
 =?utf-8?B?aHFiNWJZbldhK24wd1JXZmhkQ0pSUVM0M1ZmNy93K0UrZFBodnJWQkplTFlz?=
 =?utf-8?B?cUJ4SXNySVBhLzBuamk0ZVhGNWV0YjRBVklEdEp6Nzk5bU5WT2doVjJLZU12?=
 =?utf-8?B?UHdoMUxBNDVta1UvaTFVbkhvSUl5SUtuZmtNdEdKMTNoRkVXejFUcjFIZW5V?=
 =?utf-8?B?aCtYR0g0VTJZeFphZkRoODAzcjBQcTUxRWwxdUROSms1QlM5Vmt4QWhHWTlC?=
 =?utf-8?B?K1NtWFhKQkV1T3pER25MWGkwK0Y2VHpMaTEybE42NExTTWgrMXhuc2Q0SWsw?=
 =?utf-8?B?eG5qV0d1N21SY1VBL211WDZBRVEySFhjY3hqWU54eGxBdyt2NlZzU2Q3T0I4?=
 =?utf-8?B?RFdzMGhBb3ZXcDNYVk5qOWc2Q3lsMTZUN3JXN2ZqMTB4d0RvN3NMamFPaVZm?=
 =?utf-8?B?dmxxYWtuUHpnTzdwSkxaV3d2aE5xWmpHZ2NNWDhnbGJFZUx0dVlOOE56U0xR?=
 =?utf-8?B?WmpoOEl5dTZjenpRSWpFZDlMbXIyd004dUxnaFlTMUJlcUhybDAwWFdnR0VO?=
 =?utf-8?B?SWEzVTRWZkRLbldyNGduekprWFRLTm12SHM0UThwVzg5aFUwcFFHOWtCdTNF?=
 =?utf-8?B?cmtTaGVFMklQMWNXeVhReWNlMWVCekRUdjFvQXp0NFU0bTQvTGdVNWZ0dHRV?=
 =?utf-8?B?N1RKb3NhZENMQzFlKzhwd2ZpYzJ5UEIvdnlxcTIxQU9nRnhXZ2RRVFRkRzBo?=
 =?utf-8?B?RkhWNTREb2VXclgyYnhwcGhsSXJldDVLMmR6blowRUFNY2RmQWF6UEZPMnl6?=
 =?utf-8?B?RTlaUWRzc21VTTEyYVNQcTM2THU5RkJqYVBsTjVNR0xJMHc4blBzbTNxWURU?=
 =?utf-8?B?cTJRMm1WZkpibXJNWWNYbXJXSUhFMGY2UTJrRzVVYU0zSDdNU0pDc25qcGdG?=
 =?utf-8?B?ckYyWURRVTJsS0ZRZldrZ0xXbHFVc0pNMXRNNFQ1M1Y5SHdyUEgwNzNGSUsv?=
 =?utf-8?B?T0srbFdPMEI4RzV1am5ycXFSK2FtZzRJb3JvVWpwcFhrYjR5bS9pUUpPQ3A5?=
 =?utf-8?B?UEVPOFI1S3JZMWxlVGRVNUJ2blVIN054R2tSSHJuck9zUkdWUEwwQ21JS2tJ?=
 =?utf-8?B?bjBSRTV2dWFyWENqcTBMN0FhSmQzNTNKdVlLdVlJeHBCWVg4OEVEK3k3UHk2?=
 =?utf-8?B?QmN4L0kxc3NtL3A2b0RTaXdzZW44MGpNQlFRQWEvdEJsSTF2RDJpVHcrTmVs?=
 =?utf-8?B?ZWQ3S1U0cUNOd1JIRjErSmxkUUZ0dEErTzNia1MzakcvSDVzbnI1Y1E0QXpX?=
 =?utf-8?B?aHE1dTNVTFhRSzdmdVdXbUwvVkk1b3RGclRrRzhjV2paNjFZVUg5WkUwblZH?=
 =?utf-8?B?dk1BckFTeFdhbjdmKzJKUGhENFJYTUF3NC9YNzhUYVcyZ3Z3aDFYVWF5RDNU?=
 =?utf-8?B?bTllSzhoc1huWjVMTXRiS1kwOVZGaWpGdWhMMmVnMWVQU3YvWGpHTHQwTUxS?=
 =?utf-8?B?U3pReTlZRkRheG5XZVFLTHBRcUxsQVRCZ2QrMklrMUtTb1BZRmZpZ1JTQ2lt?=
 =?utf-8?B?dWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <85232659BBC41D4B8ED9423D3497C401@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6605.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70644180-dc17-4b76-3d97-08db6e365f6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2023 06:53:21.0966
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7Sfbr01rhsULCDuOfJ3gEiej/XXx2g8kQ3kK0b/vZK1leOI2QEfUi2/qUF7ABbAEPABsnXMIQzd3kmg2R6QllQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6307
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

T24gVGh1LCAyMDIzLTA2LTE1IGF0IDExOjIwICswMjAwLCBQZXRlciBaaWpsc3RyYSB3cm90ZToN
Cj4gT24gVHVlLCBKdW4gMTMsIDIwMjMgYXQgMDE6MjU6MjNQTSArMDgwMCwgRmVuZyBUYW5nIHdy
b3RlOg0KPiA+IENvbW1pdCBiNTBkYjcwOTVmZTAgKCJ4ODYvdHNjOiBEaXNhYmxlIGNsb2Nrc291
cmNlIHdhdGNoZG9nIGZvciBUU0MNCj4gPiBvbiBxdWFsaWZpZWQgcGxhdG9ybXMiKSB3YXMgaW50
cm9kdWNlZCB0byBzb2x2ZSBwcm9ibGVtIHRoYXQNCj4gPiBzb21ldGltZXMgVFNDIGNsb2Nrc291
cmNlIGlzIHdyb25nbHkganVkZ2VkIGFzIHVuc3RhYmxlIGJ5IHdhdGNoZG9nDQo+ID4gbGlrZSAn
amlmZmllcycsIEhQRVQsIGV0Yy4NCj4gPiANCj4gPiBJbiBpdCwgdGhlIGhhcmR3YXJlIHNvY2tl
dCBudW1iZXIgaXMgYSBrZXkgZmFjdG9yIGZvciBqdWRnaW5nDQo+ID4gd2hldGhlcg0KPiA+IHRv
IGRpc2FibGUgdGhlIHdhdGNoZG9nIGZvciBUU0MsIGFuZCAnbnJfb25saW5lX25vZGVzJyB3YXMg
Y2hvc2VuDQo+ID4gYXMNCj4gPiBhbiBlc3RpbWF0aW9uIGR1ZSB0byBpdCBpcyBuZWVkZWQgaW4g
ZWFybHkgYm9vdCBwaGFzZSBiZWZvcmUNCj4gPiByZWdpc3RlcmluZyAndHNjLWVhcmx5JyBjbG9j
a3NvdXJjZSwgd2hlcmUgYWxsIG5vbmUtYm9vdCBDUFVzIGFyZQ0KPiA+IG5vdA0KPiA+IGJyb3Vn
aHQgdXAgeWV0Lg0KPiA+IA0KPiA+IEluIHJlY2VudCBwYXRjaCByZXZpZXcsIERhdmUgYW5kIFJ1
aSBwb2ludGVkIG91dCB0aGVyZSBhcmUgbWFueQ0KPiA+IGNhc2VzDQo+ID4gaW4gd2hpY2ggJ25y
X29ubGluZV9ub2RlcycgaXMgbm90IGFjY3VyYXRlLCBsaWtlOg0KPiA+IA0KPiA+ICogbnVtYSBl
bXVsYXRpb24gKG51bWE9ZmFrZT00IGV0Yy4pDQo+ID4gKiBudW1hPW9mZg0KPiA+ICogcGxhdGZv
cm1zIHdpdGggQ1BVLWxlc3MgSEJNIG5vZGVzLCBDUFUtbGVzcyBPcHRhbmUgbWVtb3J5IG5vZGVz
Lg0KPiA+ICogU05DIChzdWItbnVtYSBjbHVzdGVyKSBtb2RlIGVuYWJsZWQNCj4gPiAqICducl9j
cHVzPScgYW5kICdtYXhjcHVzPScga2VybmVsIGNtZGxpbmUgcGFyYW1ldGVyIHNldHVwDQo+ID4g
DQo+ID4gUGV0ZXIgWmlqbHN0cmEgc3VnZ2VzdGVkICdsb2dpY2FsX3BhY2thZ2VzJywgYW5kIGl0
IHNlZW1zIHRvIGJlIHRoZQ0KPiA+IGJlc3Qgb3B0aW9uIHdlIGhhdmUgYXMgaXQgY292ZXJzIGFs
bCB0aGUgY2FzZXMgYWJvdmUgZXhjZXB0IHRoZQ0KPiA+IGxhc3Qgb25lLiBCdXQgaXQgaXMgb25s
eSB1c2FibGUgYWZ0ZXIgc21wX2luaXQoKSBhbmQgYWxsIENQVXMgYXJlDQo+ID4gYnJvdWdodCB1
cCwgd2hpbGUgJ3RzYy1lYXJseScgaXMgaW5pdGlhbGl6ZWQgYmVmb3JlIHRoYXQuDQo+ID4gDQo+
ID4gT25lIHNvbHV0aW9uIGlzIHRvIHNraXAgdGhlIHdhdGNoZG9nIGZvciAndHNjLWVhcmx5JyBj
bG9ja3NvdXJjZSwNCj4gPiBhbmQgbW92ZSB0aGUgY2hlY2sgYWZ0ZXIgc21wX2luaXQoKSwgd2hp
bGUgYmVmb3JlICd0c2MnIGNsb2Nrc291cmNlDQo+ID4gaXMgcmVnaXN0ZXJlZCwgd2hlcmUgJ2xv
Z2ljYWxfcGFja2FnZXMnIGNvdWxkIGJlIHVzZWQuDQo+ID4gDQo+ID4gRm9yICducl9jcHVzJyBh
bmQgJ21heGNwdXMnIGNtZGxpbmUgY2FzZSwgdGhlIGdsb2JhbCBmbGFnDQo+ID4gJ3BhY2thZ2Vf
Y291bnRfdW5yZWxpYWJsZScgd2lsbCBiZSBzZXQgdG8gdHJ1ZSBhbmQgdGhlIHdhdGNoZG9nDQo+
ID4gd2lsbCBiZSBrZXB0IGFzIGlzLg0KPiANCj4gU28gSSBoYXZlIGF0IGxlYXN0IHR3byBtYWNo
aW5lcyB3aGVyZSBJIGJvb3Qgd2l0aCAncG9zc2libGVfY3B1cz0jJw0KPiBiZWNhdXNlIHRoZSBC
SU9TIE1BRFQgaXMgcmVwb3J0aW5nIGEgc3R1cGlkIG51bWJlciBvZiBDUFVzIHRoYXQNCj4gYXJl
bid0DQo+IGFjdHVhbGx5IHRoZXJlLg0KDQpEb2VzIHRoZSBNQURUIHJlcG9ydCB0aG9zZSBDUFVz
IGFzIGRpc2FibGVkIGJ1dCBvbmxpbmUgY2FwYWJsZT8NCmNhbiB5b3Ugc2VuZCBtZSBhIGNvcHkg
b2YgdGhlIGFjcGlkbXA/DQoNCkkgaGFkIGEgcGF0Y2ggdG8gcGFyc2UgTUFEVCBhbmQgY291bnQg
dGhlIG51bWJlciBvZiBwaHlzaWNhbCBwYWNrYWdlcw0KYnkgZGVjb2RpbmcgYWxsIHRoZSB2YWxp
ZCBBUElDSURzIGluIE1BRFQuDQpJJ20gd29uZGVyaW5nIGlmIHRoZSBwYXRjaCBzdGlsbCB3b3Jr
cyBvbiB0aGlzIG1hY2hpbmUuDQoNCj4gDQo+IFNvIEkgdGhpbmsgSSdtIGx1Y2t5IGFuZCBzaWRl
LXN0ZXBwZWQgdGhpcyBub25zZW5zZSwgYnV0IGlmIHNvbWVvbmUNCj4gd2VyZQ0KPiB0byB1c2Ug
bnJfY3B1cz0gZm9yIHRoaXMgc2FtZSBwdXJwb3NlLCB0aGV5IGdldCBzY3Jld2VkIG92ZXIgYW5k
IGdldA0KPiB0aGUNCj4gd2F0Y2hkb2cuIFNhZCBkYXkgZm9yIHRoZW0gSSBzdXBwb3NlLg0KDQp3
aGF0IGlmIHVzaW5nIHBhY2thZ2VfY291bnRfZnJvbV9NQURUPw0KDQp0aGFua3MsDQpydWkNCg==
