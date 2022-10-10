Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24B8D5F975D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 06:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbiJJEVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 00:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiJJEVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 00:21:48 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F5A12ACB
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 21:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665375707; x=1696911707;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0T+S0A/yS0oL60A5hq6u9qxmmyX1uwx2WkSrTzvQM40=;
  b=KCJUrxu5Srx88jhQDlvLasFXOpEgPnuysI9K/aVSmbYhkPgtZT3e/AIo
   yffZg4hw9zl0MQhrOGMv/WVacFjqOI5wruyj5sa/yjdmdehxUWlcTpOVx
   qtkE/aA9I+S69+8fCT2EU5tqpUJ7cFfGiPywZOpSH22GP04mLYQUsuNLA
   LkXKj2qwY5To6bGetR9FBSfYNheydtQBjvwMxaPKIXquQTt28N4+7brFk
   uBHTZHMdCcI6Mx7ESKSd7AmOOYyRvO4QNC7UcuGL4EbtlLmV31UA2N0q8
   UygJhAcktzR3eAD3UzY+bsW1RYfhyRLqTz9DZLSTrvGRWYFPggwRbaOIG
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10495"; a="305164059"
X-IronPort-AV: E=Sophos;i="5.95,172,1661842800"; 
   d="scan'208";a="305164059"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2022 21:21:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10495"; a="954775376"
