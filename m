Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A46A6F88F9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 20:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233267AbjEESts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 14:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231852AbjEESto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 14:49:44 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE521D97E;
        Fri,  5 May 2023 11:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683312577; x=1714848577;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=p9qE7BNB0c3DJ3Mv1d9XBW7WBrE9FRIOSziMtwgHpRE=;
  b=Xxi2ghzD4i7d57OXXbPlLZGVPgM3GAMHD+fJs4ki/y2ENOQSfcPf0cBj
   Yc8jHXJUzlwI/IJb8FcbJjLq5v1EXL0Ot5rqiirVZcvyIFRTm68fQV36d
   m8EeMjRtyOFJeypSFhCxaYW5ziMF+MV7v45G1UckKXOkNoUjLlXU0mM3D
   dH+MKnjPlAJW0DUbSMoGYjHJlXLXkYqn5fiGLuw2u5avPlgIYhBwAniN+
   z14o33Ac8OH8ztaAAUCK+D3+axQQWMYl8fSOX+4iGAquZP+yGBG9Z7jRA
   /qK6AfizZ1q/dA3UqJ99r35GYLC3b8bzuW3IAc7RgQHJ7pv4QE+UchjDt
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="349317256"
X-IronPort-AV: E=Sophos;i="5.99,252,1677571200"; 
   d="scan'208";a="349317256"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2023 11:49:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="700560172"
X-IronPort-AV: E=Sophos;i="5.99,252,1677571200"; 
   d="scan'208";a="700560172"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP; 05 May 2023 11:49:36 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 5 May 2023 11:49:35 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 5 May 2023 11:49:35 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 5 May 2023 11:49:35 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 5 May 2023 11:49:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C0wY+mrptctEWys1GBGDqEXYmz064RiJIOM8B+oPYwpKuXSpORrbFFnFy4q2baHpEqoIgRGKkJlyl2idJ9dE0lndv3QScnGuKbGKvpclKNMojBTu3iodCVvuhD9WLSKLw/H/SUbudY2Gb2S7Tw8IvMM0e9navZuo2q2XjNFNS7hfW9hJ3d5G34vXrjuXyYb+IV27rkxGoVhQxuQC+riIncMm30MquQPT2a+FpRYwzTNqYOQiJdO4oQA/Ma87PQ5DiiUwDgECTbM3qczxqOSrdO0a/P/wXbFsrxP093Rhlqwq9o1SuHm+RXfJFbla+3IElMMVe4KQ0JdcNgOcri6VWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AwrNUualbRk/T5eNib0ATNbaLwzFoTYuW+Q9QtNNSco=;
 b=Tfo9VhatSUuvHf22yhYY1RGQN4RiWwNfY8Bs012D4uGlQ4h9Y0vu/Nwmah8FkG1HkOJXM4Cq19FQFaGCV76G+0DOjjmWioSdthyY62BikZNrasszirTXZexLZp2tJeUN2B2VbtqYBhjEGTf5NjWhH1foKNvKBU3Uzx6CvkBKQ4gSY+fTL7bT9fFB611BYylhx0FuoGvTXZKs37IjB7W1UzShlOFBe/kZpv/oJ99E4ZZ6b/10VGSW25gI85cLB0RvfGrZ36SOBm9yUXn69RaaBqj+s/x0HSFDiPJRKIGuuQlKWn7FaKpMAufnrk9W7YxwIgaPOzzC71VIZDFGXEalNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS0PR11MB6517.namprd11.prod.outlook.com (2603:10b6:8:d3::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.27; Fri, 5 May 2023 18:49:27 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d%6]) with mapi id 15.20.6363.022; Fri, 5 May 2023
 18:49:14 +0000
