Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 779A06A9FDD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 20:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbjCCTGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 14:06:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbjCCTGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 14:06:10 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE799193DC
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 11:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677870369; x=1709406369;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mBI2BOatJPzQVWX3ZSIX9DGQMneS20CzXSNPt0nc+6M=;
  b=aQBoV/x7CB5UF1U+u/9LG6lEdWEIZXFNNLbhtLG2igRA1sIyt1CP52EI
   yvTxRw1tRPDXRMtSlXMM3FB66KEdqR1z/xUFPFiJ8E1wmCGgNCXNyn1/G
   /2Sjz0vwYSVPEUQej8BYsUbwYuZvHArx35E7TqfFypNeL2Ic2Wdip+Ua+
   Snzb9WNYL8S0iHNRmQCkGZuBvfsnEHM5oTWQGc3hm+9xPSrxNIHUHByT+
   a3WRZ21JHdZCxEsynMQPdDX1sHMV4sL9Qm6/3sECMOypi3IwAlN2U4nix
   J1aCFs1worjzSu8g8ol0/exxyz2kHvTuXGf4lBqGZPSwWUm6BtXIsTVzg
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="335156656"
X-IronPort-AV: E=Sophos;i="5.98,231,1673942400"; 
   d="scan'208";a="335156656"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2023 11:05:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="739611706"
X-IronPort-AV: E=Sophos;i="5.98,231,1673942400"; 
   d="scan'208";a="739611706"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP; 03 Mar 2023 11:05:52 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 3 Mar 2023 11:05:52 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 3 Mar 2023 11:05:51 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 3 Mar 2023 11:05:51 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Fri, 3 Mar 2023 11:05:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q/ws9L7+GKU5TrrR4X69C1Nk7s12UwWTN1mjvz2fGiEuMEn3RMZq7AS/TWlShfmjxEqnkMzTfbOgJYiTQ3h/NVVZwCz4Xkq1gRLOG9Mq+dDNMfQMMyzAnL16CQTNuc8Z0JjvHkGdXkJCP21rrMj22KDLg/+19cnrxhZPR06eL1d10BwnvstObKhf2yjrEiOKPUdZ8yGa6gc8oJqImJ3WxcBxoGkttaPP0QG9plgyBFNBlaylUy2GkgYD84WA0TrSGo8vEcsY+OB7h7K99ieFqgwTu2FnlKNSoCKSQIoGB2kEccaLki327HGlAqeqtrlOgYfwWM0o+OFq7E0jRtHsRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7EZ2rz3sV0QbKdwjgjGGlnNCUR3JKlRqryfDS3lbc3s=;
 b=Xb8k8pphi+y7wtG+ouO2Y6mjXO7Xfgyg7s2QqKToRsyAswI+YA7+ZHGSq6RJU6aMyVuACnKDwpMz4uydVzik89yfsE7ooeBVxbTsK5BE5U5g1Ae1asS6qELcFkxpRby0jI2opTMAR7SlEqtyKVYpgxG6Lnumz9SEh3MgdoQDtW/htM6KrcORNFzD/JDtmeph+/fOKZDDAfvnjNmLYZR23ijCTbke8Yq3ciNadnykiPgrMHZDfYVUC6W8E+QaONw6At52GKL4uWDwp6FBzvHt58Oum0CdzY718VRtIwIVdy4lRKB/TYCMMVrFQu7luDi+ICSP1bXs2MfsYc2+p5D9og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by SN7PR11MB7538.namprd11.prod.outlook.com (2603:10b6:806:32b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19; Fri, 3 Mar
 2023 19:05:49 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f%12]) with mapi id 15.20.6156.022; Fri, 3 Mar 2023
 19:05:49 +0000
Message-ID: <8f2b606c-945b-1c26-9bc5-29f5b89227f7@intel.com>
Date:   Fri, 3 Mar 2023 11:05:45 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.2
Subject: Re: [PATCH v3 3/3] x86/resctrl: Implement rename op for mon groups
Content-Language: en-US
To:     Peter Newman <peternewman@google.com>
CC:     <fenghua.yu@intel.com>, <Babu.Moger@amd.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <eranian@google.com>,
        <gupasani@google.com>, <hpa@zytor.com>, <james.morse@arm.com>,
        <linux-kernel@vger.kernel.org>, <mingo@redhat.com>,
        <skodak@google.com>, <tony.luck@intel.com>, <tglx@linutronix.de>,
        <x86@kernel.org>
