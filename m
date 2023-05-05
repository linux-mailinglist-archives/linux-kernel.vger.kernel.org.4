Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 618D06F8AFF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 23:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233483AbjEEV2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 17:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232350AbjEEV2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 17:28:33 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5C5E6;
        Fri,  5 May 2023 14:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683322112; x=1714858112;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WSh3Z9iZO5pmVys07W0ljR6uPjNYRfTvfC90dlHD++o=;
  b=iKTvi1pXxUVRI1zCkVRldCKPn0zhEcwrvQFhqPXj1ye90AMKHVNmP2Y3
   U1RxNm3jEVxiu/HbA4SXT8RRU0vEN04K9g75tMkACEMWrgZyv4vSP2iGr
   L/sGUjQAcgTq6f056zjAx9KwyMQz36+dDuC0UlwBhbfOGAOICFC3r+n95
   vUEu2VZ+41XgFujf7cIvWFpdClyU8DVdjATGxQX6Ue2GtLbu8aQDELMz/
   n5LyqQ3Im6S84DCK7Xc+aP34vWXOJCNKHP2uYNTNMessvm2nbbNVIT60y
   5rOCUF5NZxvolmZVYFlCgDAsVrra1q6mwsOTdGdyhCVvc7sIEixBv5RT4
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="412542850"
X-IronPort-AV: E=Sophos;i="5.99,253,1677571200"; 
   d="scan'208";a="412542850"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2023 14:28:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="697748629"
X-IronPort-AV: E=Sophos;i="5.99,253,1677571200"; 
   d="scan'208";a="697748629"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP; 05 May 2023 14:28:31 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 5 May 2023 14:28:30 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 5 May 2023 14:28:30 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 5 May 2023 14:28:30 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 5 May 2023 14:28:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NPjuQHJPBCAsH0hQo13KyzyCaG3px1qGDJVYOGprosVSuny79X43alUsUOSfAQASeZ3jNPeTLdzb2ZhYiWr3y26ZD61IiPf8LFJiltfSqAcZ5i1RjexWfx8R8Y8ypAftFp1pLah5JNObZSP0cAX2/95+vd/EmScwzUUu0AJWuqXhqXWE4V/iKe9pArOkJQjudSjuGabFfjJKlYR1Le2KWR6DAKM6pskAnT8wx3wdvjgvldj7OdKVp62LxS1PqIsdlM53M09Z3QOXys4nmtcm5BkriLi55oMusCGB+IbNqsVygswHkxNiDwTHRr1DZGrFYEJHy2Vo1pSFaMDqDmwpsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ULbBSCJqj25nYj/0MkR6qvFEJZkso9B0Zo73oG6+718=;
 b=YIWNcToSI3Fr6PECdvYa5zbg6BOYfxv/2Dc7c8gCMmedk3pEpoqwhpbd69mAjoV3RmhSwWQbsvbL2uP0lh+aJEvjc5HLboh0AVBL+7f5npSCUFGLT3xqVVX4C9i5WfytPDl6dQzTZAPGr51FzVjNjI+4jw1tTYx8IT8V7wc4rNthtlagYGcwQMu0jRB5RFlxgiPACxxtlQjxcOdCfF8HBpfMzNJGhtTC7Axr6Ekp+/0lNFtqUJHG6/j9bnoz9OOQZaDhnZy6RkkQ7a0JJ0IaUfaMAXWimf7ULPqJL/L6n30dOT9Dxk6f9pUuGG0J+Qb9fe8vqedkHr4uNnIy55UEHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MW3PR11MB4715.namprd11.prod.outlook.com (2603:10b6:303:57::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Fri, 5 May
 2023 21:28:26 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d%6]) with mapi id 15.20.6363.022; Fri, 5 May 2023
 21:28:26 +0000
Message-ID: <8acebeed-8c0e-98ac-b7a3-5dd1680fafa3@intel.com>
Date:   Fri, 5 May 2023 14:28:23 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.1
Subject: Re: [PATCH v4 2/7] x86/resctrl: Remove unnecessary rftype flags
Content-Language: en-US
To:     "Moger, Babu" <Babu.Moger@amd.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>
CC:     "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "chang.seok.bae@intel.com" <chang.seok.bae@intel.com>,
        "pawan.kumar.gupta@linux.intel.com" 
        <pawan.kumar.gupta@linux.intel.com>,
        "jmattson@google.com" <jmattson@google.com>,
        "daniel.sneddon@linux.intel.com" <daniel.sneddon@linux.intel.com>,
        "Das1, Sandipan" <Sandipan.Das@amd.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bagasdotme@gmail.com" <bagasdotme@gmail.com>,
        "eranian@google.com" <eranian@google.com>,
        "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "quic_jiles@quicinc.com" <quic_jiles@quicinc.com>,
        "peternewman@google.com" <peternewman@google.com>