Message-ID: <6ae80709-cf44-43bd-d539-650f72dcd670@intel.com>
Date:   Fri, 5 May 2023 11:49:11 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.1
Subject: Re: [PATCH v4 1/7] x86/resctrl: Add multiple tasks to the resctrl
 group at once
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
 <168177444676.1758847.11474266921067437724.stgit@bmoger-ubuntu>
 <51a1b46e-9162-83bc-29df-8a154059f847@intel.com>
 <MW3PR12MB4553BAD1A9390D518D9919A895729@MW3PR12MB4553.namprd12.prod.outlook.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <MW3PR12MB4553BAD1A9390D518D9919A895729@MW3PR12MB4553.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0107.namprd03.prod.outlook.com
 (2603:10b6:a03:333::22) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS0PR11MB6517:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bbf45d9-3b09-4d51-a45d-08db4d996c53
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xbsVkOtGu0PtMGK1DBuq2GUBDCahCXcb77KASTid+mc6S5AYYZevg97FaL2AP31YDPLWp04h/LtW5P4Csedqz9uxktFCW3wI4INBjM4fZj3X5loQhhf/0VRBhf4k/eo0dEkW1TZ5nZpmpDiqFb0gteUWhkRFUGumDwUnPmIdV2vu1Hwc922oqVsYZv267VHmsA0qQ+ejN1JBEkwrKWZj0wgiL5efQ9Pj8tdOCTgIRDXEn/Oc0kHI9gm/t+Bh17z1LR368YdypeYibqOZepX+cbtIYTVV5u/vMAZHQh5WyDBrvbOHBzg4nzngr4gdCeocH7YvEoXPl6hnwleR35xECi/2NqhhZHcCb3zUpRlVmeCy6Zb2xOi+lzKUWoIPql+as/lR3QMXhEUjsQKZm0/sloU5UG2SNGETDg1g3Q7IDEpQNdoS4doQ+L7R8D4LykMAefm50vzJF455f4KzSsc+NPBnfnL4tGr3FKZIWKrZip7ja+aEQEZBQ8FPP8j7Ic8I2Wmp77pn9D/u4wk7/wgx//NRB3339NVmuFH8Nc+A9PwLFyjU4IC/RvQLjNiu1ObCfZk72srTqkHELBu1sP7ePXcpZRHnbTsc0ajjQ3+wP3TNw0Gfoh/HO89g8zOgAaBS7ootPTa/B3quEA1kIUV3Yw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(396003)(39860400002)(346002)(376002)(451199021)(6666004)(31696002)(86362001)(36756003)(478600001)(110136005)(54906003)(316002)(66946007)(66556008)(66476007)(4326008)(6486002)(7416002)(8676002)(8936002)(5660300002)(2906002)(7406005)(44832011)(41300700001)(186003)(38100700002)(82960400001)(2616005)(6506007)(53546011)(6512007)(26005)(83380400001)(66899021)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3JLckt6QW84cFMwRDdDMy85aWN4QThJRkx1STRmeUxEU1J1Z1hRMVRjYVg0?=
 =?utf-8?B?aFpHa0lQYW1ZR2ttSElBaUxrQWVoSENpcGFHbVlEKzV5Y3RXNWVwK3F0L3J2?=
 =?utf-8?B?UzZLeXlUNXBJK0ZFaWw1TTdac1RkTVJ4U1NkR3EyK2J5N3RKNmJXMUJkVldm?=
 =?utf-8?B?c2lxUGRKOWtjMUgvYU5KOHF4eXV0ZkMrUEFzbmxJYUIvb0xNSlp0M1RiOEF6?=
 =?utf-8?B?dThoUHdrT2w1QmNIdUR6Ukg5blp5N0lVN2ZRcWQyTW9wQjlzbFVROUxhS2R1?=
 =?utf-8?B?Zll5QmtBWkNhVm5ZUE9uVW8rL29EWHVlb2d0RmZBUjlBVlkwU1Uwck9OeFlW?=
 =?utf-8?B?WXFrVkR4SW1IS0VQcXhZS3BaZHhOZlBocVNCbTJaNGV6NEJhMDhRaWNzaDZ4?=
 =?utf-8?B?cFV0RXpxSDdUZ3dJdnVqUkZ6aTB0cHRvdFUyRlVycG9uM1IzL1ptOXNCdFRU?=
 =?utf-8?B?M0hoTFhKYnp4eEJoUlpCMmp2ZUw5TWFUc0xDQzY1T2g1WE1RUCtBRW9yVXhB?=
 =?utf-8?B?bXByMEsyR25LKzNnMVVua3QyZ2FWdFRqOHZSRlFjWG5KZ2FNSzlMeHh5em1E?=
 =?utf-8?B?QjNvcFFWV1hJaFlwTDhWaGpyMFJMTFpicGhBbGdlUWZaOHo1NWZFUGpxZTFC?=
 =?utf-8?B?NytlM0J5U09Vb3llMklwM3I0L0hvYnp5OE1kaDlLc0Zhd0c4NUVYL1ZNa2RP?=
 =?utf-8?B?S3FYcldZS3l5R3ZJaGNQVkFSTmx5ODF2c2YxWHZ6SktLYzdKNVRpYjBERXo0?=
 =?utf-8?B?TGxiMmxpeXpQRDFnc1hqNGhzeEFzdXlndjVGNTlSd3lYQXp4eGFodGVIUWc5?=
 =?utf-8?B?aGQxMFdBaWhFdTZyS3dMNzZSWVFPNVNQSi9NR3c0Q3pmbjc1M2J6NkZJMUNk?=
 =?utf-8?B?c3ZrQnZsaVMyRFByYkVsTC9pTmRIMWlCTEtzTGRocWtDbGxYcFRRKzdEV1FD?=
 =?utf-8?B?dFBpR2JDOVJXckhOVE0xUGd1TndyazRkNE10M0NUZ1RQcVAwME1EL3BIOXk3?=
 =?utf-8?B?Nm81TnllV080aUZsVXE1Q2RQUlZWQmJ3bGUwYzIvdGhRbkV3THBiWnJKRmpo?=
 =?utf-8?B?Y0M1dWFSVjhqSXBEdkNzdU81YmIvL1BzR2NGYXVRd3pnODB6alpVbW5Ldm9v?=
 =?utf-8?B?WFNOUEhqZ2ovT0hWaVppMEk1cnhrNGg4OEtJNisxOTA0K0dKZ3pjSVpZeVFO?=
 =?utf-8?B?UGtwYS8zYUJndXlRcmFMVW5DVnkyNXV2dHl1Y1RrRVpiNUhvalpST0V2OENJ?=
 =?utf-8?B?Q1dBd0U1SVRzNW9oNlUvTFJZbm9IOElxQTkvVzJmR2ZOdm50SDZGemp0NzRj?=
 =?utf-8?B?ZGVKdUJaenZVbXBZSkMvalo4cmg5dEhXOTlzOUtrSldBVDdMRUhuMjFpcFJW?=
 =?utf-8?B?d0xnRUFXbDlzUm9zYmVaWHlRYVFId004Vk1vbFBLejBsYlNENGhRcmtYbzNo?=
 =?utf-8?B?LzFtNUxlcXdQaWw0T3crOWtMS1pMTTlQM0FPTjdySVdVQkk0UlpWNVdKU1ZE?=
 =?utf-8?B?N3cvM1pRalFsSXRjMFZPTDJlUjVpZnA0UGdTRHN2UG5ES3E5Y3hFODA1NHM0?=
 =?utf-8?B?cWFOa2x4NGFGTWt4R3FhWU5MTkJncmdJQWZUdndCRDZzWXdLNEIrNmdKVmF0?=
 =?utf-8?B?aHpiUDM5Q2d4TE1xcG9ocm9Nd0lhQUdwc29zOVRRNkY4dTljYkt3SFRJTURR?=
 =?utf-8?B?OHltVHB1SUlCck5EbWZudS9Uc0FrYzEvaVd0a2E5YnlrRmJrb1ZadkV4Z1Ew?=
 =?utf-8?B?ZEs5R1dSSjBsYzJVRThGS1U0cjB0cCtTdkVpbnAwdy95ckF0Q3hyYURvSlJM?=
 =?utf-8?B?NnExQlU0YmJxWFZxbVpSMkpjTzNCcDFwMWh3QUtIbDBWSnNyV2NhdlJlOTdx?=
 =?utf-8?B?OEpaRDJXempxM3FOMHFIeXFJVkpOeEdsRW9jWU1VVnVLampMS2ZrT3lqTklI?=
 =?utf-8?B?RkdKSWZKaEx3cTZTMmhnZmdwMEhlT2NGRXMrMUk1RDZkRXEwcmRnZC9FVnE4?=
 =?utf-8?B?RG5RcFAzTkF2WGtORm5FUjlreExEOWdUTXNZR1JOZmZNUWxrQit6VGVKTHlE?=
 =?utf-8?B?cXVoVUdhQzZjYVBnM041V05sZm5saXBUQUVEV0w2UDZZNDRaKzgwOU5mZlE1?=
 =?utf-8?B?RlhsenEvMlJSUU5DOC9lUUU5QlpEUG44U2l3NEZOUHFNWDdWRWN0Sm1jU21J?=
 =?utf-8?B?b2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bbf45d9-3b09-4d51-a45d-08db4d996c53
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 18:49:14.8605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eZSrMRN3d+w4DA9ooITK7LRI/LIceyNGPWd3XLsUGQ21hN1kg+ODwQM5vhRcJnl55MNR09TFfaN8bvlJsdXyCPlYQJkRbihv1muF/zhiZ70=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6517
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