References: <20230125101334.1069060-1-peternewman@google.com>
 <20230125101334.1069060-4-peternewman@google.com>
 <b14598a8-2ab1-eda2-e1fb-a5f568e869d5@intel.com>
 <CALPaoCgnP0zU4fkDxst9pyY1FrxW2zT-VfMTnJbj_iytQxknjQ@mail.gmail.com>
 <2f0abf41-87ba-0eee-03d9-ec3e5062d595@intel.com>
 <CALPaoCgZuHxfH-OEiXsCn0cxmUQygwCH5HOT0ka5OmxMX96Y8g@mail.gmail.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <CALPaoCgZuHxfH-OEiXsCn0cxmUQygwCH5HOT0ka5OmxMX96Y8g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR05CA0086.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::27) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|SN7PR11MB7538:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f7aa069-28f7-42d7-df51-08db1c1a4ce1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vgC3f8u7Zfc80FqL7izoI3MMGOZTDskLxnGz8819r2wEc0sOhQBB+/s+ahFYvCWPTFuSltRTBK9i+/bxrT4Un6vmjMIie4pSJwKrdcrs/GIljNiJPrOiRdJb3pz5rX8hN4w+j3+J8bDFuR4nc4C+T4cUzpYsmJo3aYinDUXE1LVsiGYX2emlxQ+3Bpz+MOpHXUEEH4BQBkDXdaRNzSCFuh7OmVZfsa1PtgSqUxsaGU7uKeigHZb7+/rzf7Af9dqf+a7GJZVi++PurDjC4bJzzKJ0aVw4ZR6adeXOzwVOJ1WuBFvuGczdl1iT+MvTVOcWGh2Jj2Oc2CzGGzPz1tYLdxbO1/NM4r7r180IB9B6ATnyDnjVPDlX6+7QFTDITRn+gFXU4Wd0r+ts3h8eqd2ualgQR4tuDRgv3jR70gcF74aggpHpz8gfuP3Aslg+Cz3JA1xvYLtcDXbQEP9AmGYIu5MvQslT8JjhCgKgoYd5Dw2SW01yApDUNxb3QCR2AK++FufBhlPEwC959kirNIEmrMRaoib0coMtZV17kQ1QVS1PRVc7tzwGHd+/nMnAU1cesdj+uHJ5tA+S/PcM/1k0UFjZrrkAgN/rjzcNpq7FQHMLzRy5mD0krjK8v7lHxDTHh2onKroYvDGzKQp0MIiRFaq++ZCDJu+5LwWHSwXSGB8G84lXf1XJEWvQVJDhu93Xk/GpZ95crzBnTW4B3MPhJf8iToU5TXwSoqKPRUdydYk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(376002)(396003)(136003)(39850400004)(346002)(451199018)(31686004)(2616005)(36756003)(8936002)(8676002)(6512007)(41300700001)(53546011)(66476007)(66946007)(6916009)(186003)(86362001)(31696002)(66556008)(7416002)(2906002)(44832011)(4326008)(83380400001)(6666004)(6506007)(478600001)(6486002)(316002)(5660300002)(26005)(38100700002)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WktFQTRCa1NINHhpQ2NJaFZzWGkvby9ZbUVHN0luaS8wMzhoUStCOUUyUU1L?=
 =?utf-8?B?bHp4ZHF3QXpycG1ERUtTb0MrTDh6YTVrbXV3MmtWNnZZRkdtb3JoSDEwNGJp?=
 =?utf-8?B?QUIrYzd4bjZTWDRXekdzTUJQbTlndFEvV2VHS2ovWnZVTDV5cGwzOXZkdVEx?=
 =?utf-8?B?Wkt2UTdqdThLOENnVDIyaTlDVTRFNE00VnJyaTIya0o0aWNPUkFwbzdwU0lL?=
 =?utf-8?B?amtXQW9wVjNueTNwT2l0YjRzSlpxVXVjV2xzYTFLNGVQUUtWWG1mYVJFM2Yy?=
 =?utf-8?B?TS8wcDhtNERpZDVXUE0vUXYzQysxUkxMeVQrdXQrK1BNMEJRTEtVUHRrUm93?=
 =?utf-8?B?bTl1dEYrRW01dzRPRFkwU3M0TXYyVVhHd3JCSDhlVHBiR0RhRm1LWjhYSGlW?=
 =?utf-8?B?OWxaM05HSVkyNHVWb3ZqUGgxdFNYUWxiM1hCOXp4NE4ydVRRUXRqZ2F0TUZM?=
 =?utf-8?B?L2lZUGZMVGxkMVkwU2dPR2J6TUpmMkx1cUszYVF3bFZoMUxkREFZYnFYMktT?=
 =?utf-8?B?NGcyMncrd1Q1KzJlNm1hWTlNM3FMcXA3UUwzOEZhVndlNW1xbnVGbE9EelpE?=
 =?utf-8?B?dW56Wko4Zk9OTmxob2ZvYlBJU3J0cVVGeU5uYVFBbURkNGkzempoTkpoaURx?=
 =?utf-8?B?TXhmZTNLRFkwalNNUUcwMG5ZaFJGdDZsOUpwdElDWGxwdXlRUE1mMlNsbVh4?=
 =?utf-8?B?TllZdUJTNFBKUmxRNnI0clpOR3JUV3ZNaEVuWmUyZEcyeWpkV2t6ZnZkOHZa?=
 =?utf-8?B?NjYxN1h2MHJZL2dHZzZYMldtOXViZWVTS09EWjAzSWY1T21MOFpCK1VzYWsr?=
 =?utf-8?B?ekJRV2J2TDEvZ25nM3gveDhWd05hcUF0RXUyQm9UMGg5NFhNQmI1SDF1alpl?=
 =?utf-8?B?UTVhRGRkRHAxbXpyMmJqcVBTWFdSV0IrOGFRdlpjZlEzVU1WRW05Vno2Y1pB?=
 =?utf-8?B?R1AvN05MTFNwSEI3OWFPSW9HK2ZFeHBGc1pPZnZpM05vVkVWbjM2Z2hWQ29v?=
 =?utf-8?B?Nlpmc3NVaHJoUXdLeUlHWkFPYUtJdFJYeUx4eGVzOHc2OFBMTmswNDR0bkVo?=
 =?utf-8?B?cVBNTWhjZ3FFczFwbGxDemZmK3ozaWVNQlFoSG8wcE1KZCtsRGV3TEM3MG00?=
 =?utf-8?B?US80NTdvZWk1SFRIZ0tYcEJLVEVYZThVRmd0RExwVHZRY2trRVVIOVNkb0hE?=
 =?utf-8?B?WTAvdzBsWmpMNXVLMEZqOVZEV1lNZGs5cWFvd1ErMUo4V2ZZYXM5Y3JtOUJL?=
 =?utf-8?B?Vy93ckVxUml1U2wrS2MxK3J6SUhkMGJhYi8wSDk3Rkg3cm04cGs3RzN4MjRL?=
 =?utf-8?B?VFd4ZHVXWUtVL3F5TEpXcmVLMndtdUVVbE5mdTdsWDVqNGlFZ0tMM1pKZVdq?=
 =?utf-8?B?Y3RtcjhvYVFnK0FWRHAySlZ3LzlYaFY4S3ZnMytVUExrdWlZMEJOUTJHNFFn?=
 =?utf-8?B?SkN4c05NR3dMTjVyL2ZhK1NCNVpHTVJhMHlONVl5emNVdjl1bkxtbHZhTytl?=
 =?utf-8?B?ejY3VCtKakRrQ2FCaGRGdjJLb3dCYzNQZ2NQT2xoendPcmsyd2JwaWV4WERa?=
 =?utf-8?B?OTQ0T0hSV0ZNaEpTNFdDdXdJcVF4anNsUnNhbUpHczBmM0Y0aERRRGJvb1NE?=
 =?utf-8?B?NDUxTVpzOStuOFFldEM0djlTREYvMjl1K1E1M1crL1poK1JFVi9acTJuaEsy?=
 =?utf-8?B?eFRHS1c1dnNtZFJMYkcrSnE5S2lWV1poc3NUSEVpRSs1VHJoM3JwVCtUM3Vp?=
 =?utf-8?B?ZjJ3QTZOSHc5akZQbCsreklvOVVhcHU1a0F5bGF1azdxVktHMjY4STlKWjVE?=
 =?utf-8?B?OHVjZUJYVlljdjlGYzYzMFp5eXBaU2hnd3VjOG1zcXZ2SEhwR2JlYU1rbnF2?=
 =?utf-8?B?QkFrU3Y4blJBV2lEOGQ1ZUxyUWQ3VnZpdllUSUp6RkwwcTBZWjRLWTZ5by9P?=
 =?utf-8?B?ZVBpQWNIMlcwS01pM1RNZ1czaFlYK2dOdE9FTWVxTEVxdHhjZm0zUm9RTW14?=
 =?utf-8?B?V25QUktRZkdnN01vaVpnSzRKZ1pxOFhkMk16VXFscVJUNlZhZlRrNmU3R3lY?=
 =?utf-8?B?TzNQV003S21Gc1pDRXh2T2xkWGZCcElmaGxmcm9sejdsWXF6VG11ZzQ0aWRW?=
 =?utf-8?B?dWFhWjdFTWZIbDVmalN6S29wOWxYeVZacVRDazRRSTZ3aExmbnYvQ2F4Zlov?=
 =?utf-8?B?c2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f7aa069-28f7-42d7-df51-08db1c1a4ce1
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 19:05:49.0311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8QJ61vAGJIGkjEWMQw0UetiqF7pUApck3MEUuZaG3H9d7IrXs4gxl4r9Y2JornhZKq0UP7Y8MbhgKqiy3BMDvCVA6kyGfmwQNHpKbYkhF00=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7538
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 3/3/2023 7:10 AM, Peter Newman wrote:
> On Thu, Mar 2, 2023 at 11:27 PM Reinette Chatre
> <reinette.chatre@intel.com> wrote:
>> On 3/2/2023 6:26 AM, Peter Newman wrote:
>>> On Sat, Feb 11, 2023 at 12:21 AM Reinette Chatre
>>> <reinette.chatre@intel.com> wrote:
>>>
>>>> On 1/25/2023 2:13 AM, Peter Newman wrote:
>>>>> +     for_each_process_thread(p, t) {
>>>>> +             if (is_closid_match(t, prdtgrp) && is_rmid_match(t, rdtgrp))
>>>>> +                     rdt_move_one_task(t, new_prdtgrp->closid, t->rmid,
>>>>> +                                       cpus);
>>>>> +     }
>>>>> +     read_unlock(&tasklist_lock);
>>>>
>>>> Can rdt_move_group_tasks() be used here?
>>>
>>> As it is today, rdt_move_group_tasks() would move too many tasks.
>>> mongrp_move() needs both the CLOSID and RMID to match, while
>>> rdt_move_group_tasks() only needs 0-1 of the two to match.
>>>
>>> I tried adding more parameters to rdt_move_group_tasks() to change the
>>> move condition, but I couldn't make the resulting code not look gross
>>> and after factoring the tricky stuff into rdt_move_one_task(),
>>> rdt_move_group_tasks() didn't look interesting enough to reuse.
>>
>> Could it be made readable by adding a compare function as parameter to
>> rdt_move_group_tasks() that is used to determine if a task should be moved?
> 
> Yes, I think that would be ok in this case. That shouldn't have any
> cost if these are all static functions.
> 
> As long as we have an rdt_move_group_tasks() function, it's a liability
> to have a separate task-moving loop for someone to miss in the future.

