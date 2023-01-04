Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D74765CCC1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 07:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232969AbjADGGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 01:06:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjADGGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 01:06:38 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29BF0DF90;
        Tue,  3 Jan 2023 22:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672812397; x=1704348397;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=p+niLxIGrA/upJnHhlGNGzIItjHu/lcQnxYYIVhh1Yc=;
  b=ZZQpQ5JtETdg0wxZwyLoMvAKhxUE789ExduJzB64pfRLzz6X/PNTcml/
   Pyk7u/qxpJAdaatxRahpe2GiIlYAFYTvF26nFSyIGJiClB3/r4pj0TXX3
   O5jToCKhxHktmRxiPDghnMJiJ8o5Vk/ncReUom4hwCINqoEYYnLBdSr+k
   dlNq/V4pRgY4wdxx5xYcTg2S1Ya3UAjFIlZGH/zK6leySnyyE4uCIu1gS
   Oz3nFsgNIWcnihJJoDccNiR4IFORtLbJT9FbzOj9wjxBJSW/BF1FfQA2c
   Y6nwu73CJOTIi/I5MEULFxNf4iPJDwCg/4bbPy8pD+tI3gkmsEJxI+CXV
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="309611112"
X-IronPort-AV: E=Sophos;i="5.96,299,1665471600"; 
   d="scan'208";a="309611112"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 22:06:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="657010275"
X-IronPort-AV: E=Sophos;i="5.96,299,1665471600"; 
   d="scan'208";a="657010275"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP; 03 Jan 2023 22:06:35 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 3 Jan 2023 22:06:35 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 3 Jan 2023 22:06:34 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 3 Jan 2023 22:06:34 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 3 Jan 2023 22:06:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aoVsRvR1f1mRDqDHEUMqUc48kbvzrZEeQD68XOzFeeWiLzubNOKQFE+rx33GuU2iiF9XQf3T8BVFshV1doeZBTq0IHNMdWxszfA3WxKWoQv/zh0Ci1xHPhvd4N/4f3xYtyWmQLyKXqVK+f5ZCUMNNyTLeruvH7m+WH01CJnjOHLO7MTeoNnZiC6EytcEYfCNb/CmolAYqrXDQEoE9sjw0t1Gzx/5e7fKjH0a5YykI2b7dKXWoD7/aY2gMTEfgmf+lBwmaWiS45DIMfYdF+netEo8ZwUgFPTIn1vblIfIlIe4jkY3lkaOSi4yC2tzIgQRQcGcBCtDkiTsOfI7HMoeGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p+niLxIGrA/upJnHhlGNGzIItjHu/lcQnxYYIVhh1Yc=;
 b=FKwKNH2F/qVqNiIrVmBkPVvyth4TCuaPig88TOLiv6M531/PC6GUAKrE06zed+uJhJjn7QvgXajdRjGI9Hg+mdg3SmjU/eCt9MVYfd3TocBfHru9Aa7LdahJENqpkjiI68R3LaqMRou7ir85IvWZ6+i6/29ZJbJeENgHpKzCXMfBnjlotYuVQ+me9PMFdwuslqckWHowbdvYRxTcz3lr8zc+Zhm3D8txYCxN+J2soVsQQlTX/+JM+tpW7iYrdyY2QkXRW6wE119cuhY2bWcUbaR7ZYyuNb/DvqXPqZbJlAHbRpYWsnB1uqXidz81RCwdFiHry16ymKUy0esP5R1Stg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by IA1PR11MB6347.namprd11.prod.outlook.com (2603:10b6:208:388::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 06:06:31 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::16c0:1ae3:13ee:c40e]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::16c0:1ae3:13ee:c40e%3]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 06:06:31 +0000
From:   "Yu, Fenghua" <fenghua.yu@intel.com>
To:     Babu Moger <babu.moger@amd.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Eranian, Stephane" <eranian@google.com>,
        "peternewman@google.com" <peternewman@google.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>