On 5/5/2023 10:09 AM, Moger, Babu wrote:
> [AMD Official Use Only - General]
> 
> Hi Reinette,
> 
>> -----Original Message-----
>> From: Reinette Chatre <reinette.chatre@intel.com>
>> Sent: Thursday, May 4, 2023 1:58 PM
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
>> Subject: Re: [PATCH v4 1/7] x86/resctrl: Add multiple tasks to the resctrl group
>> at once
>>
>> Hi Babu,
>>
>> On 4/17/2023 4:34 PM, Babu Moger wrote:
>>> The resctrl task assignment for MONITOR or CONTROL group needs to be
>>> done one at a time. For example:
>>
>> Why all caps for monitor and control? If the intention is to use the terms for
>> these groups then it may be easier to use the same terms as in the
>> documentation, or you could just not use all caps like you do in later patches.
> 
> Sure.
>>
>>>
>>>   $mount -t resctrl resctrl /sys/fs/resctrl/
>>>   $mkdir /sys/fs/resctrl/clos1
>>>   $echo 123 > /sys/fs/resctrl/clos1/tasks
>>>   $echo 456 > /sys/fs/resctrl/clos1/tasks
>>>   $echo 789 > /sys/fs/resctrl/clos1/tasks
>>>
>>> This is not user-friendly when dealing with hundreds of tasks.
>>>
>>> It can be improved by supporting the multiple task id assignment in
>>> one command with the tasks separated by commas. For example:
>>
>> Please use imperative mood (see Documentation/process/maintainer-tip.rst).
>>
>> Something like:
>> "Improve multiple task id assignment ...."
> 
> How about:
> "Improve the assignment by supporting multiple task id assignment in
> one command with the tasks separated by commas."

