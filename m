Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BDE367DD17
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 06:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbjA0FZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 00:25:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjA0FY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 00:24:59 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340131BAED;
        Thu, 26 Jan 2023 21:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674797098; x=1706333098;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=77jChTDg3uPL/hvngJy3X5VWB+j/6ciUyGX5ukBruV8=;
  b=JkbQPZ37MgMPAEs2RRzWsfHj7Z9OrsMTU5lALI6WZgRWt037FWy8rztG
   3Ks+mZ1m6vOkjmWojxRhIbk0qFQoEwJ5PFrY6WpzAKLkevHkPTzY/WpHL
   UICEVmBAxriG0AOweGBjZoOsSXFbv45BXhXpAzJ7KhwF0D0ai349GmCN8
   9VsKeiYHSuJpyH8daMeONnnye/ETxcEv12+MabX8pGlkwZGtdOhNHqBd7
   UhIU/kipnjF8xAjKk1OJ9QJfFte66ScKK7kR3krR0tlJiHFjyHZNJLRyd
   X3wVgWUQk+aVmOzW1J5G+Aw7pSMAfFIeG+6sK3MCzCv5Z+i2XGfg0J7h6
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="389396097"
X-IronPort-AV: E=Sophos;i="5.97,250,1669104000"; 
   d="scan'208";a="389396097"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 21:24:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="787112705"
X-IronPort-AV: E=Sophos;i="5.97,250,1669104000"; 
   d="scan'208";a="787112705"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga004.jf.intel.com with ESMTP; 26 Jan 2023 21:24:56 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 26 Jan 2023 21:24:56 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 26 Jan 2023 21:24:55 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 26 Jan 2023 21:24:55 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 26 Jan 2023 21:24:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=naxyXfpGQWlkZnYY1AhygDDzt4Fcy8RN6K9hBPK6GBd1GhDnx0HzolSnq9TyW0G2Orz2vaqhxZaP7IsgfsPYy7hz+ssv8kOEyyr4C4DbUrysjsA44t6VnMB1UontkkwXV1KrLoHwjy8BoZIiHprzE8yAnrDT7cEGRZuuk/UkPn16pA3sBJbvuybcfh/8J2D+7F3lqGCJJvqB44HJz2nmkkKKTf7G2998ztTk2n1dLR6MF6YHfOJhJ8MHReHFdDaZ7b5HpMZKLHVlPSWu1VKycVrSP528BwqpaLWUdIOuJJMGzyNpRS5Bd0ECER/CoJgcy88qa/Fa0fno9m8KWVB9/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=77jChTDg3uPL/hvngJy3X5VWB+j/6ciUyGX5ukBruV8=;
 b=MaWH2U4k+YN4SvqOA9GHXoWp2+1KX44L+ksO3b7CPlMxxTn4fpZqPp6f+hk6+4xX8KZiUbiWd2qws4N94d5fEfQ6X5uCYSEIVZ7VZIzB5zUOPx1Fyw39Ae+rVbj4Otz0v8blBg+VBp7sXRg6DePVXmIu0NBug+pyUu2t489hAI8o4OJNooEM1PkJridpPeAVd/wVnGwtSfdJZcA+PE9Zonsv+KB6FMJLOD1+ww7yjTO+73E1KgFRdA535kkKAlRtW4UWFasw8YPnvezB7CpCM5cW2Zr6eRaFr55Wn5zN0qrjhV+T2Ad6Fjg8yiYHSS1ROT3+4g1Rv44w2aWmI4Ksiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by DS7PR11MB7907.namprd11.prod.outlook.com (2603:10b6:8:ec::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Fri, 27 Jan
 2023 05:24:54 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::16c0:1ae3:13ee:c40e]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::16c0:1ae3:13ee:c40e%8]) with mapi id 15.20.5986.018; Fri, 27 Jan 2023
 05:24:54 +0000
From:   "Yu, Fenghua" <fenghua.yu@intel.com>
To:     "Luck, Tony" <tony.luck@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        Peter Newman <peternewman@google.com>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "x86@kernel.org" <x86@kernel.org>
CC:     Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: Re: [PATCH 3/7] x86/resctrl: Add a new node-scoped resource to
 rdt_resources_all[]