Subject: RE: [RFC PATCH 3/3] x86/resctrl: Display the RMID and COSID for
 resctrl groups
Thread-Topic: [RFC PATCH 3/3] x86/resctrl: Display the RMID and COSID for
 resctrl groups
Thread-Index: AQHZH7+/qLDsouKKjkeb4gWNzeXER66NxN5A
Date:   Wed, 4 Jan 2023 06:06:31 +0000
Message-ID: <IA1PR11MB609764AC3E09E0A1F8A8FF7E9BF59@IA1PR11MB6097.namprd11.prod.outlook.com>
References: <167278351577.34228.12803395505584557101.stgit@bmoger-ubuntu>
 <167278361325.34228.16916982678071203069.stgit@bmoger-ubuntu>
In-Reply-To: <167278361325.34228.16916982678071203069.stgit@bmoger-ubuntu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6097:EE_|IA1PR11MB6347:EE_
x-ms-office365-filtering-correlation-id: 6a45d99d-7118-4012-621e-08daee19d333
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tMNzGq2mzuS1xSAO0iZoVqm6h6A0NyUnLahdf5hPFQWy43qFtjreOc0kphf2LuGChsu8ORmauk5u5iJwq26z6baIBp1fKS9RammqzmnBL1SiQiyynbibFbnXs7adYI3zpOkiJwVH1N02PD7kJK41+nUneTg8v3tMv3f+M+VnY16N1M4qd2OkhVKEdd7w9Mj+SqX+0dVFDC3El/qbVT+TsUihFmski5SxqRWYESeTw6v4vtLKQskFR1cvKY8DPber1weyWJNuz8J5t/Pbi8HETxtX3Ft8nJll2kYylojFgI4rkYj9DO1Gq5QgchdQb+85kfUKd9v5PiGmFcYRnTfs1/8dkFVl6Vj/fw8tah5wl/eacb9LGcuTwMcoXgQ1y7yS2MlBIRSUDt3LvWe5csI+HFv81ehl/SFtYAVNxwJSdREMIoTkBnFd2SqBPHiXUu6hpgM0dbqyRuSSXFrDlDjrOtj7nYkFVrfaKUfR4cv4iUOKIpS9CXJhTWp/olqZgscJhFzraYlchceU63d+DK7UBqDfSR63q1uNE7LZWyl/0Fzj4RZyLHFyESfcJqsZL2fyeLUMaw9CogWSxpDtV2xS2r2qkoVCd00v1Qf3DXHObyqd5VQRypHOo68+3BaBuIZjdgAp87MCHENEgRv2eu2lZZK4RbNS912R7NUllepNNltyvh5U8epm/d7jmIPknm1tby4e1pbi5ELM2tiGN62tvQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(366004)(376002)(346002)(396003)(451199015)(7416002)(5660300002)(66946007)(76116006)(66476007)(66556008)(66446008)(64756008)(4326008)(316002)(110136005)(6636002)(2906002)(54906003)(52536014)(8936002)(71200400001)(122000001)(478600001)(26005)(186003)(9686003)(7696005)(6506007)(33656002)(8676002)(83380400001)(38070700005)(86362001)(55016003)(41300700001)(82960400001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UDJxZDFTMUUxNCtnODJlOHh5ZmE2QitYanljR3EyU1F1TFFqWXpBTUhJazQz?=
 =?utf-8?B?Z21mQlNneE1LdmpmVkRGWkx0MmRaNHg4bzN0ZmxRdGVZeE9OUy9VREVaNGto?=
 =?utf-8?B?NEVCQlJueUdWUHFEUmdPNmUzNnJBdjNZNjlFenpNZllTK0Z6VzNIK2VVSnVr?=
 =?utf-8?B?bzRmQTdnSFhFZmprNDBrUmpNcXVNZEZOMGNmVjVTSXkxS3B5bnJndldkMlpv?=
 =?utf-8?B?dGZnaXNRUFliOS9lQU8rZ21Ib2RrV3NFU3BnUFVwWnl4OHRvYVV6Ly9vc1ZD?=
 =?utf-8?B?U2pmT0U3d1lQdVJlQTFyMzk0Wkp0cnV6OUo4WnJzT2w0a0tuQ0poWStRZFZG?=
 =?utf-8?B?elJYNWlXUjM0L1RzVU84aXVjaDAvT293ZHFhMTUwNDBsaXJKRzBHVllLSldG?=
 =?utf-8?B?Mnd1SFZiK1gwV016MEFVSmtud0pzSS9VaHJuWnJSNUFwQ2tuMjZkQVRoZjJH?=
 =?utf-8?B?cjFrMzdHZEhjbE5WUVdWa2JZSTE2WEF6TVFyNzRJZnJBdVk2WHVPNlo2Zk9x?=
 =?utf-8?B?ZW80aUkrR01TbngyQ1Nkd3B3cm0vWW9DVUtqM2hkT0E0RnJidkVVeVFFbEky?=
 =?utf-8?B?TWQ1amYxUjAycURYQjVBWVRvYUtCQUxCdEd6dWFSbDdoSVBFdmt4TEJBaUxr?=
 =?utf-8?B?eExpaHJub0NYeHRBbUdQdEorWWdqNUVJdG56WlpBRjA0MHErTENkUFNtUzNh?=
 =?utf-8?B?bVMrWkFaR1IyQUtsSDRlam0raFZpQnA4UUhwREd2c0ZRRWl3UHhCSmZZeDB2?=
 =?utf-8?B?OHhrY3JTVkFUN2ZUdUFtN2J6TEhJdEZZUWo5cnFTejBWTUh6Rmx1TWV4SS9p?=
 =?utf-8?B?Ni8rTlMwclU4WS8zTWNqTnFydWlRaWZ6emJLQnhPaFZWTXg2Z2F1SEw5Zkd2?=
 =?utf-8?B?dnlLZzN6TlFYRU50bWNqb2c0QXYrRFFRMHlDKzRRV3dWSjFiVENEeXM5MDln?=
 =?utf-8?B?a1IvQ2oybHJqMnZuNXJUQVZwTWR5TDBIVVJab0tBdVZkT2Mzb21wMWVWWUlp?=
 =?utf-8?B?VkVyUm4raHZBdG5vVFQxOFhYTjRqcVFMYitpcEF3c0tGN0N2d1FtMVdUTW84?=
 =?utf-8?B?dURERTRVZDhQYWhXK0ZJZDNFZUg4Tk42MXdxSDB4eExQa1R2RzlHdUJVTjg5?=
 =?utf-8?B?TjZnNFBUaTVzV0dNUldhaWNjNE5HWUZ5UjdoRlVCdzgyMVdvU285VDF3d0JB?=
 =?utf-8?B?ZVI3WkMvWXZHa3hlWUw1Z1EyamJNMk9EYTdGNGEyT1l3Z0lHRk94M0tCSzJo?=
 =?utf-8?B?cFhsdFk3S1IrWmVWLzNuRjZvR2ltNnAwaitGZHBwcnhMdmVUYXh4WWlPL2NS?=
 =?utf-8?B?c1JoSjVwbTlmeTNQUkxya2tIZmI3WlY0VTZTQml2WVlzbks2Q2hEekJlc2kx?=
 =?utf-8?B?ZjVDeHZVemtBaDlWaDhZbjh1WERXV0ZKVUZmb3o5YUpQd2M4OVpMcklvS0t0?=
 =?utf-8?B?bkxaZ1Nhay9JNnQxM09LUGVxN1JQOGx2K1NxRHRnaDgyV2U2OW9BTFpXcjB1?=
 =?utf-8?B?K1RINVlQdTQ3SmlFQkY5OSsyZ0gzcDUrZWdtWWNMcW9NTnE4N2ZpZXpqSDBo?=
 =?utf-8?B?WUVzVkhpYUJOU1llS21vSjMrZU9UTmNaaFN3OWg1VjlaUzlCMTM4OXJ3dzZw?=
 =?utf-8?B?OUQ4cTQ3K0M4cDliM0dreWFBTzltRVFlNEhta29xWTJwdy9Oek9MWEQ1Mmgw?=
 =?utf-8?B?NCs4K0h6a0V6NUZHWkFHTml0R0IySEp4TVFMblhiNXpOck1lWWpjZjlxUmxK?=
 =?utf-8?B?cEpkbS9lbGpuaWFZNFo2U2FnVXI1SGtNUmtxNmMwSUZpZ0Y3MzVDVHRYNE9P?=
 =?utf-8?B?T05yV3JmLzBiRGZRVjl0dFpxM0pWaytjcnBiWVozZTZ2Z0FVSnFpQVkvdzdG?=
 =?utf-8?B?MlJXMnArdkFROW1jU2lMT1BkanlPWlNiYnNTYTBncGUyZmxWSTdzSnNXVjRO?=
 =?utf-8?B?NHdFREEyRWpBSnhuOVVsSHVZQTQ3bkV6Z0lORlloQzEzbzhXSDNlMEhqQ2ZX?=
 =?utf-8?B?bk9HWnRpUWpYVmRyd1ppelpMZVIzb0w3a0o3cDhaRTVEZGR0OHFHL3N5dUN3?=
 =?utf-8?B?YlFJYXhHdDk1WEZRSkxnZXlkdWloTnN1QmdUSkIyd0lISkFmd1dUbTRJV21R?=
 =?utf-8?Q?sAZlCUtcZWLhlAkn9xK2AtD+P?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a45d99d-7118-4012-621e-08daee19d333
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2023 06:06:31.0830
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 38p4vscWy+fjvWautml5LlVyb4fY+wtJ6ccPR+Y39JS8YPdxTu7hAg2F7JqBJ0ObBXAWAbQY9Idqoz9Twxf2qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6347
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

SGksIEJhYnUsDQoNCj4gV2hlbiBhIHVzZXIgY3JlYXRlcyBhIGNvbnRyb2wgb3IgbW9uaXRvciBn
cm91cCwgdGhlIENMT1NJRCBvciBSTUlEIGFyZSBub3QNCj4gdmlzaWJsZSB0byB0aGUgdXNlci4g
VGhlc2UgYXJlIGFyY2hpdGVjdHVyYWxseSBkZWZpbmVkIGVudGl0aWVzLg0KPiBUaGVyZSBpcyBu
byBoYXJtIGluIGRpc3BsYXlpbmcgdGhlc2UgaW4gcmVzY3RybCBncm91cHMuIFNvbWV0aW1lcyBp
dCBjYW4gaGVscCB0bw0KPiBkZWJ1ZyB0aGUgaXNzdWVzLg0KQWx0aG91Z2ggIm5vIGhhcm0iIHRv
IHNob3cgdGhlbSwgaXQncyBub3QgdXNlZnVsIGZvciBnZW5lcmljIHVzZXIgZWl0aGVyIGFuZCBt
YXkNCmNhdXNlIGNvbmZ1c2lvbiBzb21ldGltZXMuIENMT1NJRCBhbmQgUk1JRCBhcmUgc3VwcG9z
ZWQgdG8gYmUgaW52aXNpYmxlIHRvDQpnZW5lcmljIHVzZXJzLg0KDQpNYXliZSBpbnRyb2R1Y2Ug
YSBuZXcgcmVzY3RybCBtb3VudCBvcHRpb24gY2FsbGVkICJkZWJ1ZyIgYW5kIHNob3cgdGhlIGZp
bGVzDQphbmQgbWF5YmUgb3RoZXIgZnV0dXJlIGRlYnVnIGluZm8gb25seSBpbiBkZWJ1ZyBtb2Rl
Pw0KDQo+IA0KPiBBZGQgQ0xPU0lEIGFuZCBSTUlEIHRvIHRoZSBjb250cm9sL21vbml0b3IgZ3Jv
dXBzIGRpc3BsYXkgaW4gcmVzY3RybCBpbnRlcmZhY2UuDQo+IA0KPiAgICRjYXQgL3N5cy9mcy9y
ZXNjdHJsL2Nsb3MxL2Nsb3NpZA0KPiAgIDENCj4gICAkY2F0IC9zeXMvZnMvcmVzY3RybC9tb25f
Z3JvdXBzL21vbjEvcm1pZA0KPiAgIDMNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEJhYnUgTW9nZXIg
PGJhYnUubW9nZXJAYW1kLmNvbT4NCj4gLS0tDQo+ICBEb2N1bWVudGF0aW9uL3g4Ni9yZXNjdHJs
LnJzdCAgICAgICAgICB8ICAgMTUgKysrKysrKysrKw0KPiAgYXJjaC94ODYva2VybmVsL2NwdS9y
ZXNjdHJsL3JkdGdyb3VwLmMgfCAgIDQ2DQo+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDYxIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1n
aXQgYS9Eb2N1bWVudGF0aW9uL3g4Ni9yZXNjdHJsLnJzdCBiL0RvY3VtZW50YXRpb24veDg2L3Jl
c2N0cmwucnN0DQo+IGluZGV4IGYyNmUxNjQxMmJjYi4uODUyMDUxNGJjOGI1IDEwMDY0NA0KPiAt
LS0gYS9Eb2N1bWVudGF0aW9uL3g4Ni9yZXNjdHJsLnJzdA0KPiArKysgYi9Eb2N1bWVudGF0aW9u
L3g4Ni9yZXNjdHJsLnJzdA0KPiBAQCAtMjMxLDYgKzIzMSwxNCBAQCBBbGwgZ3JvdXBzIGNvbnRh
aW4gdGhlIGZvbGxvd2luZyBmaWxlczoNCj4gIAlKdXN0IGxpa2UgImNwdXMiLCBvbmx5IHVzaW5n
IHJhbmdlcyBvZiBDUFVzIGluc3RlYWQgb2YgYml0bWFza3MuDQo+IA0KPiANCj4gKyJybWlkIjoN
Cj4gKwlSZWFkaW5nIHRoaXMgZmlsZSBzaG93cyB0aGUgcmVzb3VyY2UgbW9uaXRvcmluZyBpZCAo
Uk1JRCkgZm9yDQo+ICsJbW9uaXRvcmluZyB0aGUgcmVzb3VyY2UgdXRpbGl6YXRpb24uIE1vbml0
b3JpbmcgaXMgcGVyZm9ybWVkIGJ5DQo+ICsJdGFnZ2luZyBlYWNoIGNvcmUob3IgdGhyZWFkKSBv
ciBwcm9jZXNzIHZpYSBhIFJlc291cmNlIE1vbml0b3JpbmcNCj4gKwlJRCAoUk1JRCkuIEtlcm5l
bCBhc3NpZ25zIGEgbmV3IFJNSUQgd2hlbiBhIGdyb3VwIGlzIGNyZWF0ZWQNCj4gKwlkZXBlbmRp
bmcgb24gdGhlIGF2YWlsYWJsZSBSTUlEcy4gTXVsdGlwbGUgY29yZXMob3IgdGhyZWFkcykgb3IN
Cj4gKwlwcm9jZXNzZXMgY2FuIHNoYXJlIGEgc2FtZSBSTUlEIGluIGEgcmVzY3RybCBkb21haW4u
DQo+ICsNCj4gIFdoZW4gY29udHJvbCBpcyBlbmFibGVkIGFsbCBDVFJMX01PTiBncm91cHMgd2ls
bCBhbHNvIGNvbnRhaW46DQo+IA0KPiAgInNjaGVtYXRhIjoNCj4gQEAgLTI1Miw2ICsyNjAsMTMg
QEAgV2hlbiBjb250cm9sIGlzIGVuYWJsZWQgYWxsIENUUkxfTU9OIGdyb3VwcyB3aWxsDQo+IGFs
c28gY29udGFpbjoNCj4gIAlmaWxlLiBPbiBzdWNjZXNzZnVsIHBzZXVkby1sb2NrZWQgcmVnaW9u
IGNyZWF0aW9uIHRoZSBtb2RlIHdpbGwNCj4gIAlhdXRvbWF0aWNhbGx5IGNoYW5nZSB0byAicHNl
dWRvLWxvY2tlZCIuDQo+IA0KPiArImNsb3NpZCI6DQo+ICsJUmVhZGluZyB0aGlzIGZpbGUgc2hv
d3MgdGhlIENsYXNzIG9mIFNlcnZpY2UgKENMT1MpIGlkIHdoaWNoIGFjdHMNCj4gKwlhcyBhIHJl
c291cmNlIGNvbnRyb2wgdGFnIG9uIHdoaWNoIHRoZSByZXNvdXJjZXMgY2FuIGJlIHRocm90dGxl
ZC4NCj4gKwlLZXJuZWwgYXNzaWducyBhIG5ldyBDTE9TSUQgYSBjb250cm9sIGdyb3VwIGlzIGNy
ZWF0ZWQgZGVwZW5kaW5nDQo+ICsJb24gdGhlIGF2YWlsYWJsZSBDTE9TSURzLiBNdWx0aXBsZSBj
b3JlcyhvciB0aHJlYWRzKSBvciBwcm9jZXNzZXMNCj4gKwljYW4gc2hhcmUgYSBzYW1lIENMT1NJ
RCBpbiBhIHJlc2N0cmwgZG9tYWluLg0KPiArDQo+ICBXaGVuIG1vbml0b3JpbmcgaXMgZW5hYmxl
ZCBhbGwgTU9OIGdyb3VwcyB3aWxsIGFsc28gY29udGFpbjoNCj4gDQo+ICAibW9uX2RhdGEiOg0K
PiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL2NwdS9yZXNjdHJsL3JkdGdyb3VwLmMNCj4g
Yi9hcmNoL3g4Ni9rZXJuZWwvY3B1L3Jlc2N0cmwvcmR0Z3JvdXAuYw0KPiBpbmRleCAwZDcxZWQy
MmNmYTkuLjk4YjQ3OThlNWNhZSAxMDA2NDQNCj4gLS0tIGEvYXJjaC94ODYva2VybmVsL2NwdS9y
ZXNjdHJsL3JkdGdyb3VwLmMNCj4gKysrIGIvYXJjaC94ODYva2VybmVsL2NwdS9yZXNjdHJsL3Jk
dGdyb3VwLmMNCj4gQEAgLTc2OSw2ICs3NjksMzggQEAgc3RhdGljIGludCByZHRncm91cF90YXNr
c19zaG93KHN0cnVjdCBrZXJuZnNfb3Blbl9maWxlDQo+ICpvZiwNCj4gIAlyZXR1cm4gcmV0Ow0K
PiAgfQ0KPiANCj4gK3N0YXRpYyBpbnQgcmR0Z3JvdXBfY2xvc2lkX3Nob3coc3RydWN0IGtlcm5m
c19vcGVuX2ZpbGUgKm9mLA0KPiArCQkJCXN0cnVjdCBzZXFfZmlsZSAqcywgdm9pZCAqdikNCj4g
K3sNCj4gKwlzdHJ1Y3QgcmR0Z3JvdXAgKnJkdGdycDsNCj4gKwlpbnQgcmV0ID0gMDsNCj4gKw0K
PiArCXJkdGdycCA9IHJkdGdyb3VwX2tuX2xvY2tfbGl2ZShvZi0+a24pOw0KPiArCWlmIChyZHRn
cnApDQo+ICsJCXNlcV9wcmludGYocywgIiV1XG4iLCByZHRncnAtPmNsb3NpZCk7DQo+ICsJZWxz
ZQ0KPiArCQlyZXQgPSAtRU5PRU5UOw0KPiArCXJkdGdyb3VwX2tuX3VubG9jayhvZi0+a24pOw0K
PiArDQo+ICsJcmV0dXJuIHJldDsNCj4gK30NCj4gKw0KPiArc3RhdGljIGludCByZHRncm91cF9y
bWlkX3Nob3coc3RydWN0IGtlcm5mc19vcGVuX2ZpbGUgKm9mLA0KPiArCQkJICAgICAgc3RydWN0
IHNlcV9maWxlICpzLCB2b2lkICp2KQ0KPiArew0KPiArCXN0cnVjdCByZHRncm91cCAqcmR0Z3Jw
Ow0KPiArCWludCByZXQgPSAwOw0KPiArDQo+ICsJcmR0Z3JwID0gcmR0Z3JvdXBfa25fbG9ja19s
aXZlKG9mLT5rbik7DQo+ICsJaWYgKHJkdGdycCkNCj4gKwkJc2VxX3ByaW50ZihzLCAiJXVcbiIs
IHJkdGdycC0+bW9uLnJtaWQpOw0KPiArCWVsc2UNCj4gKwkJcmV0ID0gLUVOT0VOVDsNCj4gKwly
ZHRncm91cF9rbl91bmxvY2sob2YtPmtuKTsNCj4gKw0KPiArCXJldHVybiByZXQ7DQo+ICt9DQo+
ICsNCj4gICNpZmRlZiBDT05GSUdfUFJPQ19DUFVfUkVTQ1RSTA0KPiANCj4gIC8qDQo+IEBAIC0x
NTkzLDYgKzE2MjUsMjAgQEAgc3RhdGljIHN0cnVjdCByZnR5cGUgcmVzX2NvbW1vbl9maWxlc1td
ID0gew0KPiAgCQkuc2VxX3Nob3cJPSByZHRncm91cF9zaXplX3Nob3csDQo+ICAJCS5mZmxhZ3MJ
CT0gUkZfQ1RSTF9CQVNFLA0KPiAgCX0sDQo+ICsJew0KPiArCQkubmFtZQkJPSAiY2xvc2lkIiwN
Cj4gKwkJLm1vZGUJCT0gMDQ0NCwNCj4gKwkJLmtmX29wcwkJPSAmcmR0Z3JvdXBfa2Zfc2luZ2xl
X29wcywNCj4gKwkJLnNlcV9zaG93CT0gcmR0Z3JvdXBfY2xvc2lkX3Nob3csDQo+ICsJCS5mZmxh
Z3MJCT0gUkZfQ1RSTF9CQVNFLA0KPiArCX0sDQo+ICsJew0KPiArCQkubmFtZQkJPSAicm1pZCIs
DQo+ICsJCS5tb2RlCQk9IDA0NDQsDQo+ICsJCS5rZl9vcHMJCT0gJnJkdGdyb3VwX2tmX3Npbmds
ZV9vcHMsDQo+ICsJCS5zZXFfc2hvdwk9IHJkdGdyb3VwX3JtaWRfc2hvdywNCj4gKwkJLmZmbGFn
cwkJPSBSRlRZUEVfQkFTRSwNCj4gKwl9LA0KPiANCj4gIH07DQo+IA0KPiANClRoYW5rcy4NCg0K
LUZlbmdodWENCg==