The double use of 'assignment' can be confusing. This is also a
changelog where a clear context->problem->solution format can help.
If your changelog is clear regarding the context and problem then it
can end with brief solution description like:

"Support multiple task assignment in one command with tasks ids separated
by commas. For example: " (and also please use a non-x86 term for the group
name in your example)

>>>   $echo 123,456,789 > /sys/fs/resctrl/clos1/tasks
>>>

...

>>> +	pid will be logged in /sys/fs/resctrl/info/last_cmd_status file.
>>
>> Would it not always print the failing pid (if error was encountered while
> 
> Not always. In this case it does not print the pid,
> rdt_last_cmd_puts("Can't move task to different control group\n");
>                         return -EINVAL;
> 

What you quote above adds the relevant text to the last_cmd_status buffer ...
and later (see below) more text is added to the buffer that contains the
pid, no?

...

>>>  	struct rdtgroup *rdtgrp;
>>> +	char *pid_str;
>>>  	int ret = 0;
>>>  	pid_t pid;
>>>
>>> -	if (kstrtoint(strstrip(buf), 0, &pid) || pid < 0)
>>> +	if (nbytes == 0)
>>>  		return -EINVAL;
>>> +
>>> +	buf[nbytes - 1] = '\0';
>>> +
>>
>> This seems like another remnant of the schemata write code that expects that
>> the buffer ends with a '\n'. Since this code does not have this requirement the
>> above may have unintended consequences if a tool provides a buffer that does
>> not end with '\n'.
>> I think you just want to ensure that the buffer is properly terminated and from
>> what I understand when looking at kernfs_fop_write_iter() this is already taken
>> care of.
> 
> Sure. Will check. Then I will have to change the check below to if (!buf).

Please check what kernfs_fop_write_iter() does. From what I can tell it does
exactly what you are trying to do above, but without overwriting
part of the string that user space provides.
I thus do not think that the later check needs to change. From what I understand
it is used to handle the scenario if user space provides a string like "pid,"
(last character is the separator). Please do confirm that the code can handle
any variations that user space may throw at it.

>>> @@ -716,6 +739,12 @@ static ssize_t rdtgroup_tasks_write(struct
>> kernfs_open_file *of,
>>>  	}
>>>
>>>  	ret = rdtgroup_move_task(pid, rdtgrp, of);
>>> +	if (ret) {
>>> +		rdt_last_cmd_printf("Error while processing task %d\n", pid);

Note here the pid is added to the buffer that is printed when user space
views last_cmd_status. I think this is the first time two lines of error may
be added to the buffer so you could double check all works as expected.

Reinette