References: <168177435378.1758847.8317743523931859131.stgit@bmoger-ubuntu>
 <168177445556.1758847.5029687867896978170.stgit@bmoger-ubuntu>
 <4275aa91-5834-2c03-f455-f1d3d666fec7@intel.com>
 <MW3PR12MB4553E65A5D5DE6E27045766595729@MW3PR12MB4553.namprd12.prod.outlook.com>
 <efd45c71-2241-e0b8-e1c0-6fcc1e95b321@intel.com>
 <MW3PR12MB4553C5EF3818F6C54B8BF5B695729@MW3PR12MB4553.namprd12.prod.outlook.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <MW3PR12MB4553C5EF3818F6C54B8BF5B695729@MW3PR12MB4553.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0033.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::8) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MW3PR11MB4715:EE_
X-MS-Office365-Filtering-Correlation-Id: b73ee326-819a-4332-f3d3-08db4dafa9a6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f/pJ/jf1oP6Siytk+3JoHU1z1tqYNbXAF1Zbe/LyV6lDvVAzCDF8Be46gV4QLYGMLxdW/pUfpPrPtbDPWgDbzTvPtWd0fAnsCOdgRJnjr5NgkEBN9PvBFgV4m1ZaMdyaMk/wOA3kP1wfRt6AwgsUL76MVyScghPw0IHyZ3EsYQnrEwfTjjqNKB0lxTVK8FrVLLof9EX0L/KE4uO11SuT4sTJsJH9gQZDr6BbaEc6RyErGzlUIPOrhc/e7u777pUXya4I+4C/MHGiFJI7wjEuKVKDPMDErV8ToLRVYWu1OKIZZu0rtepQtjtVzr4CffN0PWW5FgNmIOWvUqo0u62U4SgVmIa3rHwkaoCGtKWdEWkARAguvePlxEi4KNXJiRrhNuScq+2/NJx+3ca5iXEsxv9tI6H4B+dqChMBaZtzBNsre9JnJPucVeAQ45mLZNyYGN86G57NgyutzBjgcf7vNZlMK20MA6y7njUklisxWWzzf789Et2wcxcm9ABF+ti89lKJIxJfQWHQxsm/LBKFGAL6TNsnco99zfdnfMPpL7tSGnJU3WtPbqyhGrfJiP7I2/QxmKKOLlfjPs/ORYl3lnClBpDNMmFPLWterPJjoEFMCULsRrOpoURYkxBXJOtnrHZnjrGOXbvje6iTbhIJhg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(396003)(136003)(376002)(366004)(451199021)(41300700001)(31686004)(2906002)(66946007)(44832011)(5660300002)(66476007)(4326008)(66556008)(316002)(8936002)(54906003)(8676002)(110136005)(7416002)(7406005)(478600001)(6666004)(6486002)(186003)(53546011)(26005)(6506007)(6512007)(83380400001)(36756003)(2616005)(38100700002)(82960400001)(86362001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUo3ajVVVFgzTkYreTBEcW9oMWRkWlRtcS9pUUY4azZCc1p6a29zQ1VObEdk?=
 =?utf-8?B?SzkxVVFaazJ2bTRkd014a0dCUmZHRktGNTgzLytIUkNzeUZRL1FxcC9waERP?=
 =?utf-8?B?SXhpN29neHlJenhuY3QvaWVEd1JHVG1QWHUzaTRaVXR3OFk0UFFWRjY3cTZk?=
 =?utf-8?B?YWJFUHRzTGdEbEdRdmtFYUQrR1dNMnR1WVIzLzlzV3hGN1o3bmJmbXVaaTBw?=
 =?utf-8?B?cDBmK0xESk9jWlUxa3RqT2ttT29RYXVJek5VT3gwc0lkRS85MlhTUVVlWlYz?=
 =?utf-8?B?QmpvT2RsL3BZL1ZlSXJqVDl5ckJ1NE5NNkNnV0x3TFN6TUNvb0tCS1J4V0kz?=
 =?utf-8?B?ZVQvb1FCZkd5L0dLc2hnaVJpWU9yMWxMU0FDdFJabzNOQWwwN3AzSG9DUWVI?=
 =?utf-8?B?Mi9UOEcrd2JDOVJiamlQR1pMWStOcW0xdkViNktiVkRZbDd3Ly8vdGJOTjJ0?=
 =?utf-8?B?czlQV3VhSzhOd1RnTlFoZWYzT3dHT1JXRXk0OEhSbWlwR1RDZGVVZTNaeEpF?=
 =?utf-8?B?ZGowaUxsQXFkUGFiYzdFcW1JM2pUUVJaRXdPWmtRZDhJdEEweUE4aXp0OFlt?=
 =?utf-8?B?b2tMcEFnWlRUMGpTeVFtUDNlczBCdWxGNnFxNmxqUXIzMm5TUm1UZVN1WWh6?=
 =?utf-8?B?VmhmNVJrM1ViUWlyU3pZb3hPM21OZzhkakFPV09zcWNKQzRlREhQeUxxUDh5?=
 =?utf-8?B?WFRrb2E0VUVwU0hNeElwSVJBSXdiU1I0NGdKTWhZcC9PYWZOcUtoSCsvZXF3?=
 =?utf-8?B?aGhqRVkvN0tvS3pFNDZHS0NVNWROVGp4WmliQ0tQS216dWVQWUxDaGJyYmlU?=
 =?utf-8?B?NzFGKzlKTjU2OHdYV0IvMEU3K1NNTTdicjZKUEhFWFhYcGk3SFJ2TkRCeEhW?=
 =?utf-8?B?c3hzS1NEdXJQY0lubXZKYTh0SnNEUFh6N3M4WStHSm55aVhsc1p4VW9OUHEx?=
 =?utf-8?B?Znhpd1BZSG8zN1VIZGdJRERaUndXZ09hU2o5TVBibG9SNjV2Ulo1dUYzWEZO?=
 =?utf-8?B?N2RQR01aa0o4VHVLTitEVlc2UmNoMVBTOFlIeU1qOVdjb3FScTkwQ1lXNUZB?=
 =?utf-8?B?bmRjZmJVbFRqWnlqWEY1cTJ2R1R2NUp2Sm81WXhxdC9PRHZFdmdkRWhXWlJQ?=
 =?utf-8?B?MkM3Zmx6dWptQ1EveWhwQmNDL3RySE0vTUJkZkJPNkxQL08vcmFoVVJQTjFy?=
 =?utf-8?B?WkhiU1daRHM1N3c5UlhEcE5oaFhpZUFxSytQZVIxNi9URlVVbVZMZW1vU0dw?=
 =?utf-8?B?bkg2MkY5K0I3a2xEN3JXSnl1SHJGQ2J0KzE0YUQ1WWk1Rmdzd1h4RWRCenJ1?=
 =?utf-8?B?WXJ3dzFpU3ljQXAwOHB3dXZWTTFMa1d3YndTYlp1cUNBNGdjVUdVOG5sMFVG?=
 =?utf-8?B?V2xTWVdETldRYW9VZEVzdm9SY2pRblh2eFVmM1Rwcm9IS1dZd3VRVFJZeUNI?=
 =?utf-8?B?Qy9LUmRTL2JabGlZQ01HeEtZWWZPUnMvYktVN0dHaDdUelUwc00xRnZCM0Zv?=
 =?utf-8?B?V0llaDdoY0lUWDh4ZUVkMVpkSE1aV1E4Q0N6ei80TGE2anp2bmhTL2o0Tndl?=
 =?utf-8?B?Z1dIMStTZVpFR1llRUJsdkR2VXlwMWM2SDlKSThKeFpVcllwSy9OMm9rV3Rn?=
 =?utf-8?B?NXlRditlU2NlWmFGdWVoZXlhdmd3TkNmWjJNVEwydlVOcVhva25FMW1OdEVB?=
 =?utf-8?B?akRjR2VNZ1IyTW14NmVNcmJWUXpQYVZBT0VnR21JWFFtb1RuRWw1WGFSSUJw?=
 =?utf-8?B?SU1YTWtSVVliUFI4SW96OHUyOGdoWW5BNTdyRzVMOThrb3RHOTlWQlFraHgz?=
 =?utf-8?B?dnhYa2srM05Tb096VHZ2V1dlWXBhTFJ0dFNCRmhxL2ZZR1M2TXpKRXZlUzBo?=
 =?utf-8?B?cTVBTVJJRklQQXA4b21DL1d2d0wxOHIrbm52VXpZdE92dWMvQUVWTm1lbmd2?=
 =?utf-8?B?L2txZGFSRGFQdHltUXNZT2dCbHFWdi8rRytHVWNyUmNRVk9yY0tZOSs0S0F6?=
 =?utf-8?B?ZXlHbE5wWDVVVWdIUXBNWGNEaXFIVllYRXdsWUlXWXJpMC82RU1qbGFHVXpn?=
 =?utf-8?B?UTJQSVVObGxhNE4xMXAxV2JDWGo0MHIyeGdoRUdVZERTeWgwTXhaRGdmbFUw?=
 =?utf-8?B?V3VqNSs1Q3JqYWc2UFYzU1B4VUJrTWNoU1FtdUdXWjgxUUVBeGJLcUdiQVM4?=
 =?utf-8?B?bWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b73ee326-819a-4332-f3d3-08db4dafa9a6
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 21:28:26.7112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DGz/RVt936K4Ux0igADSqjnIaziOuZDP7gsQS2SRCairLwgCPNblL26tPjtw/S0d3SMnTRr0SGqkTHR1gfIHFX0a4DQ0cb4y1cbBqqbOgZY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4715
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 5/5/2023 12:04 PM, Moger, Babu wrote:
> [AMD Official Use Only - General]
> 
> Hi Reinette,
> 
>> -----Original Message-----
>> From: Reinette Chatre <reinette.chatre@intel.com>
>> Sent: Friday, May 5, 2023 1:54 PM
>> To: Moger, Babu <Babu.Moger@amd.com>; corbet@lwn.net;
>> tglx@linutronix.de; mingo@redhat.com; bp@alien8.de
>> Cc: fenghua.yu@intel.com; dave.hansen@linux.intel.com; x86@kernel.org;
>> hpa@zytor.com; paulmck@kernel.org; akpm@linux-foundation.org;
>> quic_neeraju@quicinc.com; rdunlap@infradead.org;
>> damien.lemoal@opensource.wdc.com; songmuchun@bytedance.com;
>> peterz@infradead.org; jpoimboe@kernel.org; pbonzini@redhat.com;
>> chang.seok.bae@intel.com; pawan.kumar.gupta@linux.intel.com;
>> jmattson@google.com; daniel.sneddon@linux.intel.com; Das1, Sandipan
>> <Sandipan.Das@amd.com>; tony.luck@intel.com; james.morse@arm.com;
>> linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org;
>> bagasdotme@gmail.com; eranian@google.com; christophe.leroy@csgroup.eu;
>> jarkko@kernel.org; adrian.hunter@intel.com; quic_jiles@quicinc.com;
>> peternewman@google.com
>> Subject: Re: [PATCH v4 2/7] x86/resctrl: Remove unnecessary rftype flags

(is it possible to trim the headers in your replies?)

...

>>>> On 4/17/2023 4:34 PM, Babu Moger wrote:
>>>>> Remove unnecessary rftype flags to avoid multiple indirection.
>>>>
>>>> Could you please elaborate what makes these flags unnecessary?
>>>
>>> Yea. Probably should not say unnecessary.
>>> How about this ?
>>> "rftype flags have two prefixes, RFTYPE_ and RF_. Remove the flag names
>> with suffix RF_ and avoid indirection."
>>
>> I do not think that having a different prefix is a motivation for a flag to be
>> removed. Having a different prefix could rather be a motivation for a flag to be
>> renamed to a consistent name.
>>
>> Could you please describe the problem being solved?
> 
> Motivation for these changes.
> 1. Remove the naming inconsistency
> 2. Remove the indirection
> 3. Make it easier for adding new flags
> 

Could you please create a coherent changelog that follows the guidance
of the maintainer doc? Some details about why the indirection needs to be
removed and how this makes it easier to add new flags?

Reinette

