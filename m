Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFAD973BBCC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 17:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbjFWPhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 11:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232063AbjFWPhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 11:37:08 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1102126
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 08:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687534624; x=1719070624;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=avjJXHDm+8ifX9ESL9GtF6SvZ3yNRTtbyJlMMxo9oDM=;
  b=d3OxDAFxQ98meUBXhlEs1VC4/soWwy8DLPOV1nx8Mhg6Zeee36lPPHXB
   j3Xs/ubmpWP0adTSgH5p70ZpkjPjmj0RV3D0LLVpBMpvvFrXFYUDCE0uK
   Br9cXbWumJJjT5TQk5RUdGju6HqiJTjmbfM0K8gQ6IJjreKmTX4+pAB26
   LdVvYT1Q4PlpEJqUTe8FDcV9jmAVlLdAJ6XYeQdCJe0SHzGPQOu6Pg7n/
   d4d1Qt9GE8jDMOQ/9I4TT7DxRgpCg3yeKKi7JoTX8IRj/Ya1DIq40i8zQ
   jBM2RRaRkFOtFI8C9OUE/So7y2pAZQV5yWflHh7C2vx/1JPcS88WoE2TE
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="447168035"
X-IronPort-AV: E=Sophos;i="6.01,152,1684825200"; 
   d="scan'208";a="447168035"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 08:37:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="665517851"