Agreed.
 
> Should I still bother with factoring out rdt_move_one_task() in the
> parent patch? It was motivated by my creating a new task-moving loop
> in this patch.

I do not think that refactoring is necessary if you go this route.
 
>>>>> +
>>>>> +     rdtgrp = kernfs_to_rdtgroup(kn);
>>>>> +     new_prdtgrp = kernfs_to_rdtgroup(new_parent);
>>>>> +     if (!rdtgrp || !new_prdtgrp) {
>>>>> +             free_cpumask_var(tmpmask);
>>>>> +             return -EPERM;
>>>>> +     }
>>>>> +
>>>>
>>>> How robust is this against user space attempting to move files?
>>>
>>> I'm not sure I understand the question. Can you be more specific?
>>
>> This commit adds support for rename to resctrl. I thus expect this
>> function to be called when user space attempts to move _any_ of
>> the files and/or directories within resctrl. This could be out of
>> curiosity, buggy, or maliciousness. I would like to understand how
>> robust this code would be against such attempts because I do not see
>> much checking before the preparation to do the move is started.
> 
> Now I see, thanks.
> 
> kernfs_to_rdtgroup() will return the parent rdtgroup when
> kn or new_parent is a file, which will lead to kernfs_rename() moving
> a file out of a group or clobbering another file node. I'll need to
> enforce that kn and new_parent are rdtgroup directories and not file
> nodes.

Perhaps additionally that the source directories have mon_groups as parent,
similar to the destination check you already have.

Reinette