X-IronPort-AV: E=Sophos;i="5.95,172,1661842800"; 
   d="scan'208";a="954775376"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga005.fm.intel.com with ESMTP; 09 Oct 2022 21:21:46 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 9 Oct 2022 21:21:46 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 9 Oct 2022 21:21:45 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Sun, 9 Oct 2022 21:21:45 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Sun, 9 Oct 2022 21:21:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CdmDEsQxHsLYwDKsJwrI3EBkY7410JvfCdyhZDNmzk70NkAq0hIH1nXt5ggfibGAh/LARvr1B3HlEx87A8T9pUB1mTqlH79J15jykWay7ePw8ZKSzabOU7f+TrXx+SG9fUYwz0IKrRCXzUAVllFMU64Yx3vlrTxriLapj6Hs5tPXi1w1YVMfFd2X2W62Ig8EV5JpX7HCMOlsOGW2Cn0JmCNglRROgsgSGNUcelMDI9QwrAHEf6Ydie97zXWw8fVlu39kjwg/Z7pkSe1n5D/GypTLNitn+1ET8ivdCw8p1nAqOpoRBWguW9/h8B+OX5e8YMLOTc3sVxL88Ek/0weF0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0T+S0A/yS0oL60A5hq6u9qxmmyX1uwx2WkSrTzvQM40=;
 b=KaD54Sx13Zs6Q5SYn2favrWvthVQUwC8qv14pElsz94bkZFe89m0ZHMgKEQ+AqdrgzAdO8S28RljKxmqWATF3WfzB5avxgB8DWCcOvUG0w5xZmz3ckgMKoyRSSw0LSRduLOXsUr7njSiuxqbH16ruVSDQ19Yr8yjp8c9hcq/dVBMOX8omI0IvGpkVdYanxZ3mn/CY1yVjkg1wyUbZVERVtrwDAuG5q4QiWtDIn9KrbaW/F8ygiA8u2xEUnw7AaLgyjkioiffCjzmxuDBMVKKG10cTMbCN3dDxaWuBc1NSJdI8VLCOnpxdd6ly+lLla/D/soryVzldt5444t0k15+CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN6PR1101MB2161.namprd11.prod.outlook.com
 (2603:10b6:405:52::15) by DS7PR11MB6063.namprd11.prod.outlook.com
 (2603:10b6:8:76::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Mon, 10 Oct
 2022 04:21:43 +0000
Received: from BN6PR1101MB2161.namprd11.prod.outlook.com
 ([fe80::348b:441f:ecda:baf5]) by BN6PR1101MB2161.namprd11.prod.outlook.com
 ([fe80::348b:441f:ecda:baf5%12]) with mapi id 15.20.5709.015; Mon, 10 Oct
 2022 04:21:43 +0000
From:   "Li, Xin3" <xin3.li@intel.com>
To:     "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: RE: [PATCH 6/6] x86/gsseg: use the LKGS instruction if available for
 load_gs_index()
Thread-Topic: [PATCH 6/6] x86/gsseg: use the LKGS instruction if available for
 load_gs_index()
Thread-Index: AQHY2Z1YsyE3enznIkOfLcepaehVE64DBB+AgAA15gCAABeEgIAACuQAgAAFu4CAAAKlgIAAlneAgAAdPQCAAvJUoA==
Date:   Mon, 10 Oct 2022 04:21:43 +0000
Message-ID: <BN6PR1101MB2161D08FCEE16C14A58EA850A8209@BN6PR1101MB2161.namprd11.prod.outlook.com>
References: <20221006154041.13001-1-xin3.li@intel.com>
 <20221006154041.13001-7-xin3.li@intel.com>
 <Y0A77RLAgXQyrVPq@hirez.programming.kicks-ass.net>
 <BN6PR1101MB21611798953AADA4DFD71719A85F9@BN6PR1101MB2161.namprd11.prod.outlook.com>
 <Y0B83cSSwJnRtGAn@hirez.programming.kicks-ass.net>
 <80AC2E90-D842-4EA2-A413-3CC5CFF088BC@zytor.com>
 <Y0CKz/wjvYYYgH3P@hirez.programming.kicks-ass.net>
 <b2943f49-41ba-59c9-2592-d1a91a151138@zytor.com>
 <BN6PR1101MB21617D356343204482EFD1F6A85E9@BN6PR1101MB2161.namprd11.prod.outlook.com>
 <F4064514-E927-4FBD-BE49-AA83E8453ACA@zytor.com>
In-Reply-To: <F4064514-E927-4FBD-BE49-AA83E8453ACA@zytor.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.500.17
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR1101MB2161:EE_|DS7PR11MB6063:EE_
x-ms-office365-filtering-correlation-id: 2a313f3f-516a-492f-0814-08daaa76efd5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /F+FquZ2Nt3Bh8/YgOIP/9AyyZQTe6HmsxvJVe1XwkKNQsOuZyPajcyTVj/7PAkONzDLQmkdvNEdzyZHKkXLcMnuR2bDVD6cckihQCAdWoWVDFaR44q/udNKQ3qUDbtG5iLTBYGF4rGTuDoPaiE1os/ccjfweYqvIXajOIcLeB6qEmFiJNY2PMYLogOJInzz/5F/LV0MHKID0ezvAEWZVXmpnsqucaNC67gdp3C1kyPkLLr1AnnwQBp6bYW8q0HCnRbAtFAlGhBRll1ZAkB3JNK+tV6ZjBnQHylxGXj3B37Kxk1qsIkijJ+eZ1ZsVs6nnujam6CDapyh5RqJLRcj0/441eP1zw8DZSM4QA+EdG/RHsDWiHVGRv/zwnbo5SwXIxz1uNlB8UlEDXO96l+VtJKYXmcsxuyg8ZXpHqG0xJwbg9UQ0d6Zvx5lmWHY/fV2/7gO4nlnFtvBBemrWgKkSLThTqeiFv+KL1m91T23xjH+jiYloje+TEvcStG/gt3GRneY4vcDYwBtKj0pKuwM0eFX8fG5wl48tGhmPXlVZ926cfU13OAcbxrYlTgw++y+mCjyvkMqsa/SItnEAp1nPYeswy4EUDb3DoJ9OuyLxGD2iu18kNJRcPu+Upplr2fS4F68qOfsxj/N0D8wnPCU+Jhr0Rgt4eff/d1oUWSiMGkIyXA8yZTZJbs8xGP8mdFSHQ9k2LFnBam0gGoVvzplHPaVCAguANA8yEFTdc4uV4UX2TR72kpk9005Unn6xsarf8PvN6RZFe/Qdp5PSHhV4g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR1101MB2161.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(136003)(39860400002)(366004)(376002)(451199015)(6506007)(52536014)(122000001)(8936002)(26005)(9686003)(5660300002)(4744005)(41300700001)(55016003)(86362001)(8676002)(4326008)(64756008)(66556008)(66946007)(33656002)(76116006)(54906003)(7696005)(186003)(478600001)(66476007)(316002)(66446008)(110136005)(83380400001)(71200400001)(82960400001)(38100700002)(2906002)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NTNyajFHczFYcG1iTmhhYy9kWnlsYUVscnU5c3FNT3JZL1hONlI5dTVKbzFV?=
 =?utf-8?B?cnhYaUdNc1QyQzNVSk9FVWFKMkZ1VEVwQ3ZpTk1EREx1OFVTUW5nNnZzbmV2?=
 =?utf-8?B?YmJaWXdtY0pqMDJmOU0vdnllQnU3MStIMUZpUEF5SUs2SGsybkFsOC94VmFO?=
 =?utf-8?B?cStndW9YdHVlNUFYdnhlSFVreWVKZWIwaEI0S0U4UFFmdk9seWNaN1ZBOTA1?=
 =?utf-8?B?cW9JcTJINWdrY2I1UW53bzBodVQ5T3B3cU5IMGpJUUZseHYxSnpUZmRYcnVX?=
 =?utf-8?B?YlhLakJQaGdLZUt6c3NBeWcxNVFqdS9wOE1mM0RHYlBaMTB5TEtraThyYW5S?=
 =?utf-8?B?TzlSSjBKTEdTM3JCdGNlNTN3WVRPNSsyRXorTC9NREpseU9VaWVvRy9VRHpJ?=
 =?utf-8?B?SjMzK3NQMnRQNEdBZ1hjb2twNnludDV1MVUvSXNXZ1VLM3pVeW5KNlRNd1pT?=
 =?utf-8?B?NjhiRU1hSVk4NXlKdW9rbm9ya2R2RE0rMUlSeFUzQTUwQkZoQ0VoQXJBZVFE?=
 =?utf-8?B?UElzMGdKa3UrME1ldktEeXluR1FhUHlSVGRUcVQ4djZiMVd0SGp4TnhtcFc1?=
 =?utf-8?B?ODlxYm84RWp6czN1OTl2TFhsYW5QM0xaaTZ0VzJCMVNGc1JyYVlCYldOZ1dr?=
 =?utf-8?B?N3Q0K2RsN0d1Zmx5d090dzRnSTFNc2ZZcU9KZmxzMXZiNGY5SWx0Qmk4OEpT?=
 =?utf-8?B?THZEVVVlRWQ1VkdLRmNDZW1RcjdBMUU2WlUzOXFEa1FjQmdrdlZydE5rY2FU?=
 =?utf-8?B?cXVQRE5JTzRCYXVjYlptM0hrTDhXa2U3ekI0bHRkMTlLRS8xUXh6WmpHbS96?=
 =?utf-8?B?djh4WUtBa25VTTFOaUJGNmIvb3JENlFlbWRDVTFxandWZU9FT0dpOFZZZnJB?=
 =?utf-8?B?NnltSmt2N2llek1YVEc0S3Vaa2tyei9YMzBkTUZPa1ZXQ0xnNG9wTU0zZ1pC?=
 =?utf-8?B?M25uSnZNR1JwTlhkYzhwRytnUzJkTVI0cFAwbGFkZ1o3d2RQOXJMYnRxUmRm?=
 =?utf-8?B?NTFSMFRMLzRSaHpSQkZEWlhNWVFDeHZvVUxXZElWQ3dGdU9CdVh1OEVSZGtr?=
 =?utf-8?B?ck1wYVR5VlAzYncxdTJtdGFNWWtJeXNuRFNENXdtUDJzUndhM0Z4L1B6azMy?=
 =?utf-8?B?aTFYZ3g1QkxDaVQ4WURLUC9VZUs2dzNwOXFhVE15TWcrZURRSnFqVm1lVzdq?=
 =?utf-8?B?cDhCcWFPY3EyTDhjbFdCY2RaOHJhOXY2ZHpob25ONmJRVEg3ZXI0cVNnWTBv?=
 =?utf-8?B?NW5kL0d0U3cxdDBxYUp0TXpzcldzakFmL05VejF5VnR0cE4rNURSSHNBeGFi?=
 =?utf-8?B?MGFQSElkU3NCWFZyTk9YQkRudlROKzVnZWdBL1MxMG8wampybnJXdUtYZFc1?=
 =?utf-8?B?ZzdxU2dFSTIyUDhZS1pPN2dwM3Jxa3pSZEhTSFJ6dy9kVDEyZTRrSEx3Y2lm?=
 =?utf-8?B?M2p3TitOdVAzcG1wK0loMnhEaEwzejljK2VaaU54S3h3OUNRbHV0dVJKeWxW?=
 =?utf-8?B?RzdkRHB6ZlhsVzJzTHdSNXIwd2g0YzhVbU82dG50bDR1eVhFVFp2Y29kZm9H?=
 =?utf-8?B?TnBqQ2NhQ003WFFUZ0ovMnA0bk53QkVxZ1JremtwUGZWU3RkZ1ZBYTJXMlIx?=
 =?utf-8?B?OGxPUFZKUHY1SHRtY3RjemZxQmhJUDgvSXNCcS8xWGNNMVBwdHNXYzB2bVVV?=
 =?utf-8?B?TkttSy9ISS9hRy96eDgyMlR5RFI2UWlOMVM0bGJDRmJ2MTZTSGVJNGVGQjZV?=
 =?utf-8?B?NURkdXFiTXBtQ0g5WWRCUEIybHhKQmFZNkdaUllXZTFrRG5ZdkFJT1lpZFd4?=
 =?utf-8?B?anV6bWNoVzhmTyswRVZjUXdZVXg2YjRNd1JKMHBmSWZWR1BJbFhHKzlDZzBN?=
 =?utf-8?B?azdScmEyNWVwajkyeDdkczU5V2plaXgxZ2hDUXdBVUhydHNvaXd5alBmR3Zq?=
 =?utf-8?B?NUZZK0YyMEhHNTUzTkVsNEFYWGZSL3RRUUwxeDdwMG5ZM2U4allYYkJpbmNr?=
 =?utf-8?B?dDgycVV4SFVJcmhBNlZZdDhFTCtFRmlJOGE4eTJ1R2Nza0daakVGeWsrSFZy?=
 =?utf-8?B?dE54UzUwSXA0Nm1WY0lYMEFkbHBFSzJDYUx5dUlYbXlMM3VFS0p6WjBWTGEy?=
 =?utf-8?Q?Em20=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR1101MB2161.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a313f3f-516a-492f-0814-08daaa76efd5
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2022 04:21:43.2768
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZMcunvjPZss+7cLnqzXRVXYJZ+fETP6bUBGgvOP0XooGWBiI69QNJzqoVN+Wbq8HaPTIb2DdCJ+CfF3fvvbxiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6063
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

PiBPbiBPY3RvYmVyIDcsIDIwMjIgMTA6MzI6MzEgUE0gUERULCAiTGksIFhpbjMiIDx4aW4zLmxp
QGludGVsLmNvbT4gd3JvdGU6DQo+ID4+ID4gQW5kcmV3IENvb3BlciBzdWdnZXN0ZWQgdXBncmFk
aW5nIHRoZSBvcnBoYW4gc2VjdGlvbiB3YXJuaW5nIHRvIGENCj4gPj4gPiBoYXJkIGxpbmsgZXJy
b3IsIG9ycGhhbiBzZWN0aW9ucyBhcmUgYmFkIHJlZ2FyZGxlc3MuDQo+ID4+ID4NCj4gPj4NCj4g
Pj4gQWdyZWVkIDEwMDAlLiBUaGlzIGlzIGEgbm8tYnJhaW5lci4gRnJvbSBJUkM6DQo+ID4+DQo+
ID4+DQo+ID4+IDxhbmR5aGhwPiAtTERGTEFHU192bWxpbnV4ICs9IC0tb3JwaGFuLWhhbmRsaW5n
PXdhcm4gPGFuZHloaHA+DQo+ID4+ICtMREZMQUdTX3ZtbGludXggKz0gLS1vcnBoYW4taGFuZGxp
bmc9ZXJyb3INCj4gPg0KPiA+V2hvIGlzIGdvaW5nIHRvIG1ha2UgdGhlIGNoYW5nZT8NCj4gPg0K
PiANCj4gV2h5IGRvbid0IHlvdT8NCg0KV2lsbCBkby4NClhpbg0K