Thread-Topic: [PATCH 3/7] x86/resctrl: Add a new node-scoped resource to
 rdt_resources_all[]
Thread-Index: AQHZMbXlA1Use0JcAUCVct/GPJuaw66xNcCA
Date:   Fri, 27 Jan 2023 05:24:54 +0000
Message-ID: <IA1PR11MB6097400A3056553FCC8E193C9BCC9@IA1PR11MB6097.namprd11.prod.outlook.com>
References: <20230126184157.27626-1-tony.luck@intel.com>
 <20230126184157.27626-4-tony.luck@intel.com>
In-Reply-To: <20230126184157.27626-4-tony.luck@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-imapappendstamp: BL3PR11MB6484.namprd11.prod.outlook.com
 (15.20.6043.007)
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6097:EE_|DS7PR11MB7907:EE_
x-ms-office365-filtering-correlation-id: 4eab4a7e-55a4-4f17-2dc3-08db0026d261
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8GndVSFKCffbpY+/dPP4NkokEpvWUmR6YW0ZjucQMEm/RPxUeeucbc3YB/Q2oaXKe9zg+VuisRpbngHI0YcIJI2NpTYw7Oy9DTAYKZBAEpPW5jp5sWlvH0HBoUsjZqw/rjoLeIIVh9gzljbxqp4dfGLGsAyS2fDaMQLs3fP25I1ZtQkw/ZjCyD4spekP/6uwwEhmqwdD5ENk86YdecE3zCotO+V3qrBnlpYlH3/rdeej5ApMF61XCp3vA+fkhv62fvzv8a+BQ0B8OerR6RodcM0B/JXitwQzVgEQu27u4xtj1fGIZog82+KLKi8hfvqFgGMkvxlDuMt+kd8ztuqqNF0ZBOlb0gIjnIwyoAumO15ccYD44ZUThidhxLdfkTnmtrbO8UyghyevBZ0l0lztu+C2Xw3JEcu2i9vsZzZZn8AtQ9ejW8MbfBay34fLlI6Y0PeFIs1KHUeXK8RHotztpTeCGoy38oiFu1IfwGZddrxCcqNwBUZCvGi1NuHOR/PpTP/5ikBLjmpxci7gybr1lx42X8aFV/PBXafmZlK2pJHnujPLAgUvbJmjTPb1g3+i5OBlHLMAns3st1UCUHOb+yOSlqHQB8hCFpQMHnw8F6zbE5g1e1O2syWw7L6yQ9xEgQI/UWOFYs7U+6TddKdXHwS7I5BwvHUc91ZgCjIoDGdH989OZOLmmmhU8umXxETDkva3qc6x4s7FmcA1BG55BtAtYrDDG6ksxPJz74KMdEbQdvwR5LvbbyeFV+l4mVvp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(396003)(376002)(346002)(136003)(451199018)(26005)(122000001)(38100700002)(33656002)(83380400001)(82960400001)(5660300002)(55016003)(86362001)(7696005)(7416002)(41300700001)(53546011)(6506007)(4326008)(8936002)(52536014)(186003)(316002)(2906002)(66476007)(66556008)(64756008)(478600001)(54906003)(66446008)(71200400001)(8676002)(66946007)(110136005)(9686003)(38070700005)(76116006)(65966003)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Wi9IOVluRGVZLzR2T0NpcmR2ZS8raXM1QjlmSnloUlJya2JiZy94QzJlbU02?=
 =?utf-8?B?cXgvVkpjMnZOYnA0MmhBVk9mSXZQWGVQemdNbTJ3bFBBTEZDb0JieUxqUHBq?=
 =?utf-8?B?NGxjR1N1dzFGUFdjSEFucUVJVWsrN0VKZmFSbTlocFF4QW15S3dRL2daK2ZH?=
 =?utf-8?B?NWhpOEh1SVNiNXlhSGtCVmFIaW1Yb1BSYjBXdjJMY2lDT0dtZzZ6U0JZK0Vn?=
 =?utf-8?B?TTYvS2EyZ2xXUGNNR3VlYTVMUHVBNlFOK1dCMCsxblNncUNOdDNjV3pBSEt5?=
 =?utf-8?B?YTNUMGpwSitkU3NRa3pCc3FJU1R1c1ZuaC9pTWx6bkFtK01DM0hrTXVidlZy?=
 =?utf-8?B?UlMxMG5CbGdzeWM5OGhLcVRUSmhNNEx4YUc0aVVFck4vTTdwSDIyR1Y4bmFm?=
 =?utf-8?B?RUxoeVBXVWREcGltZ3p1RmRzUXpBRG9UVVFtTndtWkttQ2lwWmNEaXNkODFj?=
 =?utf-8?B?clUyZ0ZnQnAzSUNQaWZqNURLempjaG1sNEpEUGc4YUpsdkR3N3pQdWJMOE1a?=
 =?utf-8?B?KytVQ3Q1S3F1RVlhZmhWQ3plOHlOSWdtTndvanRieCt2Z1ZJVWlOV3NKVmJP?=
 =?utf-8?B?K0ZYd253NFVpd2hSdjJMMExUYnpuOVN5eC9lVmd5Vk1FVmhXNjRDR2ZGUzNw?=
 =?utf-8?B?c3ZlYlhVYWszWGtFb0o4NGJiWExJa0gvR3JOVk9pVERuUlM3Z3o2dHV5U0VF?=
 =?utf-8?B?ekRVMHh2blEwRUhjSWZmRUxKcVUzQjZQeHY4TGR6QWI2Uk5mZEVvNWszWlFR?=
 =?utf-8?B?Y0J0ek9MaDF0czBYVUtyckZrcFpyelEvS2EzVXMxU0FmU3psOGcyd3RKMWVo?=
 =?utf-8?B?V2R2KzZmbXhEY2ZEeTFRbTdpeVJoTFNsNU1ITmpSa3hlM3Eva3lrUzdVaUVB?=
 =?utf-8?B?NEQ1ZDdZK3ZUY0EwWVlpc1FNZGVOMnFJd2dNVmlVRmprd0RKZ2RXSWd2Z3hW?=
 =?utf-8?B?aG1QeVBpVWxUNXBvbTJQUXVlWDdhbjh3K1FyVWZYaFpab1BseE9YcmQxa2h4?=
 =?utf-8?B?NnFOby81WE00d2hwbitIU3FRNk5MN1VlRnFHczNyVFZKY2IxVnplRVRNMnV3?=
 =?utf-8?B?SWNCV2RmOGx6TmU0VTV2VCs3NkFDUmQ4UTdOUXh2VlA2M2lFM0NwVTlkQmg3?=
 =?utf-8?B?c3BSQjh5K3JpeVZZTEFhWlBvM0MvMExlNjNrUndIZnJONDV2ajhVdUhDRjJl?=
 =?utf-8?B?ejJ3SHBIUmRqeUJXdmxUejkxS21pOEN0NVNVUnB1U05qdFppbjVxQ2FHL1Zp?=
 =?utf-8?B?aVp5TXpCSWh1MERaZXN3UWJFSVdSQURjUzlNNFZEZTlGcjFNbmY4azFtanR6?=
 =?utf-8?B?Z3I5RDRXSWF0OVZSTHlkcTUrSUZ1ZW1GTlRLeGhRRkkveXIzRDh1NlJMbll5?=
 =?utf-8?B?cmNicGgyeUx0cnZocXhnTkxVTjMyYU1keVUwVXBwaEd3eTcyTjI2bG5SQnVy?=
 =?utf-8?B?WTVWMW1yNGErN2hBc0NCSjdkSXhqdlNpK2FpNmxacHU2VGk2YXE0VWlLb05k?=
 =?utf-8?B?RUxtTFhjQmJIekZqcWF2ODF1TnVtYldGb0pIYXJGZ0NyWVpzZjJpZER2YTY5?=
 =?utf-8?B?cEhDazF4L1I3MEVaUms4ZHd5TlFIYkJwc2ZvR1V5Y0M2UmJQZUszT3pqemhs?=
 =?utf-8?B?bjRJdHdoZnd6RjZkMkswSWg4MkRTSCtnRXVlRHdXQlF4NG5XR3FDZEpjZjl6?=
 =?utf-8?B?TklkbVA5NjIwRjE4cTJ1amk2QlNucldobE9Nd0ZmbC9FU1dKY0tYTm12THRE?=
 =?utf-8?B?NzkzVjVPQk4wNG1sOXh2NnhpMVQ2c29IWEorTklKV2loUExycTFucmh5Qk8r?=
 =?utf-8?B?N3VqR25TaTByVjErNG1yR20vQm1MRktvaE5hdnFOS0ozelN0aXN6b284VmM2?=
 =?utf-8?B?N2x0cTNrSU44d0EwTDRMWlFnU2hzQW5mRkd3TkhEYUFQMi9pR05FUklacUJM?=
 =?utf-8?B?KzJ4cHNXRDlsNUpBcjJPQUk2UUpHU1NtelVWWWpvaUt1RU92Nllyam9ncTJo?=
 =?utf-8?B?b1A0RWVnV1VlTkRVT3ZtV2dyV21oRFhodDdXQm9RT3JSeUNKaHZ6KzloTzZ3?=
 =?utf-8?B?TWZrNUp1alI4TDA3enhYaHMwUWQraFJZQzZqZFJ2VjdxWFNyeDNVZVhKbFgy?=
 =?utf-8?Q?HMgPCi5eH6k9Eyt1EPj8T/JdX?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <966347FDBAFE374BB12FC6984F5B093D@intel.onmicrosoft.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eab4a7e-55a4-4f17-2dc3-08db0026d261
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2023 05:24:54.0774
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bwGt5UuxoPye9mX+fEx3Dqp9OoacT1ce1gwh8HWdNx+jAkC+Pqu0vSdkLh9pVqsVK/TEmce0YI93dL+wmPDS9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7907
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFRvbnksDQoNCk9uIDEvMjYvMjMgMTA6NDEsIFRvbnkgTHVjayB3cm90ZToNCj4gQWRkIGEg
cGxhY2Vob2xkZXIgaW4gdGhlIGFycmF5IG9mIHN0cnVjdCByZHRfaHdfcmVzb3VyY2UgdG8gYmUg
dXNlZA0KPiBmb3IgZXZlbnQgbW9uaXRvcmluZyBvZiBzeXN0ZW1zIHdpdGggU3ViLU5VTUEgQ2x1
c3RlciBlbmFibGVkLg0KPiANCj4gVXBkYXRlIGdldF9kb21haW5faWQoKSB0byBoYW5kbGUgU0NP
UEVfTk9ERS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFRvbnkgTHVjayA8dG9ueS5sdWNrQGludGVs
LmNvbT4NCj4gLS0tDQo+ICAgYXJjaC94ODYva2VybmVsL2NwdS9yZXNjdHJsL2ludGVybmFsLmgg
fCAgMiArKw0KPiAgIGFyY2gveDg2L2tlcm5lbC9jcHUvcmVzY3RybC9jb3JlLmMgICAgIHwgMTIg
KysrKysrKysrKysrDQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL2NwdS9yZXNjdHJsL2ludGVybmFsLmggYi9h
cmNoL3g4Ni9rZXJuZWwvY3B1L3Jlc2N0cmwvaW50ZXJuYWwuaA0KPiBpbmRleCAxNWNlYTUxN2Vm
YWEuLjM5YTYyYmFiZDYwYiAxMDA2NDQNCj4gLS0tIGEvYXJjaC94ODYva2VybmVsL2NwdS9yZXNj
dHJsL2ludGVybmFsLmgNCj4gKysrIGIvYXJjaC94ODYva2VybmVsL2NwdS9yZXNjdHJsL2ludGVy
bmFsLmgNCj4gQEAgLTQwOSwxMiArNDA5LDE0IEBAIGVudW0gcmVzY3RybF9yZXNfbGV2ZWwgew0K
PiAgIAlSRFRfUkVTT1VSQ0VfTDMsDQo+ICAgCVJEVF9SRVNPVVJDRV9MMiwNCj4gICAJUkRUX1JF
U09VUkNFX01CQSwNCj4gKwlSRFRfUkVTT1VSQ0VfTk9ERSwNCj4gICANCj4gICAJLyogTXVzdCBi
ZSB0aGUgbGFzdCAqLw0KPiAgIAlSRFRfTlVNX1JFU09VUkNFUywNCj4gICB9Ow0KPiAgIA0KPiAg
IGVudW0gcmVzY3RybF9zY29wZSB7DQo+ICsJU0NPUEVfTk9ERSwNCj4gICAJU0NPUEVfTDJfQ0FD
SEUgPSAyLA0KPiAgIAlTQ09QRV9MM19DQUNIRSA9IDMNCj4gICB9Ow0KPiBkaWZmIC0tZ2l0IGEv
YXJjaC94ODYva2VybmVsL2NwdS9yZXNjdHJsL2NvcmUuYyBiL2FyY2gveDg2L2tlcm5lbC9jcHUv
cmVzY3RybC9jb3JlLmMNCj4gaW5kZXggNjkxNDIzMmFjZjg0Li4xOWJlNmZlNDJlZjMgMTAwNjQ0
DQo+IC0tLSBhL2FyY2gveDg2L2tlcm5lbC9jcHUvcmVzY3RybC9jb3JlLmMNCj4gKysrIGIvYXJj
aC94ODYva2VybmVsL2NwdS9yZXNjdHJsL2NvcmUuYw0KPiBAQCAtMTAwLDYgKzEwMCwxNiBAQCBz
dHJ1Y3QgcmR0X2h3X3Jlc291cmNlIHJkdF9yZXNvdXJjZXNfYWxsW10gPSB7DQo+ICAgCQkJLmZm
bGFncwkJCT0gUkZUWVBFX1JFU19NQiwNCj4gICAJCX0sDQo+ICAgCX0sDQo+ICsJW1JEVF9SRVNP
VVJDRV9OT0RFXSA9DQo+ICsJew0KPiArCQkucl9yZXNjdHJsID0gew0KPiArCQkJLnJpZAkJCT0g
UkRUX1JFU09VUkNFX05PREUsDQo+ICsJCQkubmFtZQkJCT0gIkwzIiwNCiJMMyIgd2FzIG5hbWVk
IGFzIFJEVF9SRVNPVVJDRV9MMyBhbHJlYWR5LiBUaGUgZHVwbGljYXRlIG5hbWUgaGVyZSBtYXkN
CmNhdXNlIGR1cGxpY2F0ZSBmaWxlIG5hbWVzIGluIGluZm8gZGlyLiBNYXliZSByZW5hbWUgaXQg
YXMgIkwzX05PREUiPw0KDQo+ICsJCQkuc2NvcGUJCQk9IFNDT1BFX05PREUsDQo+ICsJCQkuZG9t
YWlucwkJPSBkb21haW5faW5pdChSRFRfUkVTT1VSQ0VfTk9ERSksDQo+ICsJCQkuZmZsYWdzCQkJ
PSBSRlRZUEVfUkVTX01CLA0KDQpJJ20gbm90IHN1cmUgaWYgZmZsYWdzIGlzIFJGVFlQRV9SRVNf
TUIgfCBSRlRZUEVfUkVTX0wzIGZvciBib3RoIGNhY2hlDQphbmQgTUI/DQoNCj4gKwkJfSwNCj4g
Kwl9LA0KPiAgIH07DQo+ICAgDQo+ICAgLyoNCj4gQEAgLTQ2NCw2ICs0NzQsOCBAQCBzdGF0aWMg
aW50IGFyY2hfZG9tYWluX21ibV9hbGxvYyh1MzIgbnVtX3JtaWQsIHN0cnVjdCByZHRfaHdfZG9t
YWluICpod19kb20pDQo+ICAgDQo+ICAgc3RhdGljIGludCBnZXRfZG9tYWluX2lkKGludCBjcHUs
IGVudW0gcmVzY3RybF9zY29wZSBzY29wZSkNCj4gICB7DQo+ICsJaWYgKHNjb3BlID09IFNDT1BF
X05PREUpDQo+ICsJCXJldHVybiBjcHVfdG9fbm9kZShjcHUpOw0KPiAgIAlyZXR1cm4gZ2V0X2Nw
dV9jYWNoZWluZm9faWQoY3B1LCBzY29wZSk7DQo+ICAgfQ0KPiAgIA0KDQpUaGFua3MuDQoNCi1G
ZW5naHVhDQo=