X-IronPort-AV: E=Sophos;i="6.01,152,1684825200"; 
   d="scan'208";a="665517851"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP; 23 Jun 2023 08:37:01 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 23 Jun 2023 08:37:01 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 23 Jun 2023 08:37:00 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 23 Jun 2023 08:37:00 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 23 Jun 2023 08:37:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cTvtz08itrctQHwhsdKfr/c1zNG/DHXheHCkD73sFAMpewV0W9Jp7XjURdNsynZ1FpxapH2CkKnATfUL+abzx3768i4YZBmk1QugHOyiHnhl8oDza6KCTsiRD8RkjThjQYHhxyz1Qx8+u2+2pfqWepbQSdqpIQfLieSJb66vlZ94WSTtul2kQ+pYrQuQaHDjFtHN/iH9ENa4IkcuoPDK2QYvehZJtzI1Gfnv0zu+RTQqulyltVzwWXp5z5GDcxDrKmo2C9vH31tHVSuo0ry7le9fjUjxHI/ECtxIrfI24jygF3gBIhx06CAAlbS+r0lO7XtIedcGktuUvIOMq3XAMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=avjJXHDm+8ifX9ESL9GtF6SvZ3yNRTtbyJlMMxo9oDM=;
 b=X9IYeh8JAoCyXEI1jKviee7SXXvkv/Q4jmjmf7q1aFFT0viFvZfO3ovGoiC9uSpzXedO/6I1JndeVN8LF5YzaBWfNo+MhS1QPrPez5c8w8UAHsXTAdHUyFH0vL8bMC/DsvASax1PYE3XI0RrN78mXmTCkNI37HlRqjlH/lsb/mvwTRtUIMFQJUG+/aNp1Em4G7TUo+FqsOjXcCD/ibyQVNU3znpG7HzGY1rxOh4+GA/pHGA2NioybQ1kqeSOtVaMJ/8Ope4izkn8MupoeSusnScml6ejMSo5PSVTWusQkC+2Rj7+hzsOUysWtfiFCzr2j4vXVcBJPDhjJOYyVUknJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0SPRMB0086.namprd11.prod.outlook.com (2603:10b6:a03:4ed::18)
 by MN2PR11MB4709.namprd11.prod.outlook.com (2603:10b6:208:267::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Fri, 23 Jun
 2023 15:36:57 +0000
Received: from SJ0SPRMB0086.namprd11.prod.outlook.com
 ([fe80::f2e:b472:607d:dfbf]) by SJ0SPRMB0086.namprd11.prod.outlook.com
 ([fe80::f2e:b472:607d:dfbf%5]) with mapi id 15.20.6521.023; Fri, 23 Jun 2023
 15:36:57 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "Tang, Feng" <feng.tang@intel.com>
CC:     "Chen, Tim C" <tim.c.chen@intel.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "Woodhouse, David" <dwmw@amazon.co.uk>
Subject: Re: [Patch v2 2/2] x86/tsc: use logical_packages as a better
 estimation of socket numbers
Thread-Topic: [Patch v2 2/2] x86/tsc: use logical_packages as a better
 estimation of socket numbers
Thread-Index: AQHZnbiCY6eum+iSlk2uGaiesk42zq+LmcaAgAFwMQCACeXpgIABpcQA
Date:   Fri, 23 Jun 2023 15:36:57 +0000
Message-ID: <5df3cca321782fecdfcfac9f4139da5a7fdf3277.camel@intel.com>
References: <20230613052523.1106821-1-feng.tang@intel.com>
         <20230613052523.1106821-2-feng.tang@intel.com>
         <20230615092021.GE1683497@hirez.programming.kicks-ass.net>
         <ZIwMstkB7CG3pDYu@feng-clx> <87h6qz7et0.ffs@tglx>
In-Reply-To: <87h6qz7et0.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0SPRMB0086:EE_|MN2PR11MB4709:EE_
x-ms-office365-filtering-correlation-id: d5a9a5a5-e2c1-4213-d696-08db73ffadc0
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: goTzM7FUc1qRUrbbjO+UdpBgR8Q4qv0T1DlVQXhiby9Z1up+pUH3Xnwvlpuu+VhZ8UPKrLQ0CnrTjl0txA6hQ/rEP4W5TzFDg5+jHskyl6n8CImUdOaefum/VeQYyaKaz0+qO9HcGIFOuRLSQtNUQbK6FcePoszuMLQLOVVpDO+lfzWj0po4ovr18QAapG8iFZKX6YLxuUGYWoPP9Q3RlZN6Uf7LutWYvLUkeM3koNfTKAAVtyrpuYkkJqqCKM+b3Zhg8n0jDnwdV9C8sJqaisW3hOflDQGM9pTvpCJe2hA0LCNYHpEnsOBTkvdO2KWRUVJcYbXiRtONkbStjXrnN0aCXS4ub8+nFH4Z72AgResTEKiaV2NeiroYvVLaN+DBnY8KtvHZE0TwzhixHSPVJmuWbsaA7bfjlFP8BUq3wnCQVB4jc+Qzubb6SkuhXNIGK7r8JN4q/C2f7wOPp+fEhCjqSFsrTuKfUUsT1hOY3koOkw6ZW05/CBTJUI5c//w77zd1peh7m3wlm0nqGfhiQi8i8cKZByCbj5t6/UAQX6GHDRtbhZCYmaH54oY+6kyHhTTz8GtvequUVfxJtHN20OQFwLpcRPbaK4aWN/qWDajEMHhjc4ifF/Nx2vWwEDCw
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0SPRMB0086.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(39860400002)(136003)(396003)(376002)(451199021)(122000001)(6506007)(6512007)(71200400001)(186003)(6486002)(82960400001)(478600001)(54906003)(86362001)(110136005)(2616005)(66446008)(64756008)(66476007)(76116006)(91956017)(66946007)(66556008)(4326008)(6636002)(83380400001)(7416002)(41300700001)(316002)(5660300002)(2906002)(26005)(38100700002)(8676002)(8936002)(36756003)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?LytFN0s3UG9LM3JiLzdMYnRJTzErdUZQQ3hwOUpVbTJUWW8rRTgwaTRGelNJ?=
 =?utf-8?B?bXJGQ2pzbDcwNktOcjlyQnpxRGxHcThaV05mL2l3UXlPRjBqejFWZFQvOVdD?=
 =?utf-8?B?My9uelEyN0phSWZTTHYrNUtVNEx6KzdyUXV3RXl1dUF5WlRLRGhQRHc5M0pO?=
 =?utf-8?B?QnJoY2pocmUraHY5TnQwc0lLNGdHaFpURU1pUDBhOFMxOXQ0TDFRdVlYS0sz?=
 =?utf-8?B?Sm9iYmszUGJBZE05YWVVS3RLRmxJOTBmY0ZsalVVd0hrOWNJU2NZNGkvemd0?=
 =?utf-8?B?eWs1THhFa3U2TmJPQUtnU3hLbDlQMTBlOFJ5R0dGM2NGUWFwZzMvWjVoeHpy?=
 =?utf-8?B?aVlESytUNlFNVmM5K1pETHZSQjl1dGliRzBQN2NwK2lUYzZveEZVa3RpUlEy?=
 =?utf-8?B?OEpUSXdkczhuRUpZeWdITWdvOHVGNktqTHAza1MrL05KUEIzUTVvUytkVGF4?=
 =?utf-8?B?VXE1STA5RkdlVVpTWUhaeGlzcW9NWk1IeVgwcU05SDU5V3czN2RRT2hEcFFj?=
 =?utf-8?B?YmkvZ0JqYkZjUVFhRHlFdUh1cWx6YnlqRktiVU5oaGhXZ3J0OGdnZDNtcmM5?=
 =?utf-8?B?L0lVZ3U0c2xEUklaQmZlc2d6aHhVMk1hdW9abG5nUTM5NjQ1U1pwSFRVMG8z?=
 =?utf-8?B?eVJ0amZpbTBVQWk2TG0wRVkyRXI1aGpKVGRmOTZucFYxMXVKQmJoUmVGZm85?=
 =?utf-8?B?ZnVubjRIZk9sREVjUlJMTFM3WWdQZE9WdzZ6UTNraFVnRGlra1dqbEc0cjlG?=
 =?utf-8?B?THM5cXJpazJ6RWs1d1c3SzMzTzdYY0NIclp1YXFuL05pMG1PeFFnR2JYOVAr?=
 =?utf-8?B?SG03b1dPbGtXYWI5UEJNbS93RW5CNVBuUlduU3o4RWhTWW5Md3lFMDkvTDRX?=
 =?utf-8?B?L2FOaGkxdXYvM2pKM1dSbmtFMTcxVm8vNThiSHVDM2ZxdG5STjE5a01BVERn?=
 =?utf-8?B?d2p3MCt0Nzk2dmFtZmFDT1VrK2dmZDdiN2QrbGkxWjV2OXJXNE5uNGZ0YjFi?=
 =?utf-8?B?UXh4OWJKc0ozOE1DZ2QxaER1YStOTlRIamNRaHZvaWxGd3Y5RUhubEszdndi?=
 =?utf-8?B?QjBjejRuNElGQ3dLcnV3dXJFZFc4SnZQRGRrZnJzSnFzanppNFdyWXBpcGE5?=
 =?utf-8?B?QndtdUJoM0EySmJDZEJRUlNtWElIZWkwVlFVWjQ0Sm9JOGpBZFJJZXJzK1p2?=
 =?utf-8?B?S2tId3RMZkFjbWdXVldKdGErbllTSTNXdkxONGNucmVRZ2VhcXN1R3l1RXdB?=
 =?utf-8?B?cUp1RkpwbXd0eFFxTGtLOXg3bGNtc2d4NXEvdnlxbG0va0lBeVpHY3NPaGxk?=
 =?utf-8?B?KzZQMUJleEw2a2t1d21jb0hRVnFPNHg3Z2wwUHgrNm8rZTVDbVFuSkRTM3Az?=
 =?utf-8?B?Ti80SjVzdHc0Rk0xUVAzODJlbW9kb3JPckFBbE1NSmJYUTV0bUlMcW45RGQ3?=
 =?utf-8?B?YXVFMHZmL0FERlZOc3lEUWNveHpPd3ZIU3k2Tk4wb1lNOGtWakpHaGVoRjNa?=
 =?utf-8?B?ZVhJVkQ2SHcrUGFOU2RzbXVySlpWTjlqMFN0QWZ4cmUzL09sMjRYb0dOQ0xO?=
 =?utf-8?B?bUtUVG1Ybm54QnIrdmUrU1NtUHlhQTVvUng2WUF1K1gwUGx1VEd1MVdKLzJo?=
 =?utf-8?B?SHlYem82aWJQWXd4em5nM0NWb25IelFsb2Q0aUZUTzF1V3pzV2N0Qld5QU9p?=
 =?utf-8?B?YnVHYTJCblhpVzhpWXNLcnAwZUxEVVkyNmhwZlNWSC9XVGw4Ly9jTFdaZVFO?=
 =?utf-8?B?K0ZUblJpZittU2p0dzNLanNTVE9QTzVpbDN5RFhydzMzbTVHb0xCT2l2QUx6?=
 =?utf-8?B?R2h0TGJNT0JKMUhrb2c1ZWg3U2ZhaVU1bHJ5bHEzenpsWmZpZGJnUGY2WWow?=
 =?utf-8?B?cVZXSnplMjNmV1hWbExLL3pkODVTYWVmdkhmcXBSdDJmeWltL0RCYzFNR2xx?=
 =?utf-8?B?TFBOcGZ4SzZGVFZ6MDZuMkhoSGlweDBWN0NWVDgzYm1PWXc4enA2bHgyQ1JZ?=
 =?utf-8?B?U2lrUWZxYy90MExOdkNROEtlS1FuZUFVcEV1a1ZEeE94TlhqalczajhXNm9u?=
 =?utf-8?B?ekZLUnpXRFdsMnlLeUFXcXR4ZTJpYXhyNmdTRno4UXpjTVJKZ3ZTK3ZwN24w?=
 =?utf-8?Q?Rkm3J+fzFL04bWLpNVLmbSG9s?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <33E21474B57B1E4B944655B60CFB41CC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0SPRMB0086.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5a9a5a5-e2c1-4213-d696-08db73ffadc0
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2023 15:36:57.1556
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jv7QYYCqUK2xTXHnDYeTLlHtRhhgNqeSbYluvapo80JMUjHgQ+0TxuamST4Z/ukdEeJfP/03W7fSQr7lEw9WBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4709
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

SGksIFRob21hcywNCg0KT24gVGh1LCAyMDIzLTA2LTIyIGF0IDE2OjI3ICswMjAwLCBUaG9tYXMg
R2xlaXhuZXIgd3JvdGU6DQo+IE9uIEZyaSwgSnVuIDE2IDIwMjMgYXQgMTU6MTgsIEZlbmcgVGFu
ZyB3cm90ZToNCj4gPiBPbiBUaHUsIEp1biAxNSwgMjAyMyBhdCAxMToyMDoyMUFNICswMjAwLCBQ
ZXRlciBaaWpsc3RyYSB3cm90ZToNCj4gPiBZZXMuIFJ1aSBpcyB3b3JraW5nIG9uIGEgTUFEVCBi
YXNlZCBwYXJzaW5nIHdoaWNoIG1heSB0YWtlIGEgd2hpbGUNCj4gPiBiZWZvcmUgYmVpbmcgc3Rh
YmxlLCBnaXZlbiBhbGwga2luZHMgb2YgZmFuY3kgZmlybXdhcmUgb3V0IHRoZXJlLg0KPiANCj4g
UGxlYXNlIG5vdCB5ZXQgYW5vdGhlciBtYWQgdGFibGUgcGFyc2VyLg0KPiANCj4gVGhlIHRvcG9s
b2d5IGNhbiBiZSBldmFsdWF0ZWQgZHVyaW5nIGVhcmx5IGJvb3QgdmlhOg0KPiANCj4gwqAgMSkg
VGhlIEFQSUMgSURzIG9mIHRoZSBwb3NzaWJsZSBDUFVzLg0KPiANCj4gwqAgMikgQ1BVSUQgbGVh
ZiAweGIgb3IgMHgxZiB3aGVyZSB0aGUgdG9wbW9zdCBzdWJsZWFmIGdpdmVzIHRoZQ0KPiBudW1i
ZXINCj4gwqDCoMKgwqAgb2YgYml0cyB0byBzaGlmdCB0aGUgQVBJQyBJRCByaWdodCBmb3IgdGhl
IHBhY2thZ2Uvc29ja2V0DQo+IA0KZXhhY3RseSB0aGUgc2FtZSBpbiBteSBwcm9wb3NhbC4NCg0K
VGhlIGRpZmZlcmVuY2UgaXMgdGhhdCBJIGFsc28NCjEuIGdldCB0aGUgYml0c2hpZnQgb2YgdGhl
IGNvcmUgaWQgYW5kIGNvdW50IHRoZSBudW1iZXIgb2YgY29yZXMgaW4gYQ0KICAgcGFja2FnZS4N
CiAgIE9uIEludGVsIGh5YnJpZCBwbGF0Zm9ybXMsIHVzaW5nIG5yX3BhY2thZ2VfY3B1cyAvIG5y
X2NvcmVfY3B1cyB0bw0KICAgZ2V0IHRoZSBudW1iZXIgb2YgY29yZXMgaW4gYSBwYWNrYWdlICh4
ODZfbWF4X2NvcmVzKSBpcyBicm9rZW4uDQogICBlLmcuIGZvciBhIDZQY29yZSArIDhFY29yZSBz
eXN0ZW0sIHBhY2thZ2UgaGFzIDIwIENQVXMgYW5kIDE0IGNvcmVzLg0KMi4gZ2V0IHRoZSBtYXhp
bXVtIG51bWJlciBvZiBTTVQgc2libGluZ3MgaW4gZWFjaCBjb3JlIHRvIHNldCBjb3JyZWN0DQog
ICBzbXBfbnVtX3NpYmxpbmdzLg0KICAgT24gZnV0dXJlIGh5YnJpZCBwbGF0Zm9ybXMsIGl0IGlz
IHBvc3NpYmxlIHRoYXQgRWNvcmUgaXMgdXNlZA0KICAgYXMgYm9vdCBDUFUuIFRoaXMgY291bGQg
cmVzdWx0IGluIHNtcF9udW1fc2libGluZ3Mgc2V0IHRvIDEgZHVyaW5nwqANCiAgIGJvb3QgY3B1
IHN0YXJ0dXAsIGFuZCBjcHVfc210X2NvbnRyb2wgc2V0IHRvIENQVV9TTVRfTk9UX1NVUFBPUlRF
RC4NCg0KPiBUcnlpbmcgdG8gYWNjb21vZGF0ZSBmb3IgYW55dGhpbmcgZWxzZSB0aGFuIHRoZSBk
b2N1bWVudGVkDQo+IGVudW1lcmF0aW9uDQo+IGlzIGNyYXp5LiBJZiBmYW5jeSBmaXJtd2FyZSBp
cyBicm9rZW4gdGhlbiB0aGV5IGNhbiBrZWVwIHRoZSBwaWVjZXMuDQo+IA0KPiBTbyBzb21ldGhp
bmcgbGlrZSB0aGUgYmVsb3cgc2hvdWxkIGp1c3Qgd29yay4NCj4gDQo+IEkgZnVuZGFtZW50YWxs
eSBoYXRlIHRoZSBoYWNrZXJ5IGluIHRvcG9sb2d5LmMsIGJ1dCBjbGVhbmluZyB0aGlzDQo+IG1l
c3MNCj4gdXAgaXMgYSBjb21wbGV0ZWx5IGRpZmZlcmVudCBwcm9ibGVtIGFuZCBhbHJlYWR5IHdv
cmtlZCBvbi4NCj4gDQo+IFRoYW5rcywNCj4gDQo+IMKgwqDCoMKgwqDCoMKgIHRnbHgNCj4gLS0t
DQo+IC0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL2FwaWMuaA0KPiArKysgYi9hcmNoL3g4Ni9p
bmNsdWRlL2FzbS9hcGljLmgNCj4gQEAgLTUwOSw5ICs1MDksMTIgQEAgZXh0ZXJuIGludCBkZWZh
dWx0X2NoZWNrX3BoeXNfYXBpY2lkX3ByZQ0KPiDCoCNpZmRlZiBDT05GSUdfU01QDQo+IMKgYm9v
bCBhcGljX2lkX2lzX3ByaW1hcnlfdGhyZWFkKHVuc2lnbmVkIGludCBpZCk7DQo+IMKgdm9pZCBh
cGljX3NtdF91cGRhdGUodm9pZCk7DQo+ICtleHRlcm4gdW5zaWduZWQgaW50IGFwaWNfdG9fcGtn
X3NoaWZ0Ow0KPiArYm9vbCBsb2dpY2FsX3BhY2thZ2VzX3VwZGF0ZSh1MzIgYXBpY2lkKTsNCj4g
wqAjZWxzZQ0KPiDCoHN0YXRpYyBpbmxpbmUgYm9vbCBhcGljX2lkX2lzX3ByaW1hcnlfdGhyZWFk
KHVuc2lnbmVkIGludCBpZCkgew0KPiByZXR1cm4gZmFsc2U7IH0NCj4gwqBzdGF0aWMgaW5saW5l
IHZvaWQgYXBpY19zbXRfdXBkYXRlKHZvaWQpIHsgfQ0KPiArc3RhdGljIGlubGluZSBib29sIGxv
Z2ljYWxfcGFja2FnZXNfdXBkYXRlKHUzMiBhcGljaWQpIHsgcmV0dXJuDQo+IHRydWU7IH0NCj4g
wqAjZW5kaWYNCj4gwqANCj4gwqBzdHJ1Y3QgbXNpX21zZzsNCj4gLS0tIGEvYXJjaC94ODYva2Vy
bmVsL2FjcGkvYm9vdC5jDQo+ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9hY3BpL2Jvb3QuYw0KPiBA
QCAtMTc3LDYgKzE3Nyw5IEBAIHN0YXRpYyBpbnQgYWNwaV9yZWdpc3Rlcl9sYXBpYyhpbnQgaWQs
IHUNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gLUVJTlZBTDsNCj4g
wqDCoMKgwqDCoMKgwqDCoH0NCj4gwqANCj4gK8KgwqDCoMKgwqDCoMKgaWYgKCFsb2dpY2FsX3Bh
Y2thZ2VzX3VwZGF0ZShhY3BpaWQpKQ0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
cmV0dXJuIC1FSU5WQUw7DQo+ICsNCj4gwqDCoMKgwqDCoMKgwqDCoGlmICghZW5hYmxlZCkgew0K
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCsrZGlzYWJsZWRfY3B1czsNCj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gLUVJTlZBTDsNCj4gLS0tIGEvYXJj
aC94ODYva2VybmVsL2NwdS9hbWQuYw0KPiArKysgYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L2FtZC5j
DQo+IEBAIC02OTIsNiArNjkyLDggQEAgc3RhdGljIHZvaWQgZWFybHlfaW5pdF9hbWQoc3RydWN0
IGNwdWluZg0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoH0NCj4gwqDCoMKgwqDC
oMKgwqDCoH0NCj4gwqANCj4gK8KgwqDCoMKgwqDCoMKgZGV0ZWN0X2V4dGVuZGVkX3RvcG9sb2d5
X2Vhcmx5KGMpOw0KPiArDQo+IMKgwqDCoMKgwqDCoMKgwqBpZiAoY3B1X2hhcyhjLCBYODZfRkVB
VFVSRV9UT1BPRVhUKSkNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBzbXBfbnVt
X3NpYmxpbmdzID0gKChjcHVpZF9lYngoMHg4MDAwMDAxZSkgPj4gOCkgJg0KPiAweGZmKSArIDE7
DQo+IMKgfQ0KPiAtLS0gYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L3RvcG9sb2d5LmMNCj4gKysrIGIv
YXJjaC94ODYva2VybmVsL2NwdS90b3BvbG9neS5jDQo+IEBAIC0yOSw2ICsyOSw4IEBAIHVuc2ln
bmVkIGludCBfX21heF9kaWVfcGVyX3BhY2thZ2UgX19yZWENCj4gwqBFWFBPUlRfU1lNQk9MKF9f
bWF4X2RpZV9wZXJfcGFja2FnZSk7DQo+IMKgDQo+IMKgI2lmZGVmIENPTkZJR19TTVANCj4gK3Vu
c2lnbmVkIGludCBhcGljX3RvX3BrZ19zaGlmdCBfX3JvX2FmdGVyX2luaXQ7DQo+ICsNCj4gwqAv
Kg0KPiDCoCAqIENoZWNrIGlmIGdpdmVuIENQVUlEIGV4dGVuZGVkIHRvcG9sb2d5ICJsZWFmIiBp
cyBpbXBsZW1lbnRlZA0KPiDCoCAqLw0KPiBAQCAtNjYsNyArNjgsNyBAQCBpbnQgZGV0ZWN0X2V4
dGVuZGVkX3RvcG9sb2d5X2Vhcmx5KHN0cnVjDQo+IMKgew0KPiDCoCNpZmRlZiBDT05GSUdfU01Q
DQo+IMKgwqDCoMKgwqDCoMKgwqB1bnNpZ25lZCBpbnQgZWF4LCBlYngsIGVjeCwgZWR4Ow0KPiAt
wqDCoMKgwqDCoMKgwqBpbnQgbGVhZjsNCj4gK8KgwqDCoMKgwqDCoMKgaW50IGxlYWYsIHN1Ymxl
YWY7DQo+IMKgDQo+IMKgwqDCoMKgwqDCoMKgwqBsZWFmID0gZGV0ZWN0X2V4dGVuZGVkX3RvcG9s
b2d5X2xlYWYoYyk7DQo+IMKgwqDCoMKgwqDCoMKgwqBpZiAobGVhZiA8IDApDQo+IEBAIC04MCw2
ICs4MiwxNCBAQCBpbnQgZGV0ZWN0X2V4dGVuZGVkX3RvcG9sb2d5X2Vhcmx5KHN0cnVjDQo+IMKg
wqDCoMKgwqDCoMKgwqAgKi8NCj4gwqDCoMKgwqDCoMKgwqDCoGMtPmluaXRpYWxfYXBpY2lkID0g
ZWR4Ow0KPiDCoMKgwqDCoMKgwqDCoMKgc21wX251bV9zaWJsaW5ncyA9IG1heF90KGludCwgc21w
X251bV9zaWJsaW5ncywNCj4gTEVWRUxfTUFYX1NJQkxJTkdTKGVieCkpOw0KPiArDQo+ICvCoMKg
wqDCoMKgwqDCoGZvciAoc3VibGVhZiA9IDE7IHN1YmxlYWYgPCA4OyBzdWJsZWFmKyspIHsNCj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNwdWlkX2NvdW50KGxlYWYsIHN1YmxlYWYs
ICZlYXgsICZlYngsICZlY3gsICZlZHgpOw0KPiArDQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBpZiAoZWJ4ID09IDAgfHwgIUxFQUZCX1NVQlRZUEUoZWN4KSkNCg0KRG8gd2UgZXZl
ciBzZWUgZWJ4ID09IDAgZm9yIGEgdmFsaWQgc3VidHlwZT8NCldoZW4gZGVjb2RpbmcgQ1BVSUQu
MEIvMUYsIHdlIGNoZWNrIGZvciBpbnZhbGlkIHN1YnR5cGUgb25seS4NCg0KdGhhbmtzLA0KcnVp
DQo=
